pageextension 50073 "Purchase Quote" extends "Purchase Quote"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify(Control5)
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here

    }



    var
        PurchaseContractTable: Record "Purchase Contract";
        PurchInvHeaderTable: Record "Purch. Inv. Header";
        PurchInvLineTable: Record "Purch. Inv. Line";
}