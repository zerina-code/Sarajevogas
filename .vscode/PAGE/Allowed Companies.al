pageextension 50103 "Allowed Companies" extends "Allowed Companies"
{
    layout
    {
        // Add changes to page layout here
        modify("Evaluation Company")
        {
            Visible = false;
        }
        modify(SetupStatus)
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