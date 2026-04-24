table 50074 "Dwelling Type"
{
    Caption = 'Dwelling Type';
    DrillDownPageId = "Dwelling Types";
    LookupPageId = "Dwelling Types";
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
        field(3; "Short Description"; Text[250])
        {
            Caption = 'Short Description';
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