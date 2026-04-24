report 50114 "GroupRetailCalculationvp"
{
    // BH1.00, Maloprodajna kalkulacija
    DefaultLayout = RDLC;
    RDLCLayout = './GroupRetailCalculationVP.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Sales Shipment Line")
        {

            RequestFilterFields = "Posting Date";
            DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0), "Correction" = filter(false));
            column(CompInfoName; CompInfo.Name) { }
            column(CompInfoAddress; CompInfo.Address) { }
            column(LocationInfoNameAndAddress; locName + ', ' + locAddress) { }
            column(RetailCalculationDate; FORMAT("Posting Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(ConcatedCNumber; ConcatedCNumber) { }
            column(BuyFromVendorNameAndAddress; CompInfo.Name + ', ' + CompInfo.Address) { }
            column(Picture; CompInfo.Picture) { }
            column(VerifiedByLabel; VerifiedByLabel) { }
            column(ApprovedByLabel; ApprovedByLabel) { }
            column(PreparedByLabel; PreparedByLabel) { }
            column(TotalAmountWithVat; TotalAmountWithVat) { }
            column(TotalVAT; TotalVAT) { }
            column(TotalAmount; TotalAmount) { }
            column(TrgovackiOpisRobe_KOL2; TrgovackiOpisRobe_KOL2) { }
            column(JedinicaMjere_KOL3; JedinicaMjere_KOL3) { }
            column(Kolicina_KOL4; Kolicina_KOL4) { }
            column(FakturnaBezPDVaJedinicna_KOL5; FakturnaBezPDVaJedinicna_KOL5) { }
            column(FakturnaBezPDVaVrijednost_KOL6; FakturnaBezPDVaVrijednost_KOL6) { }
            column(ZavisniTroskoviBezPDVa_KOL7; ZavisniTroskoviBezPDVa_KOL7) { }
            column(NabavnaBezPDVaJedinicna_KOL8; NabavnaBezPDVaJedinicna_KOL8) { }
            column(NabavnaBezPDVaVrijednost_KOL9; NabavnaBezPDVaVrijednost_KOL9) { }
            column(StopaRazlikeUCijeni_KOL10; StopaRazlikeUCijeni_KOL10) { }
            column(IznosRazlikeUCijeni_KOL11; IznosRazlikeUCijeni_KOL11) { }
            column(ProdajnaCijenaBezPDVa_KOL12; ProdajnaCijenaBezPDVa_KOL12) { }
            column(StopaPDVa_KOL13; StopaPDVa_KOL13) { }
            column(IznosPDVa_KOL14; IznosPDVa_KOL14) { }
            column(ProdajnaSaPDVomVrijednost_KOL15; ProdajnaSaPDVomVrijednost_KOL15) { }
            column(ProdajnaSaPDVomJedinicna_KOL16; ProdajnaSaPDVomJedinicna_KOL16) { }
            column(VrijednostRUCa_KOL17; VrijednostRUCa_KOL17) { }
            column(VrijednostProdajnaBezPDVa_KOL18; VrijednostProdajnaBezPDVa_KOL18) { }
            column(VrijednostProdajnaPDVa_KOL19; VrijednostProdajnaPDVa_KOL19) { }

            trigger OnAfterGetRecord()
            var
            begin
                if selectedText <> 'Summary' then begin
                    TrgovackiOpisRobe_KOL2 := GetDescription("No.");
                    JedinicaMjere_KOL3 := GetBaseUoMText("No.");
                    Kolicina_KOL4 := "Quantity (Base)";
                    FakturnaBezPDVaJedinicna_KOL5 := Round("Unit Cost", 0.01, '<');
                    FakturnaBezPDVaVrijednost_KOL6 := Kolicina_KOL4 * FakturnaBezPDVaJedinicna_KOL5;
                    ZavisniTroskoviBezPDVa_KOL7 := 0;
                    NabavnaBezPDVaJedinicna_KOL8 := FakturnaBezPDVaJedinicna_KOL5;
                    NabavnaBezPDVaVrijednost_KOL9 := FakturnaBezPDVaVrijednost_KOL6;
                    ProdajnaCijenaBezPDVa_KOL12 := Round("Unit Price", 0.01, '=');
                    IznosRazlikeUCijeni_KOL11 := ProdajnaCijenaBezPDVa_KOL12 - FakturnaBezPDVaJedinicna_KOL5;
                    StopaRazlikeUCijeni_KOL10 := Round((IznosRazlikeUCijeni_KOL11 / NabavnaBezPDVaJedinicna_KOL8) * 100, 0.01, '=');
                    StopaPDVa_KOL13 := Format("VAT %") + '%';
                    IznosPDVa_KOL14 := Round(ProdajnaCijenaBezPDVa_KOL12 * ("VAT %" / 100), 0.01, '=');
                    ProdajnaSaPDVomJedinicna_KOL16 := ProdajnaCijenaBezPDVa_KOL12 + IznosPDVa_KOL14;
                    ProdajnaSaPDVomVrijednost_KOL15 := "Amount Incl. VAT"; // Kolicina_KOL4 * ProdajnaSaPDVomJedinicna_KOL16; 
                    VrijednostRUCa_KOL17 := Kolicina_KOL4 * IznosRazlikeUCijeni_KOL11;
                    VrijednostProdajnaBezPDVa_KOL18 := "Amount"; // Kolicina_KOL4 * ProdajnaCijenaBezPDVa_KOL12; 
                    VrijednostProdajnaPDVa_KOL19 := ProdajnaSaPDVomVrijednost_KOL15 - VrijednostProdajnaBezPDVa_KOL18;
                end
                else begin
                    TrgovackiOpisRobe_KOL2 := GetDescription("No.");
                    JedinicaMjere_KOL3 := GetBaseUoMText("No.");
                    Kolicina_KOL4 += "Quantity (Base)";
                    FakturnaBezPDVaJedinicna_KOL5 := Round("Unit Cost", 0.01, '<');
                    FakturnaBezPDVaVrijednost_KOL6 += "Quantity (Base)" * FakturnaBezPDVaJedinicna_KOL5;
                    ZavisniTroskoviBezPDVa_KOL7 := 0;
                    NabavnaBezPDVaJedinicna_KOL8 := FakturnaBezPDVaJedinicna_KOL5;
                    NabavnaBezPDVaVrijednost_KOL9 := FakturnaBezPDVaVrijednost_KOL6;
                    ProdajnaCijenaBezPDVa_KOL12 := Round("Unit Price", 0.01, '=');
                    IznosRazlikeUCijeni_KOL11 := ProdajnaCijenaBezPDVa_KOL12 - FakturnaBezPDVaJedinicna_KOL5;
                    StopaRazlikeUCijeni_KOL10 := Round((IznosRazlikeUCijeni_KOL11 / NabavnaBezPDVaJedinicna_KOL8) * 100, 0.01, '=');
                    StopaPDVa_KOL13 := Format("VAT %") + '%';
                    IznosPDVa_KOL14 := Round(ProdajnaCijenaBezPDVa_KOL12 * ("VAT %" / 100), 0.01, '=');
                    ProdajnaSaPDVomJedinicna_KOL16 := ProdajnaCijenaBezPDVa_KOL12 + IznosPDVa_KOL14;
                    ProdajnaSaPDVomVrijednost_KOL15 += "Amount Incl. VAT"; //"Quantity (Base)" * ProdajnaSaPDVomJedinicna_KOL16; 
                    VrijednostRUCa_KOL17 += "Quantity (Base)" * IznosRazlikeUCijeni_KOL11;
                    VrijednostProdajnaBezPDVa_KOL18 += "Amount"; // "Quantity (Base)" * ProdajnaCijenaBezPDVa_KOL12; 
                    VrijednostProdajnaPDVa_KOL19 += "Amount Incl. VAT" - "Amount"; // ("Quantity (Base)" * ProdajnaSaPDVomJedinicna_KOL16) - ("Quantity (Base)" * ProdajnaCijenaBezPDVa_KOL12);
                    BrojacRedova -= 1;

                    if BrojacRedova > 0 then
                        CurrReport.Skip();
                end;
            end;

            trigger OnPreDataItem()
            var
                loc: Record Location;
                PostingDateFilter: Text;
            begin
                PostingDateFilter := GetFilter("Posting Date");

                if PostingDateFilter = '' then begin
                    Message('Filter po datumu knjiženja je prazan! Molim vas, odaberite određeni datum za povlačenje izvještaja!');
                    CurrReport.Break();
                end;

                BrojacRedova := Count;
                StartDate := GetRangeMin("Posting Date");
                EndDate := GetRangeMax("Posting Date");

                if StartDate <> EndDate then begin
                    Message('Ovaj izvještaj nije predviđen da radi za period. Molim vas, unesite samo jedan dan/datum u filteru!');
                    CurrReport.Break();
                end;

                CompInfo.CALCFIELDS(Picture);
                DataItem1.SetFilter("Location Code", 'CNG MLP|CNG VLP|VLASTITA');

                loc.SetFilter(Code, '%1', 'CNG VLP');
                if loc.FindFirst() then begin
                    locAddress := loc.Address;
                    locName := loc.Name;
                end;

                CalculationNumber := GenerateCalculationNumber(StartDate);
                ConcatedCNumber := CalculationNumber + '/' + FORMAT(Date2DMY(StartDate, 3));

                TotalAmount := CalcTotalAmountWithoutVAT(StartDate, EndDate);
                TotalAmountWithVat := CalcTotalAmountWithVAT(StartDate, EndDate);
                TotalVAT += TotalAmountWithVat - TotalAmount;
            end;

            trigger OnPostDataItem()
            begin
                if selectedText = 'Summary' then begin
                    // Uradi nešto...
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Izaberi prikaz")
                {
                    Caption = 'Izaberi prikaz';
                    field(Selected; Selected)
                    {
                        Caption = 'Detaljno:';
                        OptionCaption = 'Detaljno,Sumarno';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    var
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";
        myInt: Integer;
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50114);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        selectedText := Format(Selected);
    end;

    var
        BrojacRedova: Integer;
        CompInfo: Record "Company Information";
        selectedText: Text;
        locName: Text;
        locAddress: Text;
        CalculationNumber: Text[100];
        ConcatedCNumber: Text[100];
        Selected: Option "Detail","Summary";
        TrgovackiOpisRobe_KOL2: Text[50];
        JedinicaMjere_KOL3: Text[50];
        Kolicina_KOL4: Decimal;
        Kolicina_KOL4_Total: Decimal;
        FakturnaBezPDVaJedinicna_KOL5: Decimal;
        FakturnaBezPDVaVrijednost_KOL6: Decimal;
        FakturnaBezPDVaVrijednost_KOL6_Total: Decimal;
        ZavisniTroskoviBezPDVa_KOL7: Decimal;
        ZavisniTroskoviBezPDVa_KOL7_Total: Decimal;
        NabavnaBezPDVaJedinicna_KOL8: Decimal;
        NabavnaBezPDVaVrijednost_KOL9: Decimal;
        NabavnaBezPDVaVrijednost_KOL9_Total: Decimal;
        StopaRazlikeUCijeni_KOL10: Decimal;
        IznosRazlikeUCijeni_KOL11: Decimal;
        ProdajnaCijenaBezPDVa_KOL12: Decimal;
        StopaPDVa_KOL13: Text[50];
        IznosPDVa_KOL14: Decimal;
        ProdajnaSaPDVomVrijednost_KOL15: Decimal;
        ProdajnaSaPDVomVrijednost_KOL15_Total: Decimal;
        ProdajnaSaPDVomJedinicna_KOL16: Decimal;
        VrijednostRUCa_KOL17: Decimal;
        VrijednostRUCa_KOL17_Total: Decimal;
        VrijednostProdajnaBezPDVa_KOL18: Decimal;
        VrijednostProdajnaBezPDVa_KOL18_Total: Decimal;
        VrijednostProdajnaPDVa_KOL19: Decimal;
        VrijednostProdajnaPDVa_KOL19_Total: Decimal;
        TotalAmount: Decimal;
        TotalVAT: Decimal;
        TotalAmountWithVat: Decimal;
        VerifiedByLabel: Label 'Verified by';
        PreparedByLabel: Label 'Prepared by';
        ApprovedByLabel: Label 'Approved by';
        StartDate: Date;
        EndDate: date;

    procedure GetBaseUoMText(ItemNo: Code[20]): Text[50]
    var
        UoM: Record "Unit of Measure";
        Item: Record "Item";
    begin
        IF Item.GET(ItemNo) THEN BEGIN
            IF UoM.GET(Item."Base Unit of Measure") THEN
                EXIT(UoM.Code);
        END;
    end;

    procedure GetDescription(ItemNo: Code[20]): Text[50]
    var
        Item: Record "Item";
    begin
        IF Item.GET(ItemNo) THEN BEGIN

            IF Item."Description" <> '' then begin
                if item.Description = 'Prirodni gas' then
                    exit('CNG')
                else
                    exit(item.Description);
            end
            else
                EXIT(Item."No.");
        END;
    end;

    procedure CalcTReceiptAmountWithVAT(var transfer: Record "Transfer Receipt Line"): Decimal;
    var
        CurrentVE: Record "Value Entry";
        amount: Decimal;
    begin
        IF transfer."Quantity (Base)" = 0 THEN CurrReport.SKIP;

        CurrentVE.SETRANGE("Document No.", transfer."Document No.");
        CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
        CurrentVE.SETRANGE("Document Line No.", transfer."Line No.");
        CurrentVE.SETRANGE("Location Code", transfer."Transfer-to Code");
        IF CurrentVE.FINDFIRST THEN BEGIN
            REPEAT
                amount += ((CurrentVE."Cost per Unit" * (1 + abs(CurrentVE."Retail VAT") / 100)) * CurrentVE."Invoiced Quantity"); // Ovo je: 1.14 * 1.17 * količina, da dobijemo fakturnu vrijednost sa PDV-om
            UNTIL CurrentVE.NEXT = 0;
        END;
        exit(amount);
    end;

    procedure CalcTReceiptAmount(var transfer: Record "Transfer Receipt Line"): Decimal;
    var
        CurrentVE: Record "Value Entry";
        amount: Decimal;
        amountWithVAT: Decimal;
    begin
        IF transfer."Quantity (Base)" = 0 THEN CurrReport.SKIP;

        CurrentVE.SETRANGE("Document No.", transfer."Document No.");
        CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
        CurrentVE.SETRANGE("Document Line No.", transfer."Line No.");
        CurrentVE.SETRANGE("Location Code", transfer."Transfer-to Code");
        IF CurrentVE.FINDFIRST THEN BEGIN
            REPEAT
                amount += CurrentVE."Cost per Unit" * CurrentVE."Invoiced Quantity";
            UNTIL CurrentVE.NEXT = 0;
        END;
        exit(amount);
    end;

    procedure CalcTotalAmountWithoutVAT(var receiptDate: Date; endDate: Date): Decimal;
    var
        trh: Record "Transfer Receipt Header";
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter(Correction, '%1', false);
        trline.SETFILTER("Transfer-to Code", 'CNG VLP|VLASTITA');
        if trLine.FindSet() then
            repeat
                trh.Reset();
                if trh.Get(trLine."Document No.") then begin
                    if not trh.Correction then begin
                        amount += CalcTReceiptAmount(trLine);
                    end;
                end;
            until trLine.Next = 0;
        exit(amount);

    end;

    procedure CalcTotalAmountWithVAT(var receiptDate: Date; endDate: Date): Decimal;
    var
        trh: Record "Transfer Receipt Header";
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter(Correction, '%1', false);
        trline.SETFILTER("Transfer-to Code", 'CNG VLP|VLASTITA');
        if trLine.FindSet() then
            repeat
                trh.Reset();
                if trh.Get(trLine."Document No.") then begin
                    if not trh.Correction then begin
                        amount += CalcTReceiptAmountWithVAT(trLine);
                    end;
                end;
            until trLine.Next = 0;
        exit(amount);
    end;

    procedure GenerateCalculationNumber(var recDate: Date): Text;
    var
        trHeader: Record "Transfer Receipt Header";
        Gener: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        number: Text;
        trHeader2: Record "Transfer Receipt Header";
    begin
        Gener.Get();
        number := '';
        trHeader.Reset();
        trHeader.SetFilter("Receipt Date", '%1', recDate);
        trHeader.SetFilter("Transfer-to Code", 'CNG VLP|VLASTITA');
        trHeader.SetFilter("Group Calculation Number", '<>%1', '');
        if trHeader.FindFirst() then begin
            number := trHeader."Group Calculation Number";
            trHeader2.Reset();
            trHeader2.SetFilter("Receipt Date", '%1', recDate);
            trHeader2.SetFilter("Transfer-to Code", 'CNG VLP|VLASTITA');
            trHeader2.SetFilter("Group Calculation Number", '%1', '');
            if trHeader2.FindFirst() then
                repeat
                    trHeader2."Group Calculation Number" := number;
                    trHeader2.Modify();
                    exit(trHeader2."Group Calculation Number");
                until trheader2.next = 0;
        end
        ELSE begin
            trheader.RESET;
            trHeader.SetFilter("Receipt Date", '%1', recDate);
            trHeader.SetFilter("Transfer-to Code", 'CNG VLP|VLASTITA');
            trHeader.SetFilter("Group Calculation Number", '%1', '');
            IF trheader.Findfirst then begin
                trHeader."Group Calculation Number" := NoSeriesMgt.GetNextNo(Gener."Group Retail Calculation Entry Series VP", TODAY, true);
                trHeader.Modify();
            end;
            exit(trHeader."Group Calculation Number");
        end;
        exit(trHeader."Group Calculation Number");
    end;
}

