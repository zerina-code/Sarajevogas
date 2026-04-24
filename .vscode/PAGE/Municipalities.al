page 50006 Municipalities
{
    Caption = 'Municipalities';
    PageType = List;
    SourceTable = Municipality;
    // SourceTableView = where(Type = filter(Regular));
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                }
                field("Tax Number"; "Tax Number")
                {
                    ApplicationArea = all;
                }
                field("DP Code"; "DP Code")
                {
                    ApplicationArea = all;

                }
                field("Entity Code"; "Entity Code")
                {

                }

                field(City; City)
                {
                    ApplicationArea = all;
                }
                field("Canton Code"; "Canton Code")
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

