/*page 50202 "Award List"
{
    Caption = 'Employee Award List';
    PageType = List;
    SourceTable = "Awards";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Category)
                {
                    ApplicationArea = all;
                }
                field("Category Name"; "Category Name")
                {
                    ApplicationArea = all;
                }
                field("Subcategory Name"; "Subcategory Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

*/