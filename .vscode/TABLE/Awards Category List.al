/*page 50001 "Award Category List"
{
    Caption = 'Award Category List';
    PageType = List;
    SourceTable = "Award Category";
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

                    //aida hero
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