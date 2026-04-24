/*page 50060 Grades
{
    Caption = 'Grades';
    PageType = List;
    SourceTable = "Grade";
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
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {

        }
    }

    actions
    {
        area(creation)
        {
            group("Dimension temporary")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = true;
                action(Grade)
                {
                    Caption = 'Grade';
                    RunObject = Page "Grades";
                    RunPageLink = "Position Code" = FIELD("Position Code"),
                                  "Position Description" = FIELD("Position Description");
                    RunPageOnRec = false;
                    Visible = false;
                }
            }
        }
    }
}

*/