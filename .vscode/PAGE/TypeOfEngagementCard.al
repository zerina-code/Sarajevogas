page 50219 "Type of Engagement Card"
{
    PageType = Card;
    SourceTable = "TypeofEngagement";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Type of Engagement';
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {

    }

}
