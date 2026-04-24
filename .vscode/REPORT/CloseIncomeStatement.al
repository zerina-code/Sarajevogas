report 50173 CloseIncomeStatement
{
    // //SKHR7.00 Croatian Localization
    // //SKHR7.00 mco 2013-03-15
    // // Added new fields to req page: Fiscal Period Starting Date, Fiscal Period Ending Date
    // // Added code, ExchDebitCreditGenJnlLine function

    Caption = 'Close Income Statement';
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Account Type" = CONST(Posting),
                                      "Income/Balance" = CONST("Income Statement"));
            RequestFilterFields = "No.";
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("G/L Account No.", "Posting Date");

                trigger OnAfterGetRecord()
                var
                    TempDimBuf: Record 360 temporary;
                    TempDimBuf2: Record 360 temporary;
                    DimensionBufferID: Integer;
                    RowOffset: Integer;
                begin
                    EntryCount := EntryCount + 1;
                    IF TIME - LastWindowUpdate > 1000 THEN BEGIN
                        LastWindowUpdate := TIME;
                        Window.UPDATE(3, ROUND(EntryCount / MaxEntry * 10000, 1));
                    END;

                    IF GroupSum THEN BEGIN
                        CalcSumsInFilter("G/L Entry", RowOffset);
                        GetGLEntryDimensions("Entry No.", TempDimBuf, "Dimension Set ID");
                    END;

                    IF (Amount <> 0) OR ("Additional-Currency Amount" <> 0) THEN BEGIN
                        IF NOT GroupSum THEN BEGIN
                            TotalAmount += Amount;
                            IF GLSetup."Additional Reporting Currency" <> '' THEN
                                TotalAmountAddCurr += "Additional-Currency Amount";

                            GetGLEntryDimensions("Entry No.", TempDimBuf, "Dimension Set ID");
                        END;

                        IF TempSelectedDim.FIND('-') THEN
                            REPEAT
                                IF TempDimBuf.GET(DATABASE::"G/L Entry", "Entry No.", TempSelectedDim."Dimension Code")
                                THEN BEGIN
                                    TempDimBuf2."Table ID" := TempDimBuf."Table ID";
                                    TempDimBuf2."Dimension Code" := TempDimBuf."Dimension Code";
                                    TempDimBuf2."Dimension Value Code" := TempDimBuf."Dimension Value Code";
                                    TempDimBuf2.INSERT;
                                END;
                            UNTIL TempSelectedDim.NEXT = 0;

                        DimensionBufferID := DimBufMgt.GetDimensionId(TempDimBuf2);

                        EntryNoAmountBuf.RESET;
                        IF ClosePerBusUnit AND FIELDACTIVE("Business Unit Code") THEN
                            EntryNoAmountBuf."Business Unit Code" := "Business Unit Code"
                        ELSE
                            EntryNoAmountBuf."Business Unit Code" := '';
                        EntryNoAmountBuf."Entry No." := DimensionBufferID;
                        IF EntryNoAmountBuf.FIND THEN BEGIN
                            EntryNoAmountBuf.Amount := EntryNoAmountBuf.Amount + Amount;
                            EntryNoAmountBuf.Amount2 := EntryNoAmountBuf.Amount2 + "Additional-Currency Amount";
                            EntryNoAmountBuf.MODIFY;
                        END ELSE BEGIN
                            EntryNoAmountBuf.Amount := Amount;
                            EntryNoAmountBuf.Amount2 := "Additional-Currency Amount";
                            EntryNoAmountBuf.INSERT;
                        END;
                    END;

                    IF GroupSum THEN
                        NEXT(RowOffset);
                end;

                trigger OnPostDataItem()
                var
                    TempDimBuf2: Record 360 temporary;
                    GlobalDimVal1: Code[20];
                    GlobalDimVal2: Code[20];
                    NewDimensionID: Integer;
                begin
                    EntryNoAmountBuf.RESET;
                    MaxEntry := EntryNoAmountBuf.COUNT;
                    EntryCount := 0;
                    Window.UPDATE(2, Text012);
                    Window.UPDATE(3, 0);

                    IF EntryNoAmountBuf.FIND('-') THEN
                        REPEAT
                            EntryCount := EntryCount + 1;
                            IF TIME - LastWindowUpdate > 1000 THEN BEGIN
                                LastWindowUpdate := TIME;
                                Window.UPDATE(3, ROUND(EntryCount / MaxEntry * 10000, 1));
                            END;

                            IF (EntryNoAmountBuf.Amount <> 0) OR (EntryNoAmountBuf.Amount2 <> 0) THEN BEGIN
                                GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
                                GenJnlLine."Account No." := "G/L Account No.";
                                GenJnlLine."Source Code" := SourceCodeSetup."Close Income Statement";
                                GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
                                GenJnlLine.VALIDATE(Amount, -EntryNoAmountBuf.Amount);
                                GenJnlLine."Source Currency Amount" := -EntryNoAmountBuf.Amount2;
                                GenJnlLine."Business Unit Code" := EntryNoAmountBuf."Business Unit Code";

                                TempDimBuf2.DELETEALL;
                                DimBufMgt.RetrieveDimensions(EntryNoAmountBuf."Entry No.", TempDimBuf2);
                                NewDimensionID := DimMgt.CreateDimSetIDFromDimBuf(TempDimBuf2);
                                GenJnlLine."Dimension Set ID" := NewDimensionID;
                                DimMgt.UpdateGlobalDimFromDimSetID(NewDimensionID, GlobalDimVal1, GlobalDimVal2);
                                GenJnlLine."Shortcut Dimension 1 Code" := '';
                                IF ClosePerGlobalDim1 THEN
                                    GenJnlLine."Shortcut Dimension 1 Code" := GlobalDimVal1;
                                GenJnlLine."Shortcut Dimension 2 Code" := '';
                                IF ClosePerGlobalDim2 THEN
                                    GenJnlLine."Shortcut Dimension 2 Code" := GlobalDimVal2;

                                //SKHR7.00 - START
                                ExchDebitCreditGenJnlLine(GenJnlLine);
                                //SKHR7.00 - END
                                HandleGenJnlLine;
                            END;
                        UNTIL EntryNoAmountBuf.NEXT = 0;

                    EntryNoAmountBuf.DELETEALL;
                end;

                trigger OnPreDataItem()
                begin
                    Window.UPDATE(2, Text013);
                    Window.UPDATE(3, 0);

                    IF ClosePerGlobalDimOnly OR ClosePerBusUnit THEN
                        CASE TRUE OF
                            ClosePerBusUnit AND (ClosePerGlobalDim1 OR ClosePerGlobalDim2):
                                SETCURRENTKEY(
                                  "G/L Account No.", "Business Unit Code",
                                  "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                            ClosePerBusUnit AND NOT (ClosePerGlobalDim1 OR ClosePerGlobalDim2):
                                SETCURRENTKEY(
                                  "G/L Account No.", "Business Unit Code", "Posting Date");
                            NOT ClosePerBusUnit AND (ClosePerGlobalDim1 OR ClosePerGlobalDim2):
                                SETCURRENTKEY(
                                  "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                        END;

                    SETRANGE("Posting Date", FiscalYearStartDate, FiscYearClosingDate);

                    MaxEntry := COUNT;

                    EntryNoAmountBuf.DELETEALL;
                    EntryCount := 0;

                    LastWindowUpdate := TIME;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ThisAccountNo := ThisAccountNo + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(4, ROUND(ThisAccountNo / NoOfAccounts * 10000, 1));
                Window.UPDATE(2, '');
                Window.UPDATE(3, 0);
            end;

            trigger OnPostDataItem()
            begin
                IF (TotalAmount <> 0) OR ((TotalAmountAddCurr <> 0) AND (GLSetup."Additional Reporting Currency" <> '')) THEN BEGIN
                    GenJnlLine."Business Unit Code" := '';
                    GenJnlLine."Shortcut Dimension 1 Code" := '';
                    GenJnlLine."Shortcut Dimension 2 Code" := '';
                    GenJnlLine."Dimension Set ID" := 0;
                    GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
                    GenJnlLine."Account No." := RetainedEarningsGLAcc."No.";
                    GenJnlLine."Source Code" := SourceCodeSetup."Close Income Statement";
                    GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
                    GenJnlLine."Currency Code" := '';
                    GenJnlLine."Additional-Currency Posting" :=
                      GenJnlLine."Additional-Currency Posting"::None;
                    //SKHR7.00 - START
                    GenJnlLine.Correction := FALSE;
                    //SKHR7.00 - END
                    GenJnlLine.VALIDATE(Amount, TotalAmount);
                    GenJnlLine."Source Currency Amount" := TotalAmountAddCurr;
                    HandleGenJnlLine;
                    Window.UPDATE(1, GenJnlLine."Account No.");
                END;
            end;

            trigger OnPreDataItem()
            begin
                NoOfAccounts := COUNT;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FiscalPeriodStartingDate; FiscalYearStartDate)
                    {
                        Caption = 'Fiscal Period Starting Date';
                        Editable = false;

                        trigger OnValidate()
                        begin
                            ValidateEndDate(TRUE);
                        end;
                    }
                    field(FiscalPeriodEndingDate; EndDateReq)
                    {
                        Caption = 'Fiscal Period Ending Date';

                        trigger OnValidate()
                        begin
                            ValidateEndDate(TRUE);
                        end;
                    }
                    field(GenJournalTemplate; GenJnlLine."Journal Template Name")
                    {
                        Caption = 'Gen. Journal Template';
                        TableRelation = "Gen. Journal Template";

                        trigger OnValidate()
                        begin
                            GenJnlLine."Journal Batch Name" := '';
                            DocNo := '';
                        end;
                    }
                    field(GenJournalBatch; GenJnlLine."Journal Batch Name")
                    {
                        Caption = 'Gen. Journal Batch';
                        Lookup = true;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            GenJnlLine.TESTFIELD("Journal Template Name");
                            GenJnlTemplate.GET(GenJnlLine."Journal Template Name");
                            GenJnlBatch.FILTERGROUP(2);
                            GenJnlBatch.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlBatch.FILTERGROUP(0);
                            GenJnlBatch."Journal Template Name" := GenJnlLine."Journal Template Name";
                            GenJnlBatch.Name := GenJnlLine."Journal Batch Name";
                            IF PAGE.RUNMODAL(0, GenJnlBatch) = ACTION::LookupOK THEN BEGIN
                                Text := GenJnlBatch.Name;
                                EXIT(TRUE);
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            IF GenJnlLine."Journal Batch Name" <> '' THEN BEGIN
                                GenJnlLine.TESTFIELD("Journal Template Name");
                                GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                            END;
                            ValidateJnl;
                        end;
                    }
                    field(DocumentNo; DocNo)
                    {
                        Caption = 'Document No.';
                    }
                    field(RetainedEarningsAcc; RetainedEarningsGLAcc."No.")
                    {
                        Caption = 'Retained Earnings Acc.';
                        TableRelation = "G/L Account";

                        trigger OnValidate()
                        begin
                            IF RetainedEarningsGLAcc."No." <> '' THEN BEGIN
                                RetainedEarningsGLAcc.FIND;
                                RetainedEarningsGLAcc.CheckGLAcc;
                            END;
                        end;
                    }
                    field(PostingDescription; PostingDescription)
                    {
                        Caption = 'Posting Description';
                    }
                    group("Close by")
                    {
                        Caption = 'Close by';
                        field(ClosePerBusUnit; ClosePerBusUnit)
                        {
                            Caption = 'Business Unit Code';
                        }
                        field(Dimensions; ColumnDim)
                        {
                            Caption = 'Dimensions';
                            Editable = false;

                            trigger OnAssistEdit()
                            var
                                TempSelectedDim2: Record 369 temporary;
                                s: Text[1024];
                            begin
                                DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Close Income Statement", ColumnDim);

                                SelectedDim.GetSelectedDim(USERID, 3, REPORT::"Close Income Statement", '', TempSelectedDim2);
                                s := CheckDimPostingRules(TempSelectedDim2);
                                IF s <> '' THEN
                                    MESSAGE(s);
                            end;
                        }
                    }
                    field(IsInvtPeriodClosed; IsInvtPeriodClosed)
                    {
                        Caption = 'Inventory Period Closed';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PostingDescription = '' THEN
                PostingDescription :=
                  COPYSTR(ObjTransl.TranslateObject(ObjTransl."Object Type"::Report, REPORT::"Close Income Statement"), 1, 30);
            EndDateReq := 0D;
            AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
            AccountingPeriod.SETRANGE("Date Locked", TRUE);
            IF AccountingPeriod.FIND('+') THEN BEGIN
                EndDateReq := AccountingPeriod."Starting Date" - 1;
                IF NOT ValidateEndDate(FALSE) THEN
                    EndDateReq := 0D;
            END;
            ValidateJnl;
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Close Income Statement", '');
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        UpdateAnalysisView: Codeunit 410;
    begin
        Window.CLOSE;
        COMMIT;
        IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
            MESSAGE(Text016);
            UpdateAnalysisView.UpdateAll(0, TRUE);
        END ELSE
            MESSAGE(Text017);
    end;

    trigger OnPreReport()
    var
        s: Text[1024];
    begin
        IF EndDateReq = 0D THEN
            ERROR(Text000);
        ValidateEndDate(TRUE);
        IF DocNo = '' THEN
            ERROR(Text001);

        SelectedDim.GetSelectedDim(USERID, 3, REPORT::"Close Income Statement", '', TempSelectedDim);
        s := CheckDimPostingRules(TempSelectedDim);
        IF s <> '' THEN
            IF NOT CONFIRM(s + Text007, FALSE) THEN
                ERROR('');

        GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        SourceCodeSetup.GET;
        GLSetup.GET;
        IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
            IF RetainedEarningsGLAcc."No." = '' THEN
                ERROR(Text002);
            IF NOT CONFIRM(
                 Text003 +
                 Text005 +
                 Text007, FALSE)
            THEN
                ERROR('');
        END;

        Window.OPEN(Text008 + Text009 + Text019 + Text010 + Text011);

        ClosePerGlobalDim1 := FALSE;
        ClosePerGlobalDim2 := FALSE;
        ClosePerGlobalDimOnly := TRUE;

        IF TempSelectedDim.FIND('-') THEN
            REPEAT
                IF TempSelectedDim."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
                    ClosePerGlobalDim1 := TRUE;
                IF TempSelectedDim."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                    ClosePerGlobalDim2 := TRUE;
                IF (TempSelectedDim."Dimension Code" <> GLSetup."Global Dimension 1 Code") AND
                   (TempSelectedDim."Dimension Code" <> GLSetup."Global Dimension 2 Code")
                THEN
                    ClosePerGlobalDimOnly := FALSE;
            UNTIL TempSelectedDim.NEXT = 0;

        GenJnlLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        IF NOT GenJnlLine.FINDLAST THEN;
        GenJnlLine.INIT;
        GenJnlLine."Posting Date" := FiscYearClosingDate;
        GenJnlLine."Document No." := DocNo;
        GenJnlLine.Description := PostingDescription;
        GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
    end;

    var
        AccountingPeriod: Record 50;
        SourceCodeSetup: Record 242;
        GenJnlTemplate: Record 80;
        GenJnlBatch: Record 232;
        GenJnlLine: Record 81;
        RetainedEarningsGLAcc: Record 15;
        GLSetup: Record 98;
        DimSelectionBuf: Record 368;
        SelectedDim: Record 369;
        TempSelectedDim: Record 369 temporary;
        EntryNoAmountBuf: Record 386 temporary;
        NoSeriesMgt: Codeunit 396;
        GenJnlPostLine: Codeunit 12;
        DimMgt: Codeunit 408;
        DimBufMgt: Codeunit 411;
        Window: Dialog;
        FiscalYearStartDate: Date;
        FiscYearClosingDate: Date;
        EndDateReq: Date;
        DocNo: Code[20];
        PostingDescription: Text[50];
        ClosePerBusUnit: Boolean;
        ClosePerGlobalDim1: Boolean;
        ClosePerGlobalDim2: Boolean;
        ClosePerGlobalDimOnly: Boolean;
        TotalAmount: Decimal;
        TotalAmountAddCurr: Decimal;
        ColumnDim: Text[250];
        ObjTransl: Record 377;
        NoOfAccounts: Integer;
        ThisAccountNo: Integer;
        Text000: Label 'Enter the ending date for the fiscal year.';
        Text001: Label 'Enter a Document No.';
        Text002: Label 'Enter Retained Earnings Account No.';
        Text003: Label 'By using an additional reporting currency, this batch job will post closing entries directly to the general ledger.  ';
        Text005: Label 'These closing entries will not be transferred to a general journal before the program posts them to the general ledger.\\ ';
        Text007: Label '\Do you want to continue?';
        Text008: Label 'Creating general journal lines...\\';
        Text009: Label 'Account No.         #1##################\';
        Text010: Label 'Now performing      #2##################\';
        Text011: Label '                    @3@@@@@@@@@@@@@@@@@@\';
        Text019: Label '                    @4@@@@@@@@@@@@@@@@@@\';
        Text012: Label 'Creating Gen. Journal lines';
        Text013: Label 'Calculating Amounts';
        Text014: Label 'The fiscal year must be closed before the income statement can be closed.';
        Text015: Label 'The fiscal year does not exist.';
        Text017: Label 'The journal lines have successfully been created.';
        Text016: Label 'The closing entries have successfully been posted.';
        Text020: Label 'The following G/L Accounts have mandatory dimension codes that have not been selected:';
        Text021: Label '\\In order to post to these accounts you must also select these dimensions:';
        MaxEntry: Integer;
        EntryCount: Integer;
        LastWindowUpdate: Time;

    local procedure ValidateEndDate(RealMode: Boolean): Boolean
    var
        OK: Boolean;
    begin
        IF EndDateReq = 0D THEN
            EXIT;

        OK := AccountingPeriod.GET(EndDateReq + 1);
        IF OK THEN
            OK := AccountingPeriod."New Fiscal Year";
        IF OK THEN BEGIN
            IF NOT AccountingPeriod."Date Locked" THEN BEGIN
                IF NOT RealMode THEN
                    EXIT;
                ERROR(Text014);
            END;
            FiscYearClosingDate := CLOSINGDATE(EndDateReq);
            //SKHR7.00 - START
            //  AccountingPeriod.SETRANGE("New Fiscal Year",TRUE);
            //SKHR7.00 - END
            OK := AccountingPeriod.FIND('<');
            FiscalYearStartDate := AccountingPeriod."Starting Date";
        END;
        IF NOT OK THEN BEGIN
            IF NOT RealMode THEN
                EXIT;
            ERROR(Text015);
        END;
        EXIT(TRUE);
    end;

    local procedure ValidateJnl()
    begin
        DocNo := '';
        IF GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") THEN
            IF GenJnlBatch."No. Series" <> '' THEN
                DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", EndDateReq);
    end;

    local procedure HandleGenJnlLine()
    begin
        GenJnlLine."Additional-Currency Posting" :=
          GenJnlLine."Additional-Currency Posting"::None;
        IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
            GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
            IF ZeroGenJnlAmount THEN BEGIN
                GenJnlLine."Additional-Currency Posting" :=
                  GenJnlLine."Additional-Currency Posting"::"Additional-Currency Amount Only";
                GenJnlLine.VALIDATE(Amount, GenJnlLine."Source Currency Amount");
                GenJnlLine."Source Currency Amount" := 0;
            END;
            IF GenJnlLine.Amount <> 0 THEN BEGIN
                GenJnlPostLine.RUN(GenJnlLine);
                IF DocNo = NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", EndDateReq, FALSE) THEN
                    NoSeriesMgt.SaveNoSeries;
            END;
        END ELSE
            IF NOT ZeroGenJnlAmount THEN
                GenJnlLine.INSERT;
    end;

    local procedure CalcSumsInFilter(var GLEntrySource: Record 17; var Offset: Integer)
    var
        GLEntry: Record 17;
    begin
        GLEntry.COPYFILTERS(GLEntrySource);
        IF ClosePerBusUnit THEN BEGIN
            GLEntry.SETRANGE("Business Unit Code", GLEntrySource."Business Unit Code");
            GenJnlLine."Business Unit Code" := GLEntrySource."Business Unit Code";
        END;
        IF ClosePerGlobalDim1 THEN BEGIN
            GLEntry.SETRANGE("Global Dimension 1 Code", GLEntrySource."Global Dimension 1 Code");
            IF ClosePerGlobalDim2 THEN
                GLEntry.SETRANGE("Global Dimension 2 Code", GLEntrySource."Global Dimension 2 Code");
        END;

        GLEntry.CALCSUMS(Amount);
        GLEntrySource.Amount := GLEntry.Amount;
        TotalAmount += GLEntrySource.Amount;
        IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
            GLEntry.CALCSUMS("Additional-Currency Amount");
            GLEntrySource."Additional-Currency Amount" := GLEntry."Additional-Currency Amount";
            TotalAmountAddCurr += GLEntrySource."Additional-Currency Amount";
        END;
        Offset := GLEntry.COUNT - 1;
    end;

    local procedure GetGLEntryDimensions(EntryNo: Integer; var DimBuf: Record 360; DimensionSetID: Integer)
    var
        DimSetEntry: Record 480;
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimensionSetID);
        IF DimSetEntry.FINDSET THEN
            REPEAT
                DimBuf."Table ID" := DATABASE::"G/L Entry";
                DimBuf."Entry No." := EntryNo;
                DimBuf."Dimension Code" := DimSetEntry."Dimension Code";
                DimBuf."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                DimBuf.INSERT;
            UNTIL DimSetEntry.NEXT = 0;
    end;

    local procedure CheckDimPostingRules(var SelectedDim: Record 369): Text[1024]
    var
        DefaultDim: Record 352;
        s: Text[1024];
        d: Text[1024];
        PrevAcc: Code[20];
    begin
        DefaultDim.SETRANGE("Table ID", DATABASE::"G/L Account");
        DefaultDim.SETFILTER(
          "Value Posting", '%1|%2',
          DefaultDim."Value Posting"::"Same Code", DefaultDim."Value Posting"::"Code Mandatory");

        IF DefaultDim.FIND('-') THEN
            REPEAT
                SelectedDim.SETRANGE("Dimension Code", DefaultDim."Dimension Code");
                IF NOT SelectedDim.FIND('-') THEN BEGIN
                    IF STRPOS(d, DefaultDim."Dimension Code") < 1 THEN
                        d := d + ' ' + FORMAT(DefaultDim."Dimension Code");
                    IF PrevAcc <> DefaultDim."No." THEN BEGIN
                        PrevAcc := DefaultDim."No.";
                        IF s = '' THEN
                            s := Text020;
                        s := s + ' ' + FORMAT(DefaultDim."No.");
                    END;
                END;
                SelectedDim.SETRANGE("Dimension Code");
            UNTIL (DefaultDim.NEXT = 0) OR (STRLEN(s) > MAXSTRLEN(s) - MAXSTRLEN(DefaultDim."No.") - STRLEN(Text021) - 1);
        IF s <> '' THEN
            s := COPYSTR(s + Text021 + d, 1, MAXSTRLEN(s));
        EXIT(s);
    end;

    local procedure IsInvtPeriodClosed(): Boolean
    var
        AccPeriod: Record 50;
        InvtPeriod: Record 5814;
    begin
        AccPeriod.GET(EndDateReq + 1);
        AccPeriod.NEXT(-1);
        EXIT(InvtPeriod.IsInvtPeriodClosed(AccPeriod."Starting Date"));
    end;

    procedure InitializeRequestTest(EndDate: Date; GenJournalLine: Record 81; GLAccount: Record 15; CloseByBU: Boolean)
    begin
        EndDateReq := EndDate;
        GenJnlLine := GenJournalLine;
        ValidateJnl;
        RetainedEarningsGLAcc := GLAccount;
        ClosePerBusUnit := CloseByBU;
    end;

    local procedure ZeroGenJnlAmount(): Boolean
    begin
        EXIT((GenJnlLine.Amount = 0) AND (GenJnlLine."Source Currency Amount" <> 0))
    end;

    local procedure GroupSum(): Boolean
    begin
        EXIT(ClosePerGlobalDimOnly AND (ClosePerBusUnit OR ClosePerGlobalDim1));
    end;

    local procedure __SKHRfunc__()
    begin
    end;

    procedure ExchDebitCreditGenJnlLine(var GenJnlLine2: Record 81)
    var
        GLAcc: Record 15;
    begin
        //SKHR7.00 - START
        IF GLSetup."Additional Reporting Currency" <> '' THEN
            EXIT;

        GLAcc.GET(GenJnlLine2."Account No.");
        IF GLAcc."Debit/Credit" = GLAcc."Debit/Credit"::Both THEN
            EXIT;

        CASE GLAcc."Debit/Credit" OF
            GLAcc."Debit/Credit"::Debit:
                IF GenJnlLine2."Debit Amount" <> 0 THEN
                    GenJnlLine2.VALIDATE("Credit Amount", -GenJnlLine2."Debit Amount");
            GLAcc."Debit/Credit"::Credit:
                IF GenJnlLine2."Credit Amount" <> 0 THEN
                    GenJnlLine2.VALIDATE("Debit Amount", -GenJnlLine2."Credit Amount");
        END;
        //SKHR7.00 - END
    end;
}

