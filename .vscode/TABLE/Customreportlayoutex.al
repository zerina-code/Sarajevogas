tableextension 50101 Customreportlayout extends "Custom Report Layout"
{
    fields
    {
        // Add changes to table fields here


        field(5000; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(60000; "Request Type"; Enum "Request Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
        }



    }

    var
        myInt: Integer;
        Municipality: Record "Municipality";
        PictureUpdated1: Boolean;
        PictureUpdated2: Boolean;
        PictureUpdated3: Boolean;
}