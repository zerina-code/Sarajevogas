page 50026 "Reduction types"
{
    Caption = 'Reduction types';
    PageType = List;
    SourceTable = "Reduction Types";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(AmountIsPercentage; AmountIsPercentage)
                {
                }
                field(AmountWithoutLimit; AmountWithoutLimit)
                {
                    Caption = 'Permanent reduction';
                }
                field("Separate Payment"; "Separate Payment")
                {
                    Visible = true;
                }
                field("Reduction Type"; "Reduction Type")
                { }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = all;
                }

                field("G/L Account"; "G/L Account")
                {
                    Visible = true;
                }
                field("Bal. G/L Account"; "Bal. G/L Account")
                {
                }
                field("Transit  Account"; "Transit  Account")
                {
                    Visible = false;
                }
                field("Transit  Account 2"; "Transit  Account 2")
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

