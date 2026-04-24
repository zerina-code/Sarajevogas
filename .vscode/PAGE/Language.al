page 50068 Language
{
    Caption = 'Languages';
    PageType = List;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter(Languages));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Types; Types) { Visible = false; }
            }
        }
    }

    actions
    {
    }
}

