table 50101 Zone_Table
{
    DataClassification = ToBeClassified;
    LookupPageId = Zones_Page;
    DrillDownPageId = Zones_Page;

    fields
    {
        field(1; Code; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';

        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
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