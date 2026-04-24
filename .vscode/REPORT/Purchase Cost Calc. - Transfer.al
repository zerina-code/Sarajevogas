report 50023 "Purchase Cost Calc. - Transfer"
{
    // BH1.00, Cost Calculation
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase Cost Calc. - Transfer.rdl';

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
            column(PostedNos; PostedNos)
            {
            }
            column(TransHeaderNo; "No.")
            {
                IncludeCaption = true;
            }
            column(TransHeaderOrderNo; "Transfer Order No.")
            {
                IncludeCaption = true;
            }
            column(TransHeaderPostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(TransHeaderName; "Transfer-from Code" + ' ' + "Transfer-from Name")
            {
            }
            column(TransferFromCaption; TransferFromCaption)
            {
            }
            column(CalculatedByLabel; CalculatedByLabel)
            {
            }
            column(ControledByLabel; ControledByLabel)
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
                column(TransferLineToLocationCode; "Transfer-to Code")
                {
                    IncludeCaption = true;
                }
                column(DescriptionCaption; DescriptionCaption)
                {
                }
                column(QuantityCaption; DataItem2.FIELDCAPTION(Quantity))
                {
                }
                column(UoMCaption; DataItem2.FIELDCAPTION("Unit of Measure"))
                {
                }
                column(UnitPriceCaption; UnitPriceCaption)
                {
                }
                column(InvoicedCaption; InvoicedCaption)
                {
                }
                column(CostsCaption; CostsCaption)
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

                trigger OnAfterGetRecord()
                var
                    CurrentVE: Record "Value Entry";
                begin
                    IF "Quantity (Base)" = 0 THEN CurrReport.SKIP;

                    //find value entry, go sequential by "entry no." because no key created
                    IF RECORDLEVELLOCKING THEN
                        CurrentVE.SETCURRENTKEY("Item Ledger Entry No.", "Document No.", "Document Line No.")
                    ELSE
                        CurrentVE.SETCURRENTKEY("Document No.");


                    CurrentInvoicedQty := "Quantity (Base)";
                    CurrentInvoicedCost := 0;
                    CurrentInvoicedPrice := 0;

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
            begin
                PostedNos := "No.";
                CLEAR(AdditionalCostVE);
                AdditionalCostVE.DELETEALL;
                Location.GET("Transfer-to Code");
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
        BuyFromVendor: Record "Vendor";
        PayToVendor: Record "Vendor";
        CurrentILE: Record "Item Ledger Entry";
        CurrentInvoicedQty: Decimal;
        CurrentInvoicedPrice: Decimal;
        CurrentInvoicedCost: Decimal;
        CurrentDirectCostActual: Decimal;
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
        DescriptionCaption: Label 'Item description';
        UnitPriceCaption: Label 'Unit price';
        InvoicedCaption: Label 'Invoiced amount';
        CostsCaption: Label 'Costs';
        PurchPriceCaption: Label 'Purch. price';
        TotalCostCaption: Label 'Total cost';
        TotalForInvoiceCaption: Label 'Total for invoice:';
        ItemChargesCaption: Label 'Additional Costs';
        CalculatedByLabel: Label 'Calculated by';
        ControledByLabel: Label 'Controlled by';
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
                IF UoM.Description <> '' THEN
                    EXIT(UoM.Description)
                ELSE
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
}

