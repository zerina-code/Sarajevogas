/*report 50150 "SpendingPlan"
{
    // BH1.00, PLAN POTROSNJE
    DefaultLayout = RDLC;
    RDLCLayout = './SpendingPlan.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; Customer)
        {

            //  RequestFilterFields = "Year", "Type";
         

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
            column(CustomerMail; Customer."E-Mail") { }
            column(City; Customer.City) { }
            column(ReportDate; FORMAT(Today, 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(RespPerson; CompInfo."Spending Plan Responsible Person Name") { }
            column(RespPosition; CompInfo."Spending Plan Responsible Person Position") { }

            column(MMAddress; mmAddress) { }
            column(ZoneStroke; mmZoneStroke) { }
            column(CustomerStroke; mmCustomerStroke) { }
            column(SerialNumber; mmSerialNumber) { }
            column(GaugeSize; gaugeSize) { }
            column(Phone; Customer."Phone No.") { }
            column(Year; Format(Year_int)) { }
            column(YearBefore; Format(Year_int - 1)) { }
            column(TwoYearsBefore; Format(Year_int - 2)) { }
            column(MonthName; Month) { }

            column(plan1; plan1) { }
            column(plan1Spent; plan1Spent) { }
            column(plan2; plan2) { }

            dataitem("Installation History"; "Installation History")
            {
                DataItemLink = "Customer No." = FIELD("No.");


                column(Measuring_Point_Adress; "Measuring Point Adress") { }
                column(mmZoneStroke; "Zone stroke") { }
                column(mmCode; "Measuring Point Code") { }
                column(mmCustomerStroke; "Customer Stroke") { }
                column(mmName; "MM Description") { }
                column(Serial_Number_I; "Serial Number I") { }
            }




            trigger OnAfterGetRecord()
            var
                mm1: Record "Area";
                mm2: Record "Area";
                mm1Spent: Record "Sales Invoice Header";
                sline: Record "Sales Invoice Line";
            begin

            end;

            trigger OnPreDataItem()
            var
            begin
                CompInfo.CALCFIELDS(Picture);

                Gauge.SetFilter("Customer No.", '%1', Customer."No.");
                Gauge.SetFilter("Code", '%1', FORMAT(Customer.MM));
                if Gauge.FindFirst() then begin
                    mmSerialNumber := Gauge."Inventar number";
                    gaugeSize := Gauge."Gauge Size";
                end;
                // Gauge.Get(Customer.MM);
            end;

        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(Year_int; Year_int)
                {
                    Caption = 'Year';
                }
            }
        }

        actions
        {


        }
        //  trigger OnOpenPage()
        //begin
        //     DataItem1.SetFilter("No.", RecNo);
        //end;
    }

    labels
    {
    }



    trigger OnPreReport()
    begin
        CompInfo.GET;

    end;

    var
        CompInfo: Record "Company Information";

        Customer: Record Customer;
        MM: Record "Service Item";
        Gauge: Record Gauge;
        plan1: Decimal;
        plan1Spent: Decimal;
        plan2: Decimal;
        mmCode: Text;
        mmName: Text;
        mmAddress: Text;
        mmZoneStroke: Text;
        mmSerialNumber: Text;
        mmCustomerStroke: Text;
        gaugeSize: Text;

        respPerson: Text;
        respPosition: Text;
        Year_int: Integer;

}

*/