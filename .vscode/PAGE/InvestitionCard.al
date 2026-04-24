page 50223 "Investition Card"
{
    PageType = Card;
    SourceTable = InvestitionTable;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Type of Investition';
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
