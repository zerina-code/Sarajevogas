pageextension 50040 GeneralLedgerEntriesExtension extends "General Ledger Entries"
{

    layout
    {
        addafter("External Document No.")
        {
            field(KIF_Entry; KIF_Entry) { }
            field(KUF_Entry; KUF_Entry) { }
        }
        // Add changes to page layout here
        addafter(Description)
        {
            field("Source No."; "Source No.")
            {
                ApplicationArea = All;
            }
            field("Journal Batch Name"; "Journal Batch Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Payment Type Code"; "Payment Type Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Payment Method"; "Payment Method")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Cashier Code"; "Cashier Code")
            {
                ApplicationArea = All;
                Visible = false;
            }

        }
        modify("Debit Amount") { Visible = true; }
        modify("Credit Amount") { Visible = true; }
        modify("Gen. Bus. Posting Group") { Visible = false; }
        modify("Gen. Posting Type") { Visible = false; }
        modify("Gen. Prod. Posting Group") { Visible = false; }
        modify("Amount") { Visible = false; }

        addafter("Source No.")
        {
            field("Employee No."; "Employee No.") { ApplicationArea = all; }
            field("Contact link"; "Contact link") { ApplicationArea = all; }
        }

    }

    actions
    {

        addafter("Value Entries")
        {

            action("Print")
            {
                Caption = 'Print';
                Image = ValueLedger;

                RunObject = report "Print of journal entries";

                //  RunObject = report "";
            }
            action("IMPORT GK")
            {
                Caption = 'Print';
                Image = ValueLedger;

                RunObject = xmlport "Import GK";

                //  RunObject = report "";
            }
        }
        addafter("DocsWithoutIC")
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
                    //ĐK   IncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
                end;
                //  RunObject = report "";
            } // Add changes to page actions here
        }

    }
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("G/L Account No.", '<>%1', 'VB');
        Rec.FILTERGROUP(0);

    end;




    var
        myInt: Integer;
        IncomingDocument: Record "Incoming Document";

}