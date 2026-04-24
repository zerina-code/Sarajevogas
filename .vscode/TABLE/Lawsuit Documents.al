/*table 50095 "Lawsuit Documents"
{
    Caption = 'Lawsuit Documents';
    DrillDownPageID = "Lawsuit Document List";
    LookupPageID = "Lawsuit Document List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; Note; Text[250])
        {
            Caption = 'Note';
        }
        field(3; "Document Template"; Integer)
        {
            Caption = 'Document Template';
        }
        field(4; "Lawsuit No."; Integer)
        {
            Caption = 'Internal ID';
            TableRelation = "Work Duties Violation"."No.";
        }
        field(5; "Insert Date"; Date)
        {
            Caption = 'Insert Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Lawsuit No.", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

*/