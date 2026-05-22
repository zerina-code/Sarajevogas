table 50301 "Contribution Category"
{
    Caption = 'Contribution Category';
    LookupPageID = "Contribution Category List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Tax Payment Percentage"; Decimal)
        {
            Caption = 'Tax Payment Percentage';
        }
        field(13; "Over Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Contribution Category Conn.".Percentage WHERE("Category Code" = FIELD(Code),
                                                                              "Over Brutto" = CONST(true), Blocked = const(false)));
            Caption = 'Over brutto';


        }
        field(14; "From Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Contribution Category Conn.".Percentage WHERE("Category Code" = FIELD(Code),
                                                                              "From Brutto" = CONST(true),

                                                             "Calculated in Total Brutto" = CONST(true), Blocked = const(false)));
            Caption = 'From brutto';

        }
        field(15; "From Brutto(RS)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Contribution Category Conn.".Percentage WHERE("Category Code" = FIELD(Code),
                                                                              "Percentage from Brutto (RS)" = CONST(true), Blocked = const(false)));
            Caption = 'From brutto';

        }
        field(16; "UOD"; Boolean)
        {

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

