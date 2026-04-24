page 50009 "Wage/Reduction bank accounts"
{
    Caption = 'Wage/Reduction bank accounts';
    PageType = List;
    SourceTable = "Wage/Reduction Bank Accounts";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; "Bank Code")
                {
                }
                field("Account No"; "Account No")
                {
                    Visible = false;
                }
                field("Fax No."; "Fax No.")
                {
                    Visible=false;
                }
                field("No."; "No.")
                {
                    Editable = true;

                }
                field(n; n)
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

