report 50129 "A-B-2"
{
    Caption = 'Zahtjev za otvaranje naloga', Locked = true;
    DefaultLayout = Word;
    WordLayout = '.\.vscode\REPORT\WORD\Zahtjev za otvaranje naloga.docx';

    dataset
    {
        dataitem("Customer Ledger Entry"; "Customer Ledger Entry")
        {
            column(Customer_Name; "Customer Name")
            {
            }
            column(Code; Code)
            {
            }
            column(st_customername; StandardText2."Customer name")
            {
            }
            column(st_Address; StandardText2.Address)
            {
            }
            column(st_Floor; StandardText2."Floor Customer 2")
            {
            }
            column(gauge_no; Gauge1.Code)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                StandardText2.Reset();
                Standardtext2.SETFILTER("Starting date", '<%1', "Customer Ledger Entry"."Starting Date");
                Standardtext2.SETFILTER("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                Standardtext2.SETCURRENTKEY("Starting date");
                Standardtext2.ASCENDING;
                Standardtext2.FINDLAST;
            end;





            trigger OnPreDataItem()

            begin

                SETFILTER("Contract reason", '=%1', 'A-B');

                SETFILTER("Customer No.", '1000');

            end;

        }


    }
    var
        StandardText2: Record "Customer Ledger Entry";
        Gauge1: Record Gauge;
}