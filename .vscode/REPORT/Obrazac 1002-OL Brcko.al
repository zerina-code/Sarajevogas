report 50043 "Obrazac 1002-OL Brcko"
{
    // //
    DefaultLayout = RDLC;
    RDLCLayout = './Obrazac 1002 - OL Brcko.rdl';


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
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompanyJIB; CompInfo."Registration No.")
            {
            }
            column(CompanyAddress; CompInfo.Address)
            {
            }
            column(CompanyPhone; CompInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompInfo."E-Mail")
            {
            }
            column(CompanyMunicipalityCode; CompInfo."Municipality Code")
            {
            }
            column(CompanyCity; CompInfo.City)
            {
            }
            column(MunicipalityName; CompInfo."Municipality Name")
            {
            }
            dataitem(DataItem14; "Wage Calculation")
            {
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
                column(Base; Basis)
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
                column(Tax; Amount)
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
                column(DepName; DepartmentName)
                {
                }
                column(DepAddress; DepartmentAddress)
                {
                }
                column(DepPhone; DepartmentPhone)
                {
                }
                dataitem(DataItem10; "Contribution Per Employee")
                {
                    DataItemLink = "Wage Header No." = FIELD("Wage Header No.");
                    /*NKBC    column(Basis; "Contribution Per Employee".Basis)
                        {
                        } NKBC*/
                }

                trigger OnAfterGetRecord()
                begin


                    SETRANGE("Month Of Wage", IDMonth);
                    SETRANGE("Year of Wage", IDYear);
                    Employee.SETFILTER("No.", '%1', "Employee No.");
                    IF Employee.FIND('-') THEN BEGIN
                        REPEAT
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

                            Basis := Brutto + BruttoAdd;
                            Hours := "Hour Pool";
                            EmployeeID := Employee."Employee ID";
                            EmployeeFirstName := Employee."First Name";
                            EmployeeLastName := Employee."Last Name";
                            CALCSUMS(Brutto);
                            CALCSUMS("Hour Pool");
                            BaseSum += Brutto + BruttoAdd;
                            TotalHours += "Hour Pool";
                            Brojac := COUNT;
                        UNTIL Employee.NEXT = 0;
                    END;


                    t_ContrEmp.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        sumZO := t_ContrEmp."Reported Amount From Wage";
                    END;

                    t_ContrEmp1.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp1.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp1.SETFILTER("Contribution Code", '%1', 'D-NEZAP-IZ');
                    IF t_ContrEmp1.FINDFIRST THEN BEGIN
                        sumZN := t_ContrEmp1."Reported Amount From Wage";
                    END;

                    t_ContrEmp2.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp2.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp2.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');
                    IF t_ContrEmp2.FINDFIRST THEN BEGIN
                        sumPIO := t_ContrEmp2."Reported Amount From Wage";
                    END;

                    t_ContrEmp3.SETFILTER("Employee No.", '%1', "Employee No.");
                    //  t_ContrEmp3.SETFILTER("Wage Calc No.",'%1',"Wage Calculation"."No.");
                    t_ContrEmp3.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                    IF t_ContrEmp3.FINDFIRST THEN BEGIN
                        sumDZ := t_ContrEmp3."Reported Amount From Wage";
                    END;

                    Contribution2.SETFILTER("Category Code", '%1', 'RS');
                    Contribution2.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');
                    IF Contribution2.FINDFIRST THEN BEGIN
                        PIOSum := (BaseSum * Contribution2.Percentage) / 100;
                    END;

                    Contribution.SETFILTER("Category Code", '%1', 'RS');
                    Contribution.SETFILTER("Contribution Code", '%1', 'D-NEZAP-IZ');
                    IF Contribution.FINDFIRST THEN BEGIN
                        ZNSum := (BaseSum * Contribution.Percentage) / 100;
                    END;

                    Contribution1.SETFILTER("Category Code", '%1', 'RS');
                    Contribution1.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                    IF Contribution1.FINDFIRST THEN BEGIN
                        ZOSum := (BaseSum * Contribution1.Percentage) / 100;
                    END;

                    Contribution3.SETFILTER("Category Code", '%1', 'RS');
                    Contribution3.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                    IF Contribution3.FINDFIRST THEN BEGIN
                        DZSum := (BaseSum * Contribution3.Percentage) / 100;
                    END;

                    /* Contribution.SETFILTER("Category Code",'%1','FBiHRS');
                     Contribution.SETFILTER("Contribution Code",'%1','D-NEZAP-IZ');
                     IF Contribution.FINDFIRST THEN BEGIN
                     sumZN:=(Basis*Contribution.Percentage)/100;
                     ZNSum:=(BaseSum*Contribution.Percentage)/100;
                     END;

                     Contribution1.SETFILTER("Category Code",'%1','FBiHRS');
                     Contribution1.SETFILTER("Contribution Code",'%1','D-ZDRAVRS');
                     IF Contribution1.FINDFIRST THEN BEGIN
                     sumZO:=(Basis*Contribution1.Percentage)/100;
                     ZOSum:=(BaseSum*Contribution1.Percentage)/100;
                     END;

                     Contribution2.SETFILTER("Category Code",'%1','FBiHRS');
                     Contribution2.SETFILTER("Contribution Code",'%1','D-PIORS');
                     IF Contribution2.FINDFIRST THEN BEGIN
                     sumPIO:=(Basis*Contribution2.Percentage)/100;
                     PIOSum:=(BaseSum*Contribution2.Percentage)/100;
                     END;


                     Contribution3.SETFILTER("Category Code",'%1','FBiHRS');
                     Contribution3.SETFILTER("Contribution Code",'%1','DJEC-ZAST');
                     IF Contribution3.FINDFIRST THEN BEGIN
                     sumDZ:=(Basis*Contribution3.Percentage)/100;
                     DZSum:=(BaseSum*Contribution3.Percentage)/100;
                     END; */

                    Total := DZSum + ZNSum + PIOSum + ZOSum;
                    SumTotal := sumDZ + sumZN + sumPIO + sumZO;

                    TaxClass.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass.FINDFIRST THEN BEGIN
                        Amount := (Basis - SumTotal) - (((Basis - SumTotal) * TaxClass.Percentage) / 100);
                        TaxTotal := (BaseSum - Total) - (((BaseSum - Total) * TaxClass.Percentage) / 100);
                    END;
                    //END;


                    //  END;

                end;

                trigger OnPreDataItem()
                begin

                    BEGIN
                        SETRANGE("Month Of Wage", IDMonth);
                        SETRANGE("Year of Wage", IDYear);
                    END;
                    SickHourPool := 0;
                    SETFILTER("Wage Calculation Type", '%1', 0);
                    SETFILTER("Contribution Category Code", '%1', 'BDPIORS');
                end;
            }

            trigger OnPreDataItem()
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
                    }
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
    begin


        BEGIN
            IDMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
            IDYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);
        END;

        //NKBC Department.SETFILTER(Code, '%1', '802');
        IF Department.FINDFIRST THEN BEGIN
            DepartmentName := Department.Description;
            DepartmentAddress := Department.Address;
            DepartmentPhone := Department.Telephone;
        END;

    end;

    trigger OnPreReport()
    begin
        Brojac := 0;
        CompInfo.GET;
        SumTotal := 0;
    end;

    var
        TaxBasisAdd: Decimal;
        TaxAdd: Decimal;
        BruttoAdd: Decimal;
        NettoAdd: Decimal;
        WVE: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        WVEC: Record "Wage Value Entry";
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
        DZSum: Decimal;
        TaxTotal: Decimal;
        DepMunicipality: Code[10];
        EmployeeContractLedger: Record "Employee Contract Ledger";
        DepartmentName: Text;
        DepartmentAddress: Text;
        DepartmentPhone: Text;
        Department: Record "ORG Dijelovi";

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

