report 50047 "Obrazac DL-2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Obrazac DL-2.rdl';

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
                DataItemTableView = SORTING("No.", "Wage Header No.", "Wage Calculation Type", "Employee No.")
                                    ORDER(Ascending)
                                    WHERE("Contribution Category Code" = FILTER('FBIHRS'));
                column(MjesecPlateWC; DataItem14."Month Of Wage")
                {
                }
                column(GodinaPlateWC; DataItem14."Year of Wage")
                {
                }
                column(BrojObracuna; DataItem14."No.")
                {
                }
                column(BrojZaposlenikaWC; DataItem14."Employee No.")
                {
                }
                column(MjesecObracuna; DataItem14."Payment Date")
                {
                }
                column(UnpaidHours; DataItem14."Unpaid Absence Hours")
                {
                }
                column(BrojRadnihSati; Hours)
                {
                }
                column(FirstName; DataItem14."First Name")
                {
                }
                column(LastName; DataItem14."Last Name")
                {
                }
                column(WageEmployeeNo; DataItem14."Employee No.")
                {
                }
                column(TaxDeductions; DataItem14."Tax Deductions")
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
                column(Brutto; DataItem14.Brutto)
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
                dataitem(DataItem10; "Contribution Per Employee")
                {
                    DataItemLink = "Wage Header No." = FIELD("Wage Header No.");
                    column(Basis; DataItem10.Basis)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin


                    DataItem14.SETRANGE("Month Of Wage", IDMonth);
                    DataItem14.SETRANGE("Year of Wage", IDYear);
                    Employee.SETFILTER("No.", '%1', DataItem14."Employee No.");
                    IF Employee.FIND('-') THEN BEGIN
                        REPEAT
                            Basis := DataItem14.Brutto;
                            Hours := DataItem14."Hour Pool";
                            EmployeeID := Employee."Employee ID";
                            EmployeeFirstName := Employee."First Name";
                            EmployeeLastName := Employee."Last Name";
                            DataItem14.CALCSUMS(Brutto);
                            DataItem14.CALCSUMS("Hour Pool");
                            BaseSum += DataItem14.Brutto;
                            TotalHours += DataItem14."Hour Pool";
                            Brojac := DataItem14.COUNT;
                        UNTIL Employee.NEXT = 0;
                        //END;

                        Contribution.SETFILTER("Category Code", '%1', 'RS');
                        Contribution.SETFILTER("Contribution Code", '%1', 'D-NEZAP-IZ');
                        IF Contribution.FINDFIRST THEN BEGIN
                            sumZN := (Basis * Contribution.Percentage) / 100;
                            ZNSum := (BaseSum * Contribution.Percentage) / 100;
                        END;

                        Contribution1.SETFILTER("Category Code", '%1', 'RS');
                        Contribution1.SETFILTER("Contribution Code", '%1', 'D-ZDRAVRS');
                        IF Contribution1.FINDFIRST THEN BEGIN
                            sumZO := (Basis * Contribution1.Percentage) / 100;
                            ZOSum := (BaseSum * Contribution1.Percentage) / 100;
                        END;

                        Contribution2.SETFILTER("Category Code", '%1', 'RS');
                        Contribution2.SETFILTER("Contribution Code", '%1', 'D-PIORS');
                        IF Contribution2.FINDFIRST THEN BEGIN
                            sumPIO := (Basis * Contribution2.Percentage) / 100;
                            PIOSum := (BaseSum * Contribution2.Percentage) / 100;
                        END;


                        Contribution3.SETFILTER("Category Code", '%1', 'RS');
                        Contribution3.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                        IF Contribution3.FINDFIRST THEN BEGIN
                            sumDZ := (Basis * Contribution3.Percentage) / 100;
                            DZSum := (BaseSum * Contribution3.Percentage) / 100;
                        END;

                        Total := sumDZ + sumZN + sumPIO + sumZO;
                        SumTotal += Total;

                        TaxClass.SETFILTER(Code, '%1', 'FBIHRS');
                        IF TaxClass.FINDFIRST THEN BEGIN
                            Amount := (Basis - Total) - (((Basis - Total) * TaxClass.Percentage) / 100);
                        END;
                    END;



                    /*IF DataItem14."Contribution Category Code"='FBIHRS' THEN BEGIN
                            IF ATCCon.GET('RS', 'D-NEZAP-IZ') THEN BEGIN
                              ATPercent:= ATCCon.Percentage/100;
                              ZNSum := ROUND(DataItem14.Brutto * ATPercent,0.01,'>');
                         END;
                         END;*/

                end;

                trigger OnPreDataItem()
                begin

                    BEGIN
                        DataItem14.SETRANGE("Month Of Wage", IDMonth);
                        DataItem14.SETRANGE("Year of Wage", IDYear);
                    END;
                    SickHourPool := 0;
                    SETFILTER("Wage Calculation Type", '%1', 0);
                    SETFILTER("Contribution Category Code", '%1', 'FBIHRS');
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
        //InputDate := TODAY;
        //BEGIN
        //TodayDay := DATE2DMY(InputDate,1);
        //TodayMonth := DATE2DMY(InputDate,2);
        //TodayYear := DATE2DMY(InputDate,3);
        //END;

        BEGIN
            IDMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
            IDYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);
        END;
    end;

    trigger OnPreReport()
    begin
        Brojac := 0;
        CompInfo.GET;
        SumTotal := 0;
    end;

    var
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
        //  PositionRS: Record "Objective Line";
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

