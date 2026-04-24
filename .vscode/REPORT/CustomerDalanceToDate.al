report 50137 "CustomerBalancetoDate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerBalancetoDate.rdl';
    Caption = 'Kupac - saldo na dan';
    PreviewMode = PrintLayout;
    ApplicationArea = basic, suite;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked, "Date Filter";
            column(CompanyName; COMPANYNAME)
            {
            }

            column(VATRegistrationNo_Customer; Customer."VAT Registration No.")
            {
            }
            column(Customer_GETRANGEMAXDateFilter; FORMAT(Customer.GETRANGEMAX("Date Filter")))
            {
            }
            column(Redni; Redni_ISPIS) { }
            column(RegistrationNo_Customer; Customer."Registration No.")
            {
            }
            column(Customer_TABLECAPTION; Customer.TABLECAPTION)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(CustLedgEntry3_TABLECAPTION; "Cust. Ledger Entry".TABLECAPTION)
            {
            }
            column(CustLedgFilter; CustLedgFilter)
            {
            }
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(PhoneNo_Customer; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TxtCustGeTranmaxDtFilter; STRSUBSTNO(Text000, FORMAT(GETRANGEMAX("Date Filter"))))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(PrintOnePrPage; PrintOnePrPage)
            {
            }
            column(Name; CompInfo.Name)
            {
            }
            column(Addres; CompInfo.Address)
            {
            }
            column(PhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoFaxNo; CompInfo."Fax No.")
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(CompInfoCounty; CompInfo.County)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(CustTableCaptCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(Address_Customer; Address)
            {
            }
            column(City_Customer; City)
            {
            }
            column(PostCode_Customer; "Post Code")
            {
            }
            column(TodayFormatted; FORMAT(MaxDate, 0, 4))
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllamtsareinLCYCaption; AllamtsareinLCYCaptionLbl)
            {
            }
            column(CustLedgEntryPostingDtCaption; CustLedgEntryPostingDtCaptionLbl)
            {
            }
            column(OriginalAmtCaption; OriginalAmtCaptionLbl)
            {
            }
            column(DebitAmtCaption; DebitAmtCaptionLbl)
            {
            }
            column(CreditAmtCaption; CreditAmtCaptionLbl)
            {
            }
            column(RegistrationNo; CompInfo."Registration No.")
            {
            }
            column(VATRegNo; CompInfo."VAT Registration No.")
            {
            }
            column(Company_Email; CompInfo."E-Mail")
            {
            }
            column(CustBalancetoDateCaption; CustBalancetoDateCaptionLbl)
            {
            }
            column(Country; CountryT)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Open", "Due Date")
                                    ORDER(Ascending);
                RequestFilterFields = "Document Type", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code";
                column(EntryNo_CustLedgEntry3; "Entry No.")
                {
                }
                column(KUF_Entry; KUF_Entry)
                {

                }
                column(PostingDate_CustLedgEntry3; FORMAT("Posting Date"))
                {
                }
                column(DocumentType_CustLedgEntry3; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo_CustLedgEntry3; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(DocumentDate_CustLedgEntry3; FORMAT("Document Date"))
                {
                }
                column(ExternalDocumentNo_CustLedgEntry3; "External Document No.")
                {
                    IncludeCaption = true;
                }
                column(DueDate_CustLedgEntry3; FORMAT("Due Date"))
                {
                }
                column(Description_CustLedgEntry3; Description)
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
                column(CustomerPostingGroup_CustLedgEntry3; "Customer Posting Group")
                {
                    IncludeCaption = true;
                }
                column(CustBalance; CustBalance)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No."),
                                   "Posting Date" = FIELD("Date Filter");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(<> "Initial Entry"));
                    column(PostingDate_DetailedCustLedgEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(DocumentType_DetailedCustLedgEntry; "Document Type")
                    {
                    }
                    column(DocumentNo_DetailedCustLedgEntry; "Document No.")
                    {
                    }
                    column(EntryType_DetailedCustLedgEntry; "Entry Type")
                    {
                    }
                    column(Amt; Amt)
                    {
                    }
                    column(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT PrintUnappliedEntries THEN
                            IF Unapplied THEN
                                CurrReport.SKIP;

                        IF PrintAmountInLCY THEN BEGIN
                            Amt := "Amount (LCY)";
                            CurrencyCode := '';
                        END ELSE BEGIN
                            Amt := Amount;
                            CurrencyCode := "Currency Code";
                        END;
                        IF Amt = 0 THEN
                            CurrReport.SKIP;

                        DtldCustLedgEntryNum := DtldCustLedgEntryNum + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //BSL1.00 START
                        CurrReport.BREAK;
                        //BSL1.00 END

                        DtldCustLedgEntryNum := 0;
                    end;
                }
                dataitem(Integer2; integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(PostingDate_CustLedgEntryTmp; FORMAT(CustLedgEntryTmp."Posting Date"))
                    {
                    }
                    column(DocumentType_CustLedgEntryTmp; FORMAT(CustLedgEntryTmp."Document Type", 0, '<Text>'))
                    {
                    }
                    column(DocumentNo_CustLedgEntryTmp; CustLedgEntryTmp."Document No.")
                    {
                    }
                    column(DocumentDate_CustLedgEntryTmp; FORMAT(CustLedgEntryTmp."Document Date"))
                    {
                    }
                    column(ExternalDocumentNo_CustLedgEntryTmp; CustLedgEntryTmp."External Document No.")
                    {
                    }
                    column(DueDate_CustLedgEntryTmp; FORMAT(CustLedgEntryTmp."Due Date"))
                    {
                    }
                    column(Description_CustLedgEntryTmp; CustLedgEntryTmp.Description)
                    {
                    }
                    column(Amt_CustLedgEntryTmp; Amt)
                    {
                    }
                    column(ShowClosing; ShowClosing)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //BSL1.00 START
                        IF Number = 1 THEN CustLedgEntryTmp.FIND('-') ELSE CustLedgEntryTmp.NEXT;

                        CustLedgEntryTmp.CALCFIELDS(Amount, "Amount (LCY)");

                        IF PrintAmountInLCY THEN BEGIN
                            Amt := CustLedgEntryTmp."Amount (LCY)";
                            CurrencyCode := '';
                        END ELSE BEGIN
                            Amt := CustLedgEntryTmp.Amount;
                            CurrencyCode := CustLedgEntryTmp."Currency Code";
                        END;
                        //BSL1.00 END
                    end;

                    trigger OnPreDataItem()
                    begin
                        //BSL1.00 START
                        IF CustLedgEntryTmp.COUNT = 0 THEN CurrReport.BREAK;
                        SETRANGE(Number, 1, CustLedgEntryTmp.COUNT);
                        //BSL1.00 END
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    OriginalNumberString: Text;
                    FormattedNumberString: Text;
                begin
                    CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                    IF PrintAmountInLCY THEN BEGIN
                        OriginalAmt := "Original Amt. (LCY)";
                        RemainingAmt := "Remaining Amt. (LCY)";
                        CurrencyCode := '';
                        CustBalance := CustBalance + "Remaining Amt. (LCY)";
                    END ELSE BEGIN
                        CALCFIELDS("Original Amount", "Remaining Amount");
                        OriginalAmt := "Original Amount";
                        RemainingAmt := "Remaining Amount";
                        CurrencyCode := "Currency Code";
                        CustBalance := CustBalance + "Remaining Amount";
                    END;

                    //BSL1.00 START
                    CurrencyTotalBuffer.UpdateTotal(CurrencyCode, RemainingAmt, "Remaining Amt. (LCY)", Counter1);

                    CustLedgEntryTmp.RESET;
                    IF ShowClosing THEN BEGIN
                        CustLedgEntryTmp.DELETEALL;
                        FindApplnEntriesDtldtLedgEntry("Cust. Ledger Entry");
                    END;

                    //BSL1.00 END
                    if GenerateTXTFile and (RemainingAmt <> 0) then begin
                        OriginalNumberString := Format(RemainingAmt);
                        FormattedNumberString := ReplaceStringAndFormatDecimal(OriginalNumberString);

                        DetailRowNumber += 1;
                        TXTFileDetailTotal += RemainingAmt;
                        CustomerDetailString := '';
                        CustomerDetailString += 'D1';
                        CustomerDetailString += DelimiterCharacter;
                        CustomerDetailString += Format(DetailRowNumber);
                        CustomerDetailString += DelimiterCharacter;
                        CustomerDetailString += Format("Document Date") + ' - ' + "Document No.";
                        CustomerDetailString += DelimiterCharacter;
                        CustomerDetailString += FormattedNumberString;
                        CustomerDetailString += DelimiterCharacter;
                        OutStr.WriteText(CustomerDetailString);
                        OutStr.WriteText();

                    end;
                end;

                trigger OnPostDataItem()
                var
                    OriginalNumberString: Text;
                    FormattedNumberString: Text;
                begin
                    if GenerateTXTFile then begin
                        OriginalNumberString := Format(TXTFileDetailTotal);
                        FormattedNumberString := ReplaceStringAndFormatDecimal(OriginalNumberString);
                        CustomerDetailString := 'D1';
                        CustomerDetailString += DelimiterCharacter;
                        CustomerDetailString += Format(DetailRowNumber + 1);
                        CustomerDetailString += DelimiterCharacter;
                        CustomerDetailString += 'Saldo po računima za prirodni gas: (dugovanje)';
                        CustomerDetailString += DelimiterCharacter;
                        CustomerDetailString += FormattedNumberString;
                        CustomerDetailString += DelimiterCharacter;

                        OutStr.WriteText(CustomerDetailString);
                        OutStr.WriteText();
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    RESET;

                    //for column customer balance
                    CustBalance := 0;

                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type");
                    DtldCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                    DtldCustLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', MaxDate), 99991231D);
                    //BSL1.00 START
                    DtldCustLedgEntry.SETFILTER("Entry Type", '%1|%2|%3',
                      DtldCustLedgEntry."Entry Type"::"Unrealized Loss",
                      DtldCustLedgEntry."Entry Type"::"Unrealized Gain",
                      DtldCustLedgEntry."Entry Type"::Application);

                    //IF PostingGroupFilter <> '' THEN DtldCustLedgEntry.SETFILTER("Customer Posting Group",PostingGroupFilter);
                    IF CurrencyFilter <> '' THEN DtldCustLedgEntry.SETFILTER("Currency Code", CurrencyFilter);
                    //BSL1.00 END

                    IF NOT PrintUnappliedEntries THEN DtldCustLedgEntry.SETRANGE(Unapplied, FALSE);

                    IF DtldCustLedgEntry.FIND('-') THEN
                        REPEAT
                            "Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                            MARK(TRUE);
                        UNTIL DtldCustLedgEntry.NEXT = 0;

                    IF OtvoreneStavke THEN BEGIN
                        SETCURRENTKEY("Customer No.", Open);
                        SETRANGE(Open, TRUE);
                    END;
                    //SETCURRENTKEY("Customer No.",Open);
                    SETRANGE("Customer No.", Customer."No.");
                    //SETRANGE(Open,TRUE);
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
                    IF OtvoreneStavke THEN SETRANGE(Open);

                    //SETRANGE(Open);
                    MARKEDONLY(TRUE);
                    SETRANGE("Date Filter", 0D, MaxDate);

                    //BSL1.00 START
                    IF PostingGroupFilter <> '' THEN SETFILTER("Customer Posting Group", PostingGroupFilter);
                    IF GDim1Filter <> '' THEN SETFILTER("Global Dimension 1 Code", GDim1Filter);
                    IF GDim2Filter <> '' THEN SETFILTER("Global Dimension 2 Code", GDim2Filter);
                    SETFILTER("Document Type", DocTypeFilter);
                    //BSL1.00 END
                    DetailRowNumber := 0;
                    TXTFileDetailTotal := 0;
                end;
            }
            dataitem(Integer1; integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(CurrencyCode_CurrencyTotalBuffer; CurrencyTotalBuffer."Currency Code")
                {
                }
                column(TotalAmount_CurrencyTotalBuffer; CurrencyTotalBuffer."Total Amount")
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
                Redni_ISPIS := Redni;

                Redni := Redni + 1;

                //  if Redni=1 then 
                //Redni_ISPIS:= 

                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);
                cr.RESET;
                IF cr.GET(CompInfo."Country/Region Code") THEN
                    CountryT := cr."Name 2"
                ELSE
                    CountryT := '';
                //BSL1.00 START
                IF PrintOnePrPage THEN BEGIN
                    IF CustCode <> "No." THEN BEGIN
                        PageGroupNo := PageGroupNo + 1;
                        CustCode := "No."
                    END;
                END;
                //BSL1.00 END
                MaxDate := GETRANGEMAX("Date Filter");
                SETRANGE("Date Filter", 0D, MaxDate);
                CALCFIELDS("Net Change (LCY)", "Net Change");

                IF SkipWithoutNetChange THEN  //BSL1.00
                    IF ((PrintAmountInLCY AND (Customer."Net Change (LCY)" = 0)) OR ((NOT PrintAmountInLCY) AND (Customer."Net Change" = 0))) THEN
                        CurrReport.SKIP;


                //BSL1.00 START
                CustLedgEntry.RESET;
                //CustLedgEntry.SETCURRENTKEY("Customer No.",Open);
                CustLedgEntry.SETRANGE("Customer No.", "No.");
                CustLedgEntry.SETRANGE("Date Filter", 0D, MaxDate);
                //CustLedgEntry.SETFILTER("Remaining Amount",'<>%1',0);
                IF PostingGroupFilter <> '' THEN CustLedgEntry.SETFILTER("Customer Posting Group", PostingGroupFilter);
                IF PaymentMethodFilter <> '' THEN CustLedgEntry.SETFILTER("Payment Method Code", PaymentMethodFilter);
                //IF NOT CustLedgEntry.FIND('-') THEN CurrReport.SKIP;
                //BSL1.00 END
                IF OtvoreneStavke THEN BEGIN
                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open);
                    CustLedgEntry.SETFILTER("Remaining Amount", '<>%1', 0);
                    IF NOT CustLedgEntry.FIND('-') THEN CurrReport.SKIP;
                END;

                if GenerateTXTFile then begin
                    CustomerHeaderString := '';
                    CustomerHeaderString += 'H1';
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += Name;
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += Address + ' ' + City;
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += "Address 2";
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += "Post Code" + ' ' + City;
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += ClassificationDesignation;
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += Format(MaxDate);
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += 'Prema našim poslovnim knjigama na dan ' + Format(MaxDate) + ', Vaše stanje čine sljedeće otvorene stavke:';
                    CustomerHeaderString += DelimiterCharacter;
                    CustomerHeaderString += "No.";
                    CustomerHeaderString += DelimiterCharacter;

                    OutStr.WriteText(CustomerHeaderString);
                    OutStr.WriteText();
                end;
            end;

            trigger OnPreDataItem()
            begin
                //BSL1.00 START
                //IF PostingGroupFilter <> '' THEN SETFILTER("Posting Group Filter",PostingGroupFilter);
                PageGroupNo := 1;
                //BSL 1.00 END


            end;
        }
        dataitem(Integer; integer)
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
                IF NOT OK THEN
                    CurrReport.BREAK;
            end;

            trigger OnPostDataItem()
            begin
                CurrencyTotalBuffer2.DELETEALL;
            end;

            trigger OnPreDataItem()
            begin
                CurrencyTotalBuffer2.SETFILTER("Total Amount", '<>0');

                CurrReport.CREATETOTALS(CurrencyTotalBuffer2."Total Amount (LCY)");
            end;
        }
        dataitem("Extended Text Line"; "Extended Text Line")
        {
            DataItemTableView = SORTING("Table Name", "No.", "Language Code", "Text No.", "Line No.");
            column(Text_ExtendedTextLine; "Extended Text Line".Text)
            {
            }
            column(PrintComision; PrintComision)
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
                        Caption = 'New Page per Customer';
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
                        Visible = true;
                    }
                    field(StandTextCode; StandTextCode)
                    {
                        Caption = 'Standard Text Code';
                        Editable = PrintComision OR (NOT SortByDueDate);
                    }
                    field(CustPostGroupFilter; CustPostGroupFilter)
                    {
                        Caption = 'Print for G/L Account';
                        Visible = false;
                    }
                    field(SkipWithoutNetChange; SkipWithoutNetChange)
                    {
                        Caption = 'Skip Customers W/O Balance';
                    }
                    field(SortByDueDate; SortByDueDate)
                    {
                        Caption = 'Sort by due date';
                        Editable = false;
                        Visible = true;
                    }
                    field(GenerateTXTFile; GenerateTXTFile)
                    {
                        Caption = 'Generate TXT file';
                    }

                    field(ClassificationDesignation; ClassificationDesignation)
                    {
                        Caption = 'Classification designation';
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
        LblReportTitle = 'Customer - Balance to Date';
        LblPage = 'Page';
        LblBalanceOn = 'Balance on';
        LblAllAmountsAreInLCY = 'All amounts are in LCY.';
        LblCustomer = 'Customer';
        LblPostingDate = 'Posting Date';
        LblDocumentDate = 'Document Date';
        LblDueDate = 'Due Date';
        LblAmount = 'Amount';
        LblRemainingAmount = 'Remaining Amount';
        LblTotal = 'Total';
        LblLCY = 'LCY';
        LblRegistrationNo = 'Registration Number';
        LblVATRegistrationNo = 'VAT Registration Number';
        LblCustBalance = 'Customer balance';
    }

    trigger OnInitReport()
    begin

        SortByDueDate := TRUE;
        OtvoreneStavke := FALSE;
    end;

    trigger OnPostReport()
    begin

        cr.RESET;
        IF cr.GET(CompInfo."Country/Region Code") THEN
            CountryT := cr."Name 2"
        ELSE
            CountryT := '';

        //Generate TXT file:
        if GenerateTXTFile then begin
            TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
            DownloadFromStream(Instr, '', '', '', TxtFileName);
        end;
    end;

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        CustDateFilter := Customer.GETFILTER("Date Filter");
        //BSL1.00 START
        CustLedgFilter := "Cust. Ledger Entry".GETFILTERS;
        CustDateFilter := Customer.GETFILTER("Date Filter");
        CurrencyFilter := "Cust. Ledger Entry".GETFILTER("Currency Code");
        IF PrintComision THEN BEGIN
            IF CustPostGroupFilter = '' THEN ERROR(Text001);
            ReportText := Text003;
        END ELSE
            ReportText := Text002;

        DocTypeFilter := '';
        IF GLAccount.GET(CustPostGroupFilter) THEN;
        //IF Customer.GETFILTER("Posting Group Filter")<>'' THEN PostingGroupFilter:=Customer.GETFILTER("Posting Group Filter");
        IF "Cust. Ledger Entry".GETFILTER("Global Dimension 1 Code") <> '' THEN GDim1Filter := "Cust. Ledger Entry".GETFILTER("Global Dimension 1 Code");
        IF "Cust. Ledger Entry".GETFILTER("Global Dimension 2 Code") <> '' THEN GDim2Filter := "Cust. Ledger Entry".GETFILTER("Global Dimension 2 Code");
        IF "Cust. Ledger Entry".GETFILTER("Payment Method Code") <> '' THEN PaymentMethodFilter := "Cust. Ledger Entry".GETFILTER("Payment Method Code");
        IF "Cust. Ledger Entry".GETFILTER("Document Type") <> '' THEN DocTypeFilter := "Cust. Ledger Entry".GETFILTER("Document Type");
        //BSL1.00 END
        SortByDueDate := TRUE;
        OtvoreneStavke := FALSE;

        //Generate TXT File:
        if GenerateTXTFile then begin
            if ClassificationDesignation = '' then
                Error(ClassificationDesignationErrorMsg);

            case Customer.GetFilter("Customer Category") of
                'Domaćinstva':
                    begin
                        CustomerCategory := 'DOM'
                    end;
                'Velika privreda':
                    begin
                        CustomerCategory := 'VP'
                    end;
                'Mala privreda':
                    begin
                        CustomerCategory := 'MP'
                    end;
                'KJKP Toplane':
                    begin
                        CustomerCategory := 'KJKP'
                    end;
                'Poseban kupac':
                    begin
                        CustomerCategory := 'Poseban'
                    end;
                'CNG punionie':
                    begin
                        CustomerCategory := 'CNG'
                    end;
                else begin
                    CustomerCategory := 'NN'
                end;
            end;

            FilteredDate := Customer.GETRANGEMAX("Date Filter");
            FileNameMonth := FORMAT(FilteredDate, 0, '<month,2>');
            FileNameYearProcess := FORMAT(FilteredDate, 0, '<year4>');
            FileNameYear := CopyStr(FileNameYearProcess, 3, 2);

            DelimiterCharacter := ';';

            TxtFileName := 'GAS_' + CustomerCategory + '_IOS' + FileNameMonth + FileNameYear + '_F.txt';
            TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
            CustomerHeaderString := '';
            CustomerDetailString := '';
            DetailRowNumber := 0;
            TXTFileDetailTotal := 0;
        end;
    end;


    var
        OtvoreneStavke: Boolean;
        cr: Record 9;
        CountryT: Text;
        CurrencyTotalBuffer: Record 332 temporary;
        CustLedgEntry: Record 21;
        DtldCustLedgEntry: Record 379;
        GLAccount: Record 15;
        CustLedgEntryTmp: Record 21 temporary;
        CurrencyTotalBuffer2: Record 332 temporary;
        GLSetUp: Record 98;
        CustFilter: Text[250];
        CustDateFilter: Text[30];
        CustLedgFilter: Text[250];
        CurrencyFilter: Text[30];
        ReportText: Text[100];
        PostingGroupFilter: Text[50];
        DocTypeFilter: Text[100];
        GDim1Filter: Text[30];
        GDim2Filter: Text[30];
        PaymentMethodFilter: Text[100];
        CurrencyCode: Code[10];
        StandTextCode: Code[10];
        IDOd: Integer;
        Redni_ISPIS: Integer;
        PorezniOdDate: Date;
        WorkType: Record "Types Of Diseases";
        jci: Decimal;
        Amountr: Decimal;
        Redni: Integer;
        PorezniPeriod: Text;
        PorezniPeriod2: Text;
        CustPostGroupFilter: Code[10];
        PrintComision: Boolean;
        Text001: Label 'Customer Posting Group Filter must be selected!';
        Text002: Label 'Customer - Balance to Date';
        Text003: Label 'Inventory - Customer Opened Entries';
        PrintUnappliedEntries: Boolean;
        SortByDueDate: Boolean;
        PrintOnePrPage: Boolean;
        PrintAmountInLCY: Boolean;
        OK: Boolean;
        ShowClosing: Boolean;
        SkipWithoutNetChange: Boolean;
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        Counter1: Integer;
        DtldCustLedgEntryNum: Integer;
        PageGroupNo: Integer;
        CustCode: Code[20];
        CompInfo: Record 79;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        Text000: Label 'Balance on %1';
        CustBalancetoDateCaptionLbl: Label 'Customer - Balance to Date';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AllamtsareinLCYCaptionLbl: Label 'All amounts are in LCY.';
        CustLedgEntryPostingDtCaptionLbl: Label 'Posting Date';
        OriginalAmtCaptionLbl: Label 'Amount';
        TotalCaptionLbl: Label 'Total';
        DebitAmtCaptionLbl: Label 'Debit Amount';
        CreditAmtCaptionLbl: Label 'Credit Amount';
        BlankMaxDateErr: Label 'Ending Date must have a value.';
        CustBalance: Decimal;
        GenerateTXTFile: Boolean;
        DelimiterCharacter: Char;
        TxtFileName: Text;
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        CustomerHeaderString: Text;
        CustomerDetailString: Text;
        CustomerCategory: Text;
        DetailRowNumber: Integer;
        FilteredDate: Date;
        FileNameMonth, FileNameYear, FileNameYearProcess : Text;
        TXTFileDetailTotal: Decimal;
        ClassificationDesignation: Text;
        ClassificationDesignationErrorMsg: Label 'In order to generate the TXT file, you must enter the classification designation.';

    procedure ReplaceStringAndFormatDecimal(InputString: Text) ResultString: Text
    var
        LastCommaPos: Integer;
        TempString: Text;
        i: Integer;
    begin
        // Step 1: Replace periods with a temporary character
        TempString := Replacestring_T(InputString, '.', '_');

        // Step 2: Find and replace the last comma with a period
        LastCommaPos := 0;
        for i := 1 to StrLen(TempString) do
            if CopyStr(TempString, i, 1) = ',' then
                LastCommaPos := i;

        if LastCommaPos > 0 then
            TempString := CopyStr(TempString, 1, LastCommaPos - 1) + '.' + CopyStr(TempString, LastCommaPos + 1);

        // Step 3: Replace remaining commas with periods
        while StrPos(TempString, ',') > 0 do
            TempString := Replacestring_T(TempString, ',', '.');

        // Step 4: Replace temporary characters back with commas
        while StrPos(TempString, '_') > 0 do
            TempString := Replacestring_T(TempString, '_', ',');

        ResultString := TempString;
    end;


    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure FindApplnEntriesDtldtLedgEntry(InputCustLedgEntry: Record 21)
    var
        DtldCustLedgEntry1: Record 379;
        DtldCustLedgEntry2: Record 379;
        CustLedgEntry: Record 21;
    begin
        DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", InputCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldCustLedgEntry1.FIND('-') THEN
            REPEAT
                IF DtldCustLedgEntry1."Cust. Ledger Entry No." = DtldCustLedgEntry1."Applied Cust. Ledger Entry No." THEN BEGIN
                    DtldCustLedgEntry2.INIT;
                    DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SETRANGE("Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldCustLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldCustLedgEntry2."Cust. Ledger Entry No." <> DtldCustLedgEntry2."Applied Cust. Ledger Entry No." THEN BEGIN
                                CustLedgEntry.SETCURRENTKEY("Entry No.");
                                CustLedgEntry.SETRANGE("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                IF CustLedgEntry.FIND('-') THEN BEGIN
                                    CustLedgEntryTmp.INIT;
                                    CustLedgEntryTmp := CustLedgEntry;
                                    CustLedgEntryTmp.INSERT;
                                END;
                            END;
                        UNTIL DtldCustLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    CustLedgEntry.SETCURRENTKEY("Entry No.");
                    CustLedgEntry.SETRANGE("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    IF CustLedgEntry.FIND('-') THEN BEGIN
                        CustLedgEntry.CALCFIELDS(Amount, "Amount (LCY)");
                        CustLedgEntryTmp.INIT;
                        CustLedgEntryTmp := CustLedgEntry;
                        CustLedgEntryTmp.INSERT;
                    END;
                END;
            UNTIL DtldCustLedgEntry1.NEXT = 0;
    end;
}

