table 50179 InvestitionTable
{
    Caption = 'Investition Table';
    LookupPageID = "InvestitionPage";
    DrillDownPageID = "Investition Card";

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
