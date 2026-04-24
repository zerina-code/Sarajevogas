table 50174 "Grouping"
{
    Caption = 'Grouping';
    DrillDownPageId = "Groupings";
    LookupPageId = "Groupings";
    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Type"; Enum "Group Type")
        {
            Caption = 'Type';

        }
    }
    keys
    {
        key(PK; Code, Description, Type)
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            Unique = true;
        }
    }
}