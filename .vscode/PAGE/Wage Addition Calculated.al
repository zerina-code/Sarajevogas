page 50150 "Wage Addition Calculated"
{
    Caption = 'Wage Addition';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Wage Addition";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Full Name"; "First Name" + ' ' + "Last Name")
                {
                    Caption = 'Ime i prezime';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {

                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field(Use; Use)
                {
                    ApplicationArea = all;
                }

                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Amount to Pay"; "Amount to Pay")
                {
                    ApplicationArea = all;
                }
                field(Taxable; Taxable)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("PIO From"; "PIO From")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Health From"; "Health From")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Unemployment From"; "Unemployment From")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Total From"; "Total From")
                {
                    Editable = false;
                    ApplicationArea = all;

                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("PIO On"; "PIO On")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Health On"; "Health On")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Unemployment On"; "Unemployment On")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Total On"; "Total On")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Tax; Tax)
                {

                    Editable = false;
                    ApplicationArea = all;
                }
                field(Brutto; Brutto)
                {
                    Editable = false;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Water Fee"; "Water Fee")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Disaster Fee"; "Disaster Fee")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Total Cost"; "Total Cost")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Year of Wage"; "Year of Wage")
                {
                    ApplicationArea = all;
                }
                field("Month of Wage"; "Month of Wage")
                {
                    ApplicationArea = all;
                }

                field("Payment Date"; "Payment Date")
                {
                    ApplicationArea = all;
                }
                field("Payment Year"; "Payment Year")
                {
                    ApplicationArea = all;
                }
                field("Payment Moth"; "Payment Moth")
                {
                    ApplicationArea = all;
                }
                field("Wage Header No."; "Wage Header No.")
                {
                    ApplicationArea = all;
                }
                field("Wage Header Entry No."; "Wage Header Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Locked; Locked)
                {
                    ApplicationArea = all;
                }
                field(Calculated; Calculated)
                {
                    ApplicationArea = all;
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

    trigger OnInit()
    begin
        //WH.FINDFIRST;
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
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        MonthFilter := DATE2DMY(WORKDATE, 2);
        YearFilter := DATE2DMY(WORKDATE, 3);
        SETFILTER("Wage Header No.", '<>%1', '');
        /*
        SetFilters;*/

    end;

    var
        Name: Text[250];
        Employee: Record "Employee";
        YearFilter: Integer;
        MonthFilter: Integer;
        WageSetup: Record "Wage Setup";
        WH: Record "Wage Header";
        WagePrecalculation: Codeunit "Wage Precalculation";
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        HasError: Boolean;
        CalcWage: Codeunit "Wage Calculation";
        WA: Record "Wage Addition";
        Municipality: Record "Municipality";
        // Txt005:"";
        CloseWageCalc: Codeunit "Close Wage Calculation";

    procedure SetFilters()
    begin
        /*Rec.FILTERGROUP(2);
        Rec.SETRANGE("Month of Wage",MonthFilter);
        Rec.SETRANGE("Year of Wage",YearFilter);
        Rec.FILTERGROUP(0);*/
        //IF Rec."Employee No." = '' THEN Rec.DELETE;
        //CurrForm.UPDATECONTROLS;

    end;
}

