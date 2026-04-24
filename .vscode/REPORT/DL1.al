report 50025 DL1
{
    DefaultLayout = RDLC;
    RDLCLayout = './DL1.rdl';

    dataset
    {
        dataitem(Employee2; "Employee")
        {
            column(MjesecPoreza; IDMonth)
            {
            }
            column(IDMonthText; IDMonthText2)
            {
            }
            column(IDMonthText2; IDMonthText2)
            {
            }
            column(IDDayText; IDDayText)
            {
            }
            column(GodinaPoreza; IDYear)
            {
            }
            column(TodayDay; TodayDay)
            {
            }
            column(TodayMonth; TodayMonth)
            {
            }
            column(TodayYear; TodayYear)
            {
            }
            column(InputDate; InputDate)
            {
            }
            column(CompanyEmail; CompInfo."E-Mail")
            {
            }
            column(CompanyMunicipalityCode2; CompInfo."Municipality Code")
            {
            }
            column(MunicipalityName; CompInfo."Municipality Name")
            {
            }
            dataitem(DataItem14; "Wage Calculation")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                column(Period; Period)
                {
                }
                column(MjesecPlateWC; "Month Of Wage")
                {
                }
                column(GodinaPlateWC; "Year of Wage")
                {
                }
                column(BrojObracuna; "No.")
                {
                }
                column(BrojZaposlenikaWC; "Employee No.")
                {
                }
                column(MjesecObracuna; FORMAT("Payment Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(UnpaidHours; "Unpaid Absence Hours")
                {
                }
                column(BrojRadnihSati; Hours)
                {
                }
                column(FirstName; "First Name")
                {
                }
                column(LastName; "Last Name")
                {
                }
                column(WageEmployeeNo; "Employee No.")
                {
                }
                column(DepMun; "Department Municipality")
                {
                }
                column(TaxDeductions; "Tax Deductions")
                {
                }
                column(Brojac; Brojac)
                {
                }
                column(BrojZaposlenika; "Employee No.")
                {
                }
                column(JMB; EmployeeID)
                {
                }
                column(RedniBr; "Month Of Wage")
                {
                }
                column(EmployeeFirstName; EmployeeFirstName)
                {
                }
                column(EmployeeLastName; EmployeeLastName)
                {
                }
                column(PositionCode; PositionCode)
                {
                }
                column(Coef; Coef)
                {
                }
                column(EmployeeNo; EmployeeNo)
                {
                }
                column(EmployeeID; t_Empl."Employee ID")
                {
                }
                column(HoursInDay; t_Empl."Hours In Day")
                {
                }
                column(Brutto; Brutto)
                {
                }
                column(SatiNaBolovanju; SickHourPool)
                {
                }
                column(sumPIO; sumPIO)
                {
                }
                column(sumZO; sumZO)
                {
                }
                column(sumDZ; sumDZ)
                {
                }
                column(sumZN; sumZN)
                {
                }
                column(Base; Basis + BruttoAdd)
                {
                }
                column(ZO; ZOAmount)
                {
                }
                column(PIO; PIOAmount)
                {
                }
                column(DZ; DZAmount)
                {
                }
                column(ZN; ZNAmount)
                {
                }
                column(Tax; ((Basis + BruttoAdd) - (sumZN + sumPIO + sumZO + sumDZ)) - (Tax + TaxAdd))
                {
                }
                column(BaseSum; BaseSum)
                {
                }
                column(ZOSum; ZOSum)
                {
                }
                column(SumTotal; SumTotal)
                {
                }
                column(ZNSum; ZNSum)
                {
                }
                column(HoursSum; HoursSum)
                {
                }
                column(TotalZN; TotalZN)
                {
                }
                column(PIOSum; PIOSum)
                {
                }
                column(AmountFromBrutto; ZNSum)
                {
                }
                column(TotalHours; TotalHours)
                {
                }
                column(Total; Total)
                {
                }
                column(TaxTotal; TaxTotal)
                {
                }
                column(MunicipalityCIPS; MunicipalityCIPS)
                {
                }
                column(MunName; MunName)
                {
                }
                column(CompanyJIB2; CompanyJIB)
                {
                }
                column(Kol12; "Tax Deductions")
                {
                }
                column(Kol13; Kol13)
                {
                }
                column(Kol14; Kol14)
                {
                }
                column(Kol16; "Tax Basis" + TaxBasisAdd)
                {
                }
                column(Kol17; Tax + TaxAdd)
                {
                }
                column(Kol19_1; Kol19_1)
                {
                }
                column(SumKol15; SumKol15)
                {
                }
                column(SumKol12; SumKol12)
                {
                }
                column(SumKol13; SumKol13)
                {
                }
                column(SumKol14; SumKol14)
                {
                }
                column(SumKol16; SumKol17)
                {
                }
                column(SumKol17; SumKol16)
                {
                }
                column(SumKol19; SumKol19)
                {
                }
                column(Kol15; Kol15)
                {
                }
                column(DZSum; DZSum)
                {
                }
                column(CompanyName; CompanyName2)
                {
                }
                column(CompanyAddress; CompanyAddress)
                {
                }
                column(CompanyPhone; CompanyPhone)
                {
                }
                column(CompanyCity; CompanyCity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Start2 := Fill.GetMonthRange("Month Of Wage", IDYear, TRUE);
                    End2 := Fill.GetMonthRange("Month Of Wage", IDYear, FALSE);

                    SETRANGE("Year of Wage", IDYear);
                    Employee.SETFILTER("No.", '%1', "Employee No.");
                    IF Employee.FIND('-') THEN BEGIN
                        REPEAT
                            Basis := "Brutto";
                            Hours := "Individual Hour Pool";


                            EmployeeID := Employee."Employee ID";
                            EmployeeFirstName := Employee."First Name";
                            EmployeeLastName := Employee."Last Name";
                            MunicipalityCIPS := Employee."Municipality Code for salary";

                            //"Wage Calculation".CALCSUMS(Brutto);//AA
                            CALCSUMS("Hour Pool");
                        UNTIL Employee.NEXT = 0;
                    END;



                    //BaseSum:=0;//AA
                    SumKol12 := 0;//AA
                    ZOSum := 0;
                    PIOSum := 0;
                    DZSum := 0;
                    ZNSum := 0;
                    SumKol16 := 0;
                    SumKol17 := 0;

                    CompanyJIB := '';
                    ECL2.RESET;
                    ECL2.SETFILTER("Starting Date", '<=%1', End2);
                    ECL2.SETFILTER("Report Ending Date", '>=%1', Start2);
                    ECL2.SETFILTER("Show Record", '%1', TRUE);
                    ECL2.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL2.SETCURRENTKEY("Starting Date");
                    IF ECL2.FINDFIRST THEN
                        REPEAT
                            ECL2.CALCFIELDS("Municipality Code for salary");
                            Mun.SETFILTER(Code, ECL2."Municipality Code for salary");
                            IF Mun.FINDFIRST THEN BEGIN
                                MunName := Mun.Name;
                                OrgDijelovi2.RESET;
                                OrgDijelovi2.SETFILTER("Municipality Code for salary", '%1', ECL2."Municipality Code for salary");
                                IF ECL2."Org Dio" <> '' THEN
                                    OrgDijelovi2.SETFILTER(Code, '%1', ECL2."Org Dio");
                                OrgDijelovi2.SETFILTER(GF, '%1', ECL2."GF rada code");
                                IF OrgDijelovi2.FINDFIRST THEN
                                    CompanyJIB := OrgDijelovi2."JIB Contributes";
                                CompanyName2 := OrgDijelovi2.Description;
                                CompanyAddress := OrgDijelovi2.Address;
                                CompanyCity := OrgDijelovi2.City;
                            END;

                            // CompanyPhone:=OrgDijelovi2.P;
                            WH.RESET;
                            WH.SETFILTER("Closing Date", '%1..%2', Start2, End2);
                            IF WH.FINDFIRST THEN
                                WCJIB.SETFILTER("Wage Header No.", '%1', WH."No.")
                            ELSE
                                ERROR('Zadani mjesec ne postoji u rangu');
                            WCJIB.SETFILTER("Employee No.", '%1', Employee."No.");
                            WCJIB.SETFILTER("Org Jed", '%1', '');
                            IF WCJIB.FINDFIRST THEN
                                REPEAT
                                    WCJIB."Org Jed" := OrgDijelovi2."JIB Contributes";
                                    WCJIB.MODIFY(TRUE);
                                UNTIL WCJIB.NEXT = 0;

                            WH.RESET;
                            WH.SETFILTER("Closing Date", '%1..%2', Start2, End2);
                            IF WH.FINDFIRST THEN
                                CPEJIB.SETFILTER("Wage Header No.", '%1', WH."No.")
                            ELSE
                                ERROR('Zadani mjesec ne postoji u rangu');
                            CPEJIB.SETFILTER("Employee No.", '%1', Employee."No.");
                            CPEJIB.SETFILTER("JIB Contributes DL", '%1', '');
                            IF CPEJIB.FINDFIRST THEN
                                REPEAT
                                    CPEJIB."JIB Contributes DL" := OrgDijelovi2."JIB Contributes";
                                    CPEJIB.MODIFY(TRUE);
                                UNTIL CPEJIB.NEXT = 0;

                            WH.RESET;
                            WH.SETFILTER("Closing Date", '%1..%2', Start2, End2);
                            IF WH.FINDFIRST THEN
                                TPEJIB.SETFILTER("Wage Header No.", '%1', WH."No.")
                            ELSE
                                ERROR('Zadani mjesec ne postoji u rangu');
                            TPEJIB.SETFILTER("Employee No.", '%1', Employee."No.");
                            TPEJIB.SETFILTER("JIB Contributes DL", '%1', '');
                            IF TPEJIB.FINDFIRST THEN
                                REPEAT
                                    TPEJIB."JIB Contributes DL" := OrgDijelovi2."JIB Contributes";//AA
                                    TPEJIB.MODIFY(TRUE);
                                UNTIL TPEJIB.NEXT = 0;
                        UNTIL ECL2.NEXT = 0;



                    CompanyJIB := "Org Jed";
                    IF CompanyJIB = '' THEN
                        CurrReport.SKIP; //oo

                    t_ContrEmp4.RESET;//AA
                    WH.RESET;
                    WH.SETRANGE("Year Of Wage", IDYear);
                    IF WH.FINDFIRST THEN
                        REPEAT
                            t_ContrEmp4.RESET;//AA
                            t_ContrEmp4.SETFILTER("Wage Header No.", '%1', WH."No.");
                            t_ContrEmp4.SETFILTER("JIB Contributes DL", '%1', OrgDijelovi2."JIB Contributes");// OO OrgDijelovi2."JIB Contributes"
                            t_ContrEmp4.SETFILTER("Contribution Code", '%1', 'D-ZAPO*');
                            t_ContrEmp4.SETFILTER("Employee No.", '%1', "Employee No.");
                            IF t_ContrEmp4.FINDFIRST THEN BEGIN
                                t_ContrEmp4.CALCSUMS("Amount From Wage");
                                ZNSum += t_ContrEmp4."Amount From Wage";
                            END;
                        UNTIL WH.NEXT = 0;

                    t_ContrEmp5.RESET;
                    WH.RESET;
                    WH.SETRANGE("Year Of Wage", IDYear);
                    IF WH.FINDFIRST THEN
                        REPEAT
                            t_ContrEmp5.SETFILTER("Wage Header No.", '%1', WH."No.");
                            t_ContrEmp5.SETFILTER("JIB Contributes DL", '%1', OrgDijelovi2."JIB Contributes"); // OO  OrgDijelovi2."JIB Contributes"
                            t_ContrEmp5.SETFILTER("Contribution Code", '%1', 'D-ZDRAVRS');
                            t_ContrEmp5.SETFILTER("Employee No.", '%1', "Employee No.");
                            IF t_ContrEmp5.FINDSET THEN BEGIN

                                t_ContrEmp5.CALCSUMS("Amount From Wage");
                                ZOSum += t_ContrEmp5."Amount From Wage";
                            END;
                        UNTIL WH.NEXT = 0;


                    t_ContrEmp6.RESET;
                    WH.RESET;
                    WH.SETRANGE("Year Of Wage", IDYear);
                    IF WH.FINDFIRST THEN
                        REPEAT
                            t_ContrEmp6.SETFILTER("Wage Header No.", '%1', WH."No.");
                            t_ContrEmp6.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                            t_ContrEmp6.SETFILTER("JIB Contributes DL", '%1', OrgDijelovi2."JIB Contributes");// OO OrgDijelovi2."JIB Contributes"
                            t_ContrEmp6.SETFILTER("Employee No.", '%1', "Employee No.");
                            IF t_ContrEmp6.FINDSET THEN BEGIN
                                t_ContrEmp6.CALCSUMS("Amount From Wage");
                                DZSum += t_ContrEmp6."Amount From Wage";
                            END;
                        UNTIL WH.NEXT = 0;

                    t_ContrEmp7.RESET;

                    WH.RESET;
                    WH.SETRANGE("Year Of Wage", IDYear);
                    IF WH.FINDFIRST THEN
                        REPEAT
                            t_ContrEmp7.SETFILTER("Wage Header No.", '%1', WH."No.");
                            t_ContrEmp7.SETFILTER("Contribution Code", '%1', 'D-PIORS');
                            t_ContrEmp7.SETFILTER("JIB Contributes DL", '%1', OrgDijelovi2."JIB Contributes");// OO OrgDijelovi2."JIB Contributes"
                            t_ContrEmp7.SETFILTER("Employee No.", '%1', "Employee No.");
                            IF t_ContrEmp7.FINDFIRST THEN BEGIN
                                t_ContrEmp7.CALCSUMS("Amount From Wage");
                                PIOSum += t_ContrEmp7."Amount From Wage";
                            END;

                        UNTIL WH.NEXT = 0;


                    t_tax.RESET;
                    WH.RESET;
                    WH.SETRANGE("Year Of Wage", IDYear);
                    IF WH.FINDFIRST THEN
                        REPEAT
                            t_tax.SETFILTER("Wage Header No.", '%1', WH."No.");
                            t_tax.SETFILTER("JIB Contributes DL", '%1', OrgDijelovi2."JIB Contributes");// OO OrgDijelovi2."JIB Contributes"
                            t_tax.SETFILTER("Contribution Category Code", '%1', '@*RS*');
                            t_tax.SETFILTER("Employee No.", '%1', "Employee No.");
                            IF t_tax.FINDSET THEN BEGIN
                                t_tax.CALCSUMS(Amount);
                                SumKol16 += t_tax.Amount;
                                SumKol17 += t_tax.Amount / 0.1;
                            END;
                        UNTIL WH.NEXT = 0;

                    //AA
                    BaseSum := 0;
                    wc2.RESET;
                    WH.RESET;
                    WH.SETRANGE("Year Of Wage", IDYear);
                    IF WH.FINDFIRST THEN
                        REPEAT
                            wc2.SETFILTER("Wage Header No.", '%1', WH."No.");
                            wc2.SETFILTER("Org Jed", '%1', OrgDijelovi2."JIB Contributes");// OO  OrgDijelovi2."JIB Contributes"
                            wc2.SETFILTER("Employee No.", '%1', "Employee No.");
                            wc2.SETFILTER("Contribution Category Code", '%1', '@*RS*');
                            wc2.SETRANGE("Department Municipality", Mun.Code);


                            IF wc2.FINDSET THEN BEGIN

                                Period := wc2."Payment Date";
                                BaseSum += wc2.Brutto;
                                wc2.CALCSUMS("Tax Deductions");
                                SumKol12 += wc2."Tax Deductions";
                                //AA
                                //Dodaci za bruto
                                WVE.RESET;
                                //WH.RESET;
                                //WH.SETRANGE("Year Of Wage",IDYear);

                                WVE.SETFILTER("Document No.", '%1', wc2."Wage Header No."); // WH."No."
                                WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                                WVE.SETFILTER("Employee No.", '%1', "Employee No.");
                                WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                                WVE.SETFILTER("Global Dimension 1 Code", '%1', wc2."Global Dimension 1 Code");
                                // WVE.SETFILTER("Contribution Category Code",'%1', '@*RS*');
                                IF WVE.FINDSET THEN BEGIN

                                    WVE.CALCSUMS("Cost Amount (Brutto)");
                                    BaseSum += WVE."Cost Amount (Brutto)";

                                END;

                                //AA Dodaci za bruto

                            END;


                        UNTIL WH.NEXT = 0;//AA



                    //  wc2.SETRANGE("Month Of Wage",IDMonth);
                    wc2.SETRANGE("Year of Wage", IDYear);
                    wc2.SETRANGE("Department Municipality", Mun.Code);

                    wc2.CALCSUMS("Hour Pool");

                    //wc2.CALCSUMS("Tax Deductions");//AA
                    //wc2.CALCSUMS("Brutto");//AA
                    //BaseSum:=wc2.Brutto;//AA BaseSum+=wc2.Brutto;
                    TotalHours := wc2."Hour Pool";
                    // SumKol12:=wc2."Tax Deductions";//AA
                    //NK END;

                    BruttoAdd := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;

                    //*******************************************Additions****************************************//
                    WVE.RESET;
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            BruttoAdd += WVE."Cost Amount (Brutto)";
                            //    BaseSum+=BruttoAdd;//AA
                            NettoAdd += WVE."Cost Amount (Netto)";

                        UNTIL WVE.NEXT = 0;
                    WVET.RESET;
                    WVET.SETFILTER("Document No.", "Wage Header No.");
                    WVET.SETFILTER("Employee No.", "Employee No.");
                    WVET.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVET.SETFILTER("Entry Type", '%1', WVET."Entry Type"::Tax);
                    IF WVET.FIND('-') THEN
                        REPEAT
                            TaxAdd := TaxAdd + WVET."Cost Amount (Netto)";
                            TaxBasisAdd += (WVET."Cost Amount (Netto)" / 0.1);
                        UNTIL WVET.NEXT = 0;

                    //*******************************************Additions****************************************//




                    wc3.RESET;
                    //   wc3.SETRANGE("Month Of Wage",IDMonth);
                    wc3.SETRANGE("Year of Wage", IDYear);
                    wc3.SETFILTER("Municipality CIPS", "Municipality CIPS");
                    IF wc3.FINDFIRST THEN BEGIN
                        REPEAT
                            Brojac := wc3.COUNT;
                        UNTIL wc3.NEXT = 0;
                    END;

                    sumZO := 0;
                    t_ContrEmp.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp.SETFILTER("Employee No.", '%1', "Employee No.");


                    t_ContrEmp.SETFILTER("Contribution Code", '%1', 'D-ZDRAVRS');
                    IF t_ContrEmp.FINDFIRST THEN
                        REPEAT
                            sumZO += t_ContrEmp."Amount From Wage";
                        UNTIL t_ContrEmp.NEXT = 0;

                    sumZN := 0;
                    t_ContrEmp1.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp1.SETFILTER("Employee No.", '%1', "Employee No.");

                    t_ContrEmp1.SETFILTER("Contribution Code", '%1', 'D-ZAPO*');
                    IF t_ContrEmp1.FINDFIRST THEN
                        REPEAT
                            sumZN += t_ContrEmp1."Amount From Wage";
                        UNTIL t_ContrEmp1.NEXT = 0;

                    sumPIO := 0;
                    t_ContrEmp2.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp2.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp2.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp2.SETFILTER("Contribution Code", '%1', 'D-PIORS');
                    IF t_ContrEmp2.FINDFIRST THEN
                        REPEAT
                            sumPIO += t_ContrEmp2."Amount From Wage";
                        UNTIL t_ContrEmp2.NEXT = 0;

                    sumDZ := 0;
                    t_ContrEmp3.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp3.SETFILTER("Employee No.", '%1', "Employee No.");
                    //      t_ContrEmp3.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp3.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                    IF t_ContrEmp3.FINDFIRST THEN
                        REPEAT
                            sumDZ += t_ContrEmp3."Amount From Wage";
                        UNTIL t_ContrEmp3.NEXT = 0;






                    Total := DZSum + ZNSum + PIOSum + ZOSum;
                    SumTotal := sumDZ + sumZN + sumPIO + sumZO;

                    TaxClass.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass.FINDFIRST THEN BEGIN
                        Amount := (Basis - SumTotal) - (((Basis - SumTotal) * TaxClass.Percentage) / 100);
                        TaxTotal := (BaseSum - Total) - (((BaseSum - Total) * TaxClass.Percentage) / 100);
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    BEGIN
                        SETRANGE("Year of Wage", IDYear);
                        //   "Wage Calculation".SETRANGE("Department Municipality",'074-RS');

                    END;
                    SickHourPool := 0;

                    SETFILTER("Contribution Category Code", '%1', '@*RS*');
                    Brojac := 0;
                end;
            }

            trigger OnPreDataItem()
            var
                OrgDijelovi: Record "ORG Dijelovi";
                OrgDijeloviTemp: Record "ORG Dijelovi";
            begin
                CompInfo.GET;


                InputDate := TODAY;
                BEGIN
                    TodayDay := DATE2DMY(InputDate, 1);
                    TodayMonth := DATE2DMY(InputDate, 2);
                    TodayYear := DATE2DMY(InputDate, 3);
                END;
                IF TodayDay < 10 THEN
                    IDDayText := '0' + FORMAT(TodayDay)
                ELSE
                    IDDayText := FORMAT(TodayDay);

                IF TodayMonth < 10 THEN
                    IDMonthText2 := '0' + FORMAT(TodayMonth)
                ELSE
                    IDMonthText2 := FORMAT(TodayMonth);
                BaseSum := 0;

                Emp.RESET;
                Emp.SETFILTER("Org Entity Code", '%1', '@*RS*');
                Emp.SETFILTER("Entity Code CIPS", '%1', '@*RS*');
                Emp.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
                IF Emp.FIND('-') THEN
                    REPEAT

                        OrgDijeloviTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                        OrgDijeloviTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                        OrgDijeloviTemp.SETFILTER(GF, '%1', Emp.GF);
                        IF NOT OrgDijeloviTemp.FINDFIRST THEN BEGIN
                            OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijelovi.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijelovi.SETFILTER(GF, '%1', Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                                OrgDijeloviTemp.INIT;
                                OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi, TRUE);
                                OrgDijeloviTemp.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp.MODIFY;

                    UNTIL Emp.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Month and year';
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
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
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        BEGIN
            IDMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
            IDYear := DATE2DMY(CALCDATE('-1G', WORKDATE), 3);
        END;
        EVALUATE(Godina, FORMAT(IDYear));
        StartDate := '1.1.' + Godina;
        EndDate := '31.12.' + Godina;
        EVALUATE(StartDated, StartDate);
        EVALUATE(EndDated, EndDate);
    end;

    trigger OnPreReport()
    begin
        //Brojac :=0;
        CompInfo.GET;
        SumTotal := 0;
    end;

    var
        Period: Date;
        WageAdition: Record "Wage Addition";
        StartDate: Text;
        EndDate: Text;
        StartDated: Date;
        EndDated: Date;
        ECL2: Record "Employee Contract Ledger";
        End2: Date;
        Start2: Date;
        Fill: Codeunit "Absence Fill";
        t_tax: Record "Tax Per Employee";
        TPEJIB: Record "Tax Per Employee";
        CPEJIB: Record "Contribution Per Employee";
        TaxBasisAdd: Decimal;
        TaxAdd: Decimal;
        BruttoAdd: Decimal;
        NettoAdd: Decimal;
        WVE: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        WVEC: Record "Wage Value Entry";
        CompanyName2: Text;
        CompanyCity: Text;
        CompanyPhone: Text;
        CompanyAddress: Text;
        Kol13: Decimal;
        Kol14: Decimal;
        Kol12: Decimal;
        Kol15: Decimal;
        Kol16: Decimal;
        Kol17: Decimal;
        Kol19_1: Decimal;
        SumKol13: Decimal;
        SumKol14: Decimal;
        SumKol12: Decimal;
        SumKol15: Decimal;
        SumKol16: Decimal;
        SumKol17: Decimal;
        SumKol19: Decimal;
        OrgDijelovi2: Record "ORG Dijelovi";
        CompanyJIB: Code[14];
        Hours: Decimal;
        ATPercent: Decimal;
        AddTaxesPercentage: Decimal;
        ATCCon: Record "Contribution Category Conn.";
        AddTaxes: Record "Contribution";
        IDMonth: Integer;
        IDMonthText: Text[10];
        IDMonthText2: Text;
        IDMjesecPlateText: Integer;
        IDDayText: Text;
        IDYear: Integer;
        IDDay: Integer;
        InputDate: Date;
        Brojac: Integer;
        t_Empl: Record "Employee";
        sumPIO: Decimal;
        sumZO: Decimal;
        sumDZ: Decimal;
        sumZN: Decimal;
        CompInfo: Record "Company Information";
        EmployeeFirstName: Text;
        EmployeeLastName: Text;
        EmployeeNo: Integer;
        EmployeeID: Code[13];
        Employee: Record "Employee";
        TodayDay: Integer;
        TodayMonth: Integer;
        TodayYear: Integer;
        SickHourPool: Decimal;
        CPE: Record "Contribution Per Employee";
        t_ContrEmp: Record "Contribution Per Employee";
        t_ContrEmp1: Record "Contribution Per Employee";
        t_ContrEmp2: Record "Contribution Per Employee";
        t_ContrEmp3: Record "Contribution Per Employee";
        TotalPIO: Decimal;
        TotalZO: Decimal;
        TotalDZ: Decimal;
        TotalZN: Decimal;
        CompEmployee: Record "Employee";
        CompEmpFirstName: Text;
        CompEmpLastName: Text;
        CompEmpID: Text;
        PositionCode: Code[10];
        Coef: Decimal;
        PositionRS: Record "Position";
        EmpNumber: Integer;
        Municipality: Record "Municipality";
        "Municipality Name": Text;
        ContributionCategory: Record "Contribution Category Conn.";
        Basis: Decimal;
        Contribution: Record "Contribution Category Conn.";
        ZOAmount: Decimal;
        Contribution1: Record "Contribution Category Conn.";
        PIOAmount: Decimal;
        Contribution2: Record "Contribution Category Conn.";
        DZAmount: Decimal;
        Contribution3: Record "Contribution Category Conn.";
        ZNAmount: Decimal;
        TaxClass: Record "Tax Class";
        DZSum: Decimal;
        Amount: Decimal;
        Total: Decimal;
        BaseSum: Decimal;
        ZOSum: Decimal;
        SumTotal: Decimal;
        ZNSum: Decimal;
        HoursSum: Decimal;
        SumBasis: Decimal;
        PIOSum: Decimal;
        CPETemp: Record "Contribution Per Employee Temp";
        CPETemp2: Record "Contribution Per Employee Temp";
        TotalHours: Decimal;
        Emp: Record "Employee";
        wc: Record "Wage Calculation";
        DZSum2: Decimal;
        TaxTotal: Decimal;
        DepMunicipality: Code[10];
        EmployeeContractLedger: Record "Employee Contract Ledger";
        wc2: Record "Wage Calculation";
        wc3: Record "Wage Calculation";
        MunicipalityCIPS: Code[10];
        Mun: Record "Municipality";
        MunName: Text;
        t_ContrEmp5: Record "Contribution Per Employee";
        t_ContrEmp6: Record "Contribution Per Employee";
        t_ContrEmp7: Record "Contribution Per Employee";
        t_ContrEmp4: Record "Contribution Per Employee";
        Godina: Text;
        WH: Record "Wage Header";
        WHRange: Text[150];
        WCJIB: Record "Wage Calculation";


    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    begin

        Percentage := 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(Employee."Contribution Category Code", AddTaxes.Code) THEN
                    IF ATCCon."Calculated in Total Brutto" THEN
                        Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;
}

