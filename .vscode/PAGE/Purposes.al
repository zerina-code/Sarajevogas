page 50160 "Purposes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Purpose;
    Caption = 'Purpose';

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