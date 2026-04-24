page 50071 "Contribution Posting Setup"
{
    Caption = 'Contribution Posting Setup';
    PageType = List;
    SourceTable = "Contribution Posting Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Additional Tax Code"; "Additional Tax Code")
                {
                }
                field("Wage Posting Group"; "Wage Posting Group")
                {
                }
                field(Account; Account)
                {
                }
                field("Bal. Account"; "Bal. Account")
                {
                }
                field("Transit Account"; "Transit Account")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

