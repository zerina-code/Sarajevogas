page 50121 Title
{
    Caption = 'Title';
    PageType = List;
    SourceTable = Title;
    SourceTableView = SORTING(Order)
                      ORDER(Ascending);
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Order; Order)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SETCURRENTKEY(Order);
    end;
}

