pageextension 50039 GeneralJournal extends "General Journal"
{
    layout
    {
        modify("Document Date") { Visible = true; }
        // Add changes to page layout here
        modify("Document Type")
        {
            Visible = VisibleI;
        }
        modify("External Document No.")
        {
            Visible = true;
        }




        modify("<Document No. Simple Page>")
        {
            Visible = VisibleI;
        }
        modify("<CurrentPostingDate>")
        {
            Visible = VisibleI;
        }
        movebefore(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")

        modify("Account Name")
        {
            Visible = VisibleI;
        }
        modify("<CurrentCurrencyCode>")
        {
            Visible = VisibleI;
        }
        modify("Currency Code")
        {
            Visible = VisibleI;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = VisibleI;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = VisibleI;
        }

        modify("Gen. Prod. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("Total Debit")
        {
            Visible = VisibleI;
        }

        modify("Total Credit")
        {
            Visible = VisibleI;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = VisibleI;
        }

        modify("Bal. Gen. Posting Type")
        {
            Visible = VisibleI;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Business Unit Code")
        {
            Visible = false;
        }

        modify(AccName)
        {
            Visible = VisibleI;
        }


        modify(Control1900919607)
        {
            Visible = VisibleI;
        }
        modify(JournalLineDetails)
        {
            Visible = VisibleI;
        }




        addafter("Posting Date")
        {
            field("Line No."; "Line No.")
            {

            }
            field(KUF_Entry; KUF_Entry)
            {

            }
        }
        addbefore(Amount)
        {
            field("Posting Group"; "Posting Group")
            {
                Editable = true;
            }
        }
        addafter("Account No.")
        {
            field(Employee; Employee) { ApplicationArea = all; }
            field(Contact; Contact) { ApplicationArea = all; }
            field("Bill Type"; "Bill Type") { ApplicationArea = all; }
            field("Prepayment"; Prepayment) { ApplicationArea = all; }
            field("Due Date"; Rec."Due Date") { }
        }



    }


    actions
    {
        modify("Test Report") { Visible = false; }
        addafter("Test Report")
        {
            action("Test Report1")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Report';
                Ellipsis = true;
                Image = TestReport;
                ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                trigger OnAction()
                begin
                    ReportPrint1.PrintGenJnlLine(Rec);
                end;
            }
            action("Import lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import lines';
                Ellipsis = true;
                Image = ImportExcel;

                trigger OnAction()
                var
                    Im: XmlPort "FA Import";
                begin
                    Im.Run;
                end;
            }

            action("Correction")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Correction';
                Ellipsis = true;
                Image = TestReport;


                trigger OnAction()
                var
                    filter: text[250];
                begin

                    Rec.FINDFIRST;
                    BEGIN
                        filter := Rec.GETFILTERS;
                        IF Rec.Correction = FALSE THEN BEGIN
                            REPEAT
                                Rec.Correction := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        ELSE BEGIN
                            REPEAT
                                Rec.Correction := FALSE;
                                Rec.MODIFY;

                            UNTIL Rec.NEXT = 0


                        END;
                    END;

                end;


            }

        }

        addafter(PostAndPrint)
        {
            action("Change Date")
            {
                Caption = 'Change Date';
                ApplicationArea = all;
                Image = DateRange;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    GenJournal: Record "Gen. Journal Line";
                    Text003: Label 'Do you want to change date in journal to current date?';
                begin

                    IF CONFIRM(Text003) THEN BEGIN
                        GenJournal.SETFILTER("Document No.", '<>%1', '');
                        IF GenJournal.FINDFIRST THEN
                            REPEAT
                                GenJournal.VALIDATE("Posting Date", TODAY);
                                GenJournal.VALIDATE("Document Date", TODAY);
                                GenJournal.MODIFY;
                            UNTIL GenJournal.NEXT = 0;
                    END;
                    MESSAGE('Promjena je izvršena. Osvježite stranicu da biste vidjeli nalog sa tekućim datumom');


                end;



            }
        }
        modify(Reconcile)
        {
            Visible = VisibleI;
        }
        modify(IncomingDocCard)
        {
            Visible = VisibleI;
        }
        modify(PreviousDocNumberTrx)
        {
            Visible = VisibleI;
        }
        modify(NextDocNumberTrx)
        {
            Visible = VisibleI;
        }
        modify(ClassicView)
        {
            Visible = VisibleI;
        }
        modify(SimpleView)
        {
            Visible = VisibleI;
        }
        modify("New Doc No.")
        {
            Visible = VisibleI;
        }
        modify("Apply Entries")
        {
            Visible = VisibleI;
        }
        // Add changes to page actions here
        modify(Dimensions)
        {
            Visible = VisibleI;
        }
        modify(Card)
        {
            Visible = VisibleI;
        }
        modify("Ledger E&ntries")
        {
            Visible = VisibleI;
        }
        modify(Approvals)
        {
            Visible = VisibleI;
        }
        modify("Renumber Document Numbers")
        {
            Visible = VisibleI;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            Visible = VisibleI;
        }
        modify(GetStandardJournals)
        {
            Visible = VisibleI;
        }
        modify(SaveAsStandardJournal)
        {
            Visible = VisibleI;
        }
        modify("Remove From Job Queue")
        {
            Visible = false;
        }

        modify(DeferralSchedule) { Visible = VisibleI; }
        modify(IncomingDocument) { Visible = VisibleI; }
        modify(SelectIncomingDoc) { Visible = VisibleI; }
        modify(IncomingDocAttachFile) { Visible = VisibleI; }
        modify(RemoveIncomingDoc) { Visible = VisibleI; }
        modify("B&ank") { Visible = VisibleI; }
        modify(Application) { Visible = VisibleI; }
        modify("Payro&ll") { Visible = VisibleI; }
        modify("Request Approval") { Visible = VisibleI; }
        modify(SendApprovalRequest) { Visible = VisibleI; }
        modify(SendApprovalRequestJournalBatch) { Visible = VisibleI; }
        modify(SendApprovalRequestJournalLine) { Visible = VisibleI; }
        modify(CancelApprovalRequestJournalBatch) { Visible = VisibleI; }
        modify(CancelApprovalRequestJournalLine) { Visible = VisibleI; }
        modify(SeeFlows) { Visible = false; }


        modify(CancelApprovalRequest) { Visible = VisibleI; }
        modify(CreateFlow) { Visible = false; }
        modify(Approval) { Visible = VisibleI; }
        modify(Approve) { Visible = VisibleI; }
        modify(Reject) { Visible = VisibleI; }
        modify(Delegate) { Visible = VisibleI; }
        modify(Comments) { Visible = VisibleI; }

        modify("Opening Balance") { Visible = VisibleI; }
        modify("G/L Accounts Opening balance ") { Visible = VisibleI; }
        modify("Customers Opening balance") { Visible = VisibleI; }
        modify("Vendors Opening balance") { Visible = VisibleI; }

        modify(Page) { Visible = VisibleI; }

        modify(Errors) { Visible = VisibleI; }


    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        WS: Record "Wage Setup";

    begin

        WS.Get();
        if Rec."Journal Batch Name" = WS."Wage Batch Name" then begin
            VisibleI := false;
        end
        else begin
            VisibleI := true;

        end;
    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
        WS: Record "Wage Setup";

    begin

        WS.Get();
        if Rec."Journal Batch Name" = WS."Wage Batch Name" then begin
            VisibleI := false;
        end
        else begin
            VisibleI := true;

        end;




    end;

    var

        ReportPrint1: Codeunit "Test Report-Print";
        myInt: Integer;
        VisibleI: Boolean;
}