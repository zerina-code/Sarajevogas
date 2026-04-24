table 50123 "Contribution Posting Setup"
{
    Caption = 'Contribution Posting Setup';
    DrillDownPageId = "Contribution Posting Setup";
    LookupPageId = "Contribution Posting Setup";

    fields
    {
        field(1; "Additional Tax Code"; Code[10])
        {
            Caption = 'Additional Tax Code';
            Description = 'Primary Key pt 1';
            TableRelation = Contribution;
        }
        field(2; "Wage Posting Group"; Code[10])
        {
            Caption = 'Wage Posting Group';
            Description = 'Primary Key pt 2';
            TableRelation = "Wage Posting Groups";
        }
        field(5; Account; Code[20])
        {
            Caption = 'Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(10; "Bal. Account"; Code[20])
        {
            Caption = 'Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(11; "Transit Account"; Code[20])
        {
            Caption = 'Transit Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(12; "Apprtionment Account"; Code[20])
        {
            Caption = 'Apprtionment Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
    }

    keys
    {
        key(Key1; "Additional Tax Code", "Wage Posting Group")
        {
        }
    }

    fieldgroups
    {
    }
}

