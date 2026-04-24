table 50035 "Transport Line"
{
    Caption = 'Transport Line';

    fields
    {
        field(1;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            Description = 'Primary Key pt 1-Transport Header No.';
        }
        field(5;"Line No.";Code[20])
        {
            Caption = 'Line No.';
            Description = 'Primary Key pt 2';
        }
        field(10;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
        }
        field(15;Workdays;Integer)
        {
            Caption = 'Workdays';
            Description = 'Workdays at work in month-Not currently used-intended for payment of transport if not at work full month';
        }
        field(20;"Basis For Transport";Decimal)
        {
            Caption = 'Basis for Transport';
            Description = 'Basis for transport per Post Codes table';
        }
        field(25;Amount;Decimal)
        {
            Caption = 'Amount';
            Description = 'Actual amount paid-currently same as basis,if workdays used it is different';
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

