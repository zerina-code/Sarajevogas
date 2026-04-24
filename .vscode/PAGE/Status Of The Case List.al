/*page 50248 "Status Of The Case List"
{
    Caption = 'Status Of The Case List';
    PageType = List;
    SourceTable = "Status Of The Case";
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
                field("Status Of The Case"; "Status Of The Case")
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