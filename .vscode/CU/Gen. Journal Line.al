codeunit 50007 GenJNLLine

{
    Permissions = TableData "Sales Header" = m,
                  TableData "Sales Line" = m,
                  TableData "Purchase Line" = imd,
                  TableData "Invoice Post. Buffer" = imd,
                  TableData "Vendor Posting Group" = imd,
                  TableData "Inventory Posting Group" = imd,
                  TableData "Sales Shipment Header" = imd,
                  TableData "Sales Shipment Line" = imd,
                  TableData "Purch. Rcpt. Header" = imd,
                  TableData "Purch. Rcpt. Line" = imd,
                  TableData "Purch. Inv. Header" = imd,
                  TableData "Purch. Inv. Line" = imd,
                  TableData "Purch. Cr. Memo Hdr." = imd,
                  TableData "Purch. Cr. Memo Line" = imd,
                  TableData "Drop Shpt. Post. Buffer" = imd,
                  TableData "Item Entry Relation" = ri,
                  TableData "Value Entry Relation" = rid,
                  TableData "Return Shipment Header" = imd;

    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Table, 81, 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 5057, 'OnBeforeContactInsert', '', true, true)]
    local procedure OnBeforeContactInsert(var Contact: Record Contact; Vendor: Record Vendor)
    begin
        Contact."Type Relation" := Contact."Type Relation"::Customer;
    end;


    [EventSubscriber(ObjectType::Table, 81, 'OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo', '', true, true)] //ED
    procedure OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset(); //trazim vrstu uplate na dokumentu za zatvaranje
        SalesInvoiceHeader.SetFilter("No.", GenJournalLine."Applies-to Doc. No.");
        if SalesInvoiceHeader.FindFirst() then begin
            GenJournalLine."Payment Type" := SalesInvoiceHeader."Payment Type Invoice";

        end;
    end;


    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    procedure OnAfterCopyGLEntryFromGenJnlLine(GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin

        GLEntry."Payment Type Code" := GenJournalLine."Payment Type";

        GLEntry."Payment Method" := GenJournalLine."Payment Method Code";



        GLEntry."Cashier Code" := GenJournalLine."Cashier Employer"; //sifra blagajnika


        GLEntry."Payment Reference" := GenJournalLine."Payment Reference";
        GLEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        GLEntry.KIF_Entry := GenJournalLine.KIF_Entry;
        GLEntry."Request Document" := GenJournalLine."Request Document";

    end;

    //12

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertVAT', '', true, true)]
    local procedure OnAfterInsertVAT(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var UnrealizedVAT: Boolean; var AddCurrencyCode: Code[10]; var VATPostingSetup: Record "VAT Posting Setup"; var GLEntryAmount: Decimal; var GLEntryVATAmount: Decimal; var GLEntryBaseAmount: Decimal; var SrcCurrCode: Code[10]; var SrcCurrGLEntryAmt: Decimal; var SrcCurrGLEntryVATAmt: Decimal; var SrcCurrGLEntryBaseAmt: Decimal; AddCurrGLEntryVATAmt: Decimal; var NextConnectionNo: Integer; var NextVATEntryNo: Integer; var NextTransactionNo: Integer; TempGLEntryBufEntryNo: Integer)
    begin
        GenJournalLine.KUF_Entry := VATEntry.KUF_Entry;
        GenJournalLine.KIF_Entry := VATEntry.KIF_Entry;
        GenJournalLine.KUF_Type := VATEntry.KUF_Type;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")

    begin
        //   VATEntry."VAT Date" := GenJournalLine."VAT Date";
        GLEntry."Payment Type Code" := GenJournalLine."Payment Type";
        GLEntry."Payment Method" := FORMAT(GenJournalLine."Payment Method");
        GLEntry."Cashier Code" := GenJournalLine."Cashier Employer"; //sifra blagajnika
        GLEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        GLEntry.KIF_Entry := GenJournalLine.KIF_Entry;
        GLEntry."Request Document" := GenJournalLine."Request Document";

    end;

    //OnAfterInitGLEntry(GLEntry, GenJnlLine);



    [EventSubscriber(ObjectType::Table, 254, 'OnAfterCopyFromGenJnlLine', '', true, true)]
    procedure Testiram(VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin
    end;

    //  // [IntegrationEvent(false, false)]







    [EventSubscriber(ObjectType::Codeunit, 5772, 'OnAfterReleaseSetFilters', '', true, true)]
    procedure FixedAsset(VAR PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        CUTest: Codeunit "Whse.-Purch. Release";

    begin
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset");
    end;


    [EventSubscriber(ObjectType::Codeunit, 5771, 'OnAfterReleaseSetFilters', '', true, true)]
    procedure OnAfterReleaseSetFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")

    var

    begin
        SalesLine.SetRange(Type, SalesLine.Type::Item, SalesLine.Type::"Fixed Asset");
    end;


    [EventSubscriber(ObjectType::Codeunit, 5750, 'OnAfterWhseShptLineInsert', '', true, true)]
    procedure OnAfterWhseShptLineInsert(var WarehouseShipmentLine: Record "Warehouse Shipment Line")


    var
        ItemTest: Record Item;
        TempGLE: Record TempGLE;

    begin
        if copystr(WarehouseShipmentLine."Item No.", 1, 2) = 'OS' then begin


            TempGLE.reset;
            TempGLE.SetFilter("Document No.", '<>%1', WarehouseShipmentLine."Source No.");
            TempGLE.SetFilter("User ID", '%1', UserId);
            if TempGLE.FindSet() then
                repeat
                    TempGLE.Delete();
                until TempGLE.Next() = 0;


            TempGLE.reset;
            TempGLE.SetFilter("Document No.", '%1', WarehouseShipmentLine."Source No.");
            TempGLE.SetFilter("Entry No.", '%1', WarehouseShipmentLine."Line No.");
            if TempGLE.findfirst then TempGLE.Delete();



            TempGLE.reset;
            TempGLE.Init();
            TempGLE."Entry No." := WarehouseShipmentLine."Line No.";
            TempGLE.Description := WarehouseShipmentLine."Item No.";
            TempGLE."Document No." := WarehouseShipmentLine."Source No.";
            TempGLE."User ID" := UserId;
            TempGLE.Insert();
        end;




        ItemTest.Reset;
        if ItemTest.FindFirst() then begin
            WarehouseShipmentLine."Item No." := ItemTest."No.";

        end;

    end;
    // end;




    [EventSubscriber(ObjectType::Table, database::"Transfer Receipt Header", 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure OnAfterCopyFromTransferHeader(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Sales Header No." := TransferHeader."Sales Header No.";
        TransferReceiptHeader.Correction := TransferHeader.Correction;
        TransferReceiptHeader."Department Code" := TransferHeader."Department Code";
    end;



    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptLineInsert', '', true, true)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line")
    var
        WhseRcptHeader: Record "Warehouse Receipt Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
        WhsePostRcpt: Codeunit "Whse.-Post Receipt";
        PostedWhseRcptHeader: Record "Posted Whse. Receipt Header";
        FA: Record "FA Journal Setup";
        FAP: page "FA Journal Setup";

    begin

        if (PurchLine.Type = PurchLine.Type::"Fixed Asset") and (PurchLine."Qty. to Receive" <> 0) then begin
            WhseRcptHeader.Reset();
            WhseRcptHeader.SetFilter("Receiving No.", '%1', PostedWhseRcptLine."No.");
            if WhseRcptHeader.FindFirst() then begin

                /*     WhseRcptLine.GetWhseRcptLine(
                         WhseRcptHeader."No.", DATABASE::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.");

                     //NE   WhseRcptLine.TestField("Qty. to Receive", PurchRcptLine.Quantity);
                     SaveTempWhseSplitSpec2(PurchLine);
                     PostedWhseRcptHeader.Reset();
                     PostedWhseRcptHeader.SetFilter("No.", '%1', PostedWhseRcptLine."No.");
                     if PostedWhseRcptHeader.FindFirst() then begin

                         WhsePostRcpt.CreatePostedRcptLine(
                           WhseRcptLine, PostedWhseRcptHeader, PostedWhseRcptLine, TempWhseSplitSpecification);
                     end;

     */
                //LL  WhseRcptLine.Delete();

            end;
        end;

        // end;
    end;


    //PostUpdateWhseDocuments


    //isto dodati na 5763 za brisanje:

    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnBeforePostUpdateWhseDocuments', '', true, true)]
    local procedure OnBeforePostUpdateWhseDocuments2(var WhseShptHeader: Record "Warehouse Shipment Header")
    var
        WhseRcptLine2: Record "Warehouse Shipment Line";
        TempGL: Record TempGLE;
        DeleteWhseRcptLine2: Boolean;

    begin

        TempGL.Reset();
        TempGL.SetFilter("Document No.", '%1', WhseShptHeader."No.");
        if TempGL.FindSet() then
            repeat

                WhseRcptLine2.Get(TempGL."Document No.", TempGL."Entry No.");
                DeleteWhseRcptLine2 := WhseRcptLine2."Qty. Outstanding" = WhseRcptLine2."Qty. to Ship";

                if DeleteWhseRcptLine2 then
                    //    DeleteWhseRcptLine2 := true
                    WhseRcptLine2.Delete
                else begin
                    WhseRcptLine2."Qty. Shipped" := WhseRcptLine2."Qty. Shipped" + WhseRcptLine2."Qty. to Ship";
                    WhseRcptLine2.Validate("Qty. Outstanding", WhseRcptLine2."Qty. Outstanding" - WhseRcptLine2."Qty. to Ship");
                    WhseRcptLine2."Qty. Shipped (Base)" := WhseRcptLine2."Qty. Shipped (Base)" + WhseRcptLine2."Qty. to Ship (Base)";
                    WhseRcptLine2."Qty. Outstanding (Base)" := WhseRcptLine2."Qty. Outstanding (Base)" - WhseRcptLine2."Qty. to Ship (Base)";
                    WhseRcptLine2.Status := WhseRcptLine2.CalcStatusShptLine;

                    WhseRcptLine2.Modify();
                end;


            until TempGL.Next() = 0;

    end;


    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnBeforePostUpdateWhseShptLine', '', true, true)]
    local procedure OnBeforePostUpdateWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        WhseRcptLine2: Record "Warehouse Shipment Line";
        TempGL: Record TempGLE;
        DeleteWhseRcptLine2: Boolean;

    begin

        TempGL.Reset();
        TempGL.SetFilter("Document No.", '%1', WarehouseShipmentLine."Source No.");
        if TempGL.FindSet() then
            repeat

                WhseRcptLine2.Get(TempGL."Document No.", TempGL."Entry No.");
                DeleteWhseRcptLine2 := WhseRcptLine2."Qty. Outstanding" = WhseRcptLine2."Qty. to Ship";

                if DeleteWhseRcptLine2 then
                    //    DeleteWhseRcptLine2 := true
                    WhseRcptLine2.Delete
                else begin
                    WhseRcptLine2."Qty. Shipped" := WhseRcptLine2."Qty. Shipped" + WhseRcptLine2."Qty. to Ship";
                    WhseRcptLine2.Validate("Qty. Outstanding", WhseRcptLine2."Qty. Outstanding" - WhseRcptLine2."Qty. to Ship");
                    WhseRcptLine2."Qty. Shipped (Base)" := WhseRcptLine2."Qty. Shipped (Base)" + WhseRcptLine2."Qty. to Ship (Base)";
                    WhseRcptLine2."Qty. Outstanding (Base)" := WhseRcptLine2."Qty. Outstanding (Base)" - WhseRcptLine2."Qty. to Ship (Base)";
                    WhseRcptLine2.Status := WhseRcptLine2.CalcStatusShptLine;

                    WhseRcptLine2.Modify();
                end;


            until TempGL.Next() = 0;

    end;

    //kraj


    [EventSubscriber(ObjectType::Codeunit, 5760, 'OnAfterInitPostedRcptLine', '', true, true)]
    local procedure OnAfterInitPostedRcptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    var
        PurchaseLine: Record "Purchase Line";
        WSetup: Record "Warehouse Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        NoSeriesLine: Record "No. Series Line";


    begin

        if (PostedWhseReceiptLine."No." = '') then begin
            PurchaseLine.Reset();
            PurchaseLine.SetFilter("Line No.", '%1', WarehouseReceiptLine."Source Line No.");
            PurchaseLine.SetFilter("Document No.", '%1', WarehouseReceiptLine."Source No.");
            if PurchaseLine.FindFirst() then begin
                if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then begin
                    if PostedWhseReceiptLine."No." = '' then begin
                        WSetup.get;
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", '%1', WSetup."Posted Whse. Receipt Nos.");
                        NoSeriesLine.SetCurrentKey("Starting Date");
                        NoSeriesLine.Ascending;
                        if NoSeriesLine.findlast then
                            PostedWhseReceiptLine."No." := NoSeriesLine."Last No. Used";
                    end;
                    //  NoSeriesMgt.InitSeries(WSetup."Posted Whse. Receipt Nos.", WSetup."Posted Whse. Receipt Nos.", 0D, PostedWhseReceiptLine."No.", WSetup."Posted Whse. Receipt Nos.");

                end;
            end;

        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, 5760, 'OnBeforePostUpdateWhseDocuments', '', true, true)]
    local procedure OnBeforePostUpdateWhseDocuments(var WhseRcptHeader: Record "Warehouse Receipt Header")
    var
        WhseRcptLine2: Record "Warehouse Receipt Line";
        TempGL: Record TempGLE;
        DeleteWhseRcptLine2: Boolean;

    begin

        TempGL.Reset();
        TempGL.SetFilter("Document No.", '%1', WhseRcptHeader."No.");
        if TempGL.FindSet() then
            repeat

                WhseRcptLine2.Get(TempGL."Document No.", TempGL."Entry No.");
                DeleteWhseRcptLine2 := WhseRcptLine2."Qty. Outstanding" = WhseRcptLine2."Qty. to Receive";

                if DeleteWhseRcptLine2 then begin
                    //    DeleteWhseRcptLine2 := true
                    WhseRcptLine2.Delete
                end

                else begin
                    WhseRcptLine2.Validate("Qty. Received", WhseRcptLine2."Qty. Received" + WhseRcptLine2."Qty. to Receive");
                    WhseRcptLine2.Validate("Qty. Outstanding", WhseRcptLine2."Qty. Outstanding" - WhseRcptLine2."Qty. to Receive");
                    WhseRcptLine2."Qty. to Cross-Dock" := 0;
                    WhseRcptLine2."Qty. to Cross-Dock (Base)" := 0;
                    WhseRcptLine2.Status := WhseRcptLine2.GetLineStatus;

                    WhseRcptLine2.Modify();

                end;

            until TempGL.Next() = 0;

    end;


    [EventSubscriber(ObjectType::Codeunit, 5760, 'OnBeforePostUpdateWhseRcptLine', '', true, true)]
    local procedure OnBeforePostUpdateWhseRcptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; var WarehouseReceiptLineBuf: Record "Warehouse Receipt Line"; var DeleteWhseRcptLine: Boolean; var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WhseRcptLine2: Record "Warehouse Receipt Line";
        TempGL: Record TempGLE;
        DeleteWhseRcptLine2: Boolean;

    begin

        TempGL.Reset();
        TempGL.SetFilter("Document No.", '%1', WhseRcptLine2."No.");
        if TempGL.FindSet() then
            repeat

                WhseRcptLine2.Get(TempGL."Document No.", TempGL."Entry No.");
                DeleteWhseRcptLine2 := WhseRcptLine2."Qty. Outstanding" = WhseRcptLine2."Qty. to Receive";

                if DeleteWhseRcptLine2 then
                    //    DeleteWhseRcptLine2 := true
                    WhseRcptLine2.Delete
                else begin
                    WhseRcptLine2.Validate("Qty. Received", WhseRcptLine2."Qty. Received" + WhseRcptLine2."Qty. to Receive");
                    WhseRcptLine2.Validate("Qty. Outstanding", WhseRcptLine2."Qty. Outstanding" - WhseRcptLine2."Qty. to Receive");
                    WhseRcptLine2."Qty. to Cross-Dock" := 0;
                    WhseRcptLine2."Qty. to Cross-Dock (Base)" := 0;
                    WhseRcptLine2.Status := WhseRcptLine2.GetLineStatus;

                    WhseRcptLine2.Modify();
                end;


            until TempGL.Next() = 0;

    end;





    [EventSubscriber(ObjectType::Codeunit, 90, 'OnInsertReceiptLineOnAfterInitPurchRcptLine', '', true, true)]
    local procedure OnInsertReceiptLineOnAfterInitPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer)
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
        WhseShipmentLine: Record "Warehouse Shipment Line";
        WhseReceive: Boolean;
        WhsePostRcpt: Codeunit "Whse.-Post Receipt";
        PostedWhseRcptHeader: Record "Posted Whse. Receipt Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        WhseShip: Boolean;
        WhsePostShpt: Codeunit "Whse.-Post Shipment";
        PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        TempGLE: Record TempGLE;

    begin




        //  TempGLE.DeleteAll();
        if (PurchLine.Type = PurchLine.Type::"Fixed Asset") and (PurchLine."Qty. to Receive" <> 0) then begin

            //kao ako ima već da je samo otvori, a ako je nema, da je kreira
            //ako je primka ili otprema

            WhseRcptLine.Reset();
            WhseRcptLine.SetFilter("Source No.", '%1', PurchRcptLine."Order No.");
            WhseRcptLine.SetFilter("Item No.", '%1', PurchRcptLine."No.");
            if WhseRcptLine.FindFirst() then
                WhseRcptLine.CalcSums(Quantity);
            if WhseRcptLine.Quantity > 0 then
                WhseReceive := true
            else
                WhseReceive := false;

            WhseShipmentLine.Reset();
            WhseShipmentLine.SetFilter("Source No.", '%1', PurchRcptLine."Order No.");
            WhseShipmentLine.SetFilter("Item No.", '%1', PurchRcptLine."No.");
            WhseShipmentLine.CalcSums(Quantity);
            if WhseShipmentLine.FindFirst() then
                if WhseShipmentLine.Quantity > 0 then
                    WhseShip := true
                else
                    WhseShip := false;

            if WhseReceive then
                if WhseRcptLine.GetWhseRcptLine(
                     WhseRcptLine."No.", DATABASE::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.")
                then begin
                    WhseRcptLine.TestField("Qty. to Receive", PurchRcptLine.Quantity);
                    SaveTempWhseSplitSpec2(PurchLine);
                    //MAYBE
                    WhsePostRcpt.CreatePostedRcptLine(
              WhseRcptLine, PostedWhseRcptHeader, PostedWhseRcptLine, TempWhseSplitSpecification);
                    TempGLE.reset;
                    TempGLE.SetFilter("Document No.", '<>%1', PurchLine."Document No.");
                    TempGLE.SetFilter("User ID", '%1', UserId);
                    if TempGLE.FindSet() then
                        repeat
                            TempGLE.Delete();
                        until TempGLE.Next() = 0;

                    TempGLE.reset;
                    TempGLE.SetFilter("Document No.", '%1', PurchLine."Document No.");
                    TempGLE.SetFilter("Entry No.", '%1', WhseRcptLine."Line No.");
                    if TempGLE.findfirst then TempGLE.Delete();




                    TempGLE.reset;
                    TempGLE.Init();
                    TempGLE."Entry No." := WhseRcptLine."Line No.";
                    TempGLE.Description := WhseRcptLine."Item No.";
                    TempGLE."Document No." := WhseRcptLine."No.";
                    TempGLE."User ID" := UserId;
                    TempGLE.Insert();
                end;

            if WhseShip then
                if WhseShipmentLine.GetWhseShptLine(
                     WhseShipmentLine."No.", DATABASE::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.")
                then begin
                    WhseShipmentLine.TestField("Qty. to Ship", -PurchRcptLine.Quantity);
                    SaveTempWhseSplitSpec2(PurchLine);
                    //MAYBE
                    WhsePostShpt.CreatePostedShptLine(
                   WhseShipmentLine, PostedWhseShptHeader, PostedWhseShptLine, TempWhseSplitSpecification);


                    TempGLE.reset;
                    TempGLE.SetFilter("Document No.", '<>%1', PurchLine."Document No.");
                    TempGLE.SetFilter("User ID", '%1', UserId);
                    if TempGLE.FindSet() then
                        repeat
                            TempGLE.Delete();
                        until TempGLE.Next() = 0;


                    TempGLE.reset;
                    TempGLE.SetFilter("Document No.", '%1', PurchLine."Document No.");
                    TempGLE.SetFilter("Entry No.", '%1', WhseRcptLine."Line No.");
                    if TempGLE.findfirst then TempGLE.Delete();
                    TempGLE.reset;
                    TempGLE.Init();
                    TempGLE."Entry No." := WhseShipmentLine."Line No.";
                    TempGLE.Description := WhseShipmentLine."Item No.";
                    TempGLE."Document No." := WhseShipmentLine."No.";
                    TempGLE."User ID" := UserId;
                    TempGLE.Insert();


                end;
            //ĐK  PurchRcptLine."Item Rcpt. Entry No." := InsertRcptEntryRelation2(PurchRcptLine);
            //ĐK PurchRcptLine."Item Charge Base Amount" := Round(CostBaseAmount / PurchLine.Quantity * PurchRcptLine.Quantity);

            //DJEMINA   PurchRcptLine.Insert(true);
        end;


    end;




    local procedure InsertRcptEntryRelation2(var PurchRcptLine: Record "Purch. Rcpt. Line"): Integer
    var
        ItemEntryRelation: Record "Item Entry Relation";
        TempTrackingSpecificationInv: Record "Tracking Specification" temporary;
    begin
        TempHandlingSpecification.CopySpecification(TempTrackingSpecificationInv);
        TempHandlingSpecification.Reset();
        if TempHandlingSpecification.FindSet() then begin
            repeat
                ItemEntryRelation.InitFromTrackingSpec(TempHandlingSpecification);
                ItemEntryRelation.TransferFieldsPurchRcptLine(PurchRcptLine);
                ItemEntryRelation.Insert();
            until TempHandlingSpecification.Next() = 0;
            TempHandlingSpecification.DeleteAll();
            exit(0);
        end;

    end;

    procedure SaveTempWhseSplitSpec2(PurchLine3: Record "Purchase Line")

    begin
        TempWhseSplitSpecification.Reset();
        TempWhseSplitSpecification.DeleteAll();
        if TempHandlingSpecification.FindSet() then
            repeat
                TempWhseSplitSpecification := TempHandlingSpecification;
                TempWhseSplitSpecification."Source Type" := DATABASE::"Purchase Line";
                TempWhseSplitSpecification."Source Subtype" := PurchLine3."Document Type".AsInteger();
                TempWhseSplitSpecification."Source ID" := PurchLine3."Document No.";
                TempWhseSplitSpecification."Source Ref. No." := PurchLine3."Line No.";
                TempWhseSplitSpecification.Insert();
            until TempHandlingSpecification.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Report, 5753, 'OnAfterPurchaseLineOnPreDataItem', '', true, true)]
    procedure OnAfterPurchaseLineOnPreDataItemP(var PurchaseLine: Record "Purchase Line"; OneHeaderCreated: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; WhseReceiptHeader: Record "Warehouse Receipt Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin
        //ĐK  PurchaseLine.SetRange(Type, PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset");
    end;

    [EventSubscriber(ObjectType::Report, 5753, 'OnBeforeWhseReceiptHeaderInsert', '', true, true)]
    procedure OnBeforeWhseReceiptHeaderInsert(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseRequest: Record "Warehouse Request")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        PH: Record "Purchase Header";
        TH: Record "Transfer Header";

    begin
        //ĐK  PurchaseLine.SetRange(Type, PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset");
        PH.Reset();
        PH.SetFilter("No.", '%1', WarehouseRequest."Source No.");
        if PH.FindFirst() then begin
            WarehouseReceiptHeader."Vendor No." := PH."Buy-from Vendor No.";
            WarehouseReceiptHeader."Vendor Name" := PH."Buy-from Vendor Name";
            WarehouseReceiptHeader."User ID Number" := ph."User ID Number";
        end;
        if WarehouseRequest."Source Type" = 5741 then begin
            TH.Reset();
            TH.SetFilter("No.", '%1', WarehouseRequest."Source No.");
            if Th.FindFirst() then begin
                WarehouseReceiptHeader."Sales Header No." := th."Sales Header No.";
                WarehouseReceiptHeader."RN Source" := th."RN Source";
                WarehouseReceiptHeader.Address := th.Address;
                WarehouseReceiptHeader."Department Code" := th."Department Code";
            end;

        end;
    end;


    [EventSubscriber(ObjectType::Report, 5753, 'OnAfterSalesLineOnPreDataItem', '', true, true)]
    procedure OnAfterSalesLineOnPreDataItem(var SalesLine: Record "Sales Line"; OneHeaderCreated: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; WhseReceiptHeader: Record "Warehouse Receipt Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin
        //ĐK  PurchaseLine.SetRange(Type, PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset");
        SalesLine.SetFilter(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::"Fixed Asset");
    end;

    [EventSubscriber(ObjectType::Report, 5753, 'OnBeforeVerifySalesItemNotBlocked', '', true, true)]
    procedure OnBeforeVerifySalesItemNotBlocked(SalesHeaer: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin
        IsHandled := true;

    end;





    //local procedure OnBeforeGetSourceDocumentsRun(var GetSourceDocuments: Report "Get Source Documents"; WarehouseRequest: Record "Warehouse Request"; ServVendDocNo: Code[20])

    [EventSubscriber(ObjectType::Codeunit, 5751, 'OnBeforeGetSourceDocumentsRun', '', true, true)]
    procedure OnBeforeGetSourceDocumentsRun(var GetSourceDocuments: Report "Get Source Documents"; WarehouseRequest: Record "Warehouse Request"; ServVendDocNo: Code[20])
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        GetSourceDocuments2: Report "Get Source Fixed Asset";
        ImaOS: Boolean;
        PO: Record "Purchase Line";
        SL: Record "Sales Line";
        SIL: Record "Service Item Line";

    begin

        //OnBeforeGetSourceDocumentsRun
        ImaOS := false;

        if (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Order") or (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Return Order") then begin
            PO.Reset();
            PO.SetFilter("Document No.", '%1', WarehouseRequest."Source No.");
            PO.SetFilter(Type, '%1', PO.Type::"Fixed Asset");
            if Po.FindFirst() then
                ImaOS := true;
        end;

        if (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order") or (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Return Order") then begin
            SL.Reset();
            SL.SetFilter("Document No.", '%1', WarehouseRequest."Source No.");
            SL.SetFilter(Type, '%1', PO.Type::"Fixed Asset");
            if SL.FindFirst() then
                ImaOS := false;
        end;



        Commit();
        if ImaOS then begin
            Clear(GetSourceDocuments2);

            //samo provjeriti da li treba onaj dio sa OS
            GetSourceDocuments2.UseRequestPage(false);
            GetSourceDocuments2.SetTableView(WarehouseRequest);
            GetSourceDocuments2.SetHideDialog(true);

            GetSourceDocuments2.run
            ;
            Commit();
        end;

        GetSourceDocuments.SetSkipBlockedItem(false);
        GetSourceDocuments.SetHideDialog(true);






    end;

    //OnBeforeWarehouseRequestOnAfterGetRecord(var WarehouseRequest: Record "Warehouse Request"; var WhseHeaderCreated: Boolean; var SkipRecord: Boolean; var BreakReport: Boolean; RequestType: Option Receive,Ship; var WhseReceiptHeader: Record "Warehouse Receipt Header"; var WhseShptHeader: Record "Warehouse Shipment Header"; OneHeaderCreated: Boolean)

    [EventSubscriber(ObjectType::Report, 5753, 'OnBeforeWarehouseRequestOnAfterGetRecord', '', true, true)]
    procedure OnBeforeWarehouseRequestOnAfterGetRecord(var WarehouseRequest: Record "Warehouse Request"; var WhseHeaderCreated: Boolean; var SkipRecord: Boolean; var BreakReport: Boolean; RequestType: Option Receive,Ship; var WhseReceiptHeader: Record "Warehouse Receipt Header"; var WhseShptHeader: Record "Warehouse Shipment Header"; OneHeaderCreated: Boolean)
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        ImaOS: Boolean;
        PO: Record "Purchase Line";
        SL: Record "Sales Line";

    begin

        //ĐK TEST
        ImaOS := false;

        if (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Order") or (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Return Order") then begin
            PO.Reset();
            PO.SetFilter("Document No.", '%1', WarehouseRequest."Source No.");
            PO.SetFilter(Type, '%1', PO.Type::"Fixed Asset");
            if Po.FindFirst() then
                ImaOS := true;
        end;

        if (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order") or (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Return Order") then begin
            SL.Reset();
            SL.SetFilter("Document No.", '%1', WarehouseRequest."Source No.");
            SL.SetFilter(Type, '%1', PO.Type::"Fixed Asset");
            if SL.FindFirst() then
                ImaOS := false;
        end;
        if imaos = true then begin
            SkipRecord := true;
            BreakReport := true;
        end
    end;


    [EventSubscriber(ObjectType::Report, 5753, 'OnBeforePurchaseLineOnAfterGetRecord', '', true, true)]
    procedure OnBeforePurchaseLineOnAfterGetRecord(PurchaseLine: Record "Purchase Line"; WarehouseRequest: Record "Warehouse Request"; RequestType: Option; var IsHandled: Boolean)
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        ImaOS: Boolean;
        PO: Record "Purchase Line";
        SL: Record "Sales Line";

    begin

        ImaOS := false;

        if (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Order") or (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Return Order") then begin
            PO.Reset();
            PO.SetFilter("Document No.", '%1', WarehouseRequest."Source No.");
            PO.SetFilter(Type, '%1', PO.Type::"Fixed Asset");
            if Po.FindFirst() then
                ImaOS := true;
        end;

        if (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order") or (WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Return Order") then begin
            SL.Reset();
            SL.SetFilter("Document No.", '%1', WarehouseRequest."Source No.");
            SL.SetFilter(Type, '%1', PO.Type::"Fixed Asset");
            if SL.FindFirst() then
                ImaOS := false;
        end;
        if ImaOs = true then
            IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Get Source Documents" then
            NewReportId := Report::"Get Source Fixed Asset";
    end;


    var
        TempWhseSplitSpecification: Record "Tracking Specification" temporary;
        TempHandlingSpecification: Record "Tracking Specification" temporary;



    //test

    // The following code creates codeunit that publishes the `OnAddressLineChanged` event.


    [IntegrationEvent(false, false)]
    procedure CreateWhseItemTrackingLines(skip: Boolean)
    begin
    end;

    //biti će kao da modifikujem neki dio codeunit-a

    // The following code extends the Customer Card page to raise the `OnAddressLineChanged` event
    // when the Address field is changed.


}
