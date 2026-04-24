/*table 50112 "Disability Level"
{
    Caption = 'Disability Level';
    DrillDownPageID = "Disability Level";
    LookupPageID = "Disability Level";

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
        field(3; "Level of Disability"; Text[10])
        {
            Caption = 'Level of Disability';
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
        key(Key2; Description)
        {
        }
        key(Key3; "Level of Disability")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Level of Disability")
        {
        }
    }
}

*/