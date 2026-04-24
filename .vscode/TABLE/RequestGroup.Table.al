table 50085 "Request Group"
{
    Caption = 'Request Group';
    DrillDownPageId = "Request Groups";
    LookupPageId = "Request Groups";
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



    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
}