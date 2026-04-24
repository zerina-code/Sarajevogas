report 50127 "Inventory - Transaction Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransactionDetail.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Inventory - Transaction Card';
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

            column(Picture; CompInfo.Picture)
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
            column(SelectedReport; SelectedReport)
            {
            }
            column(InventoryListCaptionLbl; InventoryListCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaption)
            {
            }
            column(AmountCaption; AmountCaption)
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
                    DecimalPlaces = 0 : 5;
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
                        DecimalPlaces = 0 : 5;
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

                    column(CustVend; CustVend)
                    {



                    }
                    column(IncreasesQty; IncreasesQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(DecreasesQty; DecreasesQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(ItemOnHand; ItemOnHand)
                    {
                        DecimalPlaces = 0 : 5;
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
                    column(PurchasePrice; PurchasePrice)
                    {
                    }
                    column(PurchasePricelbl; PurchasePricelbl)
                    {
                    }
                    column(Sales; Sales)
                    {
                    }

                    column(SalesPricelbl; SalesPricelbl)
                    {
                    }
                    column(UOM; UOM)
                    {
                    }

                    column(UOMlbl; UOMlbl)
                    {
                    }
                    column(VATlbl; VATlbl)
                    {
                    }
                    column(VAT; VAT)
                    {
                    }

                    column(VATbaselbl; VATbaselbl)
                    {
                    }
                    column(VATbase; VATbase)
                    {
                    }
                    column(SalesMargin; SalesMargin)
                    {
                    }

                    column(SalesMarginlbl; SalesMarginlbl)
                    {
                    }
                    column(Comitent; Comitent)
                    {
                    }
                    column(LocationFilter; LocationFilter)
                    {
                    }
                    column(Locationlbl; Locationlbl)
                    {
                    }
                    column(LocationName; LocationName)
                    {
                    }
                    column(LocCode; "Location Code") { }
                    column(Item_No_; "Item No.") { }
                    column(Qty; Quantity) { }
                    column(UnitCost; UnitCost) { }
                    column(ShowCostColumns; ShowCostColumns) { }
                    column(Ulazi; Ulazi) { }
                    column(Izlazi; Izlazi) { }
                    column(GLAccountNo; GLAccountNo) { }
                    column(CostAmount; CostAmount) { }
                    column(CostPerUnit; CostPerUnit) { }


                    trigger OnAfterGetRecord()
                    begin
                        GLAccountNo := '';
                        CostAmount := 0;
                        CostPerUnit := 0;
                        if SelectedReport = SelectedReport::inventoryTransactionCard then begin
                            //Prvobitna varijanta izvještaja: Kartica artikla
                            ItemOnHand := ItemOnHand + Quantity;
                            Clear(IncreasesQty);
                            Clear(DecreasesQty);
                            if Quantity > 0 then
                                IncreasesQty := Quantity
                            else
                                DecreasesQty := Abs(Quantity);



                            IF ("Source Type" = "Source Type"::Customer) then begin
                                Cust.SETFILTER("No.", '%1', "Source No.");
                                IF Cust.FindFirst THEN
                                    CustVend := Cust.Name
                                ELSE
                                    CustVend := '';
                            end
                            ELSE
                                IF ("Source Type" = "Source Type"::Vendor) then begin
                                    Vend.SETFILTER("No.", '%1', "Source No.");
                                    IF Vend.FindFirst THEN
                                        CustVend := Vend.Name
                                    ELSE
                                        CustVend := '';
                                end
                                ELSE
                                    IF (("Source Type" = 0) and ("Entry Type" = "Entry Type"::Transfer)) then
                                        CustVend := CompInfo.Name;

                            //saznaj Konto na koji se knjiži artikl:
                            VE.Reset();
                            VE.SetFilter("Item Ledger Entry No.", '%1', "Item Ledger Entry"."Entry No.");
                            VE.SetFilter("Invoiced Quantity", '<>%1', 0);
                            if VE.FindFirst() then begin
                                GLILR.Reset();
                                GLILR.SetFilter("Value Entry No.", '%1', VE."Entry No.");
                                if GLILR.FindFirst() then begin
                                    GLE.Reset();
                                    GLE.SetFilter("Entry No.", '%1', GLILR."G/L Entry No.");
                                    if GLE.FindFirst() then begin
                                        GLAccountNo := GLE."G/L Account No.";
                                    end;
                                end;
                            end;

                            VE.Reset();
                            VE.SetFilter("Item Ledger Entry No.", '%1', "Item Ledger Entry"."Entry No.");
                            VE.SetFilter("Valued Quantity", '%1', "Item Ledger Entry"."Quantity");
                            if VE.FindFirst() then begin
                                CostAmount := VE."Cost Amount (Actual)";
                                CostPerUnit := VE."Cost per Unit";
                            end
                            else begin
                                CostAmount := 0;
                                CostPerUnit := 0;
                            end;


                        end else
                            if SelectedReport = SelectedReport::inventoryList then begin
                                //Novododata varijanta izvještaja: Lager lista
                                Item.GET("Item No.");

                                ItemLedg.RESET;
                                ItemLedg.COPYFILTERS("Item Ledger Entry");
                                ItemLedg.SETFILTER("Item No.", '%1', "Item Ledger Entry"."Item No.");
                                if StartDateFilter <> 0D then
                                    ItemLedg.SetFilter("Posting Date", '%1..%2', StartDateFilter, EndDateFilter);
                                IF ItemLedg.FINDFIRST THEN BEGIN
                                    ItemLedg.CALCSUMS(Quantity);

                                END;
                                IznosTroskaStvarni := 0;
                                Kolicina := 0;
                                Ulazi := 0;
                                Izlazi := 0;

                                ItemLedg.RESET;
                                ItemLedg.COPYFILTERS("Item Ledger Entry");
                                ItemLedg.SETFILTER("Item No.", '%1', "Item Ledger Entry"."Item No.");
                                if StartDateFilter <> 0D then
                                    ItemLedg.SetFilter("Posting Date", '%1..%2', StartDateFilter, EndDateFilter);
                                IF ItemLedg.FINDSET THEN
                                    REPEAT
                                        ItemLedg.CALCFIELDS("Cost Amount (Actual)");
                                        IznosTroskaStvarni += ItemLedg."Cost Amount (Actual)";
                                        Kolicina += ItemLedg.Quantity;
                                    UNTIL ItemLedg.NEXT = 0;

                                IF Kolicina <> 0 THEN BEGIN

                                    IF COPYSTR(FORMAT(IznosTroskaStvarni / Kolicina, 0, '<Decimals,6>'), STRLEN(FORMAT(IznosTroskaStvarni / Kolicina, 0, '<Decimals,6>')), 1) <> '0' THEN
                                        UnitCost := ROUND(IznosTroskaStvarni / Kolicina, 0.00001, '=')
                                    ELSE
                                        UnitCost := IznosTroskaStvarni / Kolicina;
                                    // UnitCost:=Item."Unit Cost";
                                END
                                ELSE BEGIN
                                    UnitCost := 0;
                                END;

                                //Saznaj vrijednosti Ulazi i Izlazi na nivou artikla i šifre lokacije:
                                ItemLedg.RESET;
                                ItemLedg.COPYFILTERS("Item Ledger Entry");
                                ItemLedg.SETFILTER("Item No.", '%1', "Item Ledger Entry"."Item No.");
                                ItemLedg.SetFilter("Location Code", '%1', "Item Ledger Entry"."Location Code");
                                if StartDateFilter <> 0D then
                                    ItemLedg.SetFilter("Posting Date", '%1..%2', StartDateFilter, EndDateFilter);
                                IF ItemLedg.FINDSET THEN
                                    REPEAT
                                        if ItemLedg.Quantity > 0 then
                                            Ulazi += ItemLedg.Quantity
                                        else
                                            Izlazi += ItemLedg.Quantity;
                                    UNTIL ItemLedg.NEXT = 0;
                            end;
                    end;

                    trigger OnPreDataItem()
                    var
                        ItemLedgEntry: Record "Item Ledger Entry";
                    begin
                        if SelectedReport = SelectedReport::inventoryTransactionCard then begin
                            Clear(Quantity);
                            Clear(IncreasesQty);
                            Clear(DecreasesQty);
                        end else
                            if SelectedReport = SelectedReport::inventoryList then begin
                                ItemLedgEntry.Reset();
                                ItemLedgEntry.SetRange("Item No.", Item."No.");
                                if StartDateFilter <> 0D then
                                    ItemLedgEntry.SetFilter("Posting Date", '%1..%2', StartDateFilter, EndDateFilter);
                                if not ItemLedgEntry.FindFirst() then
                                    CurrReport.SKIP;
                            end;
                    end;

                }
            }


            trigger OnAfterGetRecord()
            var
                US: Record "User Setup";
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);

                if SelectedReport = SelectedReport::inventoryTransactionCard then begin

                    StartOnHand := 0;
                    if ItemDateFilter <> '' then
                        if GetRangeMin("Date Filter") > 00000101D then begin
                            SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                            CalcFields("Net Change");
                            StartOnHand := "Net Change";
                            SetFilter("Date Filter", ItemDateFilter);
                        end;
                    ItemOnHand := StartOnHand;

                    if PrintOnlyOnePerPage then
                        RecordNo := RecordNo + 1;

                    SalesPrice.SETFILTER("Item No.", '%1', "No.");
                    IF SalesPrice.FIndfirst then begin
                        PurchasePrice := SalesPrice."Purchase Unit Price";
                        UOM := SalesPrice."Unit of Measure Code";
                        IF (Location.GET(LocationFilter)) then begin



                            IF Location."CNG MP" then
                                Sales := SalesPrice."Retail Unit Price";

                            IF Location."CNG VP" then
                                Sales := SalesPrice."Wholesale Unit Price";



                            VATPostingSetup.Get('K-17-PDV', 'PDV17');
                            VAT := (Sales * VATPostingSetup."VAT %") / 100;
                            VATBase := Sales - VAT;
                            //n
                            LocationName := Location.Name;
                        end
                        ELSE
                            Sales := SalesPrice."Unit Price";

                        SalesMargin := Sales - PurchasePrice;
                    end
                    ELSE begin
                        PurchasePrice := 0;
                        UOM := '';
                        Sales := 0;
                        SalesMargin := 0;

                    end;
                end else
                    if SelectedReport = SelectedReport::inventoryList then begin
                        //
                    end;
            end;


            trigger OnPreDataItem()
            begin
                if (SelectedReport = SelectedReport::inventoryTransactionCard) AND (Item.GetFilter("No.") = '') then begin
                    Message(MsgWhenItemIsNotSelectedLbl);
                    CurrReport.BREAK;
                end;
                RecordNo := 1;
                if ItemDateFilter <> '' then begin
                    StartDateFilter := GetRangeMin("Date Filter");
                    EndDateFilter := GetRangeMax("Date Filter");
                end;
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
                group("SelectReport")
                {
                    Caption = 'Select a report';
                    field(SelectedReport; SelectedReport)
                    {
                        Caption = 'Select';
                        OptionCaption = 'Inventory - Transaction Card,Inventory List';
                    }
                }

                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Item';
                        ToolTip = 'Specifies if you want each item transaction detail to be printed on a separate page.';
                    }
                    field(ShowCostColumns; ShowCostColumns)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show costs columns in Inventory List report';
                        ToolTip = 'Specifies if you want to show costs columns  in Inventory List report.';
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
        LocationFilter := Item.GetFilter("Location Filter");
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        Text000: Label 'Period: %1';

        CompInfo: record "Company information";
        CustVend: Text;
        Cust: Record Customer;
        Vend: Record Vendor;
        ItemFilter: Text;
        LocationFilter: Text;
        ItemDateFilter: Text[30];
        ItemOnHand: Decimal;
        StartOnHand: Decimal;
        IncreasesQty: Decimal;
        DecreasesQty: Decimal;
        PrintOnlyOnePerPage: Boolean;
        RecordNo: Integer;
        InventoryTransDetailCaptionLbl: Label 'Inventory - Transaction Card';
        CurrReportPageNoCaptionLbl: Label 'Page';
        ItemLedgEntryPostDateCaptionLbl: Label 'Posting Date';
        ItemLedgEntryEntryTypCaptionLbl: Label 'Entry Type';
        IncreasesQtyCaptionLbl: Label 'Increases';
        DecreasesQtyCaptionLbl: Label 'Decreases';
        ItemOnHandCaptionLbl: Label 'Inventory';
        ContinuedCaptionLbl: Label 'Continued';
        Comitent: Label 'Comitent';
        SalesPrice: Record "Sales Price";
        SalesPricelbl: Label 'Sales Price';
        PurchasePrice: Decimal;
        PurchasePricelbl: Label 'Purchase Price';
        SalesMargin: Decimal;
        SalesMarginlbl: Label 'Sales Margin';
        Sales: decimal;
        VAT: Decimal;
        VATlbl: Label 'VAT';
        VATAmount: Decimal;
        UOM: Text[30];
        UOMlbl: Label 'Unit of Measure';

        VATBase: Decimal;
        VATBaselbl: Label 'VAT base amount';
        Location: Record Location;
        LocationName: Text[50];
        Locationlbl: Label 'Location name';

        VATPostingSetup: Record "VAT Posting Setup";

        /* Two types of reports available here:
        inventoryTransactionCard = Inventory - Transaction Card (Kartica Artikla)
        inventoryList = Inventory - List (Lager lista) */
        SelectedReport: Option "inventoryTransactionCard","inventoryList";
        ShowCostColumns: Boolean;
        InventoryListCaptionLbl: Label 'Inventory - List';
        ItemLedg: Record "Item Ledger Entry";
        UnitCost: Decimal;
        IznosTroskaStvarni: Decimal;
        Kolicina, Ulazi, Izlazi : Decimal;
        StartDateFilter, EndDateFilter : Date;
        GLAccountNo: Code[20];
        VE: Record "Value Entry";
        GLILR: Record "G/L - Item Ledger Relation";
        GLE: Record "G/L Entry";
        MsgWhenItemIsNotSelectedLbl: Label 'You must select an Item in the "No." filter field to run this report.';
        CostAmount: Decimal;
        CostPerUnit: Decimal;
        UnitPriceCaption: Label 'Unit price';
        AmountCaption: Label 'Amount';


    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
    end;
}

