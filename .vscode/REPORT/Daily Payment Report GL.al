report 50177 "Daily Payment Report GL"
{

    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Daily Payment Report GL.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItem22; "Gen. Journal Line")
        {
            RequestFilterFields = "Posting Date";
            column(Datee; Datee)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(Account_No__Change; "Account No. Change") { }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Source_No_; "Source No.")
            {
            }
            column(IznosUplata02GotovinaSum; IznosUplata02GotovinaSum) { }

            column(TotalIznosSum; TotalIznosSum) { }
            column(IznosPDVSum; IznosPDVSum) { }
            column(Description; Description)
            {
            }
            column(BrojUplata02GotovinaSum; BrojUplata02GotovinaSum) { }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(Payment_Type_Code; "Payment Type")
            {
            }
            column(Payment_Method; "Payment Method")
            {
            }
            column(IznosPDVSum2; IznosPDVSum2) { }
            column(IznosUplata02GotovinaSum2; IznosUplata02GotovinaSum2) { }
            column(IznosBezPDV; IznosBezPDV)
            {
            }
            column(IznosBezPDV02GotovinaSum2; IznosBezPDV02GotovinaSum2) { }
            column(IznosPDV; IznosPDV)
            {
            }
            column(DocumentNo; DocumentNo)
            {
            }
            column(IznosBezPDV02GotovinaSum; IznosBezPDV02GotovinaSum) { }
            column(BrojUplata02Gotovina; BrojUplata02Gotovina)
            {
            }
            column(IznosUplata02Gotovina; IznosUplata02Gotovina)
            {
            }
            column(IznosBezPDV02Gotovina; IznosBezPDV02Gotovina)
            {
            }
            column(IznosPDV02Gotovina; IznosPDV02Gotovina)
            {
            }
            column(BrojUplata03Gotovina; BrojUplata03Gotovina)
            {
            }
            column(IznosUplata03Gotovina; IznosUplata03Gotovina)
            {
            }
            column(IznosBezPDV03Gotovina; IznosBezPDV03Gotovina)
            {
            }
            column(IznosPDV03Gotovina; IznosPDV03Gotovina)
            {
            }
            column("BrojUplata03Kartično"; "BrojUplata03Kartično")
            {
            }
            column("IznosUplata03Kartično"; "IznosUplata03Kartično")
            {
            }
            column("IznosBezPDV03Kartično"; "IznosBezPDV03Kartično")
            {
            }
            column("IznosPDV03Kartično"; "IznosPDV03Kartično")
            {
            }
            column(TotalBezPDV; TotalBezPDV)
            {
            }
            column(TotalPDV; TotalPDV)
            {
            }
            column(TotalIznos; TotalIznos)
            {
            }
            column(CashierCodeGLE; CashierCodeGLE)
            {
            }
            column(FIrstAndLastName; FIrstAndLastName) { }
            column(Userid; userID) { }

            trigger OnPreDataItem()
            begin

                BankAccCardFilter := RecNo;

                BrojUplata02Gotovina := 0;
                IznosUplata02Gotovina := 0;
                IznosBezPDV02Gotovina := 0;
                IznosPDV02Gotovina := 0;

                BrojUplata03Gotovina := 0;
                IznosUplata03Gotovina := 0;
                IznosBezPDV03Gotovina := 0;
                IznosPDV03Gotovina := 0;

                "BrojUplata03Kartično" := 0;
                "IznosUplata03Kartično" := 0;
                IznosBezPDV03Kartično := 0;
                IznosPDV03Kartično := 0;

                TotalBezPDV := 0;
                TotalPDV := 0;
                TotalIznos := 0;

            end;

            trigger OnAfterGetRecord()
            var
                DataItem22Rec: Record "Gen. Journal Line";
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
                Datee := "Posting Date"; //PROBATI ZAMIJENITI
                CashierCodeGLE := "Cashier Employer";

                IznosPDV := "Credit Amount" * 17 / 117;
                IznosBezPDV := "Credit Amount" - IznosPDV;

                /*TotalBezPDV += IznosBezPDV;
                TotalPDV += IznosPDV;
                TotalIznos += "Credit Amount";*/

                /* CustLedgerEntry.Reset(); //jer mi treba broj dokumenta za zatvaranje
                 CustLedgerEntry.SetFilter("Closed by Entry No.", '%1', "Entry No.");
                 if CustLedgerEntry.FindFirst() then
                     DocumentNo := CustLedgerEntry."Document No.";*/
                DocumentNo := "Applies-to Doc. No.";
                IznosPDVSum := 0;

                DataItem22Rec.Reset();
                DataItem22Rec.CopyFilters(DataItem22);
                DataItem22Rec.SetFilter("Payment Type", '%1', "Payment Type");
                DataItem22Rec.SetFilter("Payment Method", '%1', "Payment Method");
                if DataItem22Rec.FindFirst()
                then begin
                    DataItem22Rec.CalcSums("Credit Amount");
                    IznosPDVSum := DataItem22Rec."Credit Amount" * 17 / 117;
                    BrojUplata02GotovinaSum := DataItem22Rec.Count;
                    IznosUplata02GotovinaSum := DataItem22Rec."Credit Amount";
                    IznosBezPDV02GotovinaSum := DataItem22Rec."Credit Amount" - IznosPDVSum;
                    TotalIznosSum := DataItem22Rec."Credit Amount";

                end;

                DataItem22Rec.Reset();
                DataItem22Rec.CopyFilters(DataItem22);
                if DataItem22Rec.FindFirst()
                then begin
                    DataItem22Rec.CalcSums("Credit Amount");
                    IznosPDVSum2 := DataItem22Rec."Credit Amount" * 17 / 117;

                    IznosUplata02GotovinaSum2 := DataItem22Rec."Credit Amount";
                    IznosBezPDV02GotovinaSum2 := DataItem22Rec."Credit Amount" - IznosPDVSum;

                end;

                if ("Payment Type" = '02') AND ("Payment Method" = "Payment Method"::Cash) then begin //02 gotovina

                    BrojUplata02Gotovina += 1;
                    IznosUplata02Gotovina += "Credit Amount";
                    IznosBezPDV02Gotovina += IznosBezPDV;
                    IznosPDV02Gotovina += IznosPDV;
                    TotalIznos += "Credit Amount";

                end;

                if "Payment Type" = '03' then begin
                    if "Payment Method" = "Payment Method"::Cash then begin //03 gotovina

                        BrojUplata03Gotovina += 1;
                        IznosUplata03Gotovina += "Credit Amount";
                        IznosBezPDV03Gotovina += IznosBezPDV;
                        IznosPDV03Gotovina := IznosPDV;
                        TotalIznos += "Credit Amount";

                    end else
                        if "Payment Method" = "Payment Method"::card then begin //03 kartično

                            "BrojUplata03Kartično" += 1;
                            "IznosUplata03Kartično" += "Credit Amount";
                            "IznosBezPDV03Kartično" += IznosBezPDV;
                            "IznosPDV03Kartično" += IznosPDV;
                            TotalIznos += "Credit Amount";

                        end;

                end;

                TotalPDV := TotalIznos * 17 / 117;
                TotalBezPDV := TotalIznos - TotalPDV;

            end;
        }

        dataitem(DataItem21; "Bank Account")
        {
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                /*group("Date")
                {
                    Caption = 'Datum izvještaja';
                    field(Datee; Datee)
                    {
                        Caption = 'Datum izvještaja: ';
                    }
                }*/
            }
        }

        actions
        {
        }
    }

    procedure SetParam(No: Code[20])
    begin

        RecNo := No;

    end;

    var
        RecNo: Code[20];

        CashierCodeGLE: Code[10];
        IznosPDVSum2: Decimal;
        BrojUplata02GotovinaSum: Decimal;

        BrojUplata02Gotovina: Integer;
        IznosUplata02Gotovina: Decimal;
        IznosBezPDV02Gotovina: Decimal;

        IznosPDVSum: Decimal;
        IznosPDV02Gotovina: Decimal;

        BrojUplata03Gotovina: Integer;
        Us: Record "User Setup";
        FIrstAndLastName: text;
        EMployeeF: Record Employee;
        IznosUplata03Gotovina: Decimal;
        IznosBezPDV03Gotovina: Decimal;
        IznosPDV03Gotovina: Decimal;


        BrojUplata03Kartično: Integer;
        IznosUplata03Kartično: Decimal;
        IznosBezPDV03Kartično: Decimal;
        IznosPDV03Kartično: Decimal;

        TotalBezPDV: Decimal;
        TotalPDV: Decimal;
        TotalIznos: Decimal;

        IznosBezPDV: Decimal;
        IznosPDV: Decimal;

        DocumentNo: Code[20];
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GJLine: Record "Gen. Journal Line";
        IznosUplata02GotovinaSum: Decimal;
        IznosBezPDV02GotovinaSum: Decimal;
        IznosUplata02GotovinaSum2: Decimal;
        BankAccount: Record "Bank Account";
        GLEntry: Record "G/L Entry";
        BankAccCardFilter: Code[20];
        Datee: Date;
        UserSetup: Record "User Setup";
        TotalIznosSum: Decimal;
        IznosBezPDV02GotovinaSum2: Decimal;
}
