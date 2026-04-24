/*table 50250 "Designer"
{
    Caption = 'Designer';
    DrillDownPageId = Designers;
    LookupPageId = Designers;
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

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
        key(Key1; "Code", Description)
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