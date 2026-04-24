report 50194 "Report2Cash GenJournal"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Porto Cash Report GenJournal.rdl';


    dataset
    {


        dataitem(DataItem22; "Customer Templ.")
        {
            column(PTCode; DataItem22.Code)
            {
            }
            column(PaymentCounter; PaymentCounter)
            {
            }
            column(PrintFIlters; PrintFIlters) { }
            column(PaymentAmount; PaymentAmount)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(Datee; Datee)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(User; USERID)
            {
            }
            column(FIrstAndLastName; FIrstAndLastName) { }
            column(Select; Select)
            {
            }
            column(Counter; Counter)
            {
            }
            column(Show; Show)
            {
            }
            column(PTCounter; PTCounter)
            {
            }

            dataitem(DataItem21; "Gen. Journal Line")
            {
                trigger OnPreDataItem()
                var
                    US: Record "User Setup";
                begin
                    BankAccCardFilter := RecNo;
                    SetFilter("Payment Type", '%1', DataItem22.Code);
                    SetFilter("Posting Date", '%1', DataItem21."Posting Date");
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    if US.FindFirst() then begin

                        SetFilter("Main Cashier", '%1', us."Main Cashier");
                    end;
                    if BatchName <> '' then
                        DataItem21.SetFilter("Journal Batch Name", BatchName);

                    PrintFIlters := GetFilters;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                Us.get(UserId);
                EMployeeF.Reset();
                EMployeeF.SetFilter("No.", '%1', us."Employee No. for Wage");
                if EMployeeF.FindFirst() then begin
                    FIrstAndLastName := EMployeeF."First Name" + ' ' + EMployeeF."Last Name"
                end
                else begin

                    FIrstAndLastName := '';
                end;

                //za svaku vrstu uplate koju uzimam u PT code polje stavljam filtere
                //naziv serije naloga knjižnja, datum, vrsta uplate, uplata kao vrsta dokumenta
                GLEntry.Reset();
                //DataItem21
                GLEntry.CopyFilters(DataItem21);
                GLEntry.SetFilter("Posting Date", '%1', Datee);

                //GLEntry.SetFilter("Bal. Account No.", '%1', BankAccCardFilter);
                // GLEntry.SetFilter("Posting Date", '%1', Datee);

                GLEntry.SetFilter("Payment Type", '%1', DataItem22.Code);

                if select = Select::"POS terminali dnevni izvještaj" then begin
                    GLEntry.SetFilter("Payment Method", '%1', GLEntry."Payment Method"::Card);
                    if BatchName <> '' then
                        GLEntry.SetFilter("Journal Batch Name", BatchName);
                    ReportTitle := 'DNEVNI IZVJEŠTAJ SA BLAGAJNE';
                    Show := 1;
                end else begin
                    ReportTitle := 'IZVJEŠTAJ PORTO BLAGAJNE Br. ';
                    Show := 2;
                end;

                PaymentCounter := GLEntry.Count;

                PaymentAmount := 0;

                IF GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += ABS(GLEntry.Amount);
                    until GLEntry.Next() = 0;

                Counter += 1;

            end;

            trigger OnPreDataItem()
            begin
                PTCounter := DataItem22.Count;
                Show := 0;
            end;



        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date")
                {
                    Caption = 'Datum izvještaja';
                    field(Datee; Datee)
                    {
                        Caption = 'Datum izvještaja: ';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        us.Get(UserId);
        Datee := us."Posting Date Cash";


    end;

    procedure SetParam(FirstSelect: Option; No: code[20]; BatchSent: Code[20])
    begin
        Select := FirstSelect;
        RecNo := No;
        BatchName := BatchSent;

    end;

    var
        RecNo: Code[20];
        Select: Option ,"Izvještaj porto blagajne","POS terminali dnevni izvještaj";
        BatchName: code[20];
        CompanyInformation: Record "Company Information";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        GLEntry: Record "Gen. Journal Line";
        PrintFIlters: text;
        Us: Record "User Setup";
        FIrstAndLastName: text;
        EMployeeF: Record Employee;
        ReportTitle: Text[100];
        BankAccCardFilter: Code[20];
        BankAccCardInt: Integer;
        Datee: Date;
        PaymentCounter: Integer;
        PaymentAmount: Decimal;
        Counter: Integer;
        PTCounter: Integer;
        UserSetup: Record "User Setup";
        Show: Integer;
}

