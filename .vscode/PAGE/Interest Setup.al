page 50061 "Interest setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tax deduction list";
    Caption = 'Interest setup';
    SourceTableView = where(Type = filter("Interest Setup"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)

            {
                field("Interest Date From"; "Interest Date From") { }
                field("Interest Date To"; "Interest Date To") { }
                field("Interest Amount"; "Interest Amount") { }


            }
        }

    }




    var
        myInt: Integer;
}