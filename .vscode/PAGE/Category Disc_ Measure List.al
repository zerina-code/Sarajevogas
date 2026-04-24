/*page 50236 "Category Disc. Measure List"
{
    Caption = 'Category Disciplinary Measure List';
    PageType = List;
    SourceTable = "Category Disciplinary Measure";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Category; Category)
                {
                    ApplicationArea = all;
                }
                field(Name; Name)
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