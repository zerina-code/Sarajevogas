table 50118 "Activity Type"
{
    Caption = 'Activity Type';//DZ
    DrillDownPageId = "Activity Types";
    LookupPageId = "Activity Types";
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
        field(3; "Group request"; Text[250])
        {
            Caption = 'Group request';
            TableRelation = "Request Group".Description;
        }
    }
    keys
    {
        key(PK; Code, Description, "Group request")
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            Unique = true;
        }
    }
}