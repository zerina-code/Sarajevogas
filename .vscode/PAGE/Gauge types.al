/*page 50096 "Gauge Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter("Gauge Type"));
    Caption = 'Gauge type';


    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field(Description; Description) { }


            }
        }
    }


    var
        myInt: Integer;
}*/