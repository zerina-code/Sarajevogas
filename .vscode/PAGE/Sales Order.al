pageextension 50160 Sales_Return_Order extends "Sales Return Order Subform"
{
    layout
    {
        // Add changes to page layout here

        modify("Appl.-from Item Entry")
        {
            Visible = true;
        }
        modify("Appl.-to Item Entry")
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