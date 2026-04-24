page 50022 "Tax Deduction Lists"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tax deduction list";
    Caption = 'Tax Deduction Lists';
    SourceTableView = where(Type = filter("Tax List"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)

            {
                field("Entity Code"; "Entity Code")
                {
                    ApplicationArea = All;

                }
                field("Valid Year"; "Valid Year")
                {
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;

                }
            }
        }
    }



    var
        myInt: Integer;
}