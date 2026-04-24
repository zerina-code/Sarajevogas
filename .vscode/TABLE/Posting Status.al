/*table 50137 "Posting Status"
{
    Caption = 'Posting Status';
    DrillDownPageID = "Posting Status List";
    LookupPageID = "Posting Status List";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No';
        }
        field(2; Status; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "No.", Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Status)
        {
        }
    }
}

*/