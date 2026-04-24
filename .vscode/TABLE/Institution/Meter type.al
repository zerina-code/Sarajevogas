table 50150 "Meter Type"
{
    Caption = 'Meter Types';
    DrillDownPageId = "Meter Types";
    LookupPageId = "Meter Types";


    fields
    {

        field(1; "Meter type"; Code[20])
        {
            Caption = 'Meter type';

        }

        field(2; "Gauge Size"; Text[250])
        {
            Caption = 'Gauge Size';
            //  TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(3; "Minimum flow"; Decimal)
        {
            Caption = 'Minimum flow';
        }
        field(4; "Maximum flow"; Decimal)
        {
            Caption = 'Maximum flow';
        }
        field(5; "Maximum pressure"; Decimal)
        {
            Caption = 'Maximum pressure';
        }
        field(6; "Minimum pressure"; Decimal)
        {
            Caption = 'Minimum pressure';
        }
        field(7; "Maximum temperature"; Decimal)
        {
            Caption = 'Maximum temperature';
        }
        field(8; "Minimum temperature"; Decimal)
        {
            Caption = 'Minimum temperature';
        }
        field(9; "Moderation period"; Integer)
        {
            Caption = 'Moderation period';
        }
        field(10; "Meter Type Name"; Text[250])
        {
            Caption = 'Meter Type Name';
        }




    }

    keys
    {
        key(Key1; "Meter type", "Gauge Size", "Meter Type Name")
        {
        }

    }

    fieldgroups
    {
    }
}

