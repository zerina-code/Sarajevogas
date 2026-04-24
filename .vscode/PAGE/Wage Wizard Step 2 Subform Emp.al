page 50036 "Wage Wizard Step 2 Subform Emp"
{
    Caption = 'Wage Wizard Step 2 Subform Emp';
    PageType = ListPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field(ForCalculation; "For Calculation")
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
        Absences: Record "Employee Absence";
        Step2: Page "Wage Wizard Step 2";
        StartDate: Date;
        EndDate: Date;
        AbsenceFill: Codeunit "Absence Fill";
        Header: Record "Wage Header";
        Setup: Record "Wage Setup";
        WCType: Option Normal,"Fixed Add","Average Add","Average Coefficient Add";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure FilterMe()
    begin

        Rec.RESET;
        Rec.SETFILTER("For Calculation", '%1', TRUE);
        CurrPage.UPDATE(TRUE);
    end;

    procedure UnfilterMe()
    begin
        Rec.RESET;
        CurrPage.UPDATE(TRUE);
    end;

    procedure FilterMeRound()
    begin
        Rec.SETFILTER("For Calculation", '%1', TRUE);
        CurrPage.UPDATE(TRUE);
    end;

    procedure SetWCType(var WCT: Option Normal,"Fixed Add","Average Add","Average Coefficient Add")
    begin
        /*ecWCType := WCT;
        IF WCType = WCType::Normal THEN BEGIN
         CurrPage.ForCalculation.Visible := TRUE;
        END
        ELSE BEGIN
         CurrPage.ForCalculation.Visible := FALSE;
        END;
        CurrPage.UPDATE(TRUE);*/

    end;
}

