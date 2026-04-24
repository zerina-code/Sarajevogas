/*page 50175 "Posting List"
{
    Caption = 'Posting List';
    PageType = List;
    SourceTable = "Posting";
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
                    ShowMandatory = true;
                }
                field("HR Posting No."; "HR Posting No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Hiring Manager"; "Hiring Manager")
                {
                    ApplicationArea = all;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = all;
                }
                field("Number of Candidates"; "Number of Candidates")
                {
                    ApplicationArea = all;
                }
                field("Published Date"; "Published Date")
                {
                    ApplicationArea = all;
                }
                field("Employment Date"; "Employment Date")
                {
                    ApplicationArea = all;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = all;
                }
             
                field(Position; Position)
                {
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Roll Code"; "Roll Code")
                {
                    ApplicationArea = all;
                }
                field(Benefits; Benefits)
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Name of the Company"; "Name of the Company")
                {
                    ApplicationArea = all;
                }
           
                field(Selection; Selection)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Setup)
            {
                Caption = 'Setup';
                Image = HRSetup;
                action("New Selection")
                {
                    Caption = 'Start new selection';
                    Image = CreateDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Da li želite kreirati novu selekciju?') = TRUE THEN BEGIN

                            Posting.RESET;
                            Posting.SETFILTER("No.", '%1', Rec."No.");
                            IF Posting.FINDFIRST THEN BEGIN
                                PreviousSelection := Posting.Selection;
                                Posting.Selection := 'SEL' + FORMAT(Posting."Selection Number" + 1);
                                Posting."Selection Number" := Posting."Selection Number" + 1;
                                Posting.MODIFY;
                            END;

                            CandidatePosting.RESET;
                            CandidatePosting.SETFILTER("Posting No.", '%1', Rec."No.");
                            CandidatePosting.SETFILTER(Selection, '%1', PreviousSelection);
                            IF CandidatePosting.FINDFIRST THEN
                                REPEAT
                                    IF CandidatePosting.Feedback <> 'Izabrani kandidat nije za dalju selekciju' THEN BEGIN
                                        CandidatePosting2.INIT;
                                        CandidatePosting2.VALIDATE("Serial Number", CandidatePosting."Serial Number");
                                        CandidatePosting2.VALIDATE("Posting No.", CandidatePosting."Posting No.");
                                        CandidatePosting2.INSERT;
                                    END;
                                UNTIL CandidatePosting.NEXT = 0;




                        END;
                    end;
                }
                action("Selection by Month 1")
                {
                    Caption = 'Applications';
                    Image = "Report";
                    //    RunObject = Report "Selection by Month 1";
                    Visible = false;
                }
                action("Report Applications by Source")
                {
                    Caption = 'Applications';
                    Image = "Report";
                    //     RunObject = Report "Selection by Month 2";
                    Visible = False;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'IT MANAGER' THEN
                CurrPage.EDITABLE(FALSE);
        END;
    end;

    var
        UserPersonalization: Record "User Personalization";
        CandidatePosting: Record "Candidate/Posting";
        CandidatePosting2: Record "Candidate/Posting";
        Posting: Record "Posting";
        PreviousSelection: Text;
}

*/