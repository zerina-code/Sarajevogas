tableextension 50085 "Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
{
    fields
    {
        // Add changes to table fields here
        field(500010; "Vendor No."; code[20])
        {
            Caption = 'Vendor No.';

        }
        field(500011; "Vendor Name"; Text[250])
        {
            Caption = 'Vendor Name';

        }
        field(500012; "Vendor Date"; Date)
        {
            Caption = 'Vendor Date';
        }
        field(500013; "Responsible Name"; Text[250])
        {
            Caption = 'Responsible Name';
        }
        field(500014; "Responsible Position"; Text[250])
        {
            Caption = 'Responsible person position';
        }
        field(500015; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
        }
    }

    var
        myInt: Integer;
}