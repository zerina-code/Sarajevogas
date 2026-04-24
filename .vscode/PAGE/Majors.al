/*page 50080 Majors
{
    Caption = 'Majors';
    PageType = List;
    SourceTable = Majors;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Major; Major)
                {
                    ApplicationArea = all;
                }
                field(Profession; Profession)
                {
                    ApplicationArea = all;
                }
                field("Profession Description"; "Profession Description")
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