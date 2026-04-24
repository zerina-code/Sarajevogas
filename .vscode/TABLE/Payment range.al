/*table 50119 "Payment range"
{
    Caption = 'Payment range';

    fields
    {
        field(1; "Pay Grade"; Integer)
        {
            Caption = 'Pay Grade';
        }
        field(2; "Min Region"; Decimal)
        {
            Caption = 'Minimal payment';
        }
        field(3; "Mid Region"; Decimal)
        {
            Caption = 'Mid region';
        }
        field(4; "Max Region"; Decimal)
        {
            Caption = 'Max Region';
        }
        field(5; "Min Region II"; Decimal)
        {
        }
        field(6; "Mid Region II"; Decimal)
        {
        }
        field(7; "Max Region II"; Decimal)
        {
        }
        field(8; Region; Integer)
        {
            Caption = 'Region';
        }
    }

    keys
    {
        key(Key1; "Pay Grade", Region)
        {
        }
    }

    fieldgroups
    {
    }
}

*/