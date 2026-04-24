page 50005 Entities
{
    Caption = 'Entities';
    PageType = List;
    SourceTable = "Entity";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                }
                field(Description;Description)
                {
                }
                field("Country/Region Code";"Country/Region Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

