page 50106 "Wage Posting Groups"
{
    Caption = 'Wage Posting Groups';
    PageType = List;
    SourceTable = "Wage Posting Groups";
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
                field("Temporary Contract"; "Temporary Contract")
                {
                }
                field("Temporary Contract Type"; "Temporary Contract Type")
                {
                }
                field("Tax Account"; "Tax Account")
                {
                }
                field("Tax Bal. Account"; "Tax Bal. Account")
                {
                }
                field("Tax Transit Account"; "Tax Transit Account")
                {
                }
                field("Netto Account"; "Netto Account")
                {
                }
                field("Netto Bal. Account"; "Netto Bal. Account")
                {
                }
                field("Netto Transit Account"; "Netto Transit Account")
                {
                }
                field("Transport Account"; "Transport Account")
                {
                }
                field("Transport Bal. Account"; "Transport Bal. Account")
                {
                }
                field("Transport Transit Account"; "Transport Transit Account")
                {
                }
                field("Meal Account to pay"; "Meal Account to pay")
                {
                }
                field("Meal Bal. Account to pay"; "Meal Bal. Account to pay")
                {
                }
                field("Meal Transit Account"; "Meal Transit Account")
                {
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

