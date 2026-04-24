pageextension 50074 "Purchasing Agent Extends" extends "Purchasing Agent Role Center"
{

    //ED 

    layout
    {
        modify(Control1900724808) { Visible = false; }
        addbefore(Control1900724808)
        {
            part(Test; "Purchase Agent Activities")
            {
                ApplicationArea = all;
            }
        }
        // Add   changes to page layout here
        modify("User Tasks Activities")
        {
            Visible = false;
        }
        modify(Control25)
        {
            Visible = false;
        }
        modify(Control21)
        {
            Visible = false;
        }
        modify(Control45)
        {
            Visible = false;
        }
        modify(Control1902476008)
        {
            Visible = false;
        }
        modify(Control1905989608)
        {
            Visible = false;
        }
    }


    actions
    {
        addafter("Posted Purchase Receipts")
        {
            action("Posted Whse Shipments")
            {
                ApplicationArea = Warehouse;
                Caption = 'Posted Whse Shipments';
                RunObject = Page "Posted Whse. Shipment List";
                ToolTip = 'Open the list of posted warehouse shipments.';
            }
        }

        addafter("Posted Purchase Credit Memos")
        {
            action("Posted Sales Invoices")
            {
                ApplicationArea = Purchase;
                Caption = 'Posted Sales Invoices';
                RunObject = Page "Posted Sales Invoice";
            }
            action("Posted Sales Credit Memos")
            {
                ApplicationArea = Purchase;
                Caption = 'Posted Sales Credit Memos';
                RunObject = Page "Posted Sales Credit Memos";
            }
        }


        addafter("Purchase &Line Discounts")
        {
            action(TransferOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Transfer Orders';
                Image = Report;
                RunObject = page "Transfer Orders";
            }
            action(EmployeeAbsence)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee Absence';
                Image = Report;
                RunObject = page "Employee Absence";
            }
            action("Sales Advance Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Advance Invoice';
                Image = Create;
                RunObject = Page "Sales Advance Invoice";
                RunPageMode = Create;
            }

            action("Sales Advance Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Advance Credit Memo';
                Image = Create;
                RunObject = Page "Sales Advanced Credit Memo";
                RunPageMode = Create;
            }
            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
            }
        }
        // Add changes to page actions here
        addbefore("Vendor - T&op 10 List")
        {
            action("Purchase Plans List")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Plans List';
                RunObject = Page "Purchase Plans List";
                RunPageMode = Edit;
                ToolTip = 'See all purchase plans or create a new plan.';
            }
            action("Contract List")
            {
                ApplicationArea = Suite;
                Caption = 'Contract List';
                RunObject = Page "Purchase Contract";
                RunPageMode = Edit;
                ToolTip = 'See a list of existing contracts or create a new contract.';
            }
            action("Vendor Detail Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Detail Trial Balance';
                RunObject = Report VendorDetailTrailBal;

            }
            action("Items by Location")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items by Location';
                RunObject = Page "Items by Location";
                ToolTip = 'View the actual quantity of the item per location.';
            }
        }

        modify("Navi&gate") { Visible = false; }
        modify(PurchaseOrders) { Visible = false; }
        modify("Purchase Quotes") { Visible = false; }
        modify("Blanket Purchase Orders") { Visible = false; }
        modify("Purchase Invoices") { Visible = false; }
        modify("Purchase Return Orders") { Visible = false; }
        modify(Vendors) { Visible = false; }
        modify("Purchase Journals") { Visible = false; }
        modify("Inventory Analysis Reports") { Visible = false; }
        modify("Purchase Analysis Reports") { Visible = false; }
        modify("Stockkeeping Units") { Visible = false; }
        modify(Items) { Visible = false; }
        modify("Sales Orders") { Visible = false; }
        modify("Assembly Orders") { Visible = false; }
        modify("Purchase Credit Memos") { Visible = false; }
        modify("Item Journals") { Visible = false; }
        modify(RequisitionWorksheets) { Visible = false; }
        modify(SubcontractingWorksheets) { Visible = false; }
        modify("Standard Cost Worksheets") { Visible = false; }
        modify("Catalog Items") { Visible = false; }
        modify("Requisition &Worksheet") { Visible = false; }
        modify("Posted Assembly Orders") { Visible = false; }
    }

    var
        GLEntry: Record "G/L Entry";
        CurrentYear: Integer;
        PurchaseAgentCue: Record "Purchase Cue";
}