table 50039 "Meal Line Temp"
{
    Caption = 'Meal Line Temp';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Line No."; Code[20])
        {
            Caption = 'Line No.';
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(15; Workdays; Integer)
        {
            Caption = 'Workdays';
        }
        field(20; "Basis For Meal"; Decimal)
        {
            Caption = 'Basis for Meal';
        }
        field(25; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(30; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(31; "Leather-Textile Workdays"; Decimal)
        {
            Caption = 'Leather-Textile Workdays';
        }
        field(32; "Brutto Amount"; Decimal)
        {
        }
        field(33; "Netto Before Tax"; Decimal)
        {
        }
        field(34; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConCat: Record "Contribution Category";
}

