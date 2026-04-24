report 50022 "Purchase Cost Calc. - Procur."
{
    // BH1.00, Cost Calculation
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase Cost Calc. - Procur..rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.", "Location Code";
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
            column(PurchHeaderNo; "No.")
            {
                IncludeCaption = true;
            }
            column(PurchHeaderOrderNo; "Order No.")
            {
                IncludeCaption = true;
            }
            column(PurchHeaderPostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(PurchHeaderVendorInvoiceNo; "Vendor Invoice No.")
            {
                IncludeCaption = true;
            }
            column(PurchHeaderBuyFromVendorName; "Buy-from Vendor No." + ' ' + "Buy-from Vendor Name")
            {
            }
            column(PurchHeaderPayToVendorName; "Pay-to Vendor No." + ' ' + "Pay-to Name")
            {
            }
            column(PurchHeaderBuyFromAddress; "Buy-from Address")
            {
            }
            column(PurchHeaderPayToAddress; "Pay-to Address")
            {
            }
            column(PurchHeaderBuyFromCity; "Buy-from Post Code" + ' ' + "Buy-from City")
            {
            }
            column(PurchHeaderPayToCity; "Pay-to Post Code" + ' ' + "Pay-to City")
            {
            }
            column(PurchHeaderByFromVATNo; BuyFromVendor."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(PurchHeaderPayToVATNo; PayToVendor."VAT Registration No.")
            {
            }
            column(BuyFromVendorCaption; BuyFromVendorCaption)
            {
            }
            column(PayToVendorCaption; PayToVendorCaption)
            {
            }
            column(AddressCaption; AddressCaption)
            {
            }
            column(CityCaption; CityCaption)
            {
            }
            column(VATNoCaption; FIELDCAPTION("VAT Registration No."))
            {
            }
            column(PurchHeaderAmount; Amount)
            {
            }
            column(PurchHeaderCurrencyFactor; "Currency Factor")
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
            dataitem(DataItem2; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(Item),
                                          Quantity = FILTER(<> 0));
                column(PurchLineDescription; Description)
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
                column(PurchLineLocationCode; "Location Code")
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
                column(UnitPriceCaption; DataItem2.FIELDCAPTION("Direct Unit Cost"))
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
                column(TotalForInvoiceCurrencyCaption; STRSUBSTNO(Text004, DataItem1."Currency Code"))
                {
                }
                column(CurrencyUsedCaption; CurrencyUsedCaption)
                {
                }
                column(ItemChargesCaption; ItemChargesCaption)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CurrentVE: Record "Value Entry";
                begin

                    //find value entry, go sequential by "entry no." because no key created
                    IF RECORDLEVELLOCKING THEN
                        CurrentVE.SETCURRENTKEY("Item Ledger Entry No.", "Document No.", "Document Line No.")
                    ELSE
                        CurrentVE.SETCURRENTKEY("Document No.");

                    CurrentInvoicedCost := 0;
                    CurrentInvoicedQty := 0;
                    CurrentInvoicedPrice := 0;
                    CurrentDirectCostActual := 0;

                    CurrentVE.SETRANGE("Document No.", "Document No.");
                    CurrentVE.SETRANGE("Item Ledger Entry Type", CurrentVE."Item Ledger Entry Type"::Purchase);
                    CurrentVE.SETRANGE("Document Line No.", "Line No.");
                    IF CurrentVE.FINDFIRST THEN BEGIN
                        REPEAT
                            IF CurrentVE."Invoiced Quantity" <> 0 THEN BEGIN
                                CurrentInvoicedCost += CurrentVE."Cost Amount (Actual)";
                                CurrentInvoicedQty += CurrentVE."Invoiced Quantity";
                                CurrentInvoicedPrice := CurrentVE."Cost per Unit";
                                //get purchase direct cost
                                CurrentDirectCostActual += CalcDirectCost(CurrentVE);
                                InsertAdditionalCostBuffer(CurrentVE);
                                CurrentILE.GET(CurrentVE."Item Ledger Entry No.");
                                CurrentUoMText := GetBaseUoMText(CurrentILE."Item No.");
                            END;
                        UNTIL CurrentVE.NEXT = 0;
                    END
                    ELSE
                        ERROR(Text001, GETPOSITION());
                end;

                trigger OnPreDataItem()
                begin

                    IF Location.Code <> '' THEN
                        SETRANGE("Location Code", Location.Code);
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

                BuyFromVendor.GET("Buy-from Vendor No.");
                PayToVendor.GET("Pay-to Vendor No.");
                CLEAR(AdditionalCostVE);
                AdditionalCostVE.DELETEALL;
            end;

            trigger OnPreDataItem()
            var
                PurchInvHeader2: Record "Purch. Inv. Header";
                PurchInvLine2: Record "Purch. Inv. Line";
                Delimiter: Text[2];
            begin

                IF GETFILTER("Location Code") <> '' THEN BEGIN
                    Location.GET(GETFILTER("Location Code"));
                    SETRANGE("Location Code");
                END
                ELSE
                    Location.INIT;

                //collect all Nos
                PurchInvHeader2.COPY(DataItem1);
                IF PurchInvHeader2.FIND('-') THEN
                    REPEAT
                        PurchInvLine2.SETFILTER("Document No.", PurchInvHeader2."No.");
                        PurchInvLine2.SETRANGE(Type, PurchInvLine2.Type::Item);
                        PurchInvLine2.SETFILTER(Quantity, '<>0');
                        IF NOT PurchInvLine2.FIND('-') THEN
                            ERROR(Text003, PurchInvHeader2."No.");
                        PostedNos := PostedNos + Delimiter + PurchInvHeader2."No.";
                        Delimiter := ', ';
                    UNTIL PurchInvHeader2.NEXT = 0;
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
        ReportCaption: Label 'Purchase cost calculation for:';
        CounterCaption: Label 'No.';
        PageNoCaptionLbl: Label 'Page';
        DescriptionCaption: Label 'Item description';
        InvoicedCaption: Label 'Invoiced amount';
        CostsCaption: Label 'Costs';
        PurchPriceCaption: Label 'Purch. price';
        TotalCostCaption: Label 'Total cost';
        TotalForInvoiceCaption: Label 'Total for invoice:';
        CurrencyUsedCaption: Label 'Used exch. rate:';
        ItemChargesCaption: Label 'Additional Costs';
        CalculatedByLabel: Label 'Calculated by';
        ControledByLabel: Label 'Controlled by';
        BuyFromVendorCaption: Label 'Buy from - Vendor';
        PayToVendorCaption: Label 'Pay to - Vendor';
        AddressCaption: Label 'Address';
        CityCaption: Label 'City';

    procedure CalcDirectCost(var ve: Record "Value Entry"): Decimal
    var
        VE2: Record "Value Entry";
    begin
        VE2.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        VE2.SETRANGE("Item Ledger Entry No.", ve."Item Ledger Entry No.");
        VE2.SETFILTER("Entry Type", '%1|%2', ve."Entry Type"::"Direct Cost", ve."Entry Type"::Revaluation);
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

