page 50045 "Contribution Connections"
{
    Caption = 'Contribution Connections';
    PageType = List;
    SourceTable = "Contribution Category Conn.";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contribution Code"; "Contribution Code")
                {
                }
                field(Percentage; Percentage)
                {
                }
                field("Category Code"; "Category Code")
                {
                }
                field(Blocked; Blocked) { }
                field("Average Wage"; "Average Wage") { }
                field("Over Brutto"; "Over Brutto")
                {

                }
                field("From Brutto"; "From Brutto")
                { }

                field("Calculated in Total Brutto"; "Calculated in Total Brutto")
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

