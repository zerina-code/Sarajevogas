/*table 50248 "Award Category"
{
    Caption = 'Award Category';
    DrillDownPageID = "Award Category List";
    LookupPageID = "Award Category List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; Category; Code[20])
        {
            Caption = 'Category No.';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(Key1; Category)
        {
        }
    }

    fieldgroups
    {
    }
}

*/