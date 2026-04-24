table 50086 "Mandatory Attachment Setup"
{
    Caption = 'Mandatory Attachment Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Dwelling Type"; Text[250])
        {
            Caption = 'Dwelling Type';
            DataClassification = CustomerContent;
            TableRelation = "Dwelling Type".Description;
            trigger OnValidate()
            begin
                OnValidateDwellingType();
            end;
        }
        field(2; "Mandatory Attachment Type"; Text[250])
        {
            Caption = 'Mandatory Attachment Type';
            DataClassification = CustomerContent;
            TableRelation = "Mandatory Attachment Type".Description;
        }
        field(3; "Request Type"; Enum "Request Type")
        {
            Caption = 'Request Type';
            DataClassification = CustomerContent;

            //ValuesAllowed = "Information Issuing Request", "Project overview Request", "Work Execution Request", "Location Accordance Issuing Request", "Route Accordance Issuing Request", "Spatial plan Accordance Issuing Request";
            trigger OnValidate()
            begin
                OnValidateRequestType();
            end;
        }
        field(4; "Information"; Boolean)
        {
            Caption = 'Information';
        }
        field(5; "Mandatory"; Boolean)
        {
            Caption = 'Mandatory';
        }
        field(6; "Gas Installation"; Boolean)
        {
            Caption = 'Gas Installation';
        }
    }
    keys
    {
        key(PK; "Request Type", "Dwelling Type", "Mandatory Attachment Type")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Mandatory := true;

    end;

    local procedure OnValidateDwellingType()
    begin
        TestField("Request Type", Enum::"Request Type"::"Information Issuing Request");
    end;

    local procedure OnValidateRequestType()
    begin
        "Dwelling Type" := '';
    end;
}
