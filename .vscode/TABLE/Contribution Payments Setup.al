table 50143 "Contribution Payments Setup"
{
    Caption = 'Add. Tax Payments Setup';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Entity,Canton,Municipality';
            OptionMembers = Entity,Canton,Municipality;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(3; "Type of Add. Tax"; Option)
        {
            Caption = 'Type of Add. Tax';
            Description = 'FDS';
            OptionCaption = 'PIO,Health,Unemployment,Chamber,Special,RS,Tax';
            OptionMembers = PIO,Health,Unemployment,Chamber,Special,RS,Tax;
        }
        field(4; "Payment Receiver1"; Text[30])
        {
            Caption = 'Payment Receiver1';
        }
        field(5; "Payment Receiver2"; Text[30])
        {
            Caption = 'Payment Receiver2';
        }
        field(6; "Payment Receiver3"; Text[30])
        {
            Caption = 'Payment Receiver3';
        }
        field(7; "Payment Account"; Text[30])
        {
            Caption = 'Payment Account';
        }
        field(8; "Revenue Type"; Text[30])
        {
            Caption = 'Revenue Type';
        }
        field(9; "Assignment Purpose1"; Text[30])
        {
            Caption = 'Assignment Purpose1';
        }
        field(10; "Assignment Purpose2"; Text[30])
        {
            Caption = 'Assignment Purpose2';
        }
        field(11; "Assignment Purpose3"; Text[30])
        {
            Caption = 'Assignment Purpose3';
        }
        field(12; "Add. Tax Code"; Code[10])
        {
            Caption = 'Add. Tax Code';
        }
        field(13; "G/L Account No."; Code[10])
        {
            Caption = 'G/L Account No.';
        }
        field(14; "Refer To Number"; Code[20])
        {
            Caption = 'Refer To Number';
        }

        field(15; "Refer To Number RS"; Code[20])
        {
            Caption = 'Refer To Number';
        }
        field(16; "Revenue Type TC"; Text[30])
        {
            Caption = 'Revenue Type';
        }
        field(17; "Budget organisation"; Text[1000])
        {
            Caption = 'Budžetska organizacija';
        }
    }

    keys
    {
        key(Key1; Type, "Code", "Type of Add. Tax", "Add. Tax Code")
        {
        }
    }

    fieldgroups
    {
    }
}

