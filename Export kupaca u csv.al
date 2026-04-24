report 50226 "Export kupaca u csv"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export kupaca u csv';
    ShowPrintStatus = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(MjernoMjesto; "Service Item")
        {
            RequestFilterFields = "Customer No.";
            column(SifraMjernogMjesta; "No.") { }
            column(SifraKupca; "Customer No.") { }

            trigger OnPreDataItem()
            begin
                SetRange("Status MM", "Status Cust/MM"::Active); // Dohvati samo aktivna mjerna mjesta!
            end;

            trigger OnAfterGetRecord()
            var
                Kupac: Record "Customer";
                KupacNo: Text;
                KupacNaziv: Text;
                KupacNaziv2: Text;
                KupacAdresa: Text;
                KupacBrUlice: Text;
                KupacBrUliceTxt: Text;
                SifraMjernogMjesta: Text;
                Mjerac: Record Gauge;
                MjeracSerijskiBroj: Text;
                CJL: Record "Calculation Journal Line";
                CJLStanjeMjeraca: Text;
                AnalitikaKupca: Record "Cust. Ledger Entry";
                TrenutniSaldoBroj: Decimal;
                TrenutniSaldo: Text;
                ZadnjaUplataDatum: Text;
                ZadnjaUplataIznos: Text;
                ZadnjaUplataIznosBroj: Decimal;
                ZadnjaFakturaDatum: Text;
                ZadnjaFakturaIznos: Text;
                ZadnjaFakturaIznosBroj: Decimal;
                ZadnjaUplata: Boolean;
                ZadnjaFaktura: Boolean;
            begin
                // Dohvat podataka o kupcu
                Kupac.Reset();
                Kupac.SetRange("No.", MjernoMjesto."Customer No.");

                if Kupac.FindFirst() then begin
                    KupacNo := Format(Kupac."No.");
                    KupacNaziv := Format(Kupac."Name");
                    KupacNaziv2 := Format(Kupac."Name 2");
                    if KupacNaziv2 <> '' then KupacNaziv := KupacNaziv + ' ' + KupacNaziv2;
                    Kupac.CalcFields("Street Name Customer");
                    KupacAdresa := Format(Kupac."Street Name Customer");
                    KupacBrUlice := Format(Kupac."Street No.");
                    if KupacBrUlice <> '' then KupacAdresa := KupacAdresa + ' ' + KupacBrUlice;
                    KupacBrUliceTxt := Format(Kupac."Street No. Text");
                    if KupacBrUliceTxt <> '' then KupacAdresa := KupacAdresa + ' ' + KupacBrUliceTxt;
                end;

                // Dohvat mjernog mjesta
                SifraMjernogMjesta := MjernoMjesto."No.";

                // Dohvat stanja mjerača, kao i samog mjerača iz žurnal tabele!
                CJL.Reset();
                CJL.SetCurrentKey("Reading Date To");
                CJL.SetFilter("Customer No.", KupacNo);
                CJL.SetFilter("Measuring Point Code", SifraMjernogMjesta);
                CJL.SetFilter("Reading Date To", '<=%1', NaDan);
                CJL.SetFilter("New Value", '<>%1', 0);
                CJL.SetRange("Locked", true);
                CJL.Ascending(false);

                if CJL.FindFirst() then begin
                    // Dohvat serijskog broja mjerača, ne po direktnoj vezi sa mjernim mjestom, već po žurnal tabeli, koja čuva istoriju promjena mjerača!
                    Mjerac.Reset();
                    Mjerac.SetRange("Code", CJL."Gauge");

                    if Mjerac.FindFirst() then
                        MjeracSerijskiBroj := Mjerac."Inventar number"
                    else
                        MjeracSerijskiBroj := '';

                    CJLStanjeMjeraca := Format(CJL."New Value");
                end
                else begin
                    MjeracSerijskiBroj := '';
                    CJLStanjeMjeraca := '0';
                end;

                // Dohvat trenutnog salda, zadnje uplate i zadnje fakture
                TrenutniSaldoBroj := 0;
                ZadnjaUplata := false;
                ZadnjaFaktura := false;
                ZadnjaUplataDatum := '';
                ZadnjaUplataIznos := '0.00';
                ZadnjaFakturaDatum := '';
                ZadnjaFakturaIznos := '0.00';
                AnalitikaKupca.Reset();
                AnalitikaKupca.SetRange("Customer No.", KupacNo);
                AnalitikaKupca.SetFilter("Posting Date", '<=%1', NaDan);
                AnalitikaKupca.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '1', '01', '2', '02', '3', '03');
                AnalitikaKupca.SetCurrentKey("Posting Date");
                AnalitikaKupca.Ascending(false);

                // CalcSum() je obarao servis, pa sam bio primoran da idem red-po-red uz upotrebu CalcFields()
                if AnalitikaKupca.FindSet() then
                    repeat
                        AnalitikaKupca.CalcFields("Amount (LCY)");
                        TrenutniSaldoBroj := TrenutniSaldoBroj + AnalitikaKupca."Amount (LCY)";

                        // Ukoliko naiđemo na uplatu, označi je kao zadnju uplatu i nemoj više ulaziti ovdje
                        if (AnalitikaKupca."Document Type" = AnalitikaKupca."Document Type"::Payment) and not (ZadnjaUplata) then begin
                            ZadnjaUplata := true;
                            ZadnjaUplataDatum := Format(AnalitikaKupca."Posting Date");
                            ZadnjaUplataIznosBroj := AnalitikaKupca."Amount (LCY)";

                            if ZadnjaUplataIznosBroj < 0 then
                                ZadnjaUplataIznos := Format(ZadnjaUplataIznosBroj * -1, 0, '<Precision,2:2><Standard Format,2>')
                            else
                                ZadnjaUplataIznos := Format(ZadnjaUplataIznosBroj, 0, '<Precision,2:2><Standard Format,2>');
                        end;

                        // Ukoliko naiđemo na fakturu, označi je kao zadnju fakturu i nemoj više ulaziti ovdje
                        if (AnalitikaKupca."Document Type" = AnalitikaKupca."Document Type"::Invoice) and not (ZadnjaFaktura) then begin
                            ZadnjaFaktura := true;
                            ZadnjaFakturaDatum := Format(AnalitikaKupca."Posting Date");
                            ZadnjaFakturaIznosBroj := AnalitikaKupca."Amount (LCY)";

                            if ZadnjaFakturaIznosBroj < 0 then
                                ZadnjaFakturaIznos := Format(ZadnjaFakturaIznosBroj * -1, 0, '<Precision,2:2><Standard Format,2>')
                            else
                                ZadnjaFakturaIznos := Format(ZadnjaFakturaIznosBroj, 0, '<Precision,2:2><Standard Format,2>');
                        end;
                    until AnalitikaKupca.Next() = 0;

                TrenutniSaldo := Format(TrenutniSaldoBroj, 0, '<Precision,2:2><Standard Format,2>');

                // Ispis rezultata u "fajl"!
                OutStreamObj.WriteText(KupacNaziv + Delimiter +
                                       KupacAdresa + Delimiter +
                                       KupacNo + Delimiter +
                                       SifraMjernogMjesta + Delimiter +
                                       MjeracSerijskiBroj + Delimiter +
                                       CJLStanjeMjeraca + Delimiter +
                                       TrenutniSaldo + Delimiter +
                                       ZadnjaUplataDatum + Delimiter +
                                       ZadnjaUplataIznos + Delimiter +
                                       ZadnjaFakturaDatum + Delimiter +
                                       ZadnjaFakturaIznos + Delimiter
                                      );
                OutStreamObj.WriteText();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CSVDelimiter; Delimiter)
                    {
                        ApplicationArea = All;
                        Caption = 'CSV Delimiter';
                    }
                    field(NaDan; NaDan)
                    {
                        ApplicationArea = All;
                        Caption = 'Na dan';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }

        trigger OnInit()
        begin
            Delimiter := ';';
            NaDan := TODAY;
        end;
    }

    trigger OnPreReport()
    begin
        TempBlob.CreateOutStream(OutStreamObj, TextEncoding::UTF8);
        OutStreamObj.WriteText('Naziv kupca' + Delimiter +
                               'Adresa kupca' + Delimiter +
                               'Šifra kupca' + Delimiter +
                               'Šifra mjernog mjesta' + Delimiter +
                               'Mjerač broj' + Delimiter +
                               'Stanje mjerača' + Delimiter +
                               'Trenutni saldo' + Delimiter +
                               'Datum zadnje uplate' + Delimiter +
                               'Zadnja uplata' + Delimiter +
                               'Datum zadnjeg računa' + Delimiter +
                               'Zadnji račun iznos' + Delimiter);
        OutStreamObj.WriteText();
    end;

    trigger OnPostReport()
    var
        InStreamObj: InStream;
        FileName: Text;
    begin
        FileName := 'Kupci.csv';
        TempBlob.CreateInStream(InStreamObj, TextEncoding::UTF8);
        DownloadFromStream(InStreamObj, '', '', '', FileName);
    end;

    var
        Delimiter: Text;
        NaDan: Date;
        TempBlob: Codeunit "Temp Blob";
        OutStreamObj: OutStream;
}