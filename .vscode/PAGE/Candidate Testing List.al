/*page 50011 "Candidate Testing List"
{
    Caption = 'Candidate Testing List';
    PageType = List;
    SourceTable = "Candidate Testing";
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
                    BlankZero = true;
                    ApplicationArea = all;
                }
                field("Test Date"; "Test Date")
                {
                    ApplicationArea = all;
                }
                field("Test Type"; "Test Type")
                {
                    BlankZero = true;
                    ApplicationArea = all;
                }
                field("Test Subtype"; "Test Subtype")
                {
                    BlankZero = true;
                    ApplicationArea = all;
                }
                field("Evaluation of Testing"; "Evaluation of Testing")
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