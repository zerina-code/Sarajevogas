/*page 50007 "Candidate Computer Skills List"
{
    Caption = 'Candidate Computer Skills List';
    PageType = List;
    SourceTable = "Candidate Computer Skills";
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
                field("Computer Knowledge Code"; "Computer Knowledge Code")
                {
                    ApplicationArea = all;
                }
                field("Computer Knowledge Description"; "Computer Knowledge Description")
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