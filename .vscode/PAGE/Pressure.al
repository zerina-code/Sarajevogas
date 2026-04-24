page 50229 "Pressure"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter("Pressure"));
    Caption = 'Pressure';




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
}