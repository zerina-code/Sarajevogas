page 50207 "KIF KUF Logs"
{
    Caption = 'KIF or KUF Logs';
    PageType = List;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter("KIF KUF Logs"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Year; Year)
                {

                }
                field(Month; Month)
                {

                }
                field(Type; Type)
                {

                }
                field("Number No. from"; "Number No. from")
                {

                }
                field("Number No. to"; "Number No. to")
                {

                }

            }
        }
    }

    actions
    {
    }
}

