/*page 50053 "Employee Disciplinary Measures"
{
    Caption = 'Employee Disciplinary Measures';
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
                field("Employee User Name"; "Employee User Name")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Internal ID"; "Internal ID")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Sector Name"; "Sector Name")
                {
                    ApplicationArea = all;
                }
                field("Measure Type"; "Measure Type")
                {
                    ApplicationArea = all;
                }
                field(Measure; Measure)
                {
                    ApplicationArea = all;
                }
                field("Injury Name"; "Injury Name")
                {
                    ApplicationArea = all;
                }
                field("Measure From"; "Measure From")
                {
                    ApplicationArea = all;
                }
                field("Measure To"; "Measure To")
                {
                    ApplicationArea = all;
                }
                field("Imposition/Adoption Date"; "Imposition/Adoption Date")
                {
                    ApplicationArea = all;
                }
                field(Complaint; Complaint)
                {
                    ApplicationArea = all;
                }
                field("Act Effective Date"; "Act Effective Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Measure"; "Expiration Measure")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }

                field("Document Template"; "Document Template" <> 0)
                {
                    Caption = 'Attachment';
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF "Document Template" <> 0 THEN
                            OpenAttachment;


                        CurrPage.UPDATE;
                    end;
                }
                field("Active Measure"; "Active Measure")
                {
                    ApplicationArea = all;
                }
                field("Update Org jed"; "Update Org jed")
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

                    //ĐK Attachment.SetParam1('', 4, 0);
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
            action("Notification Test")
            {
                Caption = 'Notification Test';
                Image = RefreshLines;
                //   RunObject = Report "Mails for Expiring Measures";
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Page Type" := "Page Type"::"Disciplinary measures";
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF "No." <> 0 THEN BEGIN
            TESTFIELD(Measure);
            TESTFIELD("Measure Type");
            TESTFIELD("Injury Name");
            TESTFIELD("Measure From");
            TESTFIELD("Measure To");
            TESTFIELD("Imposition/Adoption Date");
            TESTFIELD(Complaint);
            TESTFIELD("Act Effective Date");
            TESTFIELD("Expiration Measure");

            IF (STRPOS(Measure, 'Umanjenje plate na vremenski period do tri mjeseca, u iznosu do 20% jednomjesecne osnovne plate ostvarene u mjesecu u kojem je mjera izrecena') = 1) OR
               (STRPOS(Measure, 'Raspored na drugo radno mjesto na odredeno vrijeme, ali ne manje od tri mjeseca niti vise od 2 godine (raspored na drugo radno mjesto moze biti:') = 1) THEN BEGIN
                TESTFIELD("Expiration Measure");
            END;
        END;
    end;

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
                //IF DocOff.GET(Rec."Offer Version",Rec."Offer Code",Rec."Document Type",Rec."Document Template",Rec.Date) THEN
                //  DocOff.RENAME(Rec."Offer Version",Rec."Offer Code",Rec."Document Type",0,Rec.Date);
                "Document Template" := 0;
            END;
    end;
}

*/