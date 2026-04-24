report 50145 VendorDetailTrailBal
{

    DefaultLayout = RDLC;
    RDLCLayout = './VendorDetailTrialBalance.rdl';
    Caption = 'Vendor - Detail Trial Balance';
    ApplicationArea = basic, suite;
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;



    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Vendor Posting Group", "Date Filter";
            column(VendDatetFilterPeriod; STRSUBSTNO(Text000, VendDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(Redni; Redni_ISPIS) { }
            column(VendorTblCapVendFltr; TABLECAPTION + ': ' + VendFilter)
            {
            }
            column(Pictures; CompInfo.Picture)
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(AmountCaption; AmountCaption)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
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
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceLCY; VendBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYStartBalAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendDetailTrialBalCap; VendDetailTrialBalCapLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(AllamountsareinLCYCaption; AllamountsareinLCYCaptionLbl)
            {
            }
            column(ReportIncludesvendorshavebalanceCaption; ReportIncludesvendorshavebalanceCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(AdjofOpeningBalanceCaption; AdjofOpeningBalanceCaptionLbl)
            {
            }
            column(TotalLCYCaption; TotalLCYCaptionLbl)
            {
            }
            column(TotalAdjofOpenBalCaption; TotalAdjofOpenBalCaptionLbl)
            {
            }
            column(TotalLCYBeforePeriodCaption; TotalLCYBeforePeriodCaptionLbl)
            {
            }
            column(Address; Address) { }
            column(City; City) { }
            column(Post_Code; "Post Code") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Registration_No_; "Registration No.") { }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                               "Date Filter" = FIELD("Date Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date");
                column(PostingDate_VendLedgEntry; FORMAT("dOCUMENT Date"))
                {
                }
                column(KUF_Entry; KUF_Entry)
                {

                }
                column(Ext; "External Document No.")
                {

                }
                column(DocType_VendLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_VendLedgerEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_VendLedgerEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(Debit_Amount__LCY_; "Debit Amount (LCY)")
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(Credit_Amount__LCY_; "Credit Amount (LCY)")
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendAmount; VendAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendBalLCY2; VendBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(VendRemainAmount; VendRemainAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendEntryDueDate; FORMAT(VendEntryDueDate))
                {
                }
                column(EntryNo_VendorLedgerEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(VendCurrencyCode; VendCurrencyCode)
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = CONST("Correction of Remaining Amount"));
                    column(EntryTyp_DetVendLedgEntry; "Entry Type")
                    {
                    }
                    column(Correction; Correction)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Correction := Correction + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPostDataItem()
                    begin
                        SumCorrections := SumCorrections + Correction;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", VendDateFilter);
                        Correction := 0;
                    end;
                }
                dataitem("Detailed Vendor Ledg. Entry2"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = CONST("Appln. Rounding"));
                    column(Entry_DetVendLedgEntry2; "Entry Type")
                    {
                    }
                    column(VendBalanceLCY3; VendBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", VendDateFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    Redni_ISPIS := Redni;

                    Redni := Redni + 1;

                    //  if Redni=1 then 
                    //Redni_ISPIS:= 

                    CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");

                    VendLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                        VendAmount := "Amount (LCY)";
                        VendRemainAmount := "Remaining Amt. (LCY)";
                        VendCurrencyCode := '';
                    END ELSE BEGIN
                        VendAmount := Amount;
                        VendRemainAmount := "Remaining Amount";
                        VendCurrencyCode := "Currency Code";
                    END;
                    VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                        VendEntryDueDate := 0D
                    ELSE
                        VendEntryDueDate := "Due Date";
                end;

                trigger OnPreDataItem()
                begin
                    if ShowAll = false then begin
                        "Vendor Ledger Entry".SETFILTER(Prepayment, '%1', ShowPrepayment);
                    end;

                    VendLedgEntryExists := FALSE;
                    CurrReport.CREATETOTALS(VendAmount, "Amount (LCY)");

                end;


            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(VendBalanceLCY4; VendBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalAdjLCY1; StartBalAdjLCY)
                {
                }
                column(StartBalanceLCY1; StartBalanceLCY)
                {
                }
                column(VendBalStrtBalStrtBalAdj; VendBalanceLCY - StartBalanceLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT VendLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                        StartBalanceLCY := 0;
                        CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);

                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF VendDateFilter <> '' THEN BEGIN
                    IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                        SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                        CALCFIELDS("Net Change (LCY)");
                        StartBalanceLCY := -"Net Change (LCY)";
                    END;
                    SETFILTER("Date Filter", VendDateFilter);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalAdjLCY := -"Net Change (LCY)";
                    VendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SETRANGE("Vendor No.", "No.");
                    VendorLedgerEntry.SETFILTER("Posting Date", VendDateFilter);
                    IF VendorLedgerEntry.FIND('-') THEN
                        REPEAT
                            VendorLedgerEntry.SETFILTER("Date Filter", VendDateFilter);
                            VendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                            "Detailed Vendor Ledg. Entry".SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Vendor Ledg. Entry".SETRANGE("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SETFILTER("Entry Type", '%1|%2',
                              "Detailed Vendor Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                              "Detailed Vendor Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SETFILTER("Posting Date", VendDateFilter);
                            IF "Detailed Vendor Ledg. Entry".FIND('-') THEN
                                REPEAT
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                UNTIL "Detailed Vendor Ledg. Entry".NEXT = 0;
                            "Detailed Vendor Ledg. Entry".RESET;
                        UNTIL VendorLedgerEntry.NEXT = 0;
                END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;

                IF ShowPrepayment = true THEN
                    VenLedgEntry.SETFILTER(Prepayment, '<> %1', FALSE)
                ELSE
                    if ShowPrepayment = false then
                        VenLedgEntry.SETFILTER(Prepayment, ' %1|%2', FALSE, TRUE);
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                SumCorrections := 0;

                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Vendor Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
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
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        Caption = 'Show Amounts in LCY';
                    }
                    field(NewPageperVendor; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Vendor';
                    }
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Vendors That Have A Balance Only';
                        MultiLine = true;
                    }
                    field(ShowAll; ShowAll)
                    {
                        Caption = 'Show All';
                        trigger OnValidate()
                        begin
                            HandleAll();
                        end;
                        //OptionCaption = 'Show Prepayment';
                    }
                    field(ShowPrepayment; ShowPrepayment)
                    {
                        Caption = 'Show Prepayment';
                        trigger OnValidate()
                        begin
                            HandlePrepayment();
                        end;
                        //OptionCaption = 'Show Prepayment';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        VendFilter := Vendor.GETFILTERS;
        VendDateFilter := Vendor.GETFILTER("Date Filter");

        WITH "Vendor Ledger Entry" DO
            IF PrintAmountsInLCY THEN BEGIN
                AmountCaption := FIELDCAPTION("Amount (LCY)");
                RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
            END ELSE BEGIN
                AmountCaption := FIELDCAPTION(Amount);
                RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
            END;
    end;


    var
        IDOd: Integer;
        ShowAll: Boolean;
        Text000: Label 'Period: %1';
        VendorLedgerEntry: Record 25;
        VendFilter: Text;
        VendDateFilter: Text[30];
        VendAmount: Decimal;
        VendRemainAmount: Decimal;
        VendBalanceLCY: Decimal;
        VendEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        ExcludeBalanceOnly: Boolean;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        VendLedgEntryExists: Boolean;
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        VendCurrencyCode: Code[10];
        PageGroupNo: Integer;
        SumCorrections: Decimal;
        ShowPrepayment: Boolean;
        VendDetailTrialBalCapLbl: Label 'Vendor - Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        AllamountsareinLCYCaptionLbl: Label 'All amounts are in LCY.';
        ReportIncludesvendorshavebalanceCaptionLbl: Label 'This report also includes vendors that only have balances.';
        PostingDateCaptionLbl: Label 'Posting Date';
        BalanceLCYCaptionLbl: Label 'Balance (LCY)';
        DueDateCaptionLbl: Label 'Due Date';
        VendorOrderCaption: Label 'Vendor Order No.';
        PorezniOdDate: Date;
        WorkType: Record "Types Of Diseases";
        jci: Decimal;
        Amountr: Decimal;
        Redni: Integer;
        PorezniPeriod: Text;
        PorezniPeriod2: Text;
        i: Integer;
        passed: Boolean;
        DocNo: Code[30];
        Redni_ISPIS: Integer;

        AdjofOpeningBalanceCaptionLbl: Label 'Adj. of Opening Balance';
        TotalLCYCaptionLbl: Label 'Total (LCY)';
        TotalAdjofOpenBalCaptionLbl: Label 'Total Adj. of Opening Balance';
        TotalLCYBeforePeriodCaptionLbl: Label 'Total (LCY) Before Period';
        VenLedgEntry: Record "Vendor Ledger Entry";
        CompInfo: Record "Company Information";

    procedure InitializeRequest(NewPrintAmountsInLCY: Boolean; NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean)
    begin
        PrintAmountsInLCY := NewPrintAmountsInLCY;
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
    end;

    procedure HandleAll()
    var
    begin
        IF ShowAll = true THEN
            ShowPrepayment := FALSE;
    end;

    procedure HandlePrepayment()
    var
    begin
        IF ShowPrepayment = true THEN
            ShowAll := FALSE;
    end;
}

