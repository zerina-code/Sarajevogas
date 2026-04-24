/*ĐK nadležne institucije table 50225 "Competent Authority"
{
    Caption = 'Competent Authority';
    DrillDownPageID = "Competent Authority List";
    LookupPageID = "Competent Authority List";

    fields
    {
        field(1; "Category Name"; Text[100])
        {
            Caption = 'Category Name';
            TableRelation = "Category Disciplinary Measure".Name;
        }
        field(2; "Competent Authority Name"; Text[100])
        {
            Caption = 'Competent Authority Name';
        }
    }

    keys
    {
        key(Key1; "Category Name", "Competent Authority Name")
        {
        }
    }

    fieldgroups
    {
    }
}

*/