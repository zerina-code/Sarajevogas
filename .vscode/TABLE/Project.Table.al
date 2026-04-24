table 50089 "Project"
{
    Caption = 'Project';
    DrillDownPageId = "Projects";
    LookupPageId = "Projects";
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
        field(3; "Project Date"; Date)
        {
            Caption = 'Project Date';

        }
        field(4; "Investor Code"; Code[20])
        {
            Caption = 'Investor Code';
            TableRelation = Contact."No." where("Type Relation" = filter(Investor));

            trigger OnValidate()
            var
                myInt: Integer;
                Contact: Record contact;
            begin
                Contact.reset;
                Contact.SetFilter("No.", '%1', "Investor Code");
                if Contact.FindFirst() then
                    "Investor Name" := Contact.Name
                else
                    "Investor Name" := '';
            end;
        }
        field(5; "Investor Name"; Text[250])
        {
            Caption = 'Investor Name';
            //   TableRelation = Contact."No." where ("Type Relation"=filter(Investor));
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