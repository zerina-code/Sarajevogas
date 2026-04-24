page 50097 "Wage Calculation Subform"
{
    Caption = 'Wage Entries';
    Editable = true;
    PageType = List;
    SourceTable = "Wage Calculation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Wage Header No."; "Wage Header No.")
                {
                }
                field("No."; "No.")
                {
                }
                field("Year of Wage"; "Year of Wage")
                {

                }
                field("Month Of Wage"; "Month Of Wage") { }
                field("Employee No."; "Employee No.")
                {
                    Editable = false;
                }
                field(EmployeeName; EmployeeName)
                {
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                }
                field("Employee Coefficient"; "Employee Coefficient")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field(Brutto; Brutto)
                {
                    Editable = false;
                }
                field("Wage Base"; "Wage Base")
                {

                }
                field("Position Coefficient for Wage"; "Position Coefficient for Wage")
                {

                }
                field("Net Wage"; "Net Wage")
                {

                    Editable = false;
                }
                field("Tax Deductions"; "Tax Deductions")
                {

                    Editable = false;
                }
                field(Tax; Tax)
                {
                    Editable = false;
                }
                field("Indirect Wage Addition Amount"; "Indirect Wage Addition Amount")
                {
                    Editable = false;
                }
                field("Net Wage After Tax"; "Net Wage After Tax")
                {

                    Editable = false;
                }
                field("Untaxable Wage"; "Untaxable Wage")
                {
                    Editable = false;
                }
                field("Final Net Wage"; "Final Net Wage")
                {

                    Editable = false;
                }
                field("Wage Reduction"; "Wage Reduction")
                {
                    Editable = false;
                }
                field(Payment; Payment)
                {
                    Editable = false;
                }
                field(Transport; Transport)
                {
                    Editable = false;
                }
                field("Meal to pay"; "Meal to pay")
                {
                    Editable = false;
                }
                field("Sick Leave-Company"; "Sick Leave-Company")
                {
                    Editable = false;
                }
                field("Sick Leave-Fund"; "Sick Leave-Fund")
                {
                    Editable = false;
                }
                field("Work Experience Percentage"; "Work Experience Percentage")
                {
                    Editable = false;
                }
                field("Experience Total"; "Experience Total")
                {
                    Editable = false;
                }
                field("Wage Type"; "Wage Type")
                {
                    Editable = false;
                }
                field("Individual Hour Pool"; "Individual Hour Pool")
                {
                    Editable = false;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Employee.GET("Employee No.") THEN
            EmployeeName := COPYSTR((Employee."First Name" + ' ' + Employee."Last Name"), 1, MAXSTRLEN(EmployeeName));
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF (Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::Regular) THEN
            ERROR(Text000)
        ELSE BEGIN
            ShowMessage := TRUE;
            IF Rec.MARK(TRUE) THEN BEGIN
                //   R_DeleteCalc.SETWC(Rec,ShowMessage);
                R_DeleteCalc.RUN();
            END;
        END;
        /*IF CONFIRM(Txt002,FALSE,Rec."Employee No.") THEN BEGIN
        IF Rec.MARK(TRUE) THEN
           REPORT.RUNMODAL(REPORT::"Delete Calculation by Employee",FALSE,FALSE,Rec);
        END;
        */

    end;

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
        Employee: Record "Employee";
        EmployeeName: Text[250];
        WC: Record "Wage Calculation";
        DeleteRec: Boolean;
        R_DeleteCalc: Report "Delete Calculation by Employee";
        ShowMessage: Boolean;
        Text000: Label 'You cant delete regular Wage Calculation!';
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

