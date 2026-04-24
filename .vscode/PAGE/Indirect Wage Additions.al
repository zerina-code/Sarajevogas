/*ĐK page 50035 "Indirect Wage Additions"
{
    Caption = 'Indirect wage additions';
    PageType = List;
    SourceTable = "Indirect Wage Addition";

    layout
    {
        area(content)
        {
            repeater(Group2)
            {
                field("Year Wage"; YearFilter)
                {
                    Caption = 'Year Wage';
                }
                field("Month Wage"; MonthFilter)
                {
                    Caption = 'Month Wage';
                }
            }
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                }
                field("Indirect Wage Addition Type"; "Indirect Wage Addition Type")
                {
                }
                field(Amount; Amount)
                {
                }
                field(Description; Description)
                {
                }
                field(Locked; Locked)
                {
                }
                field("Wage Header No."; "Wage Header No.")
                {
                }
                field("Wage Header Entry No."; "Wage Header Entry No.")
                {
                }
                field("Year of Wage"; "Year of Wage")
                {
                }
                field("Month of Wage"; "Month of Wage")
                {
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
            Name := Employee."Last Name" + ' ' + Employee."First Name"
        ELSE
            Name := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Month of Wage" := MonthFilter;
        "Year of Wage" := YearFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Name := '';
    end;

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end

        MonthFilter := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
        YearFilter := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);

        SetFilters;
    end;

    var
        Name: Text[250];
        Employee: Record "Employee";
        YearFilter: Integer;
        MonthFilter: Integer;
        WageSetup: Record "Wage Setup";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure SetFilters()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Month of Wage", MonthFilter);
        Rec.SETRANGE("Year of Wage", YearFilter);
        Rec.FILTERGROUP(0);
        //IF Rec."Employee No." = '' THEN Rec.DELETE;
        //CurrForm.UPDATECONTROLS;
    end;
}

*/