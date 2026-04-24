page 50109 Profession
{
    Caption = 'Profession';
    PageType = List;
    SourceTable = Profession;
    SourceTableView = SORTING("Order")
                      ORDER(Ascending);
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Order; "Order")
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

