codeunit 50018 TestSubsCu
{

    EventSubscriberInstance = StaticAutomatic;


    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromServHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromServHeader(ServiceHeader: Record "Service Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."VAT Date" := ServiceHeader."VAT Date";
        GenJournalLine."Bill Type" := ServiceHeader."Bill Type";
        GenJournalLine."Bill Category" := ServiceHeader."Bill Category";
        GenJournalLine."Customer Category" := ServiceHeader."Customer Category";
        GenJournalLine."Sales Header No." := ServiceHeader."No.";
        GenJournalLine."Posting Group" := ServiceHeader."Customer Posting Group";
        GenJournalLine."Department Code" := ServiceHeader."Department Code";
        ServiceHeader.calcfields(Amount);
        IF (ServiceHeader.Amount = 0)
        and ((ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"General Geo. Work Order") or
        (ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"General Geo. Work Order Office")
        or (ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"General Work Order")
        or (ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"Work Execution Request"))
         then
            message('Morate unijeti cijenu');
    end;


    // [IntegrationEvent(true, false)]

    //OnBeforeServItemLinesExistErr

    [EventSubscriber(ObjectType::Table, database::"Service Item", 'OnBeforeServItemLinesExistErr', '', true, true)]
    local procedure OnBeforeServItemLinesExistErr(var ServiceItem: Record "Service Item"; ChangedFieldName: Text[100]; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeApplyCustLedgEntry', '', true, true)]
    local procedure OnBeforeApplyCustLedgEntry(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var GenJnlLine: Record "Gen. Journal Line"; Cust: Record Customer; var IsAmountToApplyCheckHandled: Boolean)
    var

        RequestGL: record "G/L Entry";
        CustLedg: Record "Cust. Ledger Entry";
        US: Record "User Setup";

    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.Findfirst then begin
            if us.Advance = true then begin
                if GenJnlLine.Prepayment = true then begin
                    Cust."Application Method" := cust."Application Method"::Manual;

                end;

            end;

        end;
        if (GenJnlLine."Sales Header No." <> '') then begin

            RequestGL.Reset();
            RequestGL.SetFilter("Document Type", '%1', RequestGL."Document Type"::Payment);
            RequestGL.SetFilter("Request Document", '%1', GenJnlLine."Sales Header No.");
            RequestGL.SetFilter("Source No.", '%1', GenJnlLine."Source No.");
            RequestGL.SetFilter("Source Type", '%1', GenJnlLine."Source Type");
            if RequestGL.FindFirst() then begin


                CustLedg.Reset();
                CustLedg.SetFilter("Customer No.", '%1', GenJnlLine."Source No.");
                CustLedg.SetFilter("Document Type", '%1', RequestGL."Document Type");
                CustLedg.SetFilter("Document No.", '%1', RequestGL."Document No.");
                CustLedg.SetFilter("Posting Date", '%1', RequestGL."Posting Date");
                CustLedg.SetFilter(Open, '%1', true);
                if CustLedg.FindFirst() then begin
                    CustLedg.CalcFields("Remaining Amount");
                    if CustLedg."Remaining Amount" <> 0 then begin
                        GenJnlLine."Applies-to Doc. Type" := CustLedg."Document Type";
                        GenJnlLine."Applies-to Doc. No." := CustLedg."Document No.";
                    end;
                end;

            end;
        end;

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry', '', true, true)]
    local procedure OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var

        us: Record "User Setup";
    begin


        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us.Advance = true then begin
                if GenJournalLine.Prepayment = true then begin
                    //    Cust."Application Method" := cust."Application Method"::Manual;
                    GenJournalLine."Allow Application" := false;

                end;

            end;
        end;
    end;







    //OnPrepareTempCustLedgEntryOnBeforeTempOldCustLedgEntryInsert

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPrepareTempCustLedgEntryOnBeforeTempOldCustLedgEntryInsert', '', true, true)]
    local procedure OnPrepareTempCustLedgEntryOnBeforeTempOldCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin


    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPrepareTempCustLedgEntryOnAfterSetFiltersByAppliesToId', '', true, true)]
    local procedure OnPrepareTempCustLedgEntryOnAfterSetFiltersByAppliesToId(var OldCustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    var
        UserSetup: record "User Setup";
    begin
        UserSetup.reset;
        UserSetup.setfilter("User ID", '%1', USERID);
        if UserSetup.findfirst then begin
            if UserSetup.Advance = true then begin
                if GenJournalLine.Prepayment = true then begin
                    //    Cust."Application Method" := cust."Application Method"::Manual;
                    GenJournalLine."Allow Application" := false;
                    OldCustLedgerEntry.SetFilter("Posting Date", '%1', 0D);
                end;


                if (GenJournalLine."Bill type" = '01') or (GenJournalLine."Bill type" = '02') or (GenJournalLine."Bill type" = '03') then begin
                    //    Cust."Application Method" := cust."Application Method"::Manual;
                    //    GenJournalLine."Allow Application" := false;
                    GenJournalLine."Allow Application" := false;
                    //  OldCustLedgerEntry.SetFilter("Entry No.", '<>%1', OldCustLedgerEntry."Entry No.");
                    OldCustLedgerEntry.SetFilter("Posting Date", '%1', 0D);



                end;

            end;
        end;
    end;



    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
        SL: Record "Sales Line";

    begin
        GenJournalLine."Note 1" := SalesHeader."Note 1";
        GenJournalLine."VAT Date" := SalesHeader."VAT Date";
        GenJournalLine.Prepayment := SalesHeader.Prepayment;
        GenJournalLine.KIF_Entry := SalesHeader.KIF_Entry;
        GenJournalLine.Prepayment := SalesHeader.Prepayment;
        GenJournalLine."Payment Reference" := SalesHeader."Payment Reference";
        GenJournalLine."Bill Type" := SalesHeader."Bill Type";
        GenJournalLine."Bill Category" := SalesHeader."Bill Category";
        GenJournalLine."Customer Category" := SalesHeader."Customer Category";
        GenJournalLine."Sales Header No." := SalesHeader."No.";
        GenJournalLine."Department Code" := SalesHeader."Department Code";
        SL.Reset();
        SL.SetFilter("Document No.", '%1', SalesHeader."Document No_");
        SL.SetFilter("Document Type", '%1', SalesHeader."Document Type");
        if sl.FindFirst() then begin
            sl.CalcSums(sl."VAT Difference CNG");
            GenJournalLine."VAT Difference CNG" := sl."VAT Difference CNG";

        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 57, 'OnAfterPurchDeltaUpdateTotals', '', true, true)]
    local procedure OnAfterPurchDeltaUpdateTotals(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var TotalPurchaseLine: Record "Purchase Line"; var VATAmount: Decimal; var InvoiceDiscountAmount: Decimal; var InvoiceDiscountPct: Decimal)
    var
        VATRoundingDelta: decimal;
    begin
        //AMIR - Ažuriraj totale nakon unosa VAT Rounding vrijednosti
        if PurchaseLine."VAT Prod. Posting Group" = 'PDV0' then begin
            PurchaseLine."VAT Rounding" := 0;
            PurchaseLine."Amount Including VAT" += VATRoundingDelta;
            PurchaseLine."Outstanding Amount" += VATRoundingDelta;
            PurchaseLine."Outstanding Amount (LCY)" += VATRoundingDelta;
            VATAmount += VATRoundingDelta;
            TotalPurchaseLine."Amount Including VAT" += VATRoundingDelta; //
        end else begin
            VATRoundingDelta := PurchaseLine."VAT Rounding" - xPurchaseLine."VAT Rounding";
            if VATRoundingDelta <> 0 then begin
                PurchaseLine."Amount Including VAT" += VATRoundingDelta;
                PurchaseLine."Outstanding Amount" += VATRoundingDelta;
                PurchaseLine."Outstanding Amount (LCY)" += VATRoundingDelta;
                VATAmount += VATRoundingDelta;
                TotalPurchaseLine."Amount Including VAT" += VATRoundingDelta; //
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 57, 'OnAfterCalculatePurchaseSubPageTotals', '', true, true)]
    local procedure OnAfterCalculatePurchaseSubPageTotals(var TotalPurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var VATAmount: Decimal; var InvoiceDiscountAmount: Decimal; var InvoiceDiscountPct: Decimal; var TotalPurchaseLine2: Record "Purchase Line")
    var
        VATRoundingDelta: decimal;
    begin
        //AMIR - Ažuriraj totale nakon brisanja retka Narudzbenice
        if TotalPurchLine."VAT Prod. Posting Group" = 'PDV0' then begin
            TotalPurchaseLine2."VAT Rounding" := 0;
            VATRoundingDelta := TotalPurchaseLine2."VAT Rounding";

            TotalPurchaseLine2."Amount Including VAT" += VATRoundingDelta;
            TotalPurchaseLine2."Outstanding Amount" += VATRoundingDelta;
            TotalPurchaseLine2."Outstanding Amount (LCY)" += VATRoundingDelta;
            VATAmount += VATRoundingDelta;
        end else begin
            VATRoundingDelta := TotalPurchaseLine2."VAT Rounding";
            if VATRoundingDelta <> 0 then begin
                TotalPurchaseLine2."Amount Including VAT" += VATRoundingDelta;
                TotalPurchaseLine2."Outstanding Amount" += VATRoundingDelta;
                TotalPurchaseLine2."Outstanding Amount (LCY)" += VATRoundingDelta;
                VATAmount += VATRoundingDelta;
            end;
        end;
    end;


    //

    [EventSubscriber(ObjectType::Codeunit, 11, 'OnBeforeCheckSalesDocNoIsNotUsed', '', true, true)]
    local procedure OnBeforeCheckSalesDocNoIsNotUsed(DocType: Option; DocNo: Code[20]; var IsHandled: Boolean; GenJournalLine: Record "Gen. Journal Line")

    begin
        // if GenJournalLine.sou
        if GenJournalLine."Source Code" = 'SERVIS' then
            IsHandled := true;
    end;









    //
    [EventSubscriber(ObjectType::Page, Page::"Items by Location", 'OnAfterSetTempMatrixLocationFilters', '', true, true)]
    local procedure OnAfterSetTempMatrixLocationFilters(var TempMatrixLocation: Record Location temporary);

    begin
        TempMatrixLocation.setcurrentkey(Order);
        TempMatrixLocation.ascending;
    end;

    //"Transfer Header"

    [EventSubscriber(ObjectType::Table, database::"Transfer Header", 'OnDeleteOneTransferOrderOnBeforeTransHeaderDelete', '', true, true)]

    local procedure OnDeleteOneTransferOrderOnBeforeTransHeaderDelete(var TransferHeader: Record "Transfer Header"; var HideValidationDialog: Boolean)
    var
        Location: Record Location;
    begin
        if (TransferHeader."Transfer-to Code" <> '') then begin
            Location.Reset();
            Location.SetFilter(Code, '%1', TransferHeader."Transfer-to Code");
            if Location.FindFirst() then begin
                if (Location."CNG MP" = true) or (Location."CNG VP" = true) or (Location."CNG VL" = true) then
                    HideValidationDialog := true;
            end;

        end;

        if (TransferHeader."Transfer-from Code" <> '') then begin
            Location.Reset();
            Location.SetFilter(Code, '%1', TransferHeader."Transfer-from Code");
            if Location.FindFirst() then begin
                if (Location."CNG MP" = true) or (Location."CNG VP" = true) or (Location."CNG VP" = true) then
                    HideValidationDialog := true;
            end;

        end;




    end;

    //
    //CopyFromTransferHeader
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnValidateAccountNoOnAfterAssignValue', '', true, true)]
    local procedure OnValidateAccountNoOnAfterAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    begin
        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then begin
            IF GenJournalLine."Journal Template Name" <> 'SREDSTVA' THEN BEGIN
                GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
                GenJournalLine."Gen. Bus. Posting Group" := '';
                // "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                GenJournalLine."Gen. Prod. Posting Group" := '';
                GenJournalLine."VAT Bus. Posting Group" := '';
                GenJournalLine."VAT Prod. Posting Group" := '';
                GenJournalLine."Bal. Gen. Posting Type" := GenJournalLine."Bal. Gen. Posting Type"::" ";
                GenJournalLine."Bal. VAT Bus. Posting Group" := '';
                GenJournalLine."Bal. VAT Prod. Posting Group" := '';
                GenJournalLine."Bal. Gen. Bus. Posting Group" := '';
                GenJournalLine."Bal. Gen. Prod. Posting Group" := '';
                GenJournalLine."FA Posting Type" := GenJournalLine."FA Posting Type"::" ";
            END;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, true)]
    local procedure OnBeforeDrillDownDocAttachmentFactbox(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ServiceItemLine: Record "Service Item Line";
        ServiceItemLineH: Record "Service Item Line";
        ServiceLineHeader: Record "Service Header";
    begin
        if DocumentAttachment."Table ID" = Database::"Service Item Line" then begin
            RecRef.Open(DATABASE::"Service Item Line");
            if ServiceItemLine.Get(Enum::"Service Document Type"::Order, DocumentAttachment."No.", DocumentAttachment."Line No.") then
                RecRef.GetTable(ServiceItemLine);
        end;
        if DocumentAttachment."Table ID" = Database::"Service Header" then begin
            RecRef.Open(DATABASE::"Service Header");
            ServiceLineHeader.Reset();
            ServiceLineHeader.SetFilter("No.", '%1', DocumentAttachment."No.");
            if ServiceLineHeader.FindFirst() then
                RecRef.GetTable(ServiceLineHeader);
        end;
    end;

    //   [IntegrationEvent(false, false)]

    [EventSubscriber(ObjectType::Table, database::"Service Item Line", 'OnValidateServiceItemNoOnBeforeCheckXRecServiceItemNo', '', true, true)]
    local procedure OnValidateServiceItemNoOnBeforeCheckXRecServiceItemNo(var ServiceItemLine: Record "Service Item Line"; xServiceItemLine: Record "Service Item Line"; var ServLine: Record "Service Line"; var ServItem: Record "Service Item"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, database::"Service Item Line", 'OnBeforeUpdateResponseTimeHours', '', true, true)]
    local procedure OnBeforeUpdateResponseTimeHours(var ServiceItemLine: Record "Service Item Line"; xServiceItemLine: Record "Service Item Line"; SkipResponseTimeHrsUpdate: Boolean; var IsHandled: Boolean)
    var
        SH: record "Service Header";
    begin
        SH.Reset();
        sh.SetFilter("No.", '%1', ServiceItemLine."Document No.");
        if sh.FindFirst() then begin
            if (sh."Order Date" = 0D) or (sh."Order Time" = 0T) then begin
                IsHandled := true;
            end
            else begin
                if sh."Order Date" = 0D then
                    sh."Order Date" := today;
                if sh."Order Time" = 0T then
                    sh."Order Time" := Time;
                sh.Modify();
            end;
        end;

    end;


    //
    [EventSubscriber(ObjectType::Table, database::"Service Item Line", 'OnBeforeCheckServItemCustomer', '', true, true)]
    local procedure OnBeforeCheckServItemCustomer(ServiceHeader: Record "Service Header"; ServiceItem: Record "Service Item"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', true, true)]
    local procedure OnAfterOpeForRecRefDocAttDetails(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
    begin
        if RecRef.Number = Database::"Service Item Line" then begin
            FieldRef := RecRef.Field(1);
            RecNo := FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);

            FieldRef := RecRef.Field(2);
            LineNo := FieldRef.Value;
            DocumentAttachment.SetRange("Line No.", LineNo);
        end;

        if RecRef.Number = Database::"Service Header" then begin
            FieldRef := RecRef.Field(1);
            DocType := FieldRef.Value;
            DocumentAttachment.SetRange("Document Type", DocType);

            FieldRef := RecRef.Field(3);
            RecNo := FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);

            FlowFieldsEditable := false;
        end;

    end;

    [EventSubscriber(ObjectType::Table, database::"Document Attachment", 'OnBeforeInsertAttachment', '', true, true)]
    local procedure OnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin


    end;



    [EventSubscriber(ObjectType::Codeunit, 5988, 'OnBeforeServShptItemLineInsert', '', true, true)]

    local procedure OnBeforeServShptItemLineInsert(var ServiceShptItemLine: Record "Service Shipment Item Line"; ServiceItemLine: Record "Service Item Line")

    var


    begin


    end;

    [EventSubscriber(ObjectType::Codeunit, 5988, 'OnBeforeServInvLineInsert', '', true, true)]

    local procedure OnBeforeServInvLineInsert(var ServiceInvoiceLine: Record "Service Invoice Line"; ServiceLine: Record "Service Line")
    begin
        ServiceInvoiceLine."Transfer Order" := ServiceLine."Transfer Order";
        ServiceInvoiceLine."Request Resource Type" := ServiceLine."Request Resource Type";
        ServiceInvoiceLine."Resource Connection Type" := ServiceLine."Resource Connection Type";
        ServiceInvoiceLine."Resource No." := ServiceLine."Resource No.";
        ServiceInvoiceLine."Resource Name" := ServiceLine."Resource Name";
        ServiceInvoiceLine."Planned Quantity" := ServiceLine."Planned Quantity";
        ServiceInvoiceLine.Intent := ServiceLine.Intent;
        ServiceInvoiceLine."Resource Quantity" := ServiceLine."Resource Quantity";
        ServiceInvoiceLine."Education Level" := ServiceLine."Education Level";
        ServiceInvoiceLine."Internal Employees" := ServiceLine."Internal Employees";
        ServiceInvoiceLine."Unit of Measure Code2" := ServiceLine."Unit of Measure Code2";
        ServiceInvoiceLine."Request Resource Type1" := ServiceLine."Request Resource Type1";
        ServiceInvoiceLine."RN Type" := ServiceLine."RN Type";
        ServiceInvoiceLine."Quantity RN" := ServiceLine."Quantity RN";

    end;


    [EventSubscriber(ObjectType::Codeunit, 5988, 'OnBeforeServInvHeaderInsert', '', true, true)]

    local procedure OnBeforeServInvHeaderInsert(var ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceHeader: Record "Service Header")

    var

    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 13, 'OnAfterCode', '', true, true)]


    local procedure OnAfterCode(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean)
    var

        CJL: Record "Calculation Journal Line";
    begin

        if (GenJournalLine."Bill type" in ['01', '02', '03']) and (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) then begin
            CJL.Reset();
            CJL.SetFilter("Customer No.", '%1', GenJournalLine."Account No.");
            cjl.SetFilter(Locked, '%1', false);
            if cjl.FindSet() then
                repeat
                    if cjl."Calculation Date To" >= GenJournalLine."Posting Date" then begin
                        cjl."Difference Balance" := true;
                        cjl.Modify();
                        //Commit();
                    end;
                until cjl.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 13, 'OnAfterUpdateLineBalance', '', true, true)]

    local procedure OnAfterUpdateLineBalance(var GenJournalLine: Record "Gen. Journal Line")

    var
    begin
        if (GenJournalLine.Correction = true) and ((GenJournalLine."Debit Correction" <> 0) or (GenJournalLine."Credit Correction" <> 0)) then begin

            GenJournalLine."Debit Amount" := GenJournalLine."Debit Correction";
            GenJournalLine."Credit Amount" := GenJournalLine."Credit Correction";

        end;



















    end;



    [EventSubscriber(ObjectType::Codeunit, 1330, 'OnBeforeIsUnpostedEnabledForRecord', '', true, true)]

    procedure OnBeforeIsUnpostedEnabledForRecord(RecVariant: Variant; var Enabled: Boolean; var IsHandled: Boolean)

    var
    begin
        IsHandled := true;
    end;




    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostFixedAssetOnBeforeInsertGLEntry', '', true, true)]
    local procedure OnPostFixedAssetOnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; var TempFAGLPostBuf: Record "FA G/L Posting Buffer" temporary)

    var
        FAPostingGr: Record "FA Posting Group";
        GJournalBatch: Record "Gen. Journal Batch";


    begin
        GLEntry."Payment Type Code" := GenJournalLine."Payment Type";
        GLEntry."Bill Category" := GenJournalLine."Bill Category";
        GLEntry."Bill type" := GenJournalLine."Bill type";

        GJournalBatch.Reset();
        GJournalBatch.SetFilter("Journal Template Name", '%1', GenJournalLine."Journal Template Name");
        GJournalBatch.SetFilter(Name, '%1', GenJournalLine."Journal Batch Name");
        GJournalBatch.SetFilter(Commissioning, '%1', true);

        if GJournalBatch.FindFirst() then begin


            if GenJournalLine."FA Posting Type" = GenJournalLine."FA Posting Type"::"Acquisition Cost" then begin

                if GenJournalLine."Posting Group" <> '' then begin

                    FAPostingGr.get(GenJournalLine."Posting Group");

                    if (FAPostingGr."Investment Account" <> '') and (GenJournalLine.Description <> 'A') then begin

                        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then
                            GenJournalLine.validate("Account No.", FAPostingGr."Investment Account");

                        GLEntry.validate("G/L Account No.", FAPostingGr."Investment Account");
                    end

                    else begin
                        /*   if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then
                               GenJournalLine.validate("Account No.", FAPostingGr."Acquisition Cost Account");
                           GLEntry.Validate("G/L Account No.", FAPostingGr."Acquisition Cost Account");*/
                    end;
                end;
            end;

        end;

    end;


    //5802


    [EventSubscriber(ObjectType::Codeunit, 50000, 'OnBeforeNewSalesShptLineInsert', '', true, true)]

    local procedure OnBeforeNewSalesShptLineInsert(var NewSalesShipmentLine: Record "Sales Shipment Line"; OldSalesShipmentLine: Record "Sales Shipment Line")
    begin
        NewSalesShipmentLine.Amount := -NewSalesShipmentLine.Amount;
        NewSalesShipmentLine."Amount Incl. VAT" := -NewSalesShipmentLine."Amount Incl. VAT";

    end;






    [EventSubscriber(ObjectType::Codeunit, 5802, 'OnPostInvtPostBufOnAfterInitGenJnlLine', '', true, true)]
    local procedure OnPostInvtPostBufOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var ValueEntry: Record "Value Entry")



    var
        SignValue: Integer;

        TransferH: Record "Transfer Header";

        LocationH: Record Location;

    begin
        GenJournalLine."Hide PP" := false;


        if ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Invoice" then
            GenJournalLine."Transfer Header" := false;
        if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Transfer Receipt") or (valueEntry."Document Type" = ValueEntry."Document Type"::"Transfer Shipment") then
            GenJournalLine."Transfer Header" := true;
        GenJournalLine."Document Type_2" := ValueEntry."Document Type";
        GenJournalLine."Retail RUC" := ValueEntry."Retail RUC";
        GenJournalLine.Correction := ValueEntry."G/L Correction";
        GenJournalLine."R. CNG MP" := ValueEntry."R. CNG MP";
        GenJournalLine."Sales Header No." := ValueEntry."Sales Header No.";
        GenJournalLine."Hide CNG MP" := ValueEntry."Hide CNG MP";
        GenJournalLine."VAT Difference CNG" := ValueEntry."VAT Difference CNG";
        GenJournalLine."Retail Unit Price" := ValueEntry."Retail Unit Price";
        GenJournalLine."Retail Unit Price with VAT" := ValueEntry."Retail Unit Price with VAT";
        GenJournalLine."Retail VAT" := ValueEntry."Retail VAT";
        GenJournalLine."T.Retail Unit Price with VAT" := ValueEntry."T.Retail Unit Price with VAT";
        GenJournalLine."Total Retail Amount" := ValueEntry."Total Retail Amount";
        GenJournalLine."Calculate Retail VAT" := ValueEntry."Calculate Retail VAT";
        GenJournalLine."Department Code" := ValueEntry."Department Code";





        GenJournalLine."Wholesale RUC" := ValueEntry."Wholesale RUC";
        GenJournalLine."Wholesale Unit Price" := ValueEntry."Wholesale Unit Price";
        GenJournalLine."Wholesale Unit Price with VAT" := ValueEntry."Wholesale Unit Price with VAT";
        GenJournalLine."Wholesale VAT" := ValueEntry."Wholesale VAT";
        GenJournalLine."T.Wholesale Unit Price with V" := ValueEntry."T.Wholesale Unit Price with V";
        GenJournalLine."Total Wholesale Amount" := ValueEntry."Total Wholesale Amount";


        GenJournalLine."CNG MP" := ValueEntry."CNG MP";
        GenJournalLine."CNG VP" := ValueEntry."CNG VP";
        GenJournalLine."CNG VL" := ValueEntry."CNG VL";
        GenJournalLine.Nivelacija := ValueEntry.Nivelacija;
        /* if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Transfer Receipt") and ((ValueEntry."Location Code" = 'TEREN')
         OR ((ValueEntry."Location Code" = 'UPOTREBA')))

         then*/
        if ValueEntry."Order Type" = ValueEntry."Order Type"::Transfer then begin
            if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Transfer Receipt") then begin
                TransferH.Reset();
                TransferH.SetFilter("No.", '%1', ValueEntry."Order No.");
                if TransferH.FindFirst() then begin
                    LocationH.Reset();
                    LocationH.SetFilter(Code, '%1', TransferH."Transfer-to Code");
                    if LocationH.FindFirst() then begin
                        if LocationH."Hide PP" = true then
                            GenJournalLine."Hide PP" := true;

                    end;

                    LocationH.Reset();
                    LocationH.SetFilter(Code, '%1', TransferH."Transfer-from Code");
                    if LocationH.FindFirst() then begin
                        if LocationH."Hide PP" = true then
                            GenJournalLine."Hide PP" := true;

                    end;

                end;

            end;
        end;



        if GenJournalLine."Total Retail Amount" > 0 then
            GenJournalLine.Validate(Amount, GenJournalLine."T.Retail Unit Price with VAT")
        else
            GenJournalLine.Validate(Amount, GenJournalLine."Total Retail Amount");


        if GenJournalLine."Total Wholesale Amount" > 0 then
            GenJournalLine.Validate(Amount, GenJournalLine."T.Wholesale Unit Price with V")
        else
            GenJournalLine.Validate(Amount, GenJournalLine."Total Wholesale Amount");


        GenJournalLine."Prod Bus Posting" := ValueEntry."Prod Bus Posting";
        GenJournalLine."Gen Bus Posting" := ValueEntry."Gen Bus Posting";


    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitGLEntry', '', true, true)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        TempGLE: Record TempGLE;
        BrojRed: Integer;
        G: Record "General Ledger Setup";
        CalSetup: Record "Calculation Setup";
        Customer: Record customer;
        SalesPrice: Record "Sales Price";
        Item: Record item;
        RUP: Decimal;
        TRA: Decimal;
        RRUC: Decimal;
        VPS: Record "VAT Posting Setup";
        RUPVAT: Decimal;
        TRAVAT: Decimal;
        RRUCVAT: Decimal;
        GLEntryNew: Record "G/L Entry";
        GeneralPosting: Record "General Posting Setup";
        Calc: Record "Calculation Setup";
        PostDate: Date;
        NoSeries: Codeunit NoSeriesExtented;
        CPG: Record "Customer Posting Group";
        Prethodno: Boolean;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Loc: Record Location;
        Uknjizeno: Decimal;
        LocCNG: Record Location;
        GPostingS: Record "General Posting Setup";
        GPostingS2: Record "General Posting Setup";
        IntV: Decimal;
        StartU: Integer;
        SHL: Record "Sales Line";
        TempGLE2: Record TempGLE;
        SH: record "Sales Header";
        InV: Decimal;
        GLSe: Record "General Ledger Setup";
        IntValue: Integer;
        VatSetup: Record "VAT Posting Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        GKInventory: Integer;
        GKLine: Record "Sales Line";
        GKInventoryD: Integer;
        GKInventoryDi: integer;
        USerUpdate: Record "User Setup";
        hide: Integer;
    begin

        GLSe.get;
        Prethodno := false;



        if GLEntry."G/L Account No." = '21106' then begin
            USerUpdate.Reset();
            USerUpdate.SetFilter("User ID", '%1', UserId);
            if USerUpdate.FindFirst() then begin
                hide := GLEntry."Entry No.";
                USerUpdate.KIF_Entry := hide - 1;
                USerUpdate.Modify();
            end;
        end;

        USerUpdate.Reset();
        USerUpdate.SetFilter("User ID", '%1', UserId);
        if USerUpdate.FindFirst() then
            hide := USerUpdate.KIF_Entry;
        if GLEntry."Document No." = '***' then begin


            GLEntry."Document No." := NoSeries.GetNextNo('DOC_INIT', GLEntry."Posting Date", false);
            // Evaluate(IntValue,NoSeries.GetNextNo(GLSe."G_L Entry",GLEntry."Posting Date",false));
            //    GLEntry."New Order":=IntValue;
            Prethodno := true;
        end;

        TempGLE.reset;
        TempGLE.SetFilter("Document No.", '<>%1', GLEntry."Document No.");
        TempGLE.SetFilter("User ID", '%1', UserId);
        if TempGLE.FindSet() then
            repeat
                TempGLE.Delete();
            until TempGLE.Next() = 0;


        TempGLE.reset;
        TempGLE.SetFilter("Document No.", '%1', GLEntry."Document No.");
        TempGLE.SetFilter("User ID", '%1', UserId);
        BrojRed := TempGLE.Count + 1;



        TempGLE.reset;


        TempGLE.Init();
        TempGLE."Entry No." := BrojRed;
        TempGLE."User ID" := UserId;
        TempGLE."Transaction No." := GLEntry."Entry No.";
        TempGLE."Document No." := GLEntry."Document No.";
        TempGLE.Amount := GLEntry.Amount;
        TempGLE."System-Created Entry" := GenJournalLine.Correction;
        if GenJournalLine."Sales Header No." <> '' then
            TempGLE."Global Dimension 1 Code" := GenJournalLine."Sales Header No.";
        PostDate := GLEntry."Posting Date";
        TempGLE2.Reset();
        TempGLE2.SetFilter("Entry No.", '%1', TempGLE."Entry No.");
        TempGLE2.SetFilter("Document No.", '%1', TempGLE."Document No.");
        TempGLE2.SetFilter(Description, '%1', TempGLE.Description);

        if not TempGLE2.FindFirst() then TempGLE.Insert();
        g.get();

        if GenJournalLine."Sales Header No." = '' then begin

            TempGLE2.Reset();
            TempGLE2.SetFilter("Document No.", '%1', TempGLE."Document No.");
            TempGLE2.SetFilter(Description, '%1', TempGLE.Description);
            TempGLE2.SetFilter("User ID", '%1', UserId);
            TempGLE2.SetFilter("Global Dimension 1 Code", '<>%1', '');
            if TempGLE2.FindFirst() then
                GenJournalLine."Sales Header No." := TempGLE2."Global Dimension 1 Code";

        end;

        if Prethodno = true
         then
            GLEntry."Document No." := '***';



        Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntry."Posting Date", true));
        GLEntry."New Order" := IntValue;
        GLEntry."Payment Type Code" := GenJournalLine."Payment Type";
        GLEntry."Bill Category" := GenJournalLine."Bill Category";
        GLEntry."Bill type" := GenJournalLine."Bill type";

        if (GenJournalLine.Nivelacija = true) and (BrojRed = 2) then begin
            GPostingS.reset;
            GPostingS.SetFilter("Retail Receipt Account No.", '<>%1', '');
            if GPostingS.FindFirst() then begin
                //nivelacija
                //korigujem konto i unesem novi red
                GLEntry.Validate("G/L Account No.", GPostingS."Retail Receipt Account No.");
            end;

            GLEntryNew.Init();
            GLEntryNew.Copy(GLEntry);
            GLEntryNew."Entry No." := GLEntry."Entry No." + 1;
            Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
            GLEntryNew."New Order" := IntValue;
            GeneralPosting.Reset();

            GeneralPosting.SetFilter("Retail Account No.", '<>%1', '');
            if GeneralPosting.FindFirst() then
                GLEntryNew.Validate("G/L Account No.", GeneralPosting."Purch. Account");

            GLEntryNew.Validate(Amount, round(abs(GenJournalLine."Total Retail Amount" * (GenJournalLine."Retail VAT") / 100), G."Amount Rounding Precision"));
            //  GLEntryNew.Insert();
            GLEntryNew.Validate("Debit Amount", Abs(GLEntryNew.Amount));

            CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);


        end;




        if (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Sales Invoice") and ((GenJournalLine."CNG VP" = true) or (GenJournalLine."CNG MP" = true)) then begin


            if (BrojRed = 1) and (GenJournalLine."Transfer Header" = true)
            and (GenJournalLine."Hide CNG MP" = false)
            then begin


                if (GLEntry."Entry No." <= hide) or (hide = 0) then
                    GLEntry.Validate(Amount, round(GenJournalLine."T.Retail Unit Price with VAT", G."Amount Rounding Precision"));

                if (GenJournalLine.Correction = true) and ((GLEntry."Entry No." <= hide) or (hide = 0)) then
                    GLEntry.Validate(Amount, -GLEntry.Amount);
                //2 inserta da probam dodati (prvi zbir)

                //RUC

                if (GLEntry."Entry No." <= hide) or (hide = 0) then begin
                    GLEntryNew.Init();
                    GLEntryNew.Copy(GLEntry);
                    GLEntryNew."Entry No." := GLEntry."Entry No." + 5;
                    //GLEntryNew."New Order" := GLEntryNew."Entry No.";
                    Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                    GLEntryNew."New Order" := IntValue;

                    GeneralPosting.Reset();
                    if GenJournalLine."CNG MP" = true then begin

                        GeneralPosting.SetFilter("Retail Receipt Account No. MP", '<>%1', '');
                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No. MP");

                    end

                    else begin
                        GeneralPosting.SetFilter("Retail Receipt Account No.", '<>%1', '');
                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No.");

                    end;

                    GLEntryNew.Validate(Amount, round(abs(GenJournalLine."Retail RUC"), G."Amount Rounding Precision"));
                    //  GLEntryNew.Insert();
                    GLEntryNew.Validate("Debit Amount", Abs(GLEntryNew.Amount));

                    if GenJournalLine.Correction = true
    then
                        GLEntryNew.Validate(Amount, -GLEntry.Amount);

                    CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);

                    //drugi red

                    GLEntryNew.Init();
                    GLEntryNew.Copy(GLEntry);
                    GLEntryNew."Entry No." := GLEntry."Entry No." + 6;
                    Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                    GLEntryNew."New Order" := IntValue;
                    GeneralPosting.Reset();

                    GeneralPosting.SetFilter("Retail Account No.", '<>%1', '');
                    if GeneralPosting.FindFirst() then
                        GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Account No.");

                    GLEntryNew.Validate(Amount, round(abs(GenJournalLine."Total Retail Amount" * (GenJournalLine."Retail VAT") / 100), G."Amount Rounding Precision"));
                    //  GLEntryNew.Insert();
                    GLEntryNew.Validate("Debit Amount", Abs(GLEntryNew.Amount));

                    if GenJournalLine.Correction = true
    then
                        GLEntryNew.Validate(Amount, -GLEntry.Amount);

                    CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);

                end;


            end;

        end;

        if (GenJournalLine."Transfer Header" = false) and ((GenJournalLine."CNG MP" = true) or (GenJournalLine."CNG VP" = true))

and (GenJournalLine."Document Type_2" <> GenJournalLine."Document Type_2"::"Sales Shipment")
then begin

            if (GLEntry."Entry No." <= hide) or (hide = 0) then begin
                if (BrojRed = 1) and (GenJournalLine."CNG MP" = true) and (GenJournalLine."Hide CNG MP" = false)
                 then begin
                    GLEntry.Validate(Amount, round(GenJournalLine.Amount - abs(GenJournalLine."Retail RUC") - abs(GenJournalLine."Calculate Retail VAT" - GenJournalLine."VAT Difference CNG")));
                    USerUpdate.reset;
                    USerUpdate.setfilter("User ID", '%1', UserId);
                    if USerUpdate.FindFirst() then begin
                        USerUpdate.GKUpdate := GLEntry."G/L Account No.";
                        USerUpdate.Modify();
                    end
                end;

                if (BrojRed <> 1) and (GenJournalLine."CNG MP" = true) and (GenJournalLine."Hide CNG MP" = false) then begin
                    USerUpdate.reset;
                    USerUpdate.setfilter("User ID", '%1', UserId);
                    if USerUpdate.FindFirst() then begin
                        if USerUpdate.GKUpdate = GLEntry."G/L Account No." then
                            GLEntry.Validate(Amount, round(GenJournalLine.Amount - abs(GenJournalLine."Retail RUC") - abs(GenJournalLine."Calculate Retail VAT" - GenJournalLine."VAT Difference CNG")));

                    end;
                end;

                if (BrojRed = 1) and (GenJournalLine."CNG VP" = true) and (GenJournalLine."Hide CNG MP" = false) //ĐEMINA DVA PUTA OVDJE TREBA
                         then
                    GLEntry.Validate(Amount, round(GenJournalLine.Amount - abs(GenJournalLine."Retail RUC")));




                GKLine.Reset();
                GKLine.SetFilter("Document No.", '%1', GenJournalLine."Sales Header No.");
                GKLine.SetFilter("R. Fiscal printed", '%1', false);
                if GKLine.FindFirst() then
                    GKInventory := GKLine.Count
                else
                    GKInventory := 0;
                if (GKInventory = 0) and (BrojRed = 4) and (GenJournalLine."CNG VP" = true) then begin
                    GLEntry.Validate(Amount, round(GenJournalLine.Amount - abs(GenJournalLine."Retail RUC")));
                end;
                if GKInventory <> 0 then begin
                    //ovo je kao broj punjenje za konto 1320
                    GKInventoryD := 2 * (GKInventory - 1) + 2;
                    GKInventoryDi := 0;

                    WHILE GKInventoryDi <= GKInventoryD DO begin

                        GKInventoryDi += 2;

                        if (GenJournalLine."CNG VP" = true) //ĐEMINA DVA PUTA OVDJE TREBA
                                            then begin
                            InventoryPostingSetup.Reset();
                            Loc.Reset();
                            Loc.SetFilter("CNG VP", '%1', true);
                            if Loc.FindFirst() then
                                InventoryPostingSetup.SetFilter("Location Code", '%1', Loc.Code);

                            if InventoryPostingSetup.FindFirst() then
                                //GLEntry.Validate("G/L Account No.", InventoryPostingSetup."Inventory Account");
                                if GLEntry."G/L Account No." = InventoryPostingSetup."Inventory Account" then
                                    GLEntry.Validate(Amount, round(GenJournalLine.Amount - abs(GenJournalLine."Retail RUC")));
                        end;

                    end;
                end;



                if GenJournalLine.Correction = true
              then
                    GLEntry.Validate(Amount, -GLEntry.Amount);

                GPostingS.Reset();
                GPostingS.SetFilter("COGS Account", '%1', GenJournalLine."Account No.");
                if GenJournalLine."CNG MP" = true then
                    GPostingS.SetFilter("Retail Account No.", '<>%1', '');
                if GenJournalLine."CNG VP" = true then
                    GPostingS.SetFilter("Retail Receipt Account No.", '<>%1', '');

                if GPostingS.FindFirst() then begin
                    //ovaj dio koji se odnosi na knjiženje faktura
                    //ovdje ako je
                    //treba nam ostati u pluus
                    //17.11.2023 - ovdje smo uklonili minuls  round(GenJournalLine.Amount - abs(GenJournalLine."Retail RUC") - abs(GenJournalLine."Calculate Retail VAT")
                    GLEntry.Validate(Amount, round(GenJournalLine.Amount, G."Amount Rounding Precision"));

                    //
                    if GenJournalLine.Correction = true
    then
                        GLEntry.Validate(Amount, -GLEntry.Amount);

                    IntV := round(BrojRed / 2, 1);
                    //decimalValue = ROUND(decimalValue,1)
                    //   if (BrojRed = 2) or (IntV = (BrojRed - 2) / 2) then begin



                    SHL.Reset();
                    SHL.SetFilter("Document No.", '%1', GenJournalLine."Sales Header No.");
                    InV := SHL.Count;



                    //   if BrojRed = 2 then begin
                    StartU := GLEntry."Entry No.";
                    startU += InV * 2 + 3 - 2 + 1;
                    // end;
                    //if BrojRed > 2 then begin
                    //  StartU += 1;

                    // end;


                    //imam 6 linija

                    //2 inserta da probam dodati (prvi zbir)

                    //RUC
                    GLEntryNew.Init();
                    GLEntryNew.Copy(GLEntry);

                    GLEntryNew."Entry No." := StartU;
                    Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                    GLEntryNew."New Order" := IntValue;
                    GeneralPosting.Reset();

                    if GenJournalLine."CNG MP" = true then begin
                        GeneralPosting.SetFilter("Retail Receipt Account No. MP", '<>%1', '');

                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No. MP");
                    end
                    else begin


                        GeneralPosting.SetFilter("Retail Receipt Account No.", '<>%1', '');

                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No.");

                    end;

                    GLEntryNew.Validate(Amount, round(abs(GenJournalLine."Retail RUC"), G."Amount Rounding Precision"));
                    //  GLEntryNew.Insert();
                    GLEntryNew.Validate("Debit Amount", Abs(GLEntryNew.Amount));

                    if GenJournalLine.Correction = true
    then
                        GLEntryNew.Validate(Amount, -GLEntry.Amount);


                    CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);

                    //drugi red
                    if GenJournalLine."CNG VP" = false then begin
                        GLEntryNew.Init();
                        GLEntryNew.Copy(GLEntry);
                        GLEntryNew."Entry No." := StartU + 1;
                        Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                        GLEntryNew."New Order" := IntValue;
                        GeneralPosting.Reset();
                        StartU += 1;

                        GeneralPosting.SetFilter("Retail Account No.", '<>%1', '');
                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Account No.");

                        GLEntryNew.Validate(Amount, round(abs(GenJournalLine."Calculate Retail VAT" - GenJournalLine."VAT Difference CNG"), G."Amount Rounding Precision"));
                        //  GLEntryNew.Insert();
                        GLEntryNew.Validate("Debit Amount", Abs(GLEntryNew.Amount));

                        if GenJournalLine.Correction = true
    then
                            GLEntryNew.Validate(Amount, -GLEntry.Amount);


                        CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);

                    end;

                end;
            end;

            //end;

        end;

        if (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Shipment") then begin

            GPostingS2.Reset();
            GPostingS2.SetFilter("Gen. Prod. Posting Group", '%1', GenJournalLine."Prod Bus Posting");
            GPostingS2.SetFilter("Gen. Bus. Posting Group", '%1', GenJournalLine."Gen Bus Posting");
            GPostingS2.SetFilter("Update General Posting Group", '%1', true);
            if GPostingS2.FindFirst() then begin
                //1040
                if (GenJournalLine."Account No." = GPostingS2."Previous HTZ Account") and (GenJournalLine.Amount > 0) then begin
                    GPostingS.Reset();
                    GPostingS.SetFilter("Gen. Prod. Posting Group", '%1', GenJournalLine."Prod Bus Posting");
                    GPostingS.SetFilter("Gen. Bus. Posting Group", '%1', GenJournalLine."Gen Bus Posting");
                    if GPostingS.FindFirst() then begin
                        GenJournalLine.Validate("Account No.", GPostingS."HTZ Account");
                        GLEntry.Validate("G/L Account No.", GPostingS."HTZ Account");
                    end
                    else begin
                        GenJournalLine.Validate("Account No.", '51400');
                        GLEntry.Validate("G/L Account No.", '51400');
                    end;

                end;
                //51400

                //1041
                if (GenJournalLine."Account No." = GPostingS2."Previous HTZ Account 2") and (GenJournalLine.Amount < 0) then begin

                    GPostingS.Reset();
                    GPostingS.SetFilter("Gen. Prod. Posting Group", '%1', GenJournalLine."Prod Bus Posting");
                    GPostingS.SetFilter("Gen. Bus. Posting Group", '%1', GenJournalLine."Gen Bus Posting");
                    if GPostingS.FindFirst() then begin
                        GenJournalLine.Validate("Account No.", GPostingS."HTZ Account 2");
                        GLEntry.Validate("G/L Account No.", GPostingS."HTZ Account 2");
                    end
                    else begin
                        GenJournalLine.Validate("Account No.", '10940');
                        GLEntry.Validate("G/L Account No.", '10940');
                    end;
                    //10940
                end;

            end;
        end;

        if (GLEntry."Entry No." <= hide) or (hide = 0) then begin

            if (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Shipment") and (GenJournalLine."CNG MP" = true) then begin

                if (BrojRed = 1) and (GenJournalLine."Hide CNG MP" = false) then begin



                    GLEntry.Validate(Amount, GenJournalLine."T.Retail Unit Price with VAT");


                    if GenJournalLine.Correction = true
                   then
                        GLEntry.Validate(Amount, -GLEntry.Amount);




                end;

                if (BrojRed = 3) and (GenJournalLine."Hide CNG MP" = false) then begin
                    if GenJournalLine."CNG MP" = true then begin
                        //insert novog
                        //    GLEntry.Validate(Amount, GenJournalLine."Retail RUC");
                        //konto ovdje trebam dodati novu liniju, samo vidjeti gdje koliko

                        GLEntryNew.Init();
                        GLEntryNew.Copy(GLEntry);
                        GLEntryNew."Entry No." := GLEntry."Entry No." + 3;
                        Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                        GLEntryNew."New Order" := IntValue;
                        GeneralPosting.Reset();
                        if GenJournalLine."CNG MP" = false then begin
                            GeneralPosting.SetFilter("Retail Account No.", '<>%1', '');

                            if GeneralPosting.FindFirst() then
                                GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Account No.");
                        end
                        else begin
                            GeneralPosting.SetFilter("Retail Receipt Account No. MP", '<>%1', '');

                            if GeneralPosting.FindFirst() then
                                GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No. MP");

                        end;

                        //     GLEntryNew.Validate(Amount, -abs(abs(GenJournalLine."T.Retail Unit Price with VAT") - abs(GenJournalLine."Total Retail Amount")));
                        //  GLEntryNew.Insert();
                        GLEntryNew.Validate(Amount, GenJournalLine."Retail RUC");
                        GLEntryNew.Validate("Credit Amount", Abs(GLEntryNew.Amount));
                        GLEntry.Validate("G/L Account No.", GeneralPosting."Purch. Account");
                        //  GLEntry.Validate("G/L Account No.", GeneralPosting."Direct Cost Applied Account");

                        if (GenJournalLine.Correction = true) and (GenJournalLine."R. CNG MP" = false)
                       then
                            GLEntryNew.Validate(Amount, -GLEntry.Amount);//ProblemPredznak
                        if GenJournalLine."R. CNG MP" = true then begin
                            GLEntry.Validate(Amount, abs(GLEntry.Amount));
                            GLEntry.Validate("Credit Amount", -abs(GLEntry.Amount));
                            GLEntryNew.Validate("Debit Amount", 0);
                            GLEntryNew.Validate("Credit Amount", -Abs(GLEntryNew.Amount));
                            GLEntryNew.validate(Amount, abs(GLEntryNew.Amount));
                        end;

                        CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);


                    end;

                end;

                if (BrojRed = 4) and (GenJournalLine."Hide CNG MP" = false) then begin

                    //insert
                    GLEntryNew.Init();
                    GLEntryNew.Copy(GLEntry);
                    GLEntryNew."Entry No." := GLEntry."Entry No." + 1;
                    Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                    GLEntryNew."New Order" := IntValue;
                    GeneralPosting.Reset();
                    if GenJournalLine."CNG MP" = false then begin
                        GeneralPosting.SetFilter("Retail Account No.", '<>%1', '');

                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Account No.");
                    end
                    else begin
                        GeneralPosting.SetFilter("Retail Receipt Account No. MP", '<>%1', '');

                        if GeneralPosting.FindFirst() then
                            GLEntryNew.Validate("G/L Account No.", GeneralPosting."Retail Account No.");

                    end;

                    GLEntryNew.Validate(Amount, -abs(abs(GenJournalLine."T.Retail Unit Price with VAT") - abs(GenJournalLine."Total Retail Amount")));
                    //  GLEntryNew.Insert();
                    GLEntryNew.Validate("Credit Amount", Abs(GLEntryNew.Amount));

                    if (GenJournalLine.Correction = true) and (GenJournalLine."R. CNG MP" = false)
    then
                        GLEntryNew.Validate(Amount, -GLEntry.Amount);

                    if GenJournalLine."R. CNG MP" = true then begin
                        GLEntryNew.Validate("Debit Amount", 0);
                        GLEntryNew.Validate("Credit Amount", -Abs(GLEntryNew.Amount));
                        GLEntryNew.validate(Amount, abs(GLEntryNew.Amount));
                    end;
                    //PogresanPredznak
                    CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);

                    //     Error('ĐK');
                end;
            end;


            if (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Receipt") and (GenJournalLine."CNG MP") then begin

                if (BrojRed = 1) and (GenJournalLine."Hide CNG MP" = false) then begin

                    GeneralPosting.Reset();
                    GeneralPosting.SetFilter("Retail Receipt Account No.", '<>%1', '');
                    if GeneralPosting.FindFirst() then
                        GLEntry.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No.");
                    GLEntry.Validate(Amount, abs(GenJournalLine."Retail RUC"));


                    if GenJournalLine.Correction = true
                    then
                        GLEntry.Validate(Amount, -GLEntry.Amount);

                end;
                if (BrojRed = 3) and (GenJournalLine."Hide CNG MP" = false) then begin

                    GeneralPosting.Reset();

                    if GenJournalLine."CNG MP" = true then begin
                        GeneralPosting.SetFilter("Retail Receipt Account No. MP", '<>%1', '');
                        if GeneralPosting.FindFirst() then
                            GLEntry.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No. MP");
                    end

                    else begin

                        GeneralPosting.SetFilter("Retail Receipt Account No.", '<>%1', '');
                        if GeneralPosting.FindFirst() then
                            GLEntry.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No.");
                    end;
                    GLEntry.Validate(Amount, -abs(GenJournalLine."Retail RUC"));

                    if GenJournalLine.Correction = true
    then
                        GLEntry.Validate(Amount, -GLEntry.Amount);

                end;
            end;

            //za veleprodaju knjiženje primke

            if (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Receipt") and (GenJournalLine."CNG VP") then begin

                if (BrojRed = 4) and (GenJournalLine."Hide CNG MP" = false) then begin
                    //ako je broj reda 4 i ako je korekcija onda bi trebala to dodati

                    TempGLE2.Reset();
                    TempGLE2.SetFilter("System-Created Entry", '%1', true);
                    TempGLE2.SetFilter("Document No.", '%1', TempGLE."Document No.");
                    TempGLE2.SetFilter(Description, '%1', TempGLE.Description);
                    if TempGLE2.FindFirst() then begin

                        GenJournalLine.Validate(Correction, true);
                    end;


                end;


                if (BrojRed = 3) and (GenJournalLine."Hide CNG MP" = false) then begin

                    GeneralPosting.Reset();
                    GeneralPosting.SetFilter("Retail Receipt Account No.", '<>%1', '');
                    if GeneralPosting.FindFirst() then
                        GLEntry.Validate("G/L Account No.", GeneralPosting."Retail Receipt Account No.");
                    GLEntry.Validate(Amount, -abs(GenJournalLine."Retail RUC"));

                    if GenJournalLine.Correction = true
    then
                        GLEntry.Validate(Amount, -GLEntry.Amount);


                    //ovdje mi treba insert 1309

                end;



                if (BrojRed = 2) and (GenJournalLine."Hide CNG MP" = false) then begin
                    //insert
                    GLEntryNew.Init();
                    GLEntryNew.Copy(GLEntry);
                    GLEntryNew."Entry No." := GLEntry."Entry No." + 3;
                    Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                    GLEntryNew."New Order" := IntValue;
                    GeneralPosting.Reset();
                    GeneralPosting.SetFilter("Retail Account No.", '<>%1', '');
                    if GeneralPosting.FindFirst() then
                        GLEntryNew.Validate("G/L Account No.", GeneralPosting."Purch. Account");
                    GLEntryNew.Validate("Credit Amount", Abs(GLEntryNew.Amount));

                    if GenJournalLine.Correction = true

    then begin

                        GLEntryNew.Validate(Amount, abs(GLEntry.Amount));
                        GLEntryNew.Validate("Credit Amount", -abs(GLEntry.Amount));
                        GLEntryNew.Validate("Debit Amount", 0);

                        //ovdje je onaj problem
                        GLEntry.Validate(Amount, -abs(GLEntry.Amount));
                        GenJournalLine.Validate(Correction, true);
                        GLEntry.Validate("Credit Amount", 0);
                        GLEntry.Validate("Debit Amount", -abs(GLEntry.Amount));
                    end;


                    //     GLEntryNew.Validate(Amount, -abs(Uknjizeno));
                    //  GLEntryNew.Insert();
                    //   GLEntryNew.Validate("Credit Amount", Abs(GLEntryNew.Amount));

                    CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);
                end;




                if (BrojRed = 1) and (GenJournalLine."Hide CNG MP" = false) then begin






                    InventoryPostingSetup.Reset();
                    Loc.Reset();
                    Loc.SetFilter("CNG VP", '%1', true);
                    if Loc.FindFirst() then
                        InventoryPostingSetup.SetFilter("Location Code", '%1', Loc.Code);

                    if InventoryPostingSetup.FindFirst() then
                        GLEntry.Validate("G/L Account No.", InventoryPostingSetup."Inventory Account");
                    GLEntry.Validate(Amount, abs(GenJournalLine."Total Retail Amount"));

                    if GenJournalLine.Correction = true
    then
                        GLEntry.Validate(Amount, -GLEntry.Amount);

                end;

            end;


            if ((GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) and (GenJournalLine.Prepayment = TRUE)) then begin


                //ĐEMINA DODALA
                GLEntry.Validate("Credit Amount", -(GLEntry."Amount"));
                GLEntry.Validate("Debit Amount", 0);


            end;



            if (GenJournalLine."CNG VL" = true) and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Receipt") then begin

                if BrojRed = 3 then begin
                    GeneralPosting.Reset();
                    GeneralPosting.SetFilter("Gen. Bus. Posting Group", '%1', GenJournalLine."Gen Bus Posting");
                    GeneralPosting.SetFilter("Gen. Prod. Posting Group", '%1', GenJournalLine."Prod Bus Posting");
                    if GeneralPosting.FindFirst() then
                        GLEntry.Validate("G/L Account No.", GeneralPosting."Purch. Account");
                    //   error('');




                end;

                //        if BrojRed = 4 then begin

                if (GLEntry."Entry No." <= hide) or (hide = 0) then begin

                    Customer.Reset();
                    Customer.SetFilter("No.", '%1', GenJournalLine."Bill-to/Pay-to No.");
                    customer.SetFilter("Internal Customer", '%1', true);
                    if customer.FindFirst() then begin
                        cpg.Reset();
                        cpg.SetFilter(code, '%1', GenJournalLine."Posting Group");
                        if cpg.FindFirst() then begin
                            if cpg."Receivables Account" = GLEntry."G/L Account No." then begin
                                SHL.Reset();
                                shl.SetFilter("Document No.", '%1', DelChr(GLEntry.Description, '=', 'Faktura '));
                                if shl.FindFirst() then begin
                                    G.get;
                                    sh.reset;
                                    sh.SetFilter("No.", '%1', shl."Document No.");
                                    if sh.findfirst then begin
                                        if G."VAT Bus VL" = sh."VAT Bus. Posting Group" then begin

                                            shl.CalcSums("Amount Including VAT", Amount);
                                            GLEntry.validate(Amount, GLEntry.amount - abs((shl."Amount Including VAT" - shl.Amount)));

                                            if GenJournalLine.Correction = true
            then
                                                GLEntry.Validate(Amount, -GLEntry.Amount);

                                        end;
                                    end;
                                end;


                            end;
                        end;

                    end;
                end;


                if (GLEntry."Entry No." <= hide) or (hide = 0) then begin
                    Customer.Reset();
                    Customer.SetFilter("No.", '%1', GenJournalLine."Bill-to/Pay-to No.");
                    customer.SetFilter("Internal Customer", '%1', true);
                    if customer.FindFirst() then begin

                        VatSetup.Reset();
                        VatSetup.SetFilter("Sales VAT Account", '%1', GLEntry."G/L Account No.");
                        if VatSetup.FindFirst() then begin

                            //Ovdje oduzeti PDV                GLEntry.validate(amount,amount-);

                            G.get;
                            sh.reset;
                            sh.SetFilter("No.", '%1', DelChr(GenJournalLine.Description, '=', 'Faktura '));
                            if sh.FindFirst() then begin
                                if G."VAT Bus VL" = sh."VAT Bus. Posting Group" then begin

                                    GLEntry.Validate("Debit Amount", -abs(GLEntry.Amount));
                                    GLEntry.Validate("Credit Amount", 0);

                                    IntV := round(BrojRed / 2, 1);

                                    StartU := GLEntry."Entry No.";
                                    startU += InV * 2 + 2;


                                    GLEntryNew.Init();
                                    GLEntryNew.Copy(GLEntry);
                                    GLEntryNew."Entry No." := StartU;
                                    Evaluate(IntValue, NoSeries.GetNextNo(GLSe."G_L Entry", GLEntryNew."Posting Date", true));
                                    GLEntryNew."New Order" := IntValue;
                                    SH.reset;
                                    SH.SetFilter("No.", '%1', delchr(GenJournalLine.Description, '=', 'Faktura '));
                                    if sh.FindFirst() then begin
                                        CPG.Reset();

                                        cpg.SetFilter(Code, '%1', SH."Customer Posting Group");
                                        if cpg.FindFirst() then begin
                                            GLEntryNew.Validate("G/L Account No.", CPG."Receivables Account");
                                            GLEntryNew.Validate("Debit Amount", Abs(GLEntry.Amount));
                                        end;
                                    end;

                                    //     GLEntryNew.Validate(Amount, -abs(Uknjizeno));
                                    //  GLEntryNew.Insert();
                                    //   GLEntryNew.Validate("Credit Amount", Abs(GLEntryNew.Amount));

                                    CODEUNIT.Run(CODEUNIT::"Insert Permissions", GLEntryNew);

                                    //i sad treba dodati novi red
                                end;
                            end;
                        end;
                    end;

                end;
            end;
        end;
    end;




    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeInvoicePostingBufferSetAmounts', '', true, true)]

    local procedure OnBeforeInvoicePostingBufferSetAmounts(SalesLine: Record "Sales Line"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var TotalVAT: Decimal; var TotalVATACY: Decimal; var TotalAmount: Decimal; var TotalAmountACY: Decimal; var TotalVATBase: Decimal; var TotalVATBaseACY: Decimal)
    var

        US: Record "User Setup";
        SL: record "Sales Line";
        SLLast: record "Sales Line";
        LastRow: Integer;
        SumRound: Decimal;
    begin
        LastRow := 0;
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if US.findfirst then begin
            if (us."CNG User") or (us."CNG Administrator") then begin


                SLLast.Reset();
                SLLast.SetFilter("Document No.", '%1', SalesLine."Document No.");
                SLLast.SetFilter("Document Type", '%1', SalesLine."Document Type");
                SLLast.SetCurrentKey("Line No.");
                SLLast.Ascending;
                if SLLast.findlast then begin
                    LastRow := SLLast."Line No.";
                end;

                if LastRow = SalesLine."Line No." then begin
                    SumRound := 0;
                    SL.Reset();
                    SL.SetFilter("Document No.", '%1', SalesLine."Document No.");
                    SL.SetFilter("Document Type", '%1', SalesLine."Document Type");
                    if sl.FindFirst() then
                        repeat
                            SumRound += sl."Amount Including VAT" - sl.Amount;
                        until sl.Next() = 0;
                    SumRound := round(SumRound, 0.01);

                    SL.Reset();
                    SL.SetFilter("Document No.", '%1', SalesLine."Document No.");
                    SL.SetFilter("Document Type", '%1', SalesLine."Document Type");
                    if sl.FindFirst() then begin
                        sl.CalcSums("Amount Including VAT", Amount);

                        TotalVAT := TotalVAT + (SumRound - ((round(sl."Amount Including VAT", 0.01) - round(SL.Amount, 0.01))));

                        TotalVATACY := TotalVAT;

                    end;




                end;
            end;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
    begin
        SalesInvHeader."Document No_" := SalesInvHeader."No." + '\' + format(copystr(format(Date2DMY(SalesInvHeader."Posting Date", 3)), 3, 2));

    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnCopyToTempLinesOnAfterSetFilters', '', true, true)]
    local procedure OnCopyToTempLinesOnAfterSetFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        //ĐK PROBAJ     SalesLine.SetFilter("Shipment Create", '%1', false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitAmounts', '', true, true)]
    local procedure OnBeforeInitAmounts(var GenJnlLine: Record "Gen. Journal Line"; var Currency: Record Currency; var IsHandled: Boolean)

    var
        US: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        DecimaLRe: decimal;
    begin
        //ĐK PROBAJ     SalesLine.SetFilter("Shipment Create", '%1', false);


        US.reset;
        US.setfilter("User ID", '%1', UserId);
        if US.FindFirst() then begin
            if (us."CNG Administrator" = true) or (us."CNG User" = true) then begin
                IsHandled := true;
                if GenJnlLine."Currency Code" = '' then begin
                    Currency.InitRoundingPrecision();
                    if (GenJnlLine."Account No." = '400015') and (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then begin
                        GenJnlLine."Amount (LCY)" := round(GenJnlLine.Amount, 0.01, '=');
                        GenJnlLine."VAT Amount (LCY)" := round(GenJnlLine."VAT Amount" - GenJnlLine."VAT Difference CNG", 0.01, '=');
                        GenJnlLine."VAT Base Amount (LCY)" := round(GenJnlLine."VAT Base Amount", 0.01, '=');
                    end
                    else begin
                        if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then begin
                            GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;
                            GenJnlLine."VAT Amount (LCY)" := GenJnlLine."VAT Amount" - GenJnlLine."VAT Difference CNG";
                            GenJnlLine."VAT Base Amount (LCY)" := GenJnlLine."VAT Base Amount";
                        end;
                    end;
                end else begin
                    Currency.Get(GenJnlLine."Currency Code");
                    Currency.TestField("Amount Rounding Precision");
                    if not GenJnlLine."System-Created Entry" then begin
                        GenJnlLine."Source Currency Code" := GenJnlLine."Currency Code";
                        GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
                        GenJnlLine."Source Curr. VAT Base Amount" := GenJnlLine."VAT Base Amount";
                        GenJnlLine."Source Curr. VAT Amount" := GenJnlLine."VAT Amount";
                    end;
                end;


            end
            else begin

                if (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) then begin
                    if GenJnlLine."Currency Code" = '' then begin
                        Currency.InitRoundingPrecision();
                        GLSetup.Get();
                        if GLSetup."Amount Rounding Precision" <> 0 then
                            DecimaLRe := GLSetup."Amount Rounding Precision"
                        else
                            DecimaLRe := 0.01;

                        if GenJnlLine."Account No." = '400015' then
                            DecimaLRe := 0.01;

                        GenJnlLine."Amount (LCY)" := round(GenJnlLine.Amount, DecimaLRe);
                        GenJnlLine.Amount := round(GenJnlLine.Amount, DecimaLRe);
                        GenJnlLine."VAT Amount (LCY)" := round(GenJnlLine."VAT Amount", DecimaLRe);
                        GenJnlLine."VAT Base Amount (LCY)" := round(GenJnlLine."VAT Base Amount", DecimaLRe);
                    end else begin
                        Currency.Get(GenJnlLine."Currency Code");
                        Currency.TestField("Amount Rounding Precision");
                        if not GenJnlLine."System-Created Entry" then begin
                            GenJnlLine."Source Currency Code" := GenJnlLine."Currency Code";
                            GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
                            GenJnlLine."Source Curr. VAT Base Amount" := GenJnlLine."VAT Base Amount";
                            GenJnlLine."Source Curr. VAT Amount" := GenJnlLine."VAT Amount";
                        end;
                    end;

                end;

            end;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostGLAccOnBeforeInsertGLEntry', '', true, true)]
    local procedure OnPostGLAccOnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    begin
        //ĐK ovdje je problem


        //ĐK DO

        if (GenJournalLine."Hide PP" = true) then IsHandled := true;

        if (GenJournalLine."CNG VP" = true)
        and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Shipment")
        then begin
            IsHandled := true;
        end;

        if (GenJournalLine."Hide CNG MP" = true)
        and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Receipt")
        then begin
            IsHandled := true;
        end;

        if (GenJournalLine."Hide CNG MP" = true)
       and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Shipment")
       then begin
            IsHandled := true;
        end
;
        if (GenJournalLine."CNG VP" = true)
       and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Sales Shipment") and (GenJournalLine.Correction = true)
       then begin
            IsHandled := true;
        end;

        if (GenJournalLine."CNG MP" = true)
       and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Sales Shipment")
       then begin
            IsHandled := true;
        end;

        if (GenJournalLine."CNG VL" = true)
       and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Sales Shipment")
       then begin
            IsHandled := true;
        end;

        if (GenJournalLine."CNG MP" = true) and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Receipt")
       then begin
            IsHandled := true;
        end;

        if (GenJournalLine."CNG VL" = true) and (GenJournalLine."Document Type_2" = GenJournalLine."Document Type_2"::"Transfer Shipment")
      then begin
            IsHandled := true;
        end;
        GenJournalLine.Amount := round(GenJournalLine.Amount, 0.01, '=');

        GenJournalLine."Credit Amount" := round(GenJournalLine."Credit Amount", 0.01, '=');
        GenJournalLine."Debit Amount" := round(GenJournalLine."Debit Amount", 0.01, '=');
        GLEntry.Amount := round(GLEntry.Amount, 0.01, '=');
        GLEntry."Credit Amount" := round(GLEntry."Credit Amount", 0.01, '=');
        GLEntry."Debit Amount" := round(GLEntry."Debit Amount", 0.01, '=');

        GLEntry."VAT Amount" := Round(GLEntry."VAT Amount", 0.01, '=');
        GenJournalLine."VAT Amount (LCY)" := Round(GenJournalLine."VAT Amount (LCY)", 0.01, '=');
        GenJournalLine."VAT Amount" := Round(GenJournalLine."VAT Amount", 0.01, '=');

    end;

    procedure TruncateDecimal(Value: Decimal; NoOfDecimals: Integer): Decimal
    var
        Precision: Decimal;
    begin
        Precision := POWER(10, -NoOfDecimals);
        exit(ROUND(Value, Precision, '<'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnInsertGLEntryOnBeforeCheckAmountRounding', '', true, true)]
    local procedure OnInsertGLEntryOnBeforeCheckAmountRounding(var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; var GenJnlLine: Record "Gen. Journal Line")

    var
        UsetSetup: Record "User Setup";
        //djemina ovdje ispraviti za ove fakture
        SalesLineTotal: Record "Sales Line";
        TotalAmount: Decimal;
        GLPrije: Decimal;
        GenJnlLineL: Decimal;
        GenJnlLineLN: Decimal;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;

    begin
        UsetSetup.Reset();
        UsetSetup.SetFilter("User ID", '%1', UserId);
        if UsetSetup.FindFirst() then begin
            if (UsetSetup."CNG User" = true) or (UsetSetup."CNG Administrator" = true) then begin
                TotalAmount := 0;
                //  GenJnlLine.Validate(Amount, round(GenJnlLine.Amount, 0.01, '='));
                //GenJnlLine.Validate(amount, round(GenJnlLine.Amount, 0.01, '='));
                SalesLineTotal.Reset();
                SalesLineTotal.SetFilter("Document No.", '%1', GLEntry."Document No.");
                if SalesLineTotal.FindFirst() then begin
                    SalesLineTotal.CalcSums("Amount Including VAT");
                    TotalAmount := SalesLineTotal."Amount Including VAT";
                end;
                GLPrije := GLEntry.Amount;
                GenJnlLineL := GenJnlLine."Amount (LCY)";
                GenJnlLineLN := GenJnlLine.Amount;
                if GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice then begin
                    GLEntry.Validate(Amount, round(GLEntry.Amount, 0.01, '='));
                    GenJnlLine.Validate(Amount, round(GenJnlLine.Amount, 0.01, '='));
                    GenJnlLine.Validate("Amount (LCY)", round(GenJnlLine."Amount (LCY)", 0.01, '='));
                    if (TotalAmount <> round(GLPrije, 0.01, '=')) and (copystr(GLEntry."G/L Account No.", 1, 1) = '2') then begin

                        GLEntry.Validate(Amount, TruncateDecimal(GLPrije, 2));
                        GenJnlLine.Validate(Amount, TruncateDecimal(GenJnlLineLN, 2));
                        GenJnlLine.Validate("Amount (LCY)", TruncateDecimal(GenJnlLineL, 2));
                    end;

                    if (copystr(GLEntry."G/L Account No.", 1, 1) = '2') then begin

                        TotalAmount1 := 0;
                        TotalAmount2 := 0;
                        SalesLineTotal.Reset();
                        SalesLineTotal.SetFilter("Document No.", '%1', DelChr(GLEntry.Description, '=', 'Faktura '));
                        if SalesLineTotal.FindFirst() then begin
                            SalesLineTotal.CalcSums("Amount Including VAT", Amount);
                            TotalAmount1 := round(SalesLineTotal."Amount Including VAT", 0.01, '=') - round(SalesLineTotal.Amount, 0.01, '=');
                            TotalAmount2 := round(SalesLineTotal."Amount", 0.01, '=');
                        end;
                        GLPrije := round(TotalAmount2 + TotalAmount1);


                        GLEntry.Validate(Amount, TruncateDecimal(GLPrije, 2));
                        GenJnlLine.Validate(Amount, TruncateDecimal(GLPrije, 2));
                        GenJnlLine.Validate("Amount (LCY)", TruncateDecimal(GLPrije, 2));

                    end;
                end;


                //  GLEntry.Validate("Amount (L)", round(GLEntry, 0.01, '='));
            end;
        end;

        /* if (GenJnlLine.Correction = true) and ((GenJnlLine."CNG MP" = true) or (GenJnlLine."CNG VL" = true) or (GenJnlLine."CNG VP")) then begin
     GenJnlLine.Validate(Amount, -abs(GenJnlLine.Amount));
     GenJnlLine.Validate("Debit Amount", -abs(GenJnlLine.Amount));
     GenJnlLine.Validate("Credit Amount", 0);

     GLEntry.Validate(Amount, -abs(GenJnlLine.Amount));
     GLEntry.Validate("Debit Amount", -abs(GenJnlLine.Amount));
     GLEntry.Validate("Credit Amount", 0);

 end;*/


    end;





    [EventSubscriber(ObjectType::Codeunit, 5802, 'OnBeforeGLItemLedgRelationInsert', '', true, true)]
    local procedure OnBeforeGLItemLedgRelationInsert(var GLItemLedgerRelation: Record "G/L - Item Ledger Relation"; InvtPostingBuffer: Record "Invt. Posting Buffer"; GLRegister: Record "G/L Register"; TempGLItemLedgerRelation: Record "G/L - Item Ledger Relation" temporary)
    var
        GLItemLedgerRelation2: record "G/L - Item Ledger Relation";

    begin

        GLItemLedgerRelation2.Reset();
        GLItemLedgerRelation2.SetFilter("G/L Entry No.", '%1', GLItemLedgerRelation."G/L Entry No.");
        GLItemLedgerRelation2.SetFilter("Value Entry No.", '%1', GLItemLedgerRelation."Value Entry No.");
        if GLItemLedgerRelation2.FindFirst() then
            GLItemLedgerRelation."G/L Entry No." := 999999;

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGLAcc', '', true, true)]
    procedure OnBeforePostGLAcc(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
        FAPostingGr: Record "FA Posting Group";

        TempGLE: Record TempGLE;
        BrojRed: Integer;
        G: Record "General Ledger Setup";
        CalSetup: Record "Calculation Setup";
        Customer: Record customer;
        SalesPrice: Record "Sales Price";

        Item: Record item;
        RUP: Decimal;
        TRA: Decimal;
        RRUC: Decimal;
        VPS: Record "VAT Posting Setup";
        RUPVAT: Decimal;
        TRAVAT: Decimal;
        RRUCVAT: Decimal;
        GLEntryNew: Record "Gen. Journal Line";
        GJournalBatch: Record "Gen. Journal Batch";



    begin








        GJournalBatch.Reset();
        GJournalBatch.SetFilter("Journal Template Name", '%1', GenJournalLine."Journal Template Name");
        GJournalBatch.SetFilter(Name, '%1', GenJournalLine."Journal Batch Name");
        GJournalBatch.SetFilter(Commissioning, '%1', true);

        if GJournalBatch.FindFirst() then begin




            if GenJournalLine."FA Posting Type" = GenJournalLine."FA Posting Type"::"Acquisition Cost" then begin

                if GenJournalLine."Posting Group" <> '' then begin
                    FAPostingGr.get(GenJournalLine."Posting Group");

                    if (FAPostingGr."Investment Account" <> '') and (GenJournalLine.Description <> 'A') then begin
                        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then
                            GenJournalLine.validate("Account No.", FAPostingGr."Investment Account");
                        GLEntry.validate("G/L Account No.", FAPostingGr."Investment Account");
                    end

                    else begin
                        /*    if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then
                                GenJournalLine.validate("Account No.", FAPostingGr."Acquisition Cost Account");
                            GLEntry.Validate("G/L Account No.", FAPostingGr."Acquisition Cost Account");*/
                    end;
                end;
            end;

        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGLEntryBuffer', '', true, true)]
    procedure OnBeforeInsertGLEntryBuffer(var TempGLEntryBuf: Record "G/L Entry" temporary; var GenJournalLine: Record "Gen. Journal Line"; var BalanceCheckAmount: Decimal; var BalanceCheckAmount2: Decimal; var BalanceCheckAddCurrAmount: Decimal; var BalanceCheckAddCurrAmount2: Decimal; var NextEntryNo: Integer; var TotalAmount: Decimal; var TotalAddCurrAmount: Decimal)

    var
        TempGle: Record TempGLE;
        Customer: record "Customer";
        G: record "General Ledger Setup";
        BrojRed2: integer;
        NoSeries: Codeunit NoSeriesExtented;
        VatSetup: Record "VAT Posting Setup";
        SHL: Record "Sales Line";
        SH: Record "Sales Header";
        USerUpdate: Record "User Setup";

    begin



        if ((GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) and (GenJournalLine.Prepayment = TRUE)) then begin


            TempGLEntryBuf.Validate("Credit Amount", -(TempGLEntryBuf."Amount"));
            TempGLEntryBuf.Validate("Debit Amount", 0);


        end;



        if (GenJournalLine."CNG MP" = true) or (GenJournalLine."CNG VP" = true) then begin

            TempGle.SetFilter("Document No.", '%1', TempGLEntryBuf."Document No.");
            if TempGle.FindFirst() then begin
                TempGle.CalcSums(Amount);

                BalanceCheckAmount := TempGle.Amount;
                BalanceCheckAmount2 := TempGle.Amount;

            end;
        end;
        if (GenJournalLine.Correction = true) and ((GenJournalLine."Debit Correction" <> 0) or (GenJournalLine."Credit Correction" <> 0)) then begin

            GenJournalLine."Debit Amount" := GenJournalLine."Debit Correction";
            GenJournalLine."Credit Amount" := GenJournalLine."Credit Correction";
            TempGLEntryBuf."Debit Amount" := GenJournalLine."Debit Amount";
            TempGLEntryBuf."Credit Amount" := GenJournalLine."Credit Amount";


        end;


        //internal correction

        Customer.Reset();
        Customer.SetFilter("No.", '%1', GenJournalLine."Bill-to/Pay-to No.");
        customer.SetFilter("Internal Customer", '%1', true);
        if customer.FindFirst() then begin

            if GenJournalLine."Document No." = '***' then begin


                GenJournalLine."Document No." := NoSeries.GetNextNo('DOC_INIT', GenJournalLine."Posting Date", false);
                // Evaluate(IntValue,NoSeries.GetNextNo(GLSe."G_L Entry",GLEntry."Posting Date",false));
                //    GLEntry."New Order":=IntValue;
            end;

            TempGLE.reset;
            TempGLE.SetFilter("Document No.", '%1', GenJournalLine."Document No.");
            TempGLE.SetFilter("User ID", '%1', UserId);
            BrojRed2 := TempGLE.Count;

            VatSetup.Reset();
            VatSetup.SetFilter("Sales VAT Account", '%1', TempGLEntryBuf."G/L Account No.");
            if VatSetup.FindFirst() then begin
                //djemina testu
                if strpos(TempGLEntryBuf.Description, 'Faktura') <> 0 then begin
                    SHL.Reset();

                    shl.SetFilter("Document No.", '%1', DelChr(TempGLEntryBuf.Description, '=', 'Faktura '));
                    if shl.FindFirst() then begin
                        G.get;
                        sh.reset;
                        sh.SetFilter("No.", '%1', shl."Document No.");
                        if sh.FindFirst() then begin
                            if G."VAT Bus VL" = sh."VAT Bus. Posting Group" then begin
                                TempGLEntryBuf.Validate("Debit Amount", -abs(TempGLEntryBuf.Amount));
                                TempGLEntryBuf.Validate("Credit Amount", 0);

                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;


    //end;


    //pocetak






    local procedure InsertDetailedVATEntry(VATEntryToInsert: Record "vat entry")
    var
        myInt: Integer;
    begin
        WITH VATEntryToInsert DO BEGIN
            IF NOT (Type IN [Type::Sale, Type::Purchase]) THEN
                EXIT;

            InsertDetailedVATEntryData(VATEntryToInsert);
            IF (Type = Type::Purchase)
              AND
               ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT")
            THEN BEGIN
                Type := Type::Sale;
                InsertDetailedVATEntryData(VATEntryToInsert);
            END;
        END

    end;

    local procedure InsertDetailedVATEntryData(VATEntryToInsert: Record "VAT Entry")
    var
        myInt: Integer;
        VATBooksSetup: Record "VAT Books Setup";
        DetailedAmount: Decimal;
        DetailedVATEntry: Record "Detailed VAT Entry";
    begin
        WITH VATEntryToInsert DO BEGIN
            CASE Type OF
                Type::Sale:
                    VATBooksSetup.SETRANGE(Type, VATBooksSetup.Type::Sale);
                Type::Purchase:
                    VATBooksSetup.SETRANGE(Type, VATBooksSetup.Type::Purchase);
            END;
            VATBooksSetup.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
            VATBooksSetup.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
            IF VATBooksSetup.FINDSET THEN
                REPEAT
                    IF (VATBooksSetup.Value1 + VATBooksSetup.Value2) > 0 THEN BEGIN
                        DetailedAmount := 0;
                        IF VATBooksSetup.Value1 > 0 THEN
                            AddDetailedValue(VATEntryToInsert, VATBooksSetup.Operator1, VATBooksSetup.Value1, DetailedAmount);
                        IF VATBooksSetup.Value2 > 0 THEN
                            AddDetailedValue(VATEntryToInsert, VATBooksSetup.Operator2, VATBooksSetup.Value2, DetailedAmount);

                        IF VATBooksSetup.Value3 > 0 THEN
                            AddDetailedValue(VATEntryToInsert, VATBooksSetup.Operator3, VATBooksSetup.Value3, DetailedAmount);


                        IF DetailedAmount <> 0 THEN BEGIN
                            IF NOT DetailedVATEntry.GET("Entry No.", Type) THEN BEGIN
                                DetailedVATEntry.INIT;
                                DetailedVATEntry."VAT Entry No." := "Entry No.";
                                DetailedVATEntry.Type := Type;
                                DetailedVATEntry."Document No." := "Document No.";
                                DetailedVATEntry."External Document No." := "External Document No.";
                                DetailedVATEntry."Document Type" := "Document Type";
                                DetailedVATEntry."VAT Date" := "VAT Date";
                                DetailedVATEntry.INSERT;
                            END;
                            CASE VATBooksSetup."Column Name" OF
                                0:
                                    DetailedVATEntry.Column1 := DetailedVATEntry.Column1 + DetailedAmount;
                                1:
                                    DetailedVATEntry.Column2 := DetailedVATEntry.Column2 + DetailedAmount;
                                2:
                                    DetailedVATEntry.Column3 := DetailedVATEntry.Column3 + DetailedAmount;
                                3:
                                    DetailedVATEntry.Column4 := DetailedVATEntry.Column4 + DetailedAmount;
                                4:
                                    DetailedVATEntry.Column5 := DetailedVATEntry.Column5 + DetailedAmount;
                                5:
                                    DetailedVATEntry.Column6 := DetailedVATEntry.Column6 + DetailedAmount;
                                6:
                                    DetailedVATEntry.Column7 := DetailedVATEntry.Column7 + DetailedAmount;
                                7:
                                    DetailedVATEntry.Column8 := DetailedVATEntry.Column8 + DetailedAmount;
                                8:
                                    DetailedVATEntry.Column9 := DetailedVATEntry.Column9 + DetailedAmount;
                                9:
                                    DetailedVATEntry.Column10 := DetailedVATEntry.Column10 + DetailedAmount;
                            END;
                            DetailedVATEntry.MODIFY;
                        END;
                    END;
                UNTIL VATBooksSetup.NEXT = 0;
        END;
        //-BH1.03

    end;

    local procedure AddDetailedValue(VATEntryToInsert: Record "VAT Entry"; Operator: Option " ","+","-"; Value: Option " ",Base,Amount,"VAT Base (retro)","VAT Amount (retro)"; var DetailedAmount: Decimal)
    var
        TempAmount: Decimal;
    begin
        //+BH1.03
        CASE Value OF
            Value::Base:
                TempAmount := VATEntryToInsert.Base;
            Value::Amount:
                TempAmount := VATEntryToInsert.Amount;
            Value::"VAT Base (retro)":
                TempAmount := VATEntryToInsert."VAT Base (retro.)";
            Value::"VAT Amount (retro)":
                TempAmount := VATEntryToInsert."VAT Amount (retro.)";
        END;
        IF Operator = Operator::"-" THEN
            TempAmount := -TempAmount;

        DetailedAmount := DetailedAmount + TempAmount;
        //-BH1.03
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeInsertICGenJnlLine', '', true, true)]
    procedure OnBeforeInsertICGenJnlLine(ICGenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        GenJnlLine: Record "Gen. Journal Line";

    begin

        ICGenJournalLine."VAT Date" := SalesHeader."VAT Date";

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostCustomerEntry', '', true, true)]
    procedure OnBeforePostCustomerEntry(GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin

        GenJnlLine."VAT Date" := SalesHeader."VAT Date";
        GenJnlLine."Bill Type" := SalesHeader."Bill Type";
        GenJnlLine."Bill Category" := SalesHeader."Bill Category";
        GenJnlLine."Customer Category" := SalesHeader."Customer Category";

    end;



    procedure CheckMultiplePostingGr(var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; Customer: Boolean): Boolean
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PostingGroup: Code[10];
    begin
        //+BH1.04
        PostingGroup := '';
        DtldCVLedgEntryBuf.RESET;
        DtldCVLedgEntryBuf.SETRANGE("Entry Type", DtldCVLedgEntryBuf."Entry Type"::Application);
        IF DtldCVLedgEntryBuf.FINDSET THEN
            REPEAT
                IF Customer THEN BEGIN
                    CustLedgEntry.GET(DtldCVLedgEntryBuf."CV Ledger Entry No.");
                    IF (PostingGroup <> '') AND (PostingGroup <> CustLedgEntry."Customer Posting Group") THEN
                        EXIT(TRUE);
                    PostingGroup := CustLedgEntry."Customer Posting Group";
                END ELSE BEGIN
                    VendLedgEntry.GET(DtldCVLedgEntryBuf."CV Ledger Entry No.");
                    IF (PostingGroup <> '') AND (PostingGroup <> VendLedgEntry."Vendor Posting Group") THEN
                        EXIT(TRUE);
                    PostingGroup := VendLedgEntry."Vendor Posting Group";
                END;
            UNTIL DtldCVLedgEntryBuf.NEXT = 0;
        EXIT(FALSE);
        //-BH1.04
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', true, true)]
    local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry."Bill Category" := GenJournalLine."Bill Category";
        DtldCustLedgEntry."Bill type" := GenJournalLine."Bill type";
        DtldCustLedgEntry.Amount := round(DtldCustLedgEntry.Amount, 0.01, '=');
        DtldCustLedgEntry."Amount (LCY)" := round(DtldCustLedgEntry."Amount (LCY)", 0.01, '=');
        DtldCustLedgEntry."Credit Amount" := round(DtldCustLedgEntry."Credit Amount", 0.01, '=');
        DtldCustLedgEntry."Credit Amount (LCY)" := round(DtldCustLedgEntry."Credit Amount (LCY)", 0.01, '=');
        DtldCustLedgEntry."Debit Amount" := round(DtldCustLedgEntry."Debit Amount", 0.01, '=');
        DtldCustLedgEntry."Debit Amount (LCY)" := round(DtldCustLedgEntry."Debit Amount (LCY)", 0.01, '=');



    end;


    //kraj
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post (Yes/No)", 'OnBeforeConfirmServPost', '', true, true)]
    local procedure OnBeforeConfirmServPost(var ServiceHeader: Record "Service Header"; var Ship: Boolean; var Consume: Boolean; var Invoice: Boolean; var HideDialog: Boolean)
    var
        ConfirmPostLbl: Label 'Do you want to post costs for this order?';
        ProcessAbortedErr: Label 'Process aborted!';
        SIL: Record "Service Line";
    begin
        if ServiceHeader."Request Type" = Enum::"Request Type"::"Others" then
            exit;

        if ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"Billing Invoice" then begin
            if not Confirm(ConfirmPostLbl, false) then
                Error(ProcessAbortedErr);
        end;

        SIL.reset;
        sil.SetFilter("Document No.", '%1', ServiceHeader."No.");
        sil.SetFilter(type, '%1', sil.type::Item);
        if not sil.FindFirst() then begin
            Ship := true;
            Consume := false;
            Invoice := true;

            HideDialog := true;
        end
        else begin
            Ship := true;
            Consume := false;
            Invoice := true;

            HideDialog := false;
        end;
    end;
    //  [IntegrationEvent(false, false)]


    //Service Line

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromServLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromServLine(var ItemJnlLine: Record "Item Journal Line"; ServLine: Record "Service Line")
    begin
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::sale then begin
            ItemJnlLine."Sales Header No." := ServLine."Document No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"VAT Amount Line", 'OnUpdateLinesOnAfterCalcVATAmount', '', true, true)]

    [IntegrationEvent(false, false)]
    local procedure OnUpdateLinesOnAfterCalcVATAmount(var VATAmountLine: Record "VAT Amount Line"; PrevVATAmountLine: Record "VAT Amount Line"; var Currency: Record Currency; VATBaseDiscountPerc: Decimal; PricesIncludingVAT: Boolean)
    begin
    end;


    [EventSubscriber(ObjectType::Table, database::"Service Line", 'OnAfterClearFields', '', true, true)]
    local procedure OnAfterClearFields(var ServiceLine: Record "Service Line"; xServiceLine: Record "Service Line"; TempServiceLine: Record "Service Line" temporary; CallingFieldNo: Integer)
    begin
        ServiceLine."RN Type" := ServiceLine.Type;

    end;


    [EventSubscriber(ObjectType::Table, database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure OnAfterCopyFromTransferHeader(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Sales Header No." := TransferHeader."Sales Header No.";
        TransferShipmentHeader."G/L Account No." := TransferHeader."G/L Account No.";
        TransferShipmentHeader."Department Code" := TransferHeader."Department Code";
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    begin
        ItemJnlLine."Sales Header No." := SalesHeader."No.";
        ItemJnlLine."Department Code" := SalesHeader."Department Code";
    end;

    //





    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetGLAccount(var GenJournalLine: Record "Gen. Journal Line"; var GLAccount: Record "G/L Account")
    begin
        IF (GenJournalLine."Journal Template Name" <> 'SREDSTVA') and (GenJournalLine."Journal Template Name" <> 'UPLATE') THEN BEGIN
            GenJournalLine."Gen. Posting Type" := GLAccount."Gen. Posting Type";
            GenJournalLine."Gen. Bus. Posting Group" := GLAccount."Gen. Bus. Posting Group";
            GenJournalLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
            GenJournalLine."VAT Bus. Posting Group" := GLAccount."VAT Bus. Posting Group";
            GenJournalLine."VAT Prod. Posting Group" := GLAccount."VAT Prod. Posting Group";
        end
        else begin
            GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
            GenJournalLine."Gen. Bus. Posting Group" := '';
            GenJournalLine."Gen. Prod. Posting Group" := '';
            GenJournalLine."VAT Bus. Posting Group" := '';
            GenJournalLine."VAT Prod. Posting Group" := '';
            GenJournalLine."FA Posting Type" := GenJournalLine."FA Posting Type"::" ";
        end;
    end;


    //CopyFromTransferHeader



    [EventSubscriber(ObjectType::Table, database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        users: Record "User Setup";
    begin
        CustLedgerEntry."Bin Checked" := GenJournalLine."Bin Checked";
        CustLedgerEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        CustLedgerEntry.KIF_Entry := GenJournalLine.KIF_Entry;
        CustLedgerEntry.KUF_Type := GenJournalLine.KUF_Type;
        CustLedgerEntry."VAT Date" := GenJournalLine."VAT Date";
        CustLedgerEntry."Cashier Employer" := GenJournalLine."Cashier Employer";
        CustLedgerEntry.Prepayment := GenJournalLine.Prepayment;
        CustLedgerEntry."Payment Reference" := GenJournalLine."Payment Reference";
        CustLedgerEntry."Bill Category" := GenJournalLine."Bill Category";
        CustLedgerEntry."Bill type" := GenJournalLine."Bill type";
        if (GenJournalLine."Bill type" = '') and (GenJournalLine."Payment Type" <> '') then
            CustLedgerEntry."Bill type" := GenJournalLine."Payment Type";
        CustLedgerEntry."Court Boolean" := GenJournalLine."Court Boolean";
        CustLedgerEntry."Customer Category" := GenJournalLine."Customer Category";
        CustLedgerEntry.MALS := GenJournalLine.MALS;
        CustLedgerEntry."Profit (LCY)" := round(CustLedgerEntry."Profit (LCY)", 0.01, '=');
        CustLedgerEntry."Sales (LCY)" := round(CustLedgerEntry."Sales (LCY)", 0.01, '=');

        /* users.Reset();
         users.SetFilter("User ID", '%1', UserId);
         if users.FindFirst() then begin
             CustLedgerEntry.KUF_Entry := users.KUF_Entry;
             CustLedgerEntry.KIF_Entry := users.KIF_Entry;
             CustLedgerEntry.KUF_Type := users.KUF_Type;
         end;*/




    end;

    [EventSubscriber(ObjectType::Table, database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyFromGenJnlLine(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")

    begin
        VATEntry."VAT Date" := GenJournalLine."VAT Date";
        VATEntry."Bill Type" := GenJournalLine."Bill Type";
        VATEntry."Bill Category" := GenJournalLine."Bill Category";
        VATEntry."Customer Category" := GenJournalLine."Customer Category";
        VATEntry.Prepayment := GenJournalLine.Prepayment;
        VATEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        VATEntry.KIF_Entry := GenJournalLine.KIF_Entry;
        if (GenJournalLine."CNG MP" = true) or (GenJournalLine."CNG VL" = true) or (GenJournalLine."CNG VP" = true) then
            VATEntry.Amount := GenJournalLine."VAT Difference CNG";
        /*    GenJournalLine.KIF_Entry := VATEntry.KIF_Entry;
            GenJournalLine.KUF_Entry := VATEntry.KUF_Entry;
            GenJournalLine.KUF_Type := VATEntry.KUF_Type;*/

    end;





    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")

    begin
        // GenJournalLine."Bin Checked" := SalesHeader."Bin Checked";
        GenJournalLine."VAT Date" := PurchaseHeader."VAT Date";
        GenJournalLine.KUF_Entry := PurchaseHeader.KUF;

        GenJournalLine.Prepayment := PurchaseHeader.Prepayment;
        GenJournalLine."Sales Header No." := PurchaseHeader."Sales Header No.";
    end;

    local procedure OnAfterGetNoSeriesCode(SalesHeader: Record "Sales Header"; var NoSeriesCode: Code[20])
    //local procedure OnAfterGetNoSeriesCode(SalesHeader: Record "Sales Header"; SalesSetup: Record "Sales & Receivables Setup"; NoSeriesCode: Code[20])

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CustTemp: record "Customer Templ.";
    begin

        SalesSetup.Get();
        if SalesHeader.Prepayment = true then begin
            NoSeriesCode := SalesSetup."Prepayment Invoice Nos.";
            SalesHeader."Posting No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";

        end;
        if SalesHeader."Bill type" <> '' then begin

            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', SalesHeader."Bill type");
            if CustTemp.FindFirst() then begin
                SalesHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";
                SalesHeader.validate("No. Series", CustTemp."No. Series Bill");

            end;



        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', true, true)]

    local procedure OnAfterGetNoSeriesCodePurch(PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20])
    //local procedure OnAfterGetNoSeriesCode(SalesHeader: Record "Sales Header"; SalesSetup: Record "Sales & Receivables Setup"; NoSeriesCode: Code[20])

    var

    begin

        PurchSetup.Get();
        if PurchHeader.Prepayment = true then begin
            NoSeriesCode := PurchSetup."Prepayment Invoice Nos.";
            PurchHeader."Posting No. Series" := PurchSetup."Prepayment Invoice Nos.";

        end
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterGetNoSeriesCode', '', true, true)]

    local procedure OnAfterGetNoSeriesCodeSales(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    //local procedure OnAfterGetNoSeriesCode(SalesHeader: Record "Sales Header"; SalesSetup: Record "Sales & Receivables Setup"; NoSeriesCode: Code[20])

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CustTemp: record "Customer Templ.";
    begin

        SalesSetup.Get();
        if SalesHeader.Prepayment = true then begin
            NoSeriesCode := SalesSetup."Prepayment Invoice Nos.";
            SalesHeader."Posting No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";

        end;
        if SalesHeader."Bill type" <> '' then begin

            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', SalesHeader."Bill type");
            if CustTemp.FindFirst() then begin
                SalesHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";
                SalesHeader.validate("No. Series", CustTemp."No. Series Bill");
                NoSeriesCode := SalesHeader."No. Series";

            end;

        end;
    end;


    [EventSubscriber(ObjectType::Table, database::"Service Header", 'OnAfterInitRecord', '', true, true)]
    local procedure OnAfterInitRecordService(var ServiceHeader: Record "Service Header")
    var
        NoSeries: Record "No. Series";
        CustTemp: record "Customer Templ.";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        RelationShip: Record "No. Series Relationship";
        US: Record "User Setup";

    begin

        //sada bi trebala dodijeliti brojčanu seriju za Knjiženi dokument, pa da bude jednak kao i zahtjev
        if strpos(ServiceHeader."No.", 'CZK') <> 0 then begin
            //da je ovo neki zahtjev iz CZK
            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', ServiceHeader."Bill type");
            if CustTemp.FindFirst() then begin

                //ovdje pronađem proknjiženi format ovog računa

                //  ServiceHeader."Posting No." := ServiceHeader."No.";
                //Đemina dodaj ovdje
                //e sad bi trebala prema tome kojem centru kupca pripadam
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."Posting No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";

                    end;

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."No. Series" := CustTemp."No. Series Bill";

                    end;

                end;

                NoSeriesMgt.InitSeries(ServiceHeader."Posting No. Series", '', ServiceHeader."Posting Date", ServiceHeader."Posting No.", ServiceHeader."Posting No. Series");
                NoSeriesMgt.InitSeries(ServiceHeader."No. Series", '', ServiceHeader."Posting Date", ServiceHeader."No.", ServiceHeader."No. Series");


            end;
        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        UserSetup: Record "User Setup";
        Cust: Record Customer;
    begin
        If SalesHeader.Invoice then begin
            UserSetup.Reset();
            UserSetup.SetFilter("User ID", '%1', UserId);
            if UserSetup.FindFirst() then begin
                if UserSetup."CNG User" = true then begin

                    Cust.GET(SalesHeader."Sell-to Customer No.");
                    IF Cust."VAT Registration No." <> '' then
                        ERROR('Ne možete knjižiti pravna lica');
                end;
            END;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 81, 'OnAfterPost', '', true, true)]
    local procedure OnAfterPost(var SalesHeader: Record "Sales Header")

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesL: Record "Sales Cr.Memo Line";
        Loc: Record Location;
        TransferHeader: Record "Transfer Header";
        TransferHeader2: Record "Transfer Header";
        Linija: Integer;
        TransferLine: Record "Transfer Line";
        CalculationSetup: Record "Calculation Setup";
        RTD: Codeunit "Release Transfer Document";
        SO: page "Sales Order";
        Loc2: record Location;
        BrojacTransfer: Integer;
        CountLine: Integer;
        BrojacTransfer2: Integer;
        CountLine2: Integer;
        TransferLine2: Record "Transfer Line";
        Linija2: Integer;
        SalesCRMemoHeader: record "Sales Cr.Memo Header";

    begin

        BrojacTransfer := 0;
        BrojacTransfer2 := 0;


        Loc.Reset();
        Loc.SetFilter("CNG VP", '%1', true);
        if loc.FindFirst() then begin
            //sada ako je sales header lokacije
            SalesCRMemoHeader.reset;

            SalesCRMemoHeader.SetFilter("Pre-Assigned No.", '%1', SalesHeader."No.");

            if SalesCRMemoHeader.findfirst then begin
                SalesL.Reset();
                //  SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::"Credit Memo");
                SalesL.SetFilter("Document No.", '%1', SalesCRMemoHeader."No.");
                SalesL.SetFilter("Quantity", '<>%1', 0);
                SalesL.SetFilter("Location Code", '%1', loc.Code);
                if SalesL.FindSet() then
                    repeat

                        BrojacTransfer += 1;

                        //ovdje sada transfer

                        if BrojacTransfer = 1 then begin
                            TransferHeader.init;
                            TransferHeader.Validate("Transfer-from Code", loc.Code);
                            TransferHeader.Validate("Transfer-to Code", 'GLAVNO GAS');
                            TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                            TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                            TransferHeader.Validate("Sales Header No.", SalesHeader."No.");
                            TransferHeader.validate("Department Code", SalesHeader."Department Code");
                            commit;
                            Linija += 10000;

                            TransferHeader.Insert(true);
                            Commit();
                        end;
                        CalculationSetup.get;
                        TransferLine.init;
                        TransferLine.Validate("Document No.", TransferHeader."No.");
                        TransferLine.Validate("Line No.", Linija);
                        TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                        TransferLine.Validate(Quantity, SalesL.Quantity);

                        TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                        TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                        TransferLine.Insert(true);
                        //lansiraj
                        commit;





                    until SalesL.Next() = 0;
            end;
            if TransferHeader."No." <> '' then begin
                RTD.Run(TransferHeader);
                commit;

                SO.TransferHeaderPost_GAS(TransferHeader);
                Commit();


            end;
        end;

        BrojacTransfer := 0;
        BrojacTransfer2 := 0;
        Linija := 0;
        Loc.reset;
        Loc.setfilter("CNG MP", '%1', true);
        if Loc.findfirst then begin


            SalesCRMemoHeader.reset;

            SalesCRMemoHeader.SetFilter("Pre-Assigned No.", '%1', SalesHeader."No.");

            if SalesCRMemoHeader.findfirst then begin
                SalesL.Reset();
                //  SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::"Credit Memo");
                SalesL.SetFilter("Document No.", '%1', SalesCRMemoHeader."No.");
                SalesL.SetFilter("Quantity", '<>%1', 0);
                SalesL.SetFilter("Location Code", '%1', loc.Code);
                if SalesL.FindSet() then
                    repeat

                        CountLine := SalesL.count;

                        BrojacTransfer += 1;
                        //prvo bi trebala sam maloprodaje na vp, pa onda sa vp na glavno gas

                        if BrojacTransfer = 1 then begin
                            TransferHeader.init;
                            Loc2.reset;
                            Loc2.SetFilter("CNG VP", '%1', true);
                            if Loc2.findfirst then
                                TransferHeader.Validate("Transfer-from Code", Loc.Code);
                            TransferHeader.Validate("Transfer-to Code", loc2.Code);

                            TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                            TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                            TransferHeader.Validate("Sales Header No.", SalesHeader."No.");
                            TransferHeader.Validate("Department Code", SalesHeader."Department Code");
                            Linija += 10000;
                            TransferHeader.Insert(true);

                        end;
                        CalculationSetup.get;
                        TransferLine.init;
                        TransferLine.Validate("Document No.", TransferHeader."No.");
                        TransferLine.Validate("Line No.", Linija);
                        TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                        TransferLine.Validate(Quantity, SalesL.Quantity);
                        TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                        TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                        TransferLine.Insert(true);

                        //lansiraj
                        commit;
                        if CountLine = BrojacTransfer then begin
                            RTD.Run(TransferHeader);
                            commit;



                            //za glavno gas


                            SO.TransferHeaderPost_GAS(TransferHeader);
                            Commit();


                            commit;

                        end;
                        // Linija += 10000;

                        //i sad još jednom sa vlp na mlp

                        Loc.Reset();
                        Loc.SetFilter("CNG VP", '%1', true);
                        if loc.FindFirst() then begin

                            BrojacTransfer2 += 1;
                            CountLine2 := SalesL.count;
                            if BrojacTransfer2 = 1 then begin
                                TransferHeader2.init;
                                TransferHeader2.Validate("Transfer-from Code", loc.Code);
                                TransferHeader2.Validate("Transfer-to Code", 'GLAVNO GAS');
                                TransferHeader2.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                TransferHeader2.Validate("In-Transit Code", 'TRANZIT');
                                TransferHeader2.Validate("Sales Header No.", SalesHeader."No.");
                                TransferHeader2.Validate("Department Code", SalesHeader."Department Code");
                                commit;
                                Linija2 += 10000;

                                TransferHeader2.Insert(true);

                            end;
                            Commit();
                            CalculationSetup.get;
                            TransferLine2.init;
                            TransferLine2.Validate("Document No.", TransferHeader2."No.");
                            TransferLine2.Validate("Line No.", Linija2);
                            TransferLine2.Validate("Item No.", CalculationSetup."Item No.");
                            TransferLine2.Validate(Quantity, SalesL.Quantity);
                            TransferLine2.validate("Transfer-from Code", TransferHeader2."Transfer-from Code");
                            TransferLine2.validate("Transfer-to Code", TransferHeader2."Transfer-to Code");
                            TransferLine2.Insert(true);
                            //lansiraj
                            commit;

                            if BrojacTransfer2 = CountLine2 then begin
                                RTD.Run(TransferHeader2);
                                commit;

                                SO.TransferHeaderPost_GAS(TransferHeader2);

                                Commit();
                            end;



                        end;
                    until SalesL.Next() = 0;
            end;
        end;


    end;






    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnCalcVATAmountLinesOnAfterCalcLineTotals', '', false, false)]

    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals(var VATAmountLine: Record "VAT Amount Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; Currency: Record Currency; QtyType: Option General,Invoicing,Shipping; var TotalVATAmount: Decimal)
    begin
        TotalVATAmount := TotalVATAmount - SalesLine."VAT Difference CNG";
    end;







    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure OnAfterInitRecord(SalesHeader: Record "Sales Header")

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CustTemp: record "Customer Templ.";
    begin


        SalesSetup.Get();

        if SalesHeader.Prepayment = true then begin
            SalesHeader.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
            SalesHeader."Posting No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
        end;
        if (SalesHeader."Bill type" <> '') and (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) then begin

            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', SalesHeader."Bill type");
            if CustTemp.FindFirst() then begin
                SalesHeader.Validate("Posting No. Series", CustTemp."Posting No. Series Bill");
                SalesHeader.validate("No. Series", CustTemp."No. Series Bill");
            end;

        end;

    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnAfterInitRecord', '', true, true)]
    local procedure OnAfterInitRecordNew(PurchHeader: Record "Purchase Header")

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin

        PurchSetup.Get();

        if PurchHeader.Prepayment = true then begin
            PurchHeader.validate("Posting No. Series", PurchSetup."Posted Prepmt. Inv. Nos.");
            PurchHeader."Posting No. Series" := PurchSetup."Posted Prepmt. Inv. Nos.";
        end
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterGetPostingNoSeriesCode', '', true, true)]
    local procedure OnAfterGetPostingNoSeriesCode(SalesHeader: Record "Sales Header"; var PostingNos: Code[20])

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CustTemp: record "Customer Templ.";
    begin

        SalesSetup.Get();

        if SalesHeader.Prepayment = true then begin

            if (SalesHeader."No. Series" <> '') and (SalesSetup."Prepayment Invoice Nos." = SalesSetup."Posted Prepmt. Inv. Nos.") then
                SalesHeader."Posting No. Series" := SalesHeader."No. Series"
            else
                NoSeriesManagement.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
            PostingNos := SalesSetup."Posted Prepmt. Inv. Nos.";

        end;
        if SalesHeader."Bill type" <> '' then begin

            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', SalesHeader."Bill type");
            if CustTemp.FindFirst() then begin
                SalesHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";
                SalesHeader.validate("No. Series", CustTemp."No. Series Bill");
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnAfterGetPostingNoSeriesCode', '', true, true)]
    local procedure OnAfterGetPostingNoSeriesCodeNew(PurchaseHeader: Record "Purchase Header"; VAR PostingNos: Code[20])

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin

        PurchSetup.Get();

        if PurchaseHeader.Prepayment = true then begin
            if (PurchaseHeader."No. Series" <> '') and (PurchSetup."Prepayment Invoice Nos." = PurchSetup."Posted Prepmt. Inv. Nos.") then
                PurchaseHeader."Posting No. Series" := PurchaseHeader."No. Series"
            else
                NoSeriesManagement.SetDefaultSeries(PurchaseHeader."Posting No. Series", PurchSetup."Posted Prepmt. Inv. Nos.");
            PostingNos := PurchSetup."Posted Prepmt. Inv. Nos.";

        end
    end;

    //PostGLAndCustomer

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostGLAndCustomer', '', true, true)]
    procedure OnBeforePostGLAndCustomer(VAR SalesHeader: Record "Sales Header"; VAR TempInvoicePostBuffer: Record "Invoice Post. Buffer"; VAR CustLedgerEntry: Record "Cust. Ledger Entry"; CommitIsSuppressed: Boolean; PreviewMode: Boolean);
    begin

        CustLedgerEntry.Prepayment := SalesHeader.Prepayment;

    end;

    [EventSubscriber(ObjectType::Page, Page::"Fixed Asset Card", 'OnAfterLoadDepreciationBooks', '', true, true)]
    local procedure OnAfterLoadDepreciationBooks(FixedAsset: Record "Fixed Asset"; var Simple: Boolean);
    begin

    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, true)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        SH: Record "Service Header";
    begin



    end;






    [EventSubscriber(ObjectType::Table, database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Users: Record "User Setup";
    begin

        /*   users.Reset();
           users.SetFilter("User ID", '%1', UserId);
           if users.FindFirst() then begin
               VendorLedgerEntry.KUF_Entry := users.KUF_Entry;
               VendorLedgerEntry.KIF_Entry := users.KIF_Entry;
               VendorLedgerEntry.KUF_Type := users.KUF_Type;
           end;*/
        VendorLedgerEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        VendorLedgerEntry.KIF_Entry := GenJournalLine.KIF_Entry;


        VendorLedgerEntry."VAT Date" := GenJournalLine."VAT Date";
        VendorLedgerEntry.Prepayment := GenJournalLine.Prepayment;
        VendorLedgerEntry."Payment Reference" := GenJournalLine."Payment Reference";


    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetFAAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetFAAccount(var GenJournalLine: Record "Gen. Journal Line"; var FixedAsset: Record "Fixed Asset")
    begin
        GenJournalLine."Gen. Prod. Posting Group" := '';
    end;




    [EventSubscriber(ObjectType::Report, report::"Calculate Depreciation", 'OnBeforeGenJnlLineInsert', '', true, true)]
    local procedure OnBeforeGenJnlLineInsert(var TempGenJournalLine: Record "Gen. Journal Line" temporary; var GenJournalLine: Record "Gen. Journal Line")
    var
        Fixed: Record "Fixed Asset";
        DeprBook: Record "Depreciation Book";
        FaPosting: Record "FA Posting Group";
        ErrorNo: Integer;
        FADeprBook: Record "FA Depreciation Book";

    begin

        //dodati
        Fixed.Reset();
        Fixed.SetFilter("No.", '%1', TempGenJournalLine."Account No.");
        if Fixed.FindFirst() then begin
            FADeprBook.Reset();
            FADeprBook.SetFilter("Depreciation Book Code", '%1', GenJournalLine."Depreciation Book Code");
            FADeprBook.SetFilter("FA No.", '%1', TempGenJournalLine."Account No.");
            if FADeprBook.FindFirst() then begin
                FaPosting.Get(FADeprBook."FA Posting Group");
                if Fixed."Donation Percentage" <> 0 then begin
                    TempGenJournalLine.Validate(Donation, FaPosting."Depreciation Expense Acc. D.");
                    TempGenJournalLine.Validate("Donation Percentage", Fixed."Donation Percentage");
                    TempGenJournalLine.Validate(OS, TempGenJournalLine."Account No.");
                end
                else begin
                    TempGenJournalLine.Donation := '';
                    TempGenJournalLine."Donation Percentage" := 0;
                    TempGenJournalLine.OS := '';

                end;
                GenJournalLine.Donation := TempGenJournalLine.Donation;
                GenJournalLine."Donation Percentage" := TempGenJournalLine."Donation Percentage";
                GenJournalLine.Validate(OS, TempGenJournalLine."Account No.");


                if (GenJournalLine."Donation Percentage" = 1) then begin



                end;

            end;

            //


            //i ako je genJournalLineDonation <>0
        end;

    end;





    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert G/L Account", 'OnGetBalAccAfterSaveGenJnlLineFields', '', true, true)]
    procedure OnGetBalAccAfterSaveGenJnlLineFields(var ToGenJnlLine: Record "Gen. Journal Line"; FromGenJnlLine: Record "Gen. Journal Line"; var SkipInsert: Boolean)
    begin


        //    ToGenJnlLine.OS := FromGenJnlLine."Account No.";


    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert G/L Account", 'OnGetBalAccAfterRestoreGenJnlLineFields', '', true, true)]
    procedure OnGetBalAccAfterRestoreGenJnlLineFields(var ToGenJnlLine: Record "Gen. Journal Line"; FromGenJnlLine: Record "Gen. Journal Line")
    begin

        // ToGenJnlLine.OS := FromGenJnlLine."Account No.";
        if (ToGenJnlLine."Donation Percentage" = 100) and (ToGenJnlLine."Account Type" = ToGenJnlLine."Account Type"::"G/L Account") then begin
            ToGenJnlLine.Validate("Account No.", ToGenJnlLine.Donation);

            if (ToGenJnlLine."Donation Percentage" > 0) and (ToGenJnlLine."Donation Percentage" < 100) then begin

                //da ovdje uradim insert

                //ali nemam još uvije iD

            end;

        end;


    end;


    //OnBeforeGetBalAccLocal

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert G/L Account", 'OnBeforeGetBalAccLocal', '', true, true)]
    procedure OnBeforeGetBalAccLocal(var GenJournalLine: Record "Gen. Journal Line")
    begin

        GenJournalLine.OS := GenJournalLine."Account No.";


    end;




    //    local procedure OnAfterPostDataItem()

    [EventSubscriber(ObjectType::Report, report::"Calculate Depreciation", 'OnAfterFAInsertGLAccGetBalAcc', '', true, true)]
    local procedure OnAfterFAInsertGLAccGetBalAcc(var GenJnlLine: Record "Gen. Journal Line"; var GenJnlNextLineNo: Integer; var BalAccount: Boolean)

    var
        Fixed: Record "Fixed Asset";
        DeprBook: Record "Depreciation Book";
        FaPosting: Record "FA Posting Group";
        ErrorNo: Integer;
        FADeprBook: Record "FA Depreciation Book";
        GJ: Record "Gen. Journal Line";
        GJ2: Record "Gen. Journal Line";
        GJ3: Record "Gen. Journal Line";
        GJ4: Record "Gen. Journal Line";
        Procenat: Decimal;
        DeleteYes: Boolean;
        RoundValue: Decimal;
        OrginalValue: Decimal;



    begin

        GJ.Reset();
        GJ.SetFilter(Donation, '<>%1', '');
        //      GJ.SetFilter("Account No.", '%1', GenJnlLine."Account No.");
        if GJ.FindSet() then
            repeat
                DeleteYes := false;
                if GJ."Account Type" = GJ."Account Type"::"Fixed Asset" then begin

                    Fixed.Reset();
                    Fixed.SetFilter("No.", '%1', GJ."Account No.");
                    if Fixed.FindFirst() then begin
                        FADeprBook.Reset();
                        FADeprBook.SetFilter("Depreciation Book Code", '%1', GJ."Depreciation Book Code");
                        FADeprBook.SetFilter("FA No.", '%1', GJ."Account No.");
                        if FADeprBook.FindFirst() then begin
                            FaPosting.Get(FADeprBook."FA Posting Group");
                            if Fixed."Donation Percentage" <> 0 then
                                Procenat := Fixed."Donation Percentage" / 100;
                        end;

                    end;
                end
                else begin


                    GJ2.Reset();
                    GJ2.SetFilter("Document No.", '%1', GJ."Document No.");
                    GJ2.SetFilter("Account Type", '%1', GJ2."Account Type"::"G/L Account");
                    GJ2.SetFilter(OS, '%1', GenJnlLine."Account No.");
                    if GJ2.FindFirst() then begin
                        GJ3.Init();
                        GJ3.TransferFields(GJ2);
                        GJ3."Line No." := GJ2."Line No." + 1;
                        GJ3.Donation := '';
                        GJ3.validate("Account No.", GJ.Donation);
                        //ovdje treba dodati ovo ako iznos prelazi, da se umanji za ostatak na posljednjoj

                        GJ.Validate(Amount, GJ.Amount * (Procenat));

                        OrginalValue := GJ3.Amount;
                        gj3.validate(amount, GJ3.Amount * (Procenat));
                        RoundValue := GJ3.Amount;
                        if Procenat = 1 then RoundValue := 0;
                        GJ3.Validate(Amount, OrginalValue - RoundValue);

                        if Procenat = 1 then begin
                            GJ.Delete();
                            DeleteYes := true;
                        end;
                        GJ3.Insert();

                    end;

                end;

                if DeleteYes = false then begin
                    GJ.Donation := '';
                    GJ.Modify();
                end;


            until GJ.Next() = 0;



    end;



    // [IntegrationEvent(false, false)]

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeCreatePostedWhseShptHeader', '', true, true)]
    local procedure OnBeforeCreatePostedWhseShptHeader(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesHeader: Record "Sales Header")
    begin
        PostedWhseShipmentHeader."Document No." := WarehouseShipmentHeader."Document No.";
        PostedWhseShipmentHeader."Assigned User ID" := WarehouseShipmentHeader."Assigned User ID";
        PostedWhseShipmentHeader."Employee No." := WarehouseShipmentHeader."Employee No.";
        PostedWhseShipmentHeader."Employee Name" := WarehouseShipmentHeader."Employee Name";
        PostedWhseShipmentHeader."RN Source" := WarehouseShipmentHeader."RN Source";
        PostedWhseShipmentHeader.Address := WarehouseShipmentHeader.Address;
        PostedWhseShipmentHeader."Sales Header No." := WarehouseShipmentHeader."Sales Header No.";
        PostedWhseShipmentHeader."G/L Account No." := WarehouseShipmentHeader."G/L Account No.";
        PostedWhseShipmentHeader."Department Code" := WarehouseShipmentHeader."Department Code";

    end;



    [EventSubscriber(ObjectType::Codeunit, 415, 'OnCodeOnAfterCheck', '', true, true)]
    local procedure OnCodeOnAfterCheck(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var LinesWereModified: Boolean)
    var
        PurcLine: Record "Purchase Line";
    begin
        PurcLine.Reset();

        PurcLine.SetFilter("Document No.", '%1', PurchaseHeader."No.");
        PurcLine.SetFilter(Type, '%1', PurchaseLine.Type::"Fixed Asset");
        if PurcLine.FindSet() then
            repeat
                PurcLine.TestField("Location Code");


            until PurcLine.Next() = 0;


    end;

    //"Get Source Doc. Inbound"


    // [IntegrationEvent(false, false)]


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnPostSalesLineOnBeforeInsertShipmentLine', '', true, true)]
    local procedure OnPostSalesLineOnBeforeInsertShipmentLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35])
    begin
        if ((SalesLine."Quantity Shipped" <> 0) // (SalesLine."Fiscal printed" = true) 
        and (SalesLine."New Price" = false))
         then
            IsHandled := true;


    end;



    [EventSubscriber(ObjectType::Table, 111, 'OnAfterInitFromSalesLine', '', true, true)]
    local procedure OnAfterInitFromSalesLine(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";

    begin
        SH.Reset();
        SH.SetFilter("No.", '%1', SalesShptLine."Order No.");
        if sH.FindFIRST() then begin
            SalesShptLine."Payment Method Code" := SH."Payment Method Code";
            //nk
        end;
        SalesShptHeader."RN Source" := SH."RN Source";




        SL.Reset();
        SL.SetFilter("Document No.", '%1', SalesShptLine."Order No.");
        SL.SetFilter("Line No.", '%1', SalesShptLine."Order Line No.");
        if SL.FindFIRST() then begin
            SalesShptLine."Amount" := SL.Amount;
            SalesShptLine."Payment Method Code" := SalesLine."Payment Method Code";
            SalesShptLine."Fiscal DateTime" := SalesLine."Fiscal DateTime";
            SalesShptLine."Fiscal No." := SalesLine."Fiscal No.";
            SalesShptLine."Fiscal printed" := SalesLine."Fiscal printed";
            SalesShptLine."Fiscal User" := SalesLine."Fiscal User";
            SalesShptLine."Bill Type" := SH."Bill type";


            SalesShptLine."Amount Incl. VAT" := SL."Amount Including VAT";
            cust.Reset();
            cust.GET(SL."Sell-to Customer No.");
            if Cust."Internal Customer" then
                SalesShptLine."Internal" := TRUE
            else
                SalesShptLine."Internal" := FALSE;
            SalesSetup.GET;
            if SalesSetup."NN Customer Code" = SL."Sell-to Customer No." then
                SalesShptLine."NN" := TRUE
            else
                SalesShptLine."NN" := FALSE;
        end;

    end;
    //n





    [EventSubscriber(ObjectType::Codeunit, 5750, 'OnBeforeCreateShptLineFromSalesLine', '', true, true)]
    local procedure OnBeforeCreateShptLineFromSalesLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")

    begin
        WarehouseShipmentLine."Sales Header No." := WarehouseShipmentHeader."Sales Header No.";
        WarehouseShipmentLine."G/L Account No." := WarehouseShipmentHeader."G/L Account No.";
        WarehouseShipmentHeader."Department Code" := WarehouseShipmentHeader."Department Code";

    end;



    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        WSL: Record "Warehouse Shipment Line";
        WSH: Record "Warehouse Shipment Header";
        Location: Record Location;


        SL: Record "Sales Line";
    begin

        SalesShptHeader.CNG := false;

        sl.Reset();
        sl.SetFilter("Document No.", '%1', SalesHeader."No.");
        if sl.FindSet() then
            repeat
                Location.Reset();
                Location.SetFilter("CNG MP", '%1', true);
                if Location.FindFirst() then begin

                    if sl."Location Code" = Location.Code then
                        SalesShptHeader.CNG := true;
                end;

                Location.Reset();
                Location.SetFilter("CNG VP", '%1', true);
                if Location.FindFirst() then begin

                    if sl."Location Code" = Location.Code then
                        SalesShptHeader.CNG := true;
                end;



            until sl.Next() = 0;

        WSL.Reset();
        WSL.SetFilter("Source No.", '%1', SalesHeader."No.");
        if WSL.FindFirst() then begin
            WSH.Reset();
            if WSH.Get(WSL."No.") then begin

                SalesShptHeader."Document No." := WSH."Document No.";

                Location.Reset();
                Location.SetFilter("CNG MP", '%1', true);
                if Location.FindFirst() then begin

                    if WSH."Location Code" = Location.Code then
                        SalesShptHeader.CNG := true;
                end;

                Location.Reset();
                Location.SetFilter("CNG VP", '%1', true);
                if Location.FindFirst() then begin

                    if WSH."Location Code" = Location.Code then
                        SalesShptHeader.CNG := true;
                end;


            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 5761, 'OnBeforeConfirmWhseReceiptPost', '', true, true)]
    local procedure OnBeforeConfirmWhseReceiptPost(var WhseReceiptLine: Record "Warehouse Receipt Line"; var HideDialog: Boolean; var IsPosted: Boolean)

    var
        PurchHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Location: Record Location;
    begin
        PurchHeader.Reset();
        PurchHeader.SetFilter("No.", '%1', WhseReceiptLine."Source No.");
        if PurchHeader.FindFirst() then begin
            if PurchHeader."Sales Header No." <> '' then begin
                SalesHeader.Reset();
                SalesHeader.SetFilter("No.", '%1', PurchHeader."Sales Header No.");
                if SalesHeader.FindFirst() then begin

                    SalesLine.Reset();
                    SalesLine.SetFilter("Line No.", '%1', WhseReceiptLine."Source Line No.");
                    //   SalesLine.SetFilter("Document Type", '%1', WhseReceiptLine."Source Document");
                    SalesLine.SetFilter("Document No.", '%1', PurchHeader."Sales Header No.");
                    if SalesLine.FindFirst() then begin
                        Location.Reset();
                        Location.SetFilter(Code, '%1', SalesLine."Location Code");
                        if Location.FindFirst() then begin
                            if (Location."CNG MP" = true) or (Location."CNG VP" = true)
                            then begin
                                HideDialog := true;
                                WhseReceiptLine."Sales Header No." := PurchHeader."Sales Header No.";
                            end;

                        end;

                    end;
                end;


            end;

        end;



    end;

    //"Purch.-Post (Yes/No)"



    [EventSubscriber(ObjectType::Codeunit, 91, 'OnBeforeConfirmPost', '', true, true)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)


    var
        SalesLine: Record "Sales Line";
        Location: Record Location;
    begin

        Location.Reset();
        Location.SetFilter("CNG MP", '%1', true);
        if Location.FindFirst() then begin



            SalesLine.Reset();
            SalesLine.SetFilter("Document No.", '%1', PurchaseHeader."Sales Header No.");
            SalesLine.SetFilter("Location Code", '%1', Location.Code);
            if SalesLine.FindFirst() then
                HideDialog := true;

        end;

        Location.Reset();
        Location.SetFilter("CNG VP", '%1', true);
        if Location.FindFirst() then begin



            SalesLine.Reset();
            SalesLine.SetFilter("Document No.", '%1', PurchaseHeader."Sales Header No.");
            SalesLine.SetFilter("Location Code", '%1', Location.Code);
            if SalesLine.FindFirst() then
                HideDialog := true;

        end;

        if HideDialog = true then begin


        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptHeaderInsert', '', true, true)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)

    var

        WRH: Record "Warehouse Receipt Header";
        WRL: Record "Warehouse Receipt Line";
    begin

        PurchRcptHeader."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        PurchRcptHeader."Vendor Name" := PurchaseHeader."Buy-from Vendor Name";

        WRL.Reset();
        WRL.SetFilter("Source No.", '%1', PurchaseHeader."No.");
        if WRL.FindFirst() then begin
            //No
            WRH.Reset();
            WRH.SetFilter("No.", '%1', WRL."No.");
            if WRH.FindFirst() then begin
                PurchRcptHeader."Assigned User ID" := WRH."Assigned User ID";
                PurchRcptHeader."Vendor Date" := WRH."Vendor Date";
                PurchRcptHeader."Order Date" := WRH."Order Date";

            end
            else begin
                PurchRcptHeader."Order Date" := 0D;
                PurchRcptHeader."Vendor Date" := 0D;

            end;

        end
        else begin
            PurchRcptHeader."Order Date" := 0D;
            PurchRcptHeader."Vendor Date" := 0D;
        end;

        //Vendor Date

        //

    end;


    [EventSubscriber(ObjectType::Codeunit, 5750, 'OnTransLine2ReceiptLineOnAfterInitNewLine', '', true, true)]
    local procedure OnTransLine2ReceiptLineOnAfterInitNewLine(var WhseReceiptLine: Record "Warehouse Receipt Line"; WhseReceiptHeader: Record "Warehouse Receipt Header"; TransferLine: Record "Transfer Line")

    begin
        WhseReceiptHeader."Sales Header No." := TransferLine."Sales Header No.";
        WhseReceiptLine."Sales Header No." := TransferLine."Sales Header No.";
        WhseReceiptLine."Department Code" := TransferLine."Department Code";


    end;



    [EventSubscriber(ObjectType::Codeunit, 5760, 'OnBeforePostedWhseRcptHeaderInsert', '', true, true)]
    local procedure OnBeforePostedWhseRcptHeaderInsert(var PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        PostedWhseReceiptHeader."Vendor Date" := WarehouseReceiptHeader."Vendor Date";
        PostedWhseReceiptHeader."Order Date" := WarehouseReceiptHeader."Order Date";
        PostedWhseReceiptHeader."Sales Header No." := WarehouseReceiptHeader."Sales Header No.";
        PostedWhseReceiptHeader."RN Source" := WarehouseReceiptHeader."RN Source";
        PostedWhseReceiptHeader.Address := WarehouseReceiptHeader.Address;
        PostedWhseReceiptHeader."User ID Number" := WarehouseReceiptHeader."User ID Number";
        PostedWhseReceiptHeader."Department Code" := WarehouseReceiptHeader."Department Code";
    end;

    procedure OnBeforeInsertVAT(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var UnrealizedVAT: Boolean; var AddCurrencyCode: Code[10]; var VATPostingSetup: Record "VAT Posting Setup"; var GLEntryAmount: Decimal; var GLEntryVATAmount: Decimal; var GLEntryBaseAmount: Decimal; var SrcCurrCode: Code[10]; var SrcCurrGLEntryAmt: Decimal; var SrcCurrGLEntryVATAmt: Decimal; var SrcCurrGLEntryBaseAmt: Decimal)

    var
        GLSetup: Record "General Ledger Setup";
    begin

        VATEntry."VAT Date" := GenJournalLine."VAT Date";
        VATEntry."Postponed VAT" := GenJournalLine."Postponed VAT";
        VATEntry.Amount := round(VATEntry.Amount, 0.01, '=');
        VATEntry.Base := round(VATEntry.Base, 0.01, '=');
        VATEntry."Base Before Pmt. Disc." := round(VATEntry."Base Before Pmt. Disc.", 0.01, '=');
        GLSetup.Get();

        // IF GLSetup."Prepayment Unrealized VAT" AND NOT GLSetup."Unrealized VAT" AND
        IF GLSetup."Prepayment Unrealized VAT" AND NOT GLSetup."Unrealized VAT" AND
            (VATPostingSetup."Unrealized VAT Type" > 0)
         THEN
            UnrealizedVAT := GenJournalLine.Prepayment;
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertVATEntry', '', true, true)]
    procedure OnBeforeInsertVATEntry(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")

    var
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        VatEntryInsertKUF: Record "VAT Entry";
        users: Record "User Setup";
        PHR: record "Purch. Inv. Header";
    begin

        VATEntry.KUF_Entry := '';
        VATEntry.KIF_Entry := '';
        VATEntry."VAT Difference CNG" := GenJournalLine."VAT Difference CNG";
        VATEntry.Amount := VATEntry.Amount - VATEntry."VAT Difference CNG";

        VATEntry.Amount := round(VATEntry.Amount, 0.01, '=');
        GLSetup.Get();
        VATPostingSetup.Get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
        //+BH1.02
        IF (VATPostingSetup."VAT % (retrograde)" <> 0) THEN
            CASE VATPostingSetup."VAT Calculation Type" OF
                VATPostingSetup."VAT Calculation Type"::"Full VAT":
                    BEGIN
                        VATEntry."VAT Base (retro.)" := ROUND(VATEntry.Amount * 100 / VATPostingSetup."VAT % (retrograde)");
                        VATEntry."VAT Amount (retro.)" := VATEntry.Amount;
                        VATEntry."Unrealized Base (retro.)" := ROUND(VATEntry."Unrealized Amount" * 100 / VATPostingSetup."VAT % (retrograde)");
                        VATEntry."Unrealized Amount (retro.)" := VATEntry."Unrealized Amount";
                    END;
                VATPostingSetup."VAT Calculation Type"::"Normal VAT":
                    BEGIN
                        VATEntry."VAT Base (retro.)" := ROUND(VATEntry.Base * 100 / (100 + VATPostingSetup."VAT % (retrograde)"));
                        VATEntry."VAT Amount (retro.)" := VATEntry.Base - VATEntry."VAT Base (retro.)";
                        VATEntry."Unrealized Base (retro.)" := ROUND(VATEntry."Unrealized Base" * 100 / (100 + VATPostingSetup."VAT % (retrograde)"));
                        VATEntry."Unrealized Amount (retro.)" := VATEntry."Unrealized Base" - VATEntry."Unrealized Base (retro.)";
                    END;
                //reverse
                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                        VATEntry."VAT Base (retro.)" := ROUND(VATEntry.Base * 100 / (100 + VATPostingSetup."VAT % (retrograde)"));
                        VATEntry."VAT Amount (retro.)" := VATEntry.Base - VATEntry."VAT Base (retro.)";
                        VATEntry."Unrealized Base (retro.)" := ROUND(VATEntry."Unrealized Base" * 100 / (100 + VATPostingSetup."VAT % (retrograde)"));
                        VATEntry."Unrealized Amount (retro.)" := VATEntry."Unrealized Base" - VATEntry."Unrealized Base (retro.)";
                    END;

            END;
        //-BH1.02
        IF (((VATEntry."Gen. Bus. Posting Group") = 'INO') OR (VATEntry."VAT Calculation Type".AsInteger() = 2) OR (VATEntry."VAT Prod. Posting Group" = 'PUNI PDV')) THEN VATEntry.Import := TRUE;
        IF (VATEntry."VAT Prod. Posting Group") = 'VAT0INO' THEN VATEntry.Import := FALSE;
        IF (VATEntry."VAT Prod. Posting Group") = 'ZAKUP' THEN VATEntry.Import := FALSE;
        IF ((VATEntry."VAT Calculation Type".AsInteger() = 1) and (VATEntry."VAT Prod. Posting Group" <> 'PUNI PDV')) THEN VATEntry.Import := FALSE;

        //dio koji se odnosi na KUF - br. KUF-a


        if (VATEntry.Type = VATEntry.Type::Sale) or ((VATEntry."VAT Calculation Type" = VATEntry."VAT Calculation Type"::"Reverse Charge VAT")
        and (VATEntry.Type = VATEntry.Type::Purchase)) then begin

            if (VATEntry.Type = VATEntry.Type::Purchase) and (
                   (VATEntry."Document No." <> 'PAF*') or (VATEntry."Document No." <> 'CPAF*'))
                   and (VATEntry."Source Code" <> 'OPCINALOS') and (VATEntry."VAT Bus. Posting Group" <> 'D-0-NEPDV') then begin

                //
                VATEntry.KUF_Entry := '';
                PHR.Reset();
                PHR.SetFilter("No.", '%1', VATEntry
                ."Document No.");
                if phr.FindFirst() then begin
                    VATEntry.KUF_Entry := phr.KUF;
                end;

                //     VatEntryInsertKUF.SetFilter(Type, '%1', VatEntryInsertKUF.Type::Purchase);


            end;

        end;



        //ovdje sada dodam dio oko KUF-a
        if (VATEntry.Type = VATEntry.Type::Purchase) and (
            (VATEntry."Document No." <> 'PAF*') or (VATEntry."Document No." <> 'CPAF*'))
            and (VATEntry."Source Code" <> 'OPCINALOS') and (VATEntry."VAT Bus. Posting Group" <> 'D-0-NEPDV') then begin
            //ovdje bi mi se desio dio oko broja stavke: 

            if (VATEntry.Import = false) and ((VATEntry."VAT Prod. Posting Group" <> 'AV*') and
             (VATEntry."VAT Prod. Posting Group" <> 'SAMO PDV A')) then begin

                /*   VatEntryInsertKUF.Reset();

                   VatEntryInsertKUF.SETFILTER("Document No.", '<>%1|%2', 'PAF*', 'CPAF*');
                   VatEntryInsertKUF.SETFILTER("Source Code", '<>%1', 'OPCINALOS');
                   VatEntryInsertKUF.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-0-NEPDV');
                   VatEntryInsertKUF.SetFilter("Posting Date", '%1..%2', DMY2Date(1, 1, Date2DMY(VATEntry."Posting Date", 3)),
   DMY2Date(31, 12, Date2DMY(VATEntry."Posting Date", 3)));
                   VatEntryInsertKUF.SetCurrentKey("Posting Date", "Document No.");
                   VatEntryInsertKUF.SetFilter(Type, '%1', VatEntryInsertKUF.Type::Purchase);
                   VatEntryInsertKUF.SetFilter(KUF_Type, '%1', VatEntryInsertKUF.KUF_Type::"DOMAĆI");
                   VatEntryInsertKUF.SetCurrentKey(KUF_Entry);
                   VatEntryInsertKUF.Ascending;
                   if VatEntryInsertKUF.FindLast() then begin
                       VATEntry.KUF_Type := VatEntryInsertKUF.KUF_Type::"DOMAĆI";
                       VATEntry.KUF_Entry := VatEntryInsertKUF.KUF_Entry + 1;

                   end
                   else begin
                       VATEntry.KUF_Type := VatEntryInsertKUF.KUF_Type::"DOMAĆI";
                       VATEntry.KUF_Entry := 1;

                   end;*/

                VATEntry.KUF_Entry := '';
                PHR.Reset();
                PHR.SetFilter("No.", '%1', VATEntry
                ."Document No.");
                if phr.FindFirst() then begin
                    VATEntry.KUF_Entry := phr.KUF;
                end;



                IF (VATEntry."VAT Prod. Posting Group" = 'AV*') or (VATEntry."VAT Prod. Posting Group" = 'SAMO PDV A') THEN BEGIN

                    VatEntryInsertKUF.Reset();

                    /*  VatEntryInsertKUF.SETFILTER("Document No.", '<>%1|%2', 'PAF*', 'CPAF*');
                      VatEntryInsertKUF.SETFILTER("Source Code", '<>%1', 'OPCINALOS');
                      VatEntryInsertKUF.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-0-NEPDV');
                      VatEntryInsertKUF.SetFilter("Posting Date", '%1..%2', DMY2Date(1, 1, Date2DMY(VATEntry."Posting Date", 3)),
  DMY2Date(31, 12, Date2DMY(VATEntry."Posting Date", 3)));
                      VatEntryInsertKUF.SetCurrentKey("Posting Date", "Document No.");
                      VatEntryInsertKUF.SetFilter(Type, '%1', VatEntryInsertKUF.Type::Purchase);
                      VatEntryInsertKUF.SetFilter(KUF_Type, '%1', VatEntryInsertKUF.KUF_Type::AVANSI);
                      VatEntryInsertKUF.SetCurrentKey(KUF_Entry);
                      VatEntryInsertKUF.Ascending;
                      if VatEntryInsertKUF.FindLast() then begin
                          VATEntry.KUF_Type := VatEntryInsertKUF.KUF_Type::AVANSI;
                          VATEntry.KUF_Entry := VatEntryInsertKUF.KUF_Entry + 1;

                      end
                      else begin
                          VATEntry.KUF_Type := VatEntryInsertKUF.KUF_Type::AVANSI;
                          VATEntry.KUF_Entry := 1;

                      end;*/

                    VATEntry.KUF_Entry := '';
                    PHR.Reset();
                    PHR.SetFilter("No.", '%1', VATEntry
                    ."Document No.");
                    if phr.FindFirst() then begin
                        VATEntry.KUF_Entry := phr.KUF;
                    end;


                END;

                if (VATEntry.Import = true) and ((VATEntry."VAT Prod. Posting Group" <> 'AV*') and
                (VATEntry."VAT Prod. Posting Group" <> 'SAMO PDV A')) then begin

                    //* VatEntryInsertKUF.Reset();

                    /*  VatEntryInsertKUF.SETFILTER("Document No.", '<>%1|%2', 'PAF*', 'CPAF*');
                      VatEntryInsertKUF.SETFILTER("Source Code", '<>%1', 'OPCINALOS');
                      VatEntryInsertKUF.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-0-NEPDV');
                      VatEntryInsertKUF.SetFilter("Posting Date", '%1..%2', DMY2Date(1, 1, Date2DMY(VATEntry."Posting Date", 3)),
  DMY2Date(31, 12, Date2DMY(VATEntry."Posting Date", 3)));
                      VatEntryInsertKUF.SetCurrentKey("Posting Date", "Document No.");
                      VatEntryInsertKUF.SetFilter(Type, '%1', VatEntryInsertKUF.Type::Purchase);
                      VatEntryInsertKUF.SetFilter(KUF_Type, '%1', VatEntryInsertKUF.KUF_Type::INO);
                      VatEntryInsertKUF.SetCurrentKey(KUF_Entry);
                      VatEntryInsertKUF.Ascending;
                      if VatEntryInsertKUF.FindLast() then begin
                          VATEntry.KUF_Type := VatEntryInsertKUF.KUF_Type::INO;
                          VATEntry.KUF_Entry := VatEntryInsertKUF.KUF_Entry + 1;

                      end
                      else begin
                          VATEntry.KUF_Type := VatEntryInsertKUF.KUF_Type::INO;
                          VATEntry.KUF_Entry := 1;

                      end;*/

                    VATEntry.KUF_Entry := '';
                    PHR.Reset();
                    PHR.SetFilter("No.", '%1', VATEntry
                    ."Document No.");
                    if phr.FindFirst() then begin
                        VATEntry.KUF_Entry := phr.KUF;
                    end;

                end;
            end;

        end;
        /*   users.Reset();
           users.SetFilter("User ID", '%1', UserId);
           if users.FindFirst() then begin
               users.KUF_Entry := VATEntry.KUF_Entry;
               users.KIF_Entry := VATEntry.KIF_Entry;
               users.KUF_Type := VATEntry.KUF_Type;
               users.Modify();

           end;*/

        VATEntry.Base := round(VATEntry.Base, 0.01, '=');
        VATEntry."Base Before Pmt. Disc." := round(VATEntry."Base Before Pmt. Disc.", 0.01, '=');
    end;
    //OnAfterInsertVATEntry(GenJnlLine,VATEntry,TempGLEntryBuf."Entry No.",NextVATEntryNo);

    [EventSubscriber(ObjectType::Codeunit, 5602, 'OnAfterGetAccNo', '', true, true)]
    procedure OnAfterGetAccNo(var FALedgEntry: Record "FA Ledger Entry"; var GLAccNo: Code[20])

    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        FAPostingGr: Record "FA Posting Group";
        FA: Record "Fixed Asset";
    // VATEntry2: Record "VAT Entry";
    begin
        if FALedgEntry."FA Posting Type" = FALedgEntry."FA Posting Type"::"Acquisition Cost" then begin

            FAPostingGr.get(FALedgEntry."FA Posting Group");




            IF ((FALedgEntry."Source Code" = 'NABAVA') AND (FAPostingGr."Investment Account" <> '')) OR ((FALedgEntry.Description = 'A')) THEN begin

                FAPostingGr.TESTFIELD("Investment Account");

                GLAccNo := FAPostingGr."Investment Account";

                if (FALedgEntry.Description = 'A') then begin
                    FA.Reset();
                    FA.SetFilter("No.", '%1', FALedgEntry."FA No.");
                    if FA.FindFirst() then begin
                        FA."Activation Date" := FALedgEntry."Posting Date";
                        FA.Modify();
                    end;
                end;

            end

            ELSE begin
                FAPostingGr.TESTFIELD("Acquisition Cost Account");
                GLAccNo := FAPostingGr."Acquisition Cost Account";
            end;








        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostVend', '', true, true)]
    procedure OnAfterPostVend(VAR GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; VAR TempGLEntryBuf: Record "G/L Entry"; VAR NextEntryNo: Integer; VAR NextTransactionNo: Integer)

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        CheckUnrealizedCust: Boolean;
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";

    begin
        //+BH1.01
        IF GenJournalLine."Postponed VAT" THEN BEGIN
            CheckUnrealizedCust := TRUE;
            //ĐK       UnrealizedCustLedgEntry := CustLedgEntry;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostCust', '', true, true)]
    procedure OnAfterPostCust(VAR GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; VAR TempGLEntryBuf: Record "G/L Entry"; VAR NextEntryNo: Integer; VAR NextTransactionNo: Integer)

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        CheckUnrealizedCust: Boolean;
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";

    begin
        //+BH1.01
        IF GenJournalLine."Postponed VAT" THEN BEGIN
            CheckUnrealizedCust := TRUE;
            //ĐK       UnrealizedCustLedgEntry := CustLedgEntry;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInsertVATEntry', '', true, true)]
    procedure OnAfterInsertVATEntry(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; VAR NextEntryNo: Integer)

    var
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
    begin

        InsertDetailedVATEntry(VATEntry);//BH1.03
        GenJnlLine.KUF_Entry := VATEntry.KUF_Entry;
        GenJnlLine.KIF_Entry := VATEntry.KIF_Entry;
        GenJnlLine.KUF_Type := VATEntry.KUF_Type;

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGlobalGLEntry', '', true, true)]
    procedure OnBeforeInsertGlobalGLEntry(VAR GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        GLAcc: Record "G/L Account";
        StartCompanyNotes: Codeunit "Start Company Notes";
        users: Record "User Setup";
        CJL: Record "Calculation Journal Line";

    begin

        /*  users.Reset();
          users.SetFilter("User ID", '%1', UserId);
          if users.FindFirst() then begin
              GlobalGLEntry.KUF_Entry := users.KUF_Entry;
              GlobalGLEntry.KIF_Entry := users.KIF_Entry;
              GlobalGLEntry.KUF_Type := users.KUF_Type;
              users.Modify();

          end;*/
        //da dodam ovo
        /*GlobalGLEntry."Employee No." := GenJournalLine.Employee;
        GlobalGLEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        GlobalGLEntry.KIF_Entry := GenJournalLine.KIF_Entry;
        GlobalGLEntry.KUF_Type := GenJournalLine.KUF_Type;*/

        GlobalGLEntry."Contact link" := GenJournalLine.Contact;
        GlobalGLEntry.KUF_Entry := GenJournalLine.KUF_Entry;
        GlobalGLEntry.KIF_Entry := GenJournalLine.KIF_Entry;
        GlobalGLEntry."Payment Type Code" := GenJournalLine."Payment Type";
        GlobalGLEntry."Payment Method" := GenJournalLine."Payment Method Code";




        //+BH1.05
        IF (GlobalGLEntry."G/L Account No." <> '') THEN BEGIN
            IF (GlobalGLEntry."System-Created Entry") THEN BEGIN
                GLAcc.GET(GlobalGLEntry."G/L Account No.");
                IF (GLAcc."Debit/Credit" <> GLAcc."Debit/Credit"::Both) THEN BEGIN
                    IF (GLAcc."Debit/Credit" = GLAcc."Debit/Credit"::Debit) AND (GlobalGLEntry."Debit Amount" = 0)
                    THEN BEGIN
                        GlobalGLEntry."Debit Amount" := -GlobalGLEntry."Credit Amount";
                        GlobalGLEntry."Credit Amount" := 0;
                    END;
                    IF (GLAcc."Debit/Credit" = GLAcc."Debit/Credit"::Credit) AND (GlobalGLEntry."Credit Amount" = 0)
                    THEN BEGIN
                        GlobalGLEntry."Credit Amount" := -GlobalGLEntry."Debit Amount";
                        GlobalGLEntry."Debit Amount" := 0;
                    END;
                END;
            END;
        END;
        //-BH1.05   
        IF StartCompanyNotes.GetPostingPrediction THEN
            StartCompanyNotes.InsertGLEIntoTempGLE(GlobalGLEntry);

        if (GenJournalLine."Bill type" in ['01', '02', '03']) and (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) then begin
            CJL.Reset();
            CJL.SetFilter("Customer No.", '%1', GenJournalLine."Account No.");
            cjl.SetFilter(Locked, '%1', false);
            if cjl.FindSet() then
                repeat
                    if cjl."Calculation Date To" <= GenJournalLine."Posting Date" then begin
                        cjl."Difference Balance" := true;
                        cjl.Modify();
                        /// Commit();
                    end;
                until cjl.Next() = 0;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeCustUnrealizedVAT', '', true, true)]
    procedure OnBeforeCustUnrealizedVAT(VAR GenJnlLine: Record "Gen. Journal Line"; VAR CustLedgEntry: Record "Cust. Ledger Entry"; SettledAmount: Decimal; VAR IsHandled: Boolean)

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        CheckUnrealizedCust: Boolean;
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";
        OriginalPostingDateForPostponedVAT: Date;

    begin
        //+BH1.01
        //+BH1.01
        IF GenJnlLine."Postponed VAT" THEN BEGIN
            GenJnlLine.TESTFIELD("VAT Date");
            OriginalPostingDateForPostponedVAT := GenJnlLine."Posting Date";
            GenJnlLine."Posting Date" := GenJnlLine."VAT Date";

            CustLedgEntry."Amount (LCY)" := 0;
            CustLedgEntry."Original Amt. (LCY)" := 0;
            CustLedgEntry."Remaining Amt. (LCY)" := 0;
            SettledAmount := 0;
        END;
        //-BH1.01


    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostUnrealVATEntry', '', true, true)]
    procedure OnAfterPostUnrealVATEntry(GenJnlLine: Record "Gen. Journal Line"; VAR VATEntry2: Record "VAT Entry")

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        CheckUnrealizedCust: Boolean;
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";
        OriginalPostingDateForPostponedVAT: Date;


    begin

        IF (GenJnlLine."VAT Amount" <> 0) OR (VATEntry2."Additional-Currency Amount" <> 0) OR GenJnlLine."Postponed VAT" THEN
            PostUnrealVATEntry2(GenJnlLine, VATEntry2, VATEntry2.Amount, VATEntry2.Base, VATEntry2."Additional-Currency Amount", VATEntry2."Additional-Currency Base");

        if GenJnlLine."Postponed VAT" then
            GenJnlLine."Posting Date" := OriginalPostingDateForPostponedVAT;

    end;

    LOCAL PROCEDURE PostUnrealVATEntry2(GenJnlLine: Record "Gen. Journal Line"; VAR VATEntry: Record "VAT Entry"; VATAmount: Decimal; VATBase: Decimal; VATAmountAddCurr: Decimal; VATBaseAddCurr: Decimal);
    var
        VATEntry2: Record "VAT Entry";
        NextVATEntryNo: Integer;
        GlobalGLEntry: Record "G/L Entry";
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
        NextConnectionNo: Integer;
        GLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link";
        GLEntryNo: Integer;

    BEGIN


        VATEntry2.LOCKTABLE;
        IF VATEntry2.FINDLAST THEN
            NextVATEntryNo := VATEntry2."Entry No." + 1
        ELSE
            NextVATEntryNo := 1;

        GlobalGLEntry.LOCKTABLE;
        IF GlobalGLEntry.FINDLAST THEN BEGIN
            NextEntryNo := GlobalGLEntry."Entry No." + 1;
            NextTransactionNo := GlobalGLEntry."Transaction No." + 1;
        END ELSE BEGIN
            NextEntryNo := 1;
            NextTransactionNo := 1;
        END;
        GLEntryNo := GlobalGLEntry."Entry No.";

        NextConnectionNo := NextConnectionNo + 1;
        VATEntry2.LOCKTABLE;
        VATEntry2 := VATEntry2;
        VATEntry2."Entry No." := NextVATEntryNo;
        VATEntry2."Posting Date" := GenJnlLine."Posting Date";
        VATEntry2."Document No." := GenJnlLine."Document No.";
        VATEntry2."External Document No." := GenJnlLine."External Document No.";
        VATEntry2."Document Type" := GenJnlLine."Document Type";
        VATEntry2.Amount := VATAmount;
        VATEntry2.Base := VATBase;
        VATEntry2."Additional-Currency Amount" := VATAmountAddCurr;
        VATEntry2."Additional-Currency Base" := VATBaseAddCurr;
        VATEntry2.SetUnrealAmountsToZero;
        VATEntry2."User ID" := USERID;
        VATEntry2."Source Code" := GenJnlLine."Source Code";
        VATEntry2."Reason Code" := GenJnlLine."Reason Code";
        VATEntry2."Closed by Entry No." := 0;
        VATEntry2.Closed := FALSE;
        VATEntry2."Transaction No." := NextTransactionNo;
        VATEntry2."Sales Tax Connection No." := NextConnectionNo;
        VATEntry2."Unrealized VAT Entry No." := VATEntry2."Entry No.";
        VATEntry2."Base Before Pmt. Disc." := VATEntry.Base;

        VATEntry.INSERT(TRUE);
        GLEntryVATEntryLink.InsertLink(GLEntryNo + 1, NextVATEntryNo);
        NextVATEntryNo := NextVATEntryNo + 1;

        VATEntry2."Remaining Unrealized Amount" :=
          VATEntry2."Remaining Unrealized Amount" - VATEntry.Amount;
        VATEntry2."Remaining Unrealized Base" :=
          VATEntry2."Remaining Unrealized Base" - VATEntry.Base;
        VATEntry2."Add.-Curr. Rem. Unreal. Amount" :=
          VATEntry2."Add.-Curr. Rem. Unreal. Amount" - VATEntry."Additional-Currency Amount";
        VATEntry2."Add.-Curr. Rem. Unreal. Base" :=
          VATEntry2."Add.-Curr. Rem. Unreal. Base" - VATEntry."Additional-Currency Base";
        VATEntry2.MODIFY;

    END;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertPostUnrealVATEntry', '', true, true)]
    procedure OnBeforeInsertPostUnrealVATEntry(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        CheckUnrealizedCust: Boolean;
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";
        OriginalPostingDateForPostponedVAT: Date;


    begin

        //+BH1.02
        IF VATEntry."Unrealized Amount (retro.)" <> 0 THEN BEGIN
            IF VATEntry."VAT Calculation Type" = VATEntry."VAT Calculation Type"::"Full VAT" THEN BEGIN
                VATEntry."VAT Base (retro.)" :=
                  ROUND(VATEntry."Unrealized Base (retro.)" * VATEntry.Amount / VATEntry."Unrealized Amount (retro.)");
                VATEntry."VAT Amount (retro.)" := VATEntry.Amount;
            END;
            IF VATEntry."VAT Calculation Type" = VATEntry."VAT Calculation Type"::"Normal VAT" THEN BEGIN
                VATEntry."VAT Base (retro.)" := VATEntry."Unrealized Base (retro.)";
                VATEntry."VAT Amount (retro.)" := VATEntry."Unrealized Amount (retro.)";
            END;
            VATEntry."Unrealized Amount (retro.)" := 0;
            VATEntry."Unrealized Base (retro.)" := 0;
        END;
        //-BH1.02
        InsertDetailedVATEntry(VATEntry);


    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostUnapplyOnBeforeVATEntryInsert', '', true, true)]
    procedure OnPostUnapplyOnBeforeVATEntryInsert(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line"; OrigVATEntry: Record "VAT Entry")

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
    begin
        InsertDetailedVATEntry(VATEntry);//BH1.03

    end;


    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeVendUnrealizedVAT', '', true, true)]
    procedure OnBeforeVendUnrealizedVAT(VAR GenJnlLine: Record "Gen. Journal Line"; VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; SettledAmount: Decimal; VAR IsHandled: Boolean)

    //OnAfterPostCust(GenJnlLine,Balancing,TempGLEntryBuf,NextEntryNo,NextTransactionNo);
    var
        CheckUnrealizedCust: Boolean;
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";
        OriginalPostingDateForPostponedVAT: Date;

    begin

        //+BH1.01
        IF GenJnlLine."Postponed VAT" THEN BEGIN
            GenJnlLine.TESTFIELD("VAT Date");
            OriginalPostingDateForPostponedVAT := GenJnlLine."Posting Date";
            GenJnlLine."Posting Date" := GenJnlLine."VAT Date";

            VendorLedgerEntry."Amount (LCY)" := 0;
            VendorLedgerEntry."Original Amt. (LCY)" := 0;
            VendorLedgerEntry."Remaining Amt. (LCY)" := 0;
            SettledAmount := 0;
        END;
        //-BH1.01


    end;

    local procedure IsNotPayment(DocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund): Boolean
    begin
        EXIT(DocumentType IN [DocumentType::Invoice,
                              DocumentType::"Credit Memo",
                              DocumentType::"Finance Charge Memo",
                              DocumentType::Reminder]);
    end;


    [EventSubscriber(ObjectType::Codeunit, 57, 'OnAfterSalesDeltaUpdateTotals', '', true, true)]

    local procedure OnAfterSalesDeltaUpdateTotals(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var TotalSalesLine: Record "Sales Line"; var VATAmount: Decimal; var InvoiceDiscountAmount: Decimal; var InvoiceDiscountPct: Decimal)

    var
    begin

        TotalSalesLine."VAT Difference CNG" := round(VATAmount, 0.01) - (round(TotalSalesLine."Amount Including VAT", 0.01) - round(TotalSalesLine.Amount, 0.01));
        VATAmount := VATAmount - TotalSalesLine."VAT Difference CNG";
        SalesLine."VAT Difference CNG" := TotalSalesLine."VAT Difference CNG";

    end;



    [EventSubscriber(ObjectType::Codeunit, 57, 'OnAfterCalculateSalesSubPageTotals', '', false, false)]
    local procedure OnAfterCalculateSalesSubPageTotals(var TotalSalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var VATAmount: Decimal; var InvoiceDiscountAmount: Decimal; var InvoiceDiscountPct: Decimal; var TotalSalesLine2: Record "Sales Line")
    begin
        TotalSalesLine2."VAT Difference CNG" := round(VATAmount, 0.01) - (round(TotalSalesLine2."Amount Including VAT", 0.01) - round(TotalSalesLine2.Amount, 0.01));
        VATAmount := VATAmount - TotalSalesLine2."VAT Difference CNG";

    end;


    //
    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforePostItemJournalLine', '', true, true)]

    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line")
    var
        TransferHeader: Record "Transfer Header";
    begin
        TransferHeader.Get(TransferLine."Document No.");
        ItemJournalLine."Gen. Bus. Posting Group" := TransferHeader."Gen. Bus. Posting Group";
        ItemJournalLine."Gen Bus Posting" := TransferHeader."Gen. Bus. Posting Group";
        ItemJournalLine."Sales Header No." := TransferHeader."Sales Header No.";
        ItemJournalLine."Sales Line No." := TransferHeader."Sales Line No.";
        ItemJournalLine."Sales Header No." := TransferHeader."Sales Header No.";
        ItemJournalLine."Employee No." := TransferHeader."Employee No.";
        ItemJournalLine."Employee Name" := TransferHeader."Employee Name";
        ItemJournalLine."Department Code" := TransferHeader."Department Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5708, 'OnBeforeReleaseTransferDoc', '', true, true)] //ED
    local procedure OnBeforeReleaseTransferDoc(var TransferHeader: Record "Transfer Header")
    var
        LocationTable: Record Location;
        Txt001: Label 'You must enter the name of the responsible person.';
    begin
        LocationTable.Reset();
        LocationTable.SetFilter(code, '%1', TransferHeader."Transfer-to Code");
        if LocationTable.FindFirst() then begin
            if LocationTable."Use As In-Revers" then
                if TransferHeader."Employee No." = '' then begin

                    Error(Txt001);
                end;
        end;

        LocationTable.Reset();
        LocationTable.SetFilter(code, '%1', TransferHeader."Transfer-to Code");
        if LocationTable.FindFirst() then begin
            if LocationTable."Use As In-Revers" then
                if TransferHeader."Employee No." = '' then
                    Error(Txt001);
        end;

    end;




    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptLineInsert', '', true, true)] //ED
    local procedure OnBeforeSalesShptLineInsert(SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer)
    var
        WhseShptLine: Record "Warehouse Shipment Line";
        WhseShptHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        CU: Codeunit "Sales-Post";
        TempGLE: Record TempGLE;
        SH: Record "Service Header";

    begin

        SalesShptLine."Fiscal No." := SalesLine."Fiscal No.";
        SalesShptLine."Fiscal DateTime" := SalesLine."Fiscal DateTime";
        SalesShptLine."Fiscal printed" := SalesLine."Fiscal printed";
        SalesShptLine."Fiscal User" := SalesLine."Fiscal User";
        SalesShptLine."Payment Method Code" := SalesLine."Payment Method Code";
        SH.Reset();
        SH.SetFilter("No.", '%1', SalesLine."Document No.");
        if sh.FindFirst() then
            SalesShptLine."Bill Type" := sh."Bill type";
        WarehouseShipmentLine.Reset();
        WarehouseShipmentLine.SetFilter("Source No.", '%1', SalesHeader."No.");
        WarehouseShipmentLine.SetFilter("Line No.", '%1', SalesShptLine."Line No.");
        if WarehouseShipmentLine.FindFirst() then
            WhseShptHeader.Get(WarehouseShipmentLine."No.");
        //PROVJERITI DA LI MOGU DOBITI       WhseShptHeader.Get(TempWhseShptHeader."No.");
        if (SalesLine.Type = SalesLine.Type::"Fixed Asset") and (SalesLine."Qty. to Ship" <> 0) then begin
            /*  if WhseShip then
                  if WhseShptLine.GetWhseShptLine(
                       WhseShptHeader."No.", DATABASE::"Sales Line", SalesLine."Document Type".AsInteger(), SalesLine."Document No.", SalesLine."Line No.")
                  then
                      PostWhseShptLines(WhseShptLine, SalesShptLine, SalesLine);}*/

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
                TempGLE."Document No." := WarehouseShipmentLine."No.";
                TempGLE."User ID" := UserId;
                TempGLE.Insert();
            end;


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnBeforeDeleteUpdateWhseShptLine', '', true, true)] //ED
    local procedure OnBeforeDeleteUpdateWhseShptLine(WhseShptLine: Record "Warehouse Shipment Line"; var DeleteWhseShptLine: Boolean; var WhseShptLineBuf: Record "Warehouse Shipment Line")
    var
        WhseShptLine2: Record "Warehouse Shipment Line";
    //da provjerim ovdje da li ima neko osnovno sredstvo na linijama



    begin

    end;

    //OnBeforeDeleteUpdateWhseShptLine
    local procedure PostWhseShptLines(var WhseShptLine2: Record "Warehouse Shipment Line"; SalesShptLine2: Record "Sales Shipment Line"; var SalesLine2: Record "Sales Line")
    var
        ATOWhseShptLine: Record "Warehouse Shipment Line";
        NonATOWhseShptLine: Record "Warehouse Shipment Line";
        ATOLineFound: Boolean;
        PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
        NonATOLineFound: Boolean;
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        TotalSalesShptLineQty: Decimal;
        WhsePostShpt: Codeunit "Whse.-Post Shipment";
        IsHandled: Boolean;
        TempATOTrackingSpecification: Record "Tracking Specification" temporary;
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        TempWhseSplitSpecification: Record "Tracking Specification" temporary;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        WhseShptLine2.GetATOAndNonATOLines(ATOWhseShptLine, NonATOWhseShptLine, ATOLineFound, NonATOLineFound);
        if ATOLineFound then
            TotalSalesShptLineQty += ATOWhseShptLine."Qty. to Ship";
        if NonATOLineFound then
            TotalSalesShptLineQty += NonATOWhseShptLine."Qty. to Ship";
        SalesShptLine2.TestField(Quantity, TotalSalesShptLineQty);

        SaveTempWhseSplitSpec(SalesLine2, TempATOTrackingSpecification);
        WhsePostShpt.SetWhseJnlRegisterCU(WhseJnlPostLine);
        if ATOLineFound and (ATOWhseShptLine."Qty. to Ship (Base)" > 0) then
            WhsePostShpt.CreatePostedShptLine(
              ATOWhseShptLine, PostedWhseShptHeader, PostedWhseShptLine, TempWhseSplitSpecification);

        SaveTempWhseSplitSpec(SalesLine2, TempHandlingSpecification);
        if NonATOLineFound and (NonATOWhseShptLine."Qty. to Ship (Base)" > 0) then
            WhsePostShpt.CreatePostedShptLine(
              NonATOWhseShptLine, PostedWhseShptHeader, PostedWhseShptLine, TempWhseSplitSpecification);
    end;

    procedure NumberToWords(Number: Decimal; InitialCall: Boolean): Text
    var
        Units: array[9] of Text[20];
        Teens: array[9] of Text[20];
        Tens: array[9] of Text[20];
        Hundreds: array[9] of Text[20];
        Thousands: array[9] of Text[30];
        Millions: array[9] of Text[30];
        ResultText: Text[1024];
        UnitPart: Integer;
        TenPart: Integer;
        HundredPart: Integer;
        ThousandPart: Integer;
        MillionPart: Integer;
        WholeNumber: Integer;
        DecimalPart: Decimal;
        TempResult: Text[1024];
    begin
        // Initialize arrays:
        Units[1] := 'jedan';
        Units[2] := 'dva';
        Units[3] := 'tri';
        Units[4] := 'četiri';
        Units[5] := 'pet';
        Units[6] := 'šest';
        Units[7] := 'sedam';
        Units[8] := 'osam';
        Units[9] := 'devet';

        Teens[1] := 'jedanaest';
        Teens[2] := 'dvanaest';
        Teens[3] := 'trinaest';
        Teens[4] := 'četrnaest';
        Teens[5] := 'petnaest';
        Teens[6] := 'šesnaest';
        Teens[7] := 'sedamnaest';
        Teens[8] := 'osamnaest';
        Teens[9] := 'devetnaest';

        Tens[1] := 'deset';
        Tens[2] := 'dvadeset';
        Tens[3] := 'trideset';
        Tens[4] := 'četrdeset';
        Tens[5] := 'pedeset';
        Tens[6] := 'šezdeset';
        Tens[7] := 'sedamdeset';
        Tens[8] := 'osamdeset';
        Tens[9] := 'devedeset';

        Hundreds[1] := 'sto';
        Hundreds[2] := 'dvije stotine';
        Hundreds[3] := 'tri stotine';
        Hundreds[4] := 'četiri stotine';
        Hundreds[5] := 'pet stotina';
        Hundreds[6] := 'šest stotina';
        Hundreds[7] := 'sedam stotina';
        Hundreds[8] := 'osam stotina';
        Hundreds[9] := 'devet stotina';

        Thousands[1] := 'jedna hiljada';
        Thousands[2] := 'dvije hiljade';
        Thousands[3] := 'tri hiljade';
        Thousands[4] := 'četiri hiljade';
        Thousands[5] := 'pet hiljada';
        Thousands[6] := 'šest hiljada';
        Thousands[7] := 'sedam hiljada';
        Thousands[8] := 'osam hiljada';
        Thousands[9] := 'devet hiljada';

        Millions[1] := 'jedan milion';
        Millions[2] := 'dva miliona';
        Millions[3] := 'tri miliona';
        Millions[4] := 'četiri miliona';
        Millions[5] := 'pet miliona';
        Millions[6] := 'šest miliona';
        Millions[7] := 'sedam miliona';
        Millions[8] := 'osam miliona';
        Millions[9] := 'devet miliona';

        // Check for 0
        if Number = 0 then
            exit('Nula');

        // Separate whole number and decimal parts
        WholeNumber := ROUND(Number, 1, '<');
        DecimalPart := Number - WholeNumber;

        // Process millions
        MillionPart := WholeNumber DIV 1000000;
        if MillionPart > 0 then begin
            ResultText := Millions[MillionPart] + ' ';
            WholeNumber := WholeNumber MOD 1000000;
        end;

        // Process thousands
        ThousandPart := WholeNumber DIV 1000;
        if ThousandPart > 0 then begin
            if ThousandPart <= 9 then
                ResultText := ResultText + Thousands[ThousandPart] + ' '
            else
                ResultText := ResultText + NumberToWords(ThousandPart, FALSE) + ' hiljada ';
            WholeNumber := WholeNumber MOD 1000;
        end;

        // Process hundreds
        HundredPart := WholeNumber DIV 100;
        if HundredPart > 0 then begin
            ResultText := ResultText + Hundreds[HundredPart] + ' ';
            WholeNumber := WholeNumber MOD 100;
        end;

        // Process tens and units
        TenPart := WholeNumber DIV 10;
        UnitPart := WholeNumber MOD 10;

        // Special case for 11-19
        if (TenPart = 1) and (UnitPart > 0) then begin
            ResultText := ResultText + Teens[UnitPart];
            if InitialCall then
                exit(ResultText + ' i ' + FORMAT(DecimalPart * 100, 0) + '/100')
            else
                exit(ResultText);
        end;

        if TenPart = 1 then begin
            ResultText := ResultText + Tens[TenPart];
            if InitialCall then
                exit(ResultText + ' i ' + FORMAT(DecimalPart * 100, 0) + '/100')
            else
                exit(ResultText);
        end;

        if TenPart > 0 then
            ResultText := ResultText + Tens[TenPart];

        if (TenPart > 0) and (UnitPart > 0) then
            ResultText := ResultText + ' i ';

        if UnitPart > 0 then
            ResultText := ResultText + Units[UnitPart];

        // Add the decimal part only once
        if InitialCall then
            exit(ResultText + ' i ' + FORMAT(DecimalPart * 100, 0) + '/100')
        else
            exit(ResultText);
    end;



    procedure NumberToWordsBilling(Number: Decimal; InitialCall: Boolean): Text
    var
        Units: array[9] of Text[20];
        Teens: array[9] of Text[20];
        Tens: array[9] of Text[20];
        Hundreds: array[9] of Text[20];
        Thousands: array[9] of Text[30];
        Millions: array[9] of Text[30];
        ResultText: Text[1024];
        UnitPart: Integer;
        TenPart: Integer;
        HundredPart: Integer;
        ThousandPart: Integer;
        MillionPart: Integer;
        WholeNumber: Integer;
        DecimalPart: Decimal;
        TempResult: Text[1024];

    begin
        // Initialize arrays:
        Units[1] := 'jedan';
        Units[2] := 'dva';
        Units[3] := 'tri';
        Units[4] := 'četiri';
        Units[5] := 'pet';
        Units[6] := 'šest';
        Units[7] := 'sedam';
        Units[8] := 'osam';
        Units[9] := 'devet';

        Teens[1] := 'jedanaest';
        Teens[2] := 'dvanaest';
        Teens[3] := 'trinaest';
        Teens[4] := 'četrnaest';
        Teens[5] := 'petnaest';
        Teens[6] := 'šesnaest';
        Teens[7] := 'sedamnaest';
        Teens[8] := 'osamnaest';
        Teens[9] := 'devetnaest';

        Tens[1] := 'deset';
        Tens[2] := 'dvadeset';
        Tens[3] := 'trideset';
        Tens[4] := 'četrdeset';
        Tens[5] := 'pedeset';
        Tens[6] := 'šezdeset';
        Tens[7] := 'sedamdeset';
        Tens[8] := 'osamdeset';
        Tens[9] := 'devedeset';

        Hundreds[1] := 'stotinu';
        Hundreds[2] := 'dvijestotine';
        Hundreds[3] := 'tristotine';
        Hundreds[4] := 'četiristotine';
        Hundreds[5] := 'petstotina';
        Hundreds[6] := 'šeststotina';
        Hundreds[7] := 'sedamstotina';
        Hundreds[8] := 'osamstotina';
        Hundreds[9] := 'devetstotina';

        Thousands[1] := 'jednahiljada';
        Thousands[2] := 'dvijehiljade';
        Thousands[3] := 'trihiljade';
        Thousands[4] := 'četirihiljade';
        Thousands[5] := 'pethiljada';
        Thousands[6] := 'šesthiljada';
        Thousands[7] := 'sedamhiljada';
        Thousands[8] := 'osamhiljada';
        Thousands[9] := 'devethiljada';

        Millions[1] := 'jedanmilion';
        Millions[2] := 'dvamiliona';
        Millions[3] := 'trimiliona';
        Millions[4] := 'četirimiliona';
        Millions[5] := 'petmiliona';
        Millions[6] := 'šestmiliona';
        Millions[7] := 'sedammiliona';
        Millions[8] := 'osammiliona';
        Millions[9] := 'devetmiliona';

        // Check for 0
        if Number = 0 then
            exit('Nula');

        // Separate whole number and decimal parts
        WholeNumber := ROUND(Number, 1, '<');
        DecimalPart := round(Number - WholeNumber, 0.01, '=');

        // Process millions
        MillionPart := WholeNumber DIV 1000000;
        if MillionPart > 0 then begin
            ResultText := Millions[MillionPart] + '';
            WholeNumber := WholeNumber MOD 1000000;
        end;

        // Process thousands
        ThousandPart := WholeNumber DIV 1000;
        if ThousandPart > 0 then begin
            if ThousandPart <= 9 then
                ResultText := ResultText + Thousands[ThousandPart] + ''
            else
                ResultText := ResultText + NumberToWordsBilling(ThousandPart, FALSE) + 'hiljada';
            WholeNumber := WholeNumber MOD 1000;
        end;

        // Process hundreds
        HundredPart := WholeNumber DIV 100;
        if HundredPart > 0 then begin
            ResultText := ResultText + Hundreds[HundredPart] + '';
            WholeNumber := WholeNumber MOD 100;
        end;

        // Process tens and units
        TenPart := WholeNumber DIV 10;
        UnitPart := WholeNumber MOD 10;

        // Special case for 11-19
        if (TenPart = 1) and (UnitPart > 0) then begin
            ResultText := ResultText + Teens[UnitPart];


            if InitialCall then begin
                if 2 - strlen(format(DecimalPart * 100)) <= 0 then
                    exit(ResultText + ' i ' + format(DecimalPart * 100) + '/100')
                else
                    exit(ResultText + ' i ' + FORMAT(PADSTR('', 2 - strlen(format(DecimalPart * 100)), '0')) + format(DecimalPart * 100) + '/100')
            end else begin
                exit(ResultText);
            end;
        end;

        if TenPart = 1 then begin
            ResultText := ResultText + Tens[TenPart];
            if InitialCall then begin
                if 2 - strlen(format(DecimalPart * 100)) <= 0 then
                    exit(ResultText + ' i ' + format(DecimalPart * 100) + '/100')
                else
                    exit(ResultText + ' i ' + FORMAT(PADSTR('', 2 - strlen(format(DecimalPart * 100)), '0')) + format(DecimalPart * 100) + '/100')
            end else begin
                exit(ResultText);
            end;
        end;

        if TenPart > 0 then
            ResultText := ResultText + Tens[TenPart];

        if (TenPart > 0) and (UnitPart > 0) then
            ResultText := ResultText + '';

        if UnitPart > 0 then
            ResultText := ResultText + Units[UnitPart];

        // Add the decimal part only once
        if InitialCall then begin
            if 2 - strlen(format(DecimalPart * 100)) <= 0 then
                exit(ResultText + ' i ' + format(DecimalPart * 100) + '/100')
            else
                exit(ResultText + ' i ' + FORMAT(PADSTR('', 2 - strlen(format(DecimalPart * 100)), '0')) + format(DecimalPart * 100) + '/100')
        end else begin
            exit(ResultText);
        end;
    end;


    procedure NumberToWordsBillingCNG(Number: Decimal; InitialCall: Boolean): Text
    var
        Units: array[9] of Text[20];
        Teens: array[9] of Text[20];
        Tens: array[9] of Text[20];
        Hundreds: array[9] of Text[20];
        Thousands: array[9] of Text[30];
        Millions: array[9] of Text[30];
        ResultText: Text[1024];
        UnitPart: Integer;
        TenPart: Integer;
        HundredPart: Integer;
        ThousandPart: Integer;
        MillionPart: Integer;
        WholeNumber: Integer;
        DecimalPart: Decimal;
        TempResult: Text[1024];

    begin
        // Initialize arrays:
        Units[1] := 'jedan';
        Units[2] := 'dva';
        Units[3] := 'tri';
        Units[4] := 'četiri';
        Units[5] := 'pet';
        Units[6] := 'šest';
        Units[7] := 'sedam';
        Units[8] := 'osam';
        Units[9] := 'devet';

        Teens[1] := 'jedanaest';
        Teens[2] := 'dvanaest';
        Teens[3] := 'trinaest';
        Teens[4] := 'četrnaest';
        Teens[5] := 'petnaest';
        Teens[6] := 'šesnaest';
        Teens[7] := 'sedamnaest';
        Teens[8] := 'osamnaest';
        Teens[9] := 'devetnaest';

        Tens[1] := 'deset';
        Tens[2] := 'dvadeset';
        Tens[3] := 'trideset';
        Tens[4] := 'četrdeset';
        Tens[5] := 'pedeset';
        Tens[6] := 'šezdeset';
        Tens[7] := 'sedamdeset';
        Tens[8] := 'osamdeset';
        Tens[9] := 'devedeset';

        Hundreds[1] := 'stotinu';
        Hundreds[2] := 'dvijestotine';
        Hundreds[3] := 'tristotine';
        Hundreds[4] := 'četiristotine';
        Hundreds[5] := 'petstotina';
        Hundreds[6] := 'šeststotina';
        Hundreds[7] := 'sedamstotina';
        Hundreds[8] := 'osamstotina';
        Hundreds[9] := 'devetstotina';

        Thousands[1] := 'jednahiljada';
        Thousands[2] := 'dvijehiljade';
        Thousands[3] := 'trihiljade';
        Thousands[4] := 'četirihiljade';
        Thousands[5] := 'pethiljada';
        Thousands[6] := 'šesthiljada';
        Thousands[7] := 'sedamhiljada';
        Thousands[8] := 'osamhiljada';
        Thousands[9] := 'devethiljada';

        Millions[1] := 'jedanmilion';
        Millions[2] := 'dvamiliona';
        Millions[3] := 'trimiliona';
        Millions[4] := 'četirimiliona';
        Millions[5] := 'petmiliona';
        Millions[6] := 'šestmiliona';
        Millions[7] := 'sedammiliona';
        Millions[8] := 'osammiliona';
        Millions[9] := 'devetmiliona';

        // Check for 0
        if Number = 0 then
            exit('Nula');

        // Separate whole number and decimal parts
        WholeNumber := ROUND(Number, 1, '<');
        DecimalPart := round(Number - WholeNumber, 0.01, '=');

        // Process millions
        MillionPart := WholeNumber DIV 1000000;
        if MillionPart > 0 then begin
            ResultText := Millions[MillionPart] + '';
            WholeNumber := WholeNumber MOD 1000000;
        end;

        // Process thousands
        ThousandPart := WholeNumber DIV 1000;
        if ThousandPart > 0 then begin
            if ThousandPart <= 9 then
                ResultText := ResultText + Thousands[ThousandPart] + ''
            else
                ResultText := ResultText + NumberToWordsBilling(ThousandPart, FALSE) + 'hiljada';
            WholeNumber := WholeNumber MOD 1000;
        end;

        // Process hundreds
        HundredPart := WholeNumber DIV 100;
        if HundredPart > 0 then begin
            ResultText := ResultText + Hundreds[HundredPart] + '';
            WholeNumber := WholeNumber MOD 100;
        end;

        // Process tens and units
        TenPart := WholeNumber DIV 10;
        UnitPart := WholeNumber MOD 10;

        // Special case for 11-19
        if (TenPart = 1) and (UnitPart > 0) then begin
            ResultText := ResultText + Teens[UnitPart];


            if InitialCall then begin
                if 2 - strlen(format(DecimalPart * 100)) <= 0 then
                    exit(ResultText + ' i ' + format(DecimalPart * 100) + '/100')
                else
                    exit(ResultText + ' i ' + FORMAT(PADSTR('', 2 - strlen(format(DecimalPart * 100)), '0')) + format(DecimalPart * 100) + '/100')
            end else begin
                exit(ResultText);
            end;
        end;

        if TenPart = 1 then begin
            ResultText := ResultText + Tens[TenPart];
            if InitialCall then begin
                if 2 - strlen(format(DecimalPart * 100)) <= 0 then
                    exit(ResultText + ' i ' + format(DecimalPart * 100) + '/100')
                else
                    exit(ResultText + ' i ' + FORMAT(PADSTR('', 2 - strlen(format(DecimalPart * 100)), '0')) + format(DecimalPart * 100) + '/100')
            end else begin
                exit(ResultText);
            end;
        end;

        if TenPart > 0 then
            ResultText := ResultText + Tens[TenPart];

        if (TenPart > 0) and (UnitPart > 0) then
            ResultText := ResultText + '';

        if UnitPart > 0 then
            ResultText := ResultText + Units[UnitPart];

        // Add the decimal part only once
        if InitialCall then begin
            if 2 - strlen(format(DecimalPart * 100)) <= 0 then
                exit(ResultText + ' i ' + format(DecimalPart * 100) + '/100')
            else
                exit(ResultText + ' i ' + FORMAT(PADSTR('', 2 - strlen(format(DecimalPart * 100)), '0')) + format(DecimalPart * 100) + '/100')
        end else begin
            exit(ResultText);
        end;
    end;



    local procedure SaveTempWhseSplitSpec(var SalesLine3: Record "Sales Line"; var TempSrcTrackingSpec: Record "Tracking Specification" temporary)
    var
        TempWhseSplitSpecification: Record "Tracking Specification" temporary;
    begin
        TempWhseSplitSpecification.Reset();
        TempWhseSplitSpecification.DeleteAll();
        if TempSrcTrackingSpec.FindSet() then
            repeat
                TempWhseSplitSpecification := TempSrcTrackingSpec;
                TempWhseSplitSpecification.SetSource(
                  DATABASE::"Sales Line", SalesLine3."Document Type".AsInteger(), SalesLine3."Document No.", SalesLine3."Line No.", '', 0);
                TempWhseSplitSpecification.Insert();
            until TempSrcTrackingSpec.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5764, 'OnBeforeConfirmWhseShipmentPost', '', true, true)] //ED

    local procedure OnBeforeConfirmWhseShipmentPost(var WhseShptLine: Record "Warehouse Shipment Line"; var HideDialog: Boolean; var Invoice: Boolean; var IsPosted: Boolean)
    var
        TransferHeader: Record "Transfer Header";
        Location: Record Location;
    begin
        TransferHeader.Reset();
        TransferHeader.SetFilter("No.", '%1', WhseShptLine."Source No.");
        if TransferHeader.FindFirst() then begin
            Location.Reset();
            Location.SetFilter(Code, '%1', TransferHeader."Transfer-to Code");
            if Location.FindFirst() then begin
                if (Location."CNG MP" = true) or (Location."CNG VP" = true) then
                    HideDialog := false;
            end


        end;

    end;

    //OnBeforeConfirmSalesPost

    //

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo', '', true, true)]
    local procedure OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        GenJournalLine."Account No. Change" := GenJournalLine."Account No.";
        if StrLen(CustLedgerEntry."Document No.") >= 3 then begin
            GenJournalLine."Payment Type" := CopyStr(CustLedgerEntry."Document No.", 1, 2);
            //   if GenJournalLine."Payment Type" = 'CZ' then
            GenJournalLine."Bill type" := CustLedgerEntry."Bill type";
            GenJournalLine."Payment Type" := GenJournalLine."Bill type";
            CustLedgerEntry.CalcFields("Remaining Amount");
            GenJournalLine.Validate(Amount, CustLedgerEntry."Remaining Amount");
        end
    end;







    [EventSubscriber(ObjectType::Codeunit, 81, 'OnBeforeConfirmSalesPost', '', true, true)] //ED
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    var
        SalesLine: Record "Sales Line";
        Location: Record Location;
    begin

        //  DefaultOption := 3;
        //HideDialog := false;
        Location.Reset();
        Location.SetFilter("CNG MP", '%1', true);
        if Location.FindFirst() then begin
            SalesLine.Reset();
            SalesLine.SetFilter("Document No.", '%1', SalesHeader."No.");
            SalesLine.SetFilter("Document Type", '%1', SalesHeader."Document Type");
            SalesLine.SetFilter("Location Code", '%1', Location.Code);
            SalesLine.SetFilter("Fiscal printed", '%1', false);
            if SalesLine.FindFirst() then begin

                //     DefaultOption := 1;
                //   HideDialog := true;

            end;

            Location.Reset();
            Location.SetFilter("CNG VP", '%1', true);
            if Location.FindFirst() then begin
                SalesLine.Reset();
                SalesLine.SetFilter("Document No.", '%1', SalesHeader."No.");
                SalesLine.SetFilter("Document Type", '%1', SalesHeader."Document Type");
                SalesLine.SetFilter("Location Code", '%1', Location.Code);
                if SalesLine.FindFirst() then begin

                    //   DefaultOption := 1;
                    //     HideDialog := true;
                end

            end;

        end;


    end;



    [EventSubscriber(ObjectType::Codeunit, 5752, 'OnBeforeShowResult', '', true, true)] //ED
    local procedure OnBeforeShowResult(WhseShipmentCreated: Boolean; var IsHandled: Boolean);
    var

    begin
        IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Codeunit, 5752, 'OnBeforeCreateWhseShipmentHeaderFromWhseRequest', '', true, true)] //ED

    local procedure OnBeforeCreateWhseShipmentHeaderFromWhseRequest(var WarehouseRequest: Record "Warehouse Request"; var Rusult: Boolean; var IsHandled: Boolean)
    begin
    end;



    [EventSubscriber(ObjectType::Codeunit, 5752, 'OnBeforeCreateFromOutbndTransferOrder', '', true, true)] //ED
    local procedure OnBeforeCreateFromOutbndTransferOrder(var TransferHeader: Record "Transfer Header")
    var
        TL: Record "Transfer Line";
        ILEntry: Record "Item Ledger Entry";

    begin
        IF TransferHeader."Gen. Bus. Posting Group" = 'HTZ' then begin
            TL.reset;
            tl.SetFilter("Document No.", '%1', TransferHeader."No.");
            tl.SetFilter("Gen. Prod. Posting Group", '<>%1', 'HTZ');
            if tl.FindFirst() then begin
                Error('Ne možete na jednom nalogu za prenos uzeti HTZ opremu i ostali materijal. Molimo Vas za za ovaj slučaj razdvojite posebne naloge!');

            end;
        end;

        IF TransferHeader."Gen. Bus. Posting Group" <> 'HTZ' then begin
            TL.reset;
            tl.SetFilter("Document No.", '%1', TransferHeader."No.");
            tl.SetFilter("Gen. Prod. Posting Group", '%1', 'HTZ');
            if tl.FindFirst() then begin
                Error('Ne možete na jednom nalogu za prenos uzeti HTZ opremu i ostali materijal. Molimo Vas za za ovaj slučaj razdvojite posebne naloge!');

            end;
        end;


        TL.reset;
        tl.SetFilter("Document No.", '%1', TransferHeader."No.");
        if tl.FindSet() then
            repeat

                ILEntry.reset;
                ILEntry.setfilter("Item No.", '%1', tl."Item No.");
                ILEntry.SetFilter("Location Code", '%1', tl."Transfer-from Code");
                if ILEntry.findfirst then begin
                    ILEntry.calcsums("Quantity");
                    if tl."Quantity" > ILEntry.Quantity then
                        error('Artikla ' + tl."Item No." + ' nema dovoljno na stanju, pa ne možete kreirati radne naloge!')
                end
                else begin
                    error('Artikla ' + tl."Item No." + ' nema na stanju, pa ne možete kreirati radne naloge!')
                end;

            until tl.Next() = 0;


    end;


    [EventSubscriber(ObjectType::Codeunit, 5752, 'OnAfterCreateWhseShipmentHeaderFromWhseRequest', '', true, true)] //ED
    local procedure OnAfterCreateWhseShipmentHeaderFromWhseRequest(var WarehouseRequest: Record "Warehouse Request")
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        TransferHeader: Record "Transfer Header";
        SalesHeader: Record "Sales Header";

    begin
        WarehouseShipmentHeader.Reset();
        if WarehouseShipmentHeader.FindLast() then begin //nasla sam posljednju kreiranu otpremnicu, to je upravo ova
            TransferHeader.Reset();
            TransferHeader.SetFilter("No.", '%1', WarehouseRequest."Source No.");
            if TransferHeader.FindFirst() then begin
                WarehouseShipmentHeader."Employee No." := TransferHeader."Employee No."; //upisujem broj i ime zaduzene osobe
                WarehouseShipmentHeader."Employee Name" := TransferHeader."Employee Name";
                WarehouseShipmentHeader."Transfer Header No." := TransferHeader."No.";
                WarehouseShipmentHeader."Assigned User ID" := TransferHeader."Assigned User ID";
                WarehouseShipmentHeader."Sales Header No." := TransferHeader."Sales Header No.";
                WarehouseShipmentHeader."RN Source" := TransferHeader."RN Source";
                WarehouseShipmentHeader.Address := TransferHeader.Address;
                WarehouseShipmentHeader."G/L Account No." := TransferHeader."G/L Account No.";
                WarehouseShipmentHeader."Department Code" := TransferHeader."Department Code";

                /*  SalesHeader.Reset();
                  SalesHeader.SetFilter("No.",'%1',WarehouseShipmentHeader."Transfer Header No.");
                  if SalesHeader.FindFirst() then 
                  WarehouseShipmentHeader."Document No.":=SalesHeader.*/
                //upisujem broj naloga prenosa 
                //poslije knjiženja otpremnice se automatski treba proknjiziti i nalog prenosa iz koje je ona kreirana
                WarehouseShipmentHeader.Modify();
            end;
            if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order" then begin
                SalesHeader.reset;
                SalesHeader.setfilter("No.", '%1', WarehouseRequest."Source No.");
                if SalesHeader.FindFirst() then begin
                    WarehouseShipmentHeader."RN Source" := SalesHeader."RN Source";
                end;

            end;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, 5601, 'OnGetBalAccAfterRestoreGenJnlLineFields', '', true, true)]
    local procedure OnGetBalAccAfterRestoreGenJnlLineFieldsOnGetBalAccAfterRestoreGenJnlLineFields(var ToGenJnlLine: Record "Gen. Journal Line"; FromGenJnlLine: Record "Gen. Journal Line")
    var
        GJ: Record "Gen. Journal Line";
        GJ2: Record "Gen. Journal Line";
        GJ3: Record "Gen. Journal Line";
        GJ4: Record "Gen. Journal Line";
        Procenat: Decimal;
        Fixed: Record "Fixed Asset";
        FADeprBook: Record "FA Depreciation Book";
        FaPosting: Record "FA Posting Group";
        CU: Codeunit "FA Insert G/L Account";
        Brojac: Integer;
        User: Record "User Setup";
        pageF: page "Fixed Asset G/L Journal";
        F: Record "FA Ledger Entry";

    begin


        /*    if ToGenJnlLine."Account Type" = ToGenJnlLine."Account Type"::"Fixed Asset" then begin
                User.Reset();
                User.SetFilter("user id", '%1', UserId);
                if User.FindFirst() then begin
                    User.Counter += 2000;
                    User.Modify();
                end;

                Fixed.Reset();
                Fixed.SetFilter("No.", '%1', ToGenJnlLine."Account No.");
                if Fixed.FindFirst() then begin
                    FADeprBook.Reset();
                    FADeprBook.SetFilter("Depreciation Book Code", '%1', GJ."Depreciation Book Code");
                    FADeprBook.SetFilter("FA No.", '%1', GJ."Account No.");
                    if FADeprBook.FindFirst() then begin
                        FaPosting.Get(FADeprBook."FA Posting Group");
                        if Fixed."Donation Percentage" <> 0 then
                            Procenat := Fixed."Donation Percentage" / 100;
                    end;

                end;
            end;

            if ToGenJnlLine.Donation <> '' then begin
                ToGenJnlLine.Validate(Amount, ToGenJnlLine.Amount * ToGenJnlLine."Donation Percentage" / 100);
                GJ3.Init();
                GJ3.TransferFields(ToGenJnlLine);
                GJ3.Donation := '';
                GJ3."Account No." := ToGenJnlLine.Donation;
                User.Reset();
                User.SetFilter("user id", '%1', UserId);
                if User.FindFirst() then begin
                    User.Counter += 2001;
                    User.Modify();




                    GJ3."Line No." := User.Counter;
                end;
                GJ3.Insert();

            end;
            ToGenJnlLine.Donation := '';
            ToGenJnlLine."Donation Percentage" := 0;
        */
    end;



    [EventSubscriber(ObjectType::Report, report::"Get Source Documents", 'OnBeforeCreateShptHeader', '', true, true)]
    local procedure OnBeforeCreateShptHeader(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseRequest: Record "Warehouse Request"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)

    var
        TransferO: Record "Transfer Header";
        SalesHeader: Record "Sales Header";

    begin

        WarehouseShipmentHeader."Sales Header No." := SalesLine."Document No.";
        TransferO.reset;
        TransferO.SetFilter("No.", '%1', WarehouseRequest."Source No.");
        if TransferO.FindFirst() then begin
            WarehouseShipmentHeader."Employee No." := TransferO."Employee No."; //upisujem broj i ime zaduzene osobe
            WarehouseShipmentHeader."Employee Name" := TransferO."Employee Name";
            WarehouseShipmentHeader."Transfer Header No." := TransferO."No.";
            WarehouseShipmentHeader."Assigned User ID" := TransferO."Assigned User ID";
            WarehouseShipmentHeader."RN Source" := TransferO."RN Source";
            WarehouseShipmentHeader.Address := TransferO.Address;
            WarehouseShipmentHeader."G/L Account No." := TransferO."G/L Account No.";
            WarehouseShipmentHeader."Department Code" := TransferO."Department Code";
        end;

        if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order" then begin
            SalesHeader.reset;
            SalesHeader.setfilter("No.", '%1', WarehouseRequest."Source No.");
            if SalesHeader.FindFirst() then begin
                WarehouseShipmentHeader."RN Source" := SalesHeader."RN Source";
            end;

        end;

    end;





    [EventSubscriber(ObjectType::Report, report::"Get Source Documents", 'OnBeforeWhseShptHeaderInsert', '', true, true)]
    local procedure OnBeforeWhseShptHeaderInsert(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseRequest: Record "Warehouse Request"; SalesLine: Record "Sales Line"; TransferLine: Record "Transfer Line")

    var
        TransferO: Record "Transfer Header";
        NoSeriesPovrat: Record "No. Series";
        WhseSetup: Record "General Ledger Setup";
        US: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        SalesHeader: Record "Sales Header";
    begin

        WarehouseShipmentHeader."Sales Header No." := SalesLine."Document No.";
        TransferO.reset;
        TransferO.SetFilter("No.", '%1', WarehouseRequest."Source No.");
        if TransferO.FindFirst() then begin
            WarehouseShipmentHeader."Employee No." := TransferO."Employee No."; //upisujem broj i ime zaduzene osobe
            WarehouseShipmentHeader."Employee Name" := TransferO."Employee Name";
            WarehouseShipmentHeader."Transfer Header No." := TransferO."No.";
            WarehouseShipmentHeader."Assigned User ID" := TransferO."Assigned User ID";
            WarehouseShipmentHeader."RN Source" := TransferO."RN Source";
            WarehouseShipmentHeader.Address := TransferO.Address;
            WarehouseShipmentHeader."G/L Account No." := TransferO."G/L Account No.";
            WarehouseShipmentHeader."Department Code" := TransferO."Department Code";
        end;

        if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order" then begin
            SalesHeader.reset;
            SalesHeader.setfilter("No.", '%1', WarehouseRequest."Source No.");
            if SalesHeader.FindFirst() then begin
                WarehouseShipmentHeader."RN Source" := SalesHeader."RN Source";
            end;

        end;


    end;



    //OnAfterCalculateDepreciation

    [EventSubscriber(ObjectType::Report, report::"Calculate Depreciation", 'OnAfterCalculateDepreciation', '', true, true)]
    local procedure OnAfterCalculateDepreciation(FANo: Code[20]; var TempGenJournalLine: Record "Gen. Journal Line" temporary; var TempFAJournalLine: Record "FA Journal Line" temporary; var DeprAmount: Decimal; var NumberOfDays: Integer; DeprBookCode: Code[10]; DeprUntilDate: Date; EntryAmounts: array[4] of Decimal; DaysInPeriod: Integer)
    var

        DeprBook: Record "Depreciation Book";
        ErrorNo: Integer;
        TempGenJournalLine2: Record "Gen. Journal Line" temporary;

    begin
        DeprBook.Get(DeprBookCode);
        ErrorNo := 0;



    end;
    //OnAfterPostDataItem


    /* [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterSetAmountWithRemaining', '', true, true)]


     [IntegrationEvent(false, false)]
     local procedure OnAfterSetAmountWithRemaining(var GenJournalLine: Record "Gen. Journal Line")
     begin
         if GenJournalLine."Journal Template Name" = 'PAYMENTS' then begin

         end;
     end;
 */



    [EventSubscriber(ObjectType::Table, database::Currency, 'OnAfterInitRoundingPrecision', '', true, true)]

    local procedure OnAfterInitRoundingPrecision(var Currency: Record Currency; var xCurrency: Record Currency; var GeneralLedgerSetup: Record "General Ledger Setup")
    var
        us: Record "User Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if (us."CNG User" = true) or (us."CNG Administrator" = true) then begin
                //    Currency."Amount Rounding Precision" := Currency."Unit-Amount Rounding Precision";
                Currency."Amount Rounding Precision" := 0.00000000000000000000001;


            end;
        end;
    end;






    [EventSubscriber(ObjectType::Report, Report::"Calculate Depreciation", 'OnAfterPostDataItem', '', true, true)]
    local procedure OnAfterPostDataItem()
    var

        DeprBook: Record "Depreciation Book";
        ErrorNo: Integer;
        TempGenJournalLine2: Record "Gen. Journal Line" temporary;
        Users: Record "User Setup";

    begin
        Users.Reset();
        Users.SetFilter("user id", '%1', UserId);
        if Users.FindFirst() then begin
            Users.Counter := 0;
            Users.Modify();

        end;



    end;

    [EventSubscriber(ObjectType::Codeunit, 5750, 'OnBeforeCreateShptLineFromTransLine', '', true, true)]

    local procedure OnBeforeCreateShptLineFromTransLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header")
    begin
        WarehouseShipmentLine."Sales Header No." := TransferLine."Sales Header No.";
        WarehouseShipmentLine."G/L Account No." := TransferLine."G/L Account No.";
        WarehouseShipmentLine."Department Code" := TransferLine."Department Code";
    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforePostItemJnlLine', '', true, true)]
    local procedure OnBeforePostItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean)
    begin
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Sale then begin

        end;

    end;





    [EventSubscriber(ObjectType::Codeunit, 5802, 'OnBeforeBufferAdjmtPosting', '', true, true)]
    local procedure OnBeforeBufferAdjmtPosting(var ValueEntry: Record "Value Entry"; var GlobalInvtPostBuf: Record "Invt. Posting Buffer"; CostToPost: Decimal; CostToPostACY: Decimal; ExpCostToPost: Decimal; ExpCostToPostACY: Decimal; var IsHandled: Boolean)
    begin
        /*   if ValueEntry."Retail Unit Price" <> 0 then begin

               GlobalInvtPostBuf."Amount (ACY)" := ValueEntry."T.Retail Unit Price with VAT";*/
    end;




    //end;

    //OnBeforeBufferPosting

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesLines', '', true, true)]
    local procedure OnBeforePostSalesLines(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line" temporary; var TempVATAmountLine: Record "VAT Amount Line" temporary)
    var
    begin
        //ĐK PROBAJ TempSalesLineGlobal.SetFilter("Shipment Create", '%1', false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 5802, 'OnBeforeBufferPosting', '', true, true)]
    local procedure OnBeforeBufferPostingOnBeforeBufferPosting(var ValueEntry: Record "Value Entry"; var CostToPost: Decimal; var CostToPostACY: Decimal; var ExpCostToPost: Decimal; var ExpCostToPostACY: Decimal)
    begin
        if ValueEntry."Retail Unit Price" <> 0 then begin

            //  CostToPost := ValueEntry."T.Retail Unit Price with VAT";
        end;




    end;


    //[IntegrationEvent(false, false)]



    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertValueEntry', '', true, true)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean)


    var
        CalSetup: Record "Calculation Setup";
        Customer: Record customer;
        SalesPrice: Record "Sales Price";
        RecRef: RecordRef;
        RecordRefExample: Codeunit "Modiy Permissions";
        Item: Record item;
        VPS: Record "VAT Posting Setup";
        G: Record "General Ledger Setup";
        TH: Record "Transfer Header";
        Location: Record Location;
        SHL: Record "Sales Shipment Line";
        USset: Record "User Setup";
        THEx: Boolean;
        Job: Record "Item Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        DateN: text[250];
        SignValue: Integer;

    begin
        G.get;
        ValueEntry."VAT Difference CNG" := 0;
        THEx := false;


        ValueEntry."CNG MP" := false;
        ValueEntry."CNG VP" := false;
        ValueEntry."CNG VL" := false;



        Job.Reset();
        Job.SetFilter(Name, '%1', ValueEntry."Journal Batch Name");
        if job.FindFirst() then begin
            if job.Nivelacija = true then
                ValueEntry.Nivelacija := job.Nivelacija;
        end;

        if ValueEntry.Nivelacija = true then begin

            ValueEntry."Cost Posted to G/L" := 0;
            ValueEntry."Cost per Unit" := 0;
            ValueEntry."Wholesale Unit Price" := ItemJournalLine."Unit Price New";
            if ValueEntry."Nivelacija No." = '' then begin
                G.get;

                NoSeriesMgt.InitSeries(G."Nivelacija No. Series", '', ValueEntry."Posting Date", ValueEntry."Nivelacija No.", ValueEntry."Nivelacija No Series");
                //(SalesSetup."Order Nos.", '', cjl."Calculation Date To", SH."No.", "No. Series");
                DateN := format(ValueEntry."Posting Date", 0, '<Day,2>.<Month,2>.<Year4>');
                //22.10.2023
                ValueEntry."Nivelacija No." := ValueEntry."Nivelacija No." + '\' + CopyStr(DateN, 7, 4);
            end;

            if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                ValueEntry."Total Wholesale Amount" := Round((ValueEntry."Wholesale Unit Price" * ValueEntry."Valued Quantity") - (ItemJournalLine."Unit Price Old" * ValueEntry."Valued Quantity"), G."Amount Rounding Precision")

            else
                ValueEntry."Total Wholesale Amount" := Round((ValueEntry."Wholesale Unit Price" * ValueEntry."Item Ledger Entry Quantity") - (ItemJournalLine."Unit Price Old" * ValueEntry."Item Ledger Entry Quantity"), G."Amount Rounding Precision");


            ValueEntry."Wholesale RUC" := abs(abs(ValueEntry."Cost Amount (Actual)") - abs(ValueEntry."Total Wholesale Amount"));
            ValueEntry."Cost Amount (Actual)" := 0;


            VPS.Reset();
            VPS.SetFilter("VAT Prod. Posting Group", '%1', item."VAT Prod. Posting Group");
            if VPS.FindFirst() then begin

                ValueEntry."WholeSale Unit Price with VAT" := ROUND(ValueEntry."WholeSale Unit Price" + ValueEntry."WholeSale Unit Price" * (VPS."VAT %") / 100, G."Amount Rounding Precision");
                ValueEntry."WholeSale VAT" := VPS."VAT %";
                ValueEntry."Calculate Wholesale VAT" := Round(ValueEntry."Sales Amount (Actual)" * ValueEntry."Wholesale VAT" / 100, G."Amount Rounding Precision");
            end;

            if ValueEntry."CNG VP" = true then begin
                ValueEntry."VAT Difference CNG" := (ValueEntry."Calculate Wholesale VAT") - (((ValueEntry."WholeSale Unit Price with VAT" * abs(ValueEntry."Invoiced Quantity") - ValueEntry."Sales Amount (Actual)")));

            end;

            if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                ValueEntry."T.WholeSale Unit Price with V" := round(ValueEntry."Valued Quantity" * ValueEntry."WholeSale Unit Price with VAT", G."Amount Rounding Precision")
            else
                ValueEntry."T.WholeSale Unit Price with V" := round(ValueEntry."Item Ledger Entry Quantity" * ValueEntry."WholeSale Unit Price with VAT", G."Amount Rounding Precision");

        end;

        ValueEntry."Gen Bus Posting" := ItemJournalLine."Gen. Bus. Posting Group";
        ValueEntry."Prod Bus Posting" := ItemJournalLine."Gen. Prod. Posting Group";
        TH.Reset();
        TH.SetFilter("No.", '%1', ValueEntry."Order No.");
        if TH.FindFirst() then begin
            THEx := true;
            if TH.Correction = true then
                ValueEntry."G/L Correction" := true;
            if th."R. CNG MLP" = true then
                ValueEntry."R. CNG MP" := true

            else
                ValueEntry."R. CNG MP" := false;


            Location.Reset();
            Location.SetFilter(Code, '%1', TH."Transfer-to Code");
            Location.SetFilter("CNG MP", '%1', true);
            if Location.FindFirst() then begin
                ValueEntry."CNG MP" := true;
            end

            else begin
                Location.Reset();
                Location.SetFilter(Code, '%1', TH."Transfer-from Code");
                Location.SetFilter("CNG MP", '%1', true);
                if Location.FindFirst() then
                    ValueEntry."CNG MP" := true
                else
                    ValueEntry."CNG MP" := false;
            end;



            Location.Reset();

            Location.SetFilter(Code, '%1', TH."Transfer-to Code");
            Location.SetFilter("CNG VP", '%1', true);
            if Location.FindFirst() then begin
                if ValueEntry."CNG MP" = false then
                    ValueEntry."CNG VP" := true
                    ;
            end
            else begin
                Location.Reset();

                Location.SetFilter(Code, '%1', TH."Transfer-from Code");
                Location.SetFilter("CNG VP", '%1', true);
                if Location.FindFirst() then begin
                    if ValueEntry."CNG MP" = false then
                        ValueEntry."CNG VP" := true;

                end

                else begin
                    ValueEntry."CNG VP" := false;
                end;
            end;
            ;


            //đk ovde
            if (TH."Hide CNG MP" = true) and (ValueEntry."CNG VP" = true)

then begin
                ValueEntry."CNG VP" := false;
                ValueEntry."CNG MP" := true;
            end;
            ValueEntry."Hide CNG MP" := th."Hide CNG MP";

            Location.Reset();

            Location.SetFilter(Code, '%1', TH."Transfer-to Code");
            Location.SetFilter("CNG VL", '%1', true);
            if Location.FindFirst() then begin
                ValueEntry."CNG VL" := true;
            end
            else begin
                Location.Reset();

                Location.SetFilter(Code, '%1', TH."Transfer-from Code");
                Location.SetFilter("CNG VL", '%1', true);
                if Location.FindFirst() then
                    ValueEntry."CNG VL" := true
                else
                    ValueEntry."CNG VL" := false;
            end;


        end;


        if (ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale) and (THEx = false)
        then begin
            if ValueEntry."Location Code" <> '' then begin
                Location.Reset();
                Location.SetFilter(Code, '%1', ValueEntry."Location Code");
                if Location.FindFirst() then begin
                    if Location."CNG MP" = true
                    then
                        ValueEntry."CNG MP" := true
                    else
                        ValueEntry."CNG MP" := false;

                    if Location."CNG VP" = true
                    then
                        ValueEntry."CNG VP" := true
                    else
                        ValueEntry."CNG VP" := false;

                    if Location."CNG VL" = true
             then
                        ValueEntry."CNG VL" := true
                    else
                        ValueEntry."CNG VL" := false;

                end;


            end;

        end;
        if (ValueEntry."CNG MP") or (ValueEntry."CNG VL") or (ValueEntry."CNG VP") and (ItemJournalLine."Sales Header No." <> '') then
            ValueEntry."Sales Header No." := ItemJournalLine."Sales Header No.";
        if (ValueEntry."CNG MP") or (ValueEntry."CNG VP") or (ValueEntry."CNG VL") then begin


            if CalSetup.FindFirst() then begin

                if (ValueEntry."Item No." = CalSetup."Item No.") and ((ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Transfer) or (ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale)) then begin

                    Customer.Reset();
                    Customer.SetFilter("Internal Customer", '%1', true);
                    Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                    Customer.setfilter("Customer Category", '%1', Customer."Customer Category"::CNG);
                    if Customer.FindFirst() then begin
                        //Customer."Customer Price Group"
                        SalesPrice.Reset();
                        SalesPrice.SetFilter("Sales Code", '%1', Customer."Customer Price Group");
                        SalesPrice.SetFilter("Sales Type", '%1', SalesPrice."Sales Type"::"Customer Price Group");
                        if SalesPrice.FindFirst() then begin
                            ValueEntry."Retail Unit Price" := SalesPrice."Retail Unit Price";
                            ValueEntry."Wholesale Unit Price" := SalesPrice."Wholesale Unit Price";

                            if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                                ValueEntry."Total Retail Amount" := Round(SalesPrice."Retail Unit Price" * ValueEntry."Valued Quantity", G."Amount Rounding Precision")

                            else
                                ValueEntry."Total Retail Amount" := Round(SalesPrice."Retail Unit Price" * ValueEntry."Item Ledger Entry Quantity", G."Amount Rounding Precision");







                            if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                                ValueEntry."Total Wholesale Amount" := Round(SalesPrice."Wholesale Unit Price" * ValueEntry."Valued Quantity", G."Amount Rounding Precision")

                            else
                                ValueEntry."Total Wholesale Amount" := Round(SalesPrice."Wholesale Unit Price" * ValueEntry."Item Ledger Entry Quantity", G."Amount Rounding Precision");






                            ValueEntry."Retail RUC" := abs(abs(ValueEntry."Cost Amount (Actual)") - abs(ValueEntry."Total Retail Amount"));
                            ValueEntry."Wholesale RUC" := abs(abs(ValueEntry."Cost Amount (Actual)") - abs(ValueEntry."Total Wholesale Amount"));






                            SHL.RESET;
                            SHL.SETFILTER("Document No.", '%1', ValueEntry."Document No.");
                            SHL.SETFILTER("Line No.", '%1', ValueEntry."Document Line No.");
                            IF Shl.FindFirst() then
                                ValueEntry."Payment Method Code" := SHL."Payment Method Code";
                        end
                        else begin
                            ValueEntry."Retail Unit Price" := 0;
                            ValueEntry."Total Retail Amount" := 0;
                            ValueEntry."Retail RUC" := 0;

                            ValueEntry."Wholesale Unit Price" := 0;
                            ValueEntry."Total Wholesale Amount" := 0;
                            ValueEntry."Wholesale RUC" := 0;



                        end;

                        Item.Reset();
                        Item.SetFilter("No.", '%1', ValueEntry."Item No.");
                        if Item.FindFirst() then begin
                            VPS.Reset();
                            VPS.SetFilter("VAT Prod. Posting Group", '%1', item."VAT Prod. Posting Group");
                            if VPS.FindFirst() then begin
                                ValueEntry."Retail Unit Price with VAT" := ROUND(ValueEntry."Retail Unit Price" + ValueEntry."Retail Unit Price" * (VPS."VAT %") / 100, G."Amount Rounding Precision");
                                ValueEntry."Retail VAT" := VPS."VAT %";


                                if ValueEntry."Sales Amount (Actual)" <> 0 then
                                    ValueEntry."Calculate Retail VAT" := (Round(ValueEntry."Sales Amount (Actual)" * ValueEntry."Retail VAT" / 100, G."Amount Rounding Precision"))

                                else
                                    ValueEntry."Calculate Retail VAT" := Round(ValueEntry."Cost Amount (Expected)" * ValueEntry."Retail VAT" / 100, G."Amount Rounding Precision");


                                if ValueEntry."CNG MP" = true then begin
                                    ValueEntry."VAT Difference CNG" := (ValueEntry."Calculate Retail VAT") - (((ValueEntry."Retail Unit Price with VAT" * abs(ValueEntry."Invoiced Quantity") - ValueEntry."Sales Amount (Actual)")));
                                end;
                                USset.Reset();
                                USset.SetFilter("User ID", '%1', UserId);

                                if USset.FindFirst() then begin
                                    if ValueEntry."Calculate Retail VAT" <> 0 then begin
                                        if (ValueEntry."VAT Difference CNG" < 1) and (ValueEntry."VAT Difference CNG" > -1) then
                                            USset."Value entries Cost" := ValueEntry."Calculate Retail VAT" - ValueEntry."VAT Difference CNG"
                                        else
                                            USset."Value entries Cost" := ValueEntry."Calculate Retail VAT";
                                        USset.Modify();
                                    end;
                                end;

                                if (ValueEntry."Calculate Retail VAT" = 0) and (ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Shipment")
                                then begin
                                    ValueEntry."Calculate Retail VAT" := USset."Value entries Cost";

                                end;



                                ValueEntry."WholeSale Unit Price with VAT" := ROUND(ValueEntry."WholeSale Unit Price" + ValueEntry."WholeSale Unit Price" * (VPS."VAT %") / 100, G."Amount Rounding Precision");
                                ValueEntry."WholeSale VAT" := VPS."VAT %";
                                ValueEntry."Calculate Wholesale VAT" := Round(ValueEntry."Sales Amount (Actual)" * ValueEntry."Wholesale VAT" / 100, G."Amount Rounding Precision");

                                if ValueEntry."CNG VP" = true then begin
                                    ValueEntry."VAT Difference CNG" := (ValueEntry."Calculate Wholesale VAT") - (((ValueEntry."WholeSale Unit Price with VAT" * abs(ValueEntry."Invoiced Quantity") - ValueEntry."Sales Amount (Actual)")));

                                end;

                                if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                                    ValueEntry."T.Retail Unit Price with VAT" := round((ValueEntry."Valued Quantity" * ValueEntry."Retail Unit Price") + (ValueEntry."Valued Quantity" * ValueEntry."Retail Unit Price") * (ValueEntry."Retail VAT" / 100), G."Amount Rounding Precision")
                                else
                                    ValueEntry."T.Retail Unit Price with VAT" := round((ValueEntry."Item Ledger Entry Quantity" * ValueEntry."Retail Unit Price") + (ValueEntry."Item Ledger Entry Quantity" * ValueEntry."Retail Unit Price") * (ValueEntry."Retail VAT" / 100), G."Amount Rounding Precision");


                                if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                                    ValueEntry."T.WholeSale Unit Price with V" := round((ValueEntry."Valued Quantity" * ValueEntry."WholeSale Unit Price") + (ValueEntry."Valued Quantity" * ValueEntry."WholeSale Unit Price") * (ValueEntry."WholeSale VAT" / 100), G."Amount Rounding Precision")
                                else
                                    ValueEntry."T.WholeSale Unit Price with V" := round((ValueEntry."Item Ledger Entry Quantity" * ValueEntry."WholeSale Unit Price") + (ValueEntry."Item Ledger Entry Quantity" * ValueEntry."WholeSale Unit Price") * (ValueEntry."WholeSale VAT" / 100), G."Amount Rounding Precision");



                                /* if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then
                                     ValueEntry."T.WholeSale Unit Price with V" := round(ValueEntry."Valued Quantity" * ValueEntry."WholeSale Unit Price with VAT", G."Amount Rounding Precision")
                                 else
                                     ValueEntry."T.WholeSale Unit Price with V" := round(ValueEntry."Item Ledger Entry Quantity" * ValueEntry."WholeSale Unit Price with VAT", G."Amount Rounding Precision");


 */


                            end
                            else begin
                                ValueEntry."Retail Unit Price with VAT" := 0;
                                ValueEntry."Retail VAT" := 0;
                                ValueEntry."T.Retail Unit Price with VAT" := 0;


                                ValueEntry."WholeSale Unit Price with VAT" := 0;
                                ValueEntry."WholeSale VAT" := 0;
                                ValueEntry."T.WholeSale Unit Price with V" := 0


                                //  ValueEntry."Retail RUC" := 0;

                            end;

                        end
                        else begin
                            ValueEntry."Retail Unit Price with VAT" := 0;
                            ValueEntry."Retail VAT" := 0;
                            ValueEntry."T.Retail Unit Price with VAT" := 0;
                            ValueEntry."Retail RUC" := 0;

                            ValueEntry."WholeSale Unit Price with VAT" := 0;
                            ValueEntry."WholeSale VAT" := 0;
                            ValueEntry."T.WholeSale Unit Price with V" := 0;
                            ValueEntry."WholeSale RUC" := 0;


                        end;





                    end;

                    if ValueEntry."Total Retail Amount" < 0 then
                        SignValue := -1
                    else
                        SignValue := 1;

                    ValueEntry."Retail Unit Price" := SignValue * ValueEntry."Retail Unit Price";
                    ValueEntry."Retail RUC" := SignValue * ValueEntry."Retail RUC";
                    ValueEntry."Retail VAT" := SignValue * ValueEntry."Retail VAT";
                    ValueEntry."Retail Unit Price with VAT" := SignValue * ValueEntry."Retail Unit Price with VAT";



                    //veleprodaja

                    if ValueEntry."Total Wholesale Amount" < 0 then
                        SignValue := -1
                    else
                        SignValue := 1;

                    ValueEntry."Wholesale Unit Price" := SignValue * ValueEntry."Wholesale Unit Price";
                    ValueEntry."Wholesale RUC" := SignValue * ValueEntry."Wholesale RUC";
                    ValueEntry."Wholesale VAT" := SignValue * ValueEntry."Wholesale VAT";
                    ValueEntry."Wholesale Unit Price with VAT" := SignValue * ValueEntry."Wholesale Unit Price with VAT";




                    ItemLedgerEntry."Retail RUC" := ValueEntry."Retail RUC";


                    ItemLedgerEntry."Retail Unit Price" := ValueEntry."Retail Unit Price";
                    ItemLedgerEntry."Retail Unit Price with VAT" := ValueEntry."Retail Unit Price with VAT";
                    ItemLedgerEntry."Retail VAT" := ValueEntry."Retail VAT";
                    ItemLedgerEntry."T.Retail Unit Price with VAT" := ValueEntry."T.Retail Unit Price with VAT";
                    ItemLedgerEntry."Total Retail Amount" := ValueEntry."Total Retail Amount";
                    if ValueEntry."Sales Header No." <> '' then
                        ItemLedgerEntry."Sales Header No." := ValueEntry."Sales Header No.";
                    if ValueEntry."Department Code" <> '' then
                        ItemLedgerEntry."Department Code" := ValueEntry."Department Code";


                    ItemLedgerEntry."Wholesale RUC" := ValueEntry."Wholesale RUC";
                    ItemLedgerEntry."Wholesale Unit Price" := ValueEntry."Wholesale Unit Price";
                    ItemLedgerEntry."Wholesale Unit Price with VAT" := ValueEntry."Wholesale Unit Price with VAT";
                    ItemLedgerEntry."Wholesale VAT" := ValueEntry."Wholesale VAT";
                    ItemLedgerEntry."T.Wholesale Unit Price with V" := ValueEntry."T.Wholesale Unit Price with V";
                    ItemLedgerEntry."Total Wholesale Amount" := ValueEntry."Total Wholesale Amount";



                    RecRef.GetTable(ItemLedgerEntry);
                    RecordRefExample.ModifyRecords(RecRef);

                    if (ValueEntry."CNG MP" = true) or (ValueEntry."CNG VL" = true) or (ValueEntry."CNG VP" = true) then begin
                        if (abs(ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)") <= 0.02) and ((abs(ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)") <> 0))
                        then begin
                            if ValueEntry."Cost Amount (Expected)" < 0 then
                                ValueEntry."Cost Amount (Actual)" := abs(ValueEntry."Cost Amount (Expected)")
                            else
                                ValueEntry."Cost Amount (Actual)" := -1 * abs(ValueEntry."Cost Amount (Expected)");
                        end;
                    end;

                    //    CODEUNIT.Run(CODEUNIT::"Modiy Permissions", ItemLedgerEntry);

                end;

            end;

        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, 241, 'OnBeforeCode', '', true, true)]

    procedure OnBeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        IJB: Record "Item Journal Batch";
        ILE: Record "Item Ledger Entry";

    begin

        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then begin
            ILE.Reset();
            ILE.SetFilter("Document No.", '%1', ItemJournalLine."Document No.");
            ILE.SetFilter("Item No.", '%1', ItemJournalLine."Item No.");
            ile.SetFilter(Quantity, '%1', -ItemJournalLine.Quantity);
            if ile.FindFirst() then begin
                Error('Izlaz ' + ItemJournalLine."Document No." + ' ste već proknjižili!');
            end;
        end;
        IJb.Reset();
        ijb.SetFilter(name, '%1', ItemJournalLine."Journal Batch Name");
        if IJB.FindFirst() then begin
            if IJB.Transfer = true then
                HideDialog := true;
        end;

    end;

    //

    //
    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry."Employee No." := ItemJournalLine."Employee No.";
        ItemLedgerEntry."Employee Name" := ItemJournalLine."Employee Name";
        ItemLedgerEntry."Org Name" := ItemJournalLine."Org Name";
        ItemLedgerEntry."Sales Header No." := ItemJournalLine."Sales Header No.";
        ItemLedgerEntry."Department Code" := ItemJournalLine."Department Code";
        ItemLedgerEntry."Sales Line No." := ItemJournalLine."Sales Line No.";
        if (ItemJournalLine."Sales Header No." = '') and (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale) then
            ItemJournalLine."Sales Header No." := ItemJournalLine."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforeTransRcptHeaderInsert', '', true, true)]
    local procedure OnBeforeTransRcptHeaderInsert(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Sales Header No." := TransferHeader."Sales Header No.";
        TransferReceiptHeader."Department Code" := TransferHeader."Department Code";
    end;




    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertCorrItemLedgEntry', '', true, true)]

    local procedure OnBeforeInsertCorrItemLedgEntry(var NewItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    var
        Sign: Integer;
    begin
        if NewItemLedgerEntry.Quantity > 0 then begin
            Sign := -1;
        end
        else begin
            Sign := 1;
        end;

        //
        NewItemLedgerEntry."Retail RUC" := sign * NewItemLedgerEntry."Retail RUC";
        NewItemLedgerEntry."Retail Unit Price" := Sign * NewItemLedgerEntry."Retail Unit Price";
        NewItemLedgerEntry."Retail Unit Price with VAT" := sign * NewItemLedgerEntry."Retail Unit Price with VAT";
        NewItemLedgerEntry."Retail VAT" := Sign * NewItemLedgerEntry."Retail VAT";
        NewItemLedgerEntry."T.Retail Unit Price with VAT" := Sign * NewItemLedgerEntry."T.Retail Unit Price with VAT";
        NewItemLedgerEntry."Total Retail Amount" := Sign * NewItemLedgerEntry."Total Retail Amount";


        NewItemLedgerEntry."Wholesale RUC" := Sign * NewItemLedgerEntry."Wholesale RUC";
        NewItemLedgerEntry."Wholesale Unit Price" := Sign * NewItemLedgerEntry."Wholesale Unit Price";
        NewItemLedgerEntry."Wholesale Unit Price with VAT" := Sign * NewItemLedgerEntry."Wholesale Unit Price with VAT";
        NewItemLedgerEntry."Wholesale VAT" := Sign * NewItemLedgerEntry."Wholesale VAT";
        NewItemLedgerEntry."T.Wholesale Unit Price with V" := Sign * NewItemLedgerEntry."T.Wholesale Unit Price with V";
        NewItemLedgerEntry."Total Wholesale Amount" := Sign * NewItemLedgerEntry."Total Wholesale Amount";



    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertCorrValueEntry', '', true, true)]
    local procedure OnBeforeInsertCorrValueEntry(var NewValueEntry: Record "Value Entry"; OldValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line"; Sign: Integer; CalledFromAdjustment: Boolean; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L")
    begin
        //ovdje dodajem opciju korekcije
        NewValueEntry."Retail RUC" := Sign * OldValueEntry."Retail RUC";
        NewValueEntry."Retail Unit Price" := Sign * OldValueEntry."Retail Unit Price";
        NewValueEntry."Retail Unit Price with VAT" := Sign * OldValueEntry."Retail Unit Price with VAT";
        NewValueEntry."Retail VAT" := Sign * OldValueEntry."Retail VAT";
        NewValueEntry."T.Retail Unit Price with VAT" := Sign * OldValueEntry."T.Retail Unit Price with VAT";
        NewValueEntry."Total Retail Amount" := Sign * OldValueEntry."Total Retail Amount";
        NewValueEntry."G/L Correction" := true;

        NewValueEntry."Wholesale RUC" := Sign * OldValueEntry."Wholesale RUC";
        NewValueEntry."Wholesale Unit Price" := Sign * OldValueEntry."Wholesale Unit Price";
        NewValueEntry."Wholesale Unit Price with VAT" := Sign * OldValueEntry."Wholesale Unit Price with VAT";
        NewValueEntry."Wholesale VAT" := Sign * OldValueEntry."Wholesale VAT";
        NewValueEntry."T.Wholesale Unit Price with V" := Sign * OldValueEntry."T.Wholesale Unit Price with V";
        NewValueEntry."Total Wholesale Amount" := Sign * OldValueEntry."Total Wholesale Amount";



    end;


    [EventSubscriber(ObjectType::Codeunit, 7000, 'OnAfterFindSalesLineItemPrice', '', true, true)]
    local procedure OnAfterFindSalesLineItemPrice(var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price" temporary; var FoundSalesPrice: Boolean; CalledByFieldNo: Integer)
    var
        WRL: Record "Warehouse Receipt Line";
        LC: Record Location;
        SH: Record "Sales Header";
    begin
        LC.Reset();
        LC.SetFilter(Code, '%1', SalesLine."Location Code");
        if LC.FindFirst() then begin
            if LC."CNG MP" = true then
                TempSalesPrice."Unit Price" := TempSalesPrice."Retail Unit Price";

            if LC."CNG VP" = true then
                TempSalesPrice."Unit Price" := TempSalesPrice."Wholesale Unit Price";

            if LC."CNG VL" = true then
                TempSalesPrice."Unit Price" := TempSalesPrice."Retail Unit Price";

            SH.Reset();
            SH.SetFilter("No.", '%1', SalesLine."Document No.");
            if SH.FindFirst() then begin
                if (sh."Internal Customer" = true) and ((lc."CNG MP") or (lc."CNG VL") or (lc."CNG VP")) then
                    TempSalesPrice."Unit Price" := TempSalesPrice."Purchase unit price";
            end;


        end;

    end;




    //

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnInsertReceiptLineOnAfterInitPurchRcptLine', '', true, true)]
    local procedure OnInsertReceiptLineOnAfterInitPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer)
    var
        WRL: Record "Warehouse Receipt Line";
    begin
        WRL.Reset();
        WRL.SetFilter("Source No.", '%1', PurchLine."Document No.");
        WRL.SetFilter("Line No.", '%1', PurchLine."Line No.");
        if WRL.FindFirst() then begin

            PurchRcptLine."Print Quantity" := (WRL."Print Quantity") div 1;
        end
        else begin
            PurchRcptLine."Print Quantity" := (WRL.Quantity) div 1;

        end;

        //  PurchRcptLine.p

    end;

    local procedure OnAfterInitPostedRcptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")
    begin
    end;



    //[IntegrationEvent(false, false)]


    [EventSubscriber(ObjectType::Codeunit, 5056, 'OnBeforeContactInsert', '', true, true)]
    local procedure OnBeforeContactInsert(var Contact: Record Contact; Customer: Record Customer)
    begin
        Contact."Type Relation" := Contact."Type Relation"::Customer;
    end;


    [EventSubscriber(ObjectType::Codeunit, 5056, 'OnBeforeContactInsert', '', true, true)]
    local procedure OnAfterTransferFieldsFromCustToCont(var Contact: Record Contact; Customer: Record Customer)
    begin
        Contact."E-Mail 2" := Customer."E-Mail 2";

    end;


    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeGenNextNo', '', true, true)]
    local procedure OnBeforeGenNextNo(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    var
        us: Record "User Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Undo Shipment" = true then begin
                TransferShipmentHeader."No." := '';
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        Us: Record "User Setup";
        GlobalItemLedgEntry: Record "Item Ledger Entry";
    begin
        /*  us.Reset();
          us.SetFilter("User ID", '%1', UserId);
          if us.FindFirst() then begin
              if us."Undo Shipment" = true then begin
                  ItemLedgEntryNo := 0;
                  if ItemLedgEntryNo = 0 then begin
                      GlobalItemLedgEntry.LockTable();
                      ItemLedgEntryNo := GlobalItemLedgEntry.GetLastEntryNo();
                      GlobalItemLedgEntry."Entry No." := ItemLedgEntryNo;
                      us."Undo Shipment" := false;
                      //povećati za jedan TransferSHipment
                      us.Modify();
                  end;
              end;

          end;*/
    end;




    //  [IntegrationEvent(false, false)]
    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterCreateItemJnlLine', '', true, true)]

    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    var
        TransHeader: Record "Transfer Header";
        CU: Codeunit "TransferOrder-Post Shipment";
    begin
        TransHeader.Get(TransferLine."Document No.");

        ItemJournalLine."Gen. Bus. Posting Group" := TransHeader."Gen. Bus. Posting Group";
        ItemJournalLine."Gen Bus Posting" := TransHeader."Gen. Bus. Posting Group";
        ItemJournalLine."Sales Header No." := TransHeader."Sales Header No.";
        ItemJournalLine."Sales Line No." := TransHeader."Sales Line No.";
        ItemJournalLine."Employee No." := TransHeader."Employee No.";
        ItemJournalLine."Employee Name" := TransHeader."Employee Name";
        ItemJournalLine."Department Code" := TransHeader."Department Code";
    end;

    //  [IntegrationEvent(false, false)]


    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeInsertTransShptHeader', '', true, true)]

    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    var
        WLE: page "Whse. Shipment Subform";
        WSH: Record "Warehouse Shipment Header";

    begin
        //evo ga


        //ovdje dodati
        TransShptHeader."Employee No." := TransHeader."Employee No.";
        TransShptHeader."Employee Name" := TransHeader."Employee Name";
        TransShptHeader."Sales Header No." := TransHeader."Sales Header No.";
        TransShptHeader."G/L Account No." := TransHeader."G/L Account No.";
        TransShptHeader."Department Code" := TransHeader."Department Code";

        //  TransShptHeader."Document No.":=TransHeader.doc

        WSH.Reset();
        WSH.SetFilter("Transfer Header No.", '%1', TransHeader."No.");
        if WSH.FindFirst() then begin
            TransShptHeader."Document No." := WSH."Document No.";
            TransShptHeader."Order Date" := WSH."Order Date";
            TransShptHeader."Assigned User ID" := WSH."Assigned User ID";
            TransShptHeader."RN Source" := wsh."RN Source";
            TransShptHeader.Address := WSH.Address;
            TransShptHeader."Sales Header No." := wsh."Sales Header No.";
            TransShptHeader."G/L Account No." := WSH."G/L Account No.";
            TransShptHeader."Department Code" := WSH."Department Code";

        end;

    end;







    [EventSubscriber(ObjectType::Codeunit, 5750, 'OnBeforeWhseReceiptLineInsert', '', true, true)]
    local procedure OnBeforeWhseReceiptLineInsert(var WarehouseReceiptLine: Record "Warehouse Receipt Line")
    begin

        WarehouseReceiptLine."Print Quantity" := (WarehouseReceiptLine.Quantity) div 1;
    end;



    [EventSubscriber(ObjectType::Report, report::"Get Source Documents", 'OnBeforeWhseReceiptHeaderInsert', '', true, true)]
    local procedure OnBeforeWhseReceiptHeaderInsert(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseRequest: Record "Warehouse Request")
    var
        US: Record "User Setup";
        WhseSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if US.FindFirst() then begin
            if us."Undo Shipment" = true then begin
                WhseSetup.Get();
                WarehouseReceiptHeader."No. Series" := WhseSetup."Undo Warehouse Receipt";
                WarehouseReceiptHeader."Receiving No. Series" := WhseSetup."Posted Undo Warehouse Receipt";

                if WarehouseReceiptHeader."No." = '' then begin
                    WhseSetup.TestField("Undo Warehouse Receipt");
                    NoSeriesMgt.InitSeries(WhseSetup."Undo Warehouse Receipt", WhseSetup."Undo Warehouse Receipt", WarehouseReceiptHeader."Posting Date", WarehouseReceiptHeader."No.", WarehouseReceiptHeader."No. Series");

                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnBeforePostedWhseShptHeaderInsert', '', true, true)]

    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var

    begin
        PostedWhseShipmentHeader."Order Date" := WarehouseShipmentHeader."Order Date";
        PostedWhseShipmentHeader."Employee No." := WarehouseShipmentHeader."Employee No.";
        PostedWhseShipmentHeader."Employee Name" := WarehouseShipmentHeader."Employee Name";
        PostedWhseShipmentHeader."Assigned User ID" := WarehouseShipmentHeader."Assigned User ID";
        PostedWhseShipmentHeader."RN Source" := WarehouseShipmentHeader."RN Source";
        PostedWhseShipmentHeader.Address := WarehouseShipmentHeader.Address;
        PostedWhseShipmentHeader."Sales Header No." := WarehouseShipmentHeader."Sales Header No.";
        PostedWhseShipmentHeader."G/L Account No." := WarehouseShipmentHeader."G/L Account No.";
        PostedWhseShipmentHeader."Department Code" := WarehouseShipmentHeader."Department Code";

    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeUpdateWithWarehouseShipReceive', '', true, true)]

    local procedure OnBeforeUpdateWithWarehouseShipReceive(TransferLine: Record "Transfer Line")
    var
        ServiceLineUpdate: Record "Service Line";
    begin
        ServiceLineUpdate.Reset();
        ServiceLineUpdate.SetFilter("Transfer Order", '%1', TransferLine."Document No.");
        // ServiceLineUpdate.SetFilter("Line No.", '%1', WarehouseShipmentLine."Line No.");
        ServiceLineUpdate.SetFilter(Type, '%1', ServiceLineUpdate.Type::Item);
        //  ServiceLineUpdate.SetFilter("Quantity Shipped", '%1', 0);
        ServiceLineUpdate.SetFilter("No.", '%1', TransferLine."Item No.");
        if ServiceLineUpdate.FindSet() THEN
            repeat
                IF ServiceLineUpdate.Quantity <> ServiceLineUpdate."Quantity Shipped" THEN BEGIN
                    ServiceLineUpdate."Quantity Shipped" := TransferLine."Quantity Shipped";
                    ServiceLineUpdate.Modify();
                END;
            UNTIL ServiceLineUpdate.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnAfterReleaseSourceForFilterWhseShptLine', '', true, true)]



    local procedure OnAfterReleaseSourceForFilterWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line");
    var
        ServiceLineUpdate: Record "Service Line";
    begin
        /*  ServiceLineUpdate.Reset();
          ServiceLineUpdate.SetFilter("Transfer Order", '%1', WarehouseShipmentLine."Source No.");
          // ServiceLineUpdate.SetFilter("Line No.", '%1', WarehouseShipmentLine."Line No.");
          ServiceLineUpdate.SetFilter(Type, '%1', ServiceLineUpdate.Type::Item);
          //  ServiceLineUpdate.SetFilter("Quantity Shipped", '%1', 0);
          ServiceLineUpdate.SetFilter("No.", '%1', WarehouseShipmentLine."Item No.");
          if ServiceLineUpdate.FindSet() THEN
              repeat
                  IF ServiceLineUpdate.Quantity <> ServiceLineUpdate."Quantity Shipped" THEN BEGIN
                      ServiceLineUpdate."Quantity Shipped" := WarehouseShipmentLine."Qty. to Ship";
                      ServiceLineUpdate.Modify();
                  END;
              UNTIL ServiceLineUpdate.Next() = 0;*/
    end;

    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnAfterTransferPostShipment', '', true, true)]


    local procedure OnAfterTransferPostShipment(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; TransferHeader: Record "Transfer Header")
    var
        ServiceLineUpdate: Record "Service Line";
    begin

        /*  ServiceLineUpdate.Reset();
          ServiceLineUpdate.SetFilter("Transfer Order", '%1', WarehouseShipmentLine."Source No.");
          // ServiceLineUpdate.SetFilter("Line No.", '%1', WarehouseShipmentLine."Line No.");
          ServiceLineUpdate.SetFilter(Type, '%1', ServiceLineUpdate.Type::Item);
          //  ServiceLineUpdate.SetFilter("Quantity Shipped", '%1', 0);
          ServiceLineUpdate.SetFilter("No.", '%1', WarehouseShipmentLine."Item No.");
          if ServiceLineUpdate.FindSet() THEN
              repeat
                  IF ServiceLineUpdate.Quantity <> ServiceLineUpdate."Quantity Shipped" THEN BEGIN
                      ServiceLineUpdate."Quantity Shipped" := WarehouseShipmentLine."Qty. to Ship";
                      ServiceLineUpdate.Modify();
                  END;
              UNTIL ServiceLineUpdate.Next() = 0;*/
    end;


    [EventSubscriber(ObjectType::Codeunit, 5763, 'OnAfterRun', '', true, true)]

    local procedure OnAfterRun(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        Location: Record Location;
        TL: Record "Transfer Line";
        TH: Record "Transfer Header";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        ServiceLineUpdate: record "Service Line";



    begin

        //INT 1.0 start
        Location.SETFILTER(Code, '%1', WarehouseShipmentLine."Destination No.");
        IF Location.FIND('-') THEN BEGIN
            IF NOT Location."Require Receive" THEN BEGIN
                TL.SETFILTER("Document No.", '%1', WarehouseShipmentLine."Source No.");
                IF TL.FIND('-') THEN
                    TL.VALIDATE("Qty. to Receive", TL."Quantity Shipped");
                TL.MODIFY;
                TH.SETFILTER("No.", '%1', TL."Document No.");
                IF TH.FIND('-') THEN BEGIN
                    TransferPostReceipt.RUN(TH);
                END;
            END;
        END;
        //INT1.0 end*/

        /*  ServiceLineUpdate.Reset();
          ServiceLineUpdate.SetFilter("Transfer Order", '%1', WarehouseShipmentLine."Source No.");
          ServiceLineUpdate.SetFilter("Line No.", '%1', WarehouseShipmentLine."Line No.");
          ServiceLineUpdate.SetFilter(Type, '%1', ServiceLineUpdate.Type::Item);
          ServiceLineUpdate.SetFilter("No.", '%1', WarehouseShipmentLine."Item No.");
          if ServiceLineUpdate.FindFirst() then begin
              ServiceLineUpdate."Quantity Shipped" := WarehouseShipmentLine."Qty. Shipped";
              ServiceLineUpdate.Modify();
          end;*/

    end;




    procedure EvenOrOdd(var Number: Integer) Even: Boolean
    var

    begin
        if (Number mod 2) = 0 then
            Even := true
        else
            Even := false;

    end;




    procedure RemoveLetter(var Number: Code[20]) Even: Text[250]
    var
        TextNumber: Text[250];


    begin
        Even := DELCHR(Number, '=', DELCHR(Number, '=', '1234567890'));

    end;

    procedure NumberToMonth(var IncomingNo: Integer): Text
    var
        MonthName: Text;
        labelJanuary: Label 'January';
        labelFebruary: Label 'February';
        labelMarch: Label 'March';
        labelApril: Label 'April';
        labelMay: Label 'May';
        labelJune: Label 'June';
        labelJuly: Label 'July';
        labelAugust: Label 'August';
        labelSeptember: Label 'September';
        labelOctober: Label 'October';
        labelNovember: Label 'November';
        labelDecember: Label 'December';
        Txt001: Label 'Invalid month number. Please provide a value between 1 and 12.';
    begin
        //Amir
        if (IncomingNo < 1) or (IncomingNo > 12) then
            Error(Txt001);

        case IncomingNo of
            1:
                MonthName := labelJanuary;
            2:
                MonthName := labelFebruary;
            3:
                MonthName := labelMarch;
            4:
                MonthName := labelApril;
            5:
                MonthName := labelMay;
            6:
                MonthName := labelJune;
            7:
                MonthName := labelJuly;
            8:
                MonthName := labelAugust;
            9:
                MonthName := labelSeptember;
            10:
                MonthName := labelOctober;
            11:
                MonthName := labelNovember;
            12:
                MonthName := labelDecember;
        end;

        exit(MonthName);
    end;

    //Amir. WagesNotAllowed: General message for users who don't have permission to view Wage related stuff. To avoid many duplicates in translation file.
    procedure WagesNotAllowed(): Text
    var
        msg: Label 'You do not have permission to access this resource. Please contact your system administrator.';
    begin
        exit(msg);
    end;

    procedure HRNotAllowed(): Text
    var
        msg: Label 'You do not have permission to access this resource. Please contact your system administrator.';
    begin
        exit(msg);
    end;

    //amir: ova procedure je izvučena iz codeunit 311 "Item-Check Avail."
    //svrha je da se zabrani kreiranje otpremnice na Kartici zahtjeva radnog naloga. Na podtabeli Ostali troškovi, kada se navede Artikal, mi navedemo lokaciju
    //u polje Lokacija izvora (Source Location Code). Sa ovim je samo provjera preusmjerena da provjerava stanje artikla na tom skladištu. 
    procedure ServiceInvLineShowWarning(ServLine: Record "Service Line"): Boolean
    var
        OldServLine: Record "Service Line";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        OldItemNetChange: Decimal;
        OldItemNetResChange: Decimal;
        UseOrderPromise: Boolean;

    begin
        if not ItemCheckAvail.ShowWarningForThisItem(ServLine."No.") then
            exit(false);

        OldItemNetChange := 0;

        OldServLine := ServLine;

        if OldServLine.Find then // Find previous quantity
            if (OldServLine."Document Type" = OldServLine."Document Type"::Order) and
               (OldServLine."No." = ServLine."No.") and
               (OldServLine."Variant Code" = ServLine."Variant Code") and
               (OldServLine."Source Location Code" = ServLine."Source Location Code") and
               (OldServLine."Bin Code" = ServLine."Bin Code")
            then begin
                OldItemNetChange := -OldServLine."Outstanding Qty. (Base)";
                OldServLine.CalcFields("Reserved Qty. (Base)");
                OldItemNetResChange := -OldServLine."Reserved Qty. (Base)";
            end;

        UseOrderPromise := true;
        exit(
          ItemCheckAvail.ShowWarning(
            ServLine."No.",
            ServLine."Variant Code",
            ServLine."Source Location Code",
            ServLine."Unit of Measure Code",
            ServLine."Qty. per Unit of Measure",
            -ServLine."Outstanding Quantity",
            OldItemNetChange,
            ServLine."Needed by Date",
            OldServLine."Needed by Date"));
    end;




    [EventSubscriber(ObjectType::Codeunit, 5601, 'OnInsertBufferBalAccOnAfterAssignFromFAPostingGrAcc', '', true, true)]
    local procedure OnInsertBufferBalAccOnAfterAssignFromFAPostingGrAcc(FAAllocation: Record "FA Allocation"; var FAGLPostBuf: Record "FA G/L Posting Buffer")
    var
        Fixed: Record "Fixed Asset";
        DeprBook: Record "Depreciation Book";
        FaPosting: Record "FA Posting Group";
        ErrorNo: Integer;
        FADeprBook: Record "FA Depreciation Book";
        FAGLPostBuf2: Record "FA G/L Posting Buffer";
        GEnJnl: Record "Gen. Journal Line";

    begin







        // GenJournalLine."Bin Checked" := SalesHeader."Bin Checked";
        //   GenJournalLine.Amount ovdje se kreira amount
        /*   FAGLPostBuf2.Init();
           FAGLPostBuf2.TransferFields(FAGLPostBuf);
           FAGLPostBuf2.probati*
           /
           




    end;



    //FAGLPostBuf



    //   [IntegrationEvent(false, false)]

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnAfterInitQtyToReceive', '', true, true)]
    local procedure OnAfterInitQtyToReceive(var PurchLine: Record "Purchase Line"; CurrFieldNo: Integer)

    begin
        /* if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
             PurchLine."Qty. to Receive" := 0;
             PurchLine."Qty. to Invoice" := 0;
             if PurchLine.Quantity <> 1 then begin
                 Error('Količina za osnovno sredstvo mora biti jednaka 1!');
             end;*/

        // end;

    end;




    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnBeforeInitInsert', '', true, true)]
    local procedure OnBeforeInitInsert(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchaseS: Record "Purchases & Payables Setup";
    begin
        PurchaseS.get;
        if PurchaseHeader.Prepayment = true then begin
            PurchaseS.get;
            PurchaseHeader."No. Series" := PurchaseS."Advance No. Series";
        end;

    end;



    [EventSubscriber(ObjectType::Table, database::"Transfer Line", 'OnInsertOnBeforeAssignLineNo', '', true, true)]
    local procedure OnInsertOnBeforeAssignLineNo(var TransferLine: Record "Transfer Line"; var IsHandled: Boolean)
    var
        TrLine: Record "Transfer Line";
    begin

        if TransferLine."Line No." <> 0 then begin

            TrLine.reset();
            TrLine.SetFilter("Document No.", '%1', TransferLine."Document No.");
            TrLine.SetFilter("Line No.", '%1', TransferLine."Line No.");
            if not TrLine.FindFirst() then
                IsHandled := true;

        end;
    end;


    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnBeforeInitInsert', '', true, true)]
    local procedure OOnBeforeInitInsert(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesS: Record "Sales & Receivables Setup";
        BillT: Record "Customer Templ.";

    begin
        SalesS.get;
        if SalesHeader.Prepayment = true then begin
            SalesS.get;
            SalesHeader."No. Series" := SalesS."Prepayment Invoice Nos.";
        end;
        if SalesHeader."Bill type" <> '' then begin
            BillT.Reset();
            BillT.SetFilter(Code, '%1', SalesHeader."Bill type");
            if BillT.FindFirst() then begin
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                    SalesHeader.Validate("No. Series", BillT."No. Series Bill");
                    SalesHeader.Validate("Posting No. Series", BillT."Posting No. Series Bill");
                end;
                if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then begin
                    SalesHeader.Validate("No. Series", BillT."Undo No. Series Bill");
                    SalesHeader.Validate("Posting No. Series", BillT."Undo Posting No. Series Bill");
                end;
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Page, Page::"My Settings", 'OnUserRoleCenterChange', '', true, true)]
    local procedure OnUserRoleCenterChange(NewAllProfile: Record "All Profile")
    var
        Us: record "User Setup";
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin


            if NewAllProfile."Profile ID" = 'CNG' then begin
                if us."Control Verification" = true then
                    us."CNG Administrator" := true;
                us."CNG User" := true;
            end
            else begin
                us."CNG Administrator" := false;
                us."CNG User" := false;

            end;
            us.Modify();
        end;
    end;




    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeValidateLineAmount', '', true, true)]
    local procedure OnBeforeValidateLineAmount(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        US: Record "User Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."CNG Administrator" = true then
                IsHandled := true;
            if us."CNG User" = true then
                IsHandled := true;

        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnValidateNoOnBeforeUpdateDates', '', true, true)]

    local procedure OnValidateNoOnBeforeUpdateDates(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CallingFieldNo: Integer; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesS: Record "Sales & Receivables Setup";
        locat: Record Location;
    begin
        if (SalesLine."Location Code" = '') and (TempSalesLine."Location Code" <> '') then begin
            locat.Reset();
            locat.SetFilter(Code, '%1', TempSalesLine."Location Code");
            if locat.FindFirst() then begin
                if (locat."CNG MP" = true) or (locat."CNG VP" = true)
                then
                    SalesLine."Location Code" := TempSalesLine."Location Code";
            end;
        end;

    end;



    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnInitInsertOnBeforeInitRecord', '', true, true)]
    local procedure OnInitInsertOnBeforeInitRecord(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header")
    var
        PurchaseS: Record "Purchases & Payables Setup";
    begin
        PurchaseS.get;
        if PurchaseHeader.Prepayment = true then begin
            PurchaseS.get;
            If PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                PurchaseHeader."No. Series" := PurchaseS."Advance No. Series"
            ELSE
                PurchaseHeader."No. Series" := PurchaseS."Corr. Prepayment Invoice Nos.";
        end;

    end;



    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnInitInsertOnBeforeInitRecord', '', true, true)]
    local procedure OnInitInsertOnBeforeInitRecordSalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.get;
        if SalesHeader.Prepayment = true then begin
            SalesSetup.get;
            If SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                SalesHeader."No. Series" := SalesSetup."Prepayment Invoice Nos."
            ELSE
                SalesHeader."No. Series" := SalesSetup."Corr. Prepayment Invoice Nos.";
        end;

    end;






}
