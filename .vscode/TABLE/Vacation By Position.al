/*table 50240 "Vacation By Position"
{
    // -

    Caption = 'Vacation By Position';

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            TableRelation = Position.Code;
        }
        field(2; "Maximum Vacation Days"; Integer)
        {
            Caption = 'Maximum Vacation Days';
        }
    }

    keys
    {
        key(Key1; "Position Code")
        {
        }
    }

    fieldgroups
    {
    }
}

*/