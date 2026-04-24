page 50134 "Purchase Advance Invoice"
{
    // //BH1.01, Postponed VAT

    Caption = 'Purchase Invoice';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "Purchase Is Finished" = CONST(true), Prepayment = const(true));
    //ĐK

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
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; "Buy-from Contact No.")
                {
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                    Importance = Additional;
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                    Importance = Additional;
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    Importance = Additional;
                }
                field("Buy-from City"; "Buy-from City")
                {
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    Importance = Additional;
                }
                field("Posting Date"; "Posting Date")
                {
                    Importance = Promoted;
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Order Date"; "Order Date")
                {
                    Caption = 'Order Date';
                }
                field("Incoming Document Entry No."; "Incoming Document Entry No.")
                {
                    Visible = false;
                }
                field("VAT Date"; "VAT Date")
                {
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                }
                field("Order Address Code"; "Order Address Code")
                {
                    Visible = false;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
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
                }
                field("Job Queue Status"; "Job Queue Status")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Vendor Order No."; "Vendor Order No.")
                {
                }
                field(Status; Status)
                {
                    Importance = Promoted;
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Posting No. Series"; "Posting No. Series")
                {

                }
                field("Posting Description"; "Posting Description")
                {
                    Visible = true;
                    Editable = true;
                }
                field(KUF; KUF) { ApplicationArea = all; Visible = true; }
            }
            part(PurchLines; 55)
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; "Pay-to Contact No.")
                {
                    Importance = Additional;
                }
                field("Pay-to Name"; "Pay-to Name")
                {
                }
                field("Pay-to Address"; "Pay-to Address")
                {
                    Importance = Additional;
                }
                field("Pay-to Address 2"; "Pay-to Address 2")
                {
                    Importance = Additional;
                }
                field("Pay-to Post Code"; "Pay-to Post Code")
                {
                    Importance = Additional;
                }
                field("Pay-to City"; "Pay-to City")
                {
                }
                field("Pay-to Contact"; "Pay-to Contact")
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
                field("Payment Reference"; "Payment Reference")
                {
                }
                field("Creditor No."; "Creditor No.")
                {
                    Visible = false; //ED
                }
                field("On Hold"; "On Hold")
                {
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
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; "Ship-to Name")
                {
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                }
                field("Ship-to City"; "Ship-to City")
                {
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                }
                field("Location Code"; "Location Code")
                {
                    Importance = Promoted;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
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
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field("Entry Point"; "Entry Point")
                {
                }
                field("Area"; "Area")
                {
                }
            }
        }
        area(factboxes)
        {
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part("Purchase Line FactBox"; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
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
                action("Allocation keys")
                {
                    Image = Allocate;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        PAGE.RUN(50083);
                    end;
                }
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
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
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
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
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

                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
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
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action(MoveNegativeLines)
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
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
                        //NK IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
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
                        //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Preview)
                {
                    ApplicationArea = Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }

                action(Post2)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        Text100: Label 'Owis No. cannot be empty';
                    begin
                        /*IF xRec."Vendor Order No." = '' THEN BEGIN
                          ERROR(Text100);
                          EXIT;
                        END;*/


                        Post(CODEUNIT::"Purch.-Post (Yes/No)");

                    end;
                }
                action("Test Post")
                {
                    Caption = 'Test Post';
                    Image = TestReport;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PurchaseiNVOICES: Record "Purchase Header";
                        PurchaseInvoicePage: Page "Purchase Invoice";
                    begin
                        //NK01 Start
                        TESTFIELD("VAT Date");
                        StartCompanyNotes.ClearTempGLE;
                        StartCompanyNotes.SetPostingPrediction;
                        IF NOT CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec) THEN BEGIN
                            IF StartCompanyNotes.GetTestDoneOk THEN BEGIN
                                StartCompanyNotes.ResetPostingPrediction;
                                //AS1.00 START
                                ok := DIALOG.CONFIRM(Txt000);
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
                        END;
                        //NK01 End

                        //AS1 PONOVO OTVORI PAGE KOJI JE testno PROKNJIŽEN
                        PurchaseiNVOICES.SETFILTER("No.", Rec."No.");
                        IF PurchaseiNVOICES.FIND('-') THEN BEGIN
                            PurchaseInvoicePage.SETTABLEVIEW(PurchaseiNVOICES);
                            PurchaseInvoicePage.SETRECORD(PurchaseiNVOICES);
                        END;
                        CurrPage.CLOSE;
                        PurchaseInvoicePage.RUN;
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
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
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
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
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        //ec01
                        REPORT.RUN(402);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        Prepayment := TRUE;
        if Prepayment = true then begin
            PurchSetup.get;
            "No. Series" := PurchSetup."Prepayment Invoice Nos.";
            "Posting No. Series" := PurchSetup."Prepayment Invoice Nos.";

        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter;
        "Purchase Is Finished" := TRUE;
        Prepayment := TRUE;

        if Prepayment = true then begin
            PurchSetup.get;
            "No. Series" := PurchSetup."Prepayment Invoice Nos.";
            "Posting No. Series" := PurchSetup."Prepayment Invoice Nos.";

        end;

    end;

    trigger OnOpenPage()
    begin
        /*IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;   */

    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        [InDataSet]
        JobQueueVisible: Boolean;
        StartCompanyNotes: Codeunit "Start Company Notes";
        ok: Boolean;
        DocPrint: Codeunit "Document-Print";
        Txt000: Label 'Do you want to see details?';

    local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
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

