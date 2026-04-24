table 50012 Contribution
{
    Caption = 'Contribution';
    DrillDownPageId = "Contribution List";
    LookupPageId = "Contribution List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Contract Payment Model"; Text[2])
        {
            Caption = 'Contract Payment Model';
        }
        field(4; "Contract Refer To No."; Text[22])
        {
            Caption = 'Contract Refer To No.';
        }
        field(5; Minimum; Decimal)
        {
            Caption = 'Minimum';
        }
        field(6; Maximum; Decimal)
        {
            Caption = 'Maximum';
        }
        field(7; "Over Brutto"; Boolean)
        {
            Caption = 'Over brutto';
        }
        field(8; "From Brutto"; Boolean)
        {
            Caption = 'From brutto';
        }
        field(9; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(10; "Fixed Amount"; Boolean)
        {
            Caption = 'Fixed Amount';
        }
        field(11; "Over Netto"; Boolean)
        {
            Caption = 'Over Netto';
        }
        field(12; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'PIO,Health,Unemployment,Chamber,Special,RS';
            OptionMembers = PIO,Health,Unemployment,Chamber,Special,RS;
        }
        field(13; "Short Code"; Code[10])
        {
            Caption = 'Short Code';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Minimum)
        {
        }
        key(Key3; Maximum)
        {
        }
    }

    fieldgroups
    {
    }
}

