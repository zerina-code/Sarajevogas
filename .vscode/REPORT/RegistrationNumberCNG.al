report 50112 RegistrationNumberCNG
{
    // BH1.00Fiscal Process
    // BH1.01, Invoice elements
    DefaultLayout = RDLC;
    RDLCLayout = './RegistrationNumberCNG.rdl';

    Caption = 'Registration Number CNG';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SalesShipmentLine; "Sales Shipment Line")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "Driver Name", "Sell-to Customer No.", "Document No.", "Driver ID";
            RequestFilterHeading = 'Sales Shipment Line';

            column(Type_of_vehicle;
            vehicle)
            {

            }
            column(Fiscal_No_; "Fiscal No.")
            {

            }

            column(SalesHeader; "Document No.")
            {
            }

            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(BuyerName; BuyerName)
            {

            }
            column(PaymentDesc; "Payment MEthod Code")
            {

            }
            column(BuyerAdress; BuyerAdress)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(TodayFormatted; FORMAT(TODAY))
            {
            }

            column(EndDateCaption; STRSUBSTNO(FORMAT(EndDate)))
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(PeriodText))
            {
            }

            column(DriverName; "Driver Name")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(DriverRegistrationNo; "Driver Registration No.")
            {

            }
            column(Selected; Selected)
            {
            }
            column(Description; Description)
            {

            }
            column(Amount_Including_VAT; "Amount Incl. VAT")
            {

            }
            column(RegNoFilter; RegNoFilter)
            {

            }

            column(CustFilter; CustFilter)
            {

            }


            trigger OnPreDataItem()
            begin
                CustFilter := SalesShipmentLine.GetFilter("Sell-to Customer No.");
                RegNoFilter := SalesShipmentLine.GetFilter("Driver Registration No.");
                SETFILTER(Quantity, '<>%1', 0);
                SETFILTER("No.", '%1', 'GAS');
                SETFILTER("Location Code", '%1|%2', 'CNG*', 'VLASTITA');
                SETFILTER("Correction", '%1', FALSE);
            end;

            trigger OnAfterGetRecord()
            var


            begin


                cust.GET("Sell-to Customer No.");
                BuyerName := Cust.Name;
                BuyerAdress := Cust.Address;


                if "Type of vehicle".AsInteger() = 1 then
                    vehicle := 'T'
                else
                    if "Type of vehicle".AsInteger() = 2 then
                        vehicle := 'P'
                    else
                        vehicle := '';


                StartDate := GetRangeMin("Posting Date");
                EndDate := GETRANGEMAX("Posting Date");
                PeriodText := Format(StartDate) + ' - ' + Format(EndDate);

            end;
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Selected; Selected)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ',Kartica CNG-a po registarskim oznakama,Lista CNG u zadanom periodu';
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
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50112);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;
    end;


    var
        PaymentDesc: Text[100];
        UserSettings: Record "User Setup";
        DriverRegistrationNo: Code[30];
        StartDate: Date;
        EndDate: Date;
        vehicle: Text;
        SalesOrderSubform: record "Sales Line";
        CompanyInfo: Record "Company Information";
        PeriodText: text[30];
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";
        Quantity: Decimal;
        DriverName: Text[100];
        salesheader: Record "Sales Header";

        PaymentMethod: record "Payment Method";

        BuyerName: text[100];
        counter: Integer;
        BuyerAdress: text[100];
        Selected: Option " ","RegBrojCNG","ListingCNG";
        cust: Record Customer;
        CustFilter: Text[250];
        RegNoFilter: Text[250];
}






