table 50028 "Contribution Per Employee Temp"
{
    Caption = 'Contribution per Employee Temp';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
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
            Description = 'Actual basis used for calculating AT';
        }
        field(9; "Amount Over Neto"; Decimal)
        {
            Caption = 'Amount From Neto';
        }
        field(10; "Contribution Code"; Code[10])
        {
            Caption = 'Contribution Code';
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
        key(Key1; "Employee No.", "Wage Calc No.", "Contribution Code", Incentive)
        {
        }
        key(Key2; "Contribution Code")
        {
        }
        key(Key3; "Wage Header No.", "Entry No.", "Contribution Code", "Employee No.")
        {
            SumIndexFields = "Amount From Wage", "Amount Over Wage", "Amount Over Neto";
        }
    }

    fieldgroups
    {
    }
}

