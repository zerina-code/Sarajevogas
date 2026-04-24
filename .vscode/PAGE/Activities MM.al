page 50158 "Activities MM"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "MM Activity";
    Caption = 'Activities MM';


    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }

            }
        }
    }


    var
        myInt: Integer;
}