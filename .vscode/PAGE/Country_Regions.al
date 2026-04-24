pageextension 50026 Country_Region extends "Countries/Regions"
{

    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Country Code"; "Country Code")
            {
                ApplicationArea = all;
            }
        }
        modify("EU Country/Region Code")
        {
            Visible = false;
        }
        modify("Intrastat Code")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}