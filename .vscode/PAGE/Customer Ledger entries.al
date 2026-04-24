pageextension 50028 CustomerLedgerEntriesExtension extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field("Bin Checked"; "Bin Checked")
            {
                ApplicationArea = All;
            }
        }

        // Add changes to page layout here
        addafter("Credit Amount (LCY)")
        {
            field("Profit (LCY)"; "Profit (LCY)")
            {
                ApplicationArea = All;
            }

        }
        addbefore("Customer No.")
        {
            field("Cashier Employer"; "Cashier Employer")
            { ApplicationArea = all; }
        }
        addafter("Bal. Account No.")
        {
            field("G/L Account"; "G/L Account")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {
            field("Due Date 2"; "Due Date 2")
            {
                ApplicationArea = All;
            }
            field("Due Date 3"; "Due Date 3")
            {
                ApplicationArea = All;
            }
        }
        addafter("Exported to Payment File")
        {
            field(Compensation; Compensation)
            {
                ApplicationArea = All;
            }
            field(Prepayment; Prepayment)
            {
                ApplicationArea = All;
            }
        }
        addafter("Message to Recipient") { field("Payment Reference"; "Payment Reference") { ApplicationArea = all; } }

    }
    actions
    {

        addafter("ShowDocumentAttachment")
        {

            action("Incoming Document")
            {

                Caption = 'Incoming Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                RunObject = report "Print of journal entries";

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                begin
                    //ĐKIncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
                end;
                //  RunObject = report "";
            }
        }
    }



    var
        myInt: Integer;
}