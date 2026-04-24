table 50096 "Payment Type"
{
    Caption = 'Vrsta uplate';
    //  DrillDownPageID = "Payment Type";
    // LookupPageID = "Payment Type";
    Permissions = TableData "Payment Type" = irmd;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[300])
        {
            Caption = 'Description';
        }
        field(4; "Version Code"; Code[20])
        {
            Caption = 'Version Code';
        }
        field(7; "Level Code"; Integer)
        {
            Caption = 'Level Code';
        }
    }


    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}