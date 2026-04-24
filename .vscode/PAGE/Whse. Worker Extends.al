pageextension 50085 "Whse. Worker Extends" extends "Whse. Worker WMS Role Center"
{

    //ED 

    layout
    {
        // Add   changes to page layout here
        modify(Control7)
        {
            Visible = false;
        }
        modify("User Tasks Activities")
        {
            Visible = false;
        }
        modify(Control1006)
        {
            Visible = false;
        }
        modify(Control4)
        {
            Visible = false;
        }
        modify(Control1905989608)
        {
            Visible = false;
        }
        modify(Control6)
        {
            Visible = false;
        }
    }

    actions
    {
        addbefore("Whse. P&hysical Invt. Journal")
        {
            action(WhseReceipts2)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Receipts';
                RunObject = Page "Warehouse Receipts";
                ToolTip = 'View the list of ongoing warehouse receipts.';
            }
            action(WhseShpt2)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Shipments';
                RunObject = Page "Warehouse Shipment List";
                ToolTip = 'View the list of ongoing warehouse shipments.';
            }
            action("Transfer Orders 2")
            {
                ApplicationArea = Location;
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page "Transfer Orders";
                ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
            }
        }
        addafter("Prod. &Order Picking List")
        {
            action("Items by Location")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Artikli po lokaciji';
                RunObject = Page "Items by Location";
            }
        }

        modify("Bin Contents")
        {
            Visible = false;
        }
        modify("Assembly Orders")
        {
            Visible = false;
        }
        modify(Picks)
        {
            Visible = false;
        }
        modify("Put-aways")
        {
            Visible = false;
        }
        modify(Movements)
        {
            Visible = false;
        }
        modify(WhseReceipts)
        {
            Visible = false;
        }
        modify(WhseShpt)
        {
            Visible = false;
        }
        modify("Transfer Orders")
        {
            Visible = false;
        }
        modify("Warehouse &Bin List")
        {
            Visible = false;
        }
        modify("Warehouse A&djustment Bin")
        {
            Visible = false;
        }
        modify("Customer &Labels")
        {
            Visible = false;
        }
    }
}