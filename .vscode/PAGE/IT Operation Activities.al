pageextension 50157 ITOperationActivities extends "IT Operations Activities"
{
    layout
    {
        // Add changes to page layout here
        modify("Intelligent Cloud") { Visible = false; }

        modify("Data Integration") { Visible = false; }
        modify("Data Privacy")
        {
            Visible = false;
        }

    }


    actions
    {




    }

    var
        myInt: Integer;
}