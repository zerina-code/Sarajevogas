page 50082 "Sales Advance Invoice"
{
    // BH1.01, Postponed VAT

    Caption = 'Sales Advanced Invoice';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));

    layout
    {

        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {

                    trigger OnValidate()
                    begin
                        IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                            IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    Importance = Additional;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    Importance = Additional;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Importance = Additional;
                }
                field("Sell-to City"; "Sell-to City")
                {
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                    Importance = Promoted;
                }

                field("Document Date"; "Document Date")
                {
                }
                field("Incoming Document Entry No."; "Incoming Document Entry No.")
                {
                    Visible = false;
                }
                field("VAT Date"; "VAT Date")
                {
                }
                field("External Document No."; "External Document No.")
                {
                    Importance = Promoted;
                }
                field("Salesperson Code"; "Salesperson Code")
                {

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; "Campaign No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    Importance = Additional;
                }
                field("Job Queue Status"; "Job Queue Status")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field(Status; Status)
                {
                    Importance = Promoted;
                }
                field("Posting No. Series"; "Posting No. Series")
                {

                }
                field("Posting Description"; "Posting Description")
                {
                    Editable = TRUE;
                    VISIBLE = TRUE;
                }
                field("Customer Posting Group"; "Customer Posting Group") { ApplicationArea = all; Editable = true; }
                field("Payment Type Invoice"; "Payment Type Invoice") { Visible = true; editable = false; }
                field(KIF_Entry; KIF_Entry) { Visible = true; }
            }
            part(SalesLines; "Sales Invoice Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    Importance = Additional;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    Importance = Additional;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Importance = Additional;
                }
                field("Bill-to City"; "Bill-to City")
                {
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Due Date"; "Due Date")
                {
                    Importance = Promoted;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    Visible = false; //ED
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    Importance = Additional;
                    Visible = false; //ED
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                }
                field("Direct Debit Mandate ID"; "Direct Debit Mandate ID")
                {
                    Visible = false; //ED
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("Credit Card No."; "Credit Card No.")
                {
                }
                /*      field(GetCreditcardNumber; GetCreditcardNumber)
                      {
                          Caption = 'Cr. Card Number (Last 4 Digits)';
                      }*/
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; "Ship-to Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    Importance = Additional;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    Importance = Additional;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to City"; "Ship-to City")
                {
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    Importance = Additional;
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    Importance = Additional;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false; //ED

                field("Currency Code"; "Currency Code")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        IF "Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field("Exit Point"; "Exit Point")
                {
                }
                field("Area"; "Area")
                {
                }
            }
        }
        area(factboxes)
        {
            part("Sales hist. Sell-to FactBox"; "Sales hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            systempart(RecordLinks; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Customer)
                {
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }

            }
            /*ĐK  group("Credit Card")
             {
                 Caption = 'Credit Card';
                 Image = CreditCardLog;
                 action("Credit Cards Transaction Lo&g Entries")
                 {
                     Caption = 'Credit Cards Transaction Lo&g Entries';
                     Image = CreditCardLog;
                     RunObject = Page ;
                     RunPageLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("No."),
                                   "Customer No." = FIELD("Bill-to Customer No.");
                 }
             }*/
        }
        area(processing)
        {
            group(Release2)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }

            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }

                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }

                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }

                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }

            }
            group("Credit Card2")
            {
                Caption = 'Credit Card';
                Image = AuthorizeCreditCard;
                action(Authorize)
                {
                    Caption = 'Authorize';
                    Image = AuthorizeCreditCard;

                    trigger OnAction()
                    begin
                        //ĐK    Authorize;
                    end;
                }
                action("Void A&uthorize")
                {
                    Caption = 'Void A&uthorize';
                    Image = VoidCreditCard;

                    trigger OnAction()
                    begin
                        //Đk  Void;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post3)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //INT1.00 start
                        TESTFIELD("VAT Date");
                        //     TESTFIELD("Salesperson Code");
                        //INT1.00 end
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }

                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    var
                        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
                    begin
                        SalesPostYesNo.Preview(Rec);
                    end;
                }

                action("Test post")
                {
                    Caption = 'Test post';
                    Image = TestFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //NK01 Start
                        //INT1.00 start
                        TESTFIELD("VAT Date");
                        // TESTFIELD("Salesperson Code");
                        //INT1.00 end
                        StartCompanyNotes.ClearTempGLE;
                        StartCompanyNotes.SetPostingPrediction;
                        IF NOT CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", Rec) THEN BEGIN
                            IF StartCompanyNotes.GetTestDoneOk THEN BEGIN
                                StartCompanyNotes.ResetPostingPrediction;
                                //AS1.00 START
                                ok := DIALOG.CONFIRM('Do you want to see details?');
                                StartCompanyNotes.GetPostingPredictionData(ok);
                                //AS1.00 END
                            END
                            ELSE BEGIN
                                ERROR(StartCompanyNotes.GetParamT('ERR50003'));
                            END
                        END
                        ELSE BEGIN
                            StartCompanyNotes.ResetPostingPrediction;
                            IF StartCompanyNotes.GetTestDoneOk THEN
                                ERROR(StartCompanyNotes.GetParamT('ERR50002'));
                        END
                        //NK01 End
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        //INT1.00 start
                        TESTFIELD("VAT Date");
                        //   TESTFIELD("Salesperson Code");
                        //INT1.00 end
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        //INT1.00 start
                        TESTFIELD("VAT Date");
                        //  TESTFIELD("Salesperson Code");
                        //INT1.00 end
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Prepayment := TRUE;

        SalesSetup.Get();
        if Rec.Prepayment = true then begin
            "No. Series" := SalesSetup."Prepayment Invoice Nos.";
            "Posting No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";

        end


    end;









    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        CustomerT: Record "Customer Templ.";
        CustomerPage: page "Customer Templ. List";
        UserSetup: Record "User Setup";
        SalesH: Record "Sales Header";
        SalesO: page "Sales Order";
        SalesOH: Record "Sales Header";
        Docno: text[250];
        NoSeriesMgt: Codeunit NoSeriesExtented;


        SalesSetup: Record "Sales & Receivables Setup";
    begin
        begin
            SalesSetup.Get();

            CLEAR(CustomerPage);
            CustomerT.Reset();
            UserSetup.Reset();
            UserSetup.SetFilter("User ID", '%1', UserId);
            if UserSetup.FindFirst() then begin
                if (UserSetup.Household <> 0) or (UserSetup.Household <> 0) then begin
                    CustomerPage.SetTableView(CustomerT);
                end;


            end;

            // CustomerPage.Run();
            CustomerPage.LOOKUPMODE(TRUE);
            IF CustomerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                CustomerPage.GETRECORD(CustomerT);
                "Payment Type Invoice" := CustomerT.Code;


                /* if CustomerT.NN = true then begin

                     SalesH.Init();
                     SalesH."Bill type" := CustomerT.Code;
                     SalesH.Validate("Document Type", SalesH."Document Type"::Order);
                     SalesH.validate("Document Date", Today);
                     SalesH.validate("VAT Date", today);
                     Docno := NoSeriesMgt.GetNextNo(SalesSetup."Order Nos.", TODAY, false);
                     SalesH.Validate("No.", Docno);
                     SalesH.Validate("Assigned User ID", UserId);
                     SalesH.validate("Order Date", today);
                     SalesH.validate("Posting Date", today);
                     SalesH.Validate("Sell-to Customer No.", SalesSetup."NN Customer Code");
                     SalesH.Insert();

                     SalesH.Reset();
                     SalesH.SetFilter("No.", '%1', Docno);
                     CurrPage.Close();
                     SalesO.SetTableView(SalesH);
                     Commit();
                     SalesO.Run();
                     Commit();




                 end;*/

                "Responsibility Center" := UserMgt.GetSalesFilter;
                Prepayment := TRUE;
                SalesSetup.Get();
                if Rec.Prepayment = true then begin
                    "No. Series" := SalesSetup."Prepayment Invoice Nos.";
                    "Posting No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";

                end

            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            FILTERGROUP(0);
        END;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        [InDataSet]
        JobQueueVisible: Boolean;
        StartCompanyNotes: Codeunit "Start Company Notes";
        ok: Boolean;
        SalesSetup: Record "Sales & Receivables Setup";


    procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
            IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        //ĐK   CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;
}

