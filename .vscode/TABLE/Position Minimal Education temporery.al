table 50016 "Position Minimal Education"



{
    DrillDownPageId = "Positions Minimal Education";
    LookupPageId = "Positions Minimal Education";


    fields
    {
        field(1; "Org Shema"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;

        }
        field(2; "Position Code"; Code[20])
        {
            TableRelation = "Position Menu".Code where("Org. Structure" = field("Org Shema"));
            Caption = 'Position Code';
        }
        field(3; "Position Name"; Text[250])
        {
            Caption = 'Position Name';
            TableRelation = "Position Menu".Description where("Org. Structure" = field("Org Shema"));

        }
        field(4; "Minimal Education Level"; enum School)
        {
            Caption = 'Minimal Education Level';

        }
        field(5; "School of Graduation"; Text[250])
        {
            Caption = 'School of Graduation';
            TableRelation = "Institution/Company".Description WHERE("Type" = FILTER("Education"));


        }

    }

    keys
    {
        key(Key1; "Org Shema", "Position Code", "Position Name", "Minimal Education Level", "School of Graduation")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}