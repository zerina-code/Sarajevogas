tableextension 50106 IssuedHeader extends "Issued Reminder Header"
{
    fields
    {
        // Add changes to table fields here

        field(50027; "Reminder Report"; Text[200])
        {
            Caption = 'Reminder Report';
        }
        field(50028; "Reminder Report Type"; Enum ReminderReportType)
        {
            Caption = 'Reminder Report Type';
        }
        field(50029; "Reminder sent"; Boolean)
        {
            Caption = 'Reminder sent';
        }

        field(50030; "Delivered via email"; Boolean)
        {
            Caption = 'Delivered via email';
        }
        field(50031; "Date of Sent Reminder"; Date)
        {
            Caption = 'Date of Sent Reminder';
        }
        field(50032; "Issued Reminder No."; Code[20])
        {
            Caption = 'Issued Reminder No.';
            TableRelation = "Issued Reminder Header";
        }
        field(50033; "Delivered via Post"; Boolean)
        {
            Caption = 'Delivered via Post';
            TableRelation = "Issued Reminder Header";
        }
        field(50034; "Created From Reminder"; Boolean)
        {
            Caption = 'Created From Reminder';
        }
        field(50035; "Reminder Printed"; Boolean)
        {
            Caption = 'Reminder Printed';
        }
        field(50036; "CustomerCategory"; Enum Category)
        {
            Caption = 'Customer Category';
        }
        field(50037; "Reminder Type"; Option)
        {
            OptionCaption = 'Reminder for interruption of gas supply,Accusation Reminder';
            OptionMembers = "Reminder for interruption of gas supply","Accusation Reminder";

        }
        field(50038; "WH"; code[20])
        {
            Caption = 'WH';
        }
    }

    var
        myInt: Integer;
}