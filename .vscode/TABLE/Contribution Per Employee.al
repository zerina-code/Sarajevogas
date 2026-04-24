table 50019 "Contribution Per Employee"
{
    Caption = 'Contribution per Employee';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Wage Header No."; Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(4; "Wage Calc No."; Code[20])
        {
            Caption = 'Wage Calc No.';
        }
        field(5; "Contribution Code"; Code[10])
        {
            Caption = 'Additional Tax Code';
            TableRelation = Contribution.Code;
        }
        field(6; "Amount From Wage"; Decimal)
        {
            Caption = 'Amount From Wage';
        }
        field(7; "Amount Over Wage"; Decimal)
        {
            Caption = 'Amount Over Wage';
        }
        field(8; Basis; Decimal)
        {
            Caption = 'Basis';
        }
        field(9; "Amount Over Neto"; Decimal)
        {
            Caption = 'Amount Over Neto';
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(199; "Amount On Wage"; Decimal)
        {
            Caption = 'Amount On Wage';
            FieldClass = Normal;
        }
        field(200; Percentage; Decimal)
        {
        }
        field(201; "Reported Amount From Wage"; Decimal)
        {
        }
        field(202; "Reported Amount On Wage"; Decimal)
        {
        }
        field(203; "Contribution Category Code"; Code[10])
        {
            Caption = 'Additional Tax Category Code';
            TableRelation = "Contribution Category".Code;
        }
        field(204; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(205; "Reported Amount On Netto"; Decimal)
        {
        }
        field(206; M; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Municipality Code for salary" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Šifra opštine za platu';

        }
        field(207; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(208; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(209; "Tax Number"; Code[10])
        {
            Caption = 'Tax Number';
        }
        field(210; Special; Boolean)
        {
        }
        field(211; "Special Contribution Amount"; Decimal)
        {
        }
        field(212; M2; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Municipality Code CIPS" WHERE("No." = FIELD("Employee No.")));
            Caption = 'CIPS';

        }
        field(213; "Entity Code CIPS"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Entity Code CIPS" WHERE("No." = FIELD("Employee No.")));

        }
        field(214; "Entity Code Org"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Org Entity Code" WHERE("No." = FIELD("Employee No.")));

        }
        field(215; Incentive; Boolean)
        {
        }
        field(216; "JIB Contributes"; Text[30])
        {
            Caption = 'JIB Contributes';
        }
        field(217; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(218; "JIB Contributes DL"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Wage Header No.", "Employee No.", "Wage Calc No.", "Contribution Code", Incentive)
        {
            SumIndexFields = "Amount From Wage", "Amount Over Wage", "Amount Over Neto", "Reported Amount From Wage";
        }
        key(Key2; "Contribution Code")
        {
            SumIndexFields = "Amount From Wage", "Amount Over Wage", "Amount Over Neto", "Reported Amount From Wage";
        }
        key(Key3; "Wage Header No.", "Entry No.", "Contribution Code", "Employee No.")
        {
            SumIndexFields = "Amount From Wage", "Amount Over Wage", "Amount Over Neto", "Reported Amount From Wage";
        }
        key(Key4; "Wage Header No.", "Entry No.", "Contribution Code", "Employee No.", Calculated)
        {
            SumIndexFields = "Amount From Wage", "Amount Over Wage", "Amount Over Neto", "Reported Amount From Wage";
        }
        key(Key5; "Wage Calc No.")
        {
        }
    }

    fieldgroups
    {
    }
}

