report 50003 "Vacation statistics"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Vacation statistics.rdl';
    Caption = 'Vacation statistics';

    dataset
    {
        dataitem(DataItem24; "Company Information")
        {
            column(CompanyName; DataItem24.Name)
            {
            }
            column(CompanyAdress; DataItem24.Address)
            {
            }
            column(CompanyCity; DataItem24.City)
            {
            }
            column(CompanyLogo; DataItem24.Picture)
            {
            }
            column(CompanyPostCode; DataItem24."Post Code")
            {
            }
            column(PhoneNo; DataItem24."Phone No.")
            {
            }
            column(PhoneNo2; DataItem24."Phone No. 2")
            {
            }
            column(FaxNo; DataItem24."Fax No.")
            {
            }
            column(Email; DataItem24."E-Mail")
            {
            }
            column(HomePage; DataItem24."Home Page")
            {
            }
        }
        dataitem(DataItem1; "Employee")
        {
            column(No; DataItem1."No.")
            {
            }
            column(FirsName; DataItem1."First Name")
            {
            }
            column(LastName; DataItem1."Last Name")
            {
            }
            column(ExYearDays; ExYearDays)
            {
            }
            column(ExYearDaysUsed; ExYearDaysUsed)
            {
            }
            column(ExYearsDaysLeft; ExyersDaysLeft)
            {
            }
            column(Valid; Valid)
            {
            }
            column(CurrDays; CurrDays)
            {
            }
            column(CurrDaysUsed; CurrDaysUsed)
            {
            }
            column(CurrDaysLeft; CurrDaysLeft)
            {
            }
            column(Total; Total)
            {
            }
            column(OsnovaGOtrenutna; OsnovaGOtrenutna)
            {
            }
            column(OsnovaGOprosla; OsnovaGOprosla)
            {
            }
            column(Position; Position)
            {
            }
            column(Department; Department)
            {
            }
            column(Stream; Stream)
            {
            }
            column(B1Regions; B1Regions)
            {
            }
            column(Status; Status)
            {
            }
            column(B1; B1)
            {
            }
            column(IDOJ; IDOJ)
            {
            }
            column(EmploymentDate; EmploymentDate)
            {
            }
            column(MaxDays; MaxDays)
            {
            }
            column(Dosje; DataItem1."Internal ID")
            {
            }
            column(Sektor; Sektor)
            {
            }
            column(Odjel; Odjel)
            {
            }
            column(Grupa; Grupa)
            {
            }
            column(Tim; Tim)
            {
            }
            column(VPIsk; VPIskoristeno)
            {
            }
            column(VPNeIsk; VPNeis)
            {
            }
            column(IskOstaloP; IskOstaloP)
            {
            }
            column(IskOstaloNeP; IskOstaloNeP)
            {
            }
            column(TotalBo; TotalBo)
            {
            }
            column(Porod; Porod)
            {
            }
            column(Sluzbeni; Sluzbeni)
            {
            }
            column(Praznik; Praznik)
            {
            }
            column(Suspenzija; Suspenzija)
            {
            }
            column(Neopravdano; Neopravdano)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Stream := '';
                B1Regions := '';
                Position := '';
                Department := '';
                B1 := '';
                IDOJ := '';
                EmploymentDate := 0D;


                TodayDate := TODAY;
                currentYear := DATE2DMY(DateOfReport, 3);
                lastYear := DATE2DMY(DateOfReport, 3) - 1;

                PlanGO.RESET;
                PlanGO.SETFILTER("Employee No.", "No.");
                PlanGO.SETFILTER(Year, FORMAT(currentYear));
                IF PlanGO.FINDFIRST THEN
                    OsnovaGOtrenutna := PlanGO."Total days"
                ELSE
                    OsnovaGOtrenutna := 0;

                PlanGO.RESET;
                PlanGO.SETFILTER("Employee No.", "No.");
                PlanGO.SETFILTER(Year, FORMAT(lastYear));
                IF PlanGO.FINDFIRST THEN
                    OsnovaGOprosla := PlanGO."Total days"
                ELSE
                    OsnovaGOprosla := 0;
                //EC01e

                VACSetup.SETFILTER(Year, '%1', DATE2DMY(DateOfReport, 3));
                IF VACSetup.FINDFIRST THEN BEGIN
                    CurrDays := VacMgmt.CalculateDays("No.", VACSetup."Vacation Descision Date");
                    ExYearDays := VacMgmt.CalculateDays("No.", CALCDATE('<-1Y>', VACSetup."Vacation Descision Date"));

                    CurrDaysUsed := VacMgmt.CalculateDaysUsed("No.", DateOfReport);
                    PaidCandelmasDaysUsed := VacMgmt.CalculatePaidCandelmasDaysUsed("No.", DateOfReport);
                    UnpaidCandelmasDaysUsed := VacMgmt.CalculateUnpaidCandelmasDaysUsed("No.", DateOfReport);

                    /*CurrDaysUsed:=CurrDaysUsed/8;
                    PaidCandelmasDaysUsed:=PaidCandelmasDaysUsed/8;
                    UnpaidCandelmasDaysUsed:=UnpaidCandelmasDaysUsed/8;*/
                    //ExYearDaysUsed:=VacMgmt.CalculateDaysUsed("No.",CALCDATE('<-1Y>',TODAY));
                    ExYearDaysUsed := VacMgmt.CalculateDaysUsed("No.", DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3) - 1));
                    /*ExYearDaysUsed:=(ExYearDaysUsed/8);*/
                    //sklonjeno dijeljenje sa 8

                    VPIskoristeno := VacMgmt.CalculatePaidCandelmasDaysUsed("No.", DateOfReport);
                    VPNeis := VacMgmt.CalculateUnpaidCandelmasDaysUsed("No.", DateOfReport);
                    Sum := 0;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_1');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    ;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_2');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    ;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_3');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_4');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_5');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_6');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'P_7');
                    //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
                    // EVALUATE(IDYear,DATE2DMY(Enddate,3));
                    /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
                       EVALUATE(StartDated,StartDateT);
                       EVALUATE(EndDated,EndDateT);*/
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    //Abcense.CALCSUMS(Abcense."Quantity (Base)");
                    Dani := Abcense.COUNT;
                    Sum := Sum + Dani;
                    Dani := 0;
                    VACSetup.GET('', Date2DMY(DateOfReport, 3));
                    IskOstaloP := Sum;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETRANGE("Cause of Absence Code Corr.", 'NU_1');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    IskOstaloNeP := Abcense.COUNT;
                    //IskOstaloNeP:=VACSetup."Paid Absence Quantity"-IskOstaloP;
                    //Cause of Absence;
                    TotalBo := 0;

                    CauseOfA.RESET;
                    CauseOfA.SETFILTER("Sick Leave", '%1', TRUE);
                    IF CauseOfA.FINDSET THEN
                        REPEAT
                            Abcense.RESET;
                            Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                            Abcense.SETRANGE("Employee No.", "No.");
                            Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', CauseOfA.Code);
                            StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                            EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                            Abcense.SETRANGE("From Date", StartDated, EndDated);
                            TotalBo := TotalBo + Abcense.COUNT;

                        UNTIL CauseOfA.NEXT = 0;

                    //B_10..B_14
                    Porod := 0;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'B_10');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Porod := Porod + Abcense.COUNT;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'B_11');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Porod := Porod + Abcense.COUNT;

                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'B_12');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Porod := Porod + Abcense.COUNT;

                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'B_13');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Porod := Porod + Abcense.COUNT;

                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'B_14');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Porod := Porod + Abcense.COUNT;

                    //SL_1
                    Sluzbeni := 0;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'SL_1');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Sluzbeni := Sluzbeni + Abcense.COUNT;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'SL_2');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Sluzbeni := Sluzbeni + Abcense.COUNT;



                    Praznik := 0;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'DR-PRAZNIK');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Praznik := Praznik + Abcense.COUNT;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'PR_1');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Praznik := Praznik + Abcense.COUNT;
                    //SP_1 //NU_2

                    Suspenzija := 0;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'SP_1');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Suspenzija := Suspenzija + Abcense.COUNT;
                    Neopravdano := 0;
                    Abcense.RESET;
                    Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
                    Abcense.SETRANGE("Employee No.", "No.");
                    Abcense.SETFILTER("Cause of Absence Code Corr.", '%1', 'NU_2');
                    StartDated := DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3));
                    EndDated := DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3));
                    Abcense.SETRANGE("From Date", StartDated, EndDated);
                    Neopravdano := Neopravdano + Abcense.COUNT;



                    FirstDate := AbsFill.GetMonthRange(DATE2DMY(DateOfReport, 2), DATE2DMY(DateOfReport, 3), TRUE);
                    LastDate := AbsFill.GetMonthRange(DATE2DMY(DateOfReport, 2), DATE2DMY(DateOfReport, 3), FALSE);
                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                    EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', FirstDate);
                    EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', LastDate);
                    EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                    IF SectorValue2 <> '' THEN
                        EmployeeContractLedger.SETFILTER("Sector Description", '%1', SectorValue2);
                    IF OdjelValue <> '' THEN
                        EmployeeContractLedger.SETFILTER("Department Cat. Description", '%1', OdjelValue);
                    IF GrupaValue <> '' THEN
                        EmployeeContractLedger.SETFILTER("Group Description", '%1', GrupaValue);
                    IF TimValue <> '' THEN
                        EmployeeContractLedger.SETFILTER("Team Description", '%1', TimValue);
                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                        HRSetup.GET;
                        IF EmployeeContractLedger."Contract Type Name" = HRSetup."External Description" THEN BEGIN
                            Sektor := '';
                            Odjel := '';
                            Grupa := '';
                            Tim := '';
                            EmployeeContractLedger.CALCFIELDS("Residence/Network");

                            Stream := '';
                            B1Regions := '';
                            Position := '';
                            Department := '';
                            B1 := '';
                            IDOJ := '';

                        END
                        ELSE BEGIN

                            Sektor := EmployeeContractLedger."Sector Description";
                            Odjel := EmployeeContractLedger."Department Cat. Description";
                            Grupa := EmployeeContractLedger."Group Description";
                            Tim := EmployeeContractLedger."Team Description";
                            EmployeeContractLedger.CALCFIELDS("Residence/Network");

                            Stream := EmployeeContractLedger."Group Description";
                            B1Regions := EmployeeContractLedger."Department Name";
                            Position := EmployeeContractLedger."Position Description";
                            Department := EmployeeContractLedger."Department Name";
                            B1 := EmployeeContractLedger."Sector Description";
                            IDOJ := EmployeeContractLedger."Department Code";
                        END;
                        wb.RESET;
                        wb.SETFILTER("Employee No.", "No.");
                        wb.SETFILTER("Current Company", '%1', TRUE);
                        wb.SETFILTER("Starting Date", '<=%1', DateOfReport);
                        wb.SETCURRENTKEY("Starting Date");
                        wb.ASCENDING;
                        IF wb.FINDLAST THEN BEGIN
                            EmploymentDate := wb."Starting Date"
                        END;

                    END
                    ELSE BEGIN
                        Sektor := '';
                        Odjel := '';
                        Grupa := '';
                        Tim := '';
                        EmployeeContractLedger.CALCFIELDS("Residence/Network");

                        Stream := '';
                        B1Regions := '';
                        Position := '';
                        Department := '';
                        B1 := '';
                        IDOJ := '';

                    END;
                    //CurrDaysLeft:=(CurrDays-CurrDaysUsed);

                    //EC01
                    CurrDaysLeft := (OsnovaGOtrenutna - CurrDaysUsed);
                    //EC01e
                    //ExyersDaysLeft:=(ExYearDays-ExYearDaysUsed);
                    //EC01
                    ExyersDaysLeft := (OsnovaGOprosla - ExYearDaysUsed);
                    //EC01e
                    /*
                    //IIPlanGO.RESET;
                    PlanGO.SETFILTER("Employee No.","No.");
                    PlanGO.SETFILTER(Year,FORMAT(lastYear));
                    IF PlanGO.FINDFIRST THEN
                      IF PlanGO."Valid Vacation"=TRUE THEN BEGIN
                       Valid:=TRUE;
                       Total:=CurrDaysLeft+ExyersDaysLeft;
                       IF ExyersDaysLeft<>0 THEN ValidName:=FORMAT(Valid)
                    ELSE ValidName:='Iskorišteno';
                       END;
                       END  ELSE BEGIN
                       Valid:=TRUE;
                       Total:=CurrDaysLeft+ExyersDaysLeft;
                       IF ExyersDaysLeft<>0 THEN ValidName:=FORMAT(Valid)
                    ELSE ValidName:='Iskorišteno';
                       END;
                    //END;*/

                    PlanGO.RESET;
                    PlanGO.SETFILTER("Employee No.", "No.");
                    PlanGO.SETFILTER(Year, FORMAT(lastYear));
                    IF PlanGO.FINDFIRST THEN
                        //ĐK    Valid := PlanGO."Valid Vacation";
                        Total := CurrDaysLeft + ExyersDaysLeft;
                END;


                MaxDays := 0;
                VG.SETFILTER("Employee No.", '%1', "No.");
                //đk   VG.CALCFIELDS("Max Days");
                //đk VG.SETFILTER("Max Days", '<>%1', 0);
                //IF VG.FIND('-') THEN BEGIN
                //  VG.CALCFIELDS("Max Days");
                // MaxDays := VG."Max Days";
                // Total Staff.SETFILTER("Employee No.", '%1', "No.");
                // Op.SETFILTER(Quantity, '%1', MaxDays);
                /*IF Op.FIND('-') THEN BEGIN
                IF Op."d1 start"=Op."Start Date" THEN MaxDays:=MaxDays-1;
                IF ((Op."d1 end"=Op."End Date") AND (Op."Start Date"<>Op."End Date")) THEN MaxDays:=MaxDays-1;
                IF Op."d2 start"=Op."Start Date" THEN MaxDays:=MaxDays-1;
                IF ((Op."d2 start"=CALCDATE('1D',Op."Start Date")) AND (Op."d1 start"=Op."Start Date")) THEN MaxDays:=MaxDays-1;
                IF ((Op."d2 end"=Op."End Date") AND (Op."Start Date"<>Op."End Date")) THEN MaxDays:=MaxDays-1;
                IF ((Op."d2 end"=CALCDATE('-1D',Op."End Date")) AND (Op."d2 end"=Op."End Date")) THEN MaxDays:=MaxDays-1;
                IF Op."v1 start"=Op."Start Date" THEN MaxDays:=MaxDays-1;
                IF ((Op."v1 end"=Op."End Date")  AND (Op."Start Date"<>Op."End Date")) THEN MaxDays:=MaxDays-1;
                IF Op."v2 start"=Op."Start Date" THEN MaxDays:=MaxDays-1;
                IF ((Op."v2 start"=CALCDATE('1D',Op."Start Date")) AND (Op."d2 start"=Op."Start Date")) THEN MaxDays:=MaxDays-1;
                IF ((Op."v2 end"=Op."End Date") AND (Op."Start Date"<>Op."End Date")) THEN MaxDays:=MaxDays-1;
                IF ((Op."v2 end"=CALCDATE('-1D',Op."End Date")) AND (Op."v2 end"=Op."End Date")) THEN MaxDays:=MaxDays-1;
                VDays:=0;
                ECLD.SETFILTER("Employee No.",'%1',"No.");
                ECLD.SETFILTER("From Date",'%1..%2',CALCDATE('1D',Op."Start Date"),CALCDATE('-1D',Op."End Date"));
                ECLD.SETFILTER("Cause of Absence Code Corr.",'%1|%2','D*','VPL-O');
                IF ECLD.FINDSET THEN BEGIN
                VDays:=ECLD.COUNT;
                END;

                MaxDays:=MaxDays-VDays;
                END;*/
                //   END
                // ELSE BEGIN
                //   MaxDays := 0;
                // END;

            end;

            trigger OnPreDataItem()
            begin

                OpRisk.DeleteAll();

                //mogu uzeti show zapis ukoliko je zaposlenik prema ugovoru bio to što jest na taj datum
                //SETFILTER(Status,'%1|%2',0,1);
                SETFILTER(Associates, '%1', FALSE);
                //SETFILTER("Potential Employee",'%1',FALSE);
                EA.SETFILTER("Vacation from Year", '%1', DATE2DMY(DateOfReport, 3));
                IF EA.FIND('-') THEN
                    REPEAT
                        EA.VALIDATE("Vacation from Year", EA."Vacation from Year");
                        EA.MODIFY;
                    UNTIL EA.NEXT = 0;

                IF ECL2.FINDFIRST THEN
                    REPEAT

                        IF ((ECL2."Ending Date" = 0D) OR (ECL2."Ending Date" > DMY2DATE(31, 12, DATE2DMY(DateOfReport, 3)))) THEN
                            ECL2."Report Ending Date" := TODAY
                        ELSE
                            ECL2."Report Ending Date" := ECL2."Ending Date";
                        ECL2.MODIFY;
                    UNTIL ECL2.NEXT = 0;

                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                i := 0;


                IF Employee2.FINDFIRST THEN
                    REPEAT

                        d1start := 0D;
                        d1end := 0D;
                        d2start := 0D;
                        d2end := 0D;
                        v1start := 0D;
                        v1end := 0D;
                        v2start := 0D;
                        v2end := 0D;


                        EA.RESET;
                        EA1.RESET;
                        //EA.SETFILTER("Vacation from Year",'%1|%2',0,Year);
                        EA.SETFILTER("Cause of Absence Code Corr.", '%1|%2|%3', 'GOD*', 'D*', 'VPL-O');
                        //EA.SETFILTER("Cause of Absence Code Corr.",'%1','GOD*');
                        EA.SETFILTER("Vacation from Year", '%1|%2', 0, DATE2DMY(DateOfReport, 3) - 1);
                        EA.SETFILTER("Employee No.", '%1', Employee2."No.");
                        EA.SETFILTER("From Date", '%1..%2', DMY2DATE(1, 1, DATE2DMY(DateOfReport, 3)), DateOfReport);
                        EA.SETCURRENTKEY("Employee No.", "From Date");
                        EA.ASCENDING;
                        IF EA.FINDFIRST THEN
                            REPEAT
                                counter := 0;
                                TotalDaysP := 0;
                                TotalDaysD := 0;
                                StartDate := EA."From Date";
                                wd := DATE2DWY(StartDate, 1);
                                TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                                IF VocCount = 1 THEN StartDateI := EA."From Date";
                                IF (wd > 5) THEN
                                    TotalDays -= (wd - 5);
                                EA1 := EA;
                                EA1.COPYFILTERS(EA);
                                EA1.SETCURRENTKEY("Employee No.", "From Date");
                                EA1.ASCENDING;
                                EA1.NEXT(1);
                                EndDate := EA1."From Date";
                                IF
                                   ((COPYSTR(EA."Cause of Absence Code Corr.", 1, 1) = 'D')) THEN BEGIN
                                    IF TotalDaysD = 0 THEN BEGIN
                                        d1start := EA."From Date";
                                        d1end := EA."From Date";
                                    END;
                                    IF ((TotalDaysD <> 0) AND (d1start <> 0D)) THEN BEGIN
                                        d2start := EA."From Date";

                                        d2end := EA."From Date";
                                    END;
                                    TotalDaysD += 1;
                                END;
                                IF
                                   ((COPYSTR(EA."Cause of Absence Code Corr.", 1, 1) = 'V')) THEN BEGIN
                                    IF TotalDaysP = 0 THEN BEGIN
                                        v1start := EA."From Date";
                                        v1end := EA."From Date";
                                    END;
                                    IF ((TotalDaysD <> 0) AND (v1start <> 0D) AND (v1start <> EA."From Date")) THEN BEGIN
                                        v2start := EA."From Date";

                                        v2end := EA."From Date";
                                    END;
                                    TotalDaysP += 1;
                                END;


                                IF (EndDate = StartDate + TotalDays) THEN
                                    IF
                                    ((COPYSTR(EA."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                                     THEN
                                        counter += 1
                                    ELSE
                                        VocCount += 1

                                ELSE BEGIN

                                    IF ((VocCount >= 1) AND (counter = 0)) THEN BEGIN

                                        OpRisk.INIT;
                                        OpRisk."Search Name" := 'Oprisk';
                                        OpRisk.Order := LineNo;
                                        OpRisk."Employee No." := Employee2."No.";
                                        OpRisk."Years of Experience" := VocCount;
                                        OpRisk."Starting Date" := StartDateI;
                                        OpRisk."Ending Date" := StartDate;
                                        OpRisk."Months of Exp. in Company" := TotalDaysP;
                                        OpRisk."Days of Experience" := TotalDaysD;
                                        // OpRisk."d1 start":=d1start;
                                        // OpRisk."d1 end":=d1end;
                                        // OpRisk."d2 start":=d2start;
                                        // OpRisk."d2 end":=d2end;
                                        /*     OpRisk."v1 start":=v1start;
                                          OpRisk."v1 end":=v1end;
                                          OpRisk."v2 start":=v2start;
                                           OpRisk."v2 end":=v2end;
                                         OpRisk.INSERT;*/
                                        LineNo += 1;
                                    END;
                                    VocCount := 1;
                                END;


                            UNTIL (EA.NEXT = 0);

                        VocCount := 1;
                    // DataItem1.NEXT(1);

                    UNTIL (Employee2.NEXT = 0);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Year; DateOfReport)
                {
                    ApplicationArea = all;
                    Caption = 'Date Of Report';
                }
                field(EmployeeStatus; EmployeeStatus)
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Employee Status';
                    Description = 'Active,Inactive,Unpaid,Terminated,On boarding,Practicians,Trainee,Student,Agency,Temporary Contract,Student Service,Volonteer,External employee';
                    OptionCaption = 'Active,Inactive,Unpaid,Terminated,On boarding,Practicians,Trainee,Student,Agency,Temporary Contract,Student Service,Volonteer,External employee';
                }
                field(SectorValue2; SectorValue2)
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Sector Value';
                    //OptionCaption = 'SectorValue';
                    TableRelation = Sector.Description;
                }
                field(OdjelValue; OdjelValue)
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Odjel Value';
                    //   OptionCaption = 'Odjel Value';
                    TableRelation = "Department Category".Description;
                }
                field(GrupaValue; GrupaValue)
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Grupa Value';
                    //  OptionCaption = 'Grupa Value';
                    TableRelation = Group.Description;
                }
                field(TimValue; TimValue)
                {
                    Caption = 'Tim';
                    Visible = false;
                    ApplicationArea = all;
                    //   OptionCaption = 'TimValue';
                    TableRelation = Team.Name;
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
        DateOfReport := TODAY;
    end;

    trigger OnPreReport()
    begin
        OpRisk.DELETEALL;
    end;

    var
        UnpaidCandelmasDaysUsed: Integer;
        PaidCandelmasDaysUsed: Integer;
        CurrDays: Integer;
        CurrDaysUsed: Integer;
        CurrDaysLeft: Integer;
        OdjelValue: Text;
        GrupaValue: Text;
        ExYearDays: Integer;
        ExYearDaysUsed: Integer;
        SectorValue2: Text;
        EmployeeStatus: Option;
        TimValue: Text;
        SectorValue: Text;
        ExYearDaysLeft: Integer;
        Valid: Boolean;
        Total: Integer;
        VacMgmt: Codeunit "VacationMgmt2";
        "Sum": Integer;
        VACSetup: Record "Vacation Setup history";
        AbsFill: Codeunit "Absence Fill";
        FirstDate: Date;
        LastDate: Date;
        ExyersDaysLeft: Integer;
        OsnovaGOtrenutna: Integer;
        OsnovaGOprosla: Integer;
        PlanGO: Record "Vacation Ground 2";
        TodayDate: Date;
        CauseOfA: Record "Cause of Absence";
        currentYear: Integer;
        StartDated: Date;
        Dani: Integer;
        IskOstaloP: Integer;
        Abcense: Record "Employee Absence";
        lastYear: Integer;
        WPConnSetup: Record "Web portal connection setup";
        Praznik: Integer;

        Porod: Integer;

        EndDated: Date;
        Sluzbeni: Integer;

        TotalBo: Integer;
        lvarActiveConnection: Variant;

        VPIskoristeno: Integer;
        Neopravdano: Integer;
        Suspenzija: Integer;
        Sektor: Text;
        Odjel: Text;
        Grupa: Text;
        IskOstaloNeP: Integer;
        VPNeis: Integer;
        Tim: Text;

        lvarActiveConnectionI: Variant;

        lvarActiveConnectionD: Variant;
        ValidName: Text;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        Stream: Text;
        B1Regions: Text;
        Position: Text;
        Department: Text;
        B1: Text;
        IDOJ: Text;
        EmploymentDate: Date;
        wb: Record "Work Booklet";
        B1F: Text;
        StreamF: Text;
        ECL2: Record "Employee Contract Ledger";
        TotalDaysP: Integer;
        StartDateI: Date;
        d1start: Date;
        v1start: Date;
        d1end: Date;
        v1end: Date;
        d2start: Date;
        d2end: Date;
        v2start: Date;
        v2end: Date;
        //Op: Record "OpRisk";
        ECLD: Record "Employee Absence";
        VDays: Integer;
        WorkDays: Integer;
        VocCount: Integer;
        i: Integer;
        LineNo: Integer;
        EA: Record "Employee Absence";
        OpRisk: Record Employee temporary;
        EA1: Record "Employee Absence";
        Employee2: Record "Employee";
        counter: Integer;
        TotalDaysD: Integer;
        StartDate: Date;
        wd: Integer;
        TotalDays: Integer;
        EndDate: Date;
        DateOfReport: Date;
        MaxDays: Integer;
        VG: Record "Vacation Ground 2";
        HRSetup: Record "Human Resources Setup";
}

