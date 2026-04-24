/*table 50166 Awards
{
    Caption = 'Awards';
    DrillDownPageID = "Award List";
    LookupPageID = "Award List";

    fields
    {
        field(1; Category; Code[20])
        {
            Caption = 'Category No.';
            TableRelation = "Award Category".Category;

            trigger OnValidate()
            begin
                AwardCategory.RESET;
                AwardCategory.SETFILTER(Category, '%1', Category);
                IF AwardCategory.FINDFIRST THEN
                    "Category Name" := AwardCategory.Name;
            end;
        }
        field(2; "Category Name"; Text[100])
        {
            Caption = 'Category Name';
            Editable = false;
        }
        field(3; "Subcategory Name"; Text[100])
        {
            Caption = 'Subcategory Name';
        }
    }

    keys
    {
        key(Key1; Category, "Subcategory Name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        AwardCategory: Record "Award Category";
}

*/