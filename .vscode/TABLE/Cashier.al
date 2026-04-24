table 50158 "Cashier"
{
    Caption = 'Cashier';
    DrillDownPageID = Cashier;
    LookupPageID = Cashier;

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
    }


    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}