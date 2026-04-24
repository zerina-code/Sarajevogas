table 50183 "Gas Station Attribute"
{
    Caption = 'Gas Station Attribute';
    DrillDownPageId = "Gas Station Attributes";
    LookupPageId = "Gas Station Attributes";
    fields
    {
        field(1; "Gas Station Attribute Type"; Enum "Gas Station Attribute Type")
        {
            Caption = 'Gas Station Attribute Type';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Gas Station Attribute Type", Description)
        {
            Clustered = true;
        }
    }
}