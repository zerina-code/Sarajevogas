report 50099 "Daily Payment Report"
{

    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Daily Payment Report.rdl';

    dataset
    {
        dataitem(DataItem22; "G/L Entry")
        {
            RequestFilterFields = "Posting Date";
            column(Datee; Datee)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(Account_No__Change; "Source No.") { }
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
            column(Credit_Amount; -1 * Amount)
            {
            }
            column(Payment_Type_Code; "Payment Type Code")
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
                DataItem22Rec: Record "G/L Entry";
                SalesInHeader: record "Sales Invoice Header";
            begin

                if ("Bill type" = '08') or ("Bill type" = '04') then begin
                    "Payment Type Code" := "Bill type";
                end;
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
                CashierCodeGLE := "Cashier Code";

                IznosPDV := (-1 * "Amount") * 17 / 117;
                IznosBezPDV := (-1 * "Amount") - IznosPDV;

                /*TotalBezPDV += IznosBezPDV;
                TotalPDV += IznosPDV;
                TotalIznos += "Credit Amount";*/

                /* CustLedgerEntry.Reset(); //jer mi treba broj dokumenta za zatvaranje
                 CustLedgerEntry.SetFilter("Closed by Entry No.", '%1', "Entry No.");
                 if CustLedgerEntry.FindFirst() then
                     DocumentNo := CustLedgerEntry."Document No.";*/
                DocumentNo := "External Document No.";

                if ("Bill type" = '08') or ("Bill type" = '04') and (DocumentNo <> '') then begin
                    if (CopyStr(DocumentNo, 1, 3) = '-08') or (CopyStr(DocumentNo, 1, 3) = '-04') then begin
                        SalesInHeader.Reset();
                        SalesInHeader.SetFilter("Order No.", '%1', DocumentNo);
                        if SalesInHeader.FindFirst() then begin
                            DocumentNo := SalesInHeader."No.";
                        end;
                    end;

                end;
                IznosPDVSum := 0;

                DataItem22Rec.Reset();
                DataItem22Rec.CopyFilters(DataItem22);
                DataItem22Rec.SetFilter("Payment Type Code", '%1', "Payment Type Code");
                DataItem22Rec.SetFilter("Payment Method", '%1', "Payment Method");
                if DataItem22Rec.FindFirst()
                then begin
                    DataItem22Rec.CalcSums(Amount);
                    IznosPDVSum := (-1 * DataItem22Rec."Amount") * 17 / 117;
                    BrojUplata02GotovinaSum := DataItem22Rec.Count;
                    IznosUplata02GotovinaSum := (-1 * DataItem22Rec."Amount");
                    IznosBezPDV02GotovinaSum := (-1 * DataItem22Rec."Amount") - IznosPDVSum;
                    TotalIznosSum := -1 * (DataItem22Rec."Amount");

                end;

                DataItem22Rec.Reset();
                DataItem22Rec.CopyFilters(DataItem22);
                if DataItem22Rec.FindFirst()
                then begin
                    DataItem22Rec.CalcSums("Amount");
                    IznosPDVSum2 := (-1 * DataItem22Rec."Amount") * 17 / 117;

                    IznosUplata02GotovinaSum2 := (-1 * DataItem22Rec."Amount");
                    IznosBezPDV02GotovinaSum2 := (-1 * DataItem22Rec."Amount") - IznosPDVSum;

                end;

                if ("Payment Type Code" = '02') AND ("Payment Method" = 'GOTOVINA') then begin //02 gotovina

                    BrojUplata02Gotovina += 1;
                    IznosUplata02Gotovina += (-1 * "Amount");
                    IznosBezPDV02Gotovina += IznosBezPDV;
                    IznosPDV02Gotovina += IznosPDV;
                    TotalIznos += (-1 * "Amount");

                end;

                if "Payment Type Code" = '03' then begin
                    if "Payment Method" = 'GOTOVINA' then begin //03 gotovina

                        BrojUplata03Gotovina += 1;
                        IznosUplata03Gotovina += (-1 * "Amount");
                        IznosBezPDV03Gotovina += IznosBezPDV;
                        IznosPDV03Gotovina := IznosPDV;
                        TotalIznos += (-1 * "Amount");

                    end else
                        if "Payment Method" = 'KARTIČNO' then begin //03 kartično

                            "BrojUplata03Kartično" += 1;
                            "IznosUplata03Kartično" += (-1 * "Amount");
                            "IznosBezPDV03Kartično" += IznosBezPDV;
                            "IznosPDV03Kartično" += IznosPDV;
                            TotalIznos += (-1 * "Amount");

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
        GJLine: Record "G/L Entry";
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
