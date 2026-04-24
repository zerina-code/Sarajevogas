/*table 50105 "Notes/Comments"
{
    Caption = 'Notes/Comments';
    DrillDownPageID = "Notes/Comments";
    LookupPageID = "Notes/Comments";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            TableRelation = "Work Duties Violation"."No.";
        }
        field(2; Type; Option)
        {
            Caption = 'Field';
            OptionCaption = ' ,Note 1,Note 2,Note 3,Note for execution';
            OptionMembers = " ","Note 1","Note 2","Note 3","Note for execution";
        }
        field(3; Note; Text[250])
        {
            Caption = 'Note 1';
        }
        field(4; "Note No."; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "No.", Type, "Note No.")
        {
        }
    }

    fieldgroups
    {

    }
}

*/