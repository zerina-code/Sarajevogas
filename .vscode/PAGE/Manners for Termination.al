page 50081 "Manners for Termination"
{
    Caption = 'Manners s for Termination';
    PageType = List;
    SourceTable = "Manner for Termination";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("K")
            {
                field("Code Manner"; "Code Manner")
                {
                    ApplicationArea = all;
                }
                field("Description Manner"; "Description Manner")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {

        }
    }


}

