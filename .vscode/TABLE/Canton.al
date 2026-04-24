table 50007 Canton
{
    Caption = 'Canton';
    DrillDownPageID = Cantons;
    LookupPageID = Cantons;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }
        field(4; "For Calculation"; Decimal)
        {
        }
        field(5; "Canton No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Entity Code")
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

