page 50083 Nationallity
{
    Caption = 'Nationallity';
    PageType = List;
    SourceTable = "Nationallity";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("S")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
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

