pageextension 50041 GeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Show Amounts")
        {
            field("Is Simple Page"; "Is Simple Page")
            {
                ApplicationArea = all;
            }
            field("Undo Shipment for CP"; "Undo Shipment for CP") { ApplicationArea = all; }
            field("Undo Warehouse Receipt"; "Undo Warehouse Receipt") { }
            field("Posted Undo Warehouse Receipt"; "Posted Undo Warehouse Receipt") { }
            field("Path for fiscal printer"; "Path for fiscal printer")
            {
                ApplicationArea = all;
            }
            field("Path for Pay Slip"; "Path for pay slip")
            {
                ApplicationArea = all;
            }
            field("Sleep value"; "Sleep value") { ApplicationArea = all; }
            field("Number of Days"; "Number of Days") { }
            field("Path for import txt file"; "Path for import txt file") { ApplicationArea = all; }
            field("Path for copy txt file"; "Path for copy txt file") { ApplicationArea = all; }


        }
        addafter("Bank Account Nos.")

        {
            field("Z.Obligation Series"; "Z.Obligation Series") { }
            field("R.Obligation Series"; "R.Obligation Series") { }
            field("Customer Contract Entry"; "Customer Contract Entry") { }
            field("Retail Calculation Entry Series"; "Retail Calc. Entry Series") { }
            field("Repost Journal Template"; "Repost Journal Template") { ApplicationArea = all; }
            field("Repost Batch Name"; "Repost Batch Name") { ApplicationArea = all; }
            field("Cash Receipt Journal Template"; "Cash Receipt Journal Template") { ApplicationArea = all; }
            field("Cash Batch Name"; "Cash Batch Name") { ApplicationArea = all; }
            field("Wholesale Calculation Entry Series"; "Wholesale Calc. Entry Series") { }
            field("Nivelacija No. Series"; "Nivelacija No. Series") { }
            field("Purch. Retail Calculation Entry Series"; "Purch. Retail C. Entry Series") { }
            field("Purch. Wholesale Calculation Entry Series"; "Purch.Wholesale C.Entry Series") { }
            field("Group Retail Calculation Entry Series"; "Group Retail Calculation Entry Series") { }
            field("Group Retail Calculation Entry Series VP"; "Group Retail Calculation Entry Series VP") { }
            field("G_L Entry"; "G_L Entry") { ApplicationArea = all; }
            field("VAT Bus VL"; "VAT Bus VL") { }
            field("Gauge Code"; "Gauge Code") { ApplicationArea = all; }
            field("Radio Module Code"; "Radio Module Code") { ApplicationArea = all; }
            field("Accusation Entry Series"; "Accusation Entry Series") { }
            field("Accusation Record Entry Series"; "Accusation Record Entry Series") { }
            field("Court Number Entry Series"; "Court Number Entry Series") { }
            field("Hearing Entry Series"; "Hearing Entry Series") { }
            field("Status Entry Series"; "Status Entry Series") { }
            field("Type Entry Series"; "Type Entry Series") { }
            field("History Entry Series"; "History Entry Series") { }
            field("Massive RN"; "Massive RN") { }
            field("Interest Yearly Rate"; "Interest Yearly Rate") { }
            field("Number of Days Necessary before Interest Calculation"; "Number of Days Necessary before Interest Calculation") { }
            field("Send name e-mail"; "Send name e-mail") { }
            field("Send email"; "Send email") { }
            field("Export Report Path"; "Export Report Path") { }
            field("Reminder Line Entry Series"; "Reminder Line Entry Series") { }
            field("Interest Comfort Coefficient"; "Interest Comfort Coefficient") { }
            field("Interest Normal Coefficient"; "Interest Normal Coefficient") { }
            field("Issued Reminder Entry Series"; "Issued Reminder Entry Series") { }
            field("Issued Reminder Line Entry Series"; "Issued Reminder Line Entry Series") { }
            field("Interest Rate Document Entry Series"; "Interest Rate Document Entry Series") { }
            field("Interest Setup"; "Interest Setup")
            {
                DrillDownPageId = 50061;
            }
            field("CNG Amount Rounding Precision"; "CNG Amount Rounding Precision") { }
            field("CNG Amount SG"; "CNG Amount SG") { }


        }

        modify("Background Posting") { Visible = false; }
        addafter("Bank Account Nos.")
        {
            field("No. series for S.Inventory"; "No. series for S.Inventory")
            { }
            field("No. series for Shipment A"; "No. series for Shipment A") { ApplicationArea = all; }
            field("Vendor Invoice No."; "Vendor Invoice No.") { ApplicationArea = all; }
            field("Doubtful rec. No. series"; "Doubtful rec. No. series") { ApplicationArea = all; }

        }


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}