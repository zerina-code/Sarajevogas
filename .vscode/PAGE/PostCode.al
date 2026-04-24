pageextension 50056 PostCode extends "Post Codes"
{
    layout
    {
        // Add changes to page layout here
        modify(County)
        {
            Visible = false;
        }
        modify(TimeZone)
        {
            Visible = false;
        }
        addafter(City)
        {
            field("Canton Code"; "Canton Code")
            {
                ApplicationArea = all;
            }
            field("Entity Code"; "Entity Code")
            {
                ApplicationArea = all;
            }
            field("Transport Amount"; "Transport Amount")
            {
                ApplicationArea = all;
            }
            field("Health Check Amount"; "Health Check Amount")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}