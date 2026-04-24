table 50008 "Wage/Reduction Bank"
{
    // //

    Caption = 'Wage/Reduction Bank';
    DrillDownPageID = "Wage/Reduction Banks";
    LookupPageID = "Wage/Reduction Banks";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; City; Text[30])
        {
            Caption = 'City';
        }
        field(4; "Contact E-mail"; Text[250])
        {
            Caption = 'Contact E-mail';
        }
        field(5; "Fax"; Text[250])
        {
            Caption = 'Fax';
        }
        field(6; "Phone No."; text[250])
        {
            Caption = 'Phone No.';
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

