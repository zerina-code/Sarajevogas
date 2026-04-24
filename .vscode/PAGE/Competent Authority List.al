/*page 50221 "Competent Authority List"
{
    Caption = 'Competent Authority List';
    PageType = List;
    SourceTable = "Competent Authority";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Name"; "Category Name")
                {
                    ApplicationArea = all;
                }
                field("Competent Authority Name"; "Competent Authority Name")
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