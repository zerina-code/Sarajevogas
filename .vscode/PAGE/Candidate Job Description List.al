/*page 50239 "Candidate Job Description List"
{
    Caption = 'Candidate Job Description List';
    PageType = List;
    SourceTable = "Candidate Job Description";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Serial Number"; "Serial Number")
                {
                    ApplicationArea = all;
                }
                field("Job position ID"; "Job position ID")
                {
                    ApplicationArea = all;
                }
                field("Job position"; "Job position")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
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
}

*/