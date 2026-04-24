/*table 50250 "Additional Responsibility"
{
    Caption = 'Additional Responsibility';
    DrillDownPageID = "Additional Responsibility";
    LookupPageID = "Additional Responsibility";

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(5; QuerySource; Integer)
        {
            Caption = 'QuerySource';
        }
    }

    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
    }
}

*/