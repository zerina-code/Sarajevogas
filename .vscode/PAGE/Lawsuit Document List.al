/*ĐK page 50078 "Lawsuit Document List"
{
    Caption = 'Lawsuit Document List';
    PageType = List;
    SourceTable = "Lawsuit Documents";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Lawsuit No."; "Lawsuit No.")
                {
                    ApplicationArea = all;
                }
                field(Note; Note)
                {
                    ApplicationArea = all;
                }

                field("Document Template"; "Document Template" <> 0)
                {
                    ApplicationArea = all;
                    Caption = 'Attachment';

                    trigger OnAssistEdit()
                    begin
                        IF "Document Template" <> 0 THEN
                            OpenAttachment;


                        CurrPage.UPDATE;
                    end;
                }
                field("Insert Date"; "Insert Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Add)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    IF "Document Template" <> 0 THEN BEGIN
                        IF Attachment.GET("Document Template") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);
                    END;

                    //ĐK  Attachment.SetParam1('', 4, 0);
                    IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) = FALSE THEN BEGIN
                        "Document Template" := Attachment."No.";
                        "Insert Date" := TODAY;
                        MODIFY;
                    END;
                end;
            }
            action(Remove)
            {
                Caption = 'Remove';
                Image = RemoveLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('Da li želite izbrisati privitak') THEN BEGIN
                        "Document Template" := 0;
                        "Insert Date" := 0D;
                    END;

                    //RemoveAttachment(TRUE);
                end;
            }
        }
    }

    var
        Attachment: Record "Attachment";

    procedure OpenAttachment()
    var
        Attachment: Record "Attachment";
    begin
        IF "Document Template" = 0 THEN
            EXIT;
        Attachment.GET("Document Template");
        Attachment.OpenAttachment(FORMAT("Document Template"), FALSE, '');
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Document Template") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Document Template" := 0;

            END;
    end;
}

*/