/*ĐK možda kasnije table 50078 "Template Messages"
{

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            MinValue = 1;
        }
        field(2; "Message Subject"; Text[250])
        {
            Caption = 'Message Subject';
        }
        field(3; "Message Text"; BLOB)
        {
            Caption = 'Message Text';
            SubType = UserDefined;
        }
        field(4; "Message Code"; Text[30])
        {
            Caption = 'Message Code';
        }
        field(5; "Manager 1"; Code[30])
        {
            Caption = 'Manager No';
            TableRelation = Position.Code;
        }
        field(6; "Manager 2"; Code[30])
        {
            Caption = 'Manager No';
            TableRelation = Position.Code;
        }
        field(7; "Manager 3"; Code[30])
        {
            Caption = 'Manager No';
            TableRelation = Position.Code;
        }
        field(8; "Message Attachment 1"; Text[250])
        {
            Caption = 'Message Attachment 1';
        }
        field(9; "Message Attachment 2"; Text[250])
        {
            Caption = 'Message Attachment 2';
        }
        field(10; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; ID, "Message Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TextMessage: BigText;
        OStream: OutStream;
        IStream: InStream;
        TM: Record "Template Messages";
}

*/