pageextension 50113 "Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Document No."; "Document No.") { Editable = false; Visible = false; }
            //NE field("Order Date"; "Order Date") { ApplicationArea = all; Editable = false; }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}