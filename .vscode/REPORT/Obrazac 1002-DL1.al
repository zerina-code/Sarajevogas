report 50042 "Obrazac 1002-DL1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Obrazac 1002-DL1.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {

            column(MjesecPoreza; IDMonth)
            {
            }
            column(IDMonthText; IDMonthText)
            {
            }
            column(Prikazi; Prikazi)
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
            column(Kraj; Kraj)
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
            column(VrstaPrihoda; VrstaPrihoda)
            {

            }
            column(VrstaPrihoda1; VrstaPrihoda1)
            {

            }
            column(VrstaPrihoda2; VrstaPrihoda2)
            {

            }
            column(VrstaPrihoda3; VrstaPrihoda3)
            {

            }
            column(VrstaPrihoda4; VrstaPrihoda4)
            {

            }
            column(VrstaPrihoda5; VrstaPrihoda5)
            {

            }
            column(VrstaPrihoda6; VrstaPrihoda6)
            {

            }
            column(IznosPrihoda1; IznosPrihoda1)
            {

            }
            column(IznosPrihoda2; IznosPrihoda2)
            {

            }
            column(IznosPrihoda3; IznosPrihoda3)
            {

            }

            column(IznosPrihoda4; IznosPrihoda4)
            {

            }

            column(IznosPrihoda5; IznosPrihoda5)
            {

            }

            column(IznosPrihoda6; IznosPrihoda6)
            {

            }




            dataitem(DataItem14; "Wage Calculation")
            {
                RequestFilterFields = "Municipality CIPS";
                column(MjesecPlateWC; "Month Of Wage")
                {
                }
                column(MinTax; MinTax)
                {

                }
                column(Sum50; Sum50)
                {

                }
                column(SumKol50; SumKol50)
                {

                }
                column(GodinaPlateWC; "Year of Wage")
                {
                }
                column(BrojObracuna; "No.")
                {
                }
                column(tipObracuna; "Wage Calculation Type")
                {

                }
                column(BrojZaposlenikaWC; "Employee No.")
                {
                }
                column(MjesecObracuna; "Payment Date")
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
                column(BrojZaposlenika; t_Empl."No.")
                {
                }
                column(JMB; EmployeeID)
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
                column(sumZO1; sumZO1)
                {

                }
                column(sumZN1; sumZN1)
                {

                }
                column(ZN; ZNAmount)
                {
                }
                column(Tax; Amount)
                {
                }
                column(BaseSum; BaseSum)
                {
                }
                column(Kol16_2; Kol16_2)
                {

                }
                column(ZOSum; ZOSum)
                {
                }
                column(ZoSumBez; ZoSumBez)
                {

                }
                column(SumTotal; SumTotal)
                {
                }
                column(ZNSum; ZNSum)
                {
                }

                column(ZnSumbez; ZnSumbez)
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
                column(Sum1; Sum1)
                {

                }
                column(Sum2; Sum2)
                {

                }
                column(Sum3; Sum3)
                {

                }
                column(Sum4; Sum4)
                {

                }
                column(Sum5; Sum5)
                {

                }
                column(Sum6; Sum6)
                {

                }
                column(Sum7; Sum7)
                {

                }
                column(Sum8; Sum8)
                {

                }
                column(Sum9; Sum9)
                {

                }
                column(Sum10; Sum10)
                {

                }
                column(Sum11; Sum11)
                {

                }
                column(Sum12; Sum12)
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
                column(CompanyJIB2; CompInfo."Registration No.")
                {
                }
                column(Kol12; Kol12)
                {
                }
                column(Kol12Pr; Kol12Pr)
                {

                }

                column(SumKol122; SumKol122)
                {

                }
                column(Kol13; Kol13)
                {
                }
                column(Kol14; Kol14)
                {
                }
                column(Kol16; Kol16)
                {
                }
                column(Kol16Sa; Kol16Sa)
                {

                }
                column(SUmKol16Sa; SUmKol16Sa)
                {

                }
                column(Kol17; Kol17)
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
                column(SumBasis2; SumBasis2)
                {

                }
                column(SumkKol172; SumKol172)
                {

                }
                column(SumkKol162; SumKol162)
                {

                }
                column(SumKol162_2; SumKol162_2)
                {

                }
                column(ZoSum2; ZoSum2)
                {

                }
                column(ZnSum2; ZnSum2)
                {

                }
                column(PIOSum2; PIOSum2)
                {

                }
                column(Total14; Total14)
                {

                }
                column(Nule; Nule)
                {

                }
                column(SumKol13; SumKol13)
                {
                }
                column(SumKol14; SumKol14)
                {
                }
                column(SumKol16; SumKol16)
                {
                }
                column(SumKol17; SumKol17)
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

                column(DZSum2; DZSum2)
                {

                }
                column(DZSumTOT; DZSumTOT)
                {

                }
                column(CompanyName; CompInfo.Name)
                {
                }
                column(CompanyAddress; CompInfo.Address)
                {
                }
                column(CompanyPhone; CompInfo."Phone No.")
                {
                }
                column(CompanyCity; CompInfo.City)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PaymentOrder: Record "Payment Order";
                    War2: Record "Wage Calculation";
                    CompInf: Record "Company Information";
                begin

                    wc2.SETRANGE("Month Of Wage", IDMonth);
                    wc2.SETRANGE("Year of Wage", IDYear);

                    wc2.CopyFilters(dataitem14);
                    wc2.SetFilter("Wage Calculation Type", '<>%1 & <>%2', wc2."Wage Calculation Type"::Regular, WC2."Wage Calculation Type"::Additions);
                    if wc2.findfirst then
                        Prikazi := true
                    else
                        Prikazi := false;

                    TaxDed.Reset();
                    TaxDed.setfilter("Type", '%1', TaxDed.type::"Tax List");
                    if (dataitem14."Contribution Category Code" = 'FBIH') OR (dataitem14."Contribution Category Code" = 'FBIHRS')
                    then
                        TaxDed.SetFilter("Entity Code", '%1', 'FBIH');

                    IF (dataitem14."Contribution Category Code" = 'RS') THEN
                        TaxDed.SetFilter("Entity Code", '%1', 'RS');

                    IF ((dataitem14."Contribution Category Code" = 'BDPIOFBIH') OR (dataitem14."Contribution Category Code" = 'BDPIORS')) THEN
                        TaxDed.SetFilter("Entity Code", '%1', 'BD');
                    TaxDed.SetFilter("Valid Year", '<=%1', DataItem14."Year of Wage");
                    TaxDed.SetFilter(Month, '<=%1', DataItem14."Month Of Wage");

                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                    TaxDed.ASCENDING;
                    IF TaxDed.FINDLAST THEN
                        MinTax := TaxDed.Amount
                    else
                        MinTax := 0;

                    BrojZa := BrojZa + 1;





                    CompanyJIB := '';
                    SETRANGE("Month Of Wage", IDMonth);
                    SETRANGE("Year of Wage", IDYear);
                    Employee.SETFILTER("No.", '%1', "Employee No.");
                    IF Employee.FIND('-') THEN BEGIN
                        REPEAT
                            Basis := Brutto;

                            if ("Wage Calculation Type" = "Wage Calculation Type"::Regular)
                            or ("Wage Calculation Type" = "Wage Calculation Type"::Additions) then begin
                                BaseSum := BaseSum + Basis;

                                BrojacZaposlenika := BrojacZaposlenika + 1;
                                if BrojacZaposlenika > 24 then begin
                                    Sum1 := Sum1 + Basis;
                                end;
                            end
                            else begin
                                SumBasis2 := SumBasis2 + Basis;
                            end;




                            Hours := "Hour Pool";
                            EmployeeID := Employee."Employee ID";
                            EmployeeFirstName := Employee."First Name";
                            EmployeeLastName := Employee."Last Name";
                            MunicipalityCIPS := Employee."Municipality Code for salary";

                            CALCSUMS(Brutto);
                            CALCSUMS("Hour Pool");
                        UNTIL Employee.NEXT = 0;
                    END;


                    MunicipalityCIPS := copystr(DataItem14."Municipality CIPS", 1, 3);
                    Municipality.Get(DataItem14."Municipality CIPS", Municipality.Type::Regular);
                    MunName := Municipality.Name;



                    //Wage Calculation

                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Porez');
                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    if PaymentOrder.FindFirst() then
                        VrstaPrihoda := PaymentOrder.VrstaPrihoda
                    else
                        VrstaPrihoda := '713113';


                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Doprinos');

                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    if PaymentOrder.FindFirst() then begin
                        PaymentOrder.CalcSums(Iznos);
                        VrstaPrihoda1 := PaymentOrder.VrstaPrihoda;
                        IznosPrihoda1 := PaymentOrder.Iznos;
                    end
                    else begin
                        VrstaPrihoda1 := '712199';
                        IznosPrihoda1 := 0;
                    end;


                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Doprinosi PIO');

                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    if PaymentOrder.FindFirst() then begin
                        PaymentOrder.CalcSums(Iznos);
                        VrstaPrihoda2 := PaymentOrder.VrstaPrihoda;
                        IznosPrihoda2 := PaymentOrder.Iznos;
                    end
                    else begin
                        VrstaPrihoda2 := '712129';
                        IznosPrihoda2 := 0;
                    end;

                    //712169

                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Dječija zaštita');

                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    if PaymentOrder.FindFirst() then begin
                        PaymentOrder.CalcSums(Iznos);
                        VrstaPrihoda3 := PaymentOrder.VrstaPrihoda;
                        IznosPrihoda3 := PaymentOrder.Iznos;
                    end
                    else begin
                        VrstaPrihoda3 := '712169';
                        IznosPrihoda3 := 0;
                    end;





                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Porez');

                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    PaymentOrder.SetFilter("Wage Calculation Type", '%1|%2|%3', 1, 2, 3);
                    if PaymentOrder.FindFirst() then begin
                        PaymentOrder.CalcSums(Iznos);
                        VrstaPrihoda4 := PaymentOrder.VrstaPrihoda;
                        IznosPrihoda4 := PaymentOrder.Iznos;
                    end
                    else begin
                        VrstaPrihoda4 := '711118';
                        IznosPrihoda4 := 0;
                    end;



                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Doprinosi za zdravstvo');

                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    if PaymentOrder.FindFirst() then begin
                        PaymentOrder.CalcSums(Iznos);
                        VrstaPrihoda5 := PaymentOrder.VrstaPrihoda;
                        IznosPrihoda5 := PaymentOrder.Iznos;
                    end
                    else begin
                        VrstaPrihoda5 := '712149';
                        IznosPrihoda5 := 0;
                    end;




                    PaymentOrder.reset;
                    PaymentOrder.SetFilter("Wage Header No.", '%1', "Wage Header No.");
                    PaymentOrder.SetFilter(Contributon, '%1', 'Poseban doprinos');

                    PaymentOrder.SetFilter(Opstina, '%1', "Municipality CIPS");
                    if PaymentOrder.FindFirst() then begin
                        PaymentOrder.CalcSums(Iznos);
                        VrstaPrihoda6 := PaymentOrder.VrstaPrihoda;
                        IznosPrihoda6 := PaymentOrder.Iznos;
                    end
                    else begin
                        VrstaPrihoda6 := '712171';
                        IznosPrihoda6 := 0;
                    end;











                    /*   ZOSum := 0;
                       PIOSum := 0;
                       DZSum := 0;
                       ZNSum := 0;
                       SumKol16 := 0;
                       SumKol17 := 0;*/
                    if "Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-Residents" then begin
                        Mun.SETFILTER(Code, "Municipality CIPS");
                        IF Mun.FINDFIRST THEN BEGIN
                            MunName := Mun.Name;
                            OrgDijelovi2.RESET;
                        end;

                    end
                    else begin
                        ECL2.RESET;
                        ECL2.SETFILTER("Starting Date", '<=%1', End2);
                        ECL2.SETFILTER("Ending Date", '>=%1|%2', Start2, 0D);
                        ECL2.SETFILTER("Show Record", '%1', TRUE);
                        ECL2.SETFILTER("Employee No.", '%1', "Employee No.");
                        ECL2.SETCURRENTKEY("Starting Date");


                        IF ECL2.FINDFIRST THEN BEGIN
                            ECL2.CALCFIELDS("Municipality Code for salary");
                            Mun.SETFILTER(Code, ECL2."Municipality Code for salary");
                            IF Mun.FINDFIRST THEN BEGIN
                                MunName := Mun.Name;
                                OrgDijelovi2.RESET;

                            end;

                        end;
                    end;

                    MunicipalityCIPS := copystr(DataItem14."Municipality CIPS", 1, 3);
                    Municipality.Get(DataItem14."Municipality CIPS");
                    MunName := Municipality.Name;

                    TPEJIB.SETFILTER("Employee No.", '%1', Employee."No.");
                    TPEJIB.SETFILTER("JIB Contributes", '%1', '');
                    IF TPEJIB.FINDFIRST THEN
                        REPEAT
                            TPEJIB."JIB Contributes" := OrgDijelovi2."JIB Contributes";
                            TPEJIB.MODIFY(TRUE);
                        UNTIL TPEJIB.NEXT = 0;

                    t_ContrEmp4.RESET;
                    t_ContrEmp4.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp4.SETFILTER("JIB Contributes", '%1', OrgDijelovi2."JIB Contributes");
                    t_ContrEmp4.SETFILTER("Contribution Code", '%1|%2', 'D-ZAPO*', '*' + 'NEZAPOS' + '*');


                    IF t_ContrEmp4.FINDFIRST THEN BEGIN
                        t_ContrEmp4.CALCSUMS("Amount From Wage", "Amount Over Wage");
                        //ĐK    ZNSum := t_ContrEmp4."Amount From Wage" + t_ContrEmp4."Amount Over Wage";
                    END;


                    t_ContrEmp5.RESET;
                    t_ContrEmp5.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp5.SETFILTER("JIB Contributes", '%1', OrgDijelovi2."JIB Contributes");
                    t_ContrEmp5.SETFILTER("Contribution Code", '%1|%2', 'D-ZDRAVRS', '*' + 'ZDRAV' + '*');


                    IF t_ContrEmp5.FINDFIRST THEN BEGIN
                        t_ContrEmp5.CALCSUMS("Amount From Wage", "Amount Over Wage");
                        //ĐK  ZOSum := t_ContrEmp5."Amount From Wage" + t_ContrEmp5."Amount Over Wage";
                    END;

                    t_ContrEmp6.RESET;
                    t_ContrEmp6.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp6.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                    t_ContrEmp6.SETFILTER("JIB Contributes", '%1', OrgDijelovi2."JIB Contributes");

                    IF t_ContrEmp6.FINDFIRST THEN BEGIN
                        t_ContrEmp6.CALCSUMS("Amount From Wage");
                        //ĐK   DZSum := t_ContrEmp6."Amount From Wage";
                    END;
                    CompInf.get;


                    t_ContrEmp7.RESET;
                    t_ContrEmp7.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp7.SETFILTER("Contribution Code", '%1|%2', 'D-PIORS', '*' + 'PIO' + '*');
                    t_ContrEmp7.SETFILTER("JIB Contributes", '%1', OrgDijelovi2."JIB Contributes");


                    IF t_ContrEmp7.FINDFIRST THEN BEGIN
                        t_ContrEmp7.CALCSUMS("Amount From Wage", "Amount Over Wage");
                        //ĐK  PIOSum := t_ContrEmp7."Amount From Wage" + t_ContrEmp7."Amount Over Wage";
                    END;



                    t_tax.RESET;
                    t_tax.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_tax.SETFILTER("JIB Contributes", '%1', OrgDijelovi2."JIB Contributes");
                    t_tax.SETFILTER("Contribution Category Code", '%1|%2', 'RS', 'UOD' + '*');

                    IF t_tax.FINDFIRST THEN BEGIN
                        t_tax.CALCSUMS(Amount);
                        //đk SumKol16 := t_tax.Amount;
                        //đ k SumKol17 := t_tax.Amount / 0.1;
                    END;
                    CompInf.get;
                    if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH') then
                        Kol17 := "Tax Basis" + TaxBasisAdd
                    else
                        Kol17 := 0;


                    CompInf.get;
                    if (CompInf."Municipality Code" <> DataItem14."Municipality CIPS") and (DataItem14."Municipality CIPS" = DataItem14.GetFilter("Municipality CIPS"))
                    and (("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions)) then begin
                        Kol17 := "Tax Basis" + TaxBasisAdd;
                    end;





                    if ("Wage Calculation Type" = "Wage Calculation Type"::Regular)
                           or ("Wage Calculation Type" = "Wage Calculation Type"::Additions) then begin
                        if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH') then
                            SumKol17 := SumKol17 + "Tax Basis" + TaxBasisAdd;

                        CompInf.get;
                        if (CompInf."Municipality Code" <> DataItem14."Municipality CIPS") and (DataItem14."Municipality CIPS" = DataItem14.GetFilter("Municipality CIPS"))
                        and (("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions)) then begin
                            SumKol17 := SumKol17 + "Tax Basis" + TaxBasisAdd;
                        end;


                        ;
                        if BrojacZaposlenika > 24 then begin
                            if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH') then
                                Sum7 := Sum7 + "Tax Basis" + TaxBasisAdd;


                        end;
                    End
                    else begin
                        if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH') then
                            SumKol172 := SumKol172 + "Tax Basis" + TaxBasisAdd;
                    end;

                    if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or ((DataItem14."Entity Code" = 'FBIH')) then
                        Kol16 := Tax + TaxAdd
                    else
                        Kol16 := 0;

                    CompInf.get;
                    if (CompInf."Municipality Code" <> DataItem14."Municipality CIPS") and (DataItem14."Municipality CIPS" = DataItem14.GetFilter("Municipality CIPS"))
                    and (("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions)) then begin
                        Kol16 := Tax + TaxAdd
                    end;

                    if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH')
                     and (("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-No Residents") or
                    ("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-Residents")
                    or ("Wage Calculation Type" = "Wage Calculation Type"::"Author Contracts"))
                    then begin
                        Kol16 := 0;
                        Kol16_2 := Tax + TaxAdd;
                    end;

                    if (CompInf."Municipality Code" <> dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH')
                    and (("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-No Residents") or
                   ("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-Residents")
                   or ("Wage Calculation Type" = "Wage Calculation Type"::"Author Contracts"))
                   then begin
                        Kol16 := Tax + TaxAdd;
                        Kol16_2 := Tax + TaxAdd;
                    end;




                    Kol16Sa := Tax + TaxAdd;
                    CompInf.get;



                    if ("Wage Calculation Type" = "Wage Calculation Type"::Regular)
                           or ("Wage Calculation Type" = "Wage Calculation Type"::Additions) then begin
                        if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH') then
                            SumKol16 := SumKol16 + "Tax" + TaxAdd;

                        CompInf.get;
                        if (CompInf."Municipality Code" <> DataItem14."Municipality CIPS") and (DataItem14."Municipality CIPS" = DataItem14.GetFilter("Municipality CIPS"))
                        and ("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions) then begin
                            SumKol16 := SumKol16 + "Tax" + TaxAdd;
                        end;


                        SUmKol16Sa := SUmKol16Sa + "Tax" + TaxAdd;
                        ;
                        if BrojacZaposlenika > 24 then begin
                            if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH') then
                                Sum8 := Sum8 + "Tax" + TaxAdd;
                        end;

                    end
                    else begin
                        if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH')
                         and (("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions))
                         then
                            SumKol162 := SumKol162 + "Tax" + TaxAdd;



                        if (CompInf."Municipality Code" = dataitem14."Municipality CIPS") or (DataItem14."Entity Code" = 'FBIH')
                     and (("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-No Residents") or
                    ("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-Residents")
                    or ("Wage Calculation Type" = "Wage Calculation Type"::"Author Contracts"))
                     then begin
                            SumKol162_2 := SumKol162_2 + 0;
                        end
                        else begin

                            IF (("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-No Residents") or
                   ("Wage Calculation Type" = "Wage Calculation Type"::"Temporary Service Contracts-Residents")
                   or ("Wage Calculation Type" = "Wage Calculation Type"::"Author Contracts"))
                   and (CompInf."Municipality Code" <> dataitem14."Municipality CIPS") then
                                SumKol162_2 := SumKol162_2 + "Tax" + TaxAdd;

                        end;




                    end;




                    wc2.SETRANGE("Month Of Wage", IDMonth);
                    wc2.SETRANGE("Year of Wage", IDYear);
                    wc2.SETRANGE("Department Municipality", Mun.Code);
                    wc2.CopyFilters(dataitem14);
                    wc2.CALCSUMS(Brutto);
                    wc2.CALCSUMS("Hour Pool");
                    wc2.CALCSUMS("Tax Deductions");
                    //ĐK BaseSum := wc2.Brutto;
                    TotalHours := wc2."Hour Pool";

                    CompInf.get;

                    IF (dataitem14."Municipality CIPS" <> CompInf."Municipality Code") or ((DataItem14."Entity Code" = 'FBIH')) then begin
                        Kol12 := 0;
                        Kol12Pr := 0;
                        if (DataItem14."Entity Code" = 'FBIH') then begin

                            /*  if "Tax Deductions" < MinTax then begin
                                  SumKol12 := SumKol12 + "Tax Deductions";
                                  Kol12 := "Tax Deductions";
                              end
                              else begin
                                  SumKol12 := SumKol12 + MinTax;

                                  SumKol50 := SumKol50 + "Tax Deductions" - MinTax;
                                  Kol12 := MinTax;
                                  Kol12Pr := "Tax Deductions" - MinTax;


                              end;*/
                            SumKol12 := SumKol12 + DataItem14."Iznos poreske kartice";
                            Kol12 := DataItem14."Iznos poreske kartice";
                            SumKol50 := SumKol50 + DataItem14."Iznos ličnog odbitka";
                            Kol12Pr := DataItem14."Iznos ličnog odbitka";




                        end;
                        CompInf.get;
                        if (CompInf."Municipality Code" <> DataItem14."Municipality CIPS") and (DataItem14."Municipality CIPS" = DataItem14.GetFilter("Municipality CIPS"))
                        and (("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions))
                         then begin
                            SumKol12 := SumKol12 + DataItem14."Iznos poreske kartice";
                            Kol12 := DataItem14."Iznos poreske kartice";
                            SumKol50 := SumKol50 + DataItem14."Iznos ličnog odbitka";
                            Kol12Pr := DataItem14."Iznos ličnog odbitka";
                        end;

                    end

                    else begin


                        if ("Wage Calculation Type" = "Wage Calculation Type"::Regular) or
                        ("Wage Calculation Type" = "Wage Calculation Type"::Additions) then begin

                            /*   if "Tax Deductions" < MinTax then begin
                                   SumKol12 := SumKol12 + "Tax Deductions";
                                   Kol12 := "Tax Deductions";
                               end
                               else begin
                                   SumKol12 := SumKol12 + MinTax;

                                   SumKol50 := SumKol50 + "Tax Deductions" - MinTax;
                                   Kol12 := MinTax;
                                   Kol12Pr := "Tax Deductions" - MinTax;

                               end;*/

                            SumKol12 := SumKol12 + DataItem14."Iznos poreske kartice";
                            Kol12 := DataItem14."Iznos poreske kartice";
                            SumKol50 := SumKol50 + DataItem14."Iznos ličnog odbitka";
                            Kol12Pr := DataItem14."Iznos ličnog odbitka";





                            if BrojacZaposlenika > 24 then begin
                                /*   if "Tax Deductions" < MinTax then begin
                                       Sum6 := Sum6 + "Tax Deductions";
                                   end
                                   else begin
                                       Sum6 := Sum6 + MinTax;
                                       Sum50 := Sum50 + "Tax Deductions" - MinTax;
                                   end;*/

                                Sum6 := Sum6 + DataItem14."Iznos poreske kartice";
                                Sum50 := DataItem14."Iznos ličnog odbitka";

                            end;
                        end
                        else begin



                            if (CompInf."Municipality Code" <> DataItem14."Municipality CIPS") then begin


                                SumKol122 := SumKol122 + "Tax Deductions";
                                Kol12 := "Tax Deductions";
                            end
                            else begin
                                SumKol122 := SumKol122 + 0;
                                Kol12 := 0;

                            end;
                        end;
                    end;


                    BruttoAdd := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;
                    //*******************************************Additions****************************************//
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            BruttoAdd += WVE."Cost Amount (Brutto)";
                            NettoAdd += WVE."Cost Amount (Netto)";
                        UNTIL WVE.NEXT = 0;

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
                    wc3.SETRANGE("Month Of Wage", IDMonth);
                    wc3.SETRANGE("Year of Wage", IDYear);
                    wc3.SETFILTER("Municipality CIPS", "Municipality CIPS");
                    IF wc3.FINDFIRST THEN BEGIN
                        REPEAT
                            Brojac := wc3.COUNT;
                        UNTIL wc3.NEXT = 0;
                    END;

                    sumZO := 0;
                    sumZO1 := 0;
                    t_ContrEmp.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp.SETFILTER("Contribution Code", '%1|%2', 'D-ZDRAVRS', '*' + 'ZDRAV' + '*');

                    IF t_ContrEmp.FINDFIRST THEN
                        REPEAT
                            if DataItem14."Entity Code" <> 'FBIH' then
                                sumZO += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";

                            sumZO1 += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";


                            if (t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::Regular)
                           or (t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::Additions) then begin

                                ZOSum := ZOSum + sumZO1;
                                ZoSumBez := ZoSumBez + sumZO;

                                if BrojacZaposlenika > 24 then
                                    Sum3 := Sum3 + sumZO;
                            end
                            else begin
                                ZoSum2 := ZoSum2 + sumZO;
                            end;
                        UNTIL t_ContrEmp.NEXT = 0;


                    sumZN := 0;
                    sumZN1 := 0;

                    t_ContrEmp1.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp1.SETFILTER("Employee No.", '%1', "Employee No.");
                    //     t_ContrEmp1.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp1.SETFILTER("Contribution Code", '%1|%2', 'D-ZAPO*', '*' + 'NEZAPOS' + '*');

                    IF t_ContrEmp1.FINDFIRST THEN
                        REPEAT
                            if DataItem14."Entity Code" <> 'FBIH' then
                                sumZN += t_ContrEmp1."Amount From Wage" + t_ContrEmp1."Amount Over Wage";

                            sumZN1 += t_ContrEmp1."Amount From Wage" + t_ContrEmp1."Amount Over Wage";

                            if (t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::Regular)
                           or (t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::Additions) then begin
                                if BrojacZaposlenika > 24 then
                                    Sum4 := Sum4 + sumZN;

                                ZNSum := ZNSum + sumZN1;
                                ZnSumbez := ZnSumbez + sumZN;

                            end
                            else begin
                                ZNSum2 := ZnSum2 + sumZN;
                            end;
                        UNTIL t_ContrEmp1.NEXT = 0;


                    sumPIO := 0;
                    t_ContrEmp2.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp2.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp2.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp2.SETFILTER("Contribution Code", '%1|%2', 'D-PIORS', '*' + 'PIO' + '*');

                    IF t_ContrEmp2.FINDFIRST THEN
                        REPEAT

                            if t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::"Temporary Service Contracts-Residents" then begin
                                sumPIO += t_ContrEmp2."Amount From Wage" + t_ContrEmp2."Amount Over Wage";
                            end
                            else begin
                                sumPIO += t_ContrEmp2."Amount From Wage";


                            end;

                            CompInf.get;
                            if (DataItem14.GetFilter("Municipality CIPS") <> '') and (DataItem14.GetFilter("Municipality CIPS") <> CompInf."Municipality Code")
                                then
                                Nule := true
                            else
                                Nule := false;



                            if (t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::Regular)
                       or (t_ContrEmp2."Wage Calculation Type" = t_ContrEmp2."Wage Calculation Type"::Additions) then begin
                                PIOSum := PIOSum + sumPIO;
                                if BrojacZaposlenika > 24 then
                                    Sum2 := Sum2 + sumPIO;
                            end
                            else begin

                                PIOSum2 := PIOSum2 + sumPIO;
                            end;
                        UNTIL t_ContrEmp2.NEXT = 0;


                    sumDZ := 0;



                    WCRig.reset;
                    WCRig.CopyFilters(DataItem14);
                    if WCRig.FindSet() then
                        repeat
                            t_ContrEmp3.reset;
                            t_ContrEmp3.SETFILTER("Wage Header No.", '%1', WCRig."Wage Header No.");
                            t_ContrEmp3.SETFILTER("Employee No.", '%1', WCRig."Employee No.");
                            //      t_ContrEmp3.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                            t_ContrEmp3.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');

                            IF t_ContrEmp3.FindSet() THEN
                                repeat

                                    if (t_ContrEmp3."Wage Calculation Type" = t_ContrEmp3."Wage Calculation Type"::Regular)
                                          or (t_ContrEmp3."Wage Calculation Type" = t_ContrEmp3."Wage Calculation Type"::Additions) then begin
                                        DZSumTOT := DZSumTOT + t_ContrEmp3."Amount From Wage";
                                    end;

                                until t_ContrEmp3.Next() = 0;






                        until WCRig.Next() = 0;



                    t_ContrEmp3.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    t_ContrEmp3.SETFILTER("Employee No.", '%1', "Employee No.");
                    //      t_ContrEmp3.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp3.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');

                    IF t_ContrEmp3.FINDFIRST THEN
                        REPEAT
                            sumDZ += t_ContrEmp3."Amount From Wage";

                            if (t_ContrEmp3."Wage Calculation Type" = t_ContrEmp3."Wage Calculation Type"::Regular)
                           or (t_ContrEmp3."Wage Calculation Type" = t_ContrEmp3."Wage Calculation Type"::Additions) then begin
                                DZSum := DZSum + sumDZ;

                                if BrojacZaposlenika > 24 then Sum5 := sum5 + sumDZ;
                            end
                            else begin
                                DZSum2 := DZSum2 + sumDZ
                            end;
                            ;


                        UNTIL t_ContrEmp3.NEXT = 0;






                    Total := DZSum + ZNSum + PIOSum + ZOSum;
                    SumTotal := sumDZ + sumZN + sumPIO + sumZO;


                    if (DataItem14."Wage Calculation Type" = DataItem14."Wage Calculation Type"::Regular)
                          or (DataItem14."Wage Calculation Type" = DataItem14."Wage Calculation Type"::Additions)
                      then begin

                        if BrojacZaposlenika > 24 then begin
                            Total14 := Total14 + Basis + BruttoAdd - (sumZN1 + sumPIO + sumZO1 + sumDZ) - Kol16Sa;

                        end;
                    end;

                    TaxClass.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass.FINDFIRST THEN BEGIN
                        Amount := (Basis - SumTotal) - (((Basis - SumTotal) * TaxClass.Percentage) / 100);
                        TaxTotal := (BaseSum - Total) - (((BaseSum - Total) * TaxClass.Percentage) / 100);
                    END;

                end;


                trigger OnPreDataItem()
                begin

                    BEGIN
                        SETRANGE("Month Of Wage", IDMonth);
                        SETRANGE("Year of Wage", IDYear);
                        //   "Wage Calculation".SETRANGE("Department Municipality",'074-RS');

                    END;
                    SickHourPool := 0;
                    // SETFILTER("Wage Calculation Type",'%1',0);
                    //SETFILTER("Contribution Category Code",'%1','FBiH');

                    SETFILTER("Contribution Category Code", '%1|%2', 'RS', 'UOD' + '*');
                    Brojac := 0;
                    Start2 := Fill.GetMonthRange(IDMonth, IDYear, TRUE);
                    End2 := Fill.GetMonthRange(IDMonth, IDYear, FALSE);
                    Kraj := copystr(format(end2), 1, 2);
                end;
            }

            trigger OnPreDataItem()
            var
                OrgDijelovi: Record "Org Dijelovi";
                OrgDijeloviTemp: Record "Org Dijelovi";
            begin

                CompInfo.GET;

                SETRANGE("Month Of Wage", IDMonth);
                SETRANGE("Year Of Wage", IDYear);
                IF IDMonth < 10 THEN
                    IDMonthText := '0' + FORMAT(IDMonth)
                ELSE
                    IDMonthText := FORMAT(IDMonth);

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
                Emp.SETFILTER("Org Entity Code", '%1', 'RS');
                Emp.SETFILTER("Entity Code CIPS", '%1', 'RS');
                Emp.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
                // Emp.SETFILTER("For Calculation",'%1',TRUE);
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
                    field(Month; IDMonth)
                    {
                        Caption = 'Month';
                        ApplicationArea = all;
                    }
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
                        ApplicationArea = all;
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
            IDYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);
            BrojZa := 0;
        END;
    end;

    trigger OnPreReport()
    begin
        //Brojac :=0;
        CompInfo.GET;
        SumTotal := 0;
    end;

    var
        ECL2: Record "Employee Contract Ledger";
        Nule: Boolean;

        Kol16_2: Decimal;
        DZSumTOT: Decimal;


        Total14: Decimal;

        sumZN1: Decimal;

        ZoSumBez: Decimal;
        sumZO1: Decimal;
        BrojacZaposlenika: Decimal;
        SumKol50: Decimal;

        TaxDed: Record "Tax deduction list";

        Sum50: Decimal;

        MinTax: Decimal;
        Prikazi: Boolean;
        Kraj: Text[1000];
        SumKol122: Decimal;

        Sum1: Decimal;
        Sum2: Decimal;
        Sum3: Decimal;
        Sum4: Decimal;
        Sum5: Decimal;
        Sum6: Decimal;

        Sum7: Decimal;
        Sum8: Decimal;
        Sum9: Decimal;
        Sum10: Decimal;
        Sum11: Decimal;
        Sum12: Decimal;
        SumKol172: Decimal;
        SumKol162: Decimal;
        SumKol162_2: Decimal;
        IznosPrihoda6: Decimal;
        SumBasis2: Decimal;
        ZoSum2: Decimal;
        ZnSum2: Decimal;

        PioSum2: Decimal;
        IznosPrihoda5: Decimal;
        IznosPrihoda4: Decimal;
        IznosPrihoda3: Decimal;
        IznosPrihoda2: Decimal;
        IznosPrihoda1: Decimal;

        IznosPrihoda: Decimal;
        VrstaPrihoda: Text[1000];
        VrstaPrihoda1: Text[1000];
        VrstaPrihoda2: Text[1000];
        VrstaPrihoda3: Text[1000];
        VrstaPrihoda4: Text[1000];
        VrstaPrihoda5: Text[1000];
        VrstaPrihoda6: Text[1000];

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

        Kol12Pr: Decimal;
        Kol15: Decimal;
        Kol16: Decimal;
        Kol17: Decimal;
        Kol19_1: Decimal;
        SumKol13: Decimal;
        SumKol14: Decimal;
        SumKol12: Decimal;
        SumKol15: Decimal;

        SumKol16: Decimal;
        Kol16Sa: decimal;
        SUmKol16Sa: Decimal;
        SumKol17: Decimal;
        SumKol19: Decimal;
        OrgDijelovi2: Record "Org Dijelovi";
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
        BrojZa: Integer;
        DZSum: Decimal;

        WCRig: Record "wage calculation";
        Amount: Decimal;
        Total: Decimal;
        BaseSum: Decimal;
        ZOSum: Decimal;
        SumTotal: Decimal;
        ZNSum: Decimal;
        ZnSumbez: Decimal;
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
        EmployeeContractLedger: Record "Employee contract Ledger";
        wc2: Record "Wage Calculation";
        wc3: Record "Wage Calculation";
        MunicipalityCIPS: Code[10];
        Mun: Record "Municipality";
        MunName: Text;
        t_ContrEmp5: Record "Contribution Per Employee";
        t_ContrEmp6: Record "Contribution Per Employee";
        t_ContrEmp7: Record "Contribution Per Employee";
        t_ContrEmp4: Record "Contribution Per Employee";

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

