pageextension 50154 PostedWhseReceipttist extends "Posted Whse. Receipt List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetCurrentKey("No.");
        Ascending(false);

    end;

    var
        myInt: Integer;
}