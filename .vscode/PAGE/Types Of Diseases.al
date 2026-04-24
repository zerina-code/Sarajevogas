page 50159 "Types Of Diseases"
{
    Caption = 'Types Of Diseases';
    PageType = List;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter("Types Of Diseases"));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
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

