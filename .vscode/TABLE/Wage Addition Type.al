table 50047 "Wage Addition Type"
{
    Caption = 'Wage Addition Type';
    DrillDownPageID = "Wage Addition Types";
    LookupPageID = "Wage Addition Types";


    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Percentage,Fixed';
            OptionMembers = Percentage,"Fixed";
        }
        field(5; "Calculated on Neto (Calc.)"; Boolean)
        {
            Caption = 'Calculated on Neto (Calc.)';
        }
        field(6; "Calculated on Neto (Base)"; Boolean)
        {
            Caption = 'Calculated on Neto (base)';
        }
        field(7; "Calculate Experience"; Boolean)
        {
            Caption = 'Calculate Experience';
        }
        field(101; Taxable; Boolean)
        {
            Caption = 'Taxable';
        }
        field(102; "Add. Taxable"; Boolean)
        {
            Caption = 'Add. Taxable';
        }
        field(103; "Default Amount"; Decimal)
        {
            Caption = 'Default Amount';
        }
        field(104; "G/L Account No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('D')));
            Caption = 'G/L Account No.';

        }
        field(105; "G/L Balance Account No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('C')));
            Caption = 'G/L Balance Account No.';

        }
        field(107; "Calculated Amount Brutto"; Decimal)
        {
        }
        field(108; Netto; Decimal)
        {
            Caption = 'Calculated Amount';
        }
        field(109; Tax; Decimal)
        {
        }
        field(110; "Contribution Category Code"; Code[10])
        {
        }
        field(111; Use; Boolean)
        {
            Caption = 'Use';
        }
        field(112; Regres; Boolean)
        {
        }
        field(113; "Transit Account No."; Code[10])
        {
            Caption = 'Transit Account No.';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(114; "Apportionment Account"; Code[10])
        {
            Caption = 'Apportionment Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(115; "Use Apportionment Account"; Boolean)
        {
            Caption = 'Use Apportionment Account';
        }
        field(116; Incentive; Boolean)
        {

            trigger OnValidate()
            begin
                IF Incentive THEN
                    "Incentive/Bonus" := TRUE
                ELSE
                    "Incentive/Bonus" := FALSE;
            end;
        }
        field(117; Meal; Boolean)
        {
            Caption = 'Meal';
        }
        field(118; "Calculated on Brutto"; Boolean)
        {
            Caption = 'Calculated on Neto (base)';
        }
        field(119; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = TS_knjizenja.vrnaloga;
        }
        field(120; "Wage Increase/Decrease"; Boolean)
        {
            Caption = 'Wage Increase/Decrease';
        }
        field(121; "Calculate Deduction"; Boolean)
        {
            Caption = 'Calculate Deduction';
        }
        field(122; Bonus; Boolean)
        {

            trigger OnValidate()
            begin
                IF Bonus THEN
                    "Incentive/Bonus" := TRUE
                ELSE
                    "Incentive/Bonus" := FALSE;
            end;
        }
        field(123; "Incentive/Bonus"; Boolean)
        {
        }
        field(124; "Bonus and material right"; Boolean)
        {
            Caption = 'Bonus and material right';
        }
        field(50024; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = ',Regular Work,Additional,Work Performance,Other Additional';
            OptionMembers = "<","Regular Work","Additional>","Work Performance","Other Additional";
        }

        field(125; "Other bonus from brutto"; Boolean)
        {
            Caption = 'Other bonus from brutto';
        }
        field(126; "Add Hours"; Boolean)
        {
            Caption = 'Add Hours';
        }
        field(127; "Hours Sick Leave"; Boolean)
        {
            Caption = 'Hours Sick Leave';
        }
        field(128; "Hour Pool MIP"; Boolean)
        {
            Caption = 'Hour Pool MIP';
        }
        field(129; "Sick Leave MIP"; Boolean)
        {
            Caption = 'Hours Sick Leave';
        }
        field(130; "RAD - 1G hours"; Boolean)
        {
            Caption = 'RAD - 1G hours';
        }
        field(131; "RAD 1 Dodaci"; Boolean)
        {
        }
        field(132; "RAD-1 Wage Excluded"; Boolean)
        {
        }
        field(133; "RAD-1 Wage Other"; Boolean)
        {
        }
        field(134; "Bruto (RAD)"; Boolean)
        {
            Caption = 'Bruto executed';
        }
        field(135; "Order"; Integer)
        {

            Caption = 'Order for Pay list';

        }
        field(136; "Meal add RAD"; Boolean)
        {
            Caption = 'Topli obrok - RAD';
        }
        field(137; "Work experience base"; Boolean)
        {
            Caption = 'Wage addition based on Work Experience';
        }
        field(138; "Weekend"; Boolean)
        {
            Caption = 'Dozvoljen unos vikendom';
        }
        field(139; "Sick Leave Brutto"; Boolean)
        {
            Caption = 'Ne ulazi u obračun bruto satnice za bolovanje';
        }
        field(140; "Include WVE"; Boolean)
        {
            Caption = 'Include WVE';
        }

    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConCat: Record "Contribution Category";
}

