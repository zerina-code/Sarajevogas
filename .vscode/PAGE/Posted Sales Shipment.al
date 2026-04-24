pageextension 50111 "Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Document No."; "Document No.") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here

    }

    var
        myInt: Integer;
}