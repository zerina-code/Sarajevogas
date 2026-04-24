report 50165 "Posting Billing JOB"
{
    DefaultLayout = RDLC;
    Caption = 'Posting Billing';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                DocCounter := 0;
                BatchSize := 1000;


                DocCounter += 1;
                SIL.reset;
                sil.SetFilter("Document No.", '%1', "Service Header"."No.");
                sil.SetFilter(type, '%1', sil.type::Item);
                if not sil.FindFirst() then begin
                    ServHeader.Get("Service Header"."Document Type", "Service Header"."No.");
                    ServPostYesNo.PostDocument(ServHeader);
                    DocumentIsPosted := not ServHeader.Get("Service Header"."Document Type", "Service Header"."No.");

                end
                else begin

                    ReleaseServiceDocument.PerformManualRelease("Service Header");


                    GetSourceDocOutbound.CreateFromServiceOrder("Service Header");
                    // if not Find('=><') then
                    //      Init;
                    Commit();

                    WhseShptLine2.Reset();
                    WhseShptLine2.SetFilter("Source No.", '%1', "Service Header"."No.");
                    if WhseShptLine2.FindSet() then
                        repeat

                            WhseShptLine.Copy(WhseShptLine2);
                            "Code_WH";
                        until WhseShptLine2.next = 0;
                    Commit();
                    ServHeader.Get("Service Header"."Document Type", "Service Header"."No.");
                    PostDocument(servheader);

                    if DocCounter mod BatchSize = 0 then
                        Commit();

                end;




            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("Request Type", '%1', "Request Type"::"Billing Invoice");

            end;
        }
    }



    trigger OnPostReport()
    var

    begin







    end;

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin

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

        ServHeader: Record "Service Header";
        ServPostYesNo: Codeunit "Service-Post (Yes/No)";
        InstructionMgt: Codeunit "Instruction Mgt.";


        SIL: Record "Service Line";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";

        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        ReleaseServiceDocument: Codeunit "Release Service Document";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        AppliedC: page "Apply Customer Entries";
        ApplicationDate: date;
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
        Applied2222: Boolean;
        DocCounter: Integer;
        BatchSize: Integer;
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

        WhsePostShipment: Codeunit "Whse.-Post Shipment_2";
        OpenPostedServiceOrderQst: Label 'The order is posted as number %1 and moved to the Posted Service Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';



}

