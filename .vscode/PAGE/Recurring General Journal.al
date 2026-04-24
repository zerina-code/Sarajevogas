pageextension 50076 Recurring_General_Journal extends "Recurring General Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Shortcut Dimension 1 Code")
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