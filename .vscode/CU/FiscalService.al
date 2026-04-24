codeunit 50026 FiscalPrinterService
{
    trigger OnRun()
    var
        GenL: Record "General Ledger Setup";
        CZkf: Record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin
        GenL.geT;
        Putanja := GenL."Path for fiscal printer";
        Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
        CZkF.Get(UserId);
        BankAccocunt.Reset();
        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
        if BankAccocunt.findfirst then begin
            Putanja := BankAccocunt."Path for fiscal printer";
            Putanja2 := BankAccocunt."Path for fiscal printer" + 'odgovori\';
        end
        else begin
            Putanja := GenL."Path for fiscal printer";
            Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
        end;

        TXTTab := 13;
        TXTTab := 13;
        IF ReklamniDA = FALSE THEN BEGIN
            ServiceHeader.RESET;
            ServiceHeader.SETFILTER("No.", '%1', UlazniRacun);
            IF ServiceHeader.FINDFIRST THEN BEGIN
                IF ServiceHeader."Fiscal No. Printed" = FALSE THEN BEGIN
                    File1.CREATE(Putanja + 'Stampatifiskalniracun.000', TEXTENCODING::UTF8);

                    File1.CREATEOUTSTREAM(OutStreamObj);
                    plite := '<?xml version="1.0" encoding="utf-8"?>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<BrojZahtjeva>233</BrojZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '<VrstaZahtjeva>0</VrstaZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<NoviObjekat>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '<Kupac>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    Custt.RESET;
                    Custt.SETFILTER("No.", '%1', ServiceHeader."Bill-to Customer No.");
                    IF Custt.FINDFIRST THEN
                        plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();


                    //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                    plite := '<Naziv>' + ServiceHeader."Bill-to Name" + '</Naziv>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                    plite := '<Adresa>' + ServiceHeader."Bill-to Address" + '</Adresa>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    //<PostanskiBroj>75320</PostanskiBroj>

                    plite := '<PostanskiBroj>' + ServiceHeader."Bill-to Post Code" + '</PostanskiBroj>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    //<Grad>Gračanica</Grad>
                    plite := '<Grad>' + ServiceHeader."Bill-to City" + '</Grad>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '</Kupac>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    //</Kupac>



                    plite := '<StavkeRacuna>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<RacunStavka>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    ServiceInvoiceLine.RESET;
                    ServiceInvoiceLine.SETFILTER("Document No.", '%1', UlazniRacun);
                    ServiceInvoiceLine.SETFILTER("No.", '<>%1', '');
                    IF ServiceInvoiceLine.FINDFIRST THEN BEGIN
                        plite := '<artikal>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Sifra>' + FORMAT(ServiceInvoiceLine."No.") + '</Sifra>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Naziv>' + FORMAT('Iznos po fakturi ' + ServiceInvoiceLine."Document No.") + '</Naziv>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<JM>' + 'KO' + '</JM>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        TotalCijena := 0;
                        Salles.RESET;
                        Salles.RESET;
                        Salles.SETFILTER("Document No.", '%1', UlazniRacun);
                        Salles.SETFILTER("No.", '<>%1', '');
                        IF Salles.FINDSET THEN
                            REPEAT
                                IF ServiceHeader."Currency Factor" <> 0 THEN
                                    TotalCijena := TotalCijena + Salles."Amount Including VAT" / ServiceHeader."Currency Factor"
                                ELSE
                                    TotalCijena := TotalCijena + Salles."Amount Including VAT";
                            UNTIL Salles.NEXT = 0;
                        TotalCijena := round(TotalCijena, 0.01, '=');
                        ImaZarez := STRPOS(FORMAT(TotalCijena), ',') + 1;

                        IF STRPOS(FORMAT(COPYSTR(FORMAT(TotalCijena), ImaZarez, 2)), '00') = 0 THEN
                            Rezultat := ChangeSeparator(FORMAT(TotalCijena, 0, '<Sign><Integer><Decimals><Comma,.>'))
                        ELSE
                            Rezultat := ChangeSeparator(FORMAT(ROUND(TotalCijena), 0, '<Precision,2:2><Standard Format,2>'));
                        plite := '<Cijena>' + Rezultat + '</Cijena>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        IF ServiceInvoiceLine.Amount - ServiceInvoiceLine."Amount Including VAT" < 0 THEN
                            plite := '<Stopa>E</Stopa>'
                        ELSE
                            plite := '<Stopa>K</Stopa>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Grupa>0</Grupa>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<PLU>0</PLU>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '</artikal>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Kolicina>' + '1' + '</Kolicina>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        ImaZarez := STRPOS(FORMAT(ServiceInvoiceLine."Line Discount %"), ',') + 1;

                        IF STRPOS(FORMAT(COPYSTR(FORMAT(ServiceInvoiceLine."Line Discount %"), ImaZarez, 2)), '00') = 0 THEN
                            Rezultat := ChangeSeparator(FORMAT(ServiceInvoiceLine."Line Discount %", 0, '<Sign><Integer><Decimals><Comma,.>'))
                        ELSE
                            Rezultat := ChangeSeparator(FORMAT(ROUND(ServiceInvoiceLine."Line Discount %"), 0, '<Precision,2:2><Standard Format,2>'));



                        plite := '<Rabat>0</Rabat>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();



                    end;
                    plite := '</RacunStavka>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</StavkeRacuna>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<VrstePlacanja>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<VrstaPlacanja>';


                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Oznaka>Virman</Oznaka>';

                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Iznos>' + '0' + '</Iznos>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();


                    plite := '</VrstaPlacanja>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</VrstePlacanja>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</NoviObjekat>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</RacunZahtjev>';

                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    File1.CLOSE;
                    IF ServiceHeader."Fiscal No. printed" = FALSE THEN
                        FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracun.000', Putanja + 'Stampatifiskalniracun.000');
                    SLEEP(30000);

                    Commit();
                    IF ServiceHeader."Fiscal No. printed" = FALSE THEN BEGIN
                        // Odgovor(Putanja2 + 'sfr');
                        CZkF.Get(UserId);
                        BankAccocunt.Reset();
                        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                        if BankAccocunt.findfirst then begin
                            BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series FIscal No.", TODAY, true);

                        end;

                        ServiceHeader."Fiscal No." := BrojFiskalnogRacuna;
                        //UserSetup.GET(USERID);
                        //FiscalPrinterSetup.GET(UserSetup."Fiscal Printer Code");

                        ServiceHeader."Fiscal No. printed" := TRUE;
                        ServiceHeader."Fiscal DateTime" := CURRENTDATETIME;
                        ServiceHeader."Fiscal User" := USERID;
                        ServiceHeader.MODIFY;
                        Commit();

                    END;
                END
                ELSE BEGIN

                    File1.CREATE(Putanja + 'stampatiduplikatfiskalnogracuna.xml', TEXTENCODING::UTF8);
                    //File1.CREATE('\\FORTNAV\Temp\Stampatifiskalniracun.000',TEXTENCODING::UTF8);

                    File1.CREATEOUTSTREAM(OutStreamObj);
                    plite := '';

                    plite := '<?xml version="1.0" encoding="utf-8"?>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<BrojZahtjeva>607356</BrojZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<VrstaZahtjeva>3</VrstaZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Parametri>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Parametar>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Naziv>BrojRacuna</Naziv>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Vrijednost>' + ServiceHeader."Fiscal No." + '</Vrijednost>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</Parametar>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</Parametri>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</Zahtjev>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    File1.CLOSE;
                    FileManagement.DownloadToFile(Putanja + 'stampatiduplikatfiskalnogracuna.xml', Putanja + 'stampatiduplikatfiskalnogracuna.xml');
                    Sleep(2000);
                END;
            END;

        END
        ELSE BEGIN

            TXTTab := 13;


            ServiceCrMemoHeader.RESET;
            ServiceCrMemoHeader.SETFILTER("No.", '%1', UlazniRacun);
            // ServiceCrMemoHeader.SETFILTER("Fiscal No.",'<>%1','');
            IF ServiceCrMemoHeader.FINDFIRST THEN BEGIN
                IF ServiceCrMemoHeader."Fiscal No. Printed" = FALSE THEN BEGIN
                    //E ako ima PDV, K ako nema


                    ServiceCrMemoLine.RESET;
                    ServiceCrMemoLine.SETFILTER("Document No.", '%1', UlazniRacun);
                    ServiceCrMemoLine.SETFILTER("No.", '<>%1', '');
                    IF ServiceCrMemoLine.FINDFIRST THEN BEGIN
                        ServiceCrMemoLine.CALCSUMS("Amount Including VAT");
                        Iznoss := ServiceCrMemoLine."Amount Including VAT";
                    END
                    ELSE BEGIN
                        Iznoss := 0;
                    END;
                    IF ServiceCrMemoHeader."Currency Factor" <> 0 THEN
                        Iznoss := Iznoss / ServiceCrMemoHeader."Currency Factor";
                    File5.CREATE(Putanja + 'unosnovca.xml', TEXTENCODING::UTF8);
                    File5.CREATEOUTSTREAM(OutStreamObj2);
                    Linije := '<?xml version="1.0" encoding="utf-8"?>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '<BrojZahtjeva>0</BrojZahtjeva>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '<VrstaZahtjeva>7</VrstaZahtjeva>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '<NoviObjekat>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '<Oznaka>Gotovina</Oznaka>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    ImaZarez := STRPOS(FORMAT(Rezultat), ',') + 1;

                    IF STRPOS(FORMAT(COPYSTR(FORMAT(Iznoss), ImaZarez, 2)), '00') = 0 THEN
                        Rezultat := ChangeSeparator(FORMAT(Iznoss, 0, '<Sign><Integer><Decimals><Comma,.>'))
                    ELSE
                        Rezultat := ChangeSeparator(FORMAT(ROUND(Iznoss), 0, '<Precision,2:2><Standard Format,2>'));
                    Linije := '<Iznos>' + FORMAT(Rezultat) + '</Iznos>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '</NoviObjekat>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();
                    Linije := '</RacunZahtjev>';
                    OutStreamObj2.WRITETEXT(Linije);
                    OutStreamObj2.WRITETEXT();

                    File5.CLOSE;
                    FileManagement.DownloadToFile(Putanja + 'unosnovca.xml', Putanja + 'unosnovca.xml');
                    Commit();

                    SLEEP(20000);


                    Commit();
                    //File1.CREATE(Putanja+'sfr1.xml',TEXTENCODING::UTF8);
                    File1.CREATE(Putanja + 'srr.reklamirani.000', TEXTENCODING::UTF8);
                    //ELSE
                    //File1.CREATE(Putanja+'srr.reklamirani - Copy.xml',TEXTENCODING::UTF8);
                    File1.CREATEOUTSTREAM(OutStreamObj);

                    //reklamirani račun
                    plite := '<?xml version="1.0" encoding="utf-8"?>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '<BrojZahtjeva>20</BrojZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '<VrstaZahtjeva>2</VrstaZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<NoviObjekat>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();


                    Custt.RESET;
                    Custt.SETFILTER("No.", '%1', ServiceCrMemoHeader."Bill-to Customer No.");
                    IF Custt.FINDFIRST THEN begin

                        if Custt."Registration No." <> '' then begin
                            plite := '<Kupac>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                            plite := '<Naziv>' + ServiceCrMemoHeader."Bill-to Name" + '</Naziv>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                            plite := '<Adresa>' + ServiceCrMemoHeader."Bill-to Address" + '</Adresa>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            //<PostanskiBroj>75320</PostanskiBroj>

                            plite := '<PostanskiBroj>' + ServiceCrMemoHeader."Bill-to Post Code" + '</PostanskiBroj>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<Grad>' + ServiceCrMemoHeader."Bill-to City" + '</Grad>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            plite := '</Kupac>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            //</Kupac>
                        end;

                    end;

                    plite := '<StavkeRacuna>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<RacunStavka>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    ServiceCrMemoLine.RESET;
                    ServiceCrMemoLine.SETFILTER("Document No.", '%1', UlazniRacun);
                    ServiceCrMemoLine.SETFILTER("No.", '<>%1', '');
                    IF ServiceCrMemoLine.FINDFIRST THEN BEGIN

                        plite := '<artikal>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Sifra>' + FORMAT(ServiceCrMemoLine."No.") + '</Sifra>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Naziv>' + FORMAT('Iznos po fakturi ' + ServiceCrMemoLine."Document No.") + '</Naziv>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<JM>' + 'KO' + '</JM>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        TotalCijena2 := 0;
                        Sallesr.RESET;
                        Sallesr.RESET;
                        Sallesr.SETFILTER("Document No.", '%1', UlazniRacun);
                        Sallesr.SETFILTER("No.", '<>%1', '');
                        IF Sallesr.FINDSET THEN
                            REPEAT
                                IF ServiceCrMemoHeader."Currency Factor" <> 0 THEN
                                    TotalCijena2 := TotalCijena2 + Sallesr."Amount Including VAT" / ServiceCrMemoHeader."Currency Factor"
                                ELSE
                                    TotalCijena2 := TotalCijena2 + Sallesr."Amount Including VAT";
                            UNTIL Sallesr.NEXT = 0;
                        TotalCijena := round(TotalCijena2, 0.01, '=');
                        ImaZarez := STRPOS(FORMAT(TotalCijena2), ',') + 1;


                        IF STRPOS(FORMAT(COPYSTR(FORMAT(TotalCijena2), ImaZarez, 2)), '00') = 0 THEN
                            Rezultat := ChangeSeparator(FORMAT(TotalCijena2, 0, '<Sign><Integer><Decimals><Comma,.>'))
                        ELSE
                            Rezultat := ChangeSeparator(FORMAT(ROUND(TotalCijena2), 0, '<Precision,2:2><Standard Format,2>'));
                        plite := '<Cijena>' + Rezultat + '</Cijena>';


                        //strsubstno(text01,format(100.10,0,'<Precision,2:2><Standard Format,0>'))
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        IF ServiceCrMemoLine.Amount - ServiceCrMemoLine."Amount Including VAT" < 0 THEN
                            plite := '<Stopa>E</Stopa>'
                        ELSE
                            plite := '<Stopa>K</Stopa>';


                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<Grupa>0</Grupa>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '<PLU>0</PLU>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        plite := '</artikal>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        ImaZarez := STRPOS(FORMAT(ServiceCrMemoLine.Quantity), ',') + 1;

                        IF STRPOS(FORMAT(COPYSTR(FORMAT(ServiceCrMemoLine.Quantity), ImaZarez, 2)), '00') = 0 THEN
                            Rezultat := ChangeSeparator(FORMAT(ServiceCrMemoLine.Quantity, 0, '<Sign><Integer><Decimals><Comma,.>'))
                        ELSE
                            Rezultat := ChangeSeparator(FORMAT(ROUND(ServiceCrMemoLine.Quantity), 0, '<Precision,2:2><Standard Format,2>'));


                        plite := '<Kolicina>1</Kolicina>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                        ImaZarez := STRPOS(FORMAT(ServiceCrMemoLine."Line Discount %"), ',') + 1;

                        IF STRPOS(FORMAT(COPYSTR(FORMAT(ServiceCrMemoLine."Line Discount %"), ImaZarez, 2)), '00') = 0 THEN
                            Rezultat := ChangeSeparator(FORMAT(ServiceCrMemoLine."Line Discount %", 0, '<Sign><Integer><Decimals><Comma,.>'))
                        ELSE
                            Rezultat := ChangeSeparator(FORMAT(ROUND(ServiceCrMemoLine."Line Discount %"), 0, '<Precision,2:2><Standard Format,2>'));



                        plite := '<Rabat>0</Rabat>';
                        OutStreamObj.WRITETEXT(plite);
                        OutStreamObj.WRITETEXT();
                    end;
                    plite := '</RacunStavka>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '</StavkeRacuna>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '<VrstePlacanja />';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    ServiceInvoiceHeader.RESET;
                    ServiceInvoiceHeader.SETFILTER("No.", '%1', ServiceCrMemoHeader."Applies-to Doc. No.");
                    IF ServiceInvoiceHeader.FINDFIRST THEN
                        plite := '<BrojRacuna>' + ServiceInvoiceHeader."Fiscal No." + '</BrojRacuna>'
                    ELSE
                        plite := '<BrojRacuna></BrojRacuna>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</NoviObjekat>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</RacunZahtjev>';

                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    File1.CLOSE;
                    Commit();
                    IF ServiceCrMemoHeader."Fiscal No. Printed" = FALSE THEN
                        FileManagement.DownloadToFile(Putanja + 'srr.reklamirani.000', Putanja + 'srr.reklamirani.000');
                    //ELSE
                    //FileManagement.DownloadToFile(Putanja+'srr.reklamirani - Copy.xml',Putanja+'srr.reklamirani - Copy.xml');

                    Commit();
                    IF ServiceCrMemoHeader."Fiscal No. Printed" = FALSE THEN BEGIN
                        SLEEP(30000);
                        Commit();
                        // Odgovor(Putanja2 + 'srr.reklamirani');

                        CZkF.Get(UserId);
                        BankAccocunt.Reset();
                        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                        if BankAccocunt.findfirst then begin
                            BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series R. FIscal No.", TODAY, true);

                        end;

                        ServiceCrMemoHeader."Fiscal No." := BrojFiskalnogRacuna;
                        //UserSetup.GET(USERID);
                        //FiscalPrinterSetup.GET(UserSetup."Fiscal Printer Code");
                        ServiceCrMemoHeader."Fiscal Printer Code" := 'TRING';
                        ServiceCrMemoHeader."Fiscal No. Printed" := TRUE;
                        ServiceCrMemoHeader."Fiscal DateTime" := CURRENTDATETIME;
                        ServiceCrMemoHeader."Fiscal User" := USERID;
                        ServiceCrMemoHeader.MODIFY;
                    END;
                END
                ELSE BEGIN

                    Commit();
                    File1.CREATE(Putanja + 'stampatiduplikatreklamiranogracuna.xml', TEXTENCODING::UTF8);
                    //File1.CREATE('\\FORTNAV\Temp\Stampatifiskalniracun.000',TEXTENCODING::UTF8);
                    File1.CREATEOUTSTREAM(OutStreamObj);
                    plite := '';

                    plite := '<?xml version="1.0" encoding="utf-8"?>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<BrojZahtjeva>946717</BrojZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<VrstaZahtjeva>4</VrstaZahtjeva>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Parametri>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Parametar>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Naziv>BrojRacuna</Naziv>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '<Vrijednost>' + ServiceCrMemoHeader."Fiscal No." + '</Vrijednost>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</Parametar>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</Parametri>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    plite := '</Zahtjev>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    File1.CLOSE;
                    FileManagement.DownloadToFile(Putanja + 'stampatiduplikatreklamiranogracuna.xml', Putanja + 'stampatiduplikatreklamiranogracuna.xml');

                    Commit();



                end;



            end;
        end;

    end;


    procedure SetParam(BrojRacuna: Code[20]; Reklamni: Boolean)


    begin
        UlazniRacun := BrojRacuna;
        ReklamniDA := Reklamni;

    end;

    procedure Odgovor(Upit: Text[2000])




    begin
        TXTTab := 13;
        //Upit:='\\DESKTOP-B6A3125\odgovori\sfr';
        IF EXISTS(Upit + '_1' + '.000') THEN
            ERASE(Upit + '_1' + '.000');
        IF EXISTS(Upit + '.000') THEN BEGIN
            Charr := 10;
            importFile.WRITEMODE(TRUE);
            importFile.TEXTMODE(TRUE);
            importFile.OPEN(Upit + '.000');
            importFile2.WRITEMODE(TRUE);
            importFile2.TEXTMODE(TRUE);
            IF NOT EXISTS(Upit + '_1' + '.000') THEN
                importFile2.CREATE(Upit + '_1' + '.000');


            WHILE importFile.READ(ReadLine) > 0 DO BEGIN

                x1 := 'xml';
                x2 := 'Kasa';
                x3 := 'VrstaOdgovora';
                x4 := 'Naziv';
                x5 := 'Vrijednost';
                X6 := 'Odgovor';
                IF (STRPOS(ReadLine, x1) = 0) THEN BEGIN
                    IF (STRPOS(ReadLine, x2) = 0) THEN BEGIN
                        IF (STRPOS(ReadLine, x3) = 0) THEN BEGIN
                            IF (STRPOS(ReadLine, x4) <> 0) THEN BEGIN

                                //<Naziv>BrojFiskalnogRacuna</Naziv>
                                Zamjena := COPYSTR(ReadLine, STRLEN('<Naziv>') + 7, STRLEN(ReadLine) - STRLEN('<Naziv></Naziv>') - 6);

                            END;
                            IF (STRPOS(ReadLine, x5) <> 0) THEN BEGIN
                                ReadLine2 := '<' + Zamjena + '>' + COPYSTR(ReadLine, STRPOS(ReadLine, '">') + 2, STRLEN(ReadLine) - STRPOS(ReadLine, '">') - STRLEN('</Vrijednost>') - 1) + '</' + Zamjena + '>';
                                importFile2.WRITE(ReadLine2 + FORMAT(Charr));
                            END;
                            IF STRPOS(ReadLine, X6) <> 0 THEN BEGIN
                                importFile2.WRITE(ReadLine);
                            END;


                        END
                        ELSE BEGIN
                            VrstaOdgovora := COPYSTR(ReadLine, STRLEN('<VrstaOdgovora>') + 3, STRLEN(ReadLine) - STRLEN('<VrstaOdgovora></VrstaOdgovora>') - 2)
                        END;


                    END;

                END;

                importFile2.CREATEINSTREAM(strInStream);
                importFile2.CREATEOUTSTREAM(XMLFileOutStr);
            END;
        END;



        importFile.CLOSE;
        importFile2.CLOSE;


        ToFileName := Upit + '_1' + '.000';

        CLEAR(xmldomDoc2);
        CLEAR(xmlNodeList1);
        CLEAR(xmlNodeList2);
        CLEAR(xmlNodeList3);
        CLEAR(xmlNodeList4);
        CLEAR(xmlNodeList5);
        CLEAR(xmlNodeList6);

        //ĐK xmldomDoc2 := XmlDocument.Create();
        XMLDomDocParam := XMLDomDocParam.XmlDocument();
        XMLDomDocParam.Load(Upit + '_1' + '.000');
        SystemXmlNodeListValue := XMLDomDocParam.GetElementsByTagName('BrojFiskalnogRacuna');
        SystemXmlNodeListValue2 := XMLDomDocParam.GetElementsByTagName('DatumFiskalnogRacuna');
        SystemXmlNodeListValue3 := XMLDomDocParam.GetElementsByTagName('VrijemeFiskalnogRacuna');
        SystemXmlNodeListValue4 := XMLDomDocParam.GetElementsByTagName('IznosFiskalnogRacuna');

        FOR i := 0 TO SystemXmlNodeListValue.Count - 1 DO BEGIN
            SystemXmlNodeValue := SystemXmlNodeListValue.Item(i);
            SystemXmlNodeValue2 := SystemXmlNodeListValue2.Item(i);
            SystemXmlNodeValue3 := SystemXmlNodeListValue3.Item(i);
            SystemXmlNodeValue4 := SystemXmlNodeListValue4.Item(i);




            BrojFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            DatumFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            VrijemeFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            IznosFiskalnogRacuna := SystemXmlNodeValue.InnerText;

            Commit();


        END;




    end;

    procedure ChangeSeparator(Number: Text[2000]) NumberConvert: Text


    begin
        IF STRLEN(Number) > 2 THEN BEGIN
            IF COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2) = ',' THEN BEGIN
                NumberConvert := COPYSTR(FORMAT(Number), 1, STRLEN(FORMAT(Number)) - 2) + '.' + COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2);
            END
            ELSE BEGIN
                NumberConvert := FORMAT(Number);
            END;
        END
        ELSE BEGIN
            NumberConvert := FORMAT(Number);
        END;

    end;



    var
        myInt: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        XMLManagement: Codeunit "XML DOM Management";
        UlazniRacun: Code[20];
        ReklamniDA: Boolean;
        ImaZarez: Integer;
        TextCitanje: BigText;
        Rezultat: Text[2000];
        TotalCijena2: Decimal;
        Sallesr: Record "Service Cr.Memo Line";
        ServiceCrMemoLine: Record "Service Cr.Memo Line";
        Iznoss: Decimal;

        xmlDomdoc: XmlDocument;
        TextPos: Integer;
        xmldomDoc3: XmlDocument;
        xmldomDoc2: XmlDocument;
        ServiceInvoiceHeader: Record "Service Invoice Header";
        xmlNodeList1: XmlNodeList;
        xmlNodeList2: XmlNodeList;
        xmlNodeList3: XmlNodeList;
        xmlNodeList4: XmlNodeList;
        xmlNodeList6: XmlNodeList;

        NodeVale: XmlNode;
        SystemXmlNodeValue: DotNet SystemXmlNode;
        SystemXmlNodeValue2: DotNet SystemXmlNode;
        SystemXmlNodeValue3: DotNet SystemXmlNode;
        SystemXmlNodeValue4: DotNet SystemXmlNode;

        ChildNode: DotNet SystemXmlNode;

        ChildNodeList: DotNet SystemXmlNodeList;

        i: Integer;
        j: Integer;
        xmlNodeList5: XmlNodeList;
        //TempBlob: Record TempBlob;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text[2000];
        ReadLine2: Text[2000];
        VrstaOdgovora: Text[2000];
        strInStream: InStream;
        x1: Text[2000];
        x2: Text[2000];
        x3: Text[2000];
        x4: Text[2000];
        XMLFileOutStr: OutStream;
        ToFileName: Text[2000];
        x5: Text[2000];
        x6: Text[2000];
        Zamjena: Text[2000];
        BrojFiskalnogRacuna: Text[2000];
        VrijemeFiskalnogRacuna: Text[2000];


        DatumFiskalnogRacuna: Text[2000];
        IznosFiskalnogRacuna: Text[2000];

        Custt: Record Customer;
        Putanja: Text[250];
        OutStreamObj2: OutStream;
        Linije: Text[2000];

        File5: File;
        Putanja2: Text[250];
        SystemXmlNodeListValue: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue2: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue3: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue4: DotNet SystemXmlNodeList;

        TXTTab: Char;
        Instr: InStream;
        filename: Text[2000];
        filepath: Text[2000];
        ServiceHeader: Record "Service Invoice Header";
        XMLDomDocParam: DotNet SystemXmlDocument;
        File1: File;
        SystemDokument: Dotnet SystemXmlDocument;
        SubText: Text[2000];
        OutStreamObj: OutStream;
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        plite: Text[2000];
        ServiceInvoiceLine: Record "Service Invoice Line";
        Salles: Record "Service Invoice Line";
        TotalCijena: Decimal;
        FileManagement: Codeunit "File Management";
    //ĐK     FiscalPrinterSetup: Record "BaH Fiscal Printer Setup";

}
