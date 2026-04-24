/*page 50232 "Cand. Foreign Language List"
{
    Caption = 'Cand. Foreign Language List';
    PageType = List;
    SourceTable = "Candidate Foreign Language";
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
                field("Language Code"; "Language Code")
                {
                    ApplicationArea = all;
                }
                field("Language Name"; "Language Name")
                {
                    ApplicationArea = all;
                }
                field("Language Level"; "Language Level")
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