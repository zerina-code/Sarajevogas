page 50040 Cantons
{
    Caption = 'Cantons';
    PageType = List;
    SourceTable = Canton;

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
                field("Entity Code"; "Entity Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

