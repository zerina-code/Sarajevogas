table 50026 "Reduction Types"
{
    Caption = 'Reduction types';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; AmountIsPercentage; Boolean)
        {
            Caption = 'AmountIsPercentage';
        }
        field(4; AmountWithoutLimit; Boolean)
        {
            Caption = 'Amount has no limit';
        }
        field(5; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('D')));


        }
        field(6; "Separate Payment"; Boolean)
        {
            Caption = 'Separate Payment';
        }
        field(107; "Bal. G/L Account"; Code[20])
        {
            Caption = 'G/L Account';

            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('C')));
        }
        field(108; "Transit  Account"; Code[20])
        {
            Caption = 'Transit Account';
            TableRelation = "G/L Account";
        }
        field(109; "Transit  Account 2"; Code[20])
        {
            Caption = 'Transit Account 2';
            TableRelation = "G/L Account";
        }
        field(50023; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = TS_knjizenja.vrnaloga;
        }
        field(50024; "Reduction Type"; Option)
        {
            Caption = 'Reduction Type';
            OptionCaption = ',Memberships,Unions';
            OptionMembers = "<",Memberships,Unions;

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

