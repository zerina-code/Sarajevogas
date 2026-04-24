/*table 50241 "Blocked By"
{
    // //


    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "Blocked By"; Text[250])
        {
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(5; User; Text[250])
        {
            Caption = 'User';
        }
        field(6; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(7; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(15; "Unlock Customer 1"; Text[30])
        {
            Caption = 'Allowed to Unlock Customer 1';
        }
        field(16; "Unlock Customer 2"; Text[30])
        {
            Caption = 'Allowed to Unlock Customer 1';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

*/