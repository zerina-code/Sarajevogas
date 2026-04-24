page 50226 "Statements"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter(Statement));

    layout
    {
        area(Content)
        {
            field(Code; Code) { ApplicationArea = all; }
            field(Description; Description) { ApplicationArea = all; }

        }
    }


    var
        myInt: Integer;
}