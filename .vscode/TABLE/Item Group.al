table 50045 "Item Group"
{
    //ED

    Caption = 'Item Group';
    DrillDownPageID = "Item Group";
    LookupPageID = "Item Group";

    fields
    {
        field(1; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            NotBlank = true;
        }
        field(2; "Group Description"; Text[100])
        {
            Caption = 'Group Description';
        }
        field(3; "Code Category Text"; Option)
        {
            Caption = 'Code Category Text';
            OptionCaption = ' ,Artikal,Dobavljač,Usluga,Osnovno sredstvo,Kupac';
            OptionMembers = " ",Artikal,Dobavljač,Usluga,OS,Kupac;
        }
        field(4; "Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category" where("Code Category Text" = field("Code Category Text"));


            trigger OnValidate()
            begin
                ItemCategoryTable.Reset();
                ItemCategoryTable.SetFilter(Code, '%1', "Category Code");
                if ItemCategoryTable.FindFirst() then
                    "Category Description" := ItemCategoryTable.Description;
            end;
        }
        field(5; "Category Description"; Text[100])
        {
            Caption = 'Item Category Decription';
        }
        field(6; "Group Label"; Code[20])
        {
            Caption = 'Group Label';
        }
    }

    keys
    {
        key(Key1; "Group Code", "Group Description", "Code Category Text")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ItemCategoryTable: Record "Item Category";
}

