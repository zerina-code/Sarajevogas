/*page 50084 "Notes/Comments"
{
    Caption = 'Notes/Comments';
    PageType = List;
    SourceTable = "Notes/Comments";
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
                    //ĐK
                }
                field("Note No."; "Note No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
                field(Note; Note)
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