pageextension 50117 PostedPurchaseRcptSubform extends "Posted Purchase Rcpt. Subform"
{
    Editable = true;
    layout
    {



        addafter(Description)
        {
            field("Print Quantity"; "Print Quantity")
            {
                ApplicationArea = all;
                Editable = true;


            }
        }
        modify("Type") { Editable = false; }
        modify("No.") { Editable = false; }
        modify("Description") { Editable = false; }
        modify("Location Code") { Editable = false; }
        modify(Quantity) { Editable = false; }
        modify("Unit of Measure Code") { Editable = false; }
        modify("Quantity Invoiced") { Editable = false; }
        modify("Expected Receipt Date") { Editable = false; }
        modify("Planned Receipt Date") { Editable = false; }
        modify("Order Date") { Editable = false; }

    }


}


