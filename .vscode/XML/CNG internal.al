report 50221 "CNG Internal"
{
    Caption = 'CNG Internal';
    DefaultLayout = RDLC;
    RDLCLayout = './CNG Internal.rdl';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Line")

        {
            RequestFilterFields = "Posting Date2", "Document No.", "Document Type", "Line No.";

            //Order No., Order Line No.
            column(Document_No_; "Document No.")
            {
            }
            column(Driver_Name; "Driver Name") { }
            column(Driver_ID; "Driver ID") { }
            column(Driver_Registration_No_; "Driver Registration No.") { }
            column(Driver_type; "Driver type") { }
            column(Type_of_vehicle; "Type of vehicle") { }
            column(Posting_Date; "Posting Date2") { }
            column(TypeVehnicleText; TypeVehnicleText) { }
            column(Qty_SalesInvLine; "Quantity Shipped") { }
            column(UOM_SalesInvLine; "Unit of Measure Code") { }
            column(CZkPhoneNumber; CZkPhoneNumber) { }
            column(CustomerCode; "Bill-to Customer No.") { }
            column(CustomerName; CustomerData."Name") { }
            column(CustomerA; CustomerData.Address) { }
            column(UMCapt; UMCapt)
            {
            }
            column(QuantityCapt; QuantityCapt)
            {
            }

            column(CustomerVAT; CustomerData."VAT Registration No.") { }
            column(CustomerID; CustomerData."Registration No.") { }
            column(Addres; ComPInfo.Address) { }
            column(City; ComPInfo.City) { }
            column(FORMAT_ShipmentDate; FORMAT("Shipment Date", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(CustPhone;
            CustomerData."Phone No.")
            {
            }
            column(FaxNoCZK; FaxNoCZK) { }

            column(shipCity; ComPInfo.City)
            {
            }

            column(PostCode; ComPInfo."Post Code")
            {
            }

            column(RegistrationNo; ComPInfo."Registration No.")
            {
            }
            column(IBAN; ComPInfo.IBAN)
            {
            }
            column(PhoneNo; ComPInfo."Phone No.")
            {
            }

            column(FaxNo; ComPInfo."Fax No.")
            {
            }

            column(Name2; ComPInfo."Name 2")
            {
            }
            column(EMail; ComPInfo."E-Mail")
            {
            }
            column(VATRegNo; ComPInfo."VAT Registration No.")
            {
            }
            column(Description; Description) { }
            column(Quantity; Quantity) { }
            column(IndustrialClasification; ComPInfo."Industrial Classification")
            {

            }
            column(Unit_Price; "Unit Price") { }
            column(Unit_Cost; "Unit Cost") { }

            column(comp_tax; ComPInfo."Tax No.") { }
            column(compCont; ComPInfo."Contact Phone") { }
            column(compPhone; ComPInfo."Phone No.") { }
            column(PhoneNo2; ComPInfo."Phone No. 2") { }
            column(ButilePhone; ComPInfo."Phone Number Butile") { }
            column(ButilePFax; ComPInfo."Fax Butile") { }
            column(PostingDate_SalesInvHdr; FORMAT(SalesInvoiceHeader."Posting Date2", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(DispatchCenter; ComPInfo."Dispatch Center") { }
            column(compPurchasePhone; ComPInfo."Purchase Phone No.") { }
            column(compFax; ComPInfo."Fax No.") { }
            column(comp_djelatnost; ComPInfo."Industrial Classification") { }
            column(comp_regtext; ComPInfo."Registration Text") { }
            column(comp_MBS; ComPInfo.MBS) { }
            column(comp_email; ComPInfo."E-Mail") { }
            column(comp_mun; ComPInfo."Municipality Name") { }
            column(transaction1; transaction1) { }
            column(transaction1Name; transaction1Name) { }
            column(transaction10; transaction10) { }
            column(transaction10Name; transaction10Name) { }
            column
            (transaction2; transaction2)
            { }
            column(transaction2Name; transaction2Name) { }
            column(transaction3; transaction3) { }
            column(transaction3Name; transaction3Name) { }
            column(transaction4; transaction4) { }
            column(transaction4Name; transaction4Name) { }
            column(transaction5; transaction5) { }
            column(transaction5Name; transaction5Name) { }
            column(transaction6; transaction6) { }
            column(transaction6Name; transaction6Name) { }
            column(transaction7; transaction7) { }
            column(transaction7Name; transaction7Name) { }
            column(transaction8; transaction8)
            {

            }
            column(SigPosText; NazivRN) { }
            column(transaction8Name; transaction8Name) { }
            column(CompanyInfo2Picture; ComPInfo.Picture1)
            {
            }
            column(transaction9; transaction9) { }
            column(transaction9Name; transaction9Name) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin


                SETFILTER(Quantity, '<>%1', 0);
                SETFILTER("No.", '%1', 'GAS');
                SETFILTER("Location Code", 'CNG*|*VLASTITA*');
                //     SetCurrentKey("Bill Type", "Sell-to Customer No.");
                Ascending(false);

            end;

            trigger OnAfterGetRecord()
            begin
                racuna := 0;
                ComPInfo.GET;
                ComPInfo.CALCFIELDS(Picture, Picture1);
                CustomerData.Reset();
                CustomerData.setfilter("No.", '%1', SalesInvoiceHeader."Bill-to Customer No.");
                CustomerData.FindFirst();
                // IF PostCode.GET("Ship-to Post Code") THEN shipCity := PostCode.City;


                IF SalesInvoiceHeader."Type of vehicle" = SalesInvoiceHeader."Type of vehicle"::"Cargo vehicles"
                                      then
                    TypeVehnicleText := 'TERETNA VOZILA'

                else
                    IF SalesInvoiceHeader."Type of vehicle" = SalesInvoiceHeader."Type of vehicle"::"Passenger vehicles"
                    then
                        TypeVehnicleText := 'PUTNIČKA VOZILA'
                    ELSE
                        TypeVehnicleText := '';

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', US."Employee No. for Wage");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then begin
                        NazivRN := ecl."Position Description";
                    end
                    else begin
                        NazivRN := '';
                    end;
                    ;
                end
                else begin
                    NazivRN := '';
                end;

                FaxNoCZK := '';
                CZkPhoneNumber := '';

                UserM.reset;
                UserM.setfilter("User ID", '%1', USERID);
                if UserM.findfirst then begin
                    CZkPhone.reset;
                    CZkPhone.setfilter("No.", '%1', UserM.CZK);
                    if CZkPhone.findfirst then begin
                        CZkPhoneNumber := CZKPhone."Phone No.";
                        FaxNoCZK := CZKPhone."Fax No.";
                    end;
                end;
                CompanyInfo.GET;
                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 1");
                if banacc.FindFirst() then begin

                    transaction1 := banacc."Bank Account No.";
                    transaction1Name := banacc.Name;
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 2");
                if banacc.FindFirst() then begin
                    transaction2name := banacc.Name;
                    transaction2 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 3");
                if banacc.FindFirst() then begin
                    transaction3Name := banacc.Name;
                    transaction3 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 4");
                if banacc.FindFirst() then begin
                    transaction4Name := banacc.Name;
                    transaction4 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 5");
                if banacc.FindFirst() then begin

                    transaction5Name := banacc.Name;
                    transaction5 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 6");
                if banacc.FindFirst() then begin

                    transaction6Name := banacc.Name;
                    transaction6 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 7");
                if banacc.FindFirst() then begin

                    transaction7Name := banacc.Name;
                    transaction7 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 8");
                if banacc.FindFirst() then begin

                    transaction8Name := banacc.Name;
                    transaction8 := banacc."Bank Account No.";
                end;


                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 9");
                if banacc.FindFirst() then begin

                    transaction9Name := banacc.Name;
                    transaction9 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 10");
                if banacc.FindFirst() then begin

                    transaction10Name := banacc.Name;
                    transaction10 := banacc."Bank Account No.";
                end;

            end;


        }
    }



    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50201);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;

    end;

    trigger OnPreReport()
    begin


    end;

    var
        ComPInfo: Record "Company Information";
        Text000: Label 'Period: %1';
        DateFilter: Text[30];
        US: Record "User Setup";
        ReportCaptionLbl: Label 'CNG Summary';
        ContinuedCaption: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        SlineTemp: Record "Dismantling Reason" temporary;
        RedniBroj: Integer;
        NazivRN: text;

        kg: decimal;
        racuna: decimal;
        ECL: Record "Employee Contract Ledger";
        SIL: Record "Sales Invoice Line";
        CustomerCaptionLbl: Label 'Customer';
        banacc: Record "Bank Account";
        CompanyInfo: Record "Company Information";

        CustomerNow: Record "Customer Ledger Entry";
        Rez: Decimal;
        Mjesec: array[12] of Text;

        OpomenaCode: code[20];

        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        transaction1: text[100];
        transaction3: text[100];

        transaction3Name: text[100];

        transaction2Name: text[100];
        transaction4Name: text[100];

        CalcSu: Record "Calculation Journal Line";
        transaction4: Text[100];
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];

        IznosSaldo: Decimal;

        transaction8Name: TEXT[100];
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];

        transaction10: TEXT[100];

        PaymentMethodCaptionLbl: Label 'Payment Method';

        AmountCaptionLbl: Label 'Amount';
        AmountInclVATCaptionLbl: Label 'Amount Including VAT';
        VATCaptionLbl: Label 'VAT';

        cash: decimal;
        card: decimal;
        ownconsumption: decimal;
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";

        giro: decimal;

        SIH: record "Sales Invoice Header";
        CZkPhone: record "Bank Account";

        CustName: Text;
        CustNameRedni: Integer;
        PaymentMethod: Text[30];

        PaidAmount: decimal;
        PaidAmountInclVAT: decimal;

        SL: record "Sales Line";
        SH: record "Sales Header";
        Cust: Record Customer;

        GotovinaAmount: Decimal;
        GotovinaAmountInclVAT: Decimal;
        GotovinaKG: Decimal;
        CustomerData: Record Customer;
        GotovinaRacuna: Decimal;
        KarticnoAmount: Decimal;
        KarticnoAmountInclVAT: Decimal;
        KarticnoKG: Decimal;
        KarticnoRacuna: Decimal;
        VirmanAmount: Decimal;
        VirmanAmountInclVAT: Decimal;
        VirmanKG: Decimal;
        VirmanRacuna: Decimal;

        TeretnaAmount: Decimal;
        TeretnaAmountInclVAT: Decimal;
        TeretnaKG: Decimal;
        TeretnaRacuna: Decimal;
        VlastitaAmount: Decimal;
        VlastitaAmountInclVAT: Decimal;
        CZkPhoneNumber: text;
        VlastitaKG: Decimal;
        VlastitaRacuna: Decimal;

        TotalLbl: Label 'Total';
        UserM: record "User Setup";
        SHL: Record "Sales Shipment Line";
        Selected: Option " ","TotalSales","CNGSales";

        SalesSetup: Record "Sales & Receivables Setup";


        PravnaAmount: Decimal;
        PravnaAmountInclVAT: Decimal;
        PravnaKG: Decimal;
        PravnaRacuna: Decimal;

        UMCapt: Label 'Unit of measure';
        QuantityCapt: Label 'Quantity';

        FizickaAmount: Decimal;
        FizickaAmountInclVAT: Decimal;
        FizickaKG: Decimal;
        FaxNoCZK: text[250];
        FizickaRacuna: Decimal;
        FizickaKartAmount: Decimal;
        TypeVehnicleText: TEXT[100];
        FizickaKartAmountInclVAT: Decimal;
        FizickaKartKG: Decimal;
        FizickaKartRacuna: Decimal;

}
