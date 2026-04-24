report 50126 "Retail Calculation"
{
    // BH1.00, Maloprodajna kalkulacija
    DefaultLayout = RDLC;
    RDLCLayout = './Retail Calculation - BACKUP.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Transfer Receipt Header")
        {

            RequestFilterFields = "No.";
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {
            }
            column(LocationInfoNameAndAddress; locName + ', ' + locAddress)
            {
            }
            column(RetailCalculationNo; CalculationNumber)
            {
            }
            column(RetailCalculationDate; FORMAT("Posting Date", 0, '<Day,2>.<Month,2>.<Year4>'))

            {

            }
            column(ConcatedCNumber; ConcatedCNumber) { }

            column(Year; Year)
            {

            }
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
            column(TransHeaderNo; "No.")
            {
                IncludeCaption = true;
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

            column(VerifiedByLabel; VerifiedByLabel)
            {
            }
            column(ApprovedByLabel; ApprovedByLabel)
            {
            }
            column(PreparedByLabel; PreparedByLabel)
            {

            }
            column(TotalAmountWithVat; TotalAmountWithVat)
            {

            }
            column(TotalVAT; TotalVAT)
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }

            column(TotalForInvoiceCaption; TotalForInvoiceCaption)
            {
            }
            dataitem(DataItem2; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(TransLineDescription; Description)
                {
                }
                column(CurrentUoMText; CurrentUoMText)
                {
                }
                column(CurrentInvoicedQty; CurrentInvoicedQty)
                {
                }
                column(CurrentInvoicedPrice; CurrentInvoicedPrice)
                {
                }
                column(CurrentInvoicedCost; CurrentInvoicedCost)
                {
                }
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
                column(QuantityCaption; DataItem2.FIELDCAPTION(Quantity))
                {
                }
                column(UoMCaption; DataItem2.FIELDCAPTION("Unit of Measure"))
                {
                }
                column(UnitCaption; UnitCaption)
                {
                }
                column(PriceCaption; PriceCaption)
                {
                }
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
                    loc.reset();
                    loc.SetFilter(Code, '%1', "Transfer-to Code");
                    if loc.FindFirst() then begin
                        locAddress := loc.Address;
                        locName := loc.Name;
                    end;
                    //find value entry, go sequential by "entry no." because no key created
                    IF RECORDLEVELLOCKING THEN
                        CurrentVE.SETCURRENTKEY("Item Ledger Entry No.", "Document No.", "Document Line No.")
                    ELSE
                        CurrentVE.SETCURRENTKEY("Document No.");
                    CurrentInvoicedQty := "Quantity (Base)";
                    CurrentInvoicedCost := 0;
                    CurrentInvoicedPrice := 0;
                    CurrentPriceDifferenceRate := 0;
                    CurrentPriceDifferenceAmount := 0;
                    CurrentUnitSellPriceWithoutVat := 0;
                    CurrentVatAmount := 0;
                    CurrentUnitSellAmountWithVat := 0;
                    CurrentSellAmountWithVat := 0;
                    CurrentRuc := 0;
                    CurrentValueSellAmountWithoutVat := 0;
                    CurrentValueSellVat := 0;
                    TotalAmount := 0;
                    TotalVAT := 0;
                    TotalAmountWithVat := 0;


                    CurrentVE.SETRANGE("Document No.", "Document No.");
                    CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Transfer);
                    CurrentVE.SETRANGE("Document Line No.", "Line No.");
                    CurrentVE.SETRANGE("Location Code", "Transfer-to Code");
                    IF CurrentVE.FINDFIRST THEN BEGIN

                        CurrentDirectCostActual := CalcDirectCost(CurrentVE);
                        CurrentUoMText := GetBaseUoMText("Item No.");
                        InsertAdditionalCostBuffer(CurrentVE);

                        REPEAT
                            CurrentInvoicedCost += CurrentVE."Cost Amount (Actual)";
                            CurrentInvoicedPrice += CurrentVE."Cost per Unit";
                            CurrentRuc += CurrentVE."Retail RUC";
                            CurrentValueSellAmountWithoutVat += CurrentVE."Retail Unit Price" * CurrentVE."Invoiced Quantity";
                            CurrentValueSellVat += (CurrentVE."Retail Unit Price with VAT" * CurrentVE."Invoiced Quantity") - CurrentValueSellAmountWithoutVat;
                            CurrentSellAmountWithVat += CurrentVE."Retail Unit Price with VAT" * CurrentVE."Invoiced Quantity";
                            CurrentUnitSellPriceWithoutVat += CurrentVE."Retail Unit Price";
                            CurrentUnitSellAmountWithVat += CurrentVE."Retail Unit Price with VAT";
                            CurrentPriceDifferenceAmount += CurrentUnitSellPriceWithoutVat - CurrentInvoicedPrice;
                            IF CurrentInvoicedCost = 0 then begin
                                CurrentPriceDifferenceRate += ((CurrentValueSellAmountWithoutVat - CurrentInvoicedCost) / CurrentInvoicedCost) * 100
                            end
                            ELSE
                                CurrentPriceDifferenceRate := 0;
                            CurrentVatAmount += CurrentUnitSellAmountWithVat - CurrentUnitSellPriceWithoutVat;
                            CurrentVatRate := ConvertDecimalToString(CurrentVE."Retail VAT") + '%';
                            TotalAmount += CurrentInvoicedCost;
                            TotalAmountWithVat += CurrentInvoicedCost * (1 + (CurrentVE."Retail VAT" / 100));
                            TotalVAT += TotalAmountWithVat - TotalAmount;
                            if CurrentVatAmount < 0 then begin
                                CurrentVatAmount := 0;
                            end;
                            if CurrentValueSellVat < 0 then begin
                                CurrentValueSellVat := 0;
                            end;
                        UNTIL CurrentVE.NEXT = 0;
                    END
                    ELSE
                        ERROR(Text001, GETPOSITION());
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(CurrentInvoicedCost, CurrentDirectCostActual);
                end;
            }
            dataitem(DataItem3; "Item Charge")
            {
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(ItemChargesDescription; Description)
                {
                }
                column(AdditionalCost; AdditionalCost)
                {
                }
                column(AdditionalInvoices; AdditionalInvoices)
                {
                }

                trigger OnAfterGetRecord()
                var
                    TempPurchInvoice: Record "Purch. Inv. Header" temporary;

                begin

                    AdditionalCostVE.SETRANGE("Item Charge No.", "No.");
                    IF AdditionalCostVE.FINDFIRST THEN BEGIN
                        REPEAT
                            AdditionalCost += AdditionalCostVE."Cost Amount (Actual)";
                            TempPurchInvoice.INIT;
                            TempPurchInvoice."No." := AdditionalCostVE."Document No.";
                            IF TempPurchInvoice.INSERT THEN;
                        UNTIL AdditionalCostVE.NEXT = 0
                    END ELSE
                        CurrReport.SKIP;

                    AdditionalInvoices := '';
                    IF TempPurchInvoice.FINDFIRST THEN
                        REPEAT
                            AdditionalInvoices += TempPurchInvoice."No." + '; ';
                        UNTIL TempPurchInvoice.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin

                    AdditionalCost := 0;
                    CurrReport.CREATETOTALS(AdditionalCost);
                end;
            }

            trigger OnAfterGetRecord()
            var
                NoSeriesMgt: Codeunit NoSeriesExtented;


            begin
                PostedNos := "No.";
                CLEAR(AdditionalCostVE);
                AdditionalCostVE.DELETEALL;
                Location.GET("Transfer-to Code");
                Year := Date2DMY("Posting Date", 3);
                if "Calculation Number" = '' then begin
                    Gener.Get();
                    if ("Transfer-to Code" = 'CNG MLP') then begin
                        CalculationNumber := NoSeriesMgt.GetNextNo(Gener."Retail Calc. Entry Series", TODAY, true);
                    end
                    ELSE begin
                        CalculationNumber := NoSeriesMgt.GetNextNo(Gener."Wholesale Calc. Entry Series", TODAY, true);
                    end;

                    "Calculation Number" := CalculationNumber;
                    DataItem1.Modify();
                end
                else begin
                    CalculationNumber := "Calculation Number";
                end;
                ConcatedCNumber := CalculationNumber + '/' + FORMAT(Year);
                if ("Transfer-to Code" = 'CNG MLP') then begin
                    TK := 'MPTK:   ( Osnovica: ';
                end
                ELSE begin
                    TK := 'VPTK:   ( Osnovica: ';
                end;
            end;

            trigger OnPreDataItem()
            var
                PurchInvHeader2: Record "Purch. Inv. Header";
                PurchInvLine2: Record "Purch. Inv. Line";
                Delimiter: Text[2];
            begin
                IF COUNT <> 1 THEN ERROR(Text005);
                CurrReport.CREATETOTALS(CurrentInvoicedCost, CurrentDirectCostActual);
                CompInfo.CALCFIELDS(Picture);

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            DataItem1.SetFilter("No.", RecNo);
        end;

    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET;
    end;

    var
        CompInfo: Record "Company Information";
        AdditionalCostVE: Record "Value Entry" temporary;
        Location: Record "Location";
        RecNo: Code[20];
        loc: Record Location;
        locName: Text;
        locAddress: Text;
        BuyFromVendor: Record "Vendor";
        TransferHeader: Record "Transfer Header";
        Gener: Record "General Ledger Setup";
        PayToVendor: Record "Vendor";
        CurrentILE: Record "Item Ledger Entry";
        CalculationNumber: Text[100];
        ConcatedCNumber: Text[100];
        TK: Text[25];
        Year: Integer;
        FilterYear: Text;
        CurrentInvoicedQty: Decimal;
        CurrentInvoicedPrice: Decimal;
        CurrentInvoicedCost: Decimal;
        CurrentPriceDifferenceRate: Decimal;
        CurrentPriceDifferenceAmount: Decimal;
        CurrentUnitSellPriceWithoutVat: Decimal;
        CurrentVatRate: Text[50];
        CurrentVatAmount: Decimal;
        CurrentSellAmountWithVat: Decimal;
        CurrentUnitSellAmountWithVat: Decimal;
        CurrentRuc: Decimal;
        CurrentValueSellAmountWithoutVat: Decimal;
        CurrentValueSellVat: Decimal;
        CurrentDirectCostActual: Decimal;

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

    procedure SetParam(No: code[20])
    begin
        "RecNo" := No;
    end;

}

