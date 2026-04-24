table 50092 "Geo. Activity Type"
{
    Caption = 'Geo. Activity Type';
    DrillDownPageId = "Geo. Activity Types";
    LookupPageId = "Geo. Activity Types";
    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Code, Description)
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            Unique = true;
        }
    }
}