table 50160 "Alternative Fuel"
{
    Caption = 'Alternative Fuel';//DZ
    DrillDownPageId = "Alternative Fuels";
    LookupPageId = "Alternative Fuels";
    //ANISA

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