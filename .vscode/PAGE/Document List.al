/*page 50090 "Document List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Documents;
    Caption = 'Document List';

    layout
    {
        area(Content)
        {
            repeater(Group2)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = All;

                }
                field("Attachment No"; "Attachment No" <> 0)
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        IF "Attachment No" <> 0 THEN
                            OpenAttachment2;

                        CurrPage.UPDATE;
                    end;

                }
                field("Document Name"; "Document Name")
                {

                }
                field("Print Confirmation"; "Print Confirmation")
                {

                }
                field(CR; CR)
                {

                }
                field("Attachment No2"; "Attachment No")
                {

                }
                field(ID_New; ID_New)
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //ImportAttachment;

                    IF Attachment.GET("Attachment No") THEN
                        Attachment.TESTFIELD("Read Only", FALSE);

                    Attachment.SetParam(Rec."Document No", 1, 1);
                    IF Attachment.ImportAttachmentFromClientFile2('', FALSE, FALSE) THEN BEGIN
                        "Attachment No" := Attachment."No.";
                        "Document Name" := Attachment."File Name";

                        // "Document Name":=Attachment."File Name";

                    END;
                end;
            }

        }
    }

    var
        myInt: Integer;
        Attachment: Record Attachment;

    procedure OpenAttachment2()
    var
        Attachment: Record Attachment;
    begin

        IF "Attachment No" = 0 THEN
            EXIT;
        Attachment.GET("Attachment No");

        Attachment.OpenAttachment(FORMAT("Attachment No"), FALSE, '');
    end;

}
*/