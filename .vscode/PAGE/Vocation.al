page 50136 Vocation
{
    Caption = 'Vocation';
    PageType = List;
    SourceTable = Vocation;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field("Description New"; "Description New")
                {
                    ApplicationArea = all;
                }
                field("No. Old"; "No. Old")
                {
                    ApplicationArea = all;
                }
                field("Description Old"; "Description Old")
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

