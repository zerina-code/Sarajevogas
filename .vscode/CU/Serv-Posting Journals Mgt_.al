codeunit 50010 "Serv-Posting Journals Mgt.2"
{
    Permissions = TableData 49 = imd;

    trigger OnRun()
    begin
    end;

    var
        ServiceHeader: Record "Service Header";
        GLEntry: Record "G/L Entry";
        Currency: Record "Currency";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesSetup: Record "Sales & Receivables Setup";
        TempValueEntryRelation: Record "Value Entry Relation" temporary;
        ServITRMgt: Codeunit "Serv-Item Tracking Rsrv. Mgt.";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        ServLedgEntryPostSale: Codeunit "ServLedgEntries-Post";
        TimeSheetMgt: Codeunit "Time Sheet Management";
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[20];
        SrcCode: Code[10];
        Consume: Boolean;
        Invoice: Boolean;
        ItemJnlRollRndg: Boolean;
        ServiceLinePostingDate: Date;


    procedure Initialize(var TempServHeader: Record "Service Header"; TmpConsume: Boolean; TmpInvoice: Boolean)
    var
        SrcCodeSetup: Record "Source Code Setup";
    begin
        ServiceHeader := TempServHeader;
        SetPostingOptions(TmpConsume, TmpInvoice);
        SrcCodeSetup.GET;
        SalesSetup.GET;
        SrcCode := SrcCodeSetup."Service Management";
        Currency.Initialize(ServiceHeader."Currency Code");
        ItemJnlRollRndg := FALSE;
        GenJnlLineDocNo := '';
        GenJnlLineExtDocNo := '';
    end;


    procedure Finalize()
    begin
        CLEAR(GenJnlPostLine);
        CLEAR(ResJnlPostLine);
        CLEAR(ItemJnlPostLine);
        CLEAR(ServLedgEntryPostSale);
    end;


    procedure SetPostingOptions(PassedConsume: Boolean; PassedInvoice: Boolean)
    begin
        Consume := PassedConsume;
        Invoice := PassedInvoice;
    end;


    procedure SetItemJnlRollRndg(PassedItemJnlRollRndg: Boolean)
    begin
        ItemJnlRollRndg := PassedItemJnlRollRndg;
    end;


    procedure SetGenJnlLineDocNos(DocNo: Code[20]; ExtDocNo: Code[20])
    begin
        GenJnlLineDocNo := DocNo;
        GenJnlLineExtDocNo := ExtDocNo;
    end;

    local procedure IsWarehouseShipment(ServiceLine: Record "Service Line"): Boolean
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        WITH WarehouseShipmentLine DO BEGIN
            SETRANGE("Source Type", DATABASE::"Service Line");
            SETRANGE("Source Subtype", 1);
            SETRANGE("Source No.", ServiceLine."Document No.");
            SETRANGE("Source Line No.", ServiceLine."Line No.");
            EXIT(NOT ISEMPTY);
        END;
    end;

    local procedure GetLocation(LocationCode: Code[10]; var Location: Record "Location")
    begin
        IF LocationCode = '' THEN
            Location.GetLocationSetup(LocationCode, Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;


    procedure PostItemJnlLine(var ServiceLine: Record "Service Line"; QtyToBeShipped: Decimal; QtyToBeShippedBase: Decimal; QtyToBeConsumed: Decimal; QtyToBeConsumedBase: Decimal; QtyToBeInvoiced: Decimal; QtyToBeInvoicedBase: Decimal; ItemLedgShptEntryNo: Integer; var TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecificationInv: Record "Tracking Specification"; var TempHandlingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary; var ServShptHeader: Record "Service Shipment Header"; ServShptLineDocNo: Code[20]): Integer
    var
        ItemJnlLine: Record "Item Journal Line";
        Location: Record "Location";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
        RemAmt: Decimal;
        RemDiscAmt: Decimal;
        WhsePosting: Boolean;
        CheckApplFromItemEntry: Boolean;
    begin
        CLEAR(ItemJnlPostLine);
        IF NOT ItemJnlRollRndg THEN BEGIN
            RemAmt := 0;
            RemDiscAmt := 0;
        END;

        WITH ItemJnlLine DO BEGIN
            INIT;
            CopyFromServHeader(ServiceHeader);
            CopyFromServLine(ServiceLine);

            CopyTrackingFromSpec(TrackingSpecification);

            IF QtyToBeShipped = 0 THEN BEGIN
                IF ServiceLine."Document Type" = ServiceLine."Document Type"::"Credit Memo" THEN
                    "Document Type" := "Document Type"::"Service Credit Memo"
                ELSE
                    "Document Type" := "Document Type"::"Service Invoice";
                IF QtyToBeConsumed <> 0 THEN BEGIN
                    "Entry Type" := "Entry Type"::"Negative Adjmt.";
                    "Document No." := ServShptLineDocNo;
                    "External Document No." := '';
                    "Document Type" := "Document Type"::"Service Shipment";
                END ELSE BEGIN
                    "Document No." := GenJnlLineDocNo;
                    "External Document No." := GenJnlLineExtDocNo;
                END;
                "Posting No. Series" := ServiceHeader."Posting No. Series";
            END ELSE BEGIN
                IF ServiceLine."Document Type" <> ServiceLine."Document Type"::"Credit Memo" THEN BEGIN
                    "Document Type" := "Document Type"::"Service Shipment";
                    "Document No." := ServShptHeader."No.";
                    "Posting No. Series" := ServShptHeader."No. Series";
                END;
                IF (QtyToBeInvoiced <> 0) OR (QtyToBeConsumed <> 0) THEN BEGIN
                    IF QtyToBeConsumed <> 0 THEN
                        "Entry Type" := "Entry Type"::"Negative Adjmt.";
                    "Invoice No." := GenJnlLineDocNo;
                    "External Document No." := GenJnlLineExtDocNo;
                    IF "Document No." = '' THEN BEGIN
                        IF ServiceLine."Document Type" = ServiceLine."Document Type"::"Credit Memo" THEN
                            "Document Type" := "Document Type"::"Service Credit Memo"
                        ELSE
                            "Document Type" := "Document Type"::"Service Invoice";
                        "Document No." := GenJnlLineDocNo;
                    END;
                    "Posting No. Series" := ServiceHeader."Posting No. Series";
                END;
                IF (QtyToBeConsumed <> 0) AND ("Document No." = '') THEN
                    "Document No." := ServShptLineDocNo;
            END;

            "Document Line No." := ServiceLine."Line No.";
            Quantity := -QtyToBeShipped;
            "Quantity (Base)" := -QtyToBeShippedBase;
            IF QtyToBeInvoiced <> 0 THEN BEGIN
                "Invoiced Quantity" := -QtyToBeInvoiced;
                "Invoiced Qty. (Base)" := -QtyToBeInvoicedBase;
            END ELSE
                IF QtyToBeConsumed <> 0 THEN BEGIN
                    "Invoiced Quantity" := -QtyToBeConsumed;
                    "Invoiced Qty. (Base)" := -QtyToBeConsumedBase;
                END;
            "Unit Cost" := ServiceLine."Unit Cost (LCY)";
            "Source Currency Code" := ServiceHeader."Currency Code";
            "Unit Cost (ACY)" := ServiceLine."Unit Cost";
            "Value Entry Type" := "Value Entry Type"::"Direct Cost";
            "Applies-from Entry" := ServiceLine."Appl.-from Item Entry";

            IF Invoice AND (QtyToBeInvoiced <> 0) THEN BEGIN
                Amount := -(ServiceLine.Amount * (QtyToBeInvoiced / ServiceLine."Qty. to Invoice") - RemAmt);
                IF ServiceHeader."Prices Including VAT" THEN
                    "Discount Amount" :=
                      -((ServiceLine."Line Discount Amount" + ServiceLine."Inv. Discount Amount") / (1 + ServiceLine."VAT %" / 100) *
                        (QtyToBeInvoiced / ServiceLine."Qty. to Invoice") - RemDiscAmt)
                ELSE
                    "Discount Amount" :=
                      -((ServiceLine."Line Discount Amount" + ServiceLine."Inv. Discount Amount") *
                        (QtyToBeInvoiced / ServiceLine."Qty. to Invoice") - RemDiscAmt);
            END ELSE
                IF Consume AND (QtyToBeConsumed <> 0) THEN BEGIN
                    Amount := -(ServiceLine.Amount * QtyToBeConsumed - RemAmt);
                    "Discount Amount" :=
                      -(ServiceLine."Line Discount Amount" * QtyToBeConsumed - RemDiscAmt);
                END;

            IF (QtyToBeInvoiced <> 0) OR (QtyToBeConsumed <> 0) THEN BEGIN
                RemAmt := Amount - ROUND(Amount);
                RemDiscAmt := "Discount Amount" - ROUND("Discount Amount");
                Amount := ROUND(Amount);
                "Discount Amount" := ROUND("Discount Amount");
            END ELSE BEGIN
                IF ServiceHeader."Prices Including VAT" THEN
                    Amount :=
                      -((QtyToBeShipped *
                         ServiceLine."Unit Price" * (1 - ServiceLine."Line Discount %" / 100) / (1 + ServiceLine."VAT %" / 100)) - RemAmt)
                ELSE
                    Amount :=
                      -((QtyToBeShipped * ServiceLine."Unit Price" * (1 - ServiceLine."Line Discount %" / 100)) - RemAmt);
                RemAmt := Amount - ROUND(Amount);
                IF ServiceHeader."Currency Code" <> '' THEN
                    Amount :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          ServiceLine."Posting Date", ServiceHeader."Currency Code",
                          Amount, ServiceHeader."Currency Factor"))
                ELSE
                    Amount := ROUND(Amount);
            END;

            "Source Code" := SrcCode;
            "Item Shpt. Entry No." := ItemLedgShptEntryNo;
            "Invoice-to Source No." := ServiceLine."Bill-to Customer No.";

            IF SalesSetup."Exact Cost Reversing Mandatory" AND (ServiceLine.Type = ServiceLine.Type::Item) THEN
                IF ServiceLine."Document Type" = ServiceLine."Document Type"::"Credit Memo" THEN
                    CheckApplFromItemEntry := ServiceLine.Quantity > 0
                ELSE
                    CheckApplFromItemEntry := ServiceLine.Quantity < 0;

            IF (ServiceLine."Location Code" <> '') AND (ServiceLine.Type = ServiceLine.Type::Item) AND (Quantity <> 0) THEN BEGIN
                GetLocation(ServiceLine."Location Code", Location);
                IF ((ServiceLine."Document Type" IN [ServiceLine."Document Type"::Invoice, ServiceLine."Document Type"::"Credit Memo"]) AND
                    Location."Directed Put-away and Pick") OR
                   (Location."Bin Mandatory" AND NOT IsWarehouseShipment(ServiceLine))
                THEN BEGIN
                    CreateWhseJnlLine(ItemJnlLine, ServiceLine, TempWhseJnlLine, Location);
                    WhsePosting := TRUE;
                END;
            END;

            IF QtyToBeShippedBase <> 0 THEN
                IF ServiceLine."Document Type" = ServiceLine."Document Type"::"Credit Memo" THEN
                    ServITRMgt.TransServLineToItemJnlLine(ServiceLine, ItemJnlLine, QtyToBeShippedBase, CheckApplFromItemEntry)
                ELSE
                    ServITRMgt.TransferReservToItemJnlLine(
                      ServiceLine, ItemJnlLine, -QtyToBeShippedBase, CheckApplFromItemEntry);

            IF CheckApplFromItemEntry THEN
                ServiceLine.TESTFIELD("Appl.-from Item Entry");

            OnBeforePostItemJnlLine(
              ItemJnlLine, ServShptHeader, ServiceLine, GenJnlLineDocNo,
              QtyToBeShipped, QtyToBeShippedBase, QtyToBeInvoiced, QtyToBeInvoicedBase);

            ItemJnlPostLine.RunWithCheck(ItemJnlLine);

            ItemJnlPostLine.CollectValueEntryRelation(TempValueEntryRelation, '');

            IF ItemJnlPostLine.CollectTrackingSpecification(TempHandlingSpecification) THEN
                ServITRMgt.InsertTempHandlngSpecification(DATABASE::"Service Line",
                  ServiceLine, TempHandlingSpecification,
                  TempTrackingSpecification, TempTrackingSpecificationInv,
                  QtyToBeInvoiced <> 0);

            IF WhsePosting THEN
                PostWhseJnlLines(TempWhseJnlLine, TempTrackingSpecification);

            EXIT("Item Shpt. Entry No.");
        END;
    end;

    local procedure CreateWhseJnlLine(ItemJnlLine: Record "Item Journal Line"; ServLine: Record "Service Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; Location: Record "Location")
    var
        WMSMgmt: Codeunit "WMS Management";
        WhseMgt: Codeunit "Whse. Management";
    begin
        WITH ServLine DO BEGIN
            WMSMgmt.CheckAdjmtBin(Location, ItemJnlLine.Quantity, TRUE);
            WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 0, TempWhseJnlLine, FALSE);
            TempWhseJnlLine."Source Type" := DATABASE::"Service Line";
            TempWhseJnlLine."Source Subtype" := "Document Type";
            TempWhseJnlLine."Source Code" := SrcCode;
            TempWhseJnlLine."Source Document" := WhseMgt.GetSourceDocument(TempWhseJnlLine."Source Type", TempWhseJnlLine."Source Subtype");
            TempWhseJnlLine."Source No." := "Document No.";
            TempWhseJnlLine."Source Line No." := "Line No.";
            CASE "Document Type" OF
                "Document Type"::Order:
                    TempWhseJnlLine."Reference Document" :=
                      TempWhseJnlLine."Reference Document"::"Posted Shipment";
                "Document Type"::Invoice:
                    TempWhseJnlLine."Reference Document" :=
                      TempWhseJnlLine."Reference Document"::"Posted S. Inv.";
                "Document Type"::"Credit Memo":
                    TempWhseJnlLine."Reference Document" :=
                      TempWhseJnlLine."Reference Document"::"Posted S. Cr. Memo";
            END;
            TempWhseJnlLine."Reference No." := ItemJnlLine."Document No.";
        END;
    end;




    local procedure PostWhseJnlLines(var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
    begin
        ServITRMgt.SplitWhseJnlLine(TempWhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, FALSE);
        IF TempWhseJnlLine2.FIND('-') THEN
            REPEAT
                WhseJnlRegisterLine.RegisterWhseJnlLine(TempWhseJnlLine2);
            UNTIL TempWhseJnlLine2.NEXT = 0;
    end;


    procedure PostInvoicePostBufferLine(var InvoicePostBuffer: Record "Invoice Post. Buffer"; DocType: Integer; DocNo: Code[20]; ExtDocNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLEntryNo: Integer;
    begin
        WITH GenJnlLine DO BEGIN
            InitNewLine(
              ServiceLinePostingDate, ServiceHeader."Document Date", ServiceHeader."Posting Description",
              InvoicePostBuffer."Global Dimension 1 Code", InvoicePostBuffer."Global Dimension 2 Code",
              InvoicePostBuffer."Dimension Set ID", ServiceHeader."Reason Code");

            CopyDocumentFields(ConverterFromIntegerToEnum(DocType), DocNo, ExtDocNo, SrcCode, '');

            CopyFromServiceHeader(ServiceHeader);
            CopyFromInvoicePostBuffer(InvoicePostBuffer);
            "Gen. Posting Type" := "Gen. Posting Type"::Sale;

            OnBeforePostInvoicePostBuffer(GenJnlLine, InvoicePostBuffer, ServiceHeader, GenJnlPostLine);
            GLEntryNo := GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnAfterPostInvoicePostBuffer(GenJnlLine, InvoicePostBuffer, ServiceHeader, GLEntryNo, GenJnlPostLine);
        END;
    end;


    procedure PostCustomerEntry(var TotalServiceLine: Record "Service Line"; var TotalServiceLineLCY: Record "Service Line"; DocType: Integer; DocNo: Code[20]; ExtDocNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        WITH GenJnlLine DO BEGIN
            InitNewLine(
              ServiceLinePostingDate, ServiceHeader."Document Date", ServiceHeader."Posting Description",
              ServiceHeader."Shortcut Dimension 1 Code", ServiceHeader."Shortcut Dimension 2 Code",
              ServiceHeader."Dimension Set ID", ServiceHeader."Reason Code");

            CopyDocumentFields(ConverterFromIntegerToEnum(DocType), DocNo, ExtDocNo, SrcCode, '');

            "Account Type" := "Account Type"::Customer;
            "Account No." := ServiceHeader."Bill-to Customer No.";
            CopyFromServiceHeader(ServiceHeader);
            SetCurrencyFactor(ServiceHeader."Currency Code", ServiceHeader."Currency Factor");

            CopyFromServiceHeaderApplyTo(ServiceHeader);
            CopyFromServiceHeaderPayment(ServiceHeader);

            Amount := -TotalServiceLine."Amount Including VAT";
            "Source Currency Amount" := -TotalServiceLine."Amount Including VAT";
            "Amount (LCY)" := -TotalServiceLineLCY."Amount Including VAT";
            "Sales/Purch. (LCY)" := -TotalServiceLineLCY.Amount;
            "Profit (LCY)" := -(TotalServiceLineLCY.Amount - TotalServiceLineLCY."Unit Cost (LCY)");
            "Inv. Discount (LCY)" := -TotalServiceLineLCY."Inv. Discount Amount";
            "System-Created Entry" := TRUE;

            OnBeforePostCustomerEntry(GenJnlLine, ServiceHeader);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnAfterPostCustomerEntry(GenJnlLine, ServiceHeader);
        END;
    end;



    procedure PostDirectConsumption(var ServiceLine: Record "Service Line"; var ServiceHeader: Record "Service Header"; ShptNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        ServiceCost: Record "Service Cost";
        CustPostGroup: Record "Customer Posting Group";
        GeneralPostingSetup: Record "General Posting Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        GenJnlLine.INIT;
        WITH ServiceHeader DO BEGIN
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine.VALIDATE("VAT Date", "VAT Date");//BH1.00
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := "Posting Description";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            IF ServiceLine.Type = ServiceLine.Type::"G/L Account" THEN
                GenJnlLine."Account No." := ServiceLine."No."
            ELSE BEGIN
                ServiceCost.GET(ServiceLine."No.");
                GenJnlLine."Account No." := ServiceCost."Account No.";
            END;
            GenJnlLine."Document No." := ShptNo;
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            IF ServiceLine.Type IN [ServiceLine.Type::Cost, ServiceLine.Type::"G/L Account"] THEN BEGIN
                GeneralPostingSetup.GET(ServiceLine."Gen. Bus. Posting Group", ServiceLine."Gen. Prod. Posting Group");
                GeneralPostingSetup.TESTFIELD("Sales Line Disc. Account");
                GenJnlLine."Bal. Account No." := GeneralPostingSetup."Sales Line Disc. Account";
            END ELSE BEGIN
                CustPostGroup.GET("Customer Posting Group");
                GenJnlLine."Bal. Account No." := CustPostGroup."Receivables Account";
            END;
            GenJnlLine."Currency Code" := "Currency Code";
            GenJnlLine.Amount := ServiceLine."Qty. to Consume" * ServiceLine."Unit Price";
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
            IF "Currency Code" = '' THEN
                GenJnlLine."Currency Factor" := 1
            ELSE
                GenJnlLine.VALIDATE("Currency Factor", "Currency Factor");
            GenJnlLine."Job No." := ServiceLine."Job No.";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
            GenJnlLine."Source No." := "Bill-to Customer No.";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Posting No. Series" := "Shipping No. Series";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine.Correction := Correction;
            GenJnlPostLine.RunWithCheck(GenJnlLine);
        END;
    end;

    procedure PostBalancingEntry(var TotalServiceLine: Record "Service Line"; var TotalServiceLineLCY: Record "Service Line"; DocType: Integer; DocNo: Code[20]; ExtDocNo: Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        CustLedgEntry.FINDLAST;
        WITH GenJnlLine DO BEGIN
            InitNewLine(
              ServiceLinePostingDate, ServiceHeader."Document Date", ServiceHeader."Posting Description",
              ServiceHeader."Shortcut Dimension 1 Code", ServiceHeader."Shortcut Dimension 2 Code",
              ServiceHeader."Dimension Set ID", ServiceHeader."Reason Code");

            IF ServiceHeader."Document Type" = ServiceHeader."Document Type"::"Credit Memo" THEN
                CopyDocumentFields("Document Type"::Refund, DocNo, ExtDocNo, SrcCode, '')
            ELSE
                CopyDocumentFields("Document Type"::Payment, DocNo, ExtDocNo, SrcCode, '');

            "Account Type" := "Account Type"::Customer;
            "Account No." := ServiceHeader."Bill-to Customer No.";
            CopyFromServiceHeader(ServiceHeader);
            SetCurrencyFactor(ServiceHeader."Currency Code", ServiceHeader."Currency Factor");

            SetApplyToDocNo(ServiceHeader, GenJnlLine, ConverterFromIntegerToEnum(DocType), DocNo);

            Amount := TotalServiceLine."Amount Including VAT" + CustLedgEntry."Remaining Pmt. Disc. Possible";
            "Source Currency Amount" := Amount;
            CustLedgEntry.CALCFIELDS(Amount);
            IF CustLedgEntry.Amount = 0 THEN
                "Amount (LCY)" := TotalServiceLineLCY."Amount Including VAT"
            ELSE
                "Amount (LCY)" :=
                  TotalServiceLineLCY."Amount Including VAT" +
                  ROUND(CustLedgEntry."Remaining Pmt. Disc. Possible" / CustLedgEntry."Adjusted Currency Factor");

            OnBeforePostBalancingEntry(GenJnlLine, ServiceHeader);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            OnAfterPostBalancingEntry(GenJnlLine, ServiceHeader);
        END;
    end;



    procedure PostGenJnlLineBalancing(var TotalServiceLine: Record "Service Line"; var TotalServiceLineLCY: Record "Service Line"; GenJnlLineDocType: Integer; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        CustLedgEntry.FINDLAST;
        GenJnlLine.INIT;
        WITH ServiceHeader DO BEGIN
            GenJnlLine."Posting Date" := ServiceLinePostingDate;
            GenJnlLine.VALIDATE("VAT Date", "VAT Date");//BH1.00
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := "Posting Description";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := "Bill-to Customer No.";
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
            ELSE
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := GenJnlLineDocNo;
            GenJnlLine."External Document No." := GenJnlLineExtDocNo;
            IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
            GenJnlLine."Bal. Account No." := "Bal. Account No.";
            GenJnlLine."Currency Code" := "Currency Code";
            GenJnlLine.Amount :=
              TotalServiceLine."Amount Including VAT" + CustLedgEntry."Remaining Pmt. Disc. Possible";
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
            CustLedgEntry.CALCFIELDS(Amount);
            IF CustLedgEntry.Amount = 0 THEN
                GenJnlLine."Amount (LCY)" := TotalServiceLineLCY."Amount Including VAT"
            ELSE
                GenJnlLine."Amount (LCY)" :=
                  TotalServiceLineLCY."Amount Including VAT" +
                  ROUND(CustLedgEntry."Remaining Pmt. Disc. Possible" /
                    CustLedgEntry."Adjusted Currency Factor");
            IF "Currency Code" = '' THEN
                GenJnlLine."Currency Factor" := 1
            ELSE
                GenJnlLine."Currency Factor" := "Currency Factor";
            GenJnlLine."Applies-to Doc. Type" := ConverterFromIntegerToEnum(GenJnlLineDocType);
            GenJnlLine."Applies-to Doc. No." := GenJnlLineDocNo;
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
            GenJnlLine."Source No." := "Bill-to Customer No.";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Posting No. Series" := "Posting No. Series";
            GenJnlLine.Correction := Correction;
            GenJnlPostLine.RunWithCheck(GenJnlLine);
        END;
    end;

    procedure ConverterFromIntegerToEnum(var OrdinalValue: Integer): Enum "Gen. Journal Document Type"
    var
        level: Enum "Gen. Journal Document Type";


    begin
        level := Enum::"Gen. Journal Document Type".FromInteger(OrdinalValue);
    end;

    procedure PostGenJnlLineReceivable(var TotalServiceLine: Record "Service Line"; var TotalServiceLineLCY: Record "Service Line"; GenJnlLineDocType: Integer; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.INIT;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("FA Posting Type", GenJnlLine."FA Posting Type"::" ");

        WITH ServiceHeader DO BEGIN
            GenJnlLine."Posting Date" := ServiceLinePostingDate;
            GenJnlLine.VALIDATE("VAT Date", "VAT Date");//BH1.00
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.Description := "Posting Description";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := "Bill-to Customer No.";
            GenJnlLine."Document Type" := ConverterFromIntegerToEnum(GenJnlLineDocType);
            GenJnlLine."Document No." := GenJnlLineDocNo;
            GenJnlLine."External Document No." := GenJnlLineExtDocNo;
            GenJnlLine."Currency Code" := "Currency Code";
            GenJnlLine.Amount := -TotalServiceLine."Amount Including VAT";
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := -TotalServiceLine."Amount Including VAT";
            GenJnlLine."Amount (LCY)" := -TotalServiceLineLCY."Amount Including VAT";
            IF "Currency Code" = '' THEN
                GenJnlLine."Currency Factor" := 1
            ELSE
                GenJnlLine."Currency Factor" := "Currency Factor";
            GenJnlLine."Sales/Purch. (LCY)" := -TotalServiceLineLCY.Amount;
            GenJnlLine."Profit (LCY)" := -(TotalServiceLineLCY.Amount - TotalServiceLineLCY."Unit Cost (LCY)");
            GenJnlLine."Inv. Discount (LCY)" := -TotalServiceLineLCY."Inv. Discount Amount";
            GenJnlLine."Sell-to/Buy-from No." := "Customer No.";
            GenJnlLine."Bill-to/Pay-to No." := "Bill-to Customer No.";
            GenJnlLine."Salespers./Purch. Code" := "Salesperson Code";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine."Applies-to Doc. Type" := "Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := "Applies-to Doc. No.";
            GenJnlLine."Applies-to ID" := "Applies-to ID";
            GenJnlLine."Allow Application" := "Bal. Account No." = '';
            GenJnlLine."Allow Application" := TRUE;
            GenJnlLine."Due Date" := "Due Date";
            GenJnlLine."Payment Terms Code" := "Payment Terms Code";
            GenJnlLine."Payment Method Code" := "Payment Method Code";
            GenJnlLine."Pmt. Discount Date" := "Pmt. Discount Date";
            GenJnlLine."Payment Discount %" := "Payment Discount %";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
            GenJnlLine."Source No." := "Bill-to Customer No.";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Posting No. Series" := "Posting No. Series";
            GenJnlLine.Correction := Correction;
        END;

        GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;


    procedure PostGenGnlLineSale(var InvPostingBuffer: array[2] of Record "Invoice Post. Buffer"; GenJnlLineDocType: Integer; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        WITH ServiceHeader DO BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Posting Date" := ServiceLinePostingDate;
            GenJnlLine."Document Date" := "Document Date";
            GenJnlLine.VALIDATE("VAT Date", "VAT Date");//BH1.00
            GenJnlLine.Description := "Posting Description";
            GenJnlLine."Reason Code" := "Reason Code";
            GenJnlLine."Document Type" := ConverterFromIntegerToEnum(GenJnlLineDocType);
            GenJnlLine."Document No." := GenJnlLineDocNo;
            GenJnlLine."External Document No." := GenJnlLineExtDocNo;
            GenJnlLine."Account No." := InvPostingBuffer[1]."G/L Account";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine.Amount := InvPostingBuffer[1].Amount;
            GenJnlLine."Source Currency Code" := "Currency Code";
            GenJnlLine."Source Currency Amount" := InvPostingBuffer[1]."Amount (ACY)";
            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Sale;
            GenJnlLine."Gen. Bus. Posting Group" := InvPostingBuffer[1]."Gen. Bus. Posting Group";
            GenJnlLine."Gen. Prod. Posting Group" := InvPostingBuffer[1]."Gen. Prod. Posting Group";
            GenJnlLine."VAT Bus. Posting Group" := InvPostingBuffer[1]."VAT Bus. Posting Group";
            GenJnlLine."VAT Prod. Posting Group" := InvPostingBuffer[1]."VAT Prod. Posting Group";
            GenJnlLine."Tax Area Code" := InvPostingBuffer[1]."Tax Area Code";
            GenJnlLine."Tax Liable" := InvPostingBuffer[1]."Tax Liable";
            GenJnlLine."Tax Group Code" := InvPostingBuffer[1]."Tax Group Code";
            GenJnlLine."Use Tax" := InvPostingBuffer[1]."Use Tax";
            GenJnlLine.Quantity := InvPostingBuffer[1].Quantity;
            GenJnlLine."VAT Calculation Type" := InvPostingBuffer[1]."VAT Calculation Type";
            GenJnlLine."VAT Base Amount" := InvPostingBuffer[1]."VAT Base Amount";
            GenJnlLine."VAT Base Discount %" := "VAT Base Discount %";
            GenJnlLine."Source Curr. VAT Base Amount" := InvPostingBuffer[1]."VAT Base Amount (ACY)";
            GenJnlLine."VAT Amount" := InvPostingBuffer[1]."VAT Amount";
            GenJnlLine."Source Curr. VAT Amount" := InvPostingBuffer[1]."VAT Amount (ACY)";
            GenJnlLine."VAT Difference" := InvPostingBuffer[1]."VAT Difference";
            GenJnlLine."VAT Posting" := GenJnlLine."VAT Posting"::"Manual VAT Entry";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := InvPostingBuffer[1]."Dimension Set ID";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."EU 3-Party Trade" := "EU 3-Party Trade";
            GenJnlLine."Sell-to/Buy-from No." := "Customer No.";
            GenJnlLine."Bill-to/Pay-to No." := "Bill-to Customer No.";
            GenJnlLine."Country/Region Code" := "VAT Country/Region Code";
            GenJnlLine."VAT Registration No." := "VAT Registration No.";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
            GenJnlLine."Source No." := "Bill-to Customer No.";
            GenJnlLine."Posting No. Series" := "Posting No. Series";
            GenJnlLine."Ship-to/Order Address Code" := "Ship-to Code";
            GenJnlLine."Job No." := InvPostingBuffer[1]."Job No.";
            GenJnlLine.Correction := Correction;
        END;

        GenJnlPostLine.RunWithCheck(GenJnlLine);

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine.VALIDATE("FA Posting Type", GenJnlLine."FA Posting Type"::" ");
    end;

    local procedure SetApplyToDocNo(ServiceHeader: Record "Service Header"; var GenJnlLine: Record "Gen. Journal Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    begin
        WITH GenJnlLine DO BEGIN
            IF ServiceHeader."Bal. Account Type" = ServiceHeader."Bal. Account Type"::"Bank Account" THEN
                "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
            "Bal. Account No." := ServiceHeader."Bal. Account No.";
            "Applies-to Doc. Type" := DocType;
            "Applies-to Doc. No." := DocNo;
        END;
    end;


    procedure PostResJnlLineShip(var ServiceLine: Record "Service Line"; DocNo: Code[20]; ExtDocNo: Code[20])
    var
        ResJnlLine: Record "Res. Journal Line";
    begin
        IF ServiceLine."Time Sheet No." <> '' THEN
            TimeSheetMgt.CheckServiceLine(ServiceLine);

        PostResJnlLine(
          ServiceHeader, ServiceLine,
          DocNo, ExtDocNo, SrcCode, ServiceHeader."Posting No. Series",
          ResJnlLine."Entry Type"::Usage, -ServiceLine."Qty. to Ship",
          ServiceLine.Amount / ServiceLine."Qty. to Ship", -ServiceLine.Amount);

        TimeSheetMgt.CreateTSLineFromServiceLine(ServiceLine, GenJnlLineDocNo, TRUE);
    end;


    procedure PostResJnlLineUndoUsage(var ServiceLine: Record "Service Line"; DocNo: Code[20]; ExtDocNo: Code[20])
    var
        ResJnlLine: Record "Res. Journal Line";
    begin
        PostResJnlLine(
          ServiceHeader, ServiceLine,
          DocNo, ExtDocNo, SrcCode, ServiceHeader."Posting No. Series",
          ResJnlLine."Entry Type"::Usage, -ServiceLine."Qty. to Invoice",
          ServiceLine.Amount / ServiceLine."Qty. to Invoice", -ServiceLine.Amount);
    end;


    procedure PostResJnlLineSale(var ServiceLine: Record "Service Line"; DocNo: Code[20]; ExtDocNo: Code[20])
    var
        ResJnlLine: Record "Res. Journal Line";
    begin
        PostResJnlLine(
          ServiceHeader, ServiceLine, DocNo, ExtDocNo, SrcCode, ServiceHeader."Posting No. Series",
          ResJnlLine."Entry Type"::Sale, -ServiceLine."Qty. to Invoice",
          -ServiceLine.Amount / ServiceLine.Quantity, -ServiceLine.Amount);
    end;


    procedure PostResJnlLineConsume(var ServiceLine: Record "Service Line"; var ServShptHeader: Record "Service Shipment Header")
    var
        ResJnlLine: Record "Res. Journal Line";
    begin
        IF ServiceLine."Time Sheet No." <> '' THEN
            TimeSheetMgt.CheckServiceLine(ServiceLine);

        PostResJnlLine(
          ServiceHeader, ServiceLine,
          ServShptHeader."No.", '', SrcCode, ServShptHeader."No. Series",
          ResJnlLine."Entry Type"::Usage, -ServiceLine."Qty. to Consume", 0, 0);

        TimeSheetMgt.CreateTSLineFromServiceLine(ServiceLine, GenJnlLineDocNo, FALSE);
    end;

    local procedure PostResJnlLine(ServiceHeader: Record "Service Header"; ServiceLine: Record "Service Line"; DocNo: Code[20]; ExtDocNo: Code[35]; SrcCode: Code[10]; PostingNoSeries: Code[20]; EntryType: enum "Res. Journal Line Entry Type"; Qty: Decimal; UnitPrice: Decimal; TotalPrice: Decimal)
    var
        ResJnlLine: Record "Res. Journal Line";
    begin
        WITH ResJnlLine DO BEGIN
            INIT;
            CopyDocumentFields(DocNo, ExtDocNo, SrcCode, PostingNoSeries);
            CopyFromServHeader(ServiceHeader);
            CopyFromServLine(ServiceLine);

            "Entry Type" := EntryType;
            Quantity := Qty;
            "Unit Cost" := ServiceLine."Unit Cost (LCY)";
            "Total Cost" := ServiceLine."Unit Cost (LCY)" * Quantity;
            "Unit Price" := UnitPrice;
            "Total Price" := TotalPrice;

            ResJnlPostLine.RunWithCheck(ResJnlLine);
        END;
    end;


    procedure InitServiceRegister(var NextServLedgerEntryNo: Integer; var NextWarrantyLedgerEntryNo: Integer)
    begin
        ServLedgEntryPostSale.InitServiceRegister(NextServLedgerEntryNo, NextWarrantyLedgerEntryNo);
    end;


    procedure FinishServiceRegister(var nextServEntryNo: Integer; var nextWarrantyEntryNo: Integer)
    begin
        ServLedgEntryPostSale.FinishServiceRegister(nextServEntryNo, nextWarrantyEntryNo);
    end;


    procedure InsertServLedgerEntry(var NextEntryNo: Integer; var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var ServItemLine: Record "Service Item Line"; Qty: Decimal; DocNo: Code[20]): Integer
    begin
        EXIT(
          ServLedgEntryPostSale.InsertServLedgerEntry(NextEntryNo, ServiceHeader, ServiceLine, ServItemLine, Qty, DocNo));
    end;


    procedure InsertServLedgerEntrySale(var passedNextEntryNo: Integer; var ServHeader: Record "Service Header"; var ServLine: Record "Service Line"; var ServItemLine: Record "Service Item Line"; Qty: Decimal; QtyToCharge: Decimal; GenJnlLineDocNo: Code[20]; DocLineNo: Integer)
    begin
        ServLedgEntryPostSale.InsertServLedgerEntrySale(
          passedNextEntryNo, ServHeader, ServLine, ServItemLine, Qty, QtyToCharge, GenJnlLineDocNo, DocLineNo);
    end;


    procedure CreateCreditEntry(var passedNextEntryNo: Integer; var ServHeader: Record "Service Header"; var ServLine: Record "Service Line"; GenJnlLineDocNo: Code[20])
    begin
        ServLedgEntryPostSale.CreateCreditEntry(passedNextEntryNo, ServHeader, ServLine, GenJnlLineDocNo);
    end;


    procedure InsertWarrantyLedgerEntry(var NextWarrantyEntryNo: Integer; var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var ServItemLine: Record "Service Item Line"; Qty: Decimal; GenJnlLineDocNo: Code[20]): Integer
    begin
        EXIT(
          ServLedgEntryPostSale.InsertWarrantyLedgerEntry(
            NextWarrantyEntryNo, ServiceHeader, ServiceLine, ServItemLine, Qty, GenJnlLineDocNo));
    end;


    procedure CalcSLEDivideAmount(Qty: Decimal; var passedServHeader: Record "Service Header"; var passedTempServLine: Record "Service Line"; var passedVATAmountLine: Record "VAT Amount Line")
    begin
        ServLedgEntryPostSale.CalcDivideAmount(Qty, passedServHeader, passedTempServLine, passedVATAmountLine);
    end;


    procedure TestSrvCostDirectPost(ServLineNo: Code[20])
    var
        ServCost: Record "Service Cost";
        GLAcc: Record "G/L Account";
    begin
        ServCost.GET(ServLineNo);
        GLAcc.GET(ServCost."Account No.");
        GLAcc.TESTFIELD("Direct Posting", TRUE);
    end;


    procedure TestGLAccDirectPost(ServLineNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.GET(ServLineNo);
        GLAcc.TESTFIELD("Direct Posting", TRUE);
    end;


    procedure CollectValueEntryRelation(var PassedValueEntryRelation: Record "Value Entry Relation"; RowId: Text[100])
    begin
        TempValueEntryRelation.RESET;
        PassedValueEntryRelation.RESET;

        IF TempValueEntryRelation.FINDSET THEN
            REPEAT
                PassedValueEntryRelation := TempValueEntryRelation;
                PassedValueEntryRelation."Source RowId" := RowId;
                PassedValueEntryRelation.INSERT;
            UNTIL TempValueEntryRelation.NEXT = 0;

        TempValueEntryRelation.DELETEALL;
    end;


    procedure PostJobJnlLine(var ServHeader: Record "Service Header"; ServLine: Record "Service Line"; QtyToBeConsumed: Decimal): Boolean
    var
        JobJnlLine: Record "Job Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ServiceCost: Record "Service Cost";
        Job: Record "Job";
        JobTask: Record "Job Task";
        Item: Record "Item";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        CurrencyFactor: Decimal;
        UnitPriceLCY: Decimal;
    begin
        WITH ServLine DO BEGIN
            IF ("Job No." = '') OR (QtyToBeConsumed = 0) THEN
                EXIT(FALSE);

            TESTFIELD("Job Task No.");
            Job.LOCKTABLE;
            JobTask.LOCKTABLE;
            Job.GET("Job No.");
            JobTask.GET("Job No.", "Job Task No.");

            JobJnlLine.INIT;
            JobJnlLine.DontCheckStdCost;
            JobJnlLine.VALIDATE("Job No.", "Job No.");
            JobJnlLine.VALIDATE("Job Task No.", "Job Task No.");
            JobJnlLine.VALIDATE("Line Type", "Job Line Type");
            JobJnlLine.VALIDATE("Posting Date", "Posting Date");
            JobJnlLine."Job Posting Only" := TRUE;
            JobJnlLine."No." := "No.";

            CASE Type OF
                Type::"G/L Account":
                    JobJnlLine.Type := JobJnlLine.Type::"G/L Account";
                Type::Item:
                    JobJnlLine.Type := JobJnlLine.Type::Item;
                Type::Resource:
                    JobJnlLine.Type := JobJnlLine.Type::Resource;
                Type::Cost:
                    BEGIN
                        ServiceCost.SETRANGE(Code, "No.");
                        ServiceCost.FINDFIRST;
                        JobJnlLine.Type := JobJnlLine.Type::"G/L Account";
                        JobJnlLine."No." := ServiceCost."Account No.";
                    END;
            END; // Case Type

            JobJnlLine.VALIDATE("No.");
            JobJnlLine.Description := Description;
            JobJnlLine."Description 2" := "Description 2";
            JobJnlLine."Variant Code" := "Variant Code";
            JobJnlLine."Unit of Measure Code" := "Unit of Measure Code";
            JobJnlLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            JobJnlLine.VALIDATE(Quantity, -QtyToBeConsumed);
            JobJnlLine."Document No." := ServHeader."Shipping No.";
            JobJnlLine."Service Order No." := "Document No.";
            JobJnlLine."External Document No." := ServHeader."Shipping No.";
            JobJnlLine."Posted Service Shipment No." := ServHeader."Shipping No.";
            IF Type = Type::Item THEN BEGIN
                Item.GET("No.");
                IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                    JobJnlLine.VALIDATE("Unit Cost (LCY)", Item."Standard Cost")
                ELSE
                    JobJnlLine.VALIDATE("Unit Cost (LCY)", "Unit Cost (LCY)")
            END ELSE
                JobJnlLine.VALIDATE("Unit Cost (LCY)", "Unit Cost (LCY)");
            IF "Currency Code" = Job."Currency Code" THEN
                JobJnlLine.VALIDATE("Unit Price", "Unit Price");
            IF "Currency Code" <> '' THEN BEGIN
                Currency.GET("Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
                CurrencyFactor := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                UnitPriceLCY :=
                  ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Unit Price", CurrencyFactor),
                    Currency."Amount Rounding Precision");
                JobJnlLine.VALIDATE("Unit Price (LCY)", UnitPriceLCY);
            END ELSE
                JobJnlLine.VALIDATE("Unit Price (LCY)", "Unit Price");
            JobJnlLine.VALIDATE("Line Discount %", "Line Discount %");
            JobJnlLine."Job Planning Line No." := "Job Planning Line No.";
            JobJnlLine."Remaining Qty." := "Job Remaining Qty.";
            JobJnlLine."Remaining Qty. (Base)" := "Job Remaining Qty. (Base)";
            JobJnlLine."Location Code" := "Location Code";
            JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
            JobJnlLine."Posting Group" := "Posting Group";
            JobJnlLine."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            JobJnlLine."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            JobJnlLine."Customer Price Group" := "Customer Price Group";
            SourceCodeSetup.GET;
            JobJnlLine."Source Code" := SourceCodeSetup."Service Management";
            JobJnlLine."Work Type Code" := "Work Type Code";
            JobJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            JobJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            JobJnlLine."Dimension Set ID" := "Dimension Set ID";
            OnAfterTransferValuesToJobJnlLine(JobJnlLine, ServLine);
        END;

        JobJnlPostLine.RunWithCheck(JobJnlLine);
        EXIT(TRUE);
    end;


    procedure SetPostingDate(PostingDate: Date)
    begin
        ServiceLinePostingDate := PostingDate;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCustomerEntry(var GenJournalLine: Record "Gen. Journal Line"; ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostBalancingEntry(var GenJournalLine: Record "Gen. Journal Line"; var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostInvoicePostBuffer(var GenJournalLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; ServiceHeader: Record "Service Header"; GLEntryNo: Integer; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTransferValuesToJobJnlLine(var JobJournalLine: Record "Job Journal Line"; ServiceLine: Record "Service Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCustomerEntry(var GenJournalLine: Record "Gen. Journal Line"; ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostBalancingEntry(var GenJournalLine: Record "Gen. Journal Line"; var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostInvoicePostBuffer(var GenJournalLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; ServiceHeader: Record "Service Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; ServiceShipmentHeader: Record "Service Shipment Header"; ServiceLine: Record "Service Line"; GenJnlLineDocNo: Code[20]; QtyToBeShipped: Decimal; QtyToBeShippedBase: Decimal; QtyToBeInvoiced: Decimal; QtyToBeInvoicedBase: Decimal)
    begin
    end;
}

