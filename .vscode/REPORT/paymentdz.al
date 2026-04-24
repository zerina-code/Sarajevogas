report 50115 paymentdz
{
    DefaultLayout = RDLC;
    RDLCLayout = './CashierPrinter.rdl';

    ApplicationArea = basic, suite;
    UsageCategory = ReportsAndAnalysis;

    Caption = 'Isplatnica dz';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(BatchName; "Gen. Journal Line"."Journal Batch Name")
            {
            }
            column(SystemCreatedAt; format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>'))
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Prepayment_No_Text; PaymentText)
            {

                //ApplicationArea = All;



            }




            column(Document_No_; "Document No.")
            {

            }
            column(Blagajna; Blagajna)
            {

            }
            column(Line_No_; "Line No.")
            {

            }
            column(Line; "Line No.")
            {

            }
            COLUMN(Payment_Method; "Payment Method")
            {

            }
            column(PostingDate; "Posting Date")
            {
            }
            COLUMN(Payment_No_; "Payment No.")
            {

            }
            column(DocumentNo; "Gen. Journal Line"."Document No.")
            {
            }
            COLUMN(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {

            }
            column(Amound; "Gen. Journal Line"."Credit Amount")
            {
            }
            column(Description; Description)
            {
            }
            column(LineNo; "Gen. Journal Line"."Line No.")
            {
            }
            column(Ext; "Gen. Journal Line"."External Document No.")
            {
            }
            column(Adress_CompanyInfo; CompanyInformation.Address)
            {
            }
            column(City_CompanyInfo; CompanyInformation.City)
            {
            }
            column(Phone1_CompanyInfo; CompanyInformation."Phone No.")
            {
            }
            column(Phone2_CompanyInfo; CompanyInformation."Phone No. 2")
            {
            }
            column(Fax_CompanyInfo; CompanyInformation."Fax No.")
            {
            }
            column(Email_CompanyInfo; CompanyInformation."E-Mail")
            {
            }
            column(Homepage_CompanyInfo; CompanyInformation."Home Page")
            {
            }
            column(RegistrationNo_CompanyInfo; CompanyInformation."Registration No.")
            {
            }
            column(Postcode_CompanyInfo; CompanyInformation."Post Code")
            {
            }
            column(VATRegistrationNo_CompanyInfo; CompanyInformation."VAT Registration No.")
            {
            }
            column(GiroNo_CompanyInfo; CompanyInformation."Giro No.")
            {
            }
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(Country; Country)
            {
            }
            column(City; City)
            {
            }
            column(Account_No_; "Account No.")
            {

            }
            column(BankAdress; BankAdress)
            {

            }

            column(CName; ContName)
            {
            }
            column(CAddress; ContAddress)
            {
            }
            column(CCity; ContCity)
            {
            }
            column(PM; "Gen. Journal Line"."Payment Method Code")
            {
            }
            column(User; '')
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(Bal__Account_No_; "Bal. Account No.") { }
            COLUMN(CZKAdress; CZKAddress)
            {

            }
            column(FirstString; FirstString) { }
            column(TextTest; TextTest) { }
            column(TextTest2; TextTest2) { }
            COLUMN(CZKNumber; CZKNumber)
            {

            }
            column(RedniBrojSpiska; RedniBrojSpiska) { }
            column(TotalNumber; "Gen. Journal Line".Count) { }

            trigger OnAfterGetRecord()
            var
                PrepaymentNo: Code[20];
                jnl2: Record "Gen. Journal Line";
                GJLCurr: Record "Gen. Journal Line";


            begin

                // Convert the numeric value to text
                PrepaymentNo := "Gen. Journal Line"."Payment No.";
                PaymentText := PrepaymentNo;
                RedniBrojSpiska += 1;



                GJLCurr.Reset();
                GJLCurr.copyfilters("Gen. Journal Line");
                GJLCurr.SetFilter("Journal Template Name", '%1', "Gen. Journal Line"."Journal Template Name");
                GJLCurr.SetFilter("Journal Batch Name", '%1', "Gen. Journal Line"."Journal Batch Name");
                GJLCurr.SetFilter("Payment No. int", '>=%1', "Gen. Journal Line"."Payment No. int");
                GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::cash);
                if GJLCurr.FindFirst() then begin
                    GJLCurr.CalcSums("Amount (LCY)");

                    TotalAmountRow := abs(GJLCurr."Amount (LCY)");
                end
                else begin
                    TotalAmountRow := 0;
                end;

                GJLCurr.Reset();
                GJLCurr.copyfilters("Gen. Journal Line");
                GJLCurr.SetFilter("Journal Template Name", '%1', "Gen. Journal Line"."Journal Template Name");
                GJLCurr.SetFilter("Journal Batch Name", '%1', "Gen. Journal Line"."Journal Batch Name");
                GJLCurr.SetFilter("Payment No. int Card", '>=%1', "Gen. Journal Line"."Payment No. int Card");
                GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::Card);
                if GJLCurr.FindFirst() then begin
                    GJLCurr.CalcSums("Amount (LCY)");

                    TotalAmountRow2 := abs(GJLCurr."Amount (LCY)");
                end
                else begin
                    TotalAmountRow2 := 0;
                end;






                if "Payment Method" = "Payment Method"::Cash then
                    FirstString := '(G)=' + FORMAT(TotalAmountRow, 0, '<Precision,2:2><Standard Format,2>') + 'KM'
                else
                    FirstString := '(G)=' + FORMAT(TotalAmountRow2, 0, '<Precision,2:2><Standard Format,2>') + 'KM';


                TextTest := format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ';
                TextTest := format(DT2Time(SystemCreatedAt)) + '  ';


                BANKACC.reset();
                BANKACC.SetFilter("No.", '%1', "Bal. Account No.");
                if BANKACC.FindFirst() then begin
                    if BANKACC."No." = "Gen. Journal Line"."Bal. Account No." then begin
                        CZKAddress := BANKACC."Address";
                        CZKNumber := BANKACC."Mobile Phone No.";

                    end;
                end;

                Blagajna := "Bal. Account No." + ' ' + "Cashier Employer";

                /*   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK301*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK3 Blg1';
                   end;

                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK101*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK1 Blg1';
                   end;

                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK102*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK1 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK202*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK2 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK201*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK2 Blg1';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK302*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK3 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK402*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK4 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK401*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK4 Blg1';
                   end;

                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK602*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK6 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK601*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK6 Blg1';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK702*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK7 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK701*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK7 Blg1';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK802*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK8 Blg2';
                   end;
                   GJL.reset();
                   GJL.SetFilter("Document No.", '%1', 'CZK801*');
                   IF GJL.FindFirst() THEN begin
                       Blagajna := 'CZK8 Blg1';
                   end;*/









                /*Cont.SETFILTER("No.",'%1',"Contact Link");
                
                IF Cont.FIND('-') THEN BEGIN
                
                ContName:=Cont.Name;
                ContAddress:=Cont.Address;
                ContCity:=Cont."Post Code"+', '+Cont.City;
                END;  */




            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                //Location.SETFILTER(Code,"Location Code");
                //IF Location.FINDFIRST THEN
                //City:=Location.City;

                CountryRegion.SETFILTER(Code, CompanyInformation."Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    Country := CountryRegion.Name;


                ContName := ' ';
                ContAddress := ' ';
                ContCity := ' ';
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
    }

    labels
    {

    }
    trigger OnPostReport()
    begin
        // Hyperlink('runfrombc:');
    end;

    procedure SetParam(AmountTotal: Decimal; AmountTotal2: decimal; CashYes: Boolean)
    begin

        /*TotalAmountRow := AmountTotal;
        TotalAmountRow := AmountTotal2;
        CahsDa := CashYes;*/

    end;

    var
        CompanyInformation: Record 79;
        FirstString: text;
        Country: Text[100];
        TotalAmountRow: Decimal;
        TotalAmountRow2: Decimal;
        CahsDa: Boolean;


        TextTest: text;
        TextTest2: text;
        City: Text[100];
        PaymentText: Text[50];
        CountryRegion: Record 9;
        Location: Record 14;
        Cont: Record 5050;
        ContName: Text[100];
        CZKAddress: text[50];
        ContAddress: Text[100];
        ContCity: Text[100];
        Emp: Record 5200;
        Blagajna: text[50];
        BANKACC: Record "Bank Account";
        BankAdress: text[80];

        CZKNumber: text[50];
        GJL: Record "Gen. Journal Line";
        RedniBrojSpiska: Integer;
}