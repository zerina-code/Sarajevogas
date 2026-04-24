/*table 50154 "Status Of The Case"
{
    Caption = 'Status Of The Case';
    DrillDownPageID = "Status Of The Case List";
    LookupPageID = "Status Of The Case List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; "Status Of The Case"; Text[60])
        {
            Caption = 'Status Of The Case';
        }
    }

    keys
    {
        key(Key1; "No.", "Status Of The Case")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Status Of The Case")
        {
        }
    }
}
*/
