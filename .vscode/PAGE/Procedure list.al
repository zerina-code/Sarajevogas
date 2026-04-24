/*page 50108 "Procedure List"
{
    Caption = 'Procedure';
    PageType = List;
    SourceTable = "Procedure";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type of procedure"; "Type of procedure")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
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

*/