page 50057 "Employee languages"
{
    PageType = List;
    SourceTable = "Employee Diseases";
    SourceTableView = where(Types = filter("Employee languages"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Language Code"; "Language Code")
                {
                    TableRelation = "Types Of Diseases" where(Types = filter(Languages));
                }
                field(Level; Level)
                {
                }
            }
        }
    }

    actions
    {
    }
}

