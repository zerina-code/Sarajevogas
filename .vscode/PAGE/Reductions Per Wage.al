page 50024 "Reductions Per Wage"
{
    Caption = 'Reductions Per Wage';
    PageType = List;
    SourceTable = "Reduction per Wage";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Reduction No."; "Reduction No.")
                {
                }
                field("Wage Header No."; "Wage Header No.")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }

                field(Amount; Amount)
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Date of Calculation"; "Date of Calculation")
                {
                }
                field(Type; Type)
                {
                }
                field("Reduction Name"; "Reduction Name")
                {

                }
                field("Bank Account No."; "Bank Account No.")
                { }
                field("First Name"; "First Name")
                {

                }
                field("Last Name"; "Last Name")
                { }
                field("Reduction Name 2"; "Reduction Name 2") { }
                field("Party No."; "Party No.") { }
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

