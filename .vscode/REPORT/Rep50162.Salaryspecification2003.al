report 50162 "Salary specification 2003"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Specifikacija plata - Obrazac 2003.rdl';
    Caption = 'Salary specification - Form 2003';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            column(CompanyName; Name)
            {
            }
            column(CompanyAdress; Address)
            {
            }
            column(JIB; "Registration No.")
            {
            }
            column(Municipiality; MunName)
            {
            }

            /*column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }*/
            column(IC; "Industrial Classification")
            {
            }
            column(Dio2_Bruto; Dio2_Bruto) { }
            column(Dio2_Porez; Dio2_Porez) { }
            column(Dio2_OsnovicazaPorez; Dio2_OsnovicazaPorez) { }
            column(Dio2_Doprinosi; Dio2_Doprinosi) { }
            column(Dio2_Kol12; Dio2_Kol12) { }
            column(Dio2_Kol15; Dio2_Kol15) { }

            column(Dio3_Bruto; Dio3_Bruto) { }
            column(Dio3_Porez; Dio3_Porez) { }
            column(Dio3_OsnovicazaPorez; Dio3_OsnovicazaPorez) { }
            column(Dio3_Doprinosi; Dio3_Doprinosi) { }
            column(Dio3_Kol12; Dio3_Kol12) { }
            column(Dio3_Kol15; Dio3_Kol15) { }

            column(Godina; IDYear) { }
            column(Mjesec; IDMonth) { }
            column(MjesecText; IDMonthText) { }
            column(Datum; TodayD) { }
            column(TotalZDR; TotalZDR) { }
            column(TotalPIO; TotalPIO) { }
            column(TotalPorez; TotalPorez) { }
            column(TotaUkupneObaveze; TotaUkupneObaveze) { }

            column(Dio2_ApprovedExpenditures; Dio2_ApprovedExpenditures) { }
            column(PaymentDate; FORMAT(PaymentDate, 0, 4)) { }
            column(PaymentDateText; PaymentDateText) { }
            column(Dio2_Dodatak; Dio2_Dodatak) { }

            trigger OnAfterGetRecord()
            var
                Mun: Record "Municipality";


            begin

                IF Mun.GET(DataItem1."Municipality Code", Mun.type::regular) THEN
                    MunName := Mun.Name
                ELSE
                    MunName := '';

                Dio2_Bruto := 0;
                Dio2_Porez := 0;
                Dio2_Doprinosi := 0;
                Dio2_ApprovedExpenditures := 0;


                Dio3_Bruto := 0;
                Dio3_Porez := 0;
                Dio3_Doprinosi := 0;

                TodayD := Today;
                IDMonthText := FormatMonth(IDMonth);

                // Dio 2 
                CalcDio2();

                // Dio 3 
                CalcDio3();

                TotalZDR := Dio2_Kol12 + Dio3_Kol12;
                TotalPIO := Dio2_Kol15 + Dio3_Kol15;
                TotalPorez := Dio2_Porez + Dio3_Porez;
                TotaUkupneObaveze := TotalZDR + TotalPIO + TotalPorez;

            end;





        }


    }



    requestpage
    {
        layout
        {
            area(content)
            {
                group("Datum")
                {
                    field(IDMonth; IDMonth)
                    {
                        Caption = 'Mjesec';
                        ApplicationArea = All;
                    }
                    field(IDYear; IDYear)
                    {
                        Caption = 'Godina';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            IDMonth := DATE2DMY(TODAY, 2);
            IDYear := DATE2DMY(TODAY, 3);
        end;
    }

    var
        IDMonth: Integer;
        IDYear: Integer;
        IDMonthText: Text[10];
        TodayD: Date;

        Dio2_Bruto: Decimal;
        Dio2_Porez: Decimal;
        Dio2_OsnovicazaPorez: Decimal;
        Dio2_Doprinosi: Decimal;
        Dio2_Kol12: Decimal;
        Dio2_Kol15: Decimal;
        Dio2_Dodatak: decimal;


        Dio3_Bruto: Decimal;
        Dio3_Porez: Decimal;
        Dio3_OsnovicazaPorez: Decimal;
        Dio3_Doprinosi: Decimal;
        Dio3_Kol12: Decimal;
        Dio3_Kol15: Decimal;

        MunName: Text[50];
        TotalZDR: Decimal;
        TotalPIO: Decimal;
        TotalPorez: Decimal;
        TotaUkupneObaveze: Decimal;
        Dio2_ApprovedExpenditures: Decimal;
        PaymentDate: Date;
        PaymentDateText: text;





    local procedure FormatMonth(M: Integer): Text[2]
    begin
        if M < 10 then
            exit('0' + Format(M))
        else
            exit(Format(M));
    end;

    local procedure CalcDio2()
    var
        Wage: Record "Wage Calculation";
        Emp: Record Employee;
        CPE: Record "Contribution Per Employee";
    begin
        Wage.Reset();
        Wage.SetRange("Month Of Wage", IDMonth);
        Wage.SetRange("Year of Wage", IDYear);
        Wage.SetFilter("Wage Calculation Type", '1|2');
        Wage.SetFilter("Contribution Category Code", '<>NO&<>OR&<>SK');

        if Wage.FindSet() then
            repeat
                if Emp.Get(Wage."Employee No.") then
                    if Emp."Temporary Contract Type" in [1, 2, 4] then begin
                        Dio2_Bruto += Wage.Brutto;
                        Dio2_Porez += ROUND(Wage.Tax, 0.01);
                        Dio2_OsnovicazaPorez += ROUND(Wage."Tax Basis", 0.01);
                        Dio2_Doprinosi += Wage."Contribution From Brutto";
                        Dio2_ApprovedExpenditures += Wage."Approved Expenditures";
                        Dio2_Dodatak += Wage.Brutto - Wage."Approved Expenditures";
                        PaymentDate := Wage."Payment Date";
                        PaymentDateText := FormatDateOnly(PaymentDate);
                        CPE.Reset();
                        CPE.SETFILTER("Wage Header No.", '%1', Wage."Wage Header No.");
                        CPE.SETFILTER("Employee No.", '%1', Emp."No.");
                        CPE.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                        CPE.SETFILTER("Payment Date", '%1', Wage."Payment Date");
                        CPE.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');

                        //   CPE.CalcSums("Amount From Wage");
                        //  Dio2_Kol12 := ROUND(CPE."Amount From Wage", 0.01);
                        IF CPE.FIND('-')
                          THEN
                            REPEAT
                                Dio2_Kol12 += ROUND(CPE."Amount From Wage", 0.01);

                            UNTIL CPE.NEXT = 0;
                        CPE.Reset();
                        CPE.SETFILTER("Wage Header No.", '%1', Wage."Wage Header No.");
                        CPE.SETFILTER("Employee No.", '%1', Emp."No.");
                        CPE.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                        CPE.SETFILTER("Payment Date", '%1', Wage."Payment Date");
                        CPE.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');
                        //  CPE.CalcSums("Amount Over Wage");
                        //   Dio2_Kol15 := ROUND(CPE."Amount Over Wage", 0.01);
                        IF CPE.FIND('-')
                        THEN
                            REPEAT
                                Dio2_Kol15 += ROUND(CPE."Amount Over Wage", 0.01);
                            UNTIL CPE.NEXT = 0;


                    end;
            until Wage.Next() = 0;
    end;

    local procedure CalcDio3()
    var
        Wage: Record "Wage Calculation";
        Emp: Record Employee;
        CPE: Record "Contribution Per Employee";
    begin
        Wage.Reset();
        Wage.SetRange("Month Of Wage", IDMonth);
        Wage.SetRange("Year of Wage", IDYear);
        Wage.SetFilter("Wage Calculation Type", '1|2');
        Wage.SetFilter("Contribution Category Code", 'NO|OR|SK');

        if Wage.FindSet() then
            repeat
                if Emp.Get(Wage."Employee No.") then
                    if Emp."Temporary Contract Type" in [1, 2] then begin
                        Dio3_Bruto += Wage.Brutto;
                        Dio3_Porez += ROUND(Wage.Tax, 0.01);
                        Dio3_OsnovicazaPorez += ROUND(Wage."Tax Basis", 0.01);
                        Dio3_Doprinosi += Wage."Contribution From Brutto";
                        CPE.Reset();
                        CPE.SETFILTER("Wage Header No.", '%1', Wage."Wage Header No.");
                        CPE.SETFILTER("Employee No.", '%1', Emp."No.");
                        CPE.SETFILTER("Payment Date", '%1', Wage."Payment Date");
                        CPE.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                        CPE.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                        //    CPE.CalcSums("Amount From Wage");
                        //   Dio3_Kol12 := ROUND(CPE."Amount From Wage", 0.01);
                        IF CPE.FIND('-')
                        THEN
                            REPEAT
                                Dio3_Kol12 += ROUND(CPE."Amount From Wage", 0.01);
                            UNTIL CPE.NEXT = 0;
                        CPE.Reset();
                        CPE.SETFILTER("Wage Header No.", '%1', Wage."Wage Header No.");
                        CPE.SETFILTER("Employee No.", '%1', Emp."No.");
                        CPE.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                        CPE.SETFILTER("Payment Date", '%1', Wage."Payment Date");
                        CPE.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');
                        //  CPE.CalcSums("Amount Over Wage");
                        // Dio3_Kol15 := ROUND(CPE."Amount Over Wage", 0.01);
                        IF CPE.FIND('-')
                         THEN
                            REPEAT
                                Dio3_Kol15 += ROUND(CPE."Amount Over Wage", 0.01);
                            UNTIL CPE.NEXT = 0;


                    end;
            until Wage.Next() = 0;
    end;




    local procedure FormatDateOnly(D: Date): Text[10]
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        Day := DATE2DMY(D, 1);
        Month := DATE2DMY(D, 2);
        Year := DATE2DMY(D, 3);

        exit(
            PadZero(Day) + '.' +
            PadZero(Month) + '.' +
            Format(Year)
        );
    end;

    local procedure PadZero(N: Integer): Text[2]
    begin
        if N < 10 then
            exit('0' + Format(N))
        else
            exit(Format(N));
    end;
}



