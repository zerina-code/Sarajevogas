report 50168 "Update Balance Septembar "
{
    DefaultLayout = RDLC;
    Caption = '"Update Balance Septembar';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                CJLMinimum: Record "Calculation Journal Line";

            begin


                StartBalance := 0;
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                CH.Reset();
                CH.SetFilter(Code, '%1', "Calculation Journal Line".Code);
                if CH.FindFirst() then
                    CustLedgerEntry.SetFilter("Posting Date", '<=%1', CH."Calculation Date To");
                CustLedgerEntry.SetFilter("Prepayment", '%1', false);
                CustLedgerEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '1', '01', '2', '02', '3', '03');
                if CustLedgerEntry.FindSet() then
                    repeat
                        CustLedgerEntry.CalcFields("Amount (LCY)");
                        if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) and (CustLedgerEntry."Posting Date" = CH."Calculation Date To")
                        and (CustLedgerEntry."Due Date" = CalcDate('<+15D', CH."Calculation Date To")) then begin

                        end
                        else begin
                            StartBalance += CustLedgerEntry."Amount (LCY)";
                        end;

                    until CustLedgerEntry.next = 0;

                if StartBalance <= 0 then
                    IznosPretplate := abs(StartBalance)
                else
                    IznosSaldo := abs(StartBalance);

                //sada bi trebala ažurirati sve ostalo ood početak do k

                CJLOstali.Reset();
                CJLOstali.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                CJLOstali.SetFilter(Code, '%1', "Calculation Journal Line".Code);
                CJLOstali.SetCurrentKey("Reading Date To");
                CJLOstali.Ascending;
                if CJLOstali.FindSet() then
                    repeat

                        if StartBalance >= 0 then begin
                            CJLOstali."Customer Balance" := abs(StartBalance);
                            CJLOstali."Customer Prepayment" := 0;

                        end
                        else begin
                            CJLOstali."Customer Balance" := 0;
                            CJLOstali."Customer Prepayment" := abs(StartBalance);
                        end;
                        CJLOstali.Modify();
                        StartBalance += CJLOstali.Total;


                    until CJLOstali.Next() = 0;


            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SETFILTER(Unobvious, '%1', true);
                SetCurrentKey("Reading Date To");
                Ascending;
            end;
        }


    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CJLLog.DeleteAll();

    end;

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin

    end;

    var
        CJLLog: Record "CJL Logs";
        StartBalance:
         Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        IznosPretplate: Decimal;
        IznosSaldo: Decimal;

        IznosTotal: Decimal;
        CJLOstali: Record "Calculation Journal Line";
        CH: Record "Calcuation Header";

}

