page 50037 "Wage Wizard Step 2 Subform Abs"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Subform for Wage Wizard step 2-add non-regular work hours for employees
    // 
    // //Functionality:
    // //Contains filtering functions that can be called from the main form

    Caption = 'Wage Wizard Step 2 Subform Abs';
    PageType = ListPart;
    SourceTable = "Employee Absence";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                }
                field("From Date"; "From Date")
                {
                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("To Date"; "To Date")
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
        Employee: Record "Employee";
        StartDate: Date;
        EndDate: Date;
        AbsenceFill: Codeunit "Absence Fill";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure RefreshMe()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    procedure FilterMe(EmployeeNo: Code[20]; StartDate: Date; EndDate: Date)
    begin
        Rec.SETRANGE("From Date", StartDate, EndDate);
        Rec.SETRANGE("Employee No.", EmployeeNo);
        CurrPage.UPDATE(TRUE);
    end;
}

