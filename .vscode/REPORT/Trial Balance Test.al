report 50132 "Trial Balance Test"
{
    // BH1.00, Debit/Credit
    DefaultLayout = RDLC;
    AdditionalSearchTerms = 'year closing,close accounting period,close fiscal year';
    ApplicationArea = Basic, Suite;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;
    RDLCLayout = './TrialBalanceTest.rdl';
    Caption = 'Trial Balance';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(Net_ChangeBalanceCaption; Net_ChangeBalanceCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FIELDCAPTION("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(DebitLblCaption; DebitLbl)
            {
            }
            column(CreditLblCaption; CreditLbl)
            {
            }
            column(StartDateCaption; STRSUBSTNO(DateLbl, FORMAT(StartDate)))
            {
            }
            column(FromEndDateCaption; STRSUBSTNO('%1..%2', FORMAT(StartDate), FORMAT(EndDate)))
            {
            }
            column(EndDateCaption; STRSUBSTNO(DateLbl, FORMAT(EndDate)))
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; FORMAT("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(StartBalanceD; StartBalance)
                {
                }
                column(StartBalanceC; -StartBalance)
                {
                }
                column(DebitAmount; DebitAmount)
                {
                }
                column(CreditAmount; CreditAmount)
                {
                }
                column(NetChangeD; NetChange)
                {
                }
                column(NetChangeC; -NetChange)
                {
                }
                column(ShowEUR; ShowEUR)
                {
                }
                column(FilterDate; FilterDate)
                {



                }
                column(ExchangeRate; ExchangeRate)
                {
                }
                dataitem(BlankLineRepeater; Integer)
                {
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF BlankLineNo = 0 THEN
                            CurrReport.BREAK;

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                year: Integer;

            begin


                year := Date2DMY(FromDate, 3);
                if FilterDate = true then begin
                    StartDate := DMY2DATE(1, 1, year)
                end
                else
                    if FilterDate = false then begin
                        StartDate := FromDate;
                    end;


                //+BH1.00
                CALCFIELDS("Balance at Date");

                GLAccount.GET("No.");
                GLAccount.SETRANGE("Date Filter", 0D, CLOSINGDATE(StartDate));
                GLAccount.CALCFIELDS("Balance at Date");
                StartBalance := GLAccount."Balance at Date";

                GLAccount.SETRANGE("Date Filter", StartDate, EndDate);
                GLAccount.CALCFIELDS("Debit Amount");
                GLAccount.CALCFIELDS("Credit Amount");
                DebitAmount := GLAccount."Debit Amount";
                CreditAmount := GLAccount."Credit Amount";
                NetChange := "Balance at Date" - StartBalance;
                IF SkipAccounts AND (DebitAmount = 0) AND (CreditAmount = 0) AND ("Balance at Date" = 0) THEN
                    CurrReport.SKIP;
                //-BH1.00



                IF ChangeGroupNo THEN BEGIN
                    PageGroupNo += 1;
                    ChangeGroupNo := FALSE;
                END;

                ChangeGroupNo := "New Page";
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := FALSE;

                SETFILTER("No.", '<>%1', 'VB');


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
                    field(SkipAccounts; SkipAccounts)
                    {
                        Caption = 'Skip Account without Net Change';
                    }

                    field(FilterDate; FilterDate)
                    {
                        Caption = 'Filter Date';
                    }
                }
            }
        }

        actions
        {
        }
        trigger OnInit()
        begin
            FilterDate := TRUE;
        end;
    }

    labels
    {
    }



    trigger OnPreReport()
    begin


        "G/L Account".SecurityFiltering(SecurityFilter::Filtered);


        GLFilter := "G/L Account".GETFILTERS;
        PeriodText := "G/L Account".GETFILTER("Date Filter");


        //+BH1.00

        FromDate := "G/L Account".GETRANGEMIN("Date Filter");
        test := Date2DMY(FromDate, 3);
        if FilterDate = true then begin
            StartDate := DMY2DATE(1, 1, test)
        end
        else
            if FilterDate = false then begin
                StartDate := FromDate;
            end;

        //  StartDate := CALCDATE('<-1D>', FromDate);
        EndDate := "G/L Account".GETRANGEMAX("Date Filter");
        PeriodText := Format(StartDate) + ' - ' + Format(EndDate);
        //-BH1.00
        "G/L Account".SETFILTER("No.", '<>%1', 'VB');
        CER.RESET;
        CER.SETFILTER("Currency Code", '%1', 'EUR');
        CER.SETFILTER("Starting Date", '%1', EndDate);
        IF CER.FINDFIRST THEN BEGIN
            ExchangeRate := CER."Relational Exch. Rate Amount";
        END
        ELSE BEGIN
            CER2.RESET;
            CER2.SETFILTER("Currency Code", '%1', 'EUR');
            CER2.SETCURRENTKEY("Starting Date");
            IF CER2.FINDLAST THEN BEGIN
                ExchangeRate := CER2."Relational Exch. Rate Amount";
            END;
        END;
    end;

    var
        Text000: Label 'Period: %1';
        GLAccount: Record 15;
        ExcelBuf: Record 370 temporary;
        GLFilter: Text;
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text001: Label 'Trial Balance';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        StartingBalanceCaptionLbl: Label 'Balance';
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Net Change';
        Net_ChangeBalanceCaptionLbl: Label 'Net Change Balance';
        BalanceCaptionLbl: Label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        StartBalance: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        NetChange: Decimal;
        FromDate: Date;
        StartDate: Date;
        EndDate: Date;
        SkipAccounts: Boolean;
        DebitLbl: Label 'Debit';
        CreditLbl: Label 'Credit';
        DateLbl: Label 'on %1';
        CER: Record 330;
        CER2: Record 330;
        ExchangeRate: Decimal;
        ShowEUR: Boolean;
        FilterDate: Boolean;
        test: Integer;


}

