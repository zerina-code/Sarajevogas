/*page 50102 "Document Footers"
{
    // //SKHR7.00 Croatian Localization

    Caption = 'Document Footers';
    PageType = List;
    SourceTable = "Document Footer";

    layout
    {
        area(content)
        {
            repeater(L)
            {
                field("Language Code"; "Language Code")
                {
                }
                field("Footer Text"; "Footer Text")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage.UPDATE;
    end;

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("Primary key");
        ASCENDING(TRUE);
    end;
}

*/