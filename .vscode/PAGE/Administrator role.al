pageextension 50156 AD extends "Administrator Role Center"
{
    layout
    {
        // Add changes to page layout here


        modify("User Tasks Activities")
        {
            Visible = false;
        }
        modify(Emails)
        {
            Visible = false;
        }
        modify(Control58)
        {
            Visible = false;
        }
        modify(Control52)
        {
            Visible = false;
        }
        modify(Control1900724708)
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("Check on Ne&gative Inventory")
        {
            Visible = false;
        }
        modify("Cases - Dynamics 365 Customer Service")
        {
            Visible = false;
        }
        modify("Approval User Setup")
        {
            Visible = false;
        }
        modify("Workflow User Groups")
        {
            Visible = false;
        }
        modify(Action57)
        {
            Visible = false;
        }
        modify("Data Templates List")
        {
            Visible = false;
        }
        modify("Base Calendar List")
        {
            Visible = false;
        }

        modify("Reason Codes")
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify(Intrastat)
        {
            Visible = false;
        }
        modify("VAT Registration Numbers")
        {
            Visible = false;
        }
        modify("Analysis View")
        {
            Visible = false;
        }
        modify("Data Privacy")
        {
            Visible = false;
        }
        modify("Purchase &Order")
        {
            Visible = false;
        }
        modify("Migration O&verview")
        {
            Visible = false;
        }
        modify("Relocate &Attachments")
        {
            Visible = false;
        }
        modify("Create Warehouse &Location")
        {
            Visible = false;
        }
        modify("Or&der Promising Setup")
        {
            Visible = false;
        }
        modify("Catalog &Item Setup")
        {
            Visible = false;
        }
        modify("Interaction &Template Setup")
        {
            Visible = false;
        }
        modify("Mini&forms")
        {
            Visible = false;
        }
        modify("Man&ufacturing Setup")
        {
            Visible = false;
        }
        modify("&Service Order Status Setup")
        {
            Visible = false;
        }
        modify("&Repair Status Setup")
        {
            Visible = false;
        }
        modify("&MapPoint Setup")
        {
            Visible = false;
        }
        modify("Profile Quest&ionnaire Setup")
        {
            Visible = false;
        }
        modify("&Report Selection")
        {
            Visible = false;
        }
        modify("&Date Compression")
        {
            Visible = false;
        }
        modify("Service Trou&bleshooting")
        {
            Visible = false;
        }
        modify("&Import")
        {
            Visible = false;
        }
        modify("&Sales Analysis")
        {
            Visible = false;
        }
        modify("P&urchase Analysis")
        {
            Visible = false;
        }



    }

    var
        myInt: Integer;
}