/*report 50019 "RUC calculation"
{
    // //

    Caption = 'Inventory - Sales Statistics';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem8129; "Item")
        {
            DataItemTableView = SORTING("Inventory Posting Group");
            RequestFilterFields = "No.", "Search Description", "Assembly BOM", "Inventory Posting Group", "Statistics Group", "Base Unit of Measure", "Date Filter";
            column(PeriodTextCaption; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintAlsoWithoutSale; PrintAlsoWithoutSale)
            {
            }
            column(ItemFilterCaption; STRSUBSTNO('%1: %2', TABLECAPTION, ItemFilter))
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(InventoryPostingGrp_Item; "Inventory Posting Group")
            {
            }
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Description)
            {
                IncludeCaption = true;
            }
            column(AssemblyBOM_Item; FORMAT("Assembly BOM"))
            {
            }
            column(BaseUnitofMeasure_Item; "Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            column(UnitCost; UnitCost)
            {
            }
            column(UnitPrice; UnitPrice)
            {
            }
            column(SalesQty; SalesQty)
            {
            }
            column(SalesAmount; SalesAmount)
            {
            }
            column(ItemProfit; ItemProfit)
            {
                AutoFormatType = 1;
            }
            column(ItemProfitPct; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(InvSalesStatisticsCapt; InvSalesStatisticsCaptLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(IncludeNotSoldItemsCaption; IncludeNotSoldItemsCaptionLbl)
            {
            }
            column(ItemAssemblyBOMCaption; ItemAssemblyBOMCaptionLbl)
            {
            }
            column(UnitCostCaption; UnitCostCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(SalesQtyCaption; SalesQtyCaptionLbl)
            {
            }
            column(SalesAmountCaption; SalesAmountCaptionLbl)
            {
            }
            column(ItemProfitCaption; ItemProfitCaptionLbl)
            {
            }
            column(ItemProfitPctCaption; ItemProfitPctCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Assembly BOM");

                SetFilters;
                Calculate;

                IF (SalesAmount = 0) AND NOT PrintAlsoWithoutSale THEN
                    CurrReport.SKIP;

                ItemCategoryProfit.SETFILTER(Code, '%1', "Item Category Code");
                IF ItemCategoryProfit.FINDFIRST THEN BEGIN
                    IF ItemCategoryProfit."Min. Item Profiit" <> 0 THEN BEGIN
                        //MESSAGE(FORMAT(ItemProfitPct)+' '+FORMAT(SalesAmount)+' '+FORMAT(COGSAmount)+' '+FORMAT(SalesQty));
                        IF ItemProfitPct < ItemCategoryProfit."Min. Item Profiit" THEN ERROR(RUCText);
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(SalesQty, SalesAmount, COGSAmount, ItemProfit);
                SETFILTER("No.", '%1', ItemFilter);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintAlsoWithoutSale; PrintAlsoWithoutSale)
                    {
                        Caption = 'Include Items Not Sold';
                        MultiLine = true;
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

    trigger OnPreReport()
    begin
        GLSetup.GET;

        ItemFilter := NoItem;
        PeriodText := FORMAT(RUCDate);

        WITH ItemStatisticsBuf DO BEGIN
            IF DataItem8129.GETFILTER("Date Filter") <> '' THEN
                SETFILTER("Date Filter", PeriodText);
            IF DataItem8129.GETFILTER("Location Filter") <> '' THEN
                SETFILTER("Location Filter", DataItem8129.GETFILTER("Location Filter"));
            IF DataItem8129.GETFILTER("Variant Filter") <> '' THEN
                SETFILTER("Variant Filter", DataItem8129.GETFILTER("Variant Filter"));
            IF DataItem8129.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                SETFILTER("Global Dimension 1 Filter", DataItem8129.GETFILTER("Global Dimension 1 Filter"));
            IF DataItem8129.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                SETFILTER("Global Dimension 2 Filter", DataItem8129.GETFILTER("Global Dimension 2 Filter"));
        END;
    end;

    var
        Text000: Label 'Period: %1';
        ItemStatisticsBuf: Record "Item Statistics Buffer";
        GLSetup: Record "General Ledger Setup";
        ItemFilter: Text;
        PeriodText: Text[30];
        SalesQty: Decimal;
        SalesAmount: Decimal;
        COGSAmount: Decimal;
        ItemProfit: Decimal;
        ItemProfitPct: Decimal;
        UnitPrice: Decimal;
        UnitCost: Decimal;
        PrintAlsoWithoutSale: Boolean;
        InvSalesStatisticsCaptLbl: Label 'Inventory - Sales Statistics';
        PageCaptionLbl: Label 'Page';
        IncludeNotSoldItemsCaptionLbl: Label 'This report also includes items that are not sold.';
        ItemAssemblyBOMCaptionLbl: Label 'BOM';
        UnitCostCaptionLbl: Label 'Unit Cost';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesQtyCaptionLbl: Label 'Sales (Qty.)';
        SalesAmountCaptionLbl: Label 'Sales (LCY)';
        ItemProfitCaptionLbl: Label 'Profit';
        ItemProfitPctCaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';
        NoItem: Code[30];
        RUCDate: Date;
        QtyCalc: Decimal;
        SalesAmountCalc: Decimal;
        CostamountCalc: Decimal;
        RUCText: Label 'You cant sell item bellow defined Item Profit!';
        ItemCategoryProfit: Record "Item Category";

    local procedure Calculate()
    begin
        SalesQty := -CalcInvoicedQty;
        SalesAmount := CalcSalesAmount;
        COGSAmount := CalcCostAmount + CalcCostAmountNonInvnt;
        ItemProfit := SalesAmount + COGSAmount;


        IF SalesAmount <> 0 THEN
            ItemProfitPct := ROUND(100 * ItemProfit / SalesAmount, 0.1)
        ELSE
            ItemProfitPct := 0;

        UnitPrice := CalcPerUnit(SalesAmount, SalesQty);
        UnitCost := -CalcPerUnit(COGSAmount, SalesQty);
    end;

    local procedure SetFilters()
    begin
        WITH ItemStatisticsBuf DO BEGIN
            SETRANGE("Item Filter", DataItem8129."No.");
            SETRANGE("Item Ledger Entry Type Filter", "Item Ledger Entry Type Filter"::Sale);
            SETFILTER("Entry Type Filter", '<>%1', "Entry Type Filter"::Revaluation);
        END;
    end;

    local procedure CalcSalesAmount(): Decimal
    begin
        WITH ItemStatisticsBuf DO BEGIN
            CALCFIELDS("Sales Amount (Actual)");
            EXIT("Sales Amount (Actual)" + SalesAmountCalc);
        END;
    end;

    local procedure CalcCostAmount(): Decimal
    begin
        WITH ItemStatisticsBuf DO BEGIN
            CALCFIELDS("Cost Amount (Actual)");
            EXIT("Cost Amount (Actual)" - CostamountCalc);
        END;
    end;

    local procedure CalcCostAmountNonInvnt(): Decimal
    begin
        WITH ItemStatisticsBuf DO BEGIN
            SETRANGE("Item Ledger Entry Type Filter");
            CALCFIELDS("Cost Amount (Non-Invtbl.)");
            EXIT("Cost Amount (Non-Invtbl.)");
        END;
    end;

    local procedure CalcInvoicedQty(): Decimal
    begin
        WITH ItemStatisticsBuf DO BEGIN
            SETRANGE("Entry Type Filter");
            CALCFIELDS("Invoiced Quantity");
            EXIT("Invoiced Quantity" - QtyCalc);
        END;
    end;

    local procedure CalcPerUnit(Amount: Decimal; Qty: Decimal): Decimal
    begin
        IF Qty <> 0 THEN
            EXIT(ROUND(Amount / ABS(Qty), GLSetup."Unit-Amount Rounding Precision"));
        EXIT(0);
    end;

    procedure Setparam(ItemNo: Code[30]; CalcDate: Date; Qty: Decimal; Cost: Decimal; SalesAmount: Decimal)
    begin
        NoItem := ItemNo;
        RUCDate := CalcDate;
        QtyCalc := Qty;
        SalesAmountCalc := SalesAmount;
        CostamountCalc := Cost;
    end;
}

*/