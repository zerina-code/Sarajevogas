report 50196 "Card Payment Spec. GenJ"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Card Payment Specification GenJournal.rdl';


    dataset
    {
        dataitem(DataItem21; "Gen. Journal Line")
        {
            trigger OnPreDataItem()
            begin
                //BankAccCardFilter := GETFILTER("Bal. Account No.");
                SetFilter(Description, '<>%1', 'Polog pazara');
            end;
        }

        dataitem(DataItem22; "Bank Account")
        {
            column(BankNo; DataItem22."No.")
            {
            }
            column(BankName; DataItem22.Name)
            {
            }
            column(PaymentAmount; PaymentAmount)
            {
            }
            column(Show; Show)
            {
            }
            column(Datee; Datee)
            {
            }
            column(FIrstAndLastName; FIrstAndLastName) { }
            column(Userid; userID) { }

            /*column(ReportTitle; ReportTitle)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(User; USERID)
            {
            }
            column(Counter; Counter)
            {
            }
            column(PTCounter; PTCounter)
            {
            }*/

            trigger OnAfterGetRecord()
            begin
                PaymentAmount := 0;

                Us.get(UserId);
                EMployeeF.Reset();
                EMployeeF.SetFilter("No.", '%1', us."Employee No. for Wage");
                if EMployeeF.FindFirst() then begin
                    FIrstAndLastName := EMployeeF."First Name" + ' ' + EMployeeF."Last Name"
                end
                else begin

                    FIrstAndLastName := '';
                end;

                Show := 0;
                GLEntry.Reset();
                GLEntry.CopyFilters(DataItem21);
                GLEntry.SetFilter("Bal. Account No.", '%1', DataItem22."No.");
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Payment Method", '%1', GLEntry."Payment Method"::Card);
                //jos da je uplata
                if GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += GLEntry."Credit Amount";
                    until GLEntry.Next() = 0;
                Show := 1;

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

    labels
    {
    }



    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        us.Get(UserId);
        Datee := us."Posting Date Cash";


    end;

    var
        CompanyInformation: Record "Company Information";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        GLEntry: Record "Gen. Journal Line";
        ReportTitle: Text[100];
        BankAccCardFilter: Code[20];
        BankAccCardInt: Integer;
        Us: Record "User Setup";
        FIrstAndLastName: text;
        EMployeeF: Record Employee;
        Datee: Date;
        PaymentCounter: Integer;
        PaymentAmount: Decimal;
        Counter: Integer;
        PTCounter: Integer;
        Show: Integer;

}

