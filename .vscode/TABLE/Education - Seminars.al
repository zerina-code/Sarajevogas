/*table 50237 "Education - Seminars"
{
    Caption = 'Education - Seminars';
    DrillDownPageID = "Education - Seminars List";
    LookupPageID = "Education - Seminars List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Serial Number"; Integer)
        {
            Caption = 'Serial number';
            Editable = false;
            TableRelation = Candidates."Serial Number";
        }
    }

    keys
    {
        key(Key1; "No.", Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description)
        {
        }
    }
}
*/
