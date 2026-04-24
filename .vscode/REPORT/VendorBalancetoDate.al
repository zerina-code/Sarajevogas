report 50174 VendorBalancetoDate
{
    DefaultLayout = RDLC;
    RDLCLayout = './Vendor - Balance to Date.rdl';
    Caption = 'Vendor - Balance to Date';
    PreviewMode = PrintLayout;
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    // DataAccessIntent = ReadOnly;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked, "Date Filter";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(Vendor_GETRANGEMAXDateFilter; FORMAT(Vendor.GETRANGEMAX("Date Filter")))
            {
            }
            column(VendorFilter; "Date Filter") { }
            column(Vendor_TABLECAPTION; Vendor.TABLECAPTION)
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(VendLedgEntry3_TABLECAPTION; "Vendor Ledger Entry".TABLECAPTION)
            {
            }
            column(VendLedgFilter; VendLedgFilter)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(Name_Vendor; Name)
            {
            }
            column(PhoneNo_Vendor; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(Address; Address) { }
            column(City; City) { }
            column(Post_Code; "Post Code") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Registration_No_; "Registration No.") { }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                RequestFilterFields = "Document Type", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code";
                column(PostingDate_VendLedgEntry3; FORMAT("Posting Date"))
                {
                }
                column(KUF_Entry; KUF_Entry)
                {

                }
                column(DocumentType_VendLedgEntry3; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo_VendLedgEntry3; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(DocumentDate_VendLedgEntry3; FORMAT("Document Date"))
                {
                }
                column(ExternalDocumentNo_VendLedgEntry3; "External Document No.")
                {
                    IncludeCaption = true;
                }
                column(DueDate_VendLedgEntry3; FORMAT("Due Date"))
                {
                }
                column(Description_VendLedgEntry3; Description)
                {
                    IncludeCaption = true;
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                column(OriginalAmt; OriginalAmt)
                {
                }
                column(RemainingAmt; RemainingAmt)
                {
                }
                column(VendorPostingGroup_VendLedgEntry3; "Vendor Posting Group")
                {
                    IncludeCaption = true;
                }
                column(konto; konto)
                {
                }
                column(saldo; saldo)
                {
                }
                column(Claim; Claim)
                {
                }
                column(ShowHRK; ShowHRK)
                {
                }
                column(ExchangeRate; ExchangeRate)
                {
                }
                column(OriginalAmtHRK; OriginalAmtHRK)
                {
                }
                column(RemainingAmtHRK; RemainingAmtHRK)
                {
                }
                column(saldoHRK; saldoHRK)
                {
                }
                column(TotalSaldo; TotalSaldo)
                {

                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No."),
                                   "Posting Date" = FIELD("Date Filter");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(<> "Initial Entry"));
                    column(PostingDate_DetailedVendorLedgEntry; FORMAT("Detailed Vendor Ledg. Entry"."Posting Date"))
                    {
                    }
                    column(DocumentType_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Document Type")
                    {
                    }
                    column(DocumentNo_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Document No.")
                    {
                    }
                    column(EntryNo_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Entry No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF NOT PrintUnappliedEntries THEN IF Unapplied THEN CurrReport.SKIP;
                        IF PrintAmountInLCY THEN BEGIN
                            Amt := "Amount (LCY)";
                            CurrencyCode := '';
                        END ELSE BEGIN
                            Amt := Amount;
                            CurrencyCode := "Currency Code";
                        END;
                        IF Amt = 0 THEN CurrReport.SKIP;
                        DtldVendtLedgEntryNum := DtldVendtLedgEntryNum + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //BSL1.00 START
                        CurrReport.BREAK;
                        //BSL1.00 END
                        DtldVendtLedgEntryNum := 0;
                    end;
                }
                dataitem(ClosingEntries; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(PostingDate_VendLedgEntryTmp; FORMAT(VendLedgEntryTmp."Posting Date"))
                    {
                    }
                    column(DocumentType_VendLedgEntryTmp; FORMAT(VendLedgEntryTmp."Document Type", 0, '<Text>'))
                    {
                    }
                    column(DocumentNo_VendLedgEntryTmp; VendLedgEntryTmp."Document No.")
                    {
                    }
                    column(DocumentDate_VendLedgEntryTmp; FORMAT(VendLedgEntryTmp."Document Date"))
                    {
                    }
                    column(ExternalDocumentNo_VendLedgEntryTmp; VendLedgEntryTmp."External Document No.")
                    {
                    }
                    column(DueDate_VendLedgEntryTmp; FORMAT(VendLedgEntryTmp."Due Date"))
                    {
                    }
                    column(Description_VendLedgEntryTmp; VendLedgEntryTmp.Description)
                    {
                    }
                    column(Amt; Amt)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        //BSL1.00 START
                        IF Number = 1 THEN VendLedgEntryTmp.FIND('-') ELSE VendLedgEntryTmp.NEXT;
                        VendLedgEntryTmp.CALCFIELDS(Amount, "Amount (LCY)");
                        IF PrintAmountInLCY THEN BEGIN
                            Amt := VendLedgEntryTmp."Amount (LCY)";
                            CurrencyCode := '';
                        END ELSE BEGIN
                            Amt := VendLedgEntryTmp.Amount;
                            CurrencyCode := VendLedgEntryTmp."Currency Code";
                        END;
                        //BSL1.00 END
                    end;

                    trigger OnPreDataItem()
                    begin
                        //BSL1.00 START
                        IF VendLedgEntryTmp.COUNT = 0 THEN CurrReport.BREAK;
                        SETRANGE(Number, 1, VendLedgEntryTmp.COUNT);
                        //BSL1.00 END
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    PurchInvoiceHeader.SETFILTER("No.", '%1', "Document No.");//AA
                                                                              // IF PurchInvoiceHeader.FINDFIRST THEN
                                                                              // Claim := PurchInvoiceHeader.Claim;
                    CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                    IF PrintAmountInLCY THEN BEGIN
                        OriginalAmt := "Original Amt. (LCY)";
                        RemainingAmt := "Remaining Amt. (LCY)";
                        CurrencyCode := '';
                        //EK zk  saldo += RemainingAmt;
                        //EK
                        saldo := RemainingAmt;

                    END ELSE BEGIN
                        IF ShowHRK THEN BEGIN
                            //EK ispod
                            saldo := 0;
                            IF VendLedgEntry.FINDFIRST THEN BEGIN
                                REPEAT
                                    saldo := VendLedgEntry."Remaining Amt. (LCY)";
                                UNTIL VendLedgEntry.NEXT = 0;
                            END;
                            //EK iznad

                            CALCFIELDS("Original Amount", "Remaining Amount");
                            OriginalAmt := "Original Amount";
                            RemainingAmt := "Remaining Amount";
                            CurrencyCode := "Currency Code";
                            //EK zk saldo += RemainingAmt;
                            //EK
                            saldo := RemainingAmt;
                        END
                    END;
                    //BSL1.00 START
                    CurrencyTotalBuffer.UpdateTotal(CurrencyCode, RemainingAmt, "Remaining Amt. (LCY)", Counter1);
                    VendLedgEntryTmp.RESET;
                    IF ShowClosing THEN BEGIN
                        VendLedgEntryTmp.DELETEALL;
                        FindApplnEntriesDtldtLedgEntry("Vendor Ledger Entry");
                    END;

                    //BSL1.00 END
                    IF VPG.GET("Vendor Posting Group") THEN
                        konto := VPG."Payables Account"
                    ELSE
                        konto := '';
                end;

                trigger OnPreDataItem()
                begin
                    RESET;
                    konto := '';
                    //INT1.00 start
                    //IF VendorType <> 0 THEN
                    //SETRANGE("Vendor Type", VendorType);
                    //INT1.00 end
                    DtldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type");
                    DtldVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
                    DtldVendLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', MaxDate), 99991231D);
                    //BSL1.00 START
                    DtldVendLedgEntry.SETFILTER("Entry Type", '%1|%2|%3',
                      DtldVendLedgEntry."Entry Type"::"Unrealized Loss",
                      DtldVendLedgEntry."Entry Type"::"Unrealized Gain",
                      DtldVendLedgEntry."Entry Type"::Application);
                    IF PostingGroupFilter <> '' THEN DtldVendLedgEntry.SETFILTER("Vendor Posting Group", PostingGroupFilter);
                    IF CurrencyFilter <> '' THEN DtldVendLedgEntry.SETFILTER("Currency Code", CurrencyFilter);
                    //BSL1.00 END
                    IF NOT PrintUnappliedEntries THEN DtldVendLedgEntry.SETRANGE(Unapplied, FALSE);
                    IF DtldVendLedgEntry.FIND('-') THEN
                        REPEAT
                            "Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                            MARK(TRUE);
                        UNTIL DtldVendLedgEntry.NEXT = 0;
                    SETCURRENTKEY("Vendor No.", Open);
                    SETRANGE("Vendor No.", Vendor."No.");
                    IF NOT ShowClosing THEN
                        SETRANGE(Open, TRUE)
                    ELSE
                        SETRANGE(Open, FALSE);
                    SETRANGE("Posting Date", 0D, MaxDate);
                    //BSL1.00 START
                    IF CurrencyFilter <> '' THEN SETFILTER("Currency Code", CurrencyFilter);
                    IF PaymentMethodFilter <> '' THEN SETFILTER("Payment Method Code", PaymentMethodFilter);
                    //BSL1.00 END
                    IF FIND('-') THEN
                        REPEAT
                            MARK(TRUE);
                        UNTIL NEXT = 0;
                    SETCURRENTKEY("Entry No.");
                    //BSL1.00 START
                    IF SortByDueDate THEN SETCURRENTKEY("Due Date");
                    //BSL1.00 END
                    SETRANGE(Open);
                    MARKEDONLY(TRUE);
                    SETRANGE("Date Filter", 0D, MaxDate);
                    //BSL1.00 START
                    SETFILTER("Document Type", DocTypeFilter);
                    IF PostingGroupFilter <> '' THEN SETFILTER("Vendor Posting Group", PostingGroupFilter);
                    IF GDim1Filter <> '' THEN SETFILTER("Global Dimension 1 Code", GDim1Filter);
                    IF GDim2Filter <> '' THEN SETFILTER("Global Dimension 2 Code", GDim2Filter);
                    //BSL1.00 END
                end;
            }
            dataitem(Integer2; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(CurrencyCode_CurrencyTotalBuffer; CurrencyTotalBuffer."Currency Code")
                {
                }
                column(TotalAmount_CurrencyTotalBuffer; CurrencyTotalBuffer."Total Amount")
                {
                }
                column(ExchangeRate2; ExchangeRate2)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        OK := CurrencyTotalBuffer.FIND('-')
                    ELSE
                        OK := CurrencyTotalBuffer.NEXT <> 0;
                    IF NOT OK THEN
                        CurrReport.BREAK;
                    //BSL1.00 START
                    CurrencyTotalBuffer2.UpdateTotal
                      (CurrencyTotalBuffer."Currency Code", CurrencyTotalBuffer."Total Amount", CurrencyTotalBuffer."Total Amount (LCY)", Counter1);
                    //BSL1.00 END
                end;

                trigger OnPostDataItem()
                begin
                    CurrencyTotalBuffer.DELETEALL;
                end;

                trigger OnPreDataItem()
                begin
                    CurrencyTotalBuffer.SETFILTER("Total Amount", '<>0');
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //BSL1.00 START
                IF PrintOnePrPage THEN BEGIN
                    IF VendCode <> "No." THEN BEGIN
                        PageGroupNo := PageGroupNo + 1;
                        VendCode := "No."
                    END;
                END;
                //BSL1.00 END
                KnjizneGrupe := Vendor.GETFILTER("Vendor Posting Group");
                MaxDate := GETRANGEMAX("Date Filter");
                SETRANGE("Date Filter", 0D, MaxDate);
                CALCFIELDS("Net Change (LCY)", "Net Change");
                IF SkipWithoutNetChange THEN  //BSL1.00
                    IF ((PrintAmountInLCY AND (Vendor."Net Change (LCY)" = 0)) OR ((NOT PrintAmountInLCY) AND (Vendor."Net Change" = 0))) THEN
                        CurrReport.SKIP;
                //BSL1.00 START
                VendLedgEntry.RESET;
                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                VendLedgEntry.SETRANGE("Vendor No.", "No.");
                VendLedgEntry.SETRANGE("Date Filter", 0D, MaxDate);
                VendLedgEntry.SETFILTER("Remaining Amount", '<>%1', 0);
                IF KnjizneGrupe <> '' THEN
                    VendLedgEntry.SETRANGE("Vendor Posting Group", Vendor."Vendor Posting Group");
                IF PostingGroupFilter <> '' THEN VendLedgEntry.SETFILTER("Vendor Posting Group", PostingGroupFilter);
                IF PaymentMethodFilter <> '' THEN VendLedgEntry.SETFILTER("Payment Method Code", PaymentMethodFilter);
                IF NOT VendLedgEntry.FIND('-') THEN CurrReport.SKIP;
                //BSL1.00 END
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.NEWPAGEPERRECORD := PrintOnePrPage;
                //BSL1.00 START
                //IF PostingGroupFilter <> '' THEN SETFILTER("Posting Group Filter",PostingGroupFilter);
                PageGroupNo := 1;
                //BSL1.00 END
                saldo := 0;
                saldoHRK := 0;
                CER.RESET;
                CER.SETFILTER("Currency Code", '%1', 'HRK');
                CER.SETFILTER("Starting Date", '%1', 20230101D);
                IF CER.FINDFIRST THEN BEGIN
                    ExchangeRate := CER."Relational Exch. Rate Amount";
                END
                ELSE BEGIN
                    CER2.RESET;
                    CER2.SETFILTER("Currency Code", '%1', 'HRK');
                    CER2.SETCURRENTKEY("Starting Date");
                    IF CER2.FINDLAST THEN BEGIN
                        ExchangeRate := CER2."Relational Exch. Rate Amount";
                    END;
                END;
            end;
        }
        dataitem(Integer3; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(CurrencyCode_CurrencyTotalBuffer2; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(TotalAmount_CurrencyTotalBuffer2; CurrencyTotalBuffer2."Total Amount")
            {
            }
            column(TotalAmountLCY_CurrencyTotalBuffer2; CurrencyTotalBuffer2."Total Amount (LCY)")
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    OK := CurrencyTotalBuffer2.FIND('-')
                ELSE
                    OK := CurrencyTotalBuffer2.NEXT <> 0;
                IF NOT OK THEN CurrReport.BREAK;
            end;

            trigger OnPreDataItem()
            begin
                CER.RESET;
                CER.SETFILTER("Starting Date", '%1', 20230101D);
                IF CER.FINDFIRST THEN BEGIN
                    ExchangeRate2 := CER."Relational Exch. Rate Amount";
                END
                ELSE BEGIN
                    CER2.RESET;
                    CER2.SETCURRENTKEY("Starting Date");
                    IF CER2.FINDLAST THEN BEGIN
                        ExchangeRate2 := CER2."Relational Exch. Rate Amount";
                    END;
                END;
                CurrencyTotalBuffer2.SETFILTER("Total Amount", '<>0');
                CurrReport.CREATETOTALS(CurrencyTotalBuffer2."Total Amount (LCY)");
                /*IF ShowHRK
                  THEN BEGIN
                    CurrencyTotalBuffer2."Total Amount (LCY)" := CurrencyTotalBuffer2."Total Amount (LCY)" / ExchangeRate;
                    CurrencyTotalBuffer2."Total Amount" := CurrencyTotalBuffer2."Total Amount" / ExchangeRate;
                END;*/
            end;
        }
        dataitem("Extended Text Line"; "Extended Text Line")
        {
            DataItemTableView = SORTING("Table Name", "No.", "Language Code", "Text No.", "Line No.");
            column(Text_ExtendedTextLine; "Extended Text Line".Text)
            {
            }
            trigger OnPreDataItem()
            begin
                //BSL1.00 START
                IF PrintComision THEN BEGIN
                    IF StandTextCode <> '' THEN
                        SETRANGE("No.", StandTextCode)
                    ELSE
                        CurrReport.BREAK;
                END ELSE BEGIN
                    CurrReport.BREAK;
                END;
                //BSL1.00 END
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
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        Caption = 'Show Amounts in LCY';
                    }
                    field(PrintOnePrPage; PrintOnePrPage)
                    {
                        Caption = 'New Page per Vendor';
                    }
                    field(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                        Caption = 'Include Unapplied Entries';
                    }
                    field(ShowClosing; ShowClosing)
                    {
                        Caption = 'Show Closing Entries';
                    }
                    field(PrintComision; PrintComision)
                    {
                        Caption = 'Print Standard Text';
                    }
                    field(SortByDueDate; SortByDueDate)
                    {
                        Caption = 'Sort By Due Date';
                    }
                    field(StandTextCode; StandTextCode)
                    {
                        Caption = 'Standard Text Code';
                        Editable = PrintComision OR (NOT SortByDueDate);
                        TableRelation = "Standard Text";
                    }
                    field(VendPostGroupFilter; VendPostGroupFilter)
                    {
                        Caption = 'Print for G/L Account';
                        TableRelation = "G/L Account";
                    }
                    field(SkipWithoutNetChange; SkipWithoutNetChange)
                    {
                        Caption = 'Skip Vendors W/O Balance';
                    }
                    // field(VendorType; VendorType)
                    //{
                    // Caption = 'VendorType';
                    //}
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
        LblReportTitle = 'Vendor - Balance to Date';
        LblPage = 'Page';
        LblBalanceOn = 'Balance on';
        LblAllAmountsAreInLCY = 'All amounts are in LCY.';
        LbVendor = 'Vendor';
        LblPostingDate = 'Posting Date';
        LblDocumentDate = 'Document Date';
        LblDueDate = 'Due Date';
        LblAmount = 'Amount';
        LblRemainingAmount = 'Remaining Amount';
        LblTotal = 'Total';
        LblLCY = 'LCY';
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        ShowHRK := true;

    end;

    trigger OnPreReport()
    begin
        VendFilter := Vendor.GETFILTERS;
        VendDateFilter := Vendor.GETFILTER("Date Filter");
        //BSL1.00 START
        VendLedgFilter := "Vendor Ledger Entry".GETFILTERS;
        VendLedgFilter := "Vendor Ledger Entry".GETFILTERS;
        CurrencyFilter := "Vendor Ledger Entry".GETFILTER("Currency Code");
        IF PrintComision THEN BEGIN
            IF VendPostGroupFilter = '' THEN ERROR(Text001);
            ReportText := Text003;
        END ELSE BEGIN
            ReportText := Text002;
        END;
        DocTypeFilter := '';
        IF GLAccount.GET(VendPostGroupFilter) THEN;
        //IF Vendor.GETFILTER("Posting Group Filter")<>'' THEN PostingGroupFilter:=Vendor.GETFILTER("Posting Group Filter");
        IF "Vendor Ledger Entry".GETFILTER("Global Dimension 1 Code") <> '' THEN GDim1Filter := "Vendor Ledger Entry".GETFILTER("Global Dimension 1 Code");
        IF "Vendor Ledger Entry".GETFILTER("Global Dimension 2 Code") <> '' THEN GDim2Filter := "Vendor Ledger Entry".GETFILTER("Global Dimension 2 Code");
        IF "Vendor Ledger Entry".GETFILTER("Payment Method Code") <> '' THEN PaymentMethodFilter := "Vendor Ledger Entry".GETFILTER("Payment Method Code");
        IF "Vendor Ledger Entry".GETFILTER("Document Type") <> '' THEN DocTypeFilter := "Vendor Ledger Entry".GETFILTER("Document Type");
        //BSL1.00 END
    end;

    var
        Claim: Boolean;
        PurchInvoiceHeader: Record 122;
        DtldVendLedgEntry: Record 380;
        VendLedgEntry: Record 25;
        GLAccount: Record 15;
        CurrencyTotalBuffer: Record 332 temporary;
        CurrencyTotalBuffer2: Record 332 temporary;
        VendLedgEntryTmp: Record 25 temporary;
        VendFilter: Text[250];
        VendLedgFilter: Text[100];
        VendDateFilter: Text[30];
        ReportText: Text[100];
        DocTypeFilter: Text[100];
        CurrencyFilter: Text[100];
        VendPostGroupFilter: Text[100];
        PostingGroupFilter: Text[100];
        GDim1Filter: Text[30];
        PaymentMethodFilter: Text[100];
        GDim2Filter: Text[30];
        PrintComision: Boolean;
        Text000: Label 'Balance on %1';
        Text001: Label 'Vendor Posting Group Filter must be selected!';
        Text002: Label 'Vendor - Balance to Date';
        Text003: Label 'Inventory - Vendor Opened Entries';
        PrintOnePrPage: Boolean;
        SkipWithoutNetChange: Boolean;
        KnjizneGrupe: Text;
        ShowClosing: Boolean;
        PrintAmountInLCY: Boolean;
        SortByDueDate: Boolean;
        OK: Boolean;
        PrintUnappliedEntries: Boolean;
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        CurrencyCode: Code[10];
        StandTextCode: Code[10];
        VendCode: Code[20];
        Counter1: Integer;
        DtldVendtLedgEntryNum: Integer;
        PageGroupNo: Integer;
        Type: Integer;
        //VendorType: Option " ",Ink,"Spare parts";
        VPG: Record 93;
        konto: Text;
        saldo: Decimal;
        VendLedgEntryTmp2: Record 25 temporary;
        ShowHRK: Boolean;
        CER: Record 330;
        ExchangeRate: Decimal;
        CER2: Record 330;
        ExchangeRate2: Decimal;
        OriginalAmtHRK: Decimal;
        RemainingAmtHRK: Decimal;
        saldoHRK: Decimal;
        TotalSaldo: Decimal;

    procedure InitializeRequest(NewPrintAmountInLCY: Boolean; NewPrintOnePrPage: Boolean; NewPrintUnappliedEntries: Boolean)
    begin
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintOnePrPage := NewPrintOnePrPage;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
    end;

    procedure FindApplnEntriesDtldtLedgEntry(InputVendLedgEntry: Record 25)
    var
        DtldVendLedgEntry1: Record 380;
        DtldVendLedgEntry2: Record 380;
        VendLedgEntry: Record 25;
    begin
        DtldVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
        DtldVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", InputVendLedgEntry."Entry No.");
        DtldVendLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldVendLedgEntry1.FIND('-') THEN
            REPEAT
                IF DtldVendLedgEntry1."Vendor Ledger Entry No." = DtldVendLedgEntry1."Applied Vend. Ledger Entry No." THEN BEGIN
                    DtldVendLedgEntry2.INIT;
                    DtldVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SETRANGE("Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldVendLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldVendLedgEntry2."Vendor Ledger Entry No." <> DtldVendLedgEntry2."Applied Vend. Ledger Entry No." THEN BEGIN
                                VendLedgEntry.SETCURRENTKEY("Entry No.");
                                VendLedgEntry.SETRANGE("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                IF VendLedgEntry.FIND('-') THEN BEGIN
                                    VendLedgEntryTmp.INIT;
                                    VendLedgEntryTmp := VendLedgEntry;
                                    IF NOT VendLedgEntryTmp.GET(VendLedgEntry."Entry No.") THEN
                                        VendLedgEntryTmp.INSERT;
                                END;
                            END;
                        UNTIL DtldVendLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    VendLedgEntry.SETCURRENTKEY("Entry No.");
                    VendLedgEntry.SETRANGE("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    IF VendLedgEntry.FIND('-') THEN BEGIN
                        VendLedgEntry.CALCFIELDS(Amount, "Amount (LCY)");
                        VendLedgEntryTmp.INIT;
                        VendLedgEntryTmp := VendLedgEntry;
                        IF NOT VendLedgEntryTmp.GET(VendLedgEntry."Entry No.") THEN
                            VendLedgEntryTmp.INSERT;
                    END;
                END;
            UNTIL DtldVendLedgEntry1.NEXT = 0;
    end;
}
