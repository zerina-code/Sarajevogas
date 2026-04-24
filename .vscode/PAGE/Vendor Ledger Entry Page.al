pageextension 50098 VendorLedgerEntriesExtension extends "Vendor Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Max. Payment Tolerance")
        {
            field("G/L Account"; "G/L Account")
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
                    //ĐK    IncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
                end;
                //  RunObject = report "";
            }
        }
    }



    var
        myInt: Integer;
}