/*page 50140 "Catastral Municipality"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Municipality;
    SourceTableView = where(Type = filter(KO));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    var
        myInt: Integer;
}*/