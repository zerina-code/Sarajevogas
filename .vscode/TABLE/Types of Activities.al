/*table 50176 "Types Of Activities"
{
    Caption = 'Types Of Activities';
    DrillDownPageID = "Types Of Activities";
    LookupPageID = "Types Of Activities";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
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

*/