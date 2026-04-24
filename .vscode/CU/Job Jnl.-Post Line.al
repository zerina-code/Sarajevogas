/*codeunit 50008 "Job Jnl.-Post Line2"
{
    Permissions = TableData 169 = imd,
                  TableData 241 = imd,
                  TableData 5802 = rimd;
    TableNo = 210;

    trigger OnRun()
    begin
        GetGLSetup;
        RunWithCheck(Rec);
    end;

    var
        Cust: Record "Customer";
        Job: Record "Job";
        JobTask: Record "Job Task";
        JobJnlLine: Record "Job Journal Line";
        JobJnlLine2: Record "Job Journal Line";
        ResJnlLine: Record "Res. Journal Line";
        ItemJnlLine: Record "Item Journal Line";
        JobReg: Record "Job Register";
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record "Currency";
        Location: Record "Location";
        Item: Record "Item";
        JobJnlCheckLine: Codeunit "Job Jnl.-Check Line";
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        JobPostLine: Codeunit "Job Post-Line";
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";
        GLSetupRead: Boolean;
        NextEntryNo: Integer;
        GLEntryNo: Integer;


    procedure RunWithCheck(var JobJnlLine2: Record "Job Journal Line"): Integer
    var
        JobLedgEntryNo: Integer;
    begin
        JobJnlLine.COPY(JobJnlLine2);
        JobLedgEntryNo := Code(TRUE);
        JobJnlLine2 := JobJnlLine;
        EXIT(JobLedgEntryNo);
    end;

    local procedure "Code"(CheckLine: Boolean): Integer
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        ValueEntry: Record "Value Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        JobLedgEntry2: Record "Job Ledger Entry";
        JobPlanningLine: Record "Job Planning Line";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemJnlLine2: Record "Item Journal Line";
        JobJnlLineReserve: Codeunit "Job Jnl. Line-Reserve";
        JobLedgEntryNo: Integer;
        SkipJobLedgerEntry: Boolean;
        ApplyToJobContractEntryNo: Boolean;
        TempRemainingQty: Decimal;
        RemainingAmount: Decimal;
        RemainingAmountLCY: Decimal;
        RemainingQtyToTrack: Decimal;
    begin
        OnBeforeCode(JobJnlLine);

        GetGLSetup;

        WITH JobJnlLine DO BEGIN
            IF EmptyLine THEN
                EXIT;

            IF CheckLine THEN
                JobJnlCheckLine.RunCheck(JobJnlLine);

            IF JobLedgEntry."Entry No." = 0 THEN BEGIN
                JobLedgEntry.LOCKTABLE;
                IF JobLedgEntry.FINDLAST THEN
                    NextEntryNo := JobLedgEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;
            END;

            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";

            IF JobReg."No." = 0 THEN BEGIN
                JobReg.LOCKTABLE;
                IF (NOT JobReg.FINDLAST) OR (JobReg."To Entry No." <> 0) THEN BEGIN
                    JobReg.INIT;
                    JobReg."No." := JobReg."No." + 1;
                    JobReg."From Entry No." := NextEntryNo;
                    JobReg."To Entry No." := NextEntryNo;
                    JobReg."Creation Date" := TODAY;
                    JobReg."Creation Time" := TIME;
                    JobReg."Source Code" := "Source Code";
                    JobReg."Journal Batch Name" := "Journal Batch Name";
                    JobReg."User ID" := USERID;
                    JobReg.INSERT;
                END;
            END;
            Job.GET("Job No.");
            Job.TestBlocked;
            Job.TESTFIELD("Bill-to Customer No.");
            Cust.GET(Job."Bill-to Customer No.");
            TESTFIELD("Currency Code", Job."Currency Code");
            JobTask.GET("Job No.", "Job Task No.");
            JobTask.TESTFIELD("Job Task Type", JobTask."Job Task Type"::Posting);
            JobJnlLine2 := JobJnlLine;

            OnAfterCopyJobJnlLine(JobJnlLine, JobJnlLine2);

            JobJnlLine2."Source Currency Total Cost" := 0;
            JobJnlLine2."Source Currency Total Price" := 0;
            JobJnlLine2."Source Currency Line Amount" := 0;

            GetGLSetup;
            IF (GLSetup."Additional Reporting Currency" <> '') AND
               (JobJnlLine2."Source Currency Code" <> GLSetup."Additional Reporting Currency")
            THEN
                UpdateJobJnlLineSourceCurrencyAmounts(JobJnlLine2);

            IF JobJnlLine2."Entry Type" = JobJnlLine2."Entry Type"::Usage THEN BEGIN
                CASE Type OF
                    Type::Resource:
                        BEGIN
                            ResJnlLine.INIT;
                            ResJnlLine.CopyFromJobJnlLine(JobJnlLine2);
                            ResLedgEntry.LOCKTABLE;
                            ResJnlPostLine.RunWithCheck(ResJnlLine);
                            JobJnlLine2."Resource Group No." := ResJnlLine."Resource Group No.";
                            JobLedgEntryNo := CreateJobLedgEntry(JobJnlLine2);
                        END;
                    Type::Item:
                        BEGIN
                            IF NOT "Job Posting Only" THEN BEGIN
                                InitItemJnlLine;
                                JobJnlLineReserve.TransJobJnlLineToItemJnlLine(JobJnlLine2, ItemJnlLine, ItemJnlLine."Quantity (Base)");

                                ApplyToJobContractEntryNo := FALSE;
                                IF JobPlanningLine.GET("Job No.", "Job Task No.", "Job Planning Line No.") THEN
                                    ApplyToJobContractEntryNo := TRUE
                                ELSE
                                    IF JobPlanningReservationExists(JobJnlLine2."No.", JobJnlLine2."Job No.") THEN
                                        IF ApplyToMatchingJobPlanningLine(JobJnlLine2, JobPlanningLine) THEN
                                            ApplyToJobContractEntryNo := TRUE;

                                IF ApplyToJobContractEntryNo THEN
                                    ItemJnlLine."Job Contract Entry No." := JobPlanningLine."Job Contract Entry No.";

                                ItemLedgEntry.LOCKTABLE;
                                ItemJnlLine2 := ItemJnlLine;
                                ItemJnlPostLine.RunWithCheck(ItemJnlLine);
                                ItemJnlPostLine.CollectTrackingSpecification(TempTrackingSpecification);
                                PostWhseJnlLine(ItemJnlLine2, ItemJnlLine2.Quantity, ItemJnlLine2."Quantity (Base)", TempTrackingSpecification);
                            END;

                            IF GetJobConsumptionValueEntry(ValueEntry, JobJnlLine) THEN BEGIN
                                RemainingAmount := JobJnlLine2."Line Amount";
                                RemainingAmountLCY := JobJnlLine2."Line Amount (LCY)";
                                RemainingQtyToTrack := JobJnlLine2.Quantity;

                                REPEAT
                                    SkipJobLedgerEntry := FALSE;
                                    IF ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                                        JobLedgEntry2.SETRANGE("Ledger Entry Type", JobLedgEntry2."Ledger Entry Type"::Item);
                                        JobLedgEntry2.SETRANGE("Ledger Entry No.", ItemLedgEntry."Entry No.");
                                        // The following code is only to secure that JLEs created at receipt in version 6.0 or earlier,
                                        // are not created again at point of invoice (6.0 SP1 and newer).
                                        IF JobLedgEntry2.FINDFIRST AND (JobLedgEntry2.Quantity = -ItemLedgEntry.Quantity) THEN
                                            SkipJobLedgerEntry := TRUE
                                        ELSE BEGIN
                                            JobJnlLine2."Serial No." := ItemLedgEntry."Serial No.";
                                            JobJnlLine2."Lot No." := ItemLedgEntry."Lot No.";
                                        END;
                                    END;
                                    IF NOT SkipJobLedgerEntry THEN BEGIN
                                        TempRemainingQty := JobJnlLine2."Remaining Qty.";
                                        JobJnlLine2.Quantity := -ValueEntry."Invoiced Quantity" / "Qty. per Unit of Measure";
                                        JobJnlLine2."Quantity (Base)" := ROUND(JobJnlLine2.Quantity * "Qty. per Unit of Measure", 0.00001);
                                        IF "Currency Code" <> '' THEN
                                            Currency.GET("Currency Code")
                                        ELSE
                                            Currency.InitRoundingPrecision;

                                        UpdateJobJnlLineTotalAmounts(JobJnlLine2, Currency."Amount Rounding Precision");
                                        UpdateJobJnlLineAmount(
                                          JobJnlLine2, RemainingAmount, RemainingAmountLCY, RemainingQtyToTrack, Currency."Amount Rounding Precision");

                                        JobJnlLine2.VALIDATE("Remaining Qty.", TempRemainingQty);
                                        JobJnlLine2."Ledger Entry Type" := "Ledger Entry Type"::Item;
                                        JobJnlLine2."Ledger Entry No." := ValueEntry."Item Ledger Entry No.";
                                        JobLedgEntryNo := CreateJobLedgEntry(JobJnlLine2);
                                        ValueEntry."Job Ledger Entry No." := JobLedgEntryNo;
                                        ValueEntry.MODIFY(TRUE);
                                    END;
                                UNTIL ValueEntry.NEXT = 0;
                            END;
                        END;
                    Type::"G/L Account":
                        JobLedgEntryNo := CreateJobLedgEntry(JobJnlLine2);
                END;
            END ELSE
                JobLedgEntryNo := CreateJobLedgEntry(JobJnlLine2);
        END;

        OnAfterRunCode(JobJnlLine2, JobLedgEntryNo);

        EXIT(JobLedgEntryNo);
    end;

    local procedure GetGLSetup()
    begin
        IF NOT GLSetupRead THEN
            GLSetup.GET;
        GLSetupRead := TRUE;
    end;


    procedure CreateJobLedgEntry(JobJnlLine2: Record "Job Journal Line"): Integer
    var
        ResLedgEntry: Record "Res. Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        JobPlanningLine: Record "Job Planning Line";
        Job: Record "Job";
        JobTransferLine: Codeunit "Job Transfer Line";
        JobLinkUsage: Codeunit "Job Link Usage";
        JobLedgEntryNo: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := FALSE;
        OnBeforeCreateJobLedgEntry(JobJnlLine2, IsHandled);
        IF IsHandled THEN
            EXIT;

        SetCurrency(JobJnlLine2);

        JobLedgEntry.INIT;
        JobTransferLine.FromJnlLineToLedgEntry(JobJnlLine2, JobLedgEntry);

        IF JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Sale THEN BEGIN
            JobLedgEntry.Quantity := -JobJnlLine2.Quantity;
            JobLedgEntry."Quantity (Base)" := -JobJnlLine2."Quantity (Base)";
            JobLedgEntry."Total Cost (LCY)" := -JobJnlLine2."Total Cost (LCY)";
            JobLedgEntry."Total Cost" := -JobJnlLine2."Total Cost";
            JobLedgEntry."Total Price (LCY)" := -JobJnlLine2."Total Price (LCY)";
            JobLedgEntry."Total Price" := -JobJnlLine2."Total Price";
            JobLedgEntry."Line Amount (LCY)" := -JobJnlLine2."Line Amount (LCY)";
            JobLedgEntry."Line Amount" := -JobJnlLine2."Line Amount";
            JobLedgEntry."Line Discount Amount (LCY)" := -JobJnlLine2."Line Discount Amount (LCY)";
            JobLedgEntry."Line Discount Amount" := -JobJnlLine2."Line Discount Amount";
        END ELSE BEGIN
            JobLedgEntry.Quantity := JobJnlLine2.Quantity;
            JobLedgEntry."Quantity (Base)" := JobJnlLine2."Quantity (Base)";
            JobLedgEntry."Total Cost (LCY)" := JobJnlLine2."Total Cost (LCY)";
            JobLedgEntry."Total Cost" := JobJnlLine2."Total Cost";
            JobLedgEntry."Total Price (LCY)" := JobJnlLine2."Total Price (LCY)";
            JobLedgEntry."Total Price" := JobJnlLine2."Total Price";
            JobLedgEntry."Line Amount (LCY)" := JobJnlLine2."Line Amount (LCY)";
            JobLedgEntry."Line Amount" := JobJnlLine2."Line Amount";
            JobLedgEntry."Line Discount Amount (LCY)" := JobJnlLine2."Line Discount Amount (LCY)";
            JobLedgEntry."Line Discount Amount" := JobJnlLine2."Line Discount Amount";
        END;

        JobLedgEntry."Additional-Currency Total Cost" := -JobLedgEntry."Additional-Currency Total Cost";
        JobLedgEntry."Add.-Currency Total Price" := -JobLedgEntry."Add.-Currency Total Price";
        JobLedgEntry."Add.-Currency Line Amount" := -JobLedgEntry."Add.-Currency Line Amount";

        JobLedgEntry."Entry No." := NextEntryNo;
        JobLedgEntry."No. Series" := JobJnlLine2."Posting No. Series";
        JobLedgEntry."Original Unit Cost (LCY)" := JobLedgEntry."Unit Cost (LCY)";
        JobLedgEntry."Original Total Cost (LCY)" := JobLedgEntry."Total Cost (LCY)";
        JobLedgEntry."Original Unit Cost" := JobLedgEntry."Unit Cost";
        JobLedgEntry."Original Total Cost" := JobLedgEntry."Total Cost";
        JobLedgEntry."Original Total Cost (ACY)" := JobLedgEntry."Additional-Currency Total Cost";
        JobLedgEntry."Dimension Set ID" := JobJnlLine2."Dimension Set ID";

        WITH JobJnlLine2 DO
            CASE Type OF
                Type::Resource:
                    BEGIN
                        IF "Entry Type" = "Entry Type"::Usage THEN BEGIN
                            IF ResLedgEntry.FINDLAST THEN BEGIN
                                JobLedgEntry."Ledger Entry Type" := JobLedgEntry."Ledger Entry Type"::Resource;
                                JobLedgEntry."Ledger Entry No." := ResLedgEntry."Entry No.";
                            END;
                        END;
                    END;
                Type::Item:
                    BEGIN
                        JobLedgEntry."Ledger Entry Type" := "Ledger Entry Type"::Item;
                        JobLedgEntry."Ledger Entry No." := "Ledger Entry No.";
                        JobLedgEntry."Serial No." := "Serial No.";
                        JobLedgEntry."Lot No." := "Lot No.";
                    END;
                Type::"G/L Account":
                    BEGIN
                        JobLedgEntry."Ledger Entry Type" := JobLedgEntry."Ledger Entry Type"::" ";
                        IF GLEntryNo > 0 THEN BEGIN
                            JobLedgEntry."Ledger Entry Type" := JobLedgEntry."Ledger Entry Type"::"G/L Account";
                            JobLedgEntry."Ledger Entry No." := GLEntryNo;
                            GLEntryNo := 0;
                        END;
                    END;
            END;
        IF JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Sale THEN BEGIN
            JobLedgEntry."Serial No." := JobJnlLine2."Serial No.";
            JobLedgEntry."Lot No." := JobJnlLine2."Lot No.";
        END;

        OnBeforeJobLedgEntryInsert(JobLedgEntry, JobJnlLine2);
        JobLedgEntry.INSERT(TRUE);

        JobReg."To Entry No." := NextEntryNo;
        JobReg.MODIFY;

        JobLedgEntryNo := JobLedgEntry."Entry No.";
        OnBeforeApplyUsageLink(JobLedgEntry);

        IF JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Usage THEN BEGIN
            // Usage Link should be applied if it is enabled for the job,
            // if a Job Planning Line number is defined or if it is enabled for a Job Planning Line.
            Job.GET(JobLedgEntry."Job No.");
            IF Job."Apply Usage Link" OR
               (JobJnlLine2."Job Planning Line No." <> 0) OR
               JobLinkUsage.FindMatchingJobPlanningLine(JobPlanningLine, JobLedgEntry)
            THEN
                JobLinkUsage.ApplyUsage(JobLedgEntry, JobJnlLine2)
            ELSE
                JobPostLine.InsertPlLineFromLedgEntry(JobLedgEntry)
        END;

        NextEntryNo := NextEntryNo + 1;
        OnAfterApplyUsageLink(JobLedgEntry);

        EXIT(JobLedgEntryNo);
    end;

    local procedure SetCurrency(JobJnlLine: Record "Job Journal Line")
    begin
        IF JobJnlLine."Currency Code" = '' THEN BEGIN
            CLEAR(Currency);
            Currency.InitRoundingPrecision
        END ELSE BEGIN
            Currency.GET(JobJnlLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
        END;
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line"; OriginalQuantity: Decimal; OriginalQuantityBase: Decimal; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        WarehouseJournalLine: Record "Warehouse Journal Line";
        TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary;
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        WMSManagement: Codeunit "WMS Management";
    begin
        WITH ItemJnlLine DO BEGIN
            IF "Entry Type" IN ["Entry Type"::Consumption, "Entry Type"::Output] THEN
                EXIT;

            Quantity := OriginalQuantity;
            "Quantity (Base)" := OriginalQuantityBase;
            GetLocation("Location Code");
            IF Location."Bin Mandatory" THEN
                IF WMSManagement.CreateWhseJnlLine(ItemJnlLine, 0, WarehouseJournalLine, FALSE) THEN BEGIN
                    TempTrackingSpecification.MODIFYALL("Source Type", DATABASE::"Job Journal Line");
                    ItemTrackingManagement.SplitWhseJnlLine(WarehouseJournalLine, TempWarehouseJournalLine, TempTrackingSpecification, FALSE);
                    IF TempWarehouseJournalLine.FIND('-') THEN
                        REPEAT
                            WMSManagement.CheckWhseJnlLine(TempWarehouseJournalLine, 1, 0, FALSE);
                            WhseJnlRegisterLine.RegisterWhseJnlLine(TempWarehouseJournalLine);
                        UNTIL TempWarehouseJournalLine.NEXT = 0;
                END;
        END;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;


    procedure SetGLEntryNo(GLEntryNo2: Integer)
    begin
        GLEntryNo := GLEntryNo2;
    end;

    local procedure InitItemJnlLine()
    begin
        WITH ItemJnlLine DO BEGIN
            INIT;
            CopyFromJobJnlLine(JobJnlLine2);

            "Source Type" := "Source Type"::Customer;
            "Source No." := Job."Bill-to Customer No.";

            Item.GET(JobJnlLine2."No.");
            "Inventory Posting Group" := Item."Inventory Posting Group";
            "Item Category Code" := Item."Item Category Code";
            //ĐK   "G/L Correction" := JobJnlLine2."G/L Correction";//BH1.00
        END;
    end;

    local procedure UpdateJobJnlLineTotalAmounts(var JobJnlLineToUpdate: Record "Job Journal Line"; AmtRoundingPrecision: Decimal)
    begin
        WITH JobJnlLineToUpdate DO BEGIN
            "Total Cost" := ROUND("Unit Cost" * Quantity, AmtRoundingPrecision);
            "Total Cost (LCY)" := ROUND("Unit Cost (LCY)" * Quantity, AmtRoundingPrecision);
            "Total Price" := ROUND("Unit Price" * Quantity, AmtRoundingPrecision);
            "Total Price (LCY)" := ROUND("Unit Price (LCY)" * Quantity, AmtRoundingPrecision);
        END;
    end;

    local procedure UpdateJobJnlLineAmount(var JobJnlLineToUpdate: Record "Job Journal Line"; var RemainingAmount: Decimal; var RemainingAmountLCY: Decimal; var RemainingQtyToTrack: Decimal; AmtRoundingPrecision: Decimal)
    begin
        WITH JobJnlLineToUpdate DO BEGIN
            "Line Amount" := ROUND(RemainingAmount * Quantity / RemainingQtyToTrack, AmtRoundingPrecision);
            "Line Amount (LCY)" := ROUND(RemainingAmountLCY * Quantity / RemainingQtyToTrack, AmtRoundingPrecision);

            RemainingAmount -= "Line Amount";
            RemainingAmountLCY -= "Line Amount (LCY)";
            RemainingQtyToTrack -= Quantity;
        END;
    end;

    local procedure UpdateJobJnlLineSourceCurrencyAmounts(var JobJnlLine: Record "Job Journal Line")
    begin
        WITH JobJnlLine DO BEGIN
            Currency.GET(GLSetup."Additional Reporting Currency");
            Currency.TESTFIELD("Amount Rounding Precision");
            "Source Currency Total Cost" :=
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  "Posting Date",
                  GLSetup."Additional Reporting Currency", "Total Cost (LCY)",
                  CurrExchRate.ExchangeRate(
                    "Posting Date", GLSetup."Additional Reporting Currency")),
                Currency."Amount Rounding Precision");
            "Source Currency Total Price" :=
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  "Posting Date",
                  GLSetup."Additional Reporting Currency", "Total Price (LCY)",
                  CurrExchRate.ExchangeRate(
                    "Posting Date", GLSetup."Additional Reporting Currency")),
                Currency."Amount Rounding Precision");
            "Source Currency Line Amount" :=
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  "Posting Date",
                  GLSetup."Additional Reporting Currency", "Line Amount (LCY)",
                  CurrExchRate.ExchangeRate(
                    "Posting Date", GLSetup."Additional Reporting Currency")),
                Currency."Amount Rounding Precision");
        END;
    end;

    local procedure JobPlanningReservationExists(ItemNo: Code[20]; JobNo: Code[20]): Boolean
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        WITH ReservationEntry DO BEGIN
            SETRANGE("Item No.", ItemNo);
            SETRANGE("Source Type", DATABASE::"Job Planning Line");
            SETRANGE("Source Subtype", Job.Status::Open);
            SETRANGE("Source ID", JobNo);
            EXIT(NOT ISEMPTY);
        END;
    end;

    local procedure GetJobConsumptionValueEntry(var ValueEntry: Record "Value Entry"; JobJournalLine: Record "Job Journal Line"): Boolean
    begin
        WITH JobJournalLine DO BEGIN
            ValueEntry.SETCURRENTKEY("Job No.", "Job Task No.", "Document No.");
            ValueEntry.SETRANGE("Item No.", "No.");
            ValueEntry.SETRANGE("Job No.", "Job No.");
            ValueEntry.SETRANGE("Job Task No.", "Job Task No.");
            ValueEntry.SETRANGE("Document No.", "Document No.");
            ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.");
            ValueEntry.SETRANGE("Job Ledger Entry No.", 0);
            OnGetJobConsumptionValueEntryFilter(ValueEntry, JobJnlLine);
        END;
        EXIT(ValueEntry.FINDSET);
    end;

    local procedure ApplyToMatchingJobPlanningLine(var JobJnlLine: Record "Job Journal Line"; var JobPlanningLine: Record "Job Planning Line"): Boolean
    var
        Job: Record "Job";
        JobLedgEntry: Record "Job Ledger Entry";
        JobTransferLine: Codeunit "Job Transfer Line";
        JobLinkUsage: Codeunit "Job Link Usage";
    begin
        IF JobLedgEntry."Entry Type" <> JobLedgEntry."Entry Type"::Usage THEN
            EXIT(FALSE);

        Job.GET(JobJnlLine."Job No.");
        JobLedgEntry.INIT;
        JobTransferLine.FromJnlLineToLedgEntry(JobJnlLine, JobLedgEntry);
        JobLedgEntry.Quantity := JobJnlLine.Quantity;
        JobLedgEntry."Quantity (Base)" := JobJnlLine."Quantity (Base)";

        IF JobLinkUsage.FindMatchingJobPlanningLine(JobPlanningLine, JobLedgEntry) THEN BEGIN
            JobJnlLine.VALIDATE("Job Planning Line No.", JobPlanningLine."Line No.");
            JobJnlLine.MODIFY(TRUE);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterApplyUsageLink(var JobLedgerEntry: Record "Job Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyJobJnlLine(var JobJournalLine: Record "Job Journal Line"; JobJournalLine2: Record "Job Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunCode(var JobJournalLine: Record "Job Journal Line"; JobLedgEntryNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCode(var JobJournalLine: Record "Job Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeApplyUsageLink(var JobLedgerEntry: Record "Job Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateJobLedgEntry(var JobJournalLine: Record "Job Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeJobLedgEntryInsert(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetJobConsumptionValueEntryFilter(var ValueEntry: Record "Value Entry"; JobJournalLine: Record "Job Journal Line")
    begin
    end;
}

*/