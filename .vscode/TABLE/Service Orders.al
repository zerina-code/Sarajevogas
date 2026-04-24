pageextension 50164 "Sales Orders" extends "Service Orders"
{
    layout
    {

        addfirst(Content)
        {
            field(CountV; CountV)
            {

                Caption = 'Count';
                Style = Unfavorable;
            }
        }
        // Add changes to page layout here
        modify(Status) { Visible = false; }
        modify("Order Date") { Visible = False; }


        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Notify Customer")
        {
            Visible = true;
        }
        modify("Service Order Type")
        {
            Visible = true;
        }
        modify("Contract No.")
        {
            Visible = true;
        }

        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify("Due Date")
        {
            Visible = true;
        }
        modify("Payment Discount %")
        {
            Visible = true;
        }
        modify("Payment Method Code")
        {
            Visible = true;
        }
        modify("Shipping Advice")
        {
            Visible = true;
        }
        modify("Warning Status")
        {
            Visible = true;
        }
        modify("Allocated Hours")
        {
            Visible = true;
        }
        modify("Expected Finishing Date")
        {
            Visible = true;
        }
        modify("Starting Date")
        {
            Visible = true;
        }
        modify("Finishing Date")
        {
            Visible = true;
        }
        modify("Service Time (Hours)")
        {
            Visible = true;
        }

        addafter("No.")
        {

            field("Posting Date"; "Posting Date") { }
            field("Request Type"; Rec."Request Type")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        modify("W&arehouse") { Visible = false; }
        modify(Statistics) { Visible = false; }
        modify(Action17) { Visible = false; }
        modify(Action13) { Visible = false; }
        modify(Documents) { Visible = false; }

        modify(Post) { Visible = false; }
        modify("Post and &Print") { Visible = false; }
        modify("P&osting") { Visible = false; }
        // Add changes to page actions here
        addafter(PostBatch)
        {

            action(PostBilling)
            {
                ApplicationArea = All;
                Caption = 'PostBilling';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';
                Visible = true;
                //   Visible = ProcessRequestActionVisible;

                trigger OnAction()
                var
                    ServHeader: Record "Service Header";
                    ServPostYesNo: Codeunit "Service-Post (Yes/No)";
                    InstructionMgt: Codeunit "Instruction Mgt.";


                    SIL: Record "Service Line";
                    CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";

                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    ReleaseServiceDocument: Codeunit "Release Service Document";
                    SHMore: Record "Service Header";
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    CustLedgerEntry2: Record "Cust. Ledger Entry";
                    AppliedC: page "Apply Customer Entries";
                    ApplicationDate: date;
                    CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
                    Applied2222: Boolean;
                    DocCounter: Integer;
                    BatchSize: Integer;
                    SIH: record "Service Header";
                begin

                    DocCounter := 0;
                    BatchSize := 1000;

                    /* SHMore.Reset();
                     SHMore.CopyFilters(Rec);
                     SHMore.SetFilter("Request Type", '%1', SHMore."Request Type"::"Billing Invoice");
                     if SHMore.FindSet() then
                         repeat
                             DocCounter += 1;
                             SIL.reset;
                             sil.SetFilter("Document No.", '%1', SHMore."No.");
                             sil.SetFilter(type, '%1', sil.type::Item);
                             if not sil.FindFirst() then begin
                                 ServHeader.Get(SHMore."Document Type", SHMore."No.");
                                 ServPostYesNo.PostDocument(ServHeader);
                                 DocumentIsPosted := not ServHeader.Get(SHMore."Document Type", SHMore."No.");

                             end
                             else begin

                                 ReleaseServiceDocument.PerformManualRelease(SHMore);


                                 GetSourceDocOutbound.CreateFromServiceOrder(SHMore);
                                 // if not Find('=><') then
                                 //      Init;
                                 Commit();

                                 WhseShptLine2.Reset();
                                 WhseShptLine2.SetFilter("Source No.", '%1', SHMore."No.");
                                 if WhseShptLine2.FindSet() then
                                     repeat

                                         WhseShptLine.Copy(WhseShptLine2);
                                         "Code_WH";
                                     until WhseShptLine2.next = 0;
                                 Commit();
                                 ServHeader.Get(SHMore."Document Type", SHMore."No.");
                                 PostDocument(servheader);

                                 if DocCounter mod BatchSize = 0 then
                                     Commit();

                             end;


                         until SHMore.Next() = 0;*/

                    SIH.Reset();
                    SIH.SetFilter("No.", '%1', Rec."No.");
                    Report.Run(50165, true, true, SIH);


                end;
            }

        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter("Request Type", '%1', "Request Type"::"Billing Invoice");
        CountV := rec.Count;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CountV := rec.Count;

    end;

    local procedure "Code_WH"()
    var
        Invoice: Boolean;
        HideDialog: Boolean;
        IsPosted: Boolean;
    begin
        HideDialog := false;
        IsPosted := false;
        if IsPosted then
            exit;

        with WhseShptLine do begin
            if Find then
                Selection := 2;

            Invoice := (Selection = 2);


            WhsePostShipment.SetPostingSettings(Invoice);
            WhsePostShipment.SetPrint(false);
            WhsePostShipment.Run(WhseShptLine);
            WhsePostShipment.GetResultMessage;
            Clear(WhsePostShipment);
        end;
    end;

    procedure PostDocumentWithLines(var ServiceHeaderSource: Record "Service Header"; var PassedServLine: Record "Service Line")
    var
        ServiceHeader: Record "Service Header";
    begin

        ServiceHeader.Copy(ServiceHeaderSource);
        Code_SH(PassedServLine, ServiceHeader);
        ServiceHeaderSource := ServiceHeader;
    end;


    local procedure Code_SHPost(var SalesHeader: Record "Sales Header"; PostAndSend: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
        IsHandled: Boolean;
        DefaultOption: Integer;
    begin
        HideDialog := false;
        IsHandled := false;
        DefaultOption := 3;


        SalesSetup.Get();
        if SalesSetup."Post with Job Queue" and not PostAndSend then
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Sales-Post", SalesHeader);

    end;

    local procedure Code_SH(var PassedServLine: Record "Service Line"; var PassedServiceHeader: Record "Service Header")
    var
        ServicePost: Codeunit ServicePost_2;
        ConfirmManagement: Codeunit "Confirm Management";
        Ship: Boolean;
        Consume: Boolean;
        Invoice: Boolean;
        HideDialog: Boolean;
        IsHandled: Boolean;
        NothingToPostErr: Label 'There is nothing to post.';

    begin
        if not PassedServiceHeader.Find then
            Error(NothingToPostErr);

        HideDialog := false;
        IsHandled := false;
        if IsHandled then
            exit;

        with PassedServiceHeader do begin


            Selection := 3;
            Ship := Selection in [1, 3, 4];
            Consume := Selection in [4];
            Invoice := Selection in [2, 3];


        end;



        ServicePost.SetPreviewMode(false);
        ServicePost.PostWithLines(PassedServiceHeader, PassedServLine, Ship, Consume, Invoice);
    end;


    procedure PostDocument(var ServiceHeaderSource: Record "Service Header")
    var
        DummyServLine: Record "Service Line" temporary;
    begin

        PostDocumentWithLines(ServiceHeaderSource, DummyServLine);
    end;

    var
        myInt: Integer;
        ConfirmDeleteLbl: Label 'Do you want to continue and delete?', Comment = 'Da li želite nastaviti i brisati?';
        DocumentIsPosted: Boolean;
        WhseShptLine2: Record "Warehouse Shipment Line";
        WhseShptLine: Record "Warehouse Shipment Line";
        CountV: Integer;
        UserSetup: Record "User Setup";
        VisiblePosting: Boolean;
        OpenPostedSalesCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';
        Hod: Integer;
        Selection: Integer;
        Selection2: Integer;
        ServHeader: Record "Service Header";
        WhsePostShipment: Codeunit "Whse.-Post Shipment_2";
        OpenPostedServiceOrderQst: Label 'The order is posted as number %1 and moved to the Posted Service Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';


}