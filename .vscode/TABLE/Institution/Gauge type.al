/*table 50047 "Gauge Type"
{
    Caption = 'Gauge Type';
    DrillDownPageId = "Gauge Types";
    LookupPageId = "Gauge Types";
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

    }

    fieldgroups
    {
    }
}

*/