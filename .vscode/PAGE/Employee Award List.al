/*page 50048 "Employee Award List"
{
    Caption = 'Employee Award List';
    PageType = List;
    SourceTable = "Work Duties Violation";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Visible = false;
                }
                field("Internal ID"; "Internal ID")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Position Description"; "Position Description")
                {
                }
                field("Department Name"; "Department Name")
                {
                }
                field("Group Description"; "Group Description")
                {
                }
                field("Sector Name"; "Sector Name")
                {
                }
                field(Reward; Reward)
                {
                }
                field("Reward Date"; "Reward Date")
                {
                }
                field(Comment; Comment)
                {
                }
                field("Document Template"; "Document Template")
                {
                    Visible = false;
                }
                field("Document Template2"; "Document Template" <> 0)
                {
                    Caption = 'Attachment';

                    trigger OnAssistEdit()
                    begin
                        IF "Document Template" <> 0 THEN
                            OpenAttachment;


                        CurrPage.UPDATE;
                    end;
                }
                field("Update Org jed"; "Update Org jed")
                {
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

                    // Attachment.SetParam1('', 4, 0);
                    IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) = FALSE THEN BEGIN
                        "Document Template" := Attachment."No.";
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
                        MODIFY;
                    END;

                    //RemoveAttachment(TRUE);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Page Type" := "Page Type"::Awards;
    end;

    var
        Attachment: Record Attachment;

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
                //IF DocOff.GET(Rec."Offer Version",Rec."Offer Code",Rec."Document Type",Rec."Document Template",Rec.Date) THEN
                //  DocOff.RENAME(Rec."Offer Version",Rec."Offer Code",Rec."Document Type",0,Rec.Date);
                "Document Template" := 0;
            END;
    end;
}

*/