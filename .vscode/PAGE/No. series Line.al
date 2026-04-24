pageextension 50054 NoSeriesLine extends "No. Series Lines"
{
    layout
    {
        // Add changes to page layout here
        modify("Allow Gaps in Nos.")
        {
            Visible = false;
        }
        modify("Series Code")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}