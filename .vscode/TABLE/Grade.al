/*table 50078 Grade
{
    Caption = 'Grade';
    DrillDownPageID = "Grades";
    LookupPageID = "Grades";

    fields
    {
        field(1; "Code"; Integer)
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Position Code"; Code[50])
        {
            Caption = 'Position Code';
        }
        field(3; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
        }
        field(7; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema";
        }
    }

    keys
    {
        key(Key1; "Code", "Position Code", "Position Description", "Org Shema")
        {
        }
        key(Key2; "Position Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code")
        {
        }
    }
}

*/