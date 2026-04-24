table 50036 "Transport Line Temp"
{
    Caption = 'Transport Line Temp';

    fields
    {
        field(1;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(5;"Line No.";Code[20])
        {
            Caption = 'Line No.';
        }
        field(10;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
        }
        field(15;Workdays;Integer)
        {
            Caption = 'Workdays';
        }
        field(20;"Basis For Transport";Decimal)
        {
            Caption = 'Basis for Transport';
        }
        field(25;Amount;Decimal)
        {
            Caption = 'Amount';
        }
        field(30;Calculated;Boolean)
        {
            Caption = 'Calculated';
        }
        field(32;"Brutto Amount";Decimal)
        {
        }
        field(33;"Netto Before Tax";Decimal)
        {
        }
        field(34;"Wage Calculation Entry No.";Code[20])
        {
            Caption = 'No.';
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

