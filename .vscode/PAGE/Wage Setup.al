page 50016 "Wage Setup"
{
    Caption = 'Wage Setup';
    CardPageID = "Wage Setup";
    // DelayedInsert = true;
    // DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = Card;
    // Permissions = TableData 50016 = rimd;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Wage Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Average Yearly Hour Pool"; "Average Yearly Hour Pool")
                {
                }
                field("Wage Base"; "Wage Base")
                {
                }
                field("Average Salary FBIH"; "Average Salary FBIH")
                { }
                field("Average coefficient statute"; "Average coefficient statute")
                { }
                field("Work Experience Basis"; "Work Experience Basis")
                {
                    Visible = false;
                }

                field("Base Personal Deduction"; "Base Personal Deduction")
                {
                    Visible = false;
                }
                field("Base Tax Deduction"; "Base Tax Deduction")
                {

                }
                field("General Coefficient"; "General Coefficient")
                {
                    Visible = false;
                }
                field("Type Of Work Percentage Calc."; "Type Of Work Percentage Calc.")
                {
                }
                field("Work Percentage"; "Work Percentage")
                {
                }
                field("Max Work Experience"; "Max Work Experience")
                {

                }
                field("Year of Experience - min"; "Year of Experience - min")
                { }

                field("Export Report Path"; "Export Report Path")
                {
                }
                field("RS Municipality Code"; "RS Municipality Code")
                {
                    Visible = false;
                }
            }

            group(MealSetup)
            {
                Caption = 'Meal';
                field("Meal Code FBIH"; "Meal Code FBIH")
                {
                    ApplicationArea = all;
                }
                field(Meal; Meal)
                {
                    Caption = 'Meal';
                    ApplicationArea = all;
                }
                field("Meal Taxable FBiH Untaxable"; "Meal Taxable FBiH Untaxable")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meal Taxable FBiH "; "Meal Taxable FBiH ")
                {
                    ApplicationArea = all;
                }
                field("Meal Code FBiH Taxable"; "Meal Code FBiH Taxable")
                {
                    ApplicationArea = all;
                }
                field("Meal Code BD Untaxable"; "Meal Code BD Untaxable")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meal Code BD"; "Meal Code BD")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meal Taxable BD"; "Meal Taxable BD")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meal Nontaxable BD"; "Meal Nontaxable BD")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meal Code RS"; "Meal Code RS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meal Total RS"; "Meal Total RS")
                {
                    Caption = 'Meal Total RS';
                    ApplicationArea = all;
                    Visible = false;
                }
            }

            group("Payment Orders")
            {
                Caption = 'Payment Orders';
                field("Unemployment Federation"; "Unemployment Federation")
                {
                }
                field("Unemployment Canton"; "Unemployment Canton")
                {
                }
                field("Health Federation"; "Health Federation")
                {
                }
                field("Health Canton"; "Health Canton")
                {
                }
                field("Canton Sick-Leave Amount"; "Canton Sick-Leave Amount")
                {
                    Visible = false;

                }
                field("Maximum hours for sick wage"; "Maximum hours for sick wage")
                {
                    Visible = false;

                }
                field("Canton Amount"; "Canton Amount")
                {
                    ApplicationArea = all;
                }

            }
            group("Chamber Fee")
            {
                Caption = 'Chamber fee';
                field("Brutto Rate"; "Brutto Rate")
                {
                }
                field("Chamber Rate(%)"; "Chamber Rate(%)")
                {
                }
                field("Chamber Fee Contribution Code"; "Chamber Fee Contribution Code")
                {
                }
            }
            group("Invalid Fund")
            {
                Caption = 'Invalid Fund';
                field("Invalid Fund Contribution Code"; "Invalid Fund Contribution Code")
                {
                }
                field("No. Of Employees"; "No. Of Employees")
                {
                }
                field("Invaalid Fund %"; "Invaalid Fund %")
                {
                }
            }
            group(Codes)
            {
                Caption = '13ta plata';
                field("Additional Wage Code"; "Additional Wage Code")
                {

                }
                field("HAlf Additional Wage Code"; "HAlf Additional Wage Code")
                {

                }
            }
            group(Dates)
            {
                Caption = 'Codes';
                field("Day Unit of Measure"; "Day Unit of Measure")
                {
                }
                field("Hour Unit of Measure"; "Hour Unit of Measure")
                {
                }
                field("Holiday Code"; "Holiday Code")
                {
                }
                field("Holiday Description"; "Holiday Description")
                {
                }
                field("Workday Code"; "Workday Code")
                {
                }
                field("Workday Description"; "Workday Description")
                {
                }
                /*field("Overtime Code"; "Overtime Code")
                {
                }*/
                field("Hours in Day"; "Hours in Day")
                {
                }
                field("Wage Calendar Code"; "Wage Calendar Code")
                {
                }
                field("Wage Amount Code"; "Wage Amount Code")
                {
                }
                field("Brutto Calculation Code"; "Brutto Calculation Code")
                {
                }
                field("Transport No. Series"; "Transport No. Series")
                {
                }
                field("Travel Order Nos."; "Travel Order Nos.")
                {
                }
                field("Reduction No. Series"; "Reduction No. Series")
                {
                }
                field("Meal No. Series"; "Meal No. Series")
                {
                }

                field("Wage Journal Template"; "Wage Journal Template")
                {
                    Visible = true;

                }
                field("Wage Batch Name"; "Wage Batch Name")
                {
                    Visible = true;

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

