/*report 50212 "Inventory - Trans. Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InventoryTransactionDetail.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Inventory - Transaction Detail Prices';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", Description, "Assembly BOM", "Inventory Posting Group", "Shelf No.", "Statistics Group", "Date Filter";
            column(PeriodItemDateFilter; StrSubstNo(Text000, ItemDateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(TableCaptionItemFilter; StrSubstNo('%1: %2', TableCaption, ItemFilter))
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(InventoryTransDetailCaption; InventoryTransDetailCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(ItemLedgEntryPostDateCaption; ItemLedgEntryPostDateCaptionLbl)
            {
            }
            column(ItemLedgEntryEntryTypCaption; ItemLedgEntryEntryTypCaptionLbl)
            {
            }
            column(IncreasesQtyCaption; IncreasesQtyCaptionLbl)
            {
            }
            column(DecreasesQtyCaption; DecreasesQtyCaptionLbl)
            {
            }
            column(ItemOnHandCaption; ItemOnHandCaptionLbl)
            {
            }
            column(UnitCostCaption; UnitCostCaption)
            {
            }
            column(LastDirectCostCaption; LastDirectCostCaption)
            {
            }
            column(CostAmountActualCaption; CostAmountActualCaption)
            {

            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(Description_Item; Item.Description)
                {
                }
                column(StartOnHand; StartOnHand)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(RecordNo; RecordNo)
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Posting Date" = FIELD("Date Filter"), "Location Code" = FIELD("Location Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                    DataItemLinkReference = Item;
                    DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    column(StartOnHandQuantity; StartOnHand + Quantity)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(PostingDate_ItemLedgEntry; Format("Posting Date"))
                    {
                    }
                    column(EntryType_ItemLedgEntry; "Entry Type")
                    {
                    }
                    column(DocumentNo_PItemLedgEntry; "Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_ItemLedgEntry; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(IncreasesQty; IncreasesQty)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(DecreasesQty; DecreasesQty)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(ItemOnHand; ItemOnHand)
                    {
                        DecimalPlaces = 0 : 2;

                    }
                    column(EntryNo_ItemLedgerEntry; "Entry No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity_ItemLedgerEntry; Quantity)
                    {
                    }
                    column(ItemDescriptionControl32; Item.Description)
                    {
                    }
                    column(ContinuedCaption; ContinuedCaptionLbl)
                    {
                    }
                    column(UnitCost; UnitCost)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(LastDirectCost; LastDirectCost)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(CostAmountActual; CostAmountActual)
                    {

                    }
                    column(Amount; Amount)
                    {

                    }


                    trigger OnAfterGetRecord()
                    begin
                        //UnitCost := 0;
                        //LastDirectCost := 0;
                        //UCost := 0;
                        // QuantityE := 0;
                        // CostAmountActual := 0;
                        // LastPostingDate := 0D;

                        // ItemNo := "Item No.";
                        // PostingDate := "Posting Date";
                        //Quantity1 := "Invoiced Quantity";

                        CurrentItemCode := "Item No.";


                        ItemOnHand := ROUND(ItemOnHand + Quantity, 0.01, '=');
                        Clear(IncreasesQty);
                        Clear(DecreasesQty);
                        if Quantity > 0 then
                            IncreasesQty := ROUND(Quantity, 0.01, '=')
                        else
                            DecreasesQty := ROUND(Abs(Quantity), 0.01, '=');

                        /* ko radi nešto
                                                VE.Reset();
                                                VE.SetFilter("Item Ledger Entry No.", '%1', "Item Ledger Entry"."Entry No.");
                                                VE.SetFilter("Valued Quantity", '%1', "Item Ledger Entry"."Quantity");
                                                if VE.FindFirst() then begin
                                                    repeat
                                                        Amount := VE."Cost Amount (Actual)";
                                                        LastDirectCost := VE."Cost per Unit";
                                                    until VE.Next() = 0;
                                                end;

                                                if PostingDate <> LastPostingDate then begin
                                                    if QuantityE <> 0 then begin
                                                        UnitCost := ROUND(CostAmountActual / QuantityE, 0.01, '=');
                                                    end;
                                                    QuantityE := Quantity1;
                                                    CostAmountActual := Amount;
                                                    LastPostingDate := PostingDate;
                                                end else begin
                                                    QuantityE := QuantityE + Quantity1;
                                                    CostAmountActual := CostAmountActual + Amount;
                                                end;
                                            end;*/
/*
                        VE.Reset();
                        VE.SetFilter("Item Ledger Entry No.", '%1', "Item Ledger Entry"."Entry No.");
                        VE.SetFilter("Valued Quantity", '%1', "Item Ledger Entry"."Quantity");
                        if VE.FindFirst() then begin
                            repeat
                                Amount := VE."Cost Amount (Actual)";
                                LastDirectCost := VE."Cost per Unit";
                            until VE.Next() = 0;
                        end;

                        CurrentItemCode := "Item No.";
                        CurrentPostingDate := "Posting Date";
                        if CurrentItemCode <> PreviousItemCode then begin
                            CumulativeTotalCost := 0;
                            CumulativeTotalQuantity := 0;
                        end;

                        LastDirectCost := VE."Cost per Unit";
                        Quantity1 := "Invoiced Quantity";
                        Amount := LastDirectCost * Quantity1;

                        CumulativeTotalCost := CumulativeTotalCost + LastDirectCost;
                        CumulativeTotalQuantity := CumulativeTotalQuantity + Quantity1;

                        if CumulativeTotalQuantity > 0 then
                            UnitCost := ROUND(CumulativeTotalCost / CumulativeTotalQuantity, 0.01, '=')
                        else
                            UnitCost := 0;

                        PreviousItemCode := CurrentItemCode;




                    end;


                    trigger OnPreDataItem()
                    begin
                        Clear(Quantity);
                        Clear(IncreasesQty);
                        Clear(DecreasesQty);
                        //EK
                        /* QuantityE := 0;
                         CostAmountActual := 0;
                         LastPostingDate := 0D;*/

/*   CumulativeTotalCost := 0;
   CumulativeTotalQuantity := 0;
   //PreviousItemCode := '';
   PreviousCostPerUnit := 0;

end;
}
}
/* trigger OnPostDataItem()
begin
if QuantityE <> 0 then begin
UnitCost := ROUND(CostAmountActual / QuantityE, 0.01, '=');

end
end;

trigger OnAfterGetRecord()
begin
StartOnHand := 0;
if ItemDateFilter <> '' then
if GetRangeMin("Date Filter") > 00000101D then begin
   SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
   CalcFields("Net Change");
   StartOnHand := "Net Change";
   SetFilter("Date Filter", ItemDateFilter);
end;
ItemOnHand := ROUND(StartOnHand, 0.01, '=');

if PrintOnlyOnePerPage then
RecordNo := RecordNo + 1;

end;

trigger OnPreDataItem()
begin
RecordNo := 1;
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
field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
{
   ApplicationArea = Basic, Suite;
   Caption = 'New Page per Item';
   ToolTip = 'Specifies if you want each item transaction detail to be printed on a separate page.';
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
ItemFilter := Item.GetFilters;
ItemDateFilter := Item.GetFilter("Date Filter");
end;

var
Text000: Label 'Period: %1';
ItemFilter: Text;
ItemDateFilter: Text[30];
ItemOnHand: Decimal;
StartOnHand: Decimal;
IncreasesQty: Decimal;
DecreasesQty: Decimal;
PrintOnlyOnePerPage: Boolean;
RecordNo: Integer;
InventoryTransDetailCaptionLbl: Label 'Inventory - Transaction Detail';
CurrReportPageNoCaptionLbl: Label 'Page';
ItemLedgEntryPostDateCaptionLbl: Label 'Posting Date';
ItemLedgEntryEntryTypCaptionLbl: Label 'Entry Type';
IncreasesQtyCaptionLbl: Label 'Increases';
DecreasesQtyCaptionLbl: Label 'Decreases';
ItemOnHandCaptionLbl: Label 'Inventory';
ContinuedCaptionLbl: Label 'Continued';
UnitCostCaption: Label 'Unit cost';
LastDirectCostCaption: Label 'Total amount';
UnitCost: Decimal;
LastDirectCost: Decimal;
VE: Record "Value Entry";
QuantityE: Decimal;

UCost: Decimal;
CostAmountActualCaption: Label 'Quantity';

ItemLedg: Record "Item Ledger Entry";
CostAmountActual: Decimal;
LastPostingDate: Date;
ItemNo: Code[20];
PostingDate: Date;
Quantity1: Decimal;
Amount: Decimal;

CumulativeTotalCost: Decimal;
CumulativeTotalQuantity: Decimal;
AverageCost: Decimal;
PreviousItemCode: Code[20];
CurrentItemCode: Code[20];
CurrentPostingDate: Date;
PreviousCostPerUnit: Decimal;



procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean)
begin
PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
end;
}*/
