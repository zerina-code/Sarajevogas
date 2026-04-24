tableextension 50021 "Document Attachment" extends "Document Attachment"
{
    fields
    {
        // Add changes to table fields here
        field(20; "Content"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Mandatory Attachment Type"; Text[250])
        {
            Caption = 'Mandatory Attachment Type';
            DataClassification = CustomerContent;
            TableRelation = "Mandatory Attachment Type".Description;
            Editable = false;
        }
        field(50002; "Delivered"; enum Option)
        {
            Caption = 'Delivered';
            DataClassification = CustomerContent;
        }
        field(50003; "Value"; Decimal)
        {
            Caption = 'Value';
            Editable = true;
        }
        field(50004; "No need"; Boolean)
        {
            Caption = 'No need';
            DataClassification = CustomerContent;
        }
        field(50005; "Information"; Boolean)
        {
            Caption = 'Information';
            DataClassification = CustomerContent;
        }
        field(50006; "Mandatory"; Boolean)
        {
            Caption = 'Mandatory';
        }
        field(50007; "GAS installation"; Boolean)
        {
            Caption = 'GAS installation';
            DataClassification = CustomerContent;
        }
        field(50008; "Archived"; Boolean)
        {
            Caption = 'Archived';
            DataClassification = CustomerContent;
        }

        field(50009; "Version"; Integer)
        {
            Caption = 'Version';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}