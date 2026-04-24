page 50217 "Reason for Control"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Dismantling Reason";
    Caption = 'Reason for Control';
    SourceTableView = where(Type = filter("Reason for Control"));


    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Code; Code) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }

            }
        }
    }


    var
        myInt: Integer;


}