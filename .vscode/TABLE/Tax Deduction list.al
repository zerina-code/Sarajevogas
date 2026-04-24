table 50093 "Tax deduction list"
{
    DrillDownPageID = "Tax Deduction Lists";
    LookupPageID = "Tax Deduction Lists";

    fields
    {
        field(1; Pk; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Entity Code"; Code[20])
        {
            Caption = 'Entitet';
        }
        field(3; "Valid Year"; Integer)
        {
            Caption = 'Godina';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Iznos';
        }
        field(5; Active; Boolean)
        {
            Caption = 'Aktivan';
        }
        field(6; Month; Integer)
        {
            Caption = 'Mjesec';
        }
        field(7; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Tax List,Interest Setup';
            OptionMembers = "Tax List","Interest Setup";

        }
        field(8; "Interest Date From"; Date)
        {
            Caption = 'Interest Date From';
        }

        field(9; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
        }
        field(10; "Interest Date To"; Date)
        {
            Caption = 'Interest Date To';
        }


    }

    keys
    {
        key(Key1; "Valid Year", "Entity Code", Amount, PK, Type)
        {
        }
    }


    fieldgroups
    {
    }
}

