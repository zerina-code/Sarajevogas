tableextension 50068 ServiceItemGroup extends "Service Item Group"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Code Category Text"; Option)
        {
            Caption = 'Code Category Text';
            OptionCaption = ' ,Artikal,Dobavljač,Usluga';
            OptionMembers = " ",Artikal,Dobavljač,Usluga;
        }
        field(50005; "Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category" where("Code Category Text" = const(1));

            trigger OnValidate()
            begin
                ItemCategoryTable.Reset();
                ItemCategoryTable.SetFilter(Code, '%1', "Category Code");
                if ItemCategoryTable.FindFirst() then
                    "Category Description" := ItemCategoryTable.Description;
            end;
        }
        field(50006; "Category Description"; Text[100])
        {
            Caption = 'Item Category Decription';
        }

    }

    trigger OnBeforeInsert()
    begin
        "Code Category Text" := 1;
    end;

    var
        ItemCategoryTable: Record "Item Category";

}
