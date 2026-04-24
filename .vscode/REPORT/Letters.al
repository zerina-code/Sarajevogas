/*table 50115 "Letters"
{
    Caption = 'Feed Section';
    DrillDownPageId = "Feed Sections";
    LookupPageId = "Feed Sections";
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Termination Type"; Option)
        {
            Caption = 'Termination Type';
            OptionCaption = ' ,Permanently deregister,Temporery';
            OptionMembers = " ","Permanently deregister",Temporery;
        }

        field(4; "Posting"; Boolean)
        {
            Caption = 'Posting';

        }
        field(5; "Remark"; Text[500])
        {
            Caption = 'Remark';

        }

    }
    keys
    {
        key(PK; Code, Description)
        {
            Clustered = true;
        }

    }
}*/