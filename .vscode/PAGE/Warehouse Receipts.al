pageextension 59155 "Warehouse Receipts" extends "Warehouse Receipts"
{
    layout
    {
        // Add changes to page layout here

        addafter("Assigned User ID")
        {
            field("User ID Number"; "User ID Number") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}