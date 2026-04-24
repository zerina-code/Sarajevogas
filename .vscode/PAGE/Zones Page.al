page 50120 Zones_Page
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zone_Table;
    Caption = 'Zone Page';

    layout
    {
        area(Content)
        {
            repeater("")
            {

                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description) { ApplicationArea = all; }

            }
        }
    }



    var
        myInt: Integer;
}