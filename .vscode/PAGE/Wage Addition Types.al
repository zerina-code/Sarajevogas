page 50000 "Wage Addition Types"
{
    Caption = 'Wage Addition Types';
    PageType = List;
    SourceTable = "Wage Addition Type";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Calculation Type"; "Calculation Type")
                {
                    ApplicationArea = all;
                }
                field("Payment Type"; "Payment Type")
                { }
                field(Order; Order)
                {
                    ApplicationArea = all;

                }
                field(Meal; Meal)
                {
                    ApplicationArea = all;
                }
                field(Use; Use)
                {
                    ApplicationArea = all;
                }
                field(Regres; Regres)
                {
                    ApplicationArea = all;
                }
                field(Incentive; Incentive)
                {
                    ApplicationArea = all;
                }
                field(Bonus; Bonus)
                {
                    ApplicationArea = all;
                }
                field("Wage Increase/Decrease"; "Wage Increase/Decrease")
                {
                    ApplicationArea = all;
                }
                field("Work experience base"; "Work experience base")
                { ApplicationArea = all; }
                field("Include WVE"; "Include WVE") { }
                field("Default Amount"; "Default Amount")
                {
                    ApplicationArea = all;
                }
                field("Calculated on Brutto"; "Calculated on Brutto")
                {
                    ApplicationArea = all;
                }
                field("Calculated on Neto (Calc.)"; "Calculated on Neto (Calc.)")
                {
                    ApplicationArea = all;
                }
                field("Calculated on Neto (Base)"; "Calculated on Neto (Base)")
                {
                    ApplicationArea = all;
                }
                field("Calculate Experience"; "Calculate Experience")
                {
                    ApplicationArea = all;
                }
                field("Calculate Deduction"; "Calculate Deduction")
                {
                    ApplicationArea = all;
                }
                field(Taxable; Taxable)
                {
                    ApplicationArea = all;
                }
                field("Add. Taxable"; "Add. Taxable")
                {
                    ApplicationArea = all;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Additional;
                    Style = Strong;
                    StyleExpr = TRUE;
                    DrillDown = true;
                    Lookup = true;
                    trigger OndrillDown()
                    var
                        myInt: Integer;
                        Ts_knjizenja_s: Page TS_knjizenja_Wage;
                        Ts_knjizenja_r: Record TS_knjizenja;
                    begin
                        Ts_knjizenja_r.Reset();
                        Ts_knjizenja_r.SetFilter(vrnaloga, '%1', rec."Posting Group");
                        Ts_knjizenja_r.SetFilter(D_C, '%1', 'D');
                        Ts_knjizenja_s.SetTableView(Ts_knjizenja_r);
                        Ts_knjizenja_s.run;


                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        Ts_knjizenja_s: Page TS_knjizenja_Wage;
                        Ts_knjizenja_r: Record TS_knjizenja;
                    begin
                        Ts_knjizenja_r.Reset();
                        Ts_knjizenja_r.SetFilter(vrnaloga, '%1', rec."Posting Group");
                        Ts_knjizenja_r.SetFilter(D_C, '%1', 'D');
                        Ts_knjizenja_s.SetTableView(Ts_knjizenja_r);
                        Ts_knjizenja_s.run;


                    end;

                }
                field("G/L Balance Account No."; "G/L Balance Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Image = Star;
                    Importance = Additional;
                    Style = Strong;
                    StyleExpr = TRUE;
                    DrillDown = true;
                    Lookup = true;
                    trigger OndrillDown()
                    var
                        myInt: Integer;
                        Ts_knjizenja_s: Page TS_knjizenja_Wage;
                        Ts_knjizenja_r: Record TS_knjizenja;
                    begin
                        Ts_knjizenja_r.Reset();
                        Ts_knjizenja_r.SetFilter(vrnaloga, '%1', rec."Posting Group");
                        Ts_knjizenja_r.SetFilter(D_C, '%1', 'C');
                        Ts_knjizenja_s.SetTableView(Ts_knjizenja_r);
                        Ts_knjizenja_s.run;


                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        Ts_knjizenja_s: Page TS_knjizenja_Wage;
                        Ts_knjizenja_r: Record TS_knjizenja;
                    begin
                        Ts_knjizenja_r.Reset();
                        Ts_knjizenja_r.SetFilter(vrnaloga, '%1', rec."Posting Group");
                        Ts_knjizenja_r.SetFilter(D_C, '%1', 'C');
                        Ts_knjizenja_s.SetTableView(Ts_knjizenja_r);
                        Ts_knjizenja_s.run;


                    end;
                }
                field("Bonus and material right"; "Bonus and material right")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Other bonus from brutto"; "Other bonus from brutto")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Add Hours"; "Add Hours")
                {
                    ApplicationArea = all;

                }
                field(Weekend; Weekend)
                { }
                field("Hours Sick Leave"; "Hours Sick Leave")
                {
                    ApplicationArea = all;

                }
                field("Hour Pool MIP"; "Hour Pool MIP")
                {
                    ApplicationArea = all;
                }
                field("Sick Leave MIP"; "Sick Leave MIP")
                {
                    ApplicationArea = all;
                }
                field("RAD - 1G hours"; "RAD - 1G hours")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("RAD-1 Wage Excluded"; "RAD-1 Wage Excluded")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("Bruto (RAD)"; "Bruto (RAD)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sick Leave Brutto"; "Sick Leave Brutto") { ApplicationArea = all; }

            }
        }
    }

    actions
    {
    }

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
    end;
}

