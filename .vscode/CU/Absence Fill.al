codeunit 50011 "Absence Fill"
{

    trigger OnRun()
    begin
    end;

    var
        Calendar: Record "Base Calendar";
        PathHelper: DotNet Path;
        Text007: Label 'Import';
        SingleFilterErr: Label 'Specify a file filter and an extension filter when using this function.';
        AllFilesFilterTxt: Label '*.*', Locked = true;
        UnsupportedFileExtErr: Label 'Unsupported file extension (.%1). The supported file extensions are (%2).';
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        WA: Record "Wage Addition";
        WA2: Record "Wage Addition";
        //    IB: Record "Wage Addition IB";
        WAIB: Record "Wage Addition";
        WAIB2: Record "Wage Addition";

        //   WAP: Record "Wage Addition SD";
        WASD: Record "Wage Addition";
        WASD2: Record "Wage Addition";
        StartDateWA: Date;
        VaactionG: record "Vacation Ground 2";
        CalendarChange: Record "Base Calendar Change";
        Datum: Record "Date";
        StartDate: Date;
        EndDate: Date;
        Cause: Record "Cause of Absence";
        LastEntry: Integer;
        WageSetup: Record "Wage Setup";

        DailyHours1: Decimal;
        LastArray: Integer;
        AddArray: Boolean;
        I: Integer;
        Post: Record "Post Code";
        Header: Record "Wage Header";
        WageType: Record "Wage Type";
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        Txt001: Label 'No Wages Calendar chosen!';
        Txt002: Label 'No employees marked For Calculation!';
        Txt003: Label 'Transport is partially calculated and can''t be changed!';
        Txt004: Label 'This transportation was already paid. No changes are possible.';
        Txt005: Label 'First enter the transport header information.';
        Txt006: Label 'Employee has no Post Code entered.';
        Txt007: Label 'Meal is partially calculated and can''t be changed!';
        Txt008: Label 'This transportation was already paid. No changes are possible.';
        Txt009: Label 'First enter the meal header information.';
        ConCat: Record "Contribution Category";
        TRL: Record "Transport Line";
        ML: Record "Meal Line";
        wb: Record "Work Booklet";
        wb2: Record "Work Booklet";



    procedure CheckCalendar(var InsertIt: Boolean; Recurrence: Integer)
    begin
        InsertIt := TRUE;
        CalendarChange.RESET;
        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);
        CalendarChange.SETFILTER(CalendarChange."Recurring System", '%1', Recurrence);
        IF Recurrence = 1 THEN
            CalendarChange.SETFILTER(CalendarChange.Date, FORMAT(Datum."Period Start"))
        ELSE
            CalendarChange.SETFILTER(CalendarChange.Day, '%1', Datum."Period No.");

        IF CalendarChange.FINDFIRST THEN
            IF Recurrence = 1 THEN
                InsertIt := CalendarChange."Paid Holiday"
            ELSE
                InsertIt := NOT (CalendarChange.Nonworking);

    end;


    procedure FillAbsence(CurrentMonth: Integer; CurrentYear: Integer; var Employee: Record "Employee")
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence";
        AbsenceTemp: Record "Employee Absence" temporary;
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        TempEntry: Integer;
        EmploymentContract: Record "Employment Contract";
        HoursInDay: Decimal;
    begin
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;
        AbsenceTemp.RESET;
        AbsenceTemp.DELETEALL;

        StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
        EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";


        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        AbsenceEmp.RESET;
        IF AbsenceEmp.FIND('+') THEN
            LastEntry := AbsenceEmp."Entry No."
        ELSE
            LastEntry := 0;
        LastEntry := LastEntry + 1;

        Datum.RESET;
        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate, EndDate);
        Datum.FINDFIRST;

        TempEntry := 1;



        REPEAT

            InsertAnnual := FALSE;
            InsertWeekly := FALSE;

            CheckCalendar(InsertAnnual, 1);
            CheckCalendar(InsertWeekly, 2);

            IF InsertWeekly THEN begin
                WITH AbsenceTemp DO BEGIN
                    INIT;
                    "Entry No." := TempEntry;
                    "Employee No." := '';
                    "From Date" := Datum."Period Start";
                    "To Date" := Datum."Period Start";
                    IF InsertAnnual THEN BEGIN
                        "Cause of Absence Code" := WageSetup."Workday Code";
                        Description := WageSetup."Workday Description";
                        "RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        "Cause of Absence Code" := WageSetup."Holiday Code";
                        Description := WageSetup."Holiday Description";
                        "RS Code" := RSHoliday;
                    END;

                    Quantity := Employee."Hours In Day";


                    "Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    INSERT;
                END;
                TempEntry := TempEntry + 1;

            end;
        UNTIL Datum.NEXT = 0;

        EmploymentContract.RESET;

        CurrRecNo := 0;
        TotalRecNo := Employee.COUNTAPPROX;

        Window.OPEN('Obrada radnih sati\@1@@@@@@@@@@@@@@@@@@@@@  :: Radnici\');
        Window.UPDATE(1, 0);


        IF Employee.FINDFIRST THEN
            REPEAT

                /*Obrada korekcija u RAIF_u
                     CurrRecNo += 1;
                     Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                     wb.SETFILTER("Employee No.", '%1', Employee."No.");
                     wb.SETFILTER("Current Company", '%1', TRUE);
                     IF Employee."Returned to Company" THEN BEGIN
                         IF wb.FIND('-') THEN BEGIN
                             IF (((wb."Ending Date" > StartDate))) then begin //ĐKOR ((wb."Ending Date">010115D) AND (wb."Ending Date"<311215D)))) THEN BEGIN
                                 IF (wb."Starting Date" >= StartDate) THEN
                                     FromDateFilter := wb."Starting Date"
                                 ELSE
                                     FromDateFilter := StartDate;
                             END;
                             //  MESSAGE(Employee."No.");
                             //MESSAGE(FORMAT(FromDateFilter));
                         END

                     END;

                     IF NOT Employee."Returned to Company" THEN BEGIN
                         IF wb.FIND('+') THEN BEGIN
                             IF (wb."Starting Date" >= StartDate) THEN
                                 FromDateFilter := wb."Starting Date"
                             ELSE
                                 FromDateFilter := StartDate;
                         END;
                     END;
                     wb2.SETFILTER("Employee No.", '%1', Employee."No.");
                     wb2.SETFILTER("Current Company", '%1', TRUE);
                     IF wb2.FIND('+') THEN BEGIN
                         IF (wb2."Ending Date" <= EndDate) THEN
                             ToDateFilter := wb2."Ending Date"
                         ELSE
                             ToDateFilter := EndDate;
                     END;



                     AbsenceTemp.RESET;
                     AbsenceTemp.SETRANGE("From Date", FromDateFilter, ToDateFilter);
                     IF AbsenceTemp.FINDFIRST THEN
                         REPEAT
                             AbsenceEmp.RESET;
                             AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                             AbsenceEmp.SETRANGE("From Date", AbsenceTemp."From Date");
                             InsertDay := TRUE;
                             IF AbsenceEmp.FINDFIRST THEN
                                 REPEAT
                                     Cause.GET(AbsenceEmp."Cause of Absence Code");
                                     InsertDay := InsertDay AND Cause."Added To Hour Pool"; //boolean +
                                 UNTIL AbsenceEmp.NEXT = 0;
                             IF InsertDay THEN BEGIN
                                 AbsenceEmp.TRANSFERFIELDS(AbsenceTemp);
                                 AbsenceEmp."Entry No." := LastEntry;
                                 AbsenceEmp."Employee No." := Employee."No.";

                                 AbsenceEmp."Statistics Group Code" := Employee."Statistics Group Code";

                                 IF HoursInDay <> 0 THEN
                                     AbsenceEmp.Quantity := HoursInDay;

                                 AbsenceEmp.INSERT;
                                 LastEntry := LastEntry + 1;
                             END;
                         UNTIL AbsenceTemp.NEXT = 0;
                 UNTIL Employee.NEXT = 0
             ELSE BEGIN
                 Window.CLOSE;
                 MESSAGE(Txt002);
                 EXIT;
             END;

             Window.CLOSE;
         end;*/
                IF (Employee."Employment Date" <= EndDate) AND (Employee."Employment Date" >= StartDate) THEN
                    FromDateFilter := Employee."Employment Date"
                ELSE
                    FromDateFilter := StartDate;
                IF (Employee."Termination Date" <= EndDate) AND (Employee."Termination Date" >= StartDate) THEN
                    ToDateFilter := Employee."Termination Date"
                ELSE
                    ToDateFilter := EndDate;

                AbsenceTemp.RESET;
                AbsenceTemp.SETRANGE("From Date", FromDateFilter, ToDateFilter);
                IF AbsenceTemp.FINDFIRST THEN
                    REPEAT
                        AbsenceEmp.RESET;
                        AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                        AbsenceEmp.SETRANGE("From Date", AbsenceTemp."From Date");
                        InsertDay := TRUE;
                        IF AbsenceEmp.FINDFIRST THEN
                            REPEAT
                                Cause.GET(AbsenceEmp."Cause of Absence Code");
                                InsertDay := InsertDay AND Cause."Added To Hour Pool"; //boolean +
                            UNTIL AbsenceEmp.NEXT = 0;
                        IF InsertDay THEN BEGIN
                            AbsenceEmp.TRANSFERFIELDS(AbsenceTemp);
                            AbsenceEmp."Entry No." := LastEntry;
                            AbsenceEmp."Employee No." := Employee."No.";

                            AbsenceEmp."Statistics Group Code" := Employee."Statistics Group Code";

                            IF HoursInDay <> 0 THEN
                                AbsenceEmp.Quantity := HoursInDay;

                            AbsenceEmp.INSERT;
                            LastEntry := LastEntry + 1;
                        END;
                    UNTIL AbsenceTemp.NEXT = 0;
            UNTIL Employee.NEXT = 0
        ELSE BEGIN
            Window.CLOSE;
            MESSAGE(Txt002);
            EXIT;
        END;

        Window.CLOSE;
    end;

    procedure EmployeeAbsenceInsertNo(StartDate2: Date; EndDate2: Date; var Employee: Record "Employee"; CauseCode: Code[10]; "Hours": Decimal) HoursReturn: Integer;
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        LastDate: Date;
        FirstDate: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence" temporary;
        AbsenceReg: Record "Employee Absence Reg";
        CauseOfAbsence: Record "Cause of Absence";
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        HoursInDay: Decimal;
        Holiday: Boolean;
        AbsenceEmpUnPaid: Record "Employee Absence";
        Neplaceno: Decimal;
        RazlikaDani: Decimal;
        BrojacSati: Decimal;
        Stv: Decimal;
        Empl: Record Employee;
        CalendarChange: Record "Base Calendar Change";
        ECL: Record "Employee Contract Ledger";
        First: Integer;
        Last: Integer;
        FirstSent: Integer;

    begin
        HoursReturn := 0;
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;
        First := 0;

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        AbsenceEmp.RESET;
        IF AbsenceEmp.FIND('+') THEN
            LastEntry := AbsenceEmp."Entry No."
        ELSE
            LastEntry := 0;
        LastEntry := LastEntry + 1;

        Datum.RESET;
        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate2, EndDate2);
        Datum.FINDFIRST;

        REPEAT

            //punjenje praznika

            CalendarChange.Reset();
            CalendarChange.SetFilter("Base Calendar Code", '%1', WageSetup."Wage Calendar Code");
            CalendarChange.SetFilter("Holiday Cause of Absence", '<>%1', '');
            if CalendarChange.findset then
                repeat

                    First += 1;
                    if CalendarChange."Recurring System" = CalendarChange."Recurring System"::"Annual Recurring" then begin
                        if (DMY2Date(date2dmy(CalendarChange.Date, 1), date2dmy(CalendarChange.Date, 2), Date2DMY(Datum."Period Start", 3)) = Datum."Period Start") and ((CalendarChange."Holiday Cause of Absence" <> '')) then begin           //  "Cause of Absence Code" := CalendarChange."Holiday Cause of Absence";

                            if First = 1 then
                                FirstSent := LastEntry;

                            if First = 1
                            then
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, FirstSent)
                            else
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, LastEntry);


                        end;
                    end;

                    if CalendarChange."Recurring System" = CalendarChange."Recurring System"::" " then begin
                        if First = 1 then
                            FirstSent := LastEntry;

                        if (CalendarChange.Date = Datum."Period Start") and (CalendarChange."Holiday Cause of Absence" <> '') then begin
                            if First = 1
                    then
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, FirstSent)
                            else
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, LastEntry)


                        end;

                    end;

                until CalendarChange.Next() = 0;




            InsertAnnual := FALSE;
            InsertWeekly := FALSE;

            CheckCalendar(InsertAnnual, 1);
            CheckCalendar(InsertWeekly, 2);

            AbsenceEmp.Reset(); //ovdje trazim postoji li unesen praznik na taj datum, treba ga preskočiti 
            //odim ako sada unosim službeni ili bolovanje, tada trebam pregaziti praznik
            AbsenceEmp.SetFilter("Employee No.", '%1', Employee."No.");
            AbsenceEmp.SetFilter("From Date", '%1', Datum."Period Start");
            if AbsenceEmp.FindFirst() then begin
                /*WageSetup.Get();

                CauseOfAbsence.Reset();
                CauseOfAbsence.Get(CauseCode);

                if AbsenceEmp."Cause of Absence Code" = WageSetup."Holiday Code" then //pronadjen je praznik na jedan datum
                    if NOT (CauseOfAbsence."Sick Leave" OR CauseOfAbsence."Bussiness trip") then //novo odsustvo nije bolovanje ili sp, pa ostaje praznik
                        Datum.Next()
                    else begin //novo odsustvo je sp ili bolovanje i treba pregaziti praznik
                        AbsenceEmp."Cause of Absence Code" := CauseCode;
                        AbsenceEmp.Description := CauseOfAbsence.Description;
                        AbsenceEmp.Modify();
                        Datum.Next(); //prelazi na sljedeći datum da se ne bi dupliralo
                    end;*/
                CauseOfAbsence.Reset();
                CauseOfAbsence.Get(CauseCode);
                Holiday := CauseOfAbsence.Holiday;

                CauseOfAbsence.Get(AbsenceEmp."Cause of Absence Code");

                if Holiday then //pronadjen je praznik na jedan datum
                    if NOT (CauseOfAbsence."Sick Leave" OR CauseOfAbsence."Bussiness trip") then //novo odsustvo nije bolovanje ili sp, pa ostaje praznik
                        Datum.Next()
                    else begin //novo odsustvo je sp ili bolovanje i treba pregaziti praznik
                        AbsenceEmp."Cause of Absence Code" := CauseCode;
                        AbsenceEmp.Description := CauseOfAbsence.Description;
                        AbsenceEmp.Modify();
                        Datum.Next(); //prelazi na sljedeći datum da se ne bi dupliralo
                    end;
            end;
            //ĐKAbsenceEmp.Reset();
            CauseOfAbsence.Reset();
            CauseOfAbsence.Get(CauseCode);

            IF (InsertWeekly) or (CauseOfAbsence.Weekend = true) THEN begin
                LastEntry += 1;
                WITH AbsenceEmp DO BEGIN


                    INIT;
                    "Entry No." := LastEntry;
                    Validate("Employee No.", Employee."No.");
                    //"Employee No." := Employee."No."; Amir stavio validate umjesto ovog kako bi se novo integer polje za sortiranje takodjer popunilo
                    "From Date" := Datum."Period Start";
                    "To Date" := Datum."Period Start";


                    //provjeravam da u tom periodu nije unesen neki praznik


                    IF InsertAnnual THEN BEGIN
                        Cause.Get(CauseCode);
                        "Cause of Absence Code" := CauseCode;
                        Description := Cause.Description;
                        "RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        Cause.Get(CauseCode);
                        "Cause of Absence Code" := CauseCode;
                        Description := Cause.Description;
                        "RS Code" := RSHoliday;
                    END;

                    //ako mi npr. pošalje 77 sati
                    if Hours = 0 then begin
                        Quantity := Employee."Hours In Day";
                    end
                    else begin
                        if Hours <= Employee."Hours In Day" then begin
                            Quantity := Hours;
                        end
                        else begin
                            //brojac od ukupno hours

                            RazlikaDani := Hours - BrojacSati;

                            Empl.Reset();
                            Empl.SetFilter("No.", '%1', "Employee No.");
                            Empl.SetFilter("Rad u smjenama", '%1', Empl."Rad u smjenama"::"Work in shifts");
                            if Empl.FindFirst() then begin
                                if (StartDate2 = EndDate2) then begin

                                    Stv := RazlikaDani;

                                end
                                else begin
                                    if RazlikaDani > Employee."Hours In Day" then
                                        Stv := Employee."Hours In Day"
                                    else
                                        Stv := RazlikaDani;
                                end;


                            end
                            else begin
                                if RazlikaDani > Employee."Hours In Day" then
                                    Stv := Employee."Hours In Day"
                                else
                                    Stv := RazlikaDani;
                            end;


                            BrojacSati := BrojacSati + Stv;
                            Quantity := Stv;

                        end;
                    end;

                    //
                    AbsenceEmpUnPaid.Reset();
                    AbsenceEmpUnPaid.SetFilter("Employee No.", '%1', Employee."No.");
                    AbsenceEmpUnPaid.SetFilter("From Date", '%1', Datum."Period Start");
                    AbsenceEmpUnPaid.SetFilter(Unpaid, '%1', true);
                    AbsenceEmpUnPaid.CalcSums(Quantity);
                    Neplaceno := AbsenceEmpUnPaid.Quantity;

                    Quantity := Quantity - Neplaceno;

                    //ĐK 
                    if (StartDate2 = EndDate2) and (Cause."Added To Hour Pool") then
                        Quantity := Hours;
                    "Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    "First Name" := Employee."First Name";
                    "Last Name" := Employee."Last Name";
                    ECL.Reset();
                    ECL.setfilter("Employee No.", '%1', "Employee No.");
                    ecl.SetFilter("Starting Date", '<=%1', "From Date");
                    ecl.SetCurrentKey("Starting Date");
                    ecl.Ascending;
                    if ecl.FindLast() then begin
                        "Department Code" := ecl."Department Code";
                        "Department Name" := ecl."Department Name";
                        "B-1 (with regions) Description" := ecl."Department Cat. Description";
                        "B-1 Description" := ecl."Sector Description";
                        "Stream Description" := ecl."Group Description";


                    end
                    else begin
                        "Department Code" := '';
                        "Department Name" := '';
                        "B-1 (with regions) Description" := '';
                        "B-1 Description" := '';
                        "Stream Description" := '';
                    end;
                    // INSERT;
                    HoursReturn += Quantity;
                    LastEntry := LastEntry + 1;
                end;
            END;
        UNTIL Datum.NEXT = 0;

    end;
    //ED 01 START
    procedure EmployeeAbsence(StartDate2: Date; EndDate2: Date; var Employee: Record "Employee"; CauseCode: Code[10]; "Hours": Decimal)
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        LastDate: Date;
        FirstDate: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence";
        AbsenceReg: Record "Employee Absence Reg";
        CauseOfAbsence: Record "Cause of Absence";
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        HoursInDay: Decimal;
        Holiday: Boolean;
        AbsenceEmpUnPaid: Record "Employee Absence";
        Neplaceno: Decimal;
        RazlikaDani: Decimal;
        BrojacSati: Decimal;
        Stv: Decimal;
        Empl: Record Employee;
        CalendarChange: Record "Base Calendar Change";
        ECL: Record "Employee Contract Ledger";
        First: Integer;
        Last: Integer;
        FirstSent: Integer;

    begin
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;
        First := 0;

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        AbsenceEmp.RESET;
        IF AbsenceEmp.FIND('+') THEN
            LastEntry := AbsenceEmp."Entry No."
        ELSE
            LastEntry := 0;
        LastEntry := LastEntry + 1;

        Datum.RESET;
        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate2, EndDate2);
        Datum.FINDFIRST;

        REPEAT

            //punjenje praznika

            CalendarChange.Reset();
            CalendarChange.SetFilter("Base Calendar Code", '%1', WageSetup."Wage Calendar Code");
            CalendarChange.SetFilter("Holiday Cause of Absence", '<>%1', '');
            if CalendarChange.findset then
                repeat

                    First += 1;
                    if CalendarChange."Recurring System" = CalendarChange."Recurring System"::"Annual Recurring" then begin
                        if (DMY2Date(date2dmy(CalendarChange.Date, 1), date2dmy(CalendarChange.Date, 2), Date2DMY(Datum."Period Start", 3)) = Datum."Period Start") and ((CalendarChange."Holiday Cause of Absence" <> '')) then begin           //  "Cause of Absence Code" := CalendarChange."Holiday Cause of Absence";

                            if First = 1 then
                                FirstSent := LastEntry;

                            if First = 1
                            then
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, FirstSent)
                            else
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, LastEntry);


                        end;
                    end;

                    if CalendarChange."Recurring System" = CalendarChange."Recurring System"::" " then begin
                        if First = 1 then
                            FirstSent := LastEntry;

                        if (CalendarChange.Date = Datum."Period Start") and (CalendarChange."Holiday Cause of Absence" <> '') then begin
                            if First = 1
                    then
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, FirstSent)
                            else
                                LastEntry := FillHoliday_Update(Datum."Period Start", CalendarChange."Holiday Cause of Absence", CalendarChange.Description, LastEntry)


                        end;

                    end;

                until CalendarChange.Next() = 0;




            InsertAnnual := FALSE;
            InsertWeekly := FALSE;

            CheckCalendar(InsertAnnual, 1);
            CheckCalendar(InsertWeekly, 2);

            AbsenceEmp.Reset(); //ovdje trazim postoji li unesen praznik na taj datum, treba ga preskočiti 
            //odim ako sada unosim službeni ili bolovanje, tada trebam pregaziti praznik
            AbsenceEmp.SetFilter("Employee No.", '%1', Employee."No.");
            AbsenceEmp.SetFilter("From Date", '%1', Datum."Period Start");
            if AbsenceEmp.FindFirst() then begin
                /*WageSetup.Get();

                CauseOfAbsence.Reset();
                CauseOfAbsence.Get(CauseCode);

                if AbsenceEmp."Cause of Absence Code" = WageSetup."Holiday Code" then //pronadjen je praznik na jedan datum
                    if NOT (CauseOfAbsence."Sick Leave" OR CauseOfAbsence."Bussiness trip") then //novo odsustvo nije bolovanje ili sp, pa ostaje praznik
                        Datum.Next()
                    else begin //novo odsustvo je sp ili bolovanje i treba pregaziti praznik
                        AbsenceEmp."Cause of Absence Code" := CauseCode;
                        AbsenceEmp.Description := CauseOfAbsence.Description;
                        AbsenceEmp.Modify();
                        Datum.Next(); //prelazi na sljedeći datum da se ne bi dupliralo
                    end;*/
                CauseOfAbsence.Reset();
                CauseOfAbsence.Get(CauseCode);
                Holiday := CauseOfAbsence.Holiday;

                CauseOfAbsence.Get(AbsenceEmp."Cause of Absence Code");

                if Holiday then //pronadjen je praznik na jedan datum
                    if NOT (CauseOfAbsence."Sick Leave" OR CauseOfAbsence."Bussiness trip") then //novo odsustvo nije bolovanje ili sp, pa ostaje praznik
                        Datum.Next()
                    else begin //novo odsustvo je sp ili bolovanje i treba pregaziti praznik
                        AbsenceEmp."Cause of Absence Code" := CauseCode;
                        AbsenceEmp.Description := CauseOfAbsence.Description;
                        AbsenceEmp.Modify();
                        Datum.Next(); //prelazi na sljedeći datum da se ne bi dupliralo
                    end;
            end;
            //ĐKAbsenceEmp.Reset();
            CauseOfAbsence.Reset();
            CauseOfAbsence.Get(CauseCode);

            IF (InsertWeekly) or (CauseOfAbsence.Weekend = true) THEN begin
                LastEntry += 1;
                WITH AbsenceEmp DO BEGIN


                    INIT;
                    "Entry No." := LastEntry;
                    Validate("Employee No.", Employee."No.");
                    //"Employee No." := Employee."No."; Amir stavio validate umjesto ovog kako bi se novo integer polje za sortiranje takodjer popunilo
                    "From Date" := Datum."Period Start";
                    "To Date" := Datum."Period Start";


                    //provjeravam da u tom periodu nije unesen neki praznik


                    IF InsertAnnual THEN BEGIN
                        Cause.Get(CauseCode);
                        "Cause of Absence Code" := CauseCode;
                        Description := Cause.Description;
                        "RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        Cause.Get(CauseCode);
                        "Cause of Absence Code" := CauseCode;
                        Description := Cause.Description;
                        "RS Code" := RSHoliday;
                    END;

                    //ako mi npr. pošalje 77 sati
                    if Hours = 0 then begin
                        Quantity := Employee."Hours In Day";
                    end
                    else begin
                        if Hours <= Employee."Hours In Day" then begin
                            Quantity := Hours;
                        end
                        else begin
                            //brojac od ukupno hours

                            RazlikaDani := Hours - BrojacSati;

                            Empl.Reset();
                            Empl.SetFilter("No.", '%1', "Employee No.");
                            Empl.SetFilter("Rad u smjenama", '%1', Empl."Rad u smjenama"::"Work in shifts");
                            if Empl.FindFirst() then begin
                                if (StartDate2 = EndDate2) then begin

                                    Stv := RazlikaDani;

                                end
                                else begin
                                    if RazlikaDani > Employee."Hours In Day" then
                                        Stv := Employee."Hours In Day"
                                    else
                                        Stv := RazlikaDani;
                                end;


                            end
                            else begin
                                if RazlikaDani > Employee."Hours In Day" then
                                    Stv := Employee."Hours In Day"
                                else
                                    Stv := RazlikaDani;
                            end;


                            BrojacSati := BrojacSati + Stv;
                            Quantity := Stv;

                        end;
                    end;

                    //
                    AbsenceEmpUnPaid.Reset();
                    AbsenceEmpUnPaid.SetFilter("Employee No.", '%1', Employee."No.");
                    AbsenceEmpUnPaid.SetFilter("From Date", '%1', Datum."Period Start");
                    AbsenceEmpUnPaid.SetFilter(Unpaid, '%1', true);
                    AbsenceEmpUnPaid.CalcSums(Quantity);
                    Neplaceno := AbsenceEmpUnPaid.Quantity;

                    Quantity := Quantity - Neplaceno;

                    //ĐK 
                    if (StartDate2 = EndDate2) and (Cause."Added To Hour Pool") then
                        Quantity := Hours;
                    "Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    "First Name" := Employee."First Name";
                    "Last Name" := Employee."Last Name";
                    ECL.Reset();
                    ECL.setfilter("Employee No.", '%1', "Employee No.");
                    ecl.SetFilter("Starting Date", '<=%1', "From Date");
                    ecl.SetCurrentKey("Starting Date");
                    ecl.Ascending;
                    if ecl.FindLast() then begin
                        "Department Code" := ecl."Department Code";
                        "Department Name" := ecl."Department Name";
                        "B-1 (with regions) Description" := ecl."Department Cat. Description";
                        "B-1 Description" := ecl."Sector Description";
                        "Stream Description" := ecl."Group Description";


                    end
                    else begin
                        "Department Code" := '';
                        "Department Name" := '';
                        "B-1 (with regions) Description" := '';
                        "B-1 Description" := '';
                        "Stream Description" := '';
                    end;
                    INSERT;
                    LastEntry := LastEntry + 1;
                end;
            END;
        UNTIL Datum.NEXT = 0;

    end;

    procedure FillHoliday(HolidayDate: Date; HolidayCauseOfAbsence: Code[10]; Description: Text[30])
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence";
        AbsenceReg: Record "Employee Absence Reg";
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record Employee;
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        HoursInDay: Decimal;
    begin
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        InsertAnnual := FALSE;
        InsertWeekly := FALSE;

        CheckCalendar(InsertAnnual, 1);
        CheckCalendar(InsertWeekly, 2);

        Employee.SetFilter("For Calculation", '%1', true); //filter na samo aktivne zaposlene
        if Employee.FindFirst() then
            repeat //ova petlja uzima jednog po jednog zaposlenog 
                AbsenceEmp.Reset();
                AbsenceEmp.SetFilter(AbsenceEmp."Employee No.", '%1', Employee."No."); //trazim ovog zaposlenog u registraciji izostanaka
                AbsenceEmp.SetFilter("From Date", '%1', HolidayDate); //trazim odsustvo na ovaj datum
                if AbsenceEmp.FindFirst() then begin //već postoji odsustvo na ovaj datum, moram provjeriti koji je uzrok
                                                     //za bolovanje je sick leave = true, a za službeni put je business trip = true
                                                     //za jedno od ovo dvoje ne radim insert, za ostala odsustva radim update
                    CauseOfAbsence.Get(AbsenceEmp."Cause of Absence Code");
                    if NOT (CauseOfAbsence."Bussiness trip")
                    then
                        if NOT (CauseOfAbsence."Sick Leave") then begin //izostanak se treba modify na praznik
                            AbsenceEmp."Cause of Absence Code" := HolidayCauseOfAbsence;
                            AbsenceEmp.Description := Description;
                            AbsenceEmp.Modify();
                        end;
                end
                else begin
                    AbsenceEmp.RESET;
                    IF AbsenceEmp.FIND('+') THEN
                        LastEntry := AbsenceEmp."Entry No."
                    ELSE
                        LastEntry := 0;
                    LastEntry := LastEntry + 1;
                    AbsenceEmp.Init();
                    AbsenceEmp."Entry No." := LastEntry;
                    AbsenceEmp."Employee No." := Employee."No.";
                    AbsenceEmp."First Name" := Employee."First Name";
                    AbsenceEmp."Last Name" := Employee."Last Name";
                    AbsenceEmp."From Date" := HolidayDate;
                    AbsenceEmp."To Date" := HolidayDate;
                    IF InsertAnnual THEN BEGIN
                        WageSetup.Get();
                        AbsenceEmp."Cause of Absence Code" := HolidayCauseOfAbsence;
                        AbsenceEmp.Description := Description;
                        AbsenceEmp."RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        WageSetup.Get();
                        AbsenceEmp."Cause of Absence Code" := HolidayCauseOfAbsence;
                        AbsenceEmp.Description := Description;
                        AbsenceEmp."RS Code" := RSHoliday;
                    END;

                    AbsenceEmp.Quantity := Employee."Hours In Day";

                    AbsenceEmp."Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    Commit();
                    AbsenceEmp.Insert();
                    Commit();

                end;
            until Employee.Next() = 0;
    end;
    //ED 01 END

    procedure FillHoliday_Update(HolidayDate: Date; HolidayCauseOfAbsence: Code[10]; Description: Text[30]; EntryNoSent: integer) EntryReturn: integer;
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence";
        AbsenceReg: Record "Employee Absence Reg";
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record Employee;
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        HoursInDay: Decimal;
    begin
        LastEntry := EntryNoSent;
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        InsertAnnual := FALSE;
        InsertWeekly := FALSE;

        CheckCalendar(InsertAnnual, 1);
        CheckCalendar(InsertWeekly, 2);

        Employee.SetFilter("For Calculation", '%1', true); //filter na samo aktivne zaposlene
        if Employee.FindFirst() then
            repeat //ova petlja uzima jednog po jednog zaposlenog 
                AbsenceEmp.Reset();
                AbsenceEmp.SetFilter(AbsenceEmp."Employee No.", '%1', Employee."No."); //trazim ovog zaposlenog u registraciji izostanaka
                AbsenceEmp.SetFilter("From Date", '%1', HolidayDate); //trazim odsustvo na ovaj datum
                if AbsenceEmp.FindFirst() then begin //već postoji odsustvo na ovaj datum, moram provjeriti koji je uzrok
                                                     //za bolovanje je sick leave = true, a za službeni put je business trip = true
                                                     //za jedno od ovo dvoje ne radim insert, za ostala odsustva radim update
                    CauseOfAbsence.Get(AbsenceEmp."Cause of Absence Code");
                    if NOT (CauseOfAbsence."Bussiness trip")
                    then
                        if NOT (CauseOfAbsence."Sick Leave") then begin //izostanak se treba modify na praznik
                            AbsenceEmp."Cause of Absence Code" := HolidayCauseOfAbsence;
                            AbsenceEmp.Description := Description;
                            AbsenceEmp.Modify();
                        end;
                end
                else begin
                    /*AbsenceEmp.RESET;
                    IF AbsenceEmp.FIND('+') THEN
                        LastEntry := AbsenceEmp."Entry No."
                    ELSE
                        LastEntry := 0;*/
                    LastEntry := LastEntry + 1;
                    AbsenceEmp.Init();
                    AbsenceEmp."Entry No." := LastEntry;
                    AbsenceEmp."Employee No." := Employee."No.";
                    AbsenceEmp."First Name" := Employee."First Name";
                    AbsenceEmp."Last Name" := Employee."Last Name";
                    AbsenceEmp."From Date" := HolidayDate;
                    AbsenceEmp."To Date" := HolidayDate;
                    IF InsertAnnual THEN BEGIN
                        WageSetup.Get();
                        AbsenceEmp."Cause of Absence Code" := HolidayCauseOfAbsence;
                        AbsenceEmp.Description := Description;
                        AbsenceEmp."RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        WageSetup.Get();
                        AbsenceEmp."Cause of Absence Code" := HolidayCauseOfAbsence;
                        AbsenceEmp.Description := Description;
                        AbsenceEmp."RS Code" := RSHoliday;
                    END;

                    AbsenceEmp.Quantity := Employee."Hours In Day";

                    AbsenceEmp."Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    Commit();
                    AbsenceEmp.Insert();
                    Commit();

                end;
            until Employee.Next() = 0;
        EntryReturn := LastEntry;
    end;

    procedure GetHourPool(CurrentMonth: Integer; CurrentYear: Integer; HoursInDay: Decimal) HourPool: Decimal
    var
        DateText: Text[30];
        DateText2: Text[30];
        FromDateFilter: Date;
        ToDateFilter: Date;
        InsertWeekly: Boolean;
    begin
        HourPool := 0;

        WageSetup.GET;

        StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
        EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN BEGIN
            MESSAGE(Txt001);
            EXIT;
        END;

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate, EndDate);
        Datum.FINDFIRST;
        REPEAT
            InsertWeekly := FALSE;
            CheckCalendar(InsertWeekly, 2);
            IF InsertWeekly THEN
                HourPool := HourPool + HoursInDay;

        UNTIL Datum.NEXT = 0;
    end;

    procedure GetHourPoolForVacation(StartDateT: Date; EndDateT: Date; HoursInDay: Integer) HourPool: Integer
    var
        DateText: Text[30];
        DateText2: Text[30];
        FromDateFilter: Date;
        ToDateFilter: Date;
        InsertWeekly: Boolean;
    begin
        HourPool := 0;

        WageSetup.GET;

        //StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
        //EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN BEGIN
            MESSAGE(Txt001);
            EXIT;
        END;

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDateT, EndDateT);
        Datum.FINDFIRST;
        REPEAT
            InsertWeekly := FALSE;
            CheckCalendar(InsertWeekly, 2);
            IF InsertWeekly THEN
                HourPool := HourPool + HoursInDay;

        UNTIL Datum.NEXT = 0;

    end;

    procedure GetMonthRange(CurrMonth: Integer; CurrYear: Integer; StartOrEnd: Boolean) ReturnDate: Date
    var
        Datum: Record "Date";
        DateText: Text[30];
    begin
        IF STRLEN(FORMAT(CurrMonth)) = 1 THEN
            DateText := '0' + FORMAT(CurrMonth) + FORMAT(CurrYear)
        ELSE
            DateText := FORMAT(CurrMonth) + FORMAT(CurrYear);

        IF StartOrEnd THEN
            EVALUATE(ReturnDate, '01' + DateText)
        ELSE BEGIN
            Datum.SETFILTER("Period Type", '%1', 2);
            Datum.SETFILTER("Period No.", FORMAT(CurrMonth));
            Datum.SETFILTER("Period Start", '01' + DateText);
            Datum.FINDFIRST;
            EVALUATE(ReturnDate, FORMAT(DATE2DMY(NORMALDATE(Datum."Period End"), 1)) + DateText);
        END;
    end;

    /*ĐK procedure CalcIncentiveBonus(WageHeaderIB: Record "Wage Header")
    var
        Employee: Record "Employee";
        MealLineTemp: Record "Meal Line Temp";
        MealLine: Record "Meal Line";
        Absences: Record "Employee Absence";
        COA: Record "Cause of Absence";
        MealNo: Code[20];
        MealAmount: Decimal;
        MealBasis: Decimal;
        MealHalfDayBasis: Decimal;
        WorkDays: array[31] of Boolean;
        WorkDaysNo: Integer;
        WorkDaysHalfDayNo: Integer;
        ReductionAmount: Decimal;
        Reduction: Record "Reduction";
        WageHeader: Record "Wage Header";
        RestDiff: Decimal;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        MealCoeff: Decimal;
        CTHours: Integer;
    begin

        IB.SETFILTER("Month of Wage", '%1', WageHeaderIB."Month Of Wage");
        IB.SETFILTER("Year of Wage", '%1', WageHeaderIB."Year Of Wage");
        IF IB.FIND('-') THEN
            REPEAT
                WAIB.INIT;
                WAIB2.SETFILTER("Entry No.", '<>%1', 0);
                IF WAIB2.FINDLAST THEN
                    WAIB."Entry No." := WAIB2."Entry No." + 1
                ELSE
                    WAIB."Entry No." := 1;
                WAIB.VALIDATE("Employee No.", IB."Employee No.");
                WAIB.VALIDATE("Wage Addition Type", IB."Wage Addition Type");
             
                WAIB.VALIDATE(Amount, IB.Amount);
                WAIB."Month of Wage" := WageHeaderIB."Month Of Wage";
                WAIB."Year of Wage" := WageHeaderIB."Year Of Wage";
                WAIB."System Entry" := TRUE;
                WAIB.INSERT;

            UNTIL IB.NEXT = 0;

    end;


    procedure CalcStimulationDestimulation(WageHeaderSD: Record "Wage Header")
    var
        Employee: Record "Employee";
        MealLineTemp: Record "Meal Line Temp";
        MealLine: Record "Meal Line";
        Absences: Record "Employee Absence";
        COA: Record "Cause of Absence";
        MealNo: Code[20];
        MealAmount: Decimal;
        MealBasis: Decimal;
        MealHalfDayBasis: Decimal;
        WorkDays: array[31] of Boolean;
        WorkDaysNo: Integer;
        WorkDaysHalfDayNo: Integer;
        ReductionAmount: Decimal;
        Reduction: Record "Reduction";
        WageHeader: Record "Wage Header";
        RestDiff: Decimal;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        MealCoeff: Decimal;
        CTHours: Integer;
    begin
        StartDateWA := GetMonthRange(WageHeaderSD."Month Of Wage", WageHeaderSD."Year Of Wage", TRUE);
        WAP.SETFILTER("From Date", '<=%1', StartDateWA);
        WAP.SETFILTER("To Date", '%1|>=%2', 0D, StartDateWA);
        IF WAP.FIND('-') THEN
            REPEAT
                WASD.INIT;
                WASD2.SETFILTER("Entry No.", '<>%1', 0);
                IF WASD2.FINDLAST THEN
                    WASD."Entry No." := WASD2."Entry No." + 1
                ELSE
                    WASD."Entry No." := 1;
                WASD.VALIDATE("Employee No.", WAP."Employee No.");
                WASD.VALIDATE("Wage Addition Type", WAP."Wage Addition Type");
                WASD.VALIDATE(Amount, WAP.Amount);
                WASD."Month of Wage" := WageHeaderSD."Month Of Wage";
                WASD."Year of Wage" := WageHeaderSD."Year Of Wage";
                WASD."System Entry" := TRUE;
                WASD.INSERT;

            UNTIL WAP.NEXT = 0;
    end;
*/

    procedure CheckPeriod(Absence: Record "Employee Absence")
    var
        TargetDate: Date;
        ToDate: Date;
        FromDate: Date;
        DailyHours: Decimal;
        Cause: Record "Cause of Absence";
        CauseTemp: Record "Cause of Absence";
        MarkIt: Boolean;
        ConflictArray: array[100] of Integer;
        ConflictText: Text[250];
        Txt001: Label 'Conflicts were found with following entries in Absences table:';
        Txt002: Label 'Please correct these conflicts before proceeding with data entry.';
        AbsenceTemp: Record "Employee Absence";
    begin
        WageSetup.FINDFIRST;
        AbsenceTemp.LOCKTABLE;

        TargetDate := Absence."From Date";
        Cause.GET(Absence."Cause of Absence Code");
        CASE Absence."Unit of Measure Code" OF
            WageSetup."Hour Unit of Measure":
                DailyHours1 := Absence.Quantity;
            WageSetup."Day Unit of Measure":
                DailyHours1 := WageSetup."Hours in Day";
        END;
        CLEAR(ConflictArray);
        LastArray := 0;

        WHILE TargetDate <= Absence."To Date" DO BEGIN
            DailyHours := DailyHours1;
            AbsenceTemp.RESET;

            AbsenceTemp.SETFILTER("Employee No.", Absence."Employee No.");
            //AbsenceTemp.SETFILTER("Statistics Group Code", '%1', Absence."Statistics Group Code");

            AbsenceTemp.SETFILTER("From Date", '<=%1', TargetDate);
            AbsenceTemp.SETFILTER("To Date", '>=%1', TargetDate);
            AbsenceTemp.SETFILTER("Entry No.", '<>%1&<>0', Absence."Entry No.");
            AbsenceTemp.SETCURRENTKEY("Employee No.", "From Date");

            IF AbsenceTemp.FINDFIRST THEN
                REPEAT
                    CASE AbsenceTemp."Unit of Measure Code" OF
                        WageSetup."Hour Unit of Measure":
                            DailyHours := DailyHours + AbsenceTemp.Quantity;
                        WageSetup."Day Unit of Measure":
                            DailyHours := DailyHours + WageSetup."Hours in Day";
                    END;
                    CauseTemp.GET(AbsenceTemp."Cause of Absence Code");
                    MarkIt := (Absence."Cause of Absence Code" = AbsenceTemp."Cause of Absence Code") OR (DailyHours > 24);
                    //OR ((NOT(CauseTemp."Added To Hour Pool")) AND (NOT(Cause."Added To Hour Pool"))) ;
                    IF MarkIt THEN
                        MarkConflict(AbsenceTemp, Absence, ConflictArray);
                UNTIL AbsenceTemp.NEXT = 0;

            TargetDate := CALCDATE('+1D', TargetDate);
        END;



        ConflictText := '';
        /*FOR I := 1 TO LastArray DO
          ConflictText := COPYSTR(ConflictText + ' ' +  FORMAT(ConflictArray[I]) , 1, MAXSTRLEN(ConflictText));
        IF ConflictText <> '' THEN
          BEGIN
            MESSAGE(Txt001);
            MESSAGE(ConflictText);
            ERROR(Txt002);
          END;                */

    end;

    procedure MarkConflict(AbsTemp: Record "Employee Absence"; AbsEmp: Record "Employee Absence"; var EntryArray: array[100] of Integer)
    begin
        AddArray := TRUE;
        IF LastArray > 0 THEN
            FOR I := 1 TO LastArray DO
                AddArray := (EntryArray[I] <> AbsTemp."Entry No.");

        IF AddArray AND (LastArray < ARRAYLEN(EntryArray)) THEN BEGIN
            LastArray := LastArray + 1;
            EntryArray[LastArray] := AbsTemp."Entry No.";
        END;
    end;

    procedure GetHourRange(Absence: Record "Employee Absence") HourNo: Decimal
    var
        Setup: Record "Wage Setup";
    begin
        Setup.GET('');
        CASE Absence."Unit of Measure Code" OF
            Setup."Hour Unit of Measure":
                HourNo := Absence.Quantity;
            Setup."Day Unit of Measure":
                HourNo := Absence.Quantity * Setup."Hours in Day";
        END;
    end;

    procedure CalcTransport(TransHeader: Record "Transport Header")
    var
        Employee: Record "Employee";
        TransLineTemp: Record "Transport Line Temp";
        TransLine: Record "Transport Line";
        TransNo: Code[20];
        TransportAmount: Decimal;
    begin
        IF (TransHeader."No." <> '') AND (TransHeader."Year of Wage" <> 0) AND (TransHeader."Month Of Wage" <> 0) THEN BEGIN
            CASE TransHeader.Status OF
                0:
                    BEGIN
                        TransLineTemp.SETFILTER("Document No.", TransHeader."No.");
                        IF TransLineTemp.ISEMPTY THEN BEGIN
                            Employee.RESET;
                            Employee.SETFILTER("For Calculation", '%1', TRUE);
                            Employee.SETFILTER("Transport Amount", '<>%1', 0);
                            IF TRL.FIND('+') THEN
                                //TransNo:='0000000000';
                                TransNo := INCSTR(TRL."Line No.")
                            ELSE
                                TransNo := '0000000000';
                            IF Employee.FINDFIRST THEN
                                REPEAT
                                    WageType.GET(Employee."Wage Type");

                                    TransportAmount := Employee."Transport Amount";
                                    IF TransportAmount = 0 THEN
                                        IF Post.GET(Employee."Post Code", Employee.City) THEN BEGIN
                                            IF (Post."Transport Basis" > 0) AND (NOT WageType.Contract) THEN
                                                TransportAmount := Post."Transport Basis";
                                        END
                                        ELSE
                                            ERROR(Txt006);
                                    IF TransportAmount <> 0 THEN BEGIN
                                        TransLineTemp.INIT;
                                        TransNo := INCSTR(TransNo);
                                        TransLineTemp."Document No." := TransHeader."No.";
                                        TransLineTemp."Line No." := TransNo;
                                        TransLineTemp."Employee No." := Employee."No.";
                                        TransLineTemp.Workdays := TransHeader.Workdays;
                                        TransLineTemp."Basis For Transport" := TransportAmount;
                                        TransLineTemp.Amount := TransportAmount;
                                        //WG01
                                        IF ((Employee."Contribution Category Code" = 'BDPIOFBIH') OR (Employee."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                                            ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                                            IF ConCat.FINDFIRST THEN BEGIN
                                                ConCat.CALCFIELDS("From Brutto");
                                                ConCat.CALCFIELDS("From Brutto(RS)");
                                                IF (Employee."Contribution Category Code" = 'BDPIORS') THEN BEGIN

                                                    TransLineTemp."Brutto Amount" := (TransLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100) * 0.9);
                                                    TransLineTemp."Netto Before Tax" := (TransLineTemp."Brutto Amount") - (TransLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END
                                                ELSE BEGIN
                                                    TransLineTemp."Brutto Amount" := (TransLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100) * 0.9);
                                                    TransLineTemp."Netto Before Tax" := (TransLineTemp."Brutto Amount") - (TransLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END;
                                            END;
                                        END;
                                        //WG01
                                        TransLineTemp.INSERT;
                                    END
                                    ELSE
                                        ERROR(Txt006);
                                UNTIL Employee.NEXT = 0
                            // ELSE
                            //   MESSAGE(Txt002);
                        END
                        ELSE BEGIN
                            TransLineTemp.DELETEALL;
                            CalcTransport(TransHeader);
                        END;
                    END;
                1:
                    MESSAGE(Txt003);
                2:
                    MESSAGE(Txt004);
            END;
        END
        ELSE
            MESSAGE(Txt005);
    end;

    procedure CalcMeal(MealHeader: Record "Meal Header")
    var
        Employee: Record "Employee";
        MealLineTemp: Record "Meal Line Temp";
        MealLine: Record "Meal Line";
        Absences: Record "Employee Absence";
        COA: Record "Cause of Absence";
        MealNo: Code[20];
        MealAmount: Decimal;
        MealBasis: Decimal;
        MealHalfDayBasis: Decimal;
        WorkDays: array[31] of Boolean;
        WorkDaysNo: Integer;
        WorkDaysHalfDayNo: Integer;
        ReductionAmount: Decimal;
        Reduction: Record "Reduction";
        WageHeader: Record "Wage Header";
        RestDiff: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MealCoeff: Decimal;
        CTHours: Integer;
        Ab2: record "Employee Absence";
        TotalSati: decimal;
        Dijeljenje: decimal;
        IntegerValue: integer;
        BrojDana: integer;
        AddPart: Decimal;



    begin

        //ne bi trebalo po radnim danima, već po satima

        IF (MealHeader."No." <> '')
           AND (MealHeader."Year Of Wage" <> 0)
           AND (MealHeader."Month Of Wage" <> 0) THEN BEGIN
            WageSetup.GET;
            StartDate := GetMonthRange(MealHeader."Month Of Wage", MealHeader."Year Of Wage", TRUE);
            EndDate := GetMonthRange(MealHeader."Month Of Wage", MealHeader."Year Of Wage", FALSE);
            CASE MealHeader.Status OF
                MealHeader.Status::Open:
                    BEGIN
                        MealLineTemp.SETFILTER("Document No.", MealHeader."No.");
                        IF MealLineTemp.ISEMPTY THEN BEGIN
                            Employee.RESET;
                            Employee.SETFILTER("For Calculation", '%1', TRUE);
                            Employee.SETRANGE(Meal, TRUE);
                            //MealNo:='0000000000';
                            IF ML.FIND('+') THEN
                                MealNo := INCSTR(ML."Line No.")
                            ELSE
                                MealNo := '0000000000';
                            CTHours := 0;
                            IF Employee.FINDFIRST THEN
                                REPEAT
                                    AddPart := 0;
                                    WorkDaysNo := 0;
                                    TotalSati := 0;

                                    WageType.GET(Employee."Wage Type");
                                    MealCoeff := Employee."Hours In Day" / 8;
                                    IF ((Employee."Contribution Category Code" = 'FBIH') OR (Employee."Contribution Category Code" = 'FBIHRS') OR (Employee."Contribution Category Code" = 'BD')) THEN
                                        MealBasis := WageSetup.Meal * MealCoeff;
                                    IF ((Employee."Contribution Category Code" = 'RS')) THEN
                                        MealBasis := WageSetup."Meal Total RS" * MealCoeff;
                                    IF ((Employee."Contribution Category Code" = 'BDPIOFBIH') OR (Employee."Contribution Category Code" = 'BDPIORS')) THEN
                                        MealBasis := WageSetup."Meal Nontaxable BD" * MealCoeff;
                                    MealHalfDayBasis := WageSetup."Meal - Half Day" * MealCoeff;
                                    Absences.RESET;
                                    Absences.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date", "To Date");
                                    Absences.SETFILTER("Employee No.", Employee."No.");
                                    Absences.SETFILTER("From Date", '>=%1', StartDate);
                                    Absences.SETFILTER("To Date", '<=%1', EndDate);
                                    CLEAR(WorkDays);

                                    //Full day meal:
                                    WorkDaysNo := 0;
                                    TotalSati := 0;
                                    COA.RESET;
                                    COA.SETRANGE("Meal Calculated", TRUE);
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            //  Absences.reset;
                                            Absences.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            IF COA."Short Code" = '202' THEN
                                                Absences.SETFILTER(Quantity, '>=5')
                                            ELSE
                                                Absences.SETFILTER(Quantity, '>0');
                                            IF Absences.FINDFIRST THEN
                                                REPEAT


                                                    /*  IF NOT WorkDays[DATE2DMY(Absences."From Date", 1)] THEN BEGIN
                                                          WorkDays[DATE2DMY(Absences."From Date", 1)] := TRUE;
                                                          WorkDaysNo += 1;
                                                      END;*/

                                                    TotalSati += Absences.quantity;

                                                    Dijeljenje := TotalSati / (Employee."Hours in day");
                                                    //format(dec,0,'<Integer,12><Filler Character,0>');
                                                    IF EVALUATE(IntegerValue, FORMAT(Dijeljenje, 0, '<Integer,12><Filler Character,0>')) THEN
                                                        BrojDana := IntegerValue;



                                                    if TotalSati - Employee."Hours in day" >= 0 then begin
                                                        TotalSati := TotalSati - (BrojDana * Employee."Hours in day");
                                                        IF (COA."Meal - Hours" = TRUE) AND (Absences.Quantity < 5) THEN
                                                            WorkDaysNo += 0
                                                        ELSE
                                                            WorkDaysNo += BrojDana * 1;

                                                    end;



                                                UNTIL Absences.NEXT = 0;
                                        UNTIL COA.NEXT = 0;

                                    if TotalSati > 0 then begin
                                        Dijeljenje := TotalSati / (Employee."Hours in day");
                                        AddPart := MealBasis * Dijeljenje;
                                    end;

                                    //ja bih ovdje vidjela ostatak sati

                                    if (TotalSati > 0) then begin
                                        Dijeljenje := TotalSati / (Employee."Hours in day");


                                        IF EVALUATE(IntegerValue, FORMAT(Dijeljenje, 0, '<Integer,12><Filler Character,0>')) THEN
                                            WorkDaysNo += IntegerValue;
                                    end;

                                    //Half day meal:
                                    WorkDaysHalfDayNo := 0;

                                    COA.RESET;
                                    COA.SETRANGE("Meal - Half Day Calculated", TRUE);
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            Absences.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            Absences.SETFILTER(Quantity, '>0');
                                            IF Absences.FINDFIRST THEN
                                                REPEAT
                                                    /*  IF NOT WorkDays[DATE2DMY(Absences."From Date", 1)] THEN BEGIN
                                                          WorkDays[DATE2DMY(Absences."From Date", 1)] := TRUE;
                                                          WorkDaysHalfDayNo += 1;
                                                      END;*/


                                                    TotalSati += Absences.quantity;

                                                    Dijeljenje := TotalSati / (Employee."Hours in day");
                                                    IF EVALUATE(IntegerValue, FORMAT(Dijeljenje, 0, '<Integer,12><Filler Character,0>')) THEN
                                                        BrojDana := IntegerValue;

                                                    if TotalSati - Employee."Hours in day" >= 0 then begin
                                                        TotalSati := TotalSati - (BrojDana * Employee."Hours in day");
                                                        IF (COA."Meal - Hours" = TRUE) AND (Absences.Quantity < 5) THEN
                                                            WorkDaysNo += 0
                                                        ELSE
                                                            WorkDaysNo += BrojDana * 1;
                                                    end;

                                                UNTIL Absences.NEXT = 0;
                                        UNTIL COA.NEXT = 0;

                                    if (TotalSati > 0) then begin
                                        Dijeljenje := TotalSati / (Employee."Hours in day");
                                        IF EVALUATE(IntegerValue, FORMAT(Dijeljenje, 0, '<Integer,12><Filler Character,0>')) THEN
                                            WorkDaysNo += IntegerValue;
                                    end;
                                    CTHours := 0;
                                    COA.RESET;
                                    COA.SETRANGE("Added To Hour Pool", FALSE);
                                    COA.SETRANGE("Meal Calculated", TRUE);
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            Absences.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            Absences.SETFILTER(Quantity, '>0');
                                            IF Absences.FINDFIRST THEN
                                                REPEAT
                                                    CTHours += Absences.Quantity;

                                                UNTIL Absences.NEXT = 0;
                                        UNTIL COA.NEXT = 0;
                                    Employee.CALCFIELDS("Department code");


                                    IF NOT Employee."Contact Center" THEN
                                        MealAmount := AddPart + MealBasis * WorkDaysNo + MealHalfDayBasis * WorkDaysHalfDayNo
                                    ELSE
                                        MealAmount := AddPart + (MealBasis / 8) * (CTHours);

                                    IF ((MealAmount <> 0) AND ((CTHours <> 0) OR (WorkDaysNo <> 0))) THEN BEGIN
                                        MealLineTemp.INIT;
                                        MealNo := INCSTR(MealNo);
                                        MealLineTemp."Document No." := MealHeader."No.";
                                        MealLineTemp."Line No." := MealNo;
                                        MealLineTemp."Employee No." := Employee."No.";
                                        IF (NOT (Employee."Contact Center") OR (Employee."Hours In Day" < 8)) THEN
                                            MealLineTemp.Workdays := WorkDaysNo
                                        ELSE
                                            MealLineTemp.Workdays := CTHours;
                                        MealLineTemp."Basis For Meal" := MealBasis;
                                        MealLineTemp.Amount := MealAmount;
                                        //WG01
                                        IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN

                                            //BD=!  IF( (Employee."Contribution Category Code"='BDPIOFBIH') OR (Employee."Contribution Category Code"='BDPIORS') OR (Employee."Contribution Category Code"='RS')) THEN BEGIN
                                            ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                                            IF ConCat.FINDFIRST THEN BEGIN
                                                ConCat.CALCFIELDS("From Brutto");
                                                ConCat.CALCFIELDS("From Brutto(RS)");
                                                IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN

                                                    MealLineTemp."Brutto Amount" := (MealLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100));
                                                    MealLineTemp."Netto Before Tax" := (MealLineTemp."Brutto Amount") - (MealLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END
                                                ELSE BEGIN
                                                    MealLineTemp."Brutto Amount" := (MealLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100));
                                                    MealLineTemp."Netto Before Tax" := (MealLineTemp."Brutto Amount") - (MealLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END;
                                            END;
                                        END;
                                        //WG01

                                        MealLineTemp.INSERT;
                                        IF ((Employee."Contribution Category Code" = 'FBIH') OR (Employee."Contribution Category Code" = 'FBIHRS') OR (Employee."Contribution Category Code" = 'BDPIOFBIH')
                                         OR (Employee."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                                            WA.INIT;
                                            WA2.SETFILTER("Entry No.", '<>%1', 0);
                                            IF WA2.FINDLAST THEN
                                                WA."Entry No." := WA2."Entry No." + 1
                                            ELSE
                                                WA."Entry No." := 1;
                                            WageSetup.Get();
                                            WA.VALIDATE("Employee No.", MealLineTemp."Employee No.");
                                            IF ((Employee."Contribution Category Code" = 'FBIH') OR (Employee."Contribution Category Code" = 'FBIHRS')) THEN BEGIN
                                                WA.VALIDATE("Wage Addition Type", WageSetup."Meal Code FBiH Taxable");
                                                WA.Description := WA.Description;
                                                WageSetup.GET;
                                                IF ((Employee."Hours In Day" <> 8)) THEN
                                                    WA.VALIDATE(Amount, (WageSetup."Meal Taxable FBiH Untaxable" * Employee."Hours In Day" / 8) * MealLineTemp.Workdays)
                                                ELSE
                                                    WA.VALIDATE(Amount, WageSetup."Meal Taxable FBiH Untaxable" * MealLineTemp.Workdays);
                                                IF (Employee."Contact Center") THEN
                                                    WA.VALIDATE(Amount, (WageSetup."Meal Taxable FBiH Untaxable" / 8) * MealLineTemp.Workdays);
                                            END
                                            ELSE BEGIN
                                                WA.VALIDATE("Wage Addition Type", '824');
                                                WA.Description := 'TOPLI OBROK BD OPOREZIVI';
                                                WageSetup.GET;
                                                IF ((Employee."Hours In Day" <> 8)) THEN
                                                    WA.VALIDATE(Amount, (WageSetup."Meal Taxable BD" * Employee."Hours In Day" / 8) * MealLineTemp.Workdays)
                                                ELSE
                                                    WA.VALIDATE(Amount, WageSetup."Meal Taxable BD" * MealLineTemp.Workdays);
                                                IF (Employee."Contact Center") THEN
                                                    WA.VALIDATE(Amount, (WageSetup."Meal Taxable BD" / 8) * MealLineTemp.Workdays);


                                            END;
                                            // WA."Amount to Pay":=WageSetup."Meal Taxable FBiH Untaxable"*MealLineTemp.Workdays;
                                            WA."Month of Wage" := MealHeader."Month Of Wage";
                                            WA."Year of Wage" := MealHeader."Year Of Wage";
                                            WA."System Entry" := TRUE;
                                            WA.Meal := TRUE;
                                            WA.INSERT;

                                        END;
                                    END;
                                UNTIL Employee.NEXT = 0;
                        END
                        ELSE BEGIN
                            MealLineTemp.DELETEALL;
                            CalcMeal(MealHeader);
                        END;
                    END;
                MealHeader.Status::Closed:
                    MESSAGE(Txt007);
                MealHeader.Status::Locked:
                    MESSAGE(Txt008);
            END;
        END
        ELSE
            MESSAGE(Txt009);
    end;

    procedure ValidateDate(StartDate: Date; EndDate: Date)
    var
        Text000: Label 'Start Date must have value.';
        Text001: Label 'End Date must not be before Start date.';
    begin
        IF EndDate <> 0D THEN BEGIN
            IF StartDate = 0D THEN
                ERROR(Text000);
            IF EndDate < StartDate THEN
                ERROR(Text001);
        END;

    end;

    procedure GetHoursByType(EmployeeCode: Code[20]; WorkType: Code[20]; Month: Integer; Year: Integer) HoursByType: Decimal
    var
        AbsenceEmp: Record "Employee Absence";
    begin
        AbsenceEmp.RESET;
        AbsenceEmp.SETRANGE(AbsenceEmp."Employee No.", EmployeeCode);
        AbsenceEmp.SETRANGE("From Date", GetMonthRange(Month, Year, TRUE), GetMonthRange(Month, Year, FALSE));
        AbsenceEmp.SETRANGE("Cause of Absence Code", WorkType);
        HoursByType := 0;
        IF AbsenceEmp.FINDFIRST THEN
            REPEAT
                HoursByType := HoursByType + AbsenceEmp.Quantity;
            UNTIL AbsenceEmp.NEXT = 0;
    end;

    procedure CheckPeriodForEntries(Absence: Record "Employee Absence"; "Filter": Text[300])
    var
        TargetDate: Date;
        ToDate: Date;
        FromDate: Date;
        DailyHours: Decimal;
        Cause: Record "Cause of Absence";
        CauseTemp: Record "Cause of Absence";
        MarkIt: Boolean;
        ConflictArray: array[100] of Integer;
        ConflictText: Text[250];
        Txt001: Label 'Conflicts were found with following entries in Absences table:';
        Txt002: Label 'Please correct these conflicts before proceeding with data entry.';
        AbsenceTemp: Record "Employee Absence";
    begin
        WageSetup.FINDFIRST;
        AbsenceTemp.LOCKTABLE;

        TargetDate := Absence."From Date";
        Cause.GET(Absence."Cause of Absence Code");
        CASE Absence."Unit of Measure Code" OF
            WageSetup."Hour Unit of Measure":
                DailyHours1 := Absence.Quantity;
            WageSetup."Day Unit of Measure":
                DailyHours1 := WageSetup."Hours in Day";
        END;
        CLEAR(ConflictArray);
        LastArray := 0;

        WHILE TargetDate <= Absence."To Date" DO BEGIN
            DailyHours := DailyHours1;
            AbsenceTemp.RESET;
            //    AbsenceTemp.SETFILTER("Statistics Group Code",'%1',Filter);
            //AbsenceTemp.SETFILTER("Statistics Group Code", '%1', Absence."Statistics Group Code");

            AbsenceTemp.SETFILTER("Employee No.", Absence."Employee No.");
            AbsenceTemp.SETFILTER("From Date", '<=%1', TargetDate);
            AbsenceTemp.SETFILTER("To Date", '>=%1', TargetDate);
            AbsenceTemp.SETFILTER("Entry No.", '<>%1&<>0', Absence."Entry No.");
            AbsenceTemp.SETCURRENTKEY("Employee No.", "From Date");
            IF AbsenceTemp.FINDFIRST THEN
                REPEAT
                    CASE AbsenceTemp."Unit of Measure Code" OF
                        WageSetup."Hour Unit of Measure":
                            DailyHours := DailyHours + AbsenceTemp.Quantity;
                        WageSetup."Day Unit of Measure":
                            DailyHours := DailyHours + WageSetup."Hours in Day";
                    END;
                    CauseTemp.GET(AbsenceTemp."Cause of Absence Code");
                    MarkIt := (Absence."Cause of Absence Code" = AbsenceTemp."Cause of Absence Code") OR (DailyHours > 24);
                    //OR ((NOT(CauseTemp."Added To Hour Pool")) AND (NOT(Cause."Added To Hour Pool"))) ;
                    IF MarkIt THEN
                        MarkConflict(AbsenceTemp, Absence, ConflictArray);
                UNTIL AbsenceTemp.NEXT = 0;
            TargetDate := CALCDATE('+1D', TargetDate);
        END;

        ConflictText := '';
        /*FOR I := 1 TO LastArray DO
          ConflictText := COPYSTR(ConflictText + ' ' +  FORMAT(ConflictArray[I]) , 1, MAXSTRLEN(ConflictText));
        IF ConflictText <> '' THEN
          BEGIN
            MESSAGE(Txt001);
            MESSAGE(ConflictText);
            ERROR(Txt002);
          END;      */

    end;

    procedure BLOBImport2(var BLOBRef: Record TempBlob temporary; Name: Text): Text
    begin
        EXIT(BLOBImportWithFilter2(BLOBRef, Text007, Name, AllFilesDescriptionTxt, AllFilesFilterTxt));
    end;

    procedure BLOBImportWithFilter2(var TempBlob: Record TempBlob; DialogCaption: Text; Name: Text; FileFilter: Text; ExtFilter: Text): Text
    var
        NVInStream: InStream;
        NVOutStream: OutStream;
        UploadResult: Boolean;
        ErrorMessage: Text;
    begin
        // ExtFilter examples: 'csv,txt' if you only accept *.csv and *.txt or '*.*' if you accept any extensions
        CLEARLASTERROR;

        IF (FileFilter = '') XOR (ExtFilter = '') THEN
            ERROR(SingleFilterErr);

        // There is no way to check if NVInStream is null before using it after calling the
        // UPLOADINTOSTREAM therefore if result is false this is the only way we can throw the error.
        UploadResult := UPLOADINTOSTREAM(DialogCaption, '', FileFilter, Name, NVInStream);
        IF UploadResult THEN
            ValidateFileExtension(Name, ExtFilter);
        IF UploadResult THEN BEGIN
            TempBlob.Blob.CREATEOUTSTREAM(NVOutStream);
            COPYSTREAM(NVOutStream, NVInStream);
            EXIT(Name);
        END;
        ErrorMessage := GETLASTERRORTEXT;
        IF ErrorMessage <> '' THEN
            ERROR(ErrorMessage);

        EXIT('');
    end;

    procedure ValidateFileExtension(FilePath: Text; ValidExtensions: Text)
    var
        FileExt: Text;
        LowerValidExts: Text;
    begin
        IF STRPOS(ValidExtensions, AllFilesFilterTxt) <> 0 THEN
            EXIT;

        FileExt := LOWERCASE(GetExtension(GetFileName(FilePath)));
        LowerValidExts := LOWERCASE(ValidExtensions);

        IF STRPOS(LowerValidExts, FileExt) = 0 THEN
            ERROR(STRSUBSTNO(UnsupportedFileExtErr, FileExt, LowerValidExts));
    end;

    procedure GetExtension(Name: Text): Text
    var
        FileExtension: Text;
    begin
        FileExtension := PathHelper.GetExtension(Name);

        IF FileExtension <> '' THEN
            FileExtension := DELCHR(FileExtension, '<', '.');

        EXIT(FileExtension);
    end;

    procedure GetFileName(FilePath: Text): Text
    begin
        EXIT(PathHelper.GetFileName(FilePath));
    end;


}

