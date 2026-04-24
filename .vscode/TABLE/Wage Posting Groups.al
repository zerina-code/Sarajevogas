table 50011 "Wage Posting Groups"
{
    Caption = 'Wage Posting Groups';
    LookupPageID = "Wage Posting Groups";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Wage Posting Group Code';
            Description = 'Primary Key';
        }
        field(2; "Tax Account"; Code[20])
        {
            Caption = 'Tax Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(3; "Tax Bal. Account"; Code[20])
        {
            Caption = 'Tax Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(4; "City Tax Account"; Code[20])
        {
            Caption = 'City Tax Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(5; "City Tax Bal. Account"; Code[20])
        {
            Caption = 'City Tax Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(6; "Netto Account"; Code[20])
        {
            Caption = 'Netto Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(7; "Netto Bal. Account"; Code[20])
        {
            Caption = 'Netto Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(8; "Transport Account"; Code[20])
        {
            Caption = 'Transport Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(9; "Transport Bal. Account"; Code[20])
        {
            Caption = 'Transport Bal. Account';
            Description = 'Not Used - bal. account is a bank account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(10; "Sick Comp. Account"; Code[20])
        {
            Caption = 'Sick Comp. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(11; "Sick Comp. Bal. Account"; Code[20])
        {
            Caption = 'Sick Comp. Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(12; "Sick Fund Account"; Code[20])
        {
            Caption = 'Sick Fund Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(13; "Sick Fund Bal. Account"; Code[20])
        {
            Caption = 'Sick Fund Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(14; "Meal Account to pay"; Code[20])
        {
            Caption = 'Meal Account to pay';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(15; "Meal Bal. Account to pay"; Code[20])
        {
            Caption = 'Meal Bal. Account to pay';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(16; "Tax >42 Account"; Code[20])
        {
            Caption = 'Tax >42 Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(17; "Tax >42 Bal. Account"; Code[20])
        {
            Caption = 'Tax >42 Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(18; "Reduction Bal. Account"; Code[20])
        {
            Caption = 'Reduction Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(19; "Tax Transit Account"; Code[20])
        {
            Caption = 'Tax Transit Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(20; "Netto Transit Account"; Code[20])
        {
            Caption = 'Netto Transit Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(21; "Meal Transit Account"; Code[20])
        {
            Caption = 'Meal Transit Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(22; "Transport Transit Account"; Code[20])
        {
            Caption = 'Transport Transit Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(23; "Use Account"; Code[20])
        {
            Caption = 'Use Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(24; "Use Bal. Account"; Code[20])
        {
            Caption = 'Use  Bal. Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(25; "Use Transit Account"; Code[20])
        {
            Caption = 'Use Transit Account';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting));
        }
        field(26; "Temporary Contract"; Boolean)
        {
            Caption = 'Temporary Contract';
        }
        field(27; "Temporary Contract Type"; Option)
        {
            Caption = 'Temporary Contract Type';
            OptionCaption = '  ,Temporary Contract,Temporary Contract 0,Temporary Contract Non-Residents,Author Contracts';
            OptionMembers = "  ","Temporary Contract","Temporary Contract 0","Temporary Contract Non-Residents","Author Contracts";
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

    procedure CheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin

        IF AccNo <> '' THEN BEGIN
            GLAcc.GET(AccNo);
            GLAcc.CheckGLAcc;
        END;
    end;
}

