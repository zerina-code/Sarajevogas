page 50218 "TypeOfEngagementList"
{
    PageType = List;
    SourceTable = TypeOfEngagement;
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
            action(NewRecord)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;

                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"Type of Engagement Card", TypeOfEngagementRec);
                    Rec := TypeOfEngagementRec;
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        TypeOfEngagementRec: Record TypeOfEngagement;
}
