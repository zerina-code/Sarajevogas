/*report 50110 "Vacation Calculation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; "Employee")
        {

            trigger OnPreDataItem()
            begin



                EmployeeRec.SETFILTER(Status, '%1|%2', 0, 1);
                EmployeeRec.SETFILTER("External employer Status", '%1', EmployeeRec."External employer Status"::" ");


                IF EmployeeRec.FINDFIRST THEN BEGIN

                    REPEAT


                        PlanGO."First Name" := EmployeeRec."First Name";
                        PlanGO."Last Name" := EmployeeRec."Last Name";
                        PlanGO.Year := Year;
                        PlanGO."Employee No." := EmployeeRec."No.";
                        EVALUATE(Order, EmployeeRec."No.");
                        PlanGO.Order := Order;

                        VacationSetup.SETFILTER(Year, '%1', Year);
                        IF VacationSetup.FINDFIRST THEN BEGIN
                            IF EmployeeRec."Org Entity Code" = 'BD' THEN
                                PlanGO."Legal Grounds" := VacationSetup."Base Days BD";
                            IF EmployeeRec."Org Entity Code" = 'RS' THEN
                                PlanGO."Legal Grounds" := VacationSetup."Base Days RS";
                            IF EmployeeRec."Org Entity Code" = 'FBIH' THEN
                                PlanGO."Legal Grounds" := VacationSetup."Base Days";

                        END;

                        PlanGO.RESET;
                        PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        PlanGO.SETFILTER(Year, '%1', Year);
                        IF NOT PlanGO.FINDFIRST THEN BEGIN
                            PlanGO."Starting Date of I part" := 0D;
                            PlanGO."Ending Date of I part" := 0D;

                            PlanGO.INSERT;
                        END;
                        PlanGO.RESET;
                        PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        PlanGO.SETFILTER(Year, '%1', Year);

                        IF PlanGO.FINDFIRST THEN BEGIN

                            IF ((EmployeeRec."Disabled Person" = TRUE)) THEN BEGIN

                                ELD.RESET;
                                ELD.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                ELD.SETFILTER(Active, '%1', TRUE);
                                IF ELD.FINDFIRST THEN BEGIN
                                    IF EVALUATE(LevelValue, ELD."Level of Disability") THEN
                                        Level := LevelValue
                                    ELSE
                                        Level := 0;
                                    IF Level > 50 THEN BEGIN
                                        SocialStatus.SETFILTER("No.", '%1', '1');
                                        IF SocialStatus.FINDFIRST THEN BEGIN
                                            PlanGO."Days based on Disability" := SocialStatus.Points;
                                            PlanGO.MODIFY;
                                        END;


                                    END
                                    ELSE BEGIN
                                        PlanGO."Days based on Disability" := 0;
                                        PlanGO.MODIFY;
                                    END;
                                END
                                ELSE BEGIN
                                    PlanGO."Days based on Disability" := 0;
                                    PlanGO.MODIFY
                                END;

                            END
                            ELSE
                                PlanGO."Days based on Disability" := 0;



                           





                            AddDayyy := '<+' + FORMAT(EmployeeRec."Years of Experience") + 'Y+' + FORMAT(EmployeeRec."Months of Experience") + 'M+' + FORMAT(EmployeeRec."Days of Experience") + 'D>';
                            Datttt := CALCDATE(AddDayyy, TODAY);

                            PointsperExperienceYears.RESET;

                            PointsperExperienceYears.SETFILTER("Today Min", '<=%1', Datttt);
                            PointsperExperienceYears.SETCURRENTKEY(No);
                            PointsperExperienceYears.ASCENDING;
                            IF PointsperExperienceYears.FINDLAST THEN BEGIN
                                PlanGO."Days based on Work experience" := PointsperExperienceYears.Vacation;
                                PlanGO.MODIFY;
                            END
                            ELSE BEGIN
                                PlanGO."Days based on Work experience" := 0;
                                PlanGO.MODIFY;

                            END;







                            //roditelj djece sa posebnim potrebama
                            IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No.", '%1', '2');
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    PlanGO."Based on Disabled Child" := SocialStatus.Points;
                                END;
                                PlanGO.MODIFY;
                            END
                            ELSE
                                PlanGO."Based on Disabled Child" := 0;



                            VacationSetup.SETFILTER(Year, '%1', Year);
                            IF VacationSetup.FINDFIRST THEN BEGIN
                                IF EmployeeRec."Org Entity Code" = 'BD' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days BD";
                                IF EmployeeRec."Org Entity Code" = 'RS' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days RS";
                                IF EmployeeRec."Org Entity Code" = 'FBIH' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days";

                            END;

                            UsedDaysThisYear := 0;
                            Absence.RESET;
                            Absence.SETFILTER("Employee No.", '%1', "No.");
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDaysThisYear := Absence.COUNT;
                            PlanGO."Total days" := PlanGO."Legal Grounds" - UsedDaysThisYear + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";



                            PlanGO.MODIFY;

                            PlanGO."Valid Vacation" := TRUE;
                            PlanGO.MODIFY;
                        END;



                    UNTIL EmployeeRec.NEXT = 0;
                END;

                //HR01 end

            end;
        }
        dataitem("<Employee2>"; "Employee")
        {

            trigger OnAfterGetRecord()
            begin

                Vacationsetuphistory.RESET;
                Vacationsetuphistory.SETFILTER(Year, '%1', Year);
                IF Vacationsetuphistory.FINDFIRST THEN BEGIN

                    IF "Org Entity Code" = 'FBIH' THEN
                        BrojDana := Vacationsetuphistory."Days FBIH";
                    IF "Org Entity Code" = 'RS' THEN
                        BrojDana := Vacationsetuphistory."Days RS";
                    IF "Org Entity Code" = 'BD' THEN
                        BrojDana := Vacationsetuphistory."Days BD";
                END
                ELSE BEGIN
                    ERROR('Ne postoje adekvatni podaci u postavi');
                END;

                AddYear := '<+' + FORMAT(BrojDana) + 'D>';


                NeAzuriraj := FALSE;
                UsedDaysThisYear := 0;
                Year2 := Year;
                WB.RESET;
                PlanGO.RESET;
                DodajMjesec := 0;

                //Gledam da li zadovoljava ugovor

                ECLPrviPut.RESET;
                ECLPrviPut.SETFILTER("Employee No.", '%1', "No.");
                ECLPrviPut.SETFILTER("Reason for Change", '%1', 2);
                ECLPrviPut.SETFILTER("First Time Employed", '%1', TRUE);
                ECLPrviPut.SETFILTER("Way of Employment", '<>%1', ECLPrviPut."Way of Employment"::"From Employment");
                ECLPrviPut.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                ECLPrviPut.SETFILTER("Show Record", '%1', TRUE);
                IF ECLPrviPut.FINDFIRST THEN BEGIN

                    //prvo zaposlenje gleda samo trenutnu radnu knjižicu
                    WBFirst.RESET;
                    WBFirst.SETFILTER("Employee No.", '%1', "No.");
                    WBFirst.SETFILTER("Starting Date", '<=%1', TODAY);
                    WBFirst.SETFILTER("Current Company", '%1', TRUE);
                    WBFirst.SETCURRENTKEY("Starting Date");
                    WBFirst.ASCENDING;
                    IF WBFirst.FINDLAST THEN BEGIN
                        IF WBFirst.Months >= 6 THEN BEGIN
                            NeAzuriraj := TRUE;
                        END
                        ELSE BEGIN
                            PlanGO.RESET;
                            PlanGO.SETFILTER("Employee No.", '%1', "No.");
                            PlanGO.SETFILTER(Year, '%1', Year);
                            IF PlanGO.FINDFIRST THEN BEGIN
                                PlanGO."Days based on Work experience" := 0;
                                PlanGO."Days based on Disability" := 0;
                                PlanGO."Based on Disabled Child" := 0;
                                NeAzuriraj := FALSE;

                                //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                //knjižici zaposlenik i treba da ima 4 dana.
                                IF DATE2DMY(WBFirst."Starting Date", 3) <> Year THEN BEGIN

                                    //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                    Found1 := FALSE;
                                    CountYears1 := 0;
                                    CountMonths1 := 0;
                                    Prethodni := 0;
                                    Trenutni := 0;

                                    RecDate1.RESET;
                                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                    RecDate1.SETRANGE("Period Start", WBFirst."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3))));
                                    IF RecDate1.FINDSET THEN BEGIN
                                        LastFoundDate1 := WBFirst."Starting Date";
                                        // *** find count of years ***
                                        TempDate1 := CALCDATE('<+1Y>', WBFirst."Starting Date");
                                        //već sam povecala za 1 god
                                        Found1 := TRUE;
                                        REPEAT


                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                //ako zadovolji uslove treba povećati za +1G

                                                AddYear := '';
                                                CountYears1 += 1;

                                                //  LastFoundDate1 := TempDate1;
                                                AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                TempDate1 := CALCDATE(AddYear, WBFirst."Starting Date");
                                            END
                                            ELSE
                                                Found1 := FALSE;
                                        UNTIL NOT Found1;

                                        //pronašao broj godina i onda temp1 ide dalje
                                        NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                        TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WBFirst."Starting Date"));
                                        Found1 := TRUE;
                                        REPEAT

                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                AddMonth := '';
                                                CountMonths1 += 1;

                                                // LastFoundDate1 := TempDate1;
                                                AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                TempDate1 := CALCDATE(AddMonth, WBFirst."Starting Date");
                                            END
                                            ELSE
                                                Found1 := FALSE;
                                        UNTIL NOT Found1;

                                        NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                        Prethodni := CountMonths1;
                                    END;

                                    PlanGO."Legal Grounds" := WBFirst.Months - Prethodni;
                                    UsedDaysThisYear := 0;
                                    Absence.RESET;
                                    Absence.SETFILTER("Employee No.", '%1', "No.");
                                    Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                    Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                    IF Absence.FINDSET THEN
                                        UsedDaysThisYear := Absence.COUNT;
                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";

                                    PlanGO.MODIFY;


                                    //kraj



                                END
                                ELSE BEGIN


                                    PlanGO."Legal Grounds" := WBFirst.Months;
                                    UsedDaysThisYear := 0;
                                    Absence.RESET;
                                    Absence.SETFILTER("Employee No.", '%1', "No.");
                                    Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                    Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                    IF Absence.FINDSET THEN
                                        UsedDaysThisYear := Absence.COUNT;
                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                    PlanGO.MODIFY;
                                    //ako je ista godina samo trebam dodjeliti broj dana

                                END;

                                //kraj za prelaz godine

                            END
                            ELSE BEGIN

                                //ako prelazi 6 mjeseci nemoj ažurirati
                                NeAzuriraj := TRUE;
                            END;


                            //pronašao Plan GO
                        END;

                        //pronašao radnu knjižicu
                    END;





                END
                ELSE BEGIN



                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "No.");
                    ECL.SETFILTER("Reason for Change", '%1', 2);
                    ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                    ECL.SETFILTER("Show Record", '%1', TRUE);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                    IF ECL.FINDFIRST THEN BEGIN
                        //gledam ugovore koji su biro i duzi prekid radnog odnosa, oni također gledaju samo radnu knjižicu


                        //dodala

                        WBFirst.RESET;
                        WBFirst.SETFILTER("Employee No.", '%1', "No.");
                        WBFirst.SETFILTER("Starting Date", '<=%1', TODAY);
                        WBFirst.SETFILTER("Current Company", '%1', TRUE);
                        WBFirst.SETCURRENTKEY("Starting Date");
                        WBFirst.ASCENDING;
                        IF WBFirst.FINDLAST THEN BEGIN

                            IF WBFirst.Months >= 6 THEN BEGIN
                                NeAzuriraj := TRUE;
                            END
                            ELSE BEGIN
                                PlanGO.RESET;
                                PlanGO.SETFILTER("Employee No.", '%1', "No.");
                                PlanGO.SETFILTER(Year, '%1', Year);

                                IF PlanGO.FINDFIRST THEN BEGIN
                                    PlanGO."Days based on Work experience" := 0;
                                    PlanGO."Days based on Disability" := 0;
                                    PlanGO."Based on Disabled Child" := 0;
                                    NeAzuriraj := FALSE;

                                    //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                    //knjižici zaposlenik i treba da ima 4 dana.
                                    IF DATE2DMY(WBFirst."Starting Date", 3) <> Year THEN BEGIN

                                        //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                        Found1 := FALSE;
                                        CountYears1 := 0;
                                        CountMonths1 := 0;
                                        Prethodni := 0;
                                        Trenutni := 0;

                                        RecDate1.RESET;
                                        RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                        RecDate1.SETRANGE("Period Start", WBFirst."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3))));
                                        IF RecDate1.FINDSET THEN BEGIN
                                            LastFoundDate1 := WBFirst."Starting Date";
                                            // *** find count of years ***
                                            TempDate1 := CALCDATE('<+1Y>', WBFirst."Starting Date");
                                            //već sam povecala za 1 god
                                            Found1 := TRUE;
                                            REPEAT


                                                IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    //ako zadovolji uslove treba povećati za +1G

                                                    AddYear := '';
                                                    CountYears1 += 1;

                                                    //  LastFoundDate1 := TempDate1;
                                                    AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                    TempDate1 := CALCDATE(AddYear, WBFirst."Starting Date");
                                                END
                                                ELSE
                                                    Found1 := FALSE;
                                            UNTIL NOT Found1;

                                            //pronašao broj godina i onda temp1 ide dalje
                                            NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                            TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WBFirst."Starting Date"));
                                            Found1 := TRUE;
                                            REPEAT

                                                IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                    AddMonth := '';
                                                    CountMonths1 += 1;

                                                    // LastFoundDate1 := TempDate1;
                                                    AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                    TempDate1 := CALCDATE(AddMonth, WBFirst."Starting Date");
                                                END
                                                ELSE
                                                    Found1 := FALSE;
                                            UNTIL NOT Found1;

                                            NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                            Prethodni := CountMonths1;
                                        END;

                                        PlanGO."Legal Grounds" := WBFirst.Months - Prethodni;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;
                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                        PlanGO.MODIFY;


                                        //kraj



                                    END
                                    ELSE BEGIN


                                        PlanGO."Legal Grounds" := WBFirst.Months;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;
                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                        PlanGO.MODIFY;
                                        //ako je ista godina samo trebam dodjeliti broj dana

                                    END;

                                    //kraj za prelaz godine

                                END
                                ELSE BEGIN

                                    //ako prelazi 6 mjeseci nemoj ažurirati
                                    NeAzuriraj := TRUE;
                                END;


                                //pronašao Plan GO
                            END;

                        END;

                        //kraj dodala









                    END
                    ELSE BEGIN

                        ECLRadni.RESET;
                        ECLRadni.SETFILTER("Employee No.", '%1', "No.");
                        ECLRadni.SETFILTER("Reason for Change", '%1', 2);
                        ECLRadni.SETFILTER("Way of Employment", '%1', ECLRadni."Way of Employment"::"From Employment");
                        ECLRadni.SETFILTER("Show Record", '%1', TRUE);
                        ECLRadni.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                        IF ECLRadni.FINDFIRST THEN BEGIN
                            //MESSAGE('Zaposlenik iz radnog odnosa '+ECLRadni."Employee No."+ ' broj stavke je :'+ FORMAT(ECLRadni."No."));

                            //za ove zaposlenike gledam cijeli radni staž
                            TrenutniDatumZaposlenja := 0D;
                            StartingDate := 0D;
                            StvarniStartDate := 0D;
                            StvarniEndDate := 0D;
                            Godine := 0;
                            Mjeseci := 0;
                            Dani := 0;

                            WorkBooklet.RESET;
                            WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                            WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY);
                            WorkBooklet.SETCURRENTKEY("Starting Date");
                            WorkBooklet.ASCENDING;
                            IF WorkBooklet.FINDLAST THEN BEGIN
                                TrenutniDatumZaposlenja := WorkBooklet."Starting Date";
                                Godine := Godine + WorkBooklet.Years;
                                Mjeseci := Mjeseci + WorkBooklet.Months;
                                Dani := Dani + WorkBooklet.Days;
                            END
                            ELSE BEGIN
                                TrenutniDatumZaposlenja := 0D;
                                Godine := Godine + 0;
                                Mjeseci := Mjeseci + 0;
                                Dani := Dani + 0;
                            END;


                            //Da zaposlenik pripada opsegu od 6M kako bi se provjerilo da li treba imati zakonsku osnovu ili ne

                            IF (TrenutniDatumZaposlenja <> 0D) AND ((TrenutniDatumZaposlenja <= WORKDATE) AND (TrenutniDatumZaposlenja >= CALCDATE('<-6M>', WORKDATE))) THEN BEGIN


                                WorkBooklet.RESET;
                                WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                                //WorkBooklet.SETFILTER("Current Company",'%1',FALSE);
                                WorkBooklet.SETFILTER("Starting Date", '<>%1 & <=%2', TrenutniDatumZaposlenja, TODAY);
                                //WorkBooklet.SETFILTER("Starting Date",'<=%1',TODAY);
                                WorkBooklet.SETCURRENTKEY("Starting Date");
                                WorkBooklet.ASCENDING(FALSE);
                                IF WorkBooklet.FINDFIRST THEN BEGIN
                                    //đemka
                                    IF ((CALCDATE('<-' + FORMAT(BrojDana) + 'D>', TrenutniDatumZaposlenja)) <= WorkBooklet."Ending Date") THEN BEGIN
                                        Godine := Godine + WorkBooklet.Years;
                                        Mjeseci := Mjeseci + WorkBooklet.Months;
                                        Dani := Dani + WorkBooklet.Days;

                                    END;
                                END;

                                //prethodni radni staž
                                WorkBooklet.RESET;
                                WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                                WorkBooklet.SETFILTER("Current Company", '%1', FALSE);
                                WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY);
                                WorkBooklet.SETCURRENTKEY("Starting Date");
                                WorkBooklet.ASCENDING(FALSE);
                                IF WorkBooklet.FINDSET THEN
                                    REPEAT


                                        WorkBooklet2 := WorkBooklet;
                                        WorkBooklet2.SETFILTER("Employee No.", '%1', "No.");
                                        WorkBooklet2.SETFILTER("Current Company", '%1', FALSE);
                                        WorkBooklet2.SETFILTER("Starting Date", '<=%1', TODAY);
                                        WorkBooklet2.SETCURRENTKEY("Starting Date");
                                        WorkBooklet2.ASCENDING(FALSE);
                                        WorkBooklet2.NEXT(1);
                                        IF (WorkBooklet2."Ending Date" <> 0D) AND (WorkBooklet."Contract No." <> WorkBooklet2."Contract No.") THEN BEGIN
                                            IF (CALCDATE('<-' + FORMAT(BrojDana) + 'D>', WorkBooklet."Starting Date") <= WorkBooklet2."Ending Date") THEN BEGIN

                                                StartingDate := WorkBooklet."Starting Date";

                                                Godine := Godine + WorkBooklet2.Years;
                                                Mjeseci := Mjeseci + WorkBooklet2.Months;
                                                Dani := Dani + WorkBooklet2.Days;

                                            END;
                                        END;

                                    UNTIL WorkBooklet.NEXT = 0;

                                StvarniStartDate := CALCDATE('<-' + FORMAT(Godine) + 'Y' + '-' + FORMAT(Mjeseci) + 'M' + '-' + FORMAT(Dani) + 'D>', TODAY);
                                StvarniEndDate := TODAY;

                                CountDays := 0;
                                CountMonths1 := 0;
                                CountYears1 := 0;
                                Found1 := FALSE;
                                UkupniDani := 0;
                                UkupniMjeseci := 0;
                                UkupnoGodine := 0;

                                RecDate1.RESET;
                                RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                RecDate1.SETRANGE("Period Start", StvarniStartDate, CALCDATE('<+1D>', StvarniEndDate));
                                IF RecDate1.FINDSET THEN BEGIN
                                    LastFoundDate1 := StvarniStartDate;
                                    // *** find count of years ***
                                    TempDate1 := CALCDATE('<+1Y>', StvarniStartDate);
                                    //već sam povecala za 1 god
                                    Found1 := TRUE;
                                    REPEAT


                                        IF (TempDate1 <= CALCDATE('<+1D>', StvarniEndDate)) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            //ako zadovolji uslove treba povećati za +1G

                                            AddYear := '';
                                            CountYears1 += 1;

                                            //  LastFoundDate1 := TempDate1;
                                            AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                            TempDate1 := CALCDATE(AddYear, StvarniStartDate);
                                        END
                                        ELSE
                                            Found1 := FALSE;
                                    UNTIL NOT Found1;

                                    //pronašao broj godina i onda temp1 ide dalje
                                    NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                    TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, StvarniStartDate));
                                    Found1 := TRUE;
                                    REPEAT

                                        IF (TempDate1 <= CALCDATE('<+1D>', StvarniEndDate)) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                            AddMonth := '';
                                            CountMonths1 += 1;

                                            // LastFoundDate1 := TempDate1;
                                            AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                            TempDate1 := CALCDATE(AddMonth, StvarniStartDate);
                                        END
                                        ELSE
                                            Found1 := FALSE;
                                    UNTIL NOT Found1;

                                    NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                                    TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, StvarniStartDate));
                                    Found1 := TRUE;
                                    REPEAT
                                        IF (TempDate1 <= CALCDATE('<+1D>', StvarniEndDate)) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountDays += 1;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<+1d>', TempDate1);
                                        END
                                        ELSE
                                            Found1 := FALSE;
                                    UNTIL NOT Found1;
                                END;


                                UkupniDani := CountDays;
                                UkupniMjeseci := CountMonths1;
                                UkupnoGodine := CountYears1;


                                //pronašla sam ukupno mjeseci kao da je bez prekida radnog odnosa
                                //sada gledam da li unutar ovog opsega imam prijelaz ili da li imam preko 6 mjeseci

                                IF (UkupniMjeseci < 6) AND (UkupnoGodine = 0) THEN BEGIN

                                    //spada unutar 6 mjeseci
                                    PlanGO.RESET;
                                    PlanGO.SETFILTER("Employee No.", '%1', "No.");
                                    PlanGO.SETFILTER(Year, '%1', Year);
                                    IF PlanGO.FINDFIRST THEN BEGIN
                                        PlanGO."Days based on Work experience" := 0;
                                        PlanGO."Days based on Disability" := 0;
                                        PlanGO."Based on Disabled Child" := 0;
                                        NeAzuriraj := FALSE;


                                        //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                        //knjižici zaposlenik i treba da ima 4 dana.
                                        PlanGO."Legal Grounds" := UkupniMjeseci;

                                        //PlanGO."Legal Grounds":=WBFirst.Months;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;


                                        //PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-UsedDaysThisYear;

                                        //da li trebam obračunati prijelaz godine ako se desio
                                        PlanPrijelaz.RESET;
                                        PlanPrijelaz.SETFILTER("Employee No.", '%1', "No.");
                                        PlanPrijelaz.SETFILTER(Year, '%1', Year - 1);
                                        IF PlanPrijelaz.FINDFIRST THEN BEGIN
                                            IF PlanPrijelaz."Legal Grounds" <= PlanGO."Legal Grounds" THEN
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear - PlanPrijelaz."Legal Grounds"
                                            ELSE
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;

                                        END
                                        ELSE BEGIN
                                            PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        END;


                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                        PlanGO.MODIFY;
                                        //ako je ista godina samo trebam dodjeliti broj dana

                                    END;









                                END
                                ELSE BEGIN

                                    NeAzuriraj := TRUE;

                                END;





                            END;




                        END
                        ELSE BEGIN
                            NeAzuriraj := TRUE;
                        END;


                    END;

                END;
            end;

            trigger OnPostDataItem()
            begin
                //REPORT.RUNMODAL(50020,FALSE,TRUE);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Returned to Company", '%1', FALSE);
                SETFILTER("External employer Status", '%1', EmployeeRec."External employer Status"::" ");
                SETFILTER(Status, '%1|%2', 0, 1);
            end;
        }
        dataitem("<Employee3>"; "Employee")
        {

            trigger OnAfterGetRecord()
            begin

                Vacationsetuphistory.RESET;
                Vacationsetuphistory.SETFILTER(Year, '%1', Year);
                IF Vacationsetuphistory.FINDFIRST THEN BEGIN

                    IF "Org Entity Code" = 'FBIH' THEN
                        BrojDana := Vacationsetuphistory."Days FBIH";
                    IF "Org Entity Code" = 'RS' THEN
                        BrojDana := Vacationsetuphistory."Days RS";
                    IF "Org Entity Code" = 'BD' THEN
                        BrojDana := Vacationsetuphistory."Days BD";
                END
                ELSE BEGIN
                    ERROR('Ne postoje adekvatni podaci u postavi');
                END;

                AddYear := '<+' + FORMAT(BrojDana) + 'D>';


                NeAzuriraj := FALSE;
                UsedDaysThisYear := 0;
                Year2 := Year;
                WB.RESET;
                PlanGO.RESET;
                DodajMjesec := 0;


                //Gledam da li zadovoljava ugovor

                ECLPrviPut.RESET;
                ECLPrviPut.SETFILTER("Employee No.", '%1', "No.");
                ECLPrviPut.SETFILTER("Reason for Change", '%1', 2);
                ECLPrviPut.SETFILTER("First Time Employed", '%1', TRUE);
                ECLPrviPut.SETFILTER("Way of Employment", '<>%1', ECLPrviPut."Way of Employment"::"From Employment");
                ECLPrviPut.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                ECLPrviPut.SETFILTER("Show Record", '%1', TRUE);
                IF ECLPrviPut.FINDFIRST THEN BEGIN

                    //prvo zaposlenje gleda samo trenutnu radnu knjižicu
                    WBFirst.RESET;
                    WBFirst.SETFILTER("Employee No.", '%1', "No.");
                    WBFirst.SETFILTER("Starting Date", '<=%1', TODAY);
                    WBFirst.SETFILTER("Current Company", '%1', TRUE);
                    WBFirst.SETCURRENTKEY("Starting Date");
                    WBFirst.ASCENDING;
                    IF WBFirst.FINDLAST THEN BEGIN
                        IF WBFirst.Months >= 6 THEN BEGIN
                            NeAzuriraj := TRUE;
                        END
                        ELSE BEGIN
                            PlanGO.RESET;
                            PlanGO.SETFILTER("Employee No.", '%1', "No.");
                            PlanGO.SETFILTER(Year, '%1', Year);
                            IF PlanGO.FINDFIRST THEN BEGIN
                                PlanGO."Days based on Work experience" := 0;
                                PlanGO."Days based on Disability" := 0;
                                PlanGO."Based on Disabled Child" := 0;
                                NeAzuriraj := FALSE;

                                //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                //knjižici zaposlenik i treba da ima 4 dana.
                                IF DATE2DMY(WBFirst."Starting Date", 3) <> Year THEN BEGIN

                                    //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                    Found1 := FALSE;
                                    CountYears1 := 0;
                                    CountMonths1 := 0;
                                    Prethodni := 0;
                                    Trenutni := 0;

                                    RecDate1.RESET;
                                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                    RecDate1.SETRANGE("Period Start", WBFirst."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3))));
                                    IF RecDate1.FINDSET THEN BEGIN
                                        LastFoundDate1 := WBFirst."Starting Date";
                                        // *** find count of years ***
                                        TempDate1 := CALCDATE('<+1Y>', WBFirst."Starting Date");
                                        //već sam povecala za 1 god
                                        Found1 := TRUE;
                                        REPEAT


                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                //ako zadovolji uslove treba povećati za +1G

                                                AddYear := '';
                                                CountYears1 += 1;

                                                //  LastFoundDate1 := TempDate1;
                                                AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                TempDate1 := CALCDATE(AddYear, WBFirst."Starting Date");
                                            END
                                            ELSE
                                                Found1 := FALSE;
                                        UNTIL NOT Found1;

                                        //pronašao broj godina i onda temp1 ide dalje
                                        NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                        TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WBFirst."Starting Date"));
                                        Found1 := TRUE;
                                        REPEAT

                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                AddMonth := '';
                                                CountMonths1 += 1;

                                                // LastFoundDate1 := TempDate1;
                                                AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                TempDate1 := CALCDATE(AddMonth, WBFirst."Starting Date");
                                            END
                                            ELSE
                                                Found1 := FALSE;
                                        UNTIL NOT Found1;

                                        NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                        Prethodni := CountMonths1;
                                    END;

                                    PlanGO."Legal Grounds" := WBFirst.Months - Prethodni;
                                    UsedDaysThisYear := 0;
                                    Absence.RESET;
                                    Absence.SETFILTER("Employee No.", '%1', "No.");
                                    Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                    Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                    IF Absence.FINDSET THEN
                                        UsedDaysThisYear := Absence.COUNT;
                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";

                                    PlanGO.MODIFY;


                                    //kraj



                                END
                                ELSE BEGIN


                                    PlanGO."Legal Grounds" := WBFirst.Months;
                                    UsedDaysThisYear := 0;
                                    Absence.RESET;
                                    Absence.SETFILTER("Employee No.", '%1', "No.");
                                    Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                    Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                    IF Absence.FINDSET THEN
                                        UsedDaysThisYear := Absence.COUNT;
                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                    PlanGO.MODIFY;
                                    //ako je ista godina samo trebam dodjeliti broj dana

                                END;

                                //kraj za prelaz godine

                            END
                            ELSE BEGIN

                                //ako prelazi 6 mjeseci nemoj ažurirati
                                NeAzuriraj := TRUE;
                            END;


                            //pronašao Plan GO
                        END;

                        //pronašao radnu knjižicu
                    END;





                END
                ELSE BEGIN



                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "No.");
                    ECL.SETFILTER("Reason for Change", '%1', 2);
                    ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                    ECL.SETFILTER("Show Record", '%1', TRUE);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                    IF ECL.FINDFIRST THEN BEGIN
                        //gledam ugovore koji su biro i duzi prekid radnog odnosa, oni također gledaju samo radnu knjižicu


                        //dodala

                        WBFirst.RESET;
                        WBFirst.SETFILTER("Employee No.", '%1', "No.");
                        WBFirst.SETFILTER("Starting Date", '<=%1', TODAY);
                        WBFirst.SETFILTER("Current Company", '%1', TRUE);
                        WBFirst.SETCURRENTKEY("Starting Date");
                        WBFirst.ASCENDING;
                        IF WBFirst.FINDLAST THEN BEGIN

                            IF WBFirst.Months >= 6 THEN BEGIN
                                NeAzuriraj := TRUE;
                            END
                            ELSE BEGIN
                                PlanGO.RESET;
                                PlanGO.SETFILTER("Employee No.", '%1', "No.");
                                PlanGO.SETFILTER(Year, '%1', Year);

                                IF PlanGO.FINDFIRST THEN BEGIN
                                    PlanGO."Days based on Work experience" := 0;
                                    PlanGO."Days based on Disability" := 0;
                                    PlanGO."Based on Disabled Child" := 0;
                                    NeAzuriraj := FALSE;

                                    //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                    //knjižici zaposlenik i treba da ima 4 dana.
                                    IF DATE2DMY(WBFirst."Starting Date", 3) <> Year THEN BEGIN

                                        //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                        Found1 := FALSE;
                                        CountYears1 := 0;
                                        CountMonths1 := 0;
                                        Prethodni := 0;
                                        Trenutni := 0;

                                        RecDate1.RESET;
                                        RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                        RecDate1.SETRANGE("Period Start", WBFirst."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3))));
                                        IF RecDate1.FINDSET THEN BEGIN
                                            LastFoundDate1 := WBFirst."Starting Date";
                                            // *** find count of years ***
                                            TempDate1 := CALCDATE('<+1Y>', WBFirst."Starting Date");
                                            //već sam povecala za 1 god
                                            Found1 := TRUE;
                                            REPEAT


                                                IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    //ako zadovolji uslove treba povećati za +1G

                                                    AddYear := '';
                                                    CountYears1 += 1;

                                                    //  LastFoundDate1 := TempDate1;
                                                    AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                    TempDate1 := CALCDATE(AddYear, WBFirst."Starting Date");
                                                END
                                                ELSE
                                                    Found1 := FALSE;
                                            UNTIL NOT Found1;

                                            //pronašao broj godina i onda temp1 ide dalje
                                            NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                            TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WBFirst."Starting Date"));
                                            Found1 := TRUE;
                                            REPEAT

                                                IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WBFirst."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                    AddMonth := '';
                                                    CountMonths1 += 1;

                                                    // LastFoundDate1 := TempDate1;
                                                    AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                    TempDate1 := CALCDATE(AddMonth, WBFirst."Starting Date");
                                                END
                                                ELSE
                                                    Found1 := FALSE;
                                            UNTIL NOT Found1;

                                            NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                            Prethodni := CountMonths1;
                                        END;

                                        PlanGO."Legal Grounds" := WBFirst.Months - Prethodni;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;
                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                        PlanGO.MODIFY;


                                        //kraj



                                    END
                                    ELSE BEGIN


                                        PlanGO."Legal Grounds" := WBFirst.Months;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;
                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                        PlanGO.MODIFY;
                                        //ako je ista godina samo trebam dodjeliti broj dana

                                    END;

                                    //kraj za prelaz godine

                                END
                                ELSE BEGIN

                                    //ako prelazi 6 mjeseci nemoj ažurirati
                                    NeAzuriraj := TRUE;
                                END;


                                //pronašao Plan GO
                            END;

                        END;

                        //kraj dodala









                    END
                    ELSE BEGIN

                        ECLRadni.RESET;
                        ECLRadni.SETFILTER("Employee No.", '%1', "No.");
                        ECLRadni.SETFILTER("Reason for Change", '%1', 2);
                        ECLRadni.SETFILTER("Way of Employment", '%1', ECLRadni."Way of Employment"::"From Employment");
                        ECLRadni.SETFILTER("Show Record", '%1', TRUE);
                        ECLRadni.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                        IF ECLRadni.FINDFIRST THEN BEGIN
                            //MESSAGE('Zaposlenik iz radnog odnosa '+ECLRadni."Employee No."+ ' broj stavke je :'+ FORMAT(ECLRadni."No."));

                            //za ove zaposlenike gledam cijeli radni staž
                            TrenutniDatumZaposlenja := 0D;
                            StartingDate := 0D;
                            StvarniStartDate := 0D;
                            StvarniEndDate := 0D;
                            Godine := 0;
                            Mjeseci := 0;
                            Dani := 0;
                            BrojR := 0;

                            WorkBooklet.RESET;
                            WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                            WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY);
                            WorkBooklet.SETCURRENTKEY("Starting Date");
                            WorkBooklet.ASCENDING;
                            IF WorkBooklet.FINDLAST THEN BEGIN
                                TrenutniDatumZaposlenja := WorkBooklet."Starting Date";
                                BrojR := WorkBooklet."Contract No.";
                                Godine := Godine + WorkBooklet.Years;
                                Mjeseci := Mjeseci + WorkBooklet.Months;
                                Dani := Dani + WorkBooklet.Days;
                            END
                            ELSE BEGIN
                                TrenutniDatumZaposlenja := 0D;
                                Godine := Godine + 0;
                                Mjeseci := Mjeseci + 0;
                                Dani := Dani + 0;
                                BrojR := 0;
                            END;
                            IF BrojR = 0 THEN
                                ERROR('Zaposlenik ' + "No." + ' nema aktivnu radnu knjižicu, molimo Vas da isto prvobitno korigujete');


                            //Da zaposlenik pripada opsegu od 6M kako bi se provjerilo da li treba imati zakonsku osnovu ili ne

                            IF (TrenutniDatumZaposlenja <> 0D) AND ((TrenutniDatumZaposlenja <= WORKDATE) AND (TrenutniDatumZaposlenja >= CALCDATE('<-6M>', WORKDATE))) THEN BEGIN

                                WorkBooklet.RESET;
                                WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                                WorkBooklet.SETFILTER("Contract No.", '<>%1', BrojR);
                                WorkBooklet.SETFILTER("Starting Date", '<>%1', TrenutniDatumZaposlenja);
                                WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY);
                                WorkBooklet.SETCURRENTKEY("Starting Date");
                                WorkBooklet.ASCENDING(FALSE);
                                IF WorkBooklet.FINDFIRST THEN BEGIN
                                    //đemka
                                    IF ((CALCDATE('<-' + FORMAT(BrojDana) + 'D>', TrenutniDatumZaposlenja)) <= WorkBooklet."Ending Date") THEN BEGIN
                                        Godine := Godine + WorkBooklet.Years;
                                        Mjeseci := Mjeseci + WorkBooklet.Months;
                                        Dani := Dani + WorkBooklet.Days;

                                    END;
                                END;

                                //prethodni radni staž
                                WorkBooklet.RESET;
                                WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                                //WorkBooklet.SETFILTER("Current Company",'%1',FALSE);
                                WorkBooklet.SETFILTER("Contract No.", '<>%1', BrojR);
                                WorkBooklet.SETFILTER("Starting Date", '<>%1', TrenutniDatumZaposlenja);
                                WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY);
                                WorkBooklet.SETCURRENTKEY("Starting Date");
                                WorkBooklet.ASCENDING(FALSE);
                                IF WorkBooklet.FINDSET THEN
                                    REPEAT


                                        WorkBooklet2 := WorkBooklet;
                                        WorkBooklet2.SETFILTER("Employee No.", '%1', "No.");
                                        //WorkBooklet2.SETFILTER("Current Company",'%1',FALSE);
                                        WorkBooklet2.SETFILTER("Contract No.", '<>%1', BrojR);
                                        WorkBooklet2.SETFILTER("Starting Date", '<>%1', TrenutniDatumZaposlenja);
                                        WorkBooklet2.SETFILTER("Starting Date", '<=%1', TODAY);
                                        WorkBooklet2.SETCURRENTKEY("Starting Date");
                                        WorkBooklet2.ASCENDING(FALSE);
                                        WorkBooklet2.NEXT(1);
                                        IF (WorkBooklet2."Ending Date" <> 0D) AND (WorkBooklet."Contract No." <> WorkBooklet2."Contract No.") THEN BEGIN
                                            IF (CALCDATE('<-' + FORMAT(BrojDana) + 'D>', WorkBooklet."Starting Date") <= WorkBooklet2."Ending Date") THEN BEGIN

                                                StartingDate := WorkBooklet."Starting Date";

                                                Godine := Godine + WorkBooklet2.Years;
                                                Mjeseci := Mjeseci + WorkBooklet2.Months;
                                                Dani := Dani + WorkBooklet2.Days;

                                            END;
                                        END;

                                    UNTIL WorkBooklet.NEXT = 0;

                                StvarniStartDate := CALCDATE('<-' + FORMAT(Godine) + 'Y' + '-' + FORMAT(Mjeseci) + 'M' + '-' + FORMAT(Dani) + 'D>', TODAY);
                                StvarniEndDate := TODAY;

                                CountDays := 0;
                                CountMonths1 := 0;
                                CountYears1 := 0;
                                Found1 := FALSE;
                                UkupniDani := 0;
                                UkupniMjeseci := 0;
                                UkupnoGodine := 0;

                                RecDate1.RESET;
                                RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                RecDate1.SETRANGE("Period Start", StvarniStartDate, CALCDATE('<+1D>', StvarniEndDate));
                                IF RecDate1.FINDSET THEN BEGIN
                                    LastFoundDate1 := StvarniStartDate;
                                    // *** find count of years ***
                                    TempDate1 := CALCDATE('<+1Y>', StvarniStartDate);
                                    //već sam povecala za 1 god
                                    Found1 := TRUE;
                                    REPEAT


                                        IF (TempDate1 <= CALCDATE('<+1D>', StvarniEndDate)) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            //ako zadovolji uslove treba povećati za +1G

                                            AddYear := '';
                                            CountYears1 += 1;

                                            //  LastFoundDate1 := TempDate1;
                                            AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                            TempDate1 := CALCDATE(AddYear, StvarniStartDate);
                                        END
                                        ELSE
                                            Found1 := FALSE;
                                    UNTIL NOT Found1;

                                    //pronašao broj godina i onda temp1 ide dalje
                                    NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                    TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, StvarniStartDate));
                                    Found1 := TRUE;
                                    REPEAT

                                        IF (TempDate1 <= CALCDATE('<+1D>', StvarniEndDate)) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                            AddMonth := '';
                                            CountMonths1 += 1;

                                            // LastFoundDate1 := TempDate1;
                                            AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                            TempDate1 := CALCDATE(AddMonth, StvarniStartDate);
                                        END
                                        ELSE
                                            Found1 := FALSE;
                                    UNTIL NOT Found1;

                                    NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                                    TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, StvarniStartDate));
                                    Found1 := TRUE;
                                    REPEAT
                                        IF (TempDate1 <= CALCDATE('<+1D>', StvarniEndDate)) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountDays += 1;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<+1d>', TempDate1);
                                        END
                                        ELSE
                                            Found1 := FALSE;
                                    UNTIL NOT Found1;
                                END;


                                UkupniDani := CountDays;
                                UkupniMjeseci := CountMonths1;
                                UkupnoGodine := CountYears1;


                                //pronašla sam ukupno mjeseci kao da je bez prekida radnog odnosa
                                //sada gledam da li unutar ovog opsega imam prijelaz ili da li imam preko 6 mjeseci

                                IF (UkupniMjeseci < 6) AND (UkupnoGodine = 0) THEN BEGIN

                                    //spada unutar 6 mjeseci
                                    PlanGO.RESET;
                                    PlanGO.SETFILTER("Employee No.", '%1', "No.");
                                    PlanGO.SETFILTER(Year, '%1', Year);
                                    IF PlanGO.FINDFIRST THEN BEGIN
                                        PlanGO."Days based on Work experience" := 0;
                                        PlanGO."Days based on Disability" := 0;
                                        PlanGO."Based on Disabled Child" := 0;
                                        NeAzuriraj := FALSE;


                                        //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                        //knjižici zaposlenik i treba da ima 4 dana.
                                        PlanGO."Legal Grounds" := UkupniMjeseci;

                                        //PlanGO."Legal Grounds":=WBFirst.Months;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', Year2);
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WBFirst."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;


                                        //PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-UsedDaysThisYear;

                                        //da li trebam obračunati prijelaz godine ako se desio
                                        PlanPrijelaz.RESET;
                                        PlanPrijelaz.SETFILTER("Employee No.", '%1', "No.");
                                        PlanPrijelaz.SETFILTER(Year, '%1', Year - 1);
                                        IF PlanPrijelaz.FINDFIRST THEN BEGIN
                                            IF PlanPrijelaz."Legal Grounds" <= PlanGO."Legal Grounds" THEN
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear - PlanPrijelaz."Legal Grounds"
                                            ELSE
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;

                                        END
                                        ELSE BEGIN
                                            PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        END;


                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days";


                                        PlanGO.MODIFY;
                                        //ako je ista godina samo trebam dodjeliti broj dana

                                    END;









                                END
                                ELSE BEGIN

                                    NeAzuriraj := TRUE;

                                END;





                            END;




                        END
                        ELSE BEGIN
                            NeAzuriraj := TRUE;
                        END;


                    END;

                END;
            end;

            trigger OnPostDataItem()
            begin
                //REPORT.RUNMODAL(50020,FALSE,TRUE);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Returned to Company", '%1', TRUE);
                SETFILTER("External employer Status", '%1', EmployeeRec."External employer Status"::" ");
                SETFILTER(Status, '%1|%2', 0, 1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Year; Year)
                {
                    ApplicationArea = all;
                    Caption = 'Year';
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

    trigger OnPostReport()
    begin

        EmployeeRec.SETFILTER(Status, '%1|%2', 0, 1);
        EmployeeRec.SETFILTER("External employer Status", '%1', EmployeeRec."External employer Status"::" ");

        IF EmployeeRec.FINDSET THEN
            REPEAT
                PlanGO.RESET;
                PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                PlanGO.SETFILTER(Year, '%1', Year);
                IF PlanGO.FINDFIRST THEN BEGIN
                    PlanGO."Last Name" := EmployeeRec."Last Name";
                    PlanGO.MODIFY;
                END;

            UNTIL EmployeeRec.NEXT = 0;

        DataItem1.RESET;
        DataItem1.SETFILTER("External employer Status", '<>%1', DataItem1."External employer Status"::" ");
        IF DataItem1.FINDSET THEN
            REPEAT
                PlanGO.RESET;
                PlanGO.SETFILTER("Employee No.", '%1', DataItem1."No.");
                IF PlanGO.FINDFIRST THEN
                    PlanGO.DELETE;

            UNTIL DataItem1.NEXT = 0;
        IF Year <> CurrYear THEN BEGIN
            R_WorkExperience.SetEndingDate(TODAY);
            R_WorkExperience.RUN;

        END;
        MESSAGE('Uspješno je ažuriran plan korištenja godišnjih odmora.');

    end;

    trigger OnPreReport()
    begin

        CurrYear := DATE2DMY(TODAY, 3);

        IF Year = 0 THEN
            Year := CurrYear;
        IF CurrYear <> Year THEN
            ERROR('Ne mozete raditi kalkulaciju za prethodne godine');
        FirstDateOfMonth := DMY2DATE(1, 12, Year);
        LastDateOfMonth := CALCDATE('-1D', CALCDATE('+1M', FirstDateOfMonth));
        IF Year <> CurrYear THEN BEGIN
            R_WorkExperience.SetEndingDate(DMY2DATE(1, 1, Year));
            R_WorkExperience.RUN;
        END;
        PointsperExperienceYears.RESET;
        PointsperExperienceYears.SETCURRENTKEY(No);
        PointsperExperienceYears.ASCENDING;
        IF PointsperExperienceYears.FINDSET THEN
            REPEAT
                AddDayyy := '<+' + FORMAT(PointsperExperienceYears.LowerLimit2) + '>';
                AddDayyy2 := '<+' + FORMAT(PointsperExperienceYears.UpperLimit2) + '>';
                PointsperExperienceYears."Today Min" := CALCDATE(AddDayyy, TODAY);
                PointsperExperienceYears."Today Max" := CALCDATE(AddDayyy2, TODAY);
                PointsperExperienceYears.MODIFY;
            UNTIL PointsperExperienceYears.NEXT = 0;

    end;

    var
        user: Record "User";
        Year: Integer;
        EmployeeRec: Record "Employee";
        PlanGO: Record "Vacation Grounds";
        PositionRec: Record "Position";
        EmployeeRelative: Record "Employee Relative";
        i: Integer;
        Starost: Integer;
        Mjesec: Integer;
        Godine: Integer;
        BrojR: Integer;
        Mjeseci: Integer;
        Dani: Integer;
        i7: Integer;
        MjesecT: Integer;
        JobType: Record "Vacation Setup";
        StvarniStartDate: Date;
        Prezime: Text;
        UkupniDani: Integer;
        UkupniMjeseci: Integer;
        Experience: Record "Points per Experience Years";
        R_WorkExperience: Report "Work experience in Company";
        WorkBooklet2: Record "Work Booklet";
        StvarniEndDate: Date;
        PlanPrijelaz: Record "Vacation Grounds";
        //   R_BroughtExperience: Report "Education Structure";
        SocialStatus: Record "Points per Disability Status";
        WorkBooklet: Record "Work Booklet";
        UkupnoGodine: Integer;
        SocialStatusEmployee: Record "Candidate Testing";
        StartingDate: Date;
        WBFirst: Record "Work Booklet";
        SocialStatusValue: Integer;
        AddDayyy2: Text;
        WageSetup: Record "Wage Setup";
        AddDayyy: Text;
        VacationSetup: Record "Vacation Setup";
        FirstDateOfMonth: Date;
        TrenutniDatumZaposlenja: Date;
        LastDateOfMonth: Date;
        CurrYear: Integer;
        EmploymentDate: Date;
        WB: Record "Work Booklet";
        ECL: Record "Employee Contract Ledger";
        Absence: Record "Employee Absence";
        UsedDays: Integer; 
        Year2: Integer;
        Datttt: Date;
        UsedDaysThisYear: Integer;
        WB2: Record "Work Booklet";
        WbPrevious: Record "Work Booklet";
        DodajMjesec: Integer;
        NeAzuriraj: Boolean;
        PointsperExperienceYears: Record "Points per Experience Years";
        "oRDER": Integer;
        ELD: Record "Employee Level Of Disability";
        LevelValue: Integer;
        Level: Integer;
        BrojDana: Integer;
        AddYear: Text;
        DateeeDif: Date;
        RecDate1: Record "Date";
        Found1: Boolean;
        CountYears1: Integer;
        CountMonths1: Integer;
        CountDays: Integer;
        LastFoundDate1: Date;
        TempDate1: Date;
        EndDate: Date;
        NumberOfYear: Text;
        Nesto: Date;
        YaerF: Date;
        Novi: Date;
        NumberOfMonth: Text;
        AddMonth: Text;
        NumberOfYear2: Text;
        NumberOfMonth2: Text;
        Prethodni: Integer;
        Trenutni: Integer;
        DateEmployee: Date;
        DateBetween: Date;
        Vacationsetuphistory: Record "Vacation setup history";
        ECLRadni: Record "Employee Contract Ledger";
        ECLPrviPut: Record "Employee Contract Ledger";
}

*/