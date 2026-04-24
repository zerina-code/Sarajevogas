page 50048 "Dial Codes"
{
    AutoSplitKey = true;
    Caption = 'Dial Codes';
    //DataCaptionFields = "Country Code";
    MultipleNewLines = false;
    PageType = List;
    SourceTable = "Dial Codes";

    layout
    {
        area(content)
        {
            repeater("K")
            {
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = all;
                }
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; "Country/Region Code")
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

