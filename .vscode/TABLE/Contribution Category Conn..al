table 50014 "Contribution Category Conn."
{
    Caption = 'Contribution Category Connection';

    fields
    {
        field(1; "Category Code"; Code[10])
        {
            Caption = 'Category Code';
            TableRelation = "Contribution Category".Code;
        }
        field(5; "Contribution Code"; Code[10])
        {
            Caption = 'Contribution Code';
            TableRelation = Contribution.Code;

            trigger OnValidate()
            begin
                Contribution.reset;
                Contribution.SETFILTER(Code, '%1', "Contribution Code");
                IF Contribution.FIND('-') THEN BEGIN
                    "Over Brutto" := Contribution."Over Brutto";
                    "From Brutto" := Contribution."From Brutto";
                END;
            end;
        }
        field(10; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(11; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(12; "Average Wage"; Decimal)
        {
            Caption = 'Average Wage';
        }
        field(13; "Over Brutto"; Boolean)
        {
            Caption = 'Over brutto';
        }
        field(14; "From Brutto"; Boolean)
        {
            Caption = 'From brutto';
        }
        field(15; "Calculated in Total Brutto"; Boolean)
        {
            Caption = 'Calculated in Total Brutto';
        }
        field(16; "Percentage from Brutto (RS)"; Boolean)
        {
            Caption = 'Percentage from Brutto (RS)';
        }
    }

    keys
    {
        key(Key1; "Category Code", "Contribution Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Contribution: Record "Contribution";
}

