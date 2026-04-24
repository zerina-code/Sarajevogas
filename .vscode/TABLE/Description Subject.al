/*table 50238 "Description Subject"
{
    Caption = 'Description Subject';
    DrillDownPageID = "Description Subject";
    LookupPageID = "Description Subject";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; "Description Subject"; Text[50])
        {
            Caption = 'Description Subject';
        }
    }

    keys
    {
        key(Key1; "No.", "Description Subject")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Description Subject")
        {
        }
    }
}

*/