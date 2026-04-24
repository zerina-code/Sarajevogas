table 50010 "Wage Type"
{
    Caption = 'Wage Type';
    LookupPageID = "Wage Types";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            Description = 'Primary Key';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(4; "Tax Basis Percent"; Decimal)
        {
            Caption = 'Tax Basis Percent';
        }
        field(5; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Netto,Brutto,Coefficient,Netto2';
            OptionMembers = Netto,Brutto,Coefficient,Netto2;
        }
        field(6; Contract; Boolean)
        {
            Caption = 'Contract';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

