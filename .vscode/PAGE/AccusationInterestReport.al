report 50146 "AccusationInterestReport"
{
    // BH1.00, KAMATNI LIST
    DefaultLayout = RDLC;
    RDLCLayout = './AccusationInterestReport.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Accusation Header")
        {

            RequestFilterFields = "No.", "Interest Rate Doument No.", "Payment Date";
            column(No; "No.")
            {

            }

            column(InvoiceNos; InvoiceNos)
            {

            }
            column(AccusationDate; FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Document_Date; "Document Date")
            {

            }
            column(DocumentNo; "Document No.")
            {

            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {

            }
            column(CompPage; CompInfo."Home Page")
            {

            }


            column(PhoneNo; CompInfo."Phone No.")

            {

            }
            column(PhoneNo2; CompInfo."Phone No. 2")
            {

            }
            column(FaxNo; CompInfo."Fax No.")
            {

            }

            column(Picture; CompInfo.Picture)
            {
            }
            column(CustomerCode; Customer."No.") { }
            column(CustomerName; Customer.Name)
            {

            }
            column(CustomerAddress; Customer.Address)
            {

            }
            column(CustomerCity; Customer."Post Code" + ' ' + Customer.City)
            {

            }
            column(Description; Description) { }
            column(Debt; Debt)
            {

            }
            column(DeadlineDate; "Document Date" + 15)
            {

            }
            column(Interest; Interest4) { }
            column(RespPerson; CompInfo."Accusation Responsible Person Name") { }
            column(RespPosition; CompInfo."Accusation Responsible Person Position") { }
            column(AccusationPhone; CompInfo."Accusation Phone No.") { }
            dataitem(DataItem2; "Interest Calculation")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);
                //    WHERE("Accusation Line Type" = FILTER(Debt));
                column(InvoiceNo;
                "Sales Invoice No.")
                {

                }
                column(Due_Date; "Due Date") { }
                column(InvoiceDate; FORMAT("Date from", 0, '<Day,2>.<Month,2>.<Year4>'))
                {

                }
                column(PaymentDate; FORMAT("Date to", 0, '<Day,2>.<Month,2>.<Year4>'))
                {

                }
                column(DaysPassed; FORMAT("Difference Days")) { }
                column(LineDebt; "Remaining amount") { }
                column(PaymentAmount; "Payment Amount") { }
                column(GoZaSt; "Interest Yearly Rate") { }
                column(CalculationType; CalculationType) { }
                column(InterestCoefficient; "Interest Coefficient") { }
                column(InterestAmount; "Interest Amount") { }



                trigger OnAfterGetRecord()
                var

                    AL: Record "Interest Calculation";


                begin
                    //  Interest := 0;
                    if "Interest Calculation Type" = InterestCalculationType::Comfort then CalculationType := '1K' else CalculationType := '1S';


                    //   al.Reset();
                    // al.SetFilter("Document No.", '%1', DataItem1."Document No.");
                    // if al.FindSet() then
                    //   repeat

                    //     al.CalcFields("Interest Amount");
                    Interest4 := 0;
                    AL.Reset();
                    AL.CopyFilters(DataItem2);
                    if al.FindFirst() then begin

                        al.CalcSums("Interest Amount");
                        Interest4 := al."Interest Amount";
                    end;
                    //  until al.Next() = 0;
                    if FORMAT("Date of Payment") = '' then begin
                        dayPassed := Today;
                    end
                    else
                        dayPassed := "Date of Payment";
                end;


            }

            trigger OnPreDataItem()
            var
                acc: Record "Accusation Header";
            begin
                CompInfo.CALCFIELDS(Picture);
                acc.SetFilter("No.", '%1', GetFilter("No."));
                if acc.FindFirst() then begin
                    Customer.Get(acc."Customer No.");
                end;

            end;

            trigger OnAfterGetRecord()

            var
                NoSeriesMgt: Codeunit NoSeriesExtented;
                gls: Record "General Ledger Setup";
            begin
                gls.get();
                if "Interest Rate Doument No." = '' then begin
                    if gls."Interest Rate Document Entry Series" <> '' then begin
                        "Interest Rate Doument No." := NoSeriesMgt.GetNextNo(gls."Interest Rate Document Entry Series", TODAY, true);
                        DataItem1.Modify();
                    end;

                end;


            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            DataItem1.SetFilter("No.", RecNo);
        end;
    }

    labels
    {
    }



    trigger OnPreReport()
    begin
        CompInfo.GET;

    end;

    var
        RecNo: Code[20];
        CompInfo: Record "Company Information";
        ORG: Record "ORG Shema";
        Head: Record "Head Of's";
        CEO_Phone: Text[100];
        Customer: Record Customer;
        Interest: Decimal;
        InvoiceNos: Text;
        Interest4: Decimal;
        CalculationType: Text;
        dayPassed: Date;

    procedure SetAccusation(accRec: Code[20])
    begin
        RecNo := accRec;
    end;
}

