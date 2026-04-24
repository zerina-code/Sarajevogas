table 50041 "Wage Jnl. Buffer"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Account No."; Code[10])
        {
            Caption = 'Account No.';
        }
        field(3; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DecimalPlaces = 1 : 5;
        }
        field(4; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DecimalPlaces = 1 : 5;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            Description = 'From Employee table';
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            Description = 'From Employee table';
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Document  No."; Code[100])
        {
            Caption = 'Document No.';
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

