codeunit 50025 ArchiveManagementService
{

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Document %1 has been archived.';
        Text002: Label 'Do you want to Restore %1 %2 Version %3?';
        Text003: Label '%1 %2 has been restored.';
        Text004: Label 'Document restored from Version %1.';
        Text005: Label '%1 %2 has been partly posted.\Restore not possible.';
        Text006: Label 'Entries exist for on or more of the following:\  - %1\  - %2\  - %3.\Restoration of document will delete these entries.\Continue with restore?';
        Text007: Label 'Archive %1 no.: %2?';
        Text008: Label 'Item Tracking Line';
        ReleaseServiceDoc: Codeunit "Release Service Document";
        Text009: Label 'Unposted %1 %2 does not exist anymore.\It is not possible to restore the %1.';
        DeferralUtilities: Codeunit "Deferral Utilities";
        RecordLinkManagement: Codeunit "Record Link Management";




    procedure ArchiveServiceDocument(var ServiceHeader: Record "Service Header")
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        if ConfirmManagement.GetResponseOrDefault(
             StrSubstNo(Text007, ServiceHeader."Document Type", ServiceHeader."No."), true)
        then begin
            StoreServiceDocument(ServiceHeader, false);
            Message(Text001, ServiceHeader."No.");
        end;
    end;


    procedure StoreServiceDocument(var ServiceHeader: Record "Service Header"; InteractionExist: Boolean)
    var
        ServiceLine: Record "Service Line";
        ServiceHeaderArchive: Record "Service Header Archive";
        ServiceLineArchive: Record "Service Line Archive";
        ServiceItemLineArchive: Record "Service Item Line Archive";
        ServiceitemLine: Record "Service Item Line";
        IsHandled: Boolean;
        DocumentMM: Record "Document Attachment";
        DocumentMMFInd: Record "Document Attachment";
        DocumentMMInit: Record "Document Attachment";
        ServiceLineConnected: Record "Service Line";
        ServiceLineOrg: Record "Service Line";
        ServiceHeaderConnected: Record "Service Header";
        ServiceHeaderConnectedSub: Record "Service Header";
        LinkedAccounts: List of [Text];
        CurrentLinkedAccountID: Code[20];
        NextLinkedAccountID: Code[20];
        AllLinkedAccounts: List of [Code[20]];
        IsNextFound: Boolean;
        RNConnected: text;
        SlineLast: Record "Service Line";
        BrojacIn: Integer;
        ServiceLineConnectedSum: Record "Service Line";
        QuantityUpdate: Decimal;
        SArchiveTemp: Record "Service Header Archive";

    begin
        IsHandled := false;
        OnBeforeStoreServiceDocument(ServiceHeader, IsHandled);
        if IsHandled then
            exit;

        ServiceHeaderArchive.Init();
        ServiceHeaderArchive.TransferFields(ServiceHeader);
        ServiceHeaderArchive."Archived By" := UserId;
        ServiceHeaderArchive."Date Archived" := WorkDate;
        ServiceHeaderArchive."Time Archived" := Time;
        ServiceHeaderArchive."Version No." :=
            GetNextVersionNo(
                DATABASE::"Service Header", ServiceHeader."Document Type".AsInteger(), ServiceHeader."No.", ServiceHeader."Doc. No. Occurrence");
        RecordLinkManagement.CopyLinks(ServiceHeader, ServiceHeaderArchive);
        OnBeforeServiceHeaderArchiveInsert(ServiceHeaderArchive, ServiceHeader);
        ServiceHeaderArchive.Insert();
        OnAfterServiceHeaderArchiveInsert(ServiceHeaderArchive, ServiceHeader);


        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        if ServiceLine.FindSet then
            repeat
                with ServiceLineArchive do begin
                    Init;
                    TransferFields(ServiceLine);
                    "Doc. No. Occurrence" := ServiceHeader."Doc. No. Occurrence";
                    "Version No." := ServiceHeaderArchive."Version No.";
                    RecordLinkManagement.CopyLinks(ServiceLine, ServiceLineArchive);
                    OnBeforeServiceLineArchiveInsert(ServiceLineArchive, ServiceLine);
                    Insert;
                end;

                OnAfterStoreServiceLineArchive(ServiceHeader, ServiceLine, ServiceHeaderArchive, ServiceLineArchive);
            until ServiceLine.Next = 0;

        ServiceitemLine.Reset();
        ServiceitemLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceitemLine.SetRange("Document No.", ServiceHeader."No.");
        if ServiceitemLine.FindSet then
            repeat
                with ServiceItemLineArchive do begin
                    Init;
                    TransferFields(ServiceitemLine);
                    "Doc. No. Occurrence" := ServiceHeader."Doc. No. Occurrence";
                    "Version No." := ServiceHeaderArchive."Version No.";
                    RecordLinkManagement.CopyLinks(ServiceitemLine, ServiceItemLineArchive);
                    Insert;
                    DocumentMM.Reset();
                    DocumentMM.SetFilter("No.", '%1', ServiceitemLine."Document No.");
                    DocumentMM.SetFilter("Table ID", '%1', 5901);
                    DocumentMM.SetFilter("Line No.", '%1', ServiceitemLine."Line No.");
                    if DocumentMM.FindSet() then
                        repeat
                        /*  DocumentMMFInd.Reset();
                          DocumentMMFInd.CopyFilters(DocumentMM);
                          DocumentMMFInd.SetFilter(Version, '%1', "Version No.");
                          if not DocumentMMFInd.FindFirst() then begin
                              DocumentMMInit.Init();
                              DocumentMMInit.TransferFields(DocumentMM);
                              DocumentMMInit.Version := "Version No.";
                              DocumentMMInit.Archived := true;
                              DocumentMMInit.Insert();
                          end;*/
                        until DocumentMM.Next() = 0;

                end;

            until ServiceitemLine.Next = 0;




        OnAfterStoreServiceDocument(ServiceHeader, ServiceHeaderArchive);

        //Ja bih ovdje sada uradila ažuriranje podatak, da bude jedan Codeunit.
        //gledam povezane sve radne naloge i gledam njihovu otpremljenu količinu, samo gdje su materijali.

        //pronađem sve povezane radne naloge
        SArchiveTemp.Reset();
        SArchiveTemp.SetFilter("Assigned User ID", '%1', UserId);
        if SArchiveTemp.FindSet() then
            repeat
                SArchiveTemp.delete;
            until SArchiveTemp.Next() = 0;


        RNConnected := '';
        ServiceHeaderConnected.Reset();
        ServiceHeaderConnected.SetFilter("CZK Request No.", '%1', ServiceHeader."No.");
        ServiceHeaderConnected.SetFilter("No.", '<>%1', ServiceHeader."No.");
        if ServiceHeaderConnected.FindSet() then
            repeat
                //ovdje bi bilo svi povezani nalozi za osnovni nalog

                SArchiveTemp.Reset();
                SArchiveTemp.SetFilter("Assigned User ID", '%1', UserId);
                SArchiveTemp.SetFilter("No.", '%1', ServiceHeaderConnected."No.");
                if not SArchiveTemp.FindSet() then begin

                    SArchiveTemp.Init;
                    SArchiveTemp."No." := ServiceHeaderConnected."No.";
                    SArchiveTemp."Assigned User ID" := UserId;
                    SArchiveTemp.Insert();
                    RNConnected += ServiceHeaderConnected."No." + '|';
                    //ovo je od mog inicijalno povezanog radnog naloga, međutim trebaju mi sve veze na ovog, kao pod nivoi.

                    //da li ovaj povezani ima povezanog i tako sve redom.
                    // Pronađi nalog sa trenutnim LinkedAccountID

                    if (ServiceHeaderConnected."CZK Request No." <> '') and (ServiceHeaderConnected."No." <> ServiceHeader."No.") then begin

                        if ServiceHeaderConnectedSub.Get(ServiceHeaderConnectedSub."Document Type"::Order, ServiceHeaderConnected."CZK Request No.") then begin
                            if ServiceHeaderConnectedSub."CZK Request No." <> '' then begin


                                SArchiveTemp.Reset();
                                SArchiveTemp.SetFilter("Assigned User ID", '%1', UserId);
                                SArchiveTemp.SetFilter("No.", '%1', ServiceHeaderConnectedSub."CZK Request No.");
                                if not SArchiveTemp.FindSet() then begin
                                    SArchiveTemp.Init;
                                    SArchiveTemp."No." := ServiceHeaderConnectedSub."No.";
                                    SArchiveTemp."Assigned User ID" := UserId;
                                    SArchiveTemp.Insert();
                                    RNConnected += ServiceHeaderConnectedSub."CZK Request No." + '|';

                                end;

                            end;
                        end;
                    end;
                end;

            // Ako nema sledećeg povezanog naloga, izlazimo iz petlje

            until ServiceHeaderConnected.Next() = 0;


        BrojacIn := 0;
        if StrLen(RNConnected) > 2 then
            RNConnected := copystr(RNConnected, 1, strlen(RNConnected) - 1);

        SlineLast.Reset();
        SlineLast.SetFilter("Document No.", '%1', ServiceHeader."No.");
        SlineLast.SetCurrentKey("Line No.");
        if SlineLast.FindLast() then begin
            BrojacIn := SlineLast."Line No." + 1000;
        end
        else begin
            BrojacIn := 1000;
        end;

        ServiceLineConnected.Reset();
        ServiceLineConnected.SetFilter("Document No.", RNConnected);
        ServiceLineConnected.SetFilter(Type, '%1', ServiceLineConnected.Type::Item);
        ServiceLineConnected.SetCurrentKey("No.");
        if ServiceLineConnected.FindSet() then
            repeat

                ServiceLineOrg.Reset();
                ServiceLineOrg.SetFilter("Document No.", '%1', ServiceHeader."No.");
                ServiceLineOrg.SetFilter(Type, '%1', ServiceLineOrg.Type::Item);
                ServiceLineOrg.SetFilter("No.", '%1', ServiceLineConnected."No.");
                if ServiceLineOrg.FindFirst() then begin

                    QuantityUpdate := 0;
                    ServiceLineConnectedSum.Reset();
                    ServiceLineConnectedSum.SetFilter("Document No.", RNConnected);
                    ServiceLineConnectedSum.SetFilter(Type, '%1', ServiceLineConnected.Type::Item);
                    ServiceLineConnectedSum.SetFilter("No.", '%1', ServiceLineConnected."No.");
                    if ServiceLineConnectedSum.FindFirst() then
                        repeat
                            ServiceLineConnectedSum.CalcFields("Shiped Quantity");
                            QuantityUpdate += ServiceLineConnectedSum."Shiped Quantity";
                        until ServiceLineConnectedSum.Next() = 0;

                    ServiceLineOrg.Validate(Quantity, QuantityUpdate);

                end
                else begin
                    //ovdje ćemo ubaciti
                    ServiceLineOrg.init;
                    ServiceLineOrg.TransferFields(ServiceLineConnected);
                    ServiceLineOrg."Document No." := ServiceHeader."No.";
                    ServiceLineOrg."Line No." := BrojacIn;
                    QuantityUpdate := 0;
                    ServiceLineConnectedSum.Reset();
                    ServiceLineConnectedSum.SetFilter("Document No.", RNConnected);
                    ServiceLineConnectedSum.SetFilter(Type, '%1', ServiceLineConnected.Type::Item);
                    ServiceLineConnectedSum.SetFilter("No.", '%1', ServiceLineConnected."No.");
                    if ServiceLineConnectedSum.FindFirst() then
                        repeat
                            ServiceLineConnectedSum.CalcFields("Shiped Quantity");
                            QuantityUpdate += ServiceLineConnectedSum."Shiped Quantity";
                        until ServiceLineConnectedSum.Next() = 0;

                    ServiceLineOrg.Validate(Quantity, QuantityUpdate);
                    BrojacIn += 1000;
                    ServiceLineOrg.Insert();

                end;

            until ServiceLineConnected.Next() = 0;
    end;







    procedure GetNextOccurrenceNo(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]) OccurenceNo: Integer
    var
        ServiceHeaderArchive: Record "Service Header Archive";
        PurchHeaderArchive: Record "Purchase Header Archive";
    begin
        case TableId of
            DATABASE::"Service Header":
                begin
                    ServiceHeaderArchive.LockTable();
                    ServiceHeaderArchive.SetRange("Document Type", DocType);
                    ServiceHeaderArchive.SetRange("No.", DocNo);
                    if ServiceHeaderArchive.FindLast then
                        exit(ServiceHeaderArchive."Doc. No. Occurrence" + 1);

                    exit(1);
                end;
            DATABASE::"Purchase Header":
                begin
                    PurchHeaderArchive.LockTable();
                    PurchHeaderArchive.SetRange("Document Type", DocType);
                    PurchHeaderArchive.SetRange("No.", DocNo);
                    if PurchHeaderArchive.FindLast then
                        exit(PurchHeaderArchive."Doc. No. Occurrence" + 1);

                    exit(1);
                end;
            else begin
                OnGetNextOccurrenceNo(TableId, DocType, DocNo, OccurenceNo);
                exit(OccurenceNo)
            end;
        end;
    end;

    procedure GetNextVersionNo(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]; DocNoOccurrence: Integer) VersionNo: Integer
    var
        ServiceHeaderArchive: Record "Service Header Archive";
        PurchHeaderArchive: Record "Purchase Header Archive";
    begin
        case TableId of
            DATABASE::"Service Header":
                begin
                    ServiceHeaderArchive.LockTable();
                    ServiceHeaderArchive.SetRange("Document Type", DocType);
                    ServiceHeaderArchive.SetRange("No.", DocNo);
                    ServiceHeaderArchive.SetRange("Doc. No. Occurrence", DocNoOccurrence);
                    if ServiceHeaderArchive.FindLast then
                        exit(ServiceHeaderArchive."Version No." + 1);

                    exit(1);
                end;
            DATABASE::"Purchase Header":
                begin
                    PurchHeaderArchive.LockTable();
                    PurchHeaderArchive.SetRange("Document Type", DocType);
                    PurchHeaderArchive.SetRange("No.", DocNo);
                    PurchHeaderArchive.SetRange("Doc. No. Occurrence", DocNoOccurrence);
                    if PurchHeaderArchive.FindLast then
                        exit(PurchHeaderArchive."Version No." + 1);

                    exit(1);
                end;
            else begin
                OnGetNextVersionNo(TableId, DocType, DocNo, DocNoOccurrence, VersionNo);
                exit(VersionNo)
            end;
        end;
    end;

    procedure ServiceDocArchiveGranule(): Boolean
    var
        ServiceHeaderArchive: Record "Service Header Archive";
    begin
        exit(ServiceHeaderArchive.WritePermission);
    end;

    procedure PurchaseDocArchiveGranule(): Boolean
    var
        PurchaseHeaderArchive: Record "Purchase Header Archive";
    begin
        exit(PurchaseHeaderArchive.WritePermission);
    end;



    local procedure StorePurchDocumentComments(DocType: Option; DocNo: Code[20]; DocNoOccurrence: Integer; VersionNo: Integer)
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentLineArch: Record "Purch. Comment Line Archive";
    begin
        PurchCommentLine.SetRange("Document Type", DocType);
        PurchCommentLine.SetRange("No.", DocNo);
        if PurchCommentLine.FindSet then
            repeat
                PurchCommentLineArch.Init();
                PurchCommentLineArch.TransferFields(PurchCommentLine);
                PurchCommentLineArch."Doc. No. Occurrence" := DocNoOccurrence;
                PurchCommentLineArch."Version No." := VersionNo;
                PurchCommentLineArch.Insert();
            until PurchCommentLine.Next = 0;
    end;

    procedure ArchServiceDocumentNoConfirm(var ServiceHeader: Record "Service Header")
    begin
        StoreServiceDocument(ServiceHeader, false);
    end;







    [IntegrationEvent(false, false)]
    local procedure OnAfterAutoArchivePurchDocument(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAutoArchiveServiceDocument(var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStoreServiceDocument(var ServiceHeader: Record "Service Header"; var ServiceHeaderArchive: Record "Service Header Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStoreServiceLineArchive(var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var ServiceHeaderArchive: Record "Service Header Archive"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStorePurchDocument(var PurchaseHeader: Record "Purchase Header"; var PurchaseHeaderArchive: Record "Purchase Header Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterStorePurchLineArchive(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var PurchHeaderArchive: Record "Purchase Header Archive"; var PurchLineArchive: Record "Purchase Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRestoreServiceDocument(var ServiceHeader: Record "Service Header"; var ServiceHeaderArchive: Record "Service Header Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRestoreServiceLine(var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var ServiceHeaderArchive: Record "Service Header Archive"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRestoreServiceLines(var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var ServiceHeaderArchive: Record "Service Header Archive"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterServiceHeaderArchiveInsert(var ServiceHeaderArchive: Record "Service Header Archive"; ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPurchHeaderArchiveInsert(var PurchaseHeaderArchive: Record "Purchase Header Archive"; PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTransferFromArchToServiceHeader(var ServiceHeader: Record "Service Header"; var ServiceHeaderArchive: Record "Service Header Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTransferFromArchToServiceLine(var ServiceLine: Record "Service Line"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAutoArchiveServiceDocument(var ServiceHeader: Record "Service Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAutoArchivePurchDocument(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeServiceHeaderInsert(var ServiceHeader: Record "Service Header"; ServiceHeaderArchive: Record "Service Header Archive");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRestoreServiceDocument(var ServiceHeaderArchive: Record "Service Header Archive"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckIfDocumentIsPartiallyPosted(var ServiceHeaderArchive: Record "Service Header Archive"; var DoCheck: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeServiceHeaderArchiveInsert(var ServiceHeaderArchive: Record "Service Header Archive"; ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeServiceLineArchiveInsert(var ServiceLineArchive: Record "Service Line Archive"; ServiceLine: Record "Service Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchHeaderArchiveInsert(var PurchaseHeaderArchive: Record "Purchase Header Archive"; PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchLineArchiveInsert(var PurchaseLineArchive: Record "Purchase Line Archive"; PurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStoreServiceDocument(var ServiceHeader: Record "Service Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetNextOccurrenceNo(TableId: Integer; DocType: Option; DocNo: Code[20]; var OccurenceNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetNextVersionNo(TableId: Integer; DocType: Option; DocNo: Code[20]; DocNoOccurrence: Integer; var VersionNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRestoreDocumentOnAfterDeleteServiceHeader(var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRestoreDocumentOnBeforeDeleteServiceHeader(var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRestoreServiceDocumentOnAfterServiceHeaderInsert(var ServiceHeader: Record "Service Header"; ServiceHeaderArchive: Record "Service Header Archive");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRestoreServiceLinesOnAfterServiceLineInsert(var ServiceLine: Record "Service Line"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRestoreServiceLinesOnBeforeServiceLineInsert(var ServiceLine: Record "Service Line"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRestoreServiceLinesOnAfterValidateQuantity(var ServiceLine: Record "Service Line"; var ServiceLineArchive: Record "Service Line Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStorePurchDocument(var PurchHeader: Record "Purchase Header")
    begin
    end;
}

