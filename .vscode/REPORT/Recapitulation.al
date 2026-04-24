report 50019 "Recapitulation"
{

    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Recapitulation.rdl';


    dataset
    {


        dataitem(DataItem22; "Bank Account")
        {
            DataItemTableView = SORTING("No.") where("No." = FILTER('CZK*'));
            column(BankNo; DataItem22."No.")
            {
            }
            column(BankName; DataItem22.Name)
            {
            }

            column(UplataIznos; UplataIznos)
            {
            }
            column(IsplataIznos; IsplataIznos)
            {
            }
            column(Datee; Datee)
            {
            }
            /*column(Counter; Counter)
             {
             }*/

            trigger OnAfterGetRecord()
            begin
                UplataIznos := 0;
                IsplataIznos := 0;
                //Counter += 1;


                // if Counter > 9 then begin
                GLEntry.SetFilter("Bal. Account No.", '%1', "No.");
                GLEntry.SetFilter("Posting Date", '%1', Datee);

                //ovdje zaobilazim polog pazara kao isplatu
                //jer pazar ima kao broj proturacuna tranzitni konto koji je postavljen na kartici bankovnog računa
                //BankAccount.get(DataItem22."No.");

                if GLEntry.FindFirst() then
                    repeat
                        UplataIznos += GLEntry."Credit Amount";
                        if GLEntry."G/L Account No." <> BankAccount."Transit G/L account" then
                            IsplataIznos += GLEntry."Debit Amount";
                    until GLEntry.Next() = 0;


            end;


            //  end;

            /*trigger OnPreDataItem()
            begin
                Counter := 0;
            end;*/

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

    var
        CompanyInformation: Record "Company Information";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        GLEntry: Record "G/L Entry";
        ReportTitle: Text[100];
        BankAccCardFilter: Code[20];
        BankAccCardInt: Integer;
        Datee: Date;
        UplataIznos: Decimal;
        IsplataIznos: Decimal;
    //Counter: Integer;

}

