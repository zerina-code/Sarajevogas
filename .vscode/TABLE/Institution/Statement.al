/*table 50155 "Statement"
{
    Caption = 'Statement';
    DrillDownPageId = Statements;
    LookupPageId = Statements;
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