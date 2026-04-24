table 50099 Template_Message
{
    DataClassification = ToBeClassified;
    //  LookupPageId = "List of Template Messages";
    // DrillDownPageId = "List of Template Messages";

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'ID';

        }
        field(2; "Message Subject"; Text[250])
        {
            Caption = 'Message Subject';

        }
        field(3; "Message Text"; Blob)
        {
            Caption = 'Message Text';
        }
        field(4; "Message Code"; Text[30])
        {
            Caption = 'Message Code';
        }
        field(5; "Message Attachment 1"; Text[1000])
        {
            Caption = 'Message Attachment 1';
        }
        field(6; "E-mail receiver"; Text[1000])
        {
            Caption = 'E-mail receiver';
        }
        field(7; "Print Confirmation"; Boolean)
        {
            Caption = 'Print Confirmation';
        }
        field(8; "E-mail sender"; Text[1000])
        {
            Caption = 'E-mail sender';
        }
        field(9; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Abstract,Detailed Description,Mail notification';
            OptionMembers = Empty,Abstract,"Detailed Description","Mail notification";

        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(11; MailCC; Text[1000])
        {
            Caption = 'Mail CC';
        }
        field(12; CustomerCOde; Text[20])
        {
            Caption = 'Customer Code';
        }

    }


    keys
    {
        key(PK; ID, "Message Code", Type, "Document No.", CustomerCOde)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        myInt: Integer;
        CompInf: Record "Company Information";
    begin

        rec."E-mail sender" := CompInf."E-Mail";

    end;


}
