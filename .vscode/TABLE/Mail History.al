/*Đ table 50089 "Mail History"
{
    Caption = 'Mail History';
    //ĐK DrillDownPageID = 51098;
    //Đk LookupPageID = 51098;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
            Editable = false;
        }
        field(2; "User Name"; Code[50])
        {
            Caption = 'User Name';
        }
        field(3; "Sent Date"; Date)
        {
            Caption = 'Sent Date';
        }
        field(4; "Message Name"; Text[100])
        {
            Caption = 'Message Name';
        }
        field(5; "Message Subject"; Text[100])
        {
            Caption = 'Message Subject';
        }
        field(6; "Message To"; Text[250])
        {
            Caption = 'To';
        }
        field(7; "Message Cc"; Text[250])
        {
            Caption = 'Cc';
        }
        field(8; "Message Text"; BLOB)
        {
            Caption = 'Message Text';
            SubType = UserDefined;
        }
        field(9; Attachments; Integer)
        {
            CalcFormula = Count("Attachment History" WHERE("Mail ID" = FIELD("No.")));
            Caption = 'Attachments';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}
*/