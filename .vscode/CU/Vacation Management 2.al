codeunit 50006 VacationMgmt2
{

    trigger OnRun()
    begin
    end;

    var
        VacationSetup: Record "Vacation setup history";
        Text001: Label 'Morate ';
        Employee: Record "Employee";
        Wbb: Record "Work Booklet";

    procedure CalculateDays(EmployeeNo: Code[20]; EndDate: Date): Integer
    var
        VacDays: Integer;
    begin
        //ENDDATE
        CheckSetup(EndDate);
        Employee.GET(EmployeeNo);
        //Employee.TESTFIELD("Position Code");

        VacDays := VacationSetup."Base Days" + CalculatePreviousExp(EmployeeNo, EndDate) + CalculateCurrExp(EmployeeNo, EndDate);
        VacDays := CheckMaximum(Employee."Position Code", VacDays);
        EXIT(VacDays);
    end;

    procedure CalculateDaysUsed(EmployeeNo: Code[20]; Enddate: Date): Integer
    var
        Employee: Record "Employee";
        Abcense: Record "Employee Absence";
        Dani: Integer;
    begin
        Dani := 0;
        Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
        Abcense.SETRANGE("Employee No.", EmployeeNo);
        VacationSetup.GET('', DATE2DMY(Enddate, 3));
        //Abcense.SETRANGE("Cause of Absence Code Corr.",VacationSetup."Vacation Code");
        Abcense.SETRANGE("Vacation from Year", DATE2DMY(Enddate, 3));
        Wbb.RESET;
        Wbb.SETFILTER("Employee No.", '%1', EmployeeNo);
        Wbb.SETFILTER("Current Company", '%1', TRUE);
        Wbb.SETFILTER("Hours change", '%1', FALSE);
        IF DATE2DMY(Enddate, 3) = DATE2DMY(TODAY, 3) THEN
            Wbb.SETFILTER("Starting Date", '<=%1', TODAY)
        ELSE
            Wbb.SETFILTER("Starting Date", '<=%1', Enddate);
        Wbb.SETCURRENTKEY("Starting Date");
        Wbb.ASCENDING;

        IF Wbb.FINDLAST THEN
            Abcense.SETFILTER("From Date", '>=%1', Wbb."Starting Date");
        //Abcense.CALCSUMS(Abcense.Quantity);
        Dani := Abcense.COUNT;
        //MESSAGE(Abcense."Employee No."+' '+FORMAT(Dani)+' '+FORMAT(Abcense."Cause of Absence Code Corr.")+' '+FORMAT(VacationSetup."Vacation Code")+' '+FORMAT(DATE2DMY(Enddate,3)));
        EXIT(Dani);
    end;

    procedure CheckMaximum(EmployeePosition: Code[20]; Days: Integer): Integer
    var
    //ĐK  VacPosition: Record "Vacation By Position";
    begin
        /*  IF NOT VacPosition.GET(EmployeePosition) THEN
                 IF NOT VacPosition.GET('') THEN EXIT(Days);

             IF Days > VacPosition."Maximum Vacation Days" THEN
                 EXIT(VacPosition."Maximum Vacation Days")
             ELSE*/

        EXIT(Days)
    end;

    procedure CheckSetup(DateOfReport: Date)
    begin
        // VacationSetup.GET('', Date2DMY(ReportDate));
        VacationSetup.GET('', Date2DMY(DateOfReport, 3));
        //VacationSetup.TESTFIELD("Vacation Code");
        VacationSetup.TESTFIELD("Min. of Previous Exp. (Years)");
        VacationSetup.TESTFIELD("Days for previous exp.");
        VacationSetup.TESTFIELD("Min. of Curr. Exp. (Years)");
        VacationSetup.TESTFIELD("Days for current exp.");
        VacationSetup.TESTFIELD("Base Days");
    end;

    procedure CalculatePreviousExp(EmployeeNo: Code[20]; Enddate: Date): Integer
    var
        EmployeeQualification: Record "Employee Qualification";
        PE: Integer;
        DateMin: Date;
        DateMax: Date;
    begin
        EmployeeQualification.SETCURRENTKEY(EmployeeQualification."Employee No.",
          EmployeeQualification.Type, EmployeeQualification."From Date", EmployeeQualification."To Date");
        EmployeeQualification.SETRANGE("Employee No.", EmployeeNo);
        //EmployeeQualification.SETRANGE(Holding,FALSE);
        EmployeeQualification.SETRANGE(Type, EmployeeQualification.Type::"Previous Position");

        EmployeeQualification.SETFILTER(EmployeeQualification."From Date", '<=%1', Enddate);
        //EmployeeQualification.SETfilter(EmployeeQualification."To Date",'<=%1',enddate);


        IF NOT EmployeeQualification.ISEMPTY THEN BEGIN
            IF EmployeeQualification.FIND('-') THEN DateMin := EmployeeQualification."From Date";
            IF EmployeeQualification.FIND('+') THEN DateMax := EmployeeQualification."To Date";
        END
        ELSE
            EXIT(0);

        IF (DateMax <= Enddate) AND (DateMax <> 0D) THEN
            PE := YearCalculation(DateMin, DateMax)
        ELSE
            PE := YearCalculation(DateMin, Enddate);

        IF PE >= VacationSetup."Min. of Previous Exp. (Years)" THEN
            EXIT(VacationSetup."Days for previous exp." * (PE DIV VacationSetup."Min. of Previous Exp. (Years)"))
        ELSE
            EXIT(0);
    end;

    procedure CalculateCurrExp(EmployeeNo: Code[20]; Enddate: Date): Integer
    var
        EmployeeQualification: Record "Employee Qualification";
        CE: Integer;
        dateMin: Date;
        dateMax: Date;
    begin
        EmployeeQualification.SETCURRENTKEY(EmployeeQualification."Employee No.",
          EmployeeQualification.Type, EmployeeQualification."From Date", EmployeeQualification."To Date");

        EmployeeQualification.SETRANGE("Employee No.", EmployeeNo);
        //EmployeeQualification.SETRANGE(Holding,TRUE);

        EmployeeQualification.SETFILTER(EmployeeQualification."From Date", '<=%1', Enddate);


        IF NOT EmployeeQualification.ISEMPTY THEN BEGIN
            IF EmployeeQualification.FIND('-') THEN dateMin := EmployeeQualification."From Date";
            IF EmployeeQualification.FIND('+') THEN dateMax := EmployeeQualification."To Date";

            IF (dateMax <> 0D) AND (dateMax <= Enddate) THEN CE := YearCalculation(dateMin, dateMax)

        END;

        IF Employee."Employment Date" <= Enddate THEN
            CE += YearCalculation(Employee."Employment Date", Enddate)
        ELSE
            EXIT(0);
        IF CE >= VacationSetup."Min. of Curr. Exp. (Years)" THEN
            EXIT(VacationSetup."Days for current exp." * (CE DIV VacationSetup."Min. of Curr. Exp. (Years)"))
        ELSE
            EXIT(0)


        //Counting previous exp. + current in holding
    end;

    procedure YearCalculation(StartDate: Date; EndDate: Date): Integer
    var
        recDate: Record "Date";
        CountYears: Integer;
        LastFoundDate: Date;
        TempDate: Date;
        TotalDays: Integer;
        Found: Boolean;
    begin
        CountYears := 0;
        IF StartDate = 0D THEN EXIT(0);
        recDate.RESET;
        recDate.SETRANGE("Period Type", recDate."Period Type"::Date);
        recDate.SETRANGE("Period Start", StartDate, EndDate);

        TotalDays := recDate.COUNT;          // only for information

        IF recDate.FINDSET THEN BEGIN

            LastFoundDate := StartDate;

            // *** find count of years ***

            TempDate := CALCDATE('<+1Y>', StartDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (recDate.GET(recDate."Period Type"::Date, TempDate)) THEN BEGIN
                    CountYears += 1;
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('<+1Y>', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

        END;
        EXIT(CountYears);
    end;

    procedure MonthCalculation(StartDate: Date; EndDate: Date): Integer
    var
        recDate: Record "Date";
        CountMonths: Integer;
        LastFoundDate: Date;
        TempDate: Date;
        TotalDays: Integer;
        Found: Boolean;
    begin
        CountMonths := 0;
        recDate.RESET;
        recDate.SETRANGE("Period Type", recDate."Period Type"::Date);
        recDate.SETRANGE("Period Start", StartDate, EndDate);

        TotalDays := recDate.COUNT;          // only for information

        IF recDate.FINDSET THEN BEGIN

            LastFoundDate := StartDate;

            // *** find count of years ***
            TempDate := CALCDATE('<+1Y>', StartDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (recDate.GET(recDate."Period Type"::Date, TempDate)) THEN BEGIN
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('<+1Y>', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

            // *** find count of months ***
            TempDate := CALCDATE('<+1M>', LastFoundDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (recDate.GET(recDate."Period Type"::Date, TempDate)) THEN BEGIN
                    CountMonths += 1;
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('<+1M>', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

        END;
        EXIT(CountMonths);
    end;

    procedure DayCalculation(StartDate: Date; EndDate: Date): Integer
    var
        recDate: Record "Date";
        CountDays: Integer;
        LastFoundDate: Date;
        TempDate: Date;
        TotalDays: Integer;
        Found: Boolean;
        CountMonths: Integer;
        CountYears: Integer;
    begin
        CountDays := 0;
        recDate.RESET;
        recDate.SETRANGE("Period Type", recDate."Period Type"::Date);
        recDate.SETRANGE("Period Start", StartDate, EndDate);

        TotalDays := recDate.COUNT;          // only for information

        IF recDate.FINDSET THEN BEGIN

            LastFoundDate := StartDate;
            // *** find count of years ***
            TempDate := CALCDATE('<+1Y>', StartDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (recDate.GET(recDate."Period Type"::Date, TempDate)) THEN BEGIN
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('<+1Y>', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

            // *** find count of months ***
            TempDate := CALCDATE('<+1M>', LastFoundDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (recDate.GET(recDate."Period Type"::Date, TempDate)) THEN BEGIN
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('<+1M>', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;

            // *** find count of days ***
            TempDate := CALCDATE('<+1D>', LastFoundDate);
            Found := TRUE;

            REPEAT
                IF (TempDate <= EndDate) AND (recDate.GET(recDate."Period Type"::Date, TempDate)) THEN BEGIN
                    CountDays += 1;
                    LastFoundDate := TempDate;
                    TempDate := CALCDATE('<+1D>', TempDate);
                END ELSE
                    Found := FALSE;
            UNTIL NOT Found;
        END;
        EXIT(CountDays);
    end;

    procedure CalcStartDate(Sd: Date; Endate: Date): Date
    var
        M: Integer;
        D: Integer;
        Y: Integer;
    begin
        Y := DATE2DMY(Endate, 3);
        M := DATE2DMY(Sd, 2);
        D := DATE2DMY(Sd, 1) + 1;
        EXIT(DMY2DATE(D, M, Y));
    end;

    procedure CalculatePaidCandelmasDaysUsed(EmployeeNo: Code[20]; Enddate: Date): Integer
    var
        Employee: Record "Employee";
        Abcense: Record "Employee Absence";
        IDYear: Text[10];
        StartDateT: Text[30];
        StartDated: Date;
        EndDateT: Text;
        EndDated: Date;
        Dani: Integer;
    begin
        Dani := 0;
        Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
        Abcense.SETRANGE("Employee No.", EmployeeNo);
        Abcense.SETRANGE("Cause of Absence Code Corr.", VacationSetup."Paid Candelmas Code");
        //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
        //EVALUATE(IDYear,DATE2DMY(Enddate,3));
        /* StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);   //FORMAT(DATE2DMY(Enddate,3));
         EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);   //FORMAT(DATE2DMY(Enddate,3));
         EVALUATE(StartDated,StartDateT);
         EVALUATE(EndDated,EndDateT);*/
        StartDated := DMY2DATE(1, 1, DATE2DMY(Enddate, 3));
        EndDated := DMY2DATE(31, 12, DATE2DMY(Enddate, 3));
        Abcense.SETRANGE("From Date", StartDated, EndDated);
        //Abcense.CALCSUMS(Abcense."Quantity (Base)");
        Dani := Abcense.COUNT;
        EXIT(Dani);

    end;

    procedure CalculateUnpaidCandelmasDaysUsed(EmployeeNo: Code[20]; Enddate: Date): Integer
    var
        Employee: Record "Employee";
        Abcense: Record "Employee Absence";
        IDYear: Text[10];
        StartDateT: Text[30];
        StartDated: Date;
        EndDateT: Text;
        EndDated: Date;
        Dani: Integer;
    begin

        Dani := 0;
        Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Code Corr.", Abcense."Vacation from Year");
        Abcense.SETRANGE("Employee No.", EmployeeNo);
        Abcense.SETRANGE("Cause of Absence Code Corr.", VacationSetup."Unpaid Candelmas Code");
        //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
        // EVALUATE(IDYear,DATE2DMY(Enddate,3));
        /*   StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
           EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);                   //FORMAT(DATE2DMY(Enddate,3));
           EVALUATE(StartDated,StartDateT);
           EVALUATE(EndDated,EndDateT);*/
        StartDated := DMY2DATE(1, 1, DATE2DMY(Enddate, 3));
        EndDated := DMY2DATE(31, 12, DATE2DMY(Enddate, 3));
        Abcense.SETRANGE("From Date", StartDated, EndDated);
        //Abcense.CALCSUMS(Abcense."Quantity (Base)");
        Dani := Abcense.COUNT;
        EXIT(Dani);

    end;

    procedure CalculatePaidDaysUsed(EmployeeNo: Code[20]; Enddate: Date; "Code": Code[10]): Integer
    var
        Employee: Record "Employee";
        Abcense: Record "Employee Absence";
        IDYear: Text[10];
        StartDateT: Text[30];
        StartDated: Date;
        EndDateT: Text;
        EndDated: Date;
        Dani: Integer;
    begin
        Dani := 0;
        Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Subtype Corr.", Abcense."From Date");
        Abcense.SETRANGE("Employee No.", EmployeeNo);
        Abcense.SETRANGE("Cause of Absence Code Corr.", Code);
        //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
        //EVALUATE(IDYear,DATE2DMY(Enddate,3));
        /*  StartDateT:='0101'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);              //FORMAT(DATE2DMY(Enddate,3));
          EndDateT:='1231'+ COPYSTR(FORMAT(DATE2DMY(Enddate,3)),3,2);             //FORMAT(DATE2DMY(Enddate,3));
          EVALUATE(StartDated,StartDateT);
          EVALUATE(EndDated,EndDateT);*/
        StartDated := DMY2DATE(1, 1, DATE2DMY(Enddate, 3));
        EndDated := DMY2DATE(31, 12, DATE2DMY(Enddate, 3));
        Abcense.SETRANGE("From Date", StartDated, EndDated);
        //Abcense.CALCSUMS(Abcense."Quantity (Base)");
        Dani := Abcense.COUNT;
        EXIT(Dani);

    end;

    procedure CalculateBloodDays(EmployeeNo: Code[20]; Enddate: Date): Integer
    var
        Employee: Record "Employee";
        Abcense: Record "Employee Absence";
        IDYear: Text[10];
        StartDateT: Text[30];
        StartDated: Date;
        EndDateT: Text;
        EndDated: Date;
        EBD: Record "Employee Diseases";
        allowedDays: Integer;
    begin
        //EBD.SETCURRENTKEY(EBD."Employee No.",Abcense."Cause of Absence Subtype Corr.",Abcense."From Date");
        EBD.SETRANGE("Employee No.", EmployeeNo);
        EBD.SetFilter(Types, '%1', EBD.Types::"Employee Bood Donations");


        StartDated := DMY2DATE(1, 1, DATE2DMY(Enddate, 3));
        EndDated := DMY2DATE(31, 12, DATE2DMY(Enddate, 3));
        EBD.SETRANGE(Date, StartDated, EndDated);
        allowedDays := EBD.COUNT;

        EXIT(allowedDays);
    end;

    procedure CalculateBloodDaysUsed(EmployeeNo: Code[20]; Enddate: Date; "Code": Code[10]): Integer
    var
        Employee: Record "Employee";
        Abcense: Record "Employee Absence";
        IDYear: Text[10];
        StartDateT: Text[30];
        StartDated: Date;
        EndDateT: Text;
        EndDated: Date;
        Dani: Integer;
    begin

        Dani := 0;
        Abcense.SETCURRENTKEY(Abcense."Employee No.", Abcense."Cause of Absence Subtype Corr.", Abcense."From Date");
        Abcense.SETRANGE("Employee No.", EmployeeNo);
        Abcense.SETRANGE("Cause of Absence Subtype Corr.", Code);
        //Abcense.SETRANGE("Vacation from Year",DATE2DMY(Enddate,3));
        //EVALUATE(IDYear,DATE2DMY(Enddate,3));

        StartDated := DMY2DATE(1, 1, DATE2DMY(Enddate, 3));
        EndDated := DMY2DATE(31, 12, DATE2DMY(Enddate, 3));
        Abcense.SETRANGE("From Date", StartDated, EndDated);
        //Abcense.CALCSUMS(Abcense."Quantity (Base)");
        Dani := Abcense.COUNT;
        EXIT(Dani);
    end;
}

