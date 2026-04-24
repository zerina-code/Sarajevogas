/*codeunit 50003 RequestsExtension
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, true)]
    local procedure OnBeforeDrillDownDocAttachmentFactbox(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ServiceItemLine: Record "Service Item Line";
    begin
        if DocumentAttachment."Table ID" = Database::"Service Item Line" then begin
            RecRef.Open(DATABASE::"Service Item Line");
            if ServiceItemLine.Get(Enum::"Service Document Type"::Order, DocumentAttachment."No.", DocumentAttachment."Line No.") then
                RecRef.GetTable(ServiceItemLine);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', true, true)]
    local procedure OnAfterOpeForRecRefDocAttDetails(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
    begin
        if RecRef.Number = Database::"Service Item Line" then begin
            FieldRef := RecRef.Field(1);
            RecNo := FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);

            FieldRef := RecRef.Field(2);
            LineNo := FieldRef.Value;
            DocumentAttachment.SetRange("Line No.", LineNo);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post (Yes/No)", 'OnBeforeConfirmServPost', '', true, true)]
    local procedure OnBeforeConfirmServPost(var ServiceHeader: Record "Service Header"; var Ship: Boolean; var Consume: Boolean; var Invoice: Boolean; var HideDialog: Boolean)
    var
        ConfirmPostLbl: Label 'Do you want to post costs for this order?';
        ProcessAbortedErr: Label 'Process aborted!';
    begin
        if ServiceHeader."Request Type" = Enum::"Request Type"::" " then
            exit;

        if not Confirm(ConfirmPostLbl, false) then
            Error(ProcessAbortedErr);

        Ship := true;
        Consume := false;
        Invoice := false;
        HideDialog := true;
    end;
}
*/