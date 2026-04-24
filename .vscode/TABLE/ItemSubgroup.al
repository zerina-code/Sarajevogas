table 50119 ItemSubgroup
{
    //ED

    Caption = 'ItemSubgroup';
    DrillDownPageID = ItemSubgroup;
    LookupPageID = ItemSubgroup;

    fields
    {
        field(1; "Subgroup Code"; Code[20])
        {
            Caption = 'Subgroup Code';
            NotBlank = true;
        }
        field(2; "Subgroup Description"; Text[200])
        {
            Caption = 'Subgroup Description';
        }
        field(3; "Code Category Text"; Option)
        {
            Caption = 'Code Category Text';
            OptionCaption = ' ,Artikal,Dobavljač,Usluga,Osnovno sredstvo,Kupac';
            OptionMembers = " ",Artikal,Dobavljač,Usluga,OS,Kupac;
        }
        field(4; "Group Code"; Code[10])
        {
            Caption = 'Item Group Code';
            TableRelation = "Item Group" where("Code Category Text" = field("Code Category Text"));

            trigger OnValidate()
            begin
                ItemGroupTable.Reset();
                ItemGroupTable.SetFilter("Category Code", '%1', "Class Code");
                ItemGroupTable.SetFilter("Group Code", '%1', "Group Code");
                if ItemGroupTable.FindFirst() then
                    "Group Description" := ItemGroupTable."Group Description";
            end;
        }
        field(5; "Group Description"; Text[200])
        {
            Caption = 'Item Group Decription';
        }
        field(6; "Subgroup Label"; Code[20])
        {
            Caption = 'Subgroup Label';
        }
        field(7; "Class Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category" where("Code Category Text" = field("Code Category Text"));
            trigger OnValidate()
            begin
                ItemCategoryTable.Reset();
                ItemCategoryTable.SetFilter(Code, '%1', "Class Code");
                if ItemCategoryTable.FindFirst() then
                    "Class Description" := ItemCategoryTable.Description;
            end;
        }
        field(8; "Class Description"; Text[100])
        {
            Caption = 'Class Description';
        }
    }

    keys
    {
        key(Key1; "Subgroup Code", "Subgroup Description", "Code Category Text")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ItemGroupTable: Record "Item Group";
        ItemCategoryTable: Record "Item Category";
}

