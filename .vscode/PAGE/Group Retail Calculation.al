report 50139 "Group Retail Calculation"
{
    // BH1.00, Maloprodajna kalkulacija
    DefaultLayout = RDLC;
    RDLCLayout = './Group Retail Calculation.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Transfer Receipt Line")
        {

            RequestFilterFields = "Receipt Date", "Group Calculation Number";
            DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0), "Correction" = filter(false));
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(EndDate; EndDate) { }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {
            }
            column(LocationInfoNameAndAddress; locName + ', ' + locAddress)
            {
            }
            column(RetailCalculationNo; CalculationNumber)
            {
            }
            column(RetailCalculationDate; FORMAT("Receipt Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(ConcatedCNumber; ConcatedCNumber) { }
            column(Year; Year)
            {

            }
            column(ctrlText; selectedText) { }
            column(TK; TK) { }
            column(BuyFromVendorNameAndAddress; CompInfo.Name + ', ' + CompInfo.Address)
            {

            }

            column(CompInfoVATNo; CompInfo."VAT Registration No.")
            {
            }
            column(CompInfoVATNoCaption; CompInfo.FIELDCAPTION("VAT Registration No."))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(TodayFormatted; FORMAT(TODAY))
            {
            }

            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(LocationCode; Location.Code)
            {
            }

            column(LocationCaption; Location.TABLECAPTION)
            {
            }
            column(ReportCaption; ReportCaption)
            {
            }
            column(CounterCaption; CounterCaption)
            {
            }
            column(sumField6; sumField6) { }
            column(sumField15; sumField15) { }

            column(VerifiedByLabel; VerifiedByLabel)
            {
            }
            column(ApprovedByLabel; ApprovedByLabel)
            {
            }
            column(PreparedByLabel; PreparedByLabel)
            {

            }
            column(sumField4; Quantity6) { }
            column(sumField9; sumField9) { }
            column(sumField17; sumField17) { }
            column(sumField18; sumField18) { }
            column(sumField19; sumField19) { }
            column(TotalAmountWithVat; TotalAmountWithVat)
            {

            }
            column(CurrentField7; CurrentField7) { }
            column(TotalVAT; TotalVAT)
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }

            column(TotalForInvoiceCaption; TotalForInvoiceCaption)
            {
            }


            column(TransLineDescription; GetDescription("Item No."))
            {
            }
            column(CurrentUoMText; CurrentUoMText)
            {
            }
            column(CurrInvQty; CurrInvQty)
            {
            }
            column(CurrInvPr; CurrInvPr)
            {
            }
            column(CurrInvCost; CurrInvPr * Quantity6)
            {
            }
            column(TotalQuantity; CalcTotalQuantity(StartDate, EndDate)) { }
            column(CurrentDirectCostActual; CurrentDirectCostActual)
            {
            }

            column(CurrentPriceDifferenceAmount; CurrentPriceDifferenceAmount)
            {

            }
            column(CurrentPriceDifferenceRate; CurrentPriceDifferenceRate)
            {

            }
            column(CurrentUnitSellPriceWithoutVat; CurrentUnitSellPriceWithoutVat)
            {

            }
            column(CurrentRuc; CurrentRuc)
            {

            }
            column(CurrentValueSellAmountWithoutVat; CurrentValueSellAmountWithoutVat)
            {

            }
            column(CurrentValueSellVat; CurrentValueSellVat)
            {

            }
            column(CurrentVatRate; CurrentVatRate)
            {

            }
            column(CurrentVatAmount; CurrentVatAmount)
            {

            }
            column(CurrentSellAmountWithVat; CurrentSellAmountWithVat)
            {

            }
            column(CurrentUnitSellAmountWithVat; CurrentUnitSellAmountWithVat)
            {

            }
            column(TradeNameOfTheGoodsCaption; TradeNameOfTheGoodsCaption)
            {
            }
            column(QuantityCaption; DataItem1.FIELDCAPTION(Quantity))
            {
            }
            column(UoMCaption; DataItem1.FIELDCAPTION("Unit of Measure"))
            {
            }
            column(UnitCaption; UnitCaption)
            {
            }
            column(PriceCaption; PriceCaption)
            {
            }
            column(tlCounter; tlCounter) { }
            column(DependantCostsWithoutVatCaption; DependantCostsWithoutVatCaption)
            {
            }
            column(PurchPriceCaption; PurchPriceCaption)
            {
            }
            column(TotalCostCaption; TotalCostCaption)
            {
            }
            column(ItemChargesCaption; ItemChargesCaption)
            {
            }
            column(PurchaseCaption; PurchaseCaption)
            {

            }
            column(InvoicedWithoutVatCaption; InvoicedWithoutVatCaption)
            {

            }
            column(UnitWithoutVatCaption; UnitWithoutVatCaption)
            {

            }
            column(ValueWithoutVatCaption; ValueWithoutVatCaption)
            {

            }
            column(PriceDifferenceRateCaption; PriceDifferenceRateCaption)
            {

            }
            column(Control; Control) { }
            column(PriceDifferenceAmountCaption; PriceDifferenceAmountCaption)
            {

            }
            column(SellAmountWithoutVatCaption; SellAmountWithoutVatCaption)
            {

            }
            column(VatRateCaption; VatRateCaption)
            {

            }
            column(VatAmountCaption; VatAmountCaption)
            {

            }
            column(SellAmountWithVatCaption; SellAmountWithVatCaption)
            {

            }
            column(SellAmountWithVatValueCaption; SellAmountWithVatValueCaption)
            {

            }
            column(SellAmountWithVatCostCaption; SellAmountWithVatCostCaption)
            {

            }
            column(SellAmountWithVatUnitCaption; SellAmountWithVatUnitCaption)
            {

            }
            column(TotalValueCaption; TotalValueCaption)
            {

            }
            column(RucCaption; RucCaption)
            {

            }
            column(SellPriceWithoutVatCaption; SellPriceWithoutVatCaption)
            {

            }
            column(SellPriceWithVatCaption; SellPriceWithVatCaption)
            {

            }

            trigger OnAfterGetRecord()
            var
                CurrentVE: Record "Value Entry";
            begin
                IF "Quantity (Base)" = 0 THEN CurrReport.SKIP;
                if selectedText <> 'Summary' then Quantity6 := "Quantity (Base)" else Quantity6 := CalcGroupedQuantity(StartDate, EndDate, "Item No.");
                loc.reset();
                loc.SetFilter(Code, '%1', "Transfer-to Code");
                if loc.FindFirst() then begin
                    locAddress := loc.Address;
                    locName := loc.Name;
                end;
                CurrReport.PAGENO := 1;

                CalculationNumber := GenerateCalculationNumber("Receipt Date");
                Year := Date2DMY("Receipt Date", 3);
                ConcatedCNumber := CalculationNumber + '/' + FORMAT(Year);
                //find value entry, go sequential by "entry no." because no key created
                IF RECORDLEVELLOCKING THEN
                    CurrentVE.SETCURRENTKEY("Item Ledger Entry No.", "Document No.", "Document Line No.")
                ELSE
                    CurrentVE.SETCURRENTKEY("Document No.");
                CurrInvQty := "Quantity (Base)";
                CurrentInvoicedCost := 0;
                CurrInvPr := 0;
                CurrentPriceDifferenceRate := 0;
                CurrentPriceDifferenceAmount := 0;
                CurrentUnitSellPriceWithoutVat := 0;
                CurrentVatAmount := 0;
                CurrentUnitSellAmountWithVat := 0;
                CurrentSellAmountWithVat := 0;

                CurrentRuc := 0;
                CurrentValueSellAmountWithoutVat := 0;
                CurrentValueSellVat := 0;




                CurrentVE.SETRANGE("Document No.", "Document No.");
                CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                CurrentVE.SETRANGE("Document Line No.", "Line No.");
                CurrentVE.SETRANGE("Location Code", "Transfer-to Code");
                IF CurrentVE.FINDFIRST THEN BEGIN

                    CurrentDirectCostActual := CalcDirectCost(CurrentVE);
                    CurrentInvoicedCost += CurrentVE."Cost per Unit" * CurrentVE."Invoiced Quantity";
                    TotalAmount := CalcTotalAmountWithoutVAT(StartDate, EndDate, CurrentVE."Location Code");
                    TotalAmountWithVat := CalcTotalAmountWithVAT(StartDate, EndDate, CurrentVE."Location Code");

                    CurrentUoMText := GetBaseUoMText("Item No.");
                    if selectedText = 'Summary' then
                        Control := GetDescription("Item No.")
                    else
                        Control := GetDescription("Item No.") + ' ' + CurrentVE."Document No.";
                    InsertAdditionalCostBuffer(CurrentVE);

                    REPEAT
                        if selectedText <> 'Summary' then begin
                            CurrentField7 := 0;
                            CurrInvPr += CurrentVE."Cost per Unit";
                            CurrentRuc := CurrentVE."Retail RUC";
                            CurrentValueSellAmountWithoutVat += CurrentVE."Total Retail Amount";
                            CurrentValueSellVat += (CurrentVE."T.Retail Unit Price with VAT") - CurrentValueSellAmountWithoutVat;
                            CurrentSellAmountWithVat += CurrentVE."T.Retail Unit Price with VAT";
                            CurrentUnitSellPriceWithoutVat += CurrentVE."Retail Unit Price";
                            CurrentUnitSellAmountWithVat += CurrentVE."Retail Unit Price with VAT";
                            CurrentPriceDifferenceAmount += CurrentUnitSellPriceWithoutVat - CurrInvPr;
                            if CurrentInvoicedCost = 0 then
                                CurrentPriceDifferenceRate := 0 else
                                CurrentPriceDifferenceRate += ((CurrentValueSellAmountWithoutVat - CurrentInvoicedCost) / CurrentInvoicedCost) * 100;
                            CurrentVatAmount += CurrentUnitSellAmountWithVat - CurrentUnitSellPriceWithoutVat;
                            CurrentVatRate := ConvertDecimalToString(CurrentVE."Retail VAT") + '%';
                            //   TotalAmountWithVat += CurrentInvoicedCost * (1 + (CurrentVE."Retail VAT" / 100));
                            tlCounter += 1;
                            TotalVAT += TotalAmountWithVat - TotalAmount;
                            if CurrentVatAmount < 0 then begin
                                CurrentVatAmount := 0;
                            end;
                            if CurrentValueSellVat < 0 then begin
                                CurrentValueSellVat := 0;
                            end;
                        end
                        else begin
                            //CurrentDirectCostActual := CurrentDirectCostActual + ((countDistinct(StartDate, EndDate, "Item No.", selectedText) - 1) * CurrentVE."Cost per Unit" * CurrentVE."Invoiced Quantity");
                            CurrentField7 := 0;

                            sumField9 += CurrentDirectCostActual;
                            ControlDecimal := CurrentVE."Cost per Unit" * Quantity6;
                            sumField6 := ControlDecimal;
                            CurrInvQty := CalcGroupedQuantity(StartDate, EndDate, "Item No.");
                            CurrInvPr := CurrentVE."Cost per Unit";
                            CurrentRuc += CalcGroupedRUC(StartDate, EndDate, "Item No.", CurrentVE."Location Code");
                            CurrentValueSellAmountWithoutVat := CurrentVE."Total Retail Amount";
                            CurrentValueSellVat += CalcGroupedRUC(StartDate, EndDate, "Item No.", CurrentVE."Location Code");
                            //CurrentSellAmountWithVat := CurrentVE."Retail Unit Price with VAT" * Quantity6;
                            GroupedRTPriceWithVat := CalcGroupedPriceWithVat(StartDate, EndDate, "Item No.", CurrentVE."Location Code");
                            CurrentSellAmountWithVat := GroupedRTPriceWithVat;
                            sumField15 := CurrentSellAmountWithVat;
                            sumField17 := CurrentValueSellAmountWithoutVat;
                            sumField18 += CalcGroupedVAT(StartDate, EndDate, "Item No.", CurrentVE."Location Code");
                            sumField19 := CurrentSellAmountWithVat;
                            CurrentUnitSellPriceWithoutVat += CurrentVE."Retail Unit Price";
                            CurrentUnitSellAmountWithVat += CurrentVE."Retail Unit Price with VAT";
                            CurrentPriceDifferenceAmount += CurrentUnitSellPriceWithoutVat - CurrInvPr;
                            if ControlDecimal = 0 then
                                CurrentPriceDifferenceRate := 0 else
                                CurrentPriceDifferenceRate := CalcGroupedPriceDiffernece(StartDate, EndDate, "Item No.", CurrentVE."Location Code");
                            CurrentVatAmount += CurrentUnitSellAmountWithVat - CurrentUnitSellPriceWithoutVat;
                            CurrentVatRate := ConvertDecimalToString(CurrentVE."Retail VAT") + '%';
                            //   TotalAmountWithVat += CurrentInvoicedCost * (1 + (CurrentVE."Retail VAT" / 100));
                            tlCounter := 1;
                            TotalVAT += TotalAmountWithVat - TotalAmount;
                            if CurrentVatAmount < 0 then begin
                                CurrentVatAmount := 0;
                            end;
                            if CurrentValueSellVat < 0 then begin
                                CurrentValueSellVat := 0;
                            end;
                        end;


                    UNTIL CurrentVE.NEXT = 0;
                END
                ELSE
                    ERROR(Text001, GETPOSITION());

            end;

            trigger OnPreDataItem()
            var
                PurchInvHeader2: Record "Purch. Inv. Header";
                PurchInvLine2: Record "Purch. Inv. Line";
                Delimiter: Text[2];
            begin
                //   IF COUNT <> 1 THEN ERROR(Text005);
                CurrReport.CREATETOTALS(CurrentInvoicedCost, CurrentDirectCostActual);
                CompInfo.CALCFIELDS(Picture);
                DataItem1.SetFilter("Transfer-to Code", 'CNG MLP');
                StartDate := GetRangeMin("Receipt Date");
                EndDate := GetRangeMax("Receipt Date");


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

        actions
        {
        }

    }

    labels
    {
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50139);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;
    end;


    trigger OnPreReport()
    begin
        CompInfo.GET;
        selectedText := Format(Selected);
        // StartDate := GetFilter("Receipt Date", 1);
        // EndDate := Page."Receipt Date".FILTERGROUP(2);
    end;

    var
        RecNo: Code[20];
        CompInfo: Record "Company Information";
        TK: Text[25];
        AdditionalCostVE: Record "Value Entry" temporary;
        Location: Record "Location";
        selectedText: Text;
        loc: Record Location;
        locName: Text;
        locAddress: Text;
        BuyFromVendor: Record "Vendor";
        TransferHeader: Record "Transfer Header";
        Gener: Record "General Ledger Setup";
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";
        PayToVendor: Record "Vendor";
        CurrentILE: Record "Item Ledger Entry";
        CalculationNumber: Text[100];
        ConcatedCNumber: Text[100];
        Selected: Option "Detail","Summary";
        Year: Integer;
        Control: Text;
        CurrentField7: Decimal;
        ControlDecimal: Decimal;
        CurrInvQty: Decimal;
        CurrInvPr: Decimal;
        CurrentInvoicedCost: Decimal;
        CurrentPriceDifferenceRate: Decimal;
        CurrentPriceDifferenceAmount: Decimal;
        CurrentUnitSellPriceWithoutVat: Decimal;
        CurrentVatRate: Text[50];
        Divider: Decimal;
        CurrentVatAmount: Decimal;
        CurrentSellAmountWithVat: Decimal;
        CurrentUnitSellAmountWithVat: Decimal;
        CurrentRuc: Decimal;
        CurrentValueSellAmountWithoutVat: Decimal;
        CurrentValueSellVat: Decimal;
        CurrentDirectCostActual: Decimal;
        tlCounter: Integer;
        TotalAmount: Decimal;
        TotalVAT: Decimal;
        TotalAmountWithVat: Decimal;
        AdditionalCost: Decimal;
        PostedNos: Text[1024];
        Text001: Label 'No value entries exist for %1';
        Text003: Label 'Posted Invoice No. %1 can not be a part of the calculation as it does not contain any items';
        CurrentUoMText: Text[50];
        AdditionalInvoices: Text[1024];
        Text004: Label 'Total %1:';
        Text005: Label 'You must choose only one receipt!';
        ReportCaption: Label 'Transfer cost calculation for:';
        CounterCaption: Label 'No.';
        PageNoCaptionLbl: Label 'Page';
        TradeNameOfTheGoodsCaption: Label 'Trade name of the goods';
        UnitCaption: Label 'Unit';
        PriceCaption: Label 'Price';
        DependantCostsWithoutVatCaption: Label 'Dependant costs without VAT';
        PurchaseCaption: Label 'Purchase';
        UnitWithoutVatCaption: Label 'Unit without VAT';
        ValueWithoutVatCaption: Label 'Value without VAT';
        PriceDifferenceRateCaption: Label 'Price difference rate';
        PriceDifferenceAmountCaption: Label 'Price difference amount';
        SellAmountWithoutVatCaption: Label 'Sell amount without VAT';
        VatRateCaption: Label 'VAT Rate';
        VatAmountCaption: Label 'VAT Amount';
        SellAmountWithVatCaption: Label 'Sell Amount with VAT';
        SellAmountWithVatValueCaption: Label 'Sell Amount with VAT Value';
        SellAmountWithVatCostCaption: Label 'Sell Amount with VAT Cost';
        SellAmountWithVatUnitCaption: Label 'Sell Amount with VAT Unit';
        TotalValueCaption: Label 'Total Value';
        RucCaption: Label 'RUC';
        InvoicedWithoutVatCaption: Label 'Invoiced without VAT';
        SellPriceWithoutVatCaption: Label 'Sell without VAT price';
        SellPriceWithVatCaption: Label 'Value VAT';
        PurchPriceCaption: Label 'Purch. price';
        TotalCostCaption: Label 'Total cost';
        TotalForInvoiceCaption: Label 'Total for invoice:';
        ItemChargesCaption: Label 'Additional Costs';
        VerifiedByLabel: Label 'Verified by';
        PreparedByLabel: Label 'Prepared by';
        ApprovedByLabel: Label 'Approved by';

        TransferFromCaption: Label 'Vendor';
        FilterYear: Text;

        Quantity6: Decimal;
        sumField6: Decimal;
        sumField9: Decimal;
        sumField15: Decimal;
        sumField17: Decimal;
        sumField18: Decimal;
        sumField19: Decimal;
        StartDate: Date;
        EndDate: date;
        GroupedRTPriceWithVat: Decimal;

    procedure CalcDirectCost(var ve: Record "Value Entry"): Decimal
    var
        VE2: Record "Value Entry";
    begin
        VE2.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        VE2.SETRANGE("Item Ledger Entry No.", ve."Item Ledger Entry No.");
        VE2.SETFILTER("Entry Type", '%1', ve."Entry Type"::"Direct Cost");
        VE2.CALCSUMS("Cost Amount (Actual)");
        EXIT(VE2."Cost Amount (Actual)");
    end;

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


    procedure InsertAdditionalCostBuffer(var ve: Record "Value Entry")
    var
        VE2: Record "Value Entry";
    begin
        VE2.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        VE2.SETRANGE("Item Ledger Entry No.", ve."Item Ledger Entry No.");
        VE2.SETFILTER("Entry Type", '%1', ve."Entry Type"::"Direct Cost");
        IF VE2.FINDFIRST THEN
            REPEAT
                IF (VE2."Item Charge No." <> '') THEN BEGIN
                    AdditionalCostVE.INIT;
                    AdditionalCostVE.TRANSFERFIELDS(VE2, TRUE);
                    AdditionalCostVE.INSERT;
                END;
            UNTIL VE2.NEXT = 0;
    end;

    procedure ConvertDecimalToString(var dec: Decimal): Text;
    var
        StringValue: Text;
    begin

        StringValue := STRSUBSTNO('%1', dec);
        exit(StringValue);
    end;

    procedure CalcTReceiptAmountWithVAT(var transfer: Record "Transfer Receipt Line"): Decimal;
    var
        CurrentVE: Record "Value Entry";
        amount: Decimal;
        amountWithVAT: Decimal;
    begin
        IF transfer."Quantity (Base)" = 0 THEN CurrReport.SKIP;

        CurrentInvoicedCost := 0;
        CurrentVE.SETRANGE("Document No.", transfer."Document No.");
        CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
        CurrentVE.SETRANGE("Document Line No.", transfer."Line No.");
        CurrentVE.SETRANGE("Location Code", transfer."Transfer-to Code");
        IF CurrentVE.FINDFIRST THEN BEGIN
            REPEAT
                amount += CurrentVE."Cost Amount (Actual)";
                //              ;
                amountWithVAT += amount * (1 + (CurrentVE."Retail VAT" / 100));
            UNTIL CurrentVE.NEXT = 0;
        END;
        exit(amountWithVAT);
    end;

    procedure CalcTReceiptAmount(var transfer: Record "Transfer Receipt Line"): Decimal;
    var
        CurrentVE: Record "Value Entry";
        amount: Decimal;
        amountWithVAT: Decimal;
    begin
        IF transfer."Quantity (Base)" = 0 THEN CurrReport.SKIP;

        CurrentInvoicedCost := 0;
        CurrentVE.SETRANGE("Document No.", transfer."Document No.");
        CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
        CurrentVE.SETRANGE("Document Line No.", transfer."Line No.");
        CurrentVE.SETRANGE("Location Code", transfer."Transfer-to Code");
        IF CurrentVE.FINDFIRST THEN BEGIN
            REPEAT
                amount += CurrentVE."Cost Amount (Actual)";
                amountWithVAT += amount * (1 + (CurrentVE."Retail VAT" / 100));
            UNTIL CurrentVE.NEXT = 0;
        END;
        exit(amount);
    end;

    procedure CalcTotalAmountWithoutVAT(var receiptDate: Date; endDate: Date; Loc: Code[20]): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter(Correction, '%1', false);
        trline.SETFILTER("Transfer-to Code", Loc);
        if trLine.FindSet() then
            repeat
                amount += CalcTReceiptAmount(trLine);
            until trLine.Next = 0;
        exit(amount);

    end;

    procedure CalcTotalAmountWithVAT(var receiptDate: Date; endDate: Date; Loc: Code[20]): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter(Correction, '%1', false);
        trline.SETFILTER("Transfer-to Code", Loc);
        if trLine.FindSet() then
            repeat
                amount += CalcTReceiptAmountWithVAT(trLine);
            until trLine.Next = 0;
        exit(amount);

    end;

    procedure CalcGroupedQuantity(var receiptDate: Date; endDate: Date; itemNo: Text): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter("Transfer-to Code", 'CNG MLP');
        trLine.SetFilter(Correction, '%1', false);
        if trLine.FindSet() then
            repeat
                amount += trLine.Quantity;
            until trLine.Next = 0;
        exit(amount);
    end;



    procedure CalcTotalQuantity(var receiptDate: Date; endDate: Date): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Transfer-to Code", 'CNG MLP');
        trLine.SetFilter(Correction, '%1', false);
        if trLine.FindSet() then
            repeat
                amount += trLine.Quantity;
            until trLine.Next = 0;
        exit(amount);
    end;

    procedure countDistinct(var receiptDate: Date; endDate: Date; itemNo: Text; sel: Text): Integer;
    var
        trLine: Record "Transfer Receipt Line";
        cnt: Integer;
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter("Transfer-to Code", 'CNG MLP');
        trLine.SetFilter(Correction, '%1', false);
        if trLine.FindSet() then
            repeat
                cnt += 1;
            until trLine.Next = 0;
        if sel <> 'Summary' then exit(1) else exit(cnt);
    end;

    procedure CalcGroupedSellPrice(var receiptDate: Date; endDate: Date; itemNo: Text): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter("Transfer-to Code", 'CNG MLP');
        trLine.SetFilter(Correction, '%1', false);

        if trLine.FindSet() then
            repeat
                CurrentVE.Reset();
                CurrentVE.SETRANGE("Document No.", trLine."Document No.");
                CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                CurrentVE.SETRANGE("Document Line No.", trLine."Line No.");
                CurrentVE.SETRANGE("Location Code", trLine."Transfer-to Code");
                IF CurrentVE.FINDFIRST THEN BEGIN
                    REPEAT
                        amount += CurrentVE."Cost Amount (Actual)" * CurrentVE."Invoiced Quantity";
                    //   amountWithVAT += amount * (1 + (CurrentVE."Retail VAT" / 100));
                    UNTIL CurrentVE.NEXT = 0;
                END;
            until trLine.Next = 0;
        exit(amount);
    end;

    procedure CalcGroupedPriceWithVat(var receiptDate: Date; endDate: Date; itemNo: Text; Loc: Code[20]): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        amount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter(Correction, '%1', false);
        trLine.SetFilter("Transfer-to Code", '%1', Loc);
        if trLine.FindSet() then
            repeat
                CurrentVE.Reset();
                CurrentVE.SETRANGE("Document No.", trLine."Document No.");
                CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                CurrentVE.SETRANGE("Document Line No.", trLine."Line No.");
                CurrentVE.SETRANGE("Location Code", trLine."Transfer-to Code");
                IF CurrentVE.FINDFIRST THEN BEGIN
                    REPEAT
                        amount += CurrentVE."T.Retail Unit Price with VAT";
                    UNTIL CurrentVE.NEXT = 0;
                END;
            until trLine.Next = 0;
        exit(amount);
    end;

    procedure CalcGroupedRUC(var receiptDate: Date; endDate: Date; itemNo: Text; Loc: Code[20]): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        RUCamount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter(Correction, '%1', false);
        trLine.Setfilter("Transfer-to Code", '%1', Loc);
        if trLine.FindSet() then
            repeat
                CurrentVE.Reset();
                CurrentVE.SETRANGE("Document No.", trLine."Document No.");
                CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                CurrentVE.SETRANGE("Document Line No.", trLine."Line No.");
                CurrentVE.SETRANGE("Location Code", trLine."Transfer-to Code");
                IF CurrentVE.FINDFIRST THEN BEGIN
                    REPEAT
                        RUCamount += CurrentVE."Retail RUC";
                    UNTIL CurrentVE.NEXT = 0;
                END;
            until trLine.Next = 0;
        exit(RUCamount);
    end;

    procedure CalcGroupedPriceDiffernece(var receiptDate: Date; endDate: Date; itemNo: Text; Loc: Code[20]): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        PriceDiff: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter(Correction, '%1', false);
        trLine.Setfilter("Transfer-to Code", '%1', Loc);
        if trLine.FindSet() then
            repeat
                CurrentVE.Reset();
                CurrentVE.SETRANGE("Document No.", trLine."Document No.");
                CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                CurrentVE.SETRANGE("Document Line No.", trLine."Line No.");
                CurrentVE.SETRANGE("Location Code", trLine."Transfer-to Code");
                IF CurrentVE.FINDFIRST THEN BEGIN
                    REPEAT
                        IF (CurrentVE."Cost per Unit" * CurrentVE."Valued Quantity") <> 0 then
                            PriceDiff := ((CurrentVE."Total Retail Amount" - (CurrentVE."Cost per Unit" * CurrentVE."Valued Quantity")) / (CurrentVE."Cost per Unit" * CurrentVE."Valued Quantity")) * 100;
                        ;
                    UNTIL CurrentVE.NEXT = 0;
                END;
            until trLine.Next = 0;
        exit(PriceDiff);
    end;

    procedure CalcGroupedVAT(var receiptDate: Date; endDate: Date; itemNo: Text; Loc: Code[20]): Decimal;
    var
        trLine: Record "Transfer Receipt Line";
        VATamount: Decimal;
        CurrentVE: Record "Value Entry";
    begin
        trLine.SetRange("Receipt Date", receiptDate, endDate);
        trLine.SetFilter("Item No.", itemNo);
        trLine.SetFilter(Correction, '%1', false);
        trLine.Setfilter("Transfer-to Code", '%1', Loc);
        if trLine.FindSet() then
            repeat
                CurrentVE.Reset();
                CurrentVE.SETRANGE("Document No.", trLine."Document No.");
                CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                CurrentVE.SETRANGE("Document Line No.", trLine."Line No.");
                CurrentVE.SETRANGE("Location Code", trLine."Transfer-to Code");
                IF CurrentVE.FINDFIRST THEN BEGIN
                    REPEAT
                        VATamount += CurrentVE."T.Retail Unit Price with VAT" - CurrentVE."Total Retail Amount";
                    UNTIL CurrentVE.NEXT = 0;
                END;
            until trLine.Next = 0;
        exit(VATamount);
    end;

    procedure GenerateCalculationNumber(var recDate: Date): Text;
    var
        trLine: Record "Transfer Receipt Line";
        Gener: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        controlTrLine: Record "Transfer Receipt Line";
        number: Text;
    begin
        Gener.Get();
        controlTrLine.SetFilter("Receipt Date", '%1', recDate);
        controlTrLine.SetFilter("Transfer-to Code", '%1', 'CNG MLP');
        controlTrLine.SetFilter(Correction, '%1', false);
        if controlTrLine.FindFirst() then begin
            if controlTrLine."Group Calculation Number" = '' then begin
                number := NoSeriesMgt.GetNextNo(Gener."Group Retail Calculation Entry Series", TODAY, true);
                trLine.SetFilter("Receipt Date", '%1', recDate);
                trLine.SetFilter("Transfer-to Code", '%1', 'CNG MLP');
                trLine.SetFilter(Correction, '%1', false);

                if trLine.FindSet() then
                    repeat
                        if trLine."Group Calculation Number" = '' then begin
                            trLine."Group Calculation Number" := number;
                            trLine.Modify();
                        end;
                    until trLine.Next = 0;

            end else begin
                number := controlTrLine."Group Calculation Number";
            end;
        end;

        exit(number);

    end;
}

