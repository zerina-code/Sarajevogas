report 50150 "SpendingPlan"
{
    // BH1.00, PLAN POTROSNJE
    DefaultLayout = RDLC;
    RDLCLayout = './SpendingPlan2.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {



        dataitem(DataItem2; "Installation History")
        {


            column(Measuring_Point_Adress; mmcODE1."Address MM") { }

            column(CompInfoName; CompInfo.Name) { }


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
            column(CustomerCode; DataItem2."Customer No.") { }
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
            column(ReportDate; FORMAT(Today, 0, '<Day,2>.<Month,2>.<Year4>.'))
            {

            }
            column(RespPerson; CompInfo."Spending Plan Responsible Person Name") { }
            column(RespPosition; CompInfo."Spending Plan Responsible Person Position") { }

            column(MMAddress; mmcODE1.Address) { }
            column(ZoneStroke; format(mmcODE1."Customer string")) { }
            column(CustomerStroke; formaT(Customer."Customer Stroke")) { }
            column(SerialNumber; DataItem2."Inventory Number") { }
            column(GaugeSize; gaugeSize) { }
            column(Phone; Customer."Phone No.") { }
            column(Year; Format(Year_int)) { }
            column(YearBefore; Format(Year_int - 1)) { }
            column(TwoYearsBefore; Format(Year_int - 2)) { }
            column(MonthName; MonthValue) { }

            /*  column(plan1; plan1) { }
              column(plan1Spent; plan1Spent) { }
              column(plan2; plan2) { }*/

            column(plan1; Plan_Month[1]) { }
            column(plan2; Plan_Month[2]) { }
            column(plan3; Plan_Month[3]) { }
            column(plan4; Plan_Month[4]) { }
            column(plan5; Plan_Month[5]) { }
            column(plan6; Plan_Month[6]) { }
            column(plan7; Plan_Month[7]) { }
            column(plan8; Plan_Month[8]) { }
            column(plan9; Plan_Month[9]) { }
            column(plan10; Plan_Month[10]) { }
            column(plan11; Plan_Month[11]) { }
            column(plan12; Plan_Month[12]) { }



            column(plan1_2; Plan2_Month[1]) { }
            column(plan2_2; Plan2_Month[2]) { }
            column(plan3_2; Plan2_Month[3]) { }
            column(plan4_2; Plan2_Month[4]) { }
            column(plan5_2; Plan2_Month[5]) { }
            column(plan6_2; Plan2_Month[6]) { }
            column(plan7_2; Plan2_Month[7]) { }
            column(plan8_2; Plan2_Month[8]) { }
            column(plan9_2; Plan2_Month[9]) { }
            column(plan10_2; Plan2_Month[10]) { }
            column(plan11_2; Plan2_Month[11]) { }
            column(plan12_2; Plan2_Month[12]) { }

            column(planR1; Realized_Month[1]) { }
            column(planR2; Realized_Month[2]) { }
            column(planR3; Realized_Month[3]) { }
            column(planR4; Realized_Month[4]) { }
            column(planR5; Realized_Month[5]) { }
            column(planR6; Realized_Month[6]) { }
            column(planR7; Realized_Month[7]) { }
            column(planR8; Realized_Month[8]) { }
            column(planR9; Realized_Month[9]) { }
            column(planR10; Realized_Month[10]) { }
            column(planR11; Realized_Month[11]) { }
            column(planR12; Realized_Month[12]) { }

            column(mmZoneStroke; mmcODE1."Zone stroke") { }
            column(MMCode; DataItem2."Measuring Point Code") { }
            column(mmCustomerStroke; Customer."Customer Stroke") { }
            column(MMName; mmcODE1.Description) { }
            column(Serial_Number_I; mmcODE1."Serial No.") { }
            column(Gauge_2; DataItem2.Code) { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                WageS: Record "Wage Setup";



            begin

                if (DataItem2."Measuring Point Code" = '') or (DataItem2."Customer No." = '') then
                    CurrReport.Skip();

                //dio koji se odnosi na mjerna mjesta
                mmcODE1.Reset();
                mmcODE1.SetFilter("No.", '%1', DataItem2."Measuring Point Code");
                mmcODE1.FindFirst();

                Customer.Get(DataItem2."Customer No.");

                Gauge.Reset();
                Gauge.SetFilter("Customer No.", '%1', Customer."No.");
                Gauge.SetFilter("Measuring Point", '%1', DataItem2."Measuring Point Code");
                Gauge.SetFilter("Code", '%1', DataItem2.Code);
                if Gauge.FindFirst() then begin
                    //    mmSerialNumber := Gauge."Inventar number";
                    gaugeSize := Gauge."Gauge Size";
                end;

                for myint := 1 to 12 do begin
                    Plan_Month[myInt] := 0;
                end;
                for myint := 1 to 12 do begin
                    Plan2_Month[myInt] := 0;
                end;

                for myInt := 1 to 12 do begin

                    if GeneratePlan = true then begin
                        AreaRec2.reset;
                        AreaRec2.setfilter("Type", '%1', DataItem2."Customer No.");
                        AreaRec2.setfilter("Year", '%1', Year_int);
                        AreaRec2.setfilter("Month", '%1', myInt);
                        if not AreaRec2.findfirst then begin
                            AreaRec.init;
                            AreaRec.Year := Year_int;
                            AreaRec.Month := myInt;
                            AreaRec."Category" := Customer."Customer Category";
                            AreaRec."Type" := DataItem2."Customer No.";
                            AreaRec."Internal Customer" := Customer."Internal Customer";
                            AreaRec.insert(true);

                        end;


                        commit;
                    end;



                    AreaR.Reset();
                    AreaR.SetFilter(Type, '%1', DataItem2."Customer No.");
                    AreaR.SetFilter(Month, '%1', myInt);
                    AreaR.SetFilter(Year, '%1', Year_int - 1);
                    if AreaR.FindFirst() then begin
                        AreaR.CalcSums(Amount);
                        Plan_Month[myInt] := AreaR.Amount;

                    end
                    else begin
                        Plan_Month[myInt] := 0;
                    end;
                end;

                for myInt := 1 to 12 do begin
                    AreaR.Reset();
                    AreaR.SetFilter(Type, '%1', DataItem2."Customer No.");
                    AreaR.SetFilter(Month, '%1', myInt);
                    AreaR.SetFilter(Year, '%1', Year_int - 2);
                    if AreaR.FindFirst() then begin
                        AreaR.CalcSums(Amount);
                        Plan2_Month[myInt] := AreaR.Amount;

                    end
                    else begin
                        Plan2_Month[myInt] := 0;
                    end;





                end;

                for myint := 1 to 12 do begin
                    Realized_Month[myInt] := 0;
                end;
                //plan 1:
                for myInt := 1 to 12 do begin
                    CJL.reset();
                    // sline.SetFilter("Document No.", '%1', mm1Spent."No.");
                    CJL.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    //  CJL.SetFilter("Month of Calculation", '%1', );
                    cjl.SetFilter("Year Of GAS Calculation", '%1', Year_int - 2);
                    cjl.SetFilter("Month Of GAS Calculation", '%1', myInt);
                    if CJL.FindFirst() then begin
                        CJL.CalcSums(SM3);

                        Realized_Month[myInt] := CJL.SM3;

                    end;

                end;










            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Active", '%1', true);
                SetFilter(Type, '%1', Type::Gauge);
                //SetFilter("Measuring Point Code", '<>%1', '');
                // SetFilter("Customer No.", '<>%1', '');
                //      SetFilter("Customer No.", '<>%1', '');
                //    SetFilter("Measuring Point Code", '<>%1', '');
                if SifraInitCust <> '' then
                    setfilteR("Customer No.", '%1', SifraInitCust);
                // MMInit := MM;

                if MMInit <> '' then
                    setfilteR("Measuring Point Code", '%1', MMInit);

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

                field(GeneratePlan; GeneratePlan)
                {
                    Caption = 'Generate Plan';
                }

                field(SendEmail; SendEmail)
                {
                    Caption = 'SendEmail';
                }

                field(MessageTemp; MessageTemp)
                {
                    Caption = 'Message Template';
                    TableRelation = Template_Message."Message Code";
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CalcFields(Picture);

    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        Year_int := Date2DMY(today, 3);

    end;

    trigger OnPostReport()
    var
        myInt: Integer;
        WageS: Record "Wage Setup";
    begin


        if SendEmail = true then begin
            if Confirm('Da li ste sigurni da želite poslati planove potrošnje kupcima koji se nalaze u ovom izvještaju?') then begin



                IH.Reset();
                IH.CopyFilters(DataItem2);

                if ih.FindSet() then
                    repeat
                        CLEAR(SpendingPlan);
                        CLEAR(FileManagement);
                        CLEAR(Mail);
                        SpendingPlan.SETTABLEVIEW(IH);



                        SpendingPlan.Setparam(ih."Customer No.", ih."Measuring Point Code");
                        Customer.get(ih."Customer No.");
                        Clear(Recipients);
                        CLEAR(FileManagement);
                        WageS.get;
                        //filename:='C:\Temp\PayList-'+T_Employee."First Name"+' '+T_Employee."Last Name"+'.pdf';
                        filename := WageS."Export Report Path" + ih."Customer No." + '_' + ih."Measuring Point Code" + '_' + format(Year_int) + '.pdf';
                        SpendingPlan.SAVEASPDF(filename);



                        FileManagement.DownloadToFile(filename, filename);

                        SMTPSetup.GET;
                        TempMessage.Reset();
                        TempMessage.SetFilter("Message Code", '%1', MessageTemp);
                        if TempMessage.FindFirst() then begin
                            TempMessage.CALCFIELDS("Message Text");
                            TempMessage."Message Text".CREATEINSTREAM(IStream);
                            TextMsg.READ(IStream);

                        end;


                        Recipients.Add(Customer."E-Mail 2");
                        SMTPMail.CreateMessage(TempMessage."Message Subject", TempMessage."E-mail sender", 'djemina.karalic@teneo.ba', ih."Customer No." + '_' + ih."Measuring Point Code" + '_' + format(Year_int), format(TextMsg), TRUE);

                        filename := WageS."Export Report Path" + ih."Customer No." + '_' + ih."Measuring Point Code" + '_' + format(Year_int) + '.pdf';

                        SMTPMail.AddAttachment(filename, 'Plan potrošnje za ' + ih."Customer No." + '_' + ih."Measuring Point Code" + '_' + format(Year_int) + '.pdf');


                        SMTPMail.Send();
                    until ih.Next() = 0;

            end;

        end;

    end;



    procedure Setparam(CustomerNo: code[20]; MM: code[20])
    var
        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
    begin
        SifraInitCust := CustomerNo;
        MMInit := MM;


    end;


    var
        CompInfo: Record "Company Information";

        Customer: Record Customer;
        TempMessage: Record Template_Message;
        filename: Text;
        IStream: InStream;
        SifraInitCust: code[20];
        MMInit: code[20];
        MM: Record "Service Item";
        TextMsg: BigText;
        mmcODE1: Record "Service Item";
        Gauge: Record Gauge;
        plan1: Decimal;
        GeneratePlan: boolean;
        plan1Spent: Decimal;
        AreaRec: record "Area";
        Recipients: List of [Text];
        IH: record "Installation History";
        SpendingPlan: Report "SpendingPlan";
        FileManagement: Codeunit "File Management";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit Mail;
        AreaRec2: record "Area";

        Plan_Month: array[12] of Integer;
        Realized_Month: array[12] of Integer;
        Plan2_Month: array[12] of Integer;
        plan2: Decimal;
        AreaR: Record "Area";
        SendEmail: Boolean;
        mmCode: Text;
        mmName: Text;
        mmAddress: Text;
        CJL: record "Calculation Journal Line";
        mmZoneStroke: Text;
        MessageTemp: code[20];
        mmSerialNumber: Text;
        mmCustomerStroke: Text;
        gaugeSize: Text;

        respPerson: Text;
        respPosition: Text;
        Year_int: Integer;

        MonthValue: enum Month;
        mm1Spent: Record "Sales Invoice Header";
        sline: Record "Sales Invoice Line";


}

