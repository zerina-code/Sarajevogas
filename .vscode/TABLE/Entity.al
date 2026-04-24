table 50005 Entity
{
    Caption = 'Entity';
    DrillDownPageID = Entities;
    LookupPageID = Entities;

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
        field(3; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;

        }
    }

    keys
    {
        key(Key1; "Code")
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

