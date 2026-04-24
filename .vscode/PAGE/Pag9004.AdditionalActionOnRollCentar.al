pageextension 50012 "Add. Action On Roll Cenar" extends "Bookkeeper Role Center"
{
    layout
    {



        addbefore(Control1900724808)
        {
            part(Control1901197001; "Bookkeeper Activities")
            {
                ApplicationArea = Basic, Suite;
            }


        }


        modify(Control1900724708)
        {
            Visible = false;
        }


        modify(Control1900724808)
        {
            Visible = false;
        }
        modify(Control1902476008)
        {
            Visible = false;
        }

        modify(Control18) { Visible = False; }
        modify(Control1907692008) { Visible = false; }
        modify("User Tasks Activities") { Visible = false; }
        modify(ApprovalsActivities) { Visible = false; }
    }
    actions
    {

        modify(Approvals) { Visible = false; }
        modify("Intrastat Journals") { Visible = false; }
        modify("VAT - VI&ES Declaration Tax Auth") { Visible = false; }
        modify("VAT - VIES Declaration Dis&k") { Visible = false; }
        modify("EC &Sales List") { Visible = false; }
        modify("VAT E&xceptions") { Visible = false; }
        modify("VAT Reg&istration No. Check") { Visible = false; }
        modify("Reconcile Customer and &Vendor Accounts") { Visible = false; }
        modify("G/L - VAT Reconciliation") { Visible = false; }
        modify("Sa&les && Receivables Setup") { Visible = false; }
        modify("Adjust E&xchange Rates") { Visible = false; }
        modify("Post Inventor&y Cost to G/L") { Visible = false; }
        modify("Calc. and Pos&t VAT Settlement") { Visible = false; }
        modify("B&ank Account Reconciliations") { Visible = false; }
        modify("Payment Registration") { Visible = false; }
        modify("VAT State&ment") { Visible = false; }
        modify("VAT Statements") { Visible = false; }
        addbefore("Cash Re&ceipt Journal")
        {
            action("Accusation Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Accusation Document List';
                Image = Action;
                RunObject = page "Accusation Document List";
            }
        }

        addafter("Posted Purchase Receipts")
        {
            action("Posted Whse Shipments")
            {
                ApplicationArea = Warehouse;
                Caption = 'Posted Whse Shipments';
                RunObject = Page "Posted Whse. Shipment List";
                ToolTip = 'Open the list of posted warehouse shipments.';
            }
            action("Posted Service Invoices")
            {
                ApplicationArea = Service;
                Caption = 'Posted Service Invoices';
                Image = PostedServiceOrder;
                RunObject = Page "Posted Service Invoices";
                ToolTip = 'Open the list of posted service invoices.';
            }
        }

        addafter("Sales Orders")
        {

            action("Service Header")
            {
                ApplicationArea = Service;
                Caption = 'Service Header';
                Image = ViewServiceOrder;
                RunObject = Page "Service Orders";
                RunPageLink = "Request Type" = filter("Billing Invoice");

            }
            action("Posted Service Header")
            {
                ApplicationArea = Service;
                Caption = 'Posted Service Header';
                Image = PostedServiceOrder;
                RunObject = Page "Posted Service Invoices";
                RunPageLink = "Request Type" = filter("Billing Invoice");

            }
        }

        addafter("RecurringGeneralJournals")
        {
            action("Transfer Orders")
            {
                ApplicationArea = Service;
                Caption = 'Transfer Orders';
                Image = PostedServiceOrder;
                RunObject = Page "Transfer Orders";
            }
        }

        moveafter("C&ustomer"; "&Vendor")
        moveafter("Sales Credit &Memo"; "&Purchase Invoice")


        addafter("VAT State&ment")
        {

            action("PDV Prijava")
            {
                ApplicationArea = VAT;
                Caption = 'PDV Prijava';
                Image = "Report";
                RunObject = Report "PDV prijava";

            }


            action("Electronic book of purchase invoices")
            {
                ApplicationArea = VAT;
                Caption = 'Electronic book of purchase invoices';
                Image = "Report";
                RunObject = Report "Electronic Purchase VAT Book";
                ToolTip = 'View a electronic book of purchase invoices.';
            }

            action("Electronic book of sales invoices")
            {
                ApplicationArea = VAT;
                Caption = 'Electronic book of sales invoices';
                Image = "Report";
                RunObject = Report "Electronic Sales VAT Book";
                ToolTip = 'View a Electronic book of sales invoices.';

            }
            action("Purchase VAT Book")
            {
                ApplicationArea = VAT;
                Caption = 'Purchase VAT Book ';
                Image = "Report";
                RunObject = Report "Purchase VAT Book";
                ToolTip = 'View a Purchase VAT Book ';

            }
            action("Sales VAT Book")
            {
                ApplicationArea = VAT;
                Caption = 'Sales VAT Book';
                Image = "Report";
                RunObject = Report "Sales VAT Book";
                ToolTip = 'View a Sales VAT Book';

            }
            action("Purchase VAT Book-Import")
            {
                ApplicationArea = VAT;
                Caption = 'Purchase VAT Book-Import';
                Image = "Report";
                RunObject = Report "Purchase VAT Book-Import";
                ToolTip = 'View a Purchase VAT Book-Import';

            }
            action("Purchase VAT Book-Advance")
            {
                ApplicationArea = VAT;
                Caption = 'Purchase VAT Book-Advancet';
                Image = "Report";
                RunObject = Report "Purchase VAT Book-Advance";
                ToolTip = 'View a Purchase VAT Book-Advance';

            }

        }



        addafter("&Purchase Invoice")
        {

            action("Purchase Advance Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Advance Invoice';
                Image = Create;
                RunObject = Page "Purchase Advance Invoice";
                // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
            }

            action("Purchase Advanced Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Advanced Credit Memo';
                Image = Create;
                RunObject = Page "Purchase Advanced Credit Memo";
                // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
            }



        }

        addafter("Sales Credit &Memo")
        {
            action("Sales Advance Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Advance Invoice';
                Image = Create;
                RunObject = Page "Sales Advance Invoice";
                RunPageMode = Create;
                // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
            }

            action("Sales Advance Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Advance Credit Memo';
                Image = Create;
                RunObject = Page "Sales Advanced Credit Memo";
                RunPageMode = Create;
                // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
            }


        }
        addafter(Approvals)
        {
            action("Purchase Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memo';
                Image = Create;

                RunObject = Page "Purchase Credit Memos";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase credit memo to revert a posted purchase invoice.';


            }
            action("Sales Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memos';
                Image = Create;

                RunObject = Page "Sales Credit Memos";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memos to revert a posted purchase invoice.';

            }
        }
        modify("&G/L Trial Balance") { Visible = false; }
        addfirst("&Trial Balance")
        {
            action("&G/L Trial Balance - test")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&G/L Trial Balance';
                Image = "Report";
                RunObject = Report "DetailTrialBalance";
                ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
            }


        }
        addbefore("Sales &Fin. Charge Memo")
        {
            action("Purchase Credit Memo1")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memo';
                Image = Create;

                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase credit memo to revert a posted purchase invoice.';
            }
        }

        addlast("&Trial Balance")
        {

            action("Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance';
                Image = "Report";
                RunObject = Report "Trial Balance Test";
                //ToolTip = 'View this year''s and last year''s figures as an ordinary trial balance. For income statement accounts, the balances are shown without closing entries. Closing entries are listed on a fictitious date that falls between the last day of one fiscal year and the first day of the next one. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
            }
        }

    }


}