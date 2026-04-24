page 50052 "Positions Minimal Education"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Position Minimal Education";
    Caption = 'Position Minimal Education';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Name"; "Position Name")
                {
                    ApplicationArea = all;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = All;

                }
                field("Minimal Education Level"; "Minimal Education Level")
                {
                    ApplicationArea = all;
                }
                field("School of Graduation"; "School of Graduation")
                {

                }

            }

        }
    }



    var
        myInt: Integer;
}