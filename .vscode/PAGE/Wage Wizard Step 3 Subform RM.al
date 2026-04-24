page 50038 "Wage Wizard Step 3 Subform RM"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Subform for Wage Wizard Step 3- Reduction table
    // 
    // //Functionality:
    // //View Reduction lines

    Caption = 'Wage Wizard Step 3 Subform RM';
    PageType = ListPart;
    SourceTable = "Reduction";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Reduction Amount"; "Reduction Amount")
                {
                }
                field("Paid Amount"; "Paid Amount")
                {
                }
                field("Payment Start"; "Payment Start")
                {
                }
                field(Description; Description)
                {
                }
                field(Status; Status)
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

