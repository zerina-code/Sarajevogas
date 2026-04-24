report 50135 "Daily Billing By Centers"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Daily Billing By Centers';
    DefaultLayout = RDLC;
    RDLCLayout = './Daily Billing By Centers.rdl';

    dataset
    {
        dataitem(GenJournalBatch; "Gen. Journal Batch")
        {
            DataItemTableView = SORTING(Name)
                                ORDER(ascending)
                                WHERE("Bal. Account No." = filter('*CZK*|*cng*'));
            RequestFilterFields = "Bal. Account Type", "Bal. Account No.", Name;

            column(Name; Name) { }
            column(Bal__Account_Type; "Bal. Account Type") { }
            column(Bal__Account_No_; "Bal. Account No.") { }
            column(Description; Description) { }
            column(Picture; CompInfo.Picture) { }
            column(CountOfPaymentsGAS; CountOfPaymentsGAS) { }
            column(CountOfPaymentsRES; CountOfPaymentsRES) { }
            column(FromPostingDateFilter; FORMAT(FromPostingDateFilter, 0, '<Day,2>.<Month,2>.<Year4>.')) { }
            column(ToPostingDateFilter; FORMAT(ToPostingDateFilter, 0, '<Day,2>.<Month,2>.<Year4>.')) { }
            column(Bills01; Bills01) { }
            column(Bills02; Bills02) { }
            column(Bills03; Bills03) { }
            column(Bills123Total; Bills123Total) { }
            column(TotalTotal; TotalTotal) { }
            column(BillsRes; BillsRes) { }
            column(PologPazara; PologPazara) { }
            column(Template_Type; "Template Type") { }
            column(MainCashier; MainCashier) { }
            column(OJ; OJ) { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                CompInfo.CalcFields(Picture);
                PologPazara := 0;
                GLS.Get();
                CashReceiptJnlTmpl := GLS."Cash Receipt Journal Template";  //PAYMENTS - temeljnica uplata za CNG
                CashBatchName := GLS."Cash Batch Name";                     //CNG - Serija za temeljnicu uplata

                //Preskoči stavke gdje je na korespondirajućem bankovnom računu isključena opcija 'Prikazati na blagajničkom dnevniku'
                BankAccount.Reset();
                BankAccount.SetFilter("No.", '%1', GenJournalBatch."Bal. Account No.");
                BankAccount.SetFilter(Showondocument, '%1', true);
                if not BankAccount.FindFirst() then begin
                    CurrReport.Skip();
                end;
            end;

            trigger OnAfterGetRecord()
            var
                BillTypes: Record "Customer Templ.";
                GenEnum: Enum "Gen. Journal Document Type";
                IncludeInPologPazara: Boolean;
            begin
                CountOfPaymentsGAS := 0;
                CountOfPaymentsRES := 0;
                Bills01 := 0;
                Bills02 := 0;
                Bills03 := 0;
                BillsCNG := 0;
                Bills123Total := 0;
                TotalTotal := 0;
                BillsRes := 0;
                IncludeInPologPazara := true;

                GLE.Reset();
                GLE.SetFilter("Journal Batch Name", '%1', GenJournalBatch.Name);
                GLE.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");
                GLE.SetFilter("Document Type", '%1', GenEnum::Payment);
                GLE.SetFilter("Posting Date", '%1..%2', FromPostingDateFilter, ToPostingDateFilter);
                GLE.SetFilter("Bill type", VrsteRacunaGAS);
                if GLE.FindFirst() then begin
                    CountOfPaymentsGAS := GLE.Count;
                    if GLE."Bill type" = '01' then begin
                        GLE.CalcSums(Amount);
                        Bills01 := GLE.Amount;
                    end;

                    if GLE."Bill type" = '02' then begin
                        GLE.CalcSums(Amount);
                        Bills02 := GLE.Amount;
                    end;

                    if GLE."Bill type" = '03' then begin
                        GLE.CalcSums(Amount);
                        Bills03 := GLE.Amount;
                    end;
                end;

                GLE.Reset();
                GLE.SetFilter("Journal Batch Name", '%1', GenJournalBatch.Name);
                GLE.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");
                GLE.SetFilter("Document Type", '%1', GenEnum::Payment);
                GLE.SetRange("Posting Date", FromPostingDateFilter, ToPostingDateFilter);
                GLE.SetFilter("Bill type", VrsteRacunaUsluge);
                if GLE.FindFirst() then begin
                    CountOfPaymentsRES := GLE.Count;
                    GLE.CalcSums(Amount);
                    BillsRes := GLE.Amount;
                end;

                if GenJournalBatch."Template Type" = EnumGenJrnTemplType::Payments then begin
                    //izbroj Count pa smjesti u varijablu za usluge
                    GLE.Reset();
                    GLE.SetFilter("Journal Batch Name", '%1', GenJournalBatch.Name);
                    GLE.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");
                    GLE.SetFilter("Document Type", '%1', GenEnum::Payment);
                    GLE.SetRange("Posting Date", FromPostingDateFilter, ToPostingDateFilter);
                    GLE.SetFilter("Bill type", VrsteRacunaCNG);
                    if GLE.FindFirst() then begin
                        CountOfPaymentsRES := GLE.Count;
                        GLE.CalcSums(Amount);
                        BillsRes := GLE.Amount;
                        IncludeInPologPazara := false;
                    end;
                end;

                /* polog pazara se neće ovako računati, nego je to kopija Totala. 
                GLE.Reset();
                GLE.SetFilter("Journal Batch Name", '%1', GenJournalBatch.Name);
                GLE.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");
                GLE.SetRange("Posting Date", FromPostingDateFilter, ToPostingDateFilter);
                GLE.SetFilter("Document Type", '%1', GenEnum::" ");
                if GLE.FindFirst() then begin
                    GLE.CalcSums(Amount);
                    PologPazara += GLE.Amount;
                end; */

                CountOfPaymentsRES := Abs(CountOfPaymentsRES);
                Bills01 := Abs(Bills01);
                Bills02 := Abs(Bills02);
                Bills03 := Abs(Bills03);
                BillsRes := Abs(BillsRes);
                BillsCNG := Abs(BillsCNG);
                Bills123Total := Bills01 + Bills02 + Bills03;
                TotalTotal := Bills123Total + BillsRes;

                if IncludeInPologPazara then
                    PologPazara += TotalTotal;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    Caption = 'Posting date range';
                    field(FromPostingDateFilter; FromPostingDateFilter)
                    {
                        Caption = 'Posting Date - from:';
                        ApplicationArea = All;
                        ToolTip = 'Enter the beginning date of posting.';
                        NotBlank = true;
                    }
                    field(ToPostingDateFilter; ToPostingDateFilter)
                    {
                        Caption = 'Posting Date - to:';
                        ApplicationArea = All;
                        ToolTip = 'Enter the ending date of posting.';
                        NotBlank = true;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    var
        ECL: Record "Employee Contract Ledger";
        UserSetup: Record "User Setup";
        Emp: Record Employee;
    begin
        VrsteRacunaGAS := '';
        VrsteRacunaUsluge := '';
        VrsteRacunaCNG := '';

        VrsteRacunaGAS := BillTypeCodes('GAS');
        VrsteRacunaUsluge := BillTypeCodes('USLUGE');
        VrsteRacunaCNG := BillTypeCodes('CNG');

        //PostingDateFilter := WorkDate();
        ToPostingDateFilter := WorkDate();
        FromPostingDateFilter := WorkDate();
        MainCashier := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Main Cashier" = true then begin
                Emp.Reset();
                Emp.SetFilter("No.", '%1', UserSetup."Employee No. for Wage");
                if Emp.FindFirst() then
                    MainCashier := Emp."First Name" + ' ' + Emp."Last Name"
                else
                    MainCashier := '';
            end;

            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UserSetup."Employee No. for Wage");
            ECL.SetCurrentKey("Starting Date");
            ECL.Ascending;
            if ECL.FindLast() then begin
                OJ := ecl."Department Code";
            end else
                OJ := '';
        end;
    end;

    trigger OnPreReport()
    begin
        CompInfo.Get();
    end;

    procedure BillTypeCodes(Type: Text): Text
    var
        BillTypes: Record "Customer Templ.";
        Result: Text;
    begin
        Result := '';

        case Type of
            'GAS':
                begin
                    BillTypes.Reset();
                    BillTypes.SetFilter("Bill Category", '%1|%2|%3',
                                        BillTypes."Bill Category"::"Large Economy",
                                        BillTypes."Bill Category"::"Small Economy",
                                        BillTypes."Bill Category"::Household);
                    if BillTypes.FindSet() then
                        repeat
                            if Result <> '' then
                                Result += '|';
                            Result += BillTypes.Code;
                        until BillTypes.Next() = 0;
                end;
            'USLUGE':
                begin
                    BillTypes.Reset();
                    BillTypes.SetFilter("Bill Category", '%1', BillTypes."Bill Category"::Resource);
                    if BillTypes.FindSet() then
                        repeat
                            if Result <> '' then
                                Result += '|';
                            Result += BillTypes.Code;
                        until BillTypes.Next() = 0;
                end;
            'CNG':
                begin
                    BillTypes.Reset();
                    BillTypes.SetFilter("Bill Category", '%1', BillTypes."Bill Category"::CNG);
                    if BillTypes.FindSet() then
                        repeat
                            if Result <> '' then
                                Result += '|';
                            Result += BillTypes.Code;
                        until BillTypes.Next() = 0;
                end;
        end;

        exit(Result);
    end;

    var
        BankAccount: Record "Bank Account";
        GenJrnlBatch: Record "Gen. Journal Batch";
        VrsteRacunaGAS: Text;
        VrsteRacunaUsluge: Text;
        VrsteRacunaCNG: Text;
        CountOfPaymentsGAS: Integer;
        CountOfPaymentsRES: Decimal;
        CompInfo: Record "Company Information";
        GLE: Record "G/L Entry";
        Bills01, Bills02, Bills03, BillsRes, BillsCNG, Bills123Total, TotalTotal : Decimal;
        PologPazara: Decimal;
        GLS: Record "General Ledger Setup";
        CashReceiptJnlTmpl: Text;
        CashBatchName: Text;
        //PostingDateFilter: Date;
        ToPostingDateFilter, FromPostingDateFilter : Date;
        MainCashier: Text[200];
        OJ: Text;
        EnumGenJrnTemplType: Enum "Gen. Journal Template Type";
}
