/*page 50220 "Type of Engagement List"
{
    PageType = List;
    SourceTable = "TypeofEngagement";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(New)
            {
                Caption = 'New';
                Image = New;
                trigger OnAction()
                var
                    TypeOfEngagementCard: Page "Type of Engagement Card";
                begin
                    TypeOfEngagementCard.RunModal;
                end;
            }
            action(Delete)
            {
                Caption = 'Delete';
                Image = Delete;
                trigger OnAction()
                begin
                    Rec.Delete;
                end;
            }
        }
    }
}
*/