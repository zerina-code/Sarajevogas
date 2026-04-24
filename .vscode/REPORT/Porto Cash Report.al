report 50085 "Report2Cash"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Porto Cash Report.rdl';


    dataset
    {
        dataitem(DataItem21; "G/L Entry")
        {
            trigger OnPreDataItem()
            begin
                BankAccCardFilter := RecNo;
            end;
        }

        dataitem(DataItem22; "Customer Templ.")
        {
            column(PTCode; DataItem22.Code)
            {
            }
            column(PaymentCounter; PaymentCounter)
            {
            }
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

            trigger OnAfterGetRecord()
            begin

                //za svaku vrstu uplate koju uzimam u PT code polje stavljam filtere
                //naziv serije naloga knjižnja, datum, vrsta uplate, uplata kao vrsta dokumenta

                GLEntry.SetFilter("Bal. Account No.", '%1', BankAccCardFilter);
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Bill Type", '%1', DataItem22.Code);
                if select = Select::"POS terminali dnevni izvještaj" then begin
                    GLEntry.SetFilter("Payment Method", '%1', 'KARTIČNO');
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

    procedure SetParam(FirstSelect: Option; No: code[20])
    begin
        Select := FirstSelect;
        RecNo := No;
    end;

    var
        RecNo: Code[20];
        Select: Option ,"Izvještaj porto blagajne","POS terminali dnevni izvještaj";
        CompanyInformation: Record "Company Information";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        GLEntry: Record "G/L Entry";
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

