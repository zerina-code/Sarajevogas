page 50220 "InvestitionPage"
{
    PageType = List;
    SourceTable = InvestitionTable;
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
                    PAGE.RunModal(PAGE::"Investition Card", TypeOfInvestitionRec);
                    Rec := TypeOfInvestitionRec;
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        TypeOfInvestitionRec: Record InvestitionTable;
}
