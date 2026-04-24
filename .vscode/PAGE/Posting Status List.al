/*page 50106 "Posting Status List"
{
    Caption = 'Posting Status List';
    PageType = List;
    SourceTable = "Posting Status";
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
                }
                field(Status; Status)
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