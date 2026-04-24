/*page 50046 "Education - Seminars List"
{
    Caption = 'Education - Seminars List';
    PageType = List;
    SourceTable = "Education - Seminars";
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
                    ApplicationArea = all;
                }
                field("Serial Number"; "Serial Number")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Description; Description)
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