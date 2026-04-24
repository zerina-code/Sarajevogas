table 50027 "Tax Class"
{
    Caption = 'Tax Class';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(5; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(10; "Valid From Amount"; Decimal)
        {
            Caption = 'Valid From Amount';
        }
        field(15; "Valid To Amount"; Decimal)
        {
            Caption = 'Valid To Amount';
        }
        field(20; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(30; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }
        field(31; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = TS_knjizenja.vrnaloga;
        }
        field(32; "G/L Account No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('D')));
            Caption = 'G/L Account No.';


        }
        field(33; "G/L Balance Account No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('C')));
            Caption = 'G/L Balance Account No.';

        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Valid From Amount")
        {
        }
    }

    fieldgroups
    {
    }
}

