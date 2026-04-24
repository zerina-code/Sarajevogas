table 50020 "Tax Per Employee"
{
    // //

    Caption = 'Tax Per Employee';

    fields
    {
        field(1; "Wage Header No."; Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; "Wage Calculation No."; Code[20])
        {
            Caption = 'Wage Calculation No.';
        }
        field(6; "Tax Code"; Code[10])
        {
            Caption = 'Tax Code';
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(15; "Contribution Category Code"; Code[20])
        {
            Caption = 'Additional Tax Category Code';
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(25; "Added Tax Per City Amount"; Decimal)
        {
            Caption = 'Added Tax Per City Amount';
        }
        field(30; "Tax Number"; Code[10])
        {
            Caption = 'Tax Number';
        }
        field(31; "Canton Code"; Code[10])
        {
            Caption = 'Canton Code';
        }
        field(32; Percentage; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Tax Class".Percentage WHERE(Code = FIELD("Tax Code")));

        }
        field(33; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(34; D; Code[20])
        {
            CalcFormula = Lookup("Contribution Per Employee"."Global Dimension 1 Code" WHERE("Employee No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(198; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(199; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(216; "JIB Contributes"; Text[30])
        {
            Caption = 'JIB Contributes';
        }
        field(217; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(50371; "JIB Contributes DL"; Text[30])
        {
        }
        field(503568; "Org Jed"; Code[10])
        {
        }
        field(503569; GF; Code[10])
        {
        }
        field(503570; "Payment date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Wage Header No.", "Wage Calculation No.", "Contribution Category Code")
        {
        }
        key(Key2; "Tax Code")
        {
        }
        key(Key3; "Employee No.", "Tax Number")
        {
        }
        key(Key4; "Tax Number")
        {
        }
        key(Key5; "Contribution Category Code")
        {
            SumIndexFields = Amount, "Added Tax Per City Amount";
        }
        key(Key6; "Wage Header No.", "Entry No.", "Tax Number")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Wage Header No.", "Entry No.", "Canton Code", "Tax Number")
        {
        }
    }

    fieldgroups
    {
    }
}

