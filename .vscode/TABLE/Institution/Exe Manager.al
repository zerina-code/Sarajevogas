table 50060 "Exe Manager"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "ORG Shema"; Code[10])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }

        field(2; "Position Code"; Code[20])
        {
            Caption = 'Org Code';
            //Đk   TableRelation = Department.Code WHERE("Org Shema" = FIELD("Org Shema"));
            Editable = false;
        }
        field(3; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            TableRelation = "Position Menu".Description WHERE("Org. Structure" = FIELD("Org Shema"));

            trigger OnValidate()
            var
                PosMenu: Record "Position Menu";
            begin
                PosMenu.Reset();
                PosMenu.SetFilter(Description, '%1', "Position Description");
                PosMenu.SetFilter("Org. Structure", '%1', Rec."ORG Shema");
                if PosMenu.FindFirst() then
                    "Position Code" := PosMenu.Code
                else
                    "Position Code" := '';

            end;
        }
        field(5; "Subordinate Org Description"; Text[250])
        {
            Caption = 'Subordinate Org Description';
            TableRelation = Department.Description WHERE("Org Shema" = FIELD("Org Shema"));
            trigger onvalidate()
            var
                Department: Record Department;
            begin
                Department.Reset();
                Department.SetFilter(Description, '%1', "Subordinate Org Description");
                Department.SetFilter("ORG Shema", '%1', Rec."ORG Shema");
                if Department.FindFirst() then
                    "Subordinate Org Code" := Department.Code
                else
                    "Subordinate Org Code" := '';
            end;
        }
        field(6; "Subordinate Org Code"; Code[20])
        {
            Caption = 'Subordinate Org Code';
            //ĐK TableRelation = Department.Description WHERE("Org Shema" = FIELD("Org Shema"));
            Editable = false;
        }





    }

    keys
    {
        key(Key1; "ORG Shema", "Position Description", "Subordinate Org Description")
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