/*page 50015 "Cause of Absence Subtype"
{
    Caption = 'Cause of Absence Subtype';
    PageType = List;
    SourceTable = "Cause of Absence Subtype";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("S")
            {
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    ApplicationArea = all;
                }
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                }
                field("Allowed Days"; "Allowed Days")
                {
                    BlankZero = true;
                    ApplicationArea = all;
                }
                field(Level; Level)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
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