table 50124 "Citizenship Description"
{
    Caption = 'Citizenship Description';
    DrillDownPageID = "Citizenship Description";
    LookupPageID = "Citizenship Description";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50000; "Order"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

