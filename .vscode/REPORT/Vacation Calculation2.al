report 50010 "Vacation Calculation2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; "Employee")
        {

            trigger OnPostDataItem()
            begin
                //REPORT.RUNMODAL(50020,FALSE,TRUE);
            end;

            trigger OnPreDataItem()
            begin
                //HR01 start


                //EmployeeRec.SETFILTER(Status,'%1|%2',0,1);

                EmployeeRec.Reset();
                EmployeeRec.SETFILTER("External employer Status", '%1', EmployeeRec."External employer Status"::" ");
                EmployeeRec.SETFILTER("Termination Date", '%1|>=%2', 0D, Datee);
                IF EmployeeRec.FINDFIRST THEN BEGIN
                    REPEAT
                        //  PlanGO.VALIDATE("Employee No.",EmployeeRec."No.");

                        PlanGO."First Name" := EmployeeRec."First Name";
                        PlanGO."Last Name" := EmployeeRec."Last Name";

                        //PlanGO."Work experience" := EmployeeRec."Years with military"; //ED
                        PlanGO.Year := DATE2DMY(Datee, 3);
                        PlanGO."Date of report" := Datee; //ED
                        PlanGO."Employee No." := EmployeeRec."No.";
                        EVALUATE(Order, EmployeeRec."No.");
                        PlanGO.Order := Order;
                        EmployeeC.RESET;
                        EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                        EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                        EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                        EmployeeC.SETCURRENTKEY("Starting Date");
                        EmployeeC.ASCENDING;
                        IF EmployeeC.FINDLAST THEN BEGIN
                            PlanGO."Position Name" := EmployeeC."Position Description";
                            PlanGO.Sector := EmployeeC."Sector Description"; //ED
                            PlanGO."Insert Date" := Datee;
                            /* R_WorkExperience.SetEmp(EmployeeC."Employee No.",Datee);
                         R_WorkExperience.RUN; */

                            EmployeeC.CALCFIELDS("Org Entity Code");

                            VacationSetup.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                            IF VacationSetup.FINDFIRST THEN BEGIN
                                IF EmployeeC."Org Entity Code" = 'BD' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days BD";
                                IF EmployeeC."Org Entity Code" = 'RS' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days RS";
                                IF EmployeeC."Org Entity Code" = 'FBIH' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days";
                            END;
                        END;

                        // PlanGO.MODIFY;
                        PlanGO.RESET;
                        PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                        PlanGO.SETFILTER("Insert Date", '%1', Datee);
                        IF NOT PlanGO.FINDFIRST THEN BEGIN
                            PlanGO."Starting Date of I part" := 0D;
                            PlanGO."Ending Date of I part" := 0D;


                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN


                                PlanGO.INSERT(true);
                            END;
                            //PlanGO.MODIFY;
                        END;
                        PlanGO.RESET;
                        PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                        PlanGO.SETFILTER("Insert Date", '%1', Datee);

                        IF PlanGO.FINDFIRST THEN BEGIN
                            // po stepenu invalidnosti

                            /*ELD.RESET;
                            ELD.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            ELD.SETFILTER(Active, '%1', TRUE);*/
                            IF (EmployeeRec."Disabled Person" = TRUE) THEN BEGIN
                                /*IF EVALUATE(LevelValue, ELD."Level of Disability") THEN
                                    Level := LevelValue
                                ELSE
                                    Level := 0;
                                IF Level > 50 THEN BEGIN*/
                                SocialStatus.Reset();
                                SocialStatus.SetFilter(Category, '%1', 0);
                                SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                SocialStatus.SetFilter(Category, '%1', SocialStatus.Category::Disability);
                                SocialStatus.SETFILTER("No", '%1', 1);
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    PlanGO."Days based on Disability" := SocialStatus.Points;
                                    EmployeeC.RESET;
                                    EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                    EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                                    EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                                    EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                                    EmployeeC.SETCURRENTKEY("Starting Date");
                                    EmployeeC.ASCENDING;
                                    IF EmployeeC.FINDLAST THEN BEGIN

                                        PlanGO.MODIFY;
                                    END;
                                END //;
                                    //END
                                ELSE BEGIN
                                    PlanGO."Days based on Disability" := 0;
                                    EmployeeC.RESET;
                                    EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                    EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                                    EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                                    EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                                    EmployeeC.SETCURRENTKEY("Starting Date");
                                    EmployeeC.ASCENDING;
                                    IF EmployeeC.FINDLAST THEN BEGIN

                                        PlanGO.MODIFY;
                                    END;
                                END;
                            END
                            ELSE BEGIN
                                PlanGO."Days based on Disability" := 0;
                                EmployeeC.RESET;
                                EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                                EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                                EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                                EmployeeC.SETCURRENTKEY("Starting Date");
                                EmployeeC.ASCENDING;
                                IF EmployeeC.FINDLAST THEN BEGIN

                                    PlanGO.MODIFY;
                                END;
                                //END;
                            END;




                            WBTemp.RESET;
                            WBTemp.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            IF WBTemp.FINDFIRST THEN BEGIN
                                /* Experience.SETFILTER(LowerLimit,'<=%1',WBTemp.Years);
                                        Experience.SETFILTER(UpperLimit,'>=%1',WBTemp.Years);
                                        IF Experience.FINDFIRST THEN BEGIN*/
                                // PlanGO."Days based on Work experience":=Experience.Vacation;

                                AddDayyy := '<+' + FORMAT(WBTemp.Years) + 'Y+' + FORMAT(WBTemp.Months) + 'M+' + FORMAT(WBTemp.Days) + 'D>';
                                Datttt := CALCDATE(AddDayyy, Datee);

                                PlanGO."Work experience" := WBTemp.Years; //ED GODINE

                                PointsperExperienceYears.RESET;

                                PointsperExperienceYears.SETFILTER("Today Min", '<=%1', Datttt);
                                PointsperExperienceYears.SETCURRENTKEY(No);
                                PointsperExperienceYears.SetFilter("Points Category", '%1', PointsperExperienceYears."Points Category"::"Points per Experience Years");
                                PointsperExperienceYears.ASCENDING;
                                IF PointsperExperienceYears.FINDLAST THEN BEGIN
                                    PlanGO."Days based on Work experience" := PointsperExperienceYears.Vacation;
                                END
                                ELSE BEGIN
                                    PlanGO."Days based on Work experience" := 0;

                                END;

                                EmployeeC.RESET;
                                EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                                EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                                EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                                EmployeeC.SETCURRENTKEY("Starting Date");
                                EmployeeC.ASCENDING;
                                IF EmployeeC.FINDLAST THEN BEGIN
                                    PlanGO.MODIFY;
                                END;
                            END
                            ELSE BEGIN
                                PlanGO."Days based on Work experience" := 0;
                            END;

                        END;

                        //Za samohrane roditelje/usvojitelje
                        IF ((EmployeeRec."Single parent/adopter" = TRUE)) THEN BEGIN
                            SocialStatus.Reset();
                            //SocialStatus.SetFilter(Category, '%1', 0);
                            //SocialStatus.SETFILTER("No.", '%1', '2');
                            SocialStatus.Get(2, 1, 0);
                            IF SocialStatus.FindFirst() THEN BEGIN
                                PlanGO."Days based on Disability" := PlanGO."Days based on Disability" + SocialStatus.Points;
                            END;
                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN
                                PlanGO.MODIFY;
                            END;
                        END
                        ELSE
                            PlanGO."Days based on Disability" := PlanGO."Days based on Disability";

                        //Radnici koji rade u smjenama 
                        EmployeeC.RESET;
                        EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                        EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                        EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                        EmployeeC.SETCURRENTKEY("Starting Date");
                        EmployeeC.ASCENDING;
                        If EmployeeC.FINDLAST THEN begin
                            IF ((EmployeeC."Rad u smjenama" = EmployeeC."Rad u smjenama"::"Work in shifts")) THEN BEGIN
                                SocialStatus.Reset();
                                SocialStatus.Get(1, 1, 2);
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    PlanGO."Days based on Working conditi" := SocialStatus.Points;
                                END;

                                EmployeeC.RESET;
                                EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                                EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                                EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                                EmployeeC.SETCURRENTKEY("Starting Date");
                                EmployeeC.ASCENDING;
                                IF EmployeeC.FINDLAST THEN
                                    PlanGO.MODIFY;

                            END
                            ELSE
                                PlanGO."Days based on Working conditi" := 0;
                        end;

                        //Radnici na poslovima sa skraćenim radnim vremenom
                        IF ((EmployeeRec."Hours In Day" < 8)) THEN BEGIN
                            SocialStatus.Reset();
                            SocialStatus.Get(2, 1, 2);
                            IF SocialStatus.FINDFIRST THEN BEGIN
                                PlanGO."Days based on Working conditi" := SocialStatus.Points;
                            END;

                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN
                                PlanGO.MODIFY;

                        END
                        ELSE
                            PlanGO."Days based on Working conditi" := PlanGO."Days based on Working conditi";

                        //Majka djeteta mlađeg od 7 godina
                        IF EmployeeRec.Gender.AsInteger() = 1 then begin //Zena
                            SocialStatus.SetFilter(Category, '%1', 0); //Socijalno-zdravstveni status u sifarniku
                            SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                            SocialStatus.SETFILTER("No", '%1', 2); //No 3 u sifarniku 

                            IF SocialStatus.FINDFIRST THEN BEGIN
                                EmployeeRelative.Reset();
                                EmployeeRelative.SetFilter("Employee No.", '%1', EmployeeRec."No.");
                                EmployeeRelative.SetFilter(Relation, '%1', 3); //Child
                                EmployeeRelative.SetFilter(Age, '%1..%2', 0, SocialStatus.Years - 1); //Da su unesene godine i da su te godine manje od granice u šifarniku
                                IF EmployeeRelative.FindFirst() then begin
                                    PlanGO."Days based on Disability" := PlanGO."Days based on Disability" + SocialStatus.Points;

                                    EmployeeC.RESET;
                                    EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                    EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                                    EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                                    EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                                    EmployeeC.SETCURRENTKEY("Starting Date");
                                    EmployeeC.ASCENDING;
                                    IF EmployeeC.FINDLAST THEN BEGIN
                                        PlanGO.MODIFY;
                                    END;

                                end
                                ELSE
                                    PlanGO."Days based on Disability" := PlanGO."Days based on Disability";
                            END;
                        end;


                        //Radnik mlađi od 18 godina
                        SocialStatus.SetFilter(Category, '%1', 0);
                        SocialStatus.SETFILTER("No", '%1', 3);
                        SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                        IF ((EmployeeRec.Age < SocialStatus.Years)) THEN BEGIN
                            IF SocialStatus.FINDFIRST THEN BEGIN
                                PlanGO."Days based on Disability" := PlanGO."Days based on Disability" + SocialStatus.Points;
                            END;
                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN
                                PlanGO.MODIFY;
                            END;
                        END
                        ELSE
                            PlanGO."Days based on Disability" := PlanGO."Days based on Disability";


                        //Po osnovu učešća u oružanim snagama
                        MilitaryMonths := EmployeeRec."Military Years of Service" * 12 + EmployeeRec."Military Months of Service";

                        IF (MilitaryMonths <> 0) THEN BEGIN

                            /*AddDayyy := '<+' + FORMAT(WBTemp.Years) + 'Y+' + FORMAT(WBTemp.Months) + 'M+' + FORMAT(WBTemp.Days) + 'D>';
                            Datttt := CALCDATE(AddDayyy, Datee);

                            PointsperExperienceYears.RESET;*/

                            SocialStatus.Reset();
                            SocialStatus.SetFilter(Category, '%1', 1);
                            SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                            SocialStatus.SetFilter(SocialStatus."Lower Limit Months", '<=%1', MilitaryMonths);
                            SocialStatus.SetFilter(SocialStatus."Upper Limit Months", '>=%1', MilitaryMonths);
                            SocialStatus.SetCurrentKey("Upper Limit Months");
                            SocialStatus.ASCENDING;
                            IF SocialStatus.FindLast() THEN BEGIN
                                PlanGO."Days based on Military service" := SocialStatus.Points;
                            END
                            ELSE
                                PlanGO."Days based on Military service" := 0;

                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN
                                PlanGO.MODIFY;
                            END;

                        END
                        ELSE
                            PlanGO."Days based on Military service" := 0;


                        /*MilitaryMonths := EmployeeRec."Military Years of Service" * 12 + "Military Months of Service";
                        IF ((MilitaryMonths <> 0)) THEN BEGIN
                            IF ((MilitaryMonths > 12) AND (MilitaryMonths < 18)) then begin
                                SocialStatus.SetFilter(Category, '%1', 1);
                                SocialStatus.SETFILTER("No.", '%1', '1');
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    PlanGO."Days based on Military service" := SocialStatus.Points;
                                END;
                            end
                            ELSE
                                IF ((MilitaryMonths > 18) AND (MilitaryMonths < 30)) then begin
                                    SocialStatus.SetFilter(Category, '%1', 1);
                                    SocialStatus.SETFILTER("No.", '%1', '2');
                                    IF SocialStatus.FINDFIRST THEN BEGIN
                                        PlanGO."Days based on Military service" := SocialStatus.Points;
                                    END;
                                end
                                ELSE begin
                                    SocialStatus.SetFilter(Category, '%1', 1);
                                    SocialStatus.SETFILTER("No.", '%1', '3');
                                    IF SocialStatus.FINDFIRST THEN BEGIN
                                        PlanGO."Days based on Military service" := SocialStatus.Points;
                                    END;
                                end;

                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN

                                PlanGO.MODIFY;
                            END;
                        END
                        ELSE
                            PlanGO."Days based on Military service" := 0;*/


                        //roditelj djece sa posebnim potrebama
                        /*IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                            SocialStatus.SETFILTER("No.", '%1', '2');
                            IF SocialStatus.FINDFIRST THEN BEGIN
                                PlanGO."Based on Disabled Child" := SocialStatus.Points;
                            END;
                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN

                                PlanGO.MODIFY;
                            END;
                        END
                        ELSE
                            PlanGO."Based on Disabled Child" := 0;*/


                        /*VacationSetup.SETFILTER(Year,'%1',Year);
                             IF VacationSetup.FINDFIRST THEN
                              PlanGO."Legal Grounds":=VacationSetup."Base Days";*/

                        VacationSetup.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                        IF VacationSetup.FINDFIRST THEN BEGIN

                            EmployeeC.RESET;
                            EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                            EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                            EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                            EmployeeC.SETCURRENTKEY("Starting Date");
                            EmployeeC.ASCENDING;
                            IF EmployeeC.FINDLAST THEN BEGIN
                                EmployeeC.CALCFIELDS("Org Entity Code");

                                IF EmployeeC."Org Entity Code" = 'BD' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days BD";
                                IF EmployeeC."Org Entity Code" = 'RS' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days RS";
                                IF EmployeeC."Org Entity Code" = 'FBIH' THEN
                                    PlanGO."Legal Grounds" := VacationSetup."Base Days";

                            END;
                        END;
                        UsedDaysThisYear := 0;
                        Absence.RESET;
                        Absence.SETFILTER("Employee No.", '%1', "No.");
                        Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                        Absence.SETFILTER("From Date", '%1..%2', DMY2DATE(1, 1, DATE2DMY(Datee, 3)), Datee);

                        IF Absence.FINDSET THEN
                            UsedDaysThisYear := Absence.COUNT;




                        PlanGO."Total days" := PlanGO."Legal Grounds" - UsedDaysThisYear + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                        IF PlanGO."Total days" > 35
                        then
                            PlanGO."Total days" := 35;

                        EmployeeC.RESET;
                        EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                        EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                        EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                        EmployeeC.SETCURRENTKEY("Starting Date");
                        EmployeeC.ASCENDING;
                        IF EmployeeC.FINDLAST THEN BEGIN
                            PlanGO.MODIFY;
                        END;

                        EmployeeC.RESET;
                        EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                        EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                        EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                        EmployeeC.SETCURRENTKEY("Starting Date");
                        EmployeeC.ASCENDING;
                        IF EmployeeC.FINDLAST THEN BEGIN
                            EmployeeC.CALCFIELDS("Org Entity Code");
                            IF (EmployeeC."Org Entity Code" = 'FBIH') AND (PlanGO."Manager contract" = FALSE) THEN BEGIN
                                // IF PlanGO."Total days">30 THEN PlanGO."Total days":=30;

                            END;


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

                NeAzuriraj := FALSE;
            end;

            trigger OnPostDataItem()
            begin
                //REPORT.RUNMODAL(50020,FALSE,TRUE);
            end;

            trigger OnPreDataItem()
            begin


                EmployeeRec.SETFILTER("Termination Date", '%1|>=%2', 0D, Datee);

                IF EmployeeRec.FINDSET THEN
                    REPEAT
                        IF EmployeeRec."No." = '14803' THEN
                            MESSAGE('');


                        EmployeeC.RESET;
                        EmployeeC.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                        EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                        EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                        EmployeeC.SETCURRENTKEY("Starting Date");
                        EmployeeC.ASCENDING;
                        IF EmployeeC.FINDLAST THEN BEGIN
                            EmployeeC.CALCFIELDS("Org Entity Code");


                            /*
                              IF EmployeeC."Org Entity Code"='FBIH' THEN
                              BrojDana:=15;
                            IF EmployeeC."Org Entity Code"='RS' THEN
                              BrojDana:=30;
                            IF EmployeeC."Org Entity Code"='BD' THEN
                              BrojDana:=8;
                            END;
                            */
                            //ĐK
                            Vacationsetuphistory.RESET;
                            Vacationsetuphistory.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                            IF Vacationsetuphistory.FINDFIRST THEN BEGIN

                                IF EmployeeC."Org Entity Code" = 'FBIH' THEN
                                    BrojDana := Vacationsetuphistory."Days FBIH";
                                IF EmployeeC."Org Entity Code" = 'RS' THEN
                                    BrojDana := Vacationsetuphistory."Days RS";
                                IF EmployeeC."Org Entity Code" = 'BD' THEN
                                    BrojDana := Vacationsetuphistory."Days BD";
                            END
                            ELSE BEGIN
                                ERROR('Ne postoje adekvatni podaci u postavi');
                            END;



                            AddYear := '<+' + FORMAT(BrojDana) + 'D>';


                            NeAzuriraj := FALSE;
                            UsedDaysThisYear := 0;
                            WB.RESET;
                            PlanGO.RESET;
                            DodajMjesec := 0;

                            ECLPrviPut.RESET;
                            ECLPrviPut.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                            ECLPrviPut.SETFILTER("Reason for Change", '%1', 2);
                            ECLPrviPut.SETFILTER("First Time Employed", '%1', TRUE);
                            ECLPrviPut.SETFILTER("Way of Employment", '<>%1', ECLPrviPut."Way of Employment"::"From Employment");
                            ECLPrviPut.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', Datee), Datee);
                            ECLPrviPut.SETFILTER("Show Record", '%1', TRUE);
                            IF ECLPrviPut.FINDFIRST THEN BEGIN

                                //prvo zaposlenje gleda samo trenutnu radnu knjižicu

                                WB.RESET;
                                WB.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                WB.SETFILTER("Starting Date", '<=%1', Datee);
                                WB.SETFILTER("Current Company", '%1', TRUE);
                                WB.SETCURRENTKEY("Starting Date");
                                WB.ASCENDING;
                                IF WB.FINDLAST THEN BEGIN
                                    IF WB.Months >= 6 THEN BEGIN
                                        NeAzuriraj := TRUE;
                                    END
                                    ELSE BEGIN
                                        PlanGO.RESET;
                                        PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                        PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                                        PlanGO.SETFILTER("Insert Date", '%1', Datee);
                                        IF PlanGO.FINDFIRST THEN BEGIN
                                            PlanGO."Days based on Work experience" := 0;
                                            PlanGO."Days based on Disability" := 0;
                                            PlanGO."Based on Disabled Child" := 0;
                                            NeAzuriraj := FALSE;

                                            //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                            //knjižici zaposlenik i treba da ima 4 dana.
                                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(Datee, 3) THEN BEGIN

                                                //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019)

                                                Found1 := FALSE;
                                                CountYears1 := 0;
                                                CountMonths1 := 0;
                                                Prethodni := 0;
                                                Trenutni := 0;

                                                RecDate1.RESET;
                                                RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                                RecDate1.SETRANGE("Period Start", WB."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3))));
                                                IF RecDate1.FINDSET THEN BEGIN
                                                    LastFoundDate1 := WB."Starting Date";
                                                    // *** find count of years ***
                                                    TempDate1 := CALCDATE('<+1Y>', WB."Starting Date");
                                                    //već sam povecala za 1 god
                                                    Found1 := TRUE;
                                                    REPEAT

                                                        IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            //ako zadovolji uslove treba povećati za +1G

                                                            AddYear := '';
                                                            CountYears1 += 1;

                                                            //  LastFoundDate1 := TempDate1;
                                                            AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                            TempDate1 := CALCDATE(AddYear, WB."Starting Date");
                                                        END
                                                        ELSE
                                                            Found1 := FALSE;
                                                    UNTIL NOT Found1;

                                                    //pronašao broj godina i onda temp1 ide dalje
                                                    NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                                    TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WB."Starting Date"));
                                                    Found1 := TRUE;
                                                    REPEAT

                                                        IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                            AddMonth := '';
                                                            CountMonths1 += 1;

                                                            // LastFoundDate1 := TempDate1;
                                                            AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                            TempDate1 := CALCDATE(AddMonth, WB."Starting Date");
                                                        END
                                                        ELSE
                                                            Found1 := FALSE;
                                                    UNTIL NOT Found1;

                                                    NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                                    Prethodni := CountMonths1;
                                                END;

                                                PlanGO."Legal Grounds" := WB.Months - Prethodni;
                                                UsedDaysThisYear := 0;
                                                Absence.RESET;
                                                Absence.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                                Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                                Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                                IF Absence.FINDSET THEN
                                                    UsedDaysThisYear := Absence.COUNT;
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                                PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                                IF PlanGO."Total days" > 35
                            then
                                                    PlanGO."Total days" := 35;
                                                PlanGO.MODIFY;


                                                //kraj



                                            END
                                            ELSE BEGIN


                                                PlanGO."Legal Grounds" := WB.Months;
                                                UsedDaysThisYear := 0;
                                                Absence.RESET;
                                                Absence.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                                Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                                Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                                IF Absence.FINDSET THEN
                                                    UsedDaysThisYear := Absence.COUNT;
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                                PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Days based on Disability" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                                IF PlanGO."Total days" > 35
                                                                            then
                                                    PlanGO."Total days" := 35;

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
                                ECL.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                ECL.SETFILTER("Reason for Change", '%1', 2);
                                ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                                ECL.SETFILTER("Show Record", '%1', TRUE);
                                ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', Datee), Datee);
                                IF ECL.FINDFIRST THEN BEGIN
                                    //gledam ugovore koji su biro i duzi prekid radnog odnosa, oni također gledaju samo radnu knjižicu


                                    //dodala

                                    WB.RESET;
                                    WB.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                    WB.SETFILTER("Starting Date", '<=%1', Datee);
                                    WB.SETFILTER("Current Company", '%1', TRUE);
                                    WB.SETCURRENTKEY("Starting Date");
                                    WB.ASCENDING;
                                    IF WB.FINDLAST THEN BEGIN

                                        IF WB.Months >= 6 THEN BEGIN
                                            NeAzuriraj := TRUE;
                                        END
                                        ELSE BEGIN
                                            PlanGO.RESET;
                                            PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                            PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                                            PlanGO.SETFILTER("Insert Date", '%1', Datee);

                                            IF PlanGO.FINDFIRST THEN BEGIN
                                                PlanGO."Days based on Work experience" := 0;
                                                PlanGO."Days based on Disability" := 0;
                                                PlanGO."Based on Disabled Child" := 0;
                                                NeAzuriraj := FALSE;

                                                //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                                //knjižici zaposlenik i treba da ima 4 dana.
                                                IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(Datee, 3) THEN BEGIN

                                                    //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                                    Found1 := FALSE;
                                                    CountYears1 := 0;
                                                    CountMonths1 := 0;
                                                    Prethodni := 0;
                                                    Trenutni := 0;

                                                    RecDate1.RESET;
                                                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                                    RecDate1.SETRANGE("Period Start", WB."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3))));
                                                    IF RecDate1.FINDSET THEN BEGIN
                                                        LastFoundDate1 := WB."Starting Date";
                                                        // *** find count of years ***
                                                        TempDate1 := CALCDATE('<+1Y>', WB."Starting Date");
                                                        //već sam povecala za 1 god
                                                        Found1 := TRUE;
                                                        REPEAT


                                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                //ako zadovolji uslove treba povećati za +1G

                                                                AddYear := '';
                                                                CountYears1 += 1;

                                                                //  LastFoundDate1 := TempDate1;
                                                                AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                                TempDate1 := CALCDATE(AddYear, WB."Starting Date");
                                                            END
                                                            ELSE
                                                                Found1 := FALSE;
                                                        UNTIL NOT Found1;

                                                        //pronašao broj godina i onda temp1 ide dalje
                                                        NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                                        TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WB."Starting Date"));
                                                        Found1 := TRUE;
                                                        REPEAT

                                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                                AddMonth := '';
                                                                CountMonths1 += 1;

                                                                // LastFoundDate1 := TempDate1;
                                                                AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                                TempDate1 := CALCDATE(AddMonth, WB."Starting Date");
                                                            END
                                                            ELSE
                                                                Found1 := FALSE;
                                                        UNTIL NOT Found1;

                                                        NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                                        Prethodni := CountMonths1;
                                                    END;

                                                    PlanGO."Legal Grounds" := WB.Months - Prethodni;
                                                    UsedDaysThisYear := 0;
                                                    Absence.RESET;
                                                    Absence.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                    Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                                    Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                                    IF Absence.FINDSET THEN
                                                        UsedDaysThisYear := Absence.COUNT;
                                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                                    IF PlanGO."Total days" > 35
                                                                                then
                                                        PlanGO."Total days" := 35;

                                                    PlanGO.MODIFY;


                                                    //kraj



                                                END
                                                ELSE BEGIN


                                                    PlanGO."Legal Grounds" := WB.Months;
                                                    UsedDaysThisYear := 0;
                                                    Absence.RESET;
                                                    Absence.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                    Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                                    Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                                    IF Absence.FINDSET THEN
                                                        UsedDaysThisYear := Absence.COUNT;
                                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                                    IF PlanGO."Total days" > 35
                                                                                then
                                                        PlanGO."Total days" := 35;

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
                                    ECLRadni.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                    ECLRadni.SETFILTER("Reason for Change", '%1', 2);
                                    ECLRadni.SETFILTER("Way of Employment", '%1', ECLRadni."Way of Employment"::"From Employment");
                                    ECLRadni.SETFILTER("Show Record", '%1', TRUE);
                                    ECLRadni.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', Datee), Datee);
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

                                        WB.RESET;
                                        WB.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                        WB.SETFILTER("Current Company", '%1', TRUE);
                                        WB.SETFILTER("Starting Date", '<=%1', Datee);
                                        //WB.SETFILTER("Hours change",'%1',FALSE);
                                        WB.SETCURRENTKEY("Starting Date");
                                        WB.ASCENDING;
                                        IF WB.FINDLAST THEN BEGIN
                                            TrenutniDatumZaposlenja := WB."Starting Date";
                                            Godine := Godine + WB.Years;
                                            Mjeseci := Mjeseci + WB.Months;
                                            Dani := Dani + WB.Days;
                                        END
                                        ELSE BEGIN
                                            TrenutniDatumZaposlenja := 0D;
                                            Godine := Godine + 0;
                                            Mjeseci := Mjeseci + 0;
                                            Dani := Dani + 0;
                                        END;


                                        //Da zaposlenik pripada opsegu od 6M kako bi se provjerilo da li treba imati zakonsku osnovu ili ne

                                        IF (TrenutniDatumZaposlenja <> 0D) AND ((TrenutniDatumZaposlenja <= Datee) AND (TrenutniDatumZaposlenja >= CALCDATE('<-6M>', Datee))) THEN BEGIN

                                            WB.RESET;
                                            WB.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                            //WB.SETFILTER("Current Company",'%1',FALSE);
                                            //korigovala
                                            WB.SETFILTER("Starting Date", '<>%1 & <=%2', TrenutniDatumZaposlenja, Datee);
                                            WB.SETCURRENTKEY("Starting Date");
                                            WB.ASCENDING(FALSE);
                                            IF WB.FINDFIRST THEN BEGIN
                                                //đemka
                                                IF ((CALCDATE('<-' + FORMAT(BrojDana) + 'D>', TrenutniDatumZaposlenja)) <= WB."Ending Date") THEN BEGIN
                                                    //korigovala
                                                    IF WB."Current Company" = TRUE THEN
                                                        WB.VALIDATE(Coefficient, 1);
                                                    Godine := Godine + WB.Years;
                                                    Mjeseci := Mjeseci + WB.Months;
                                                    Dani := Dani + WB.Days;

                                                END;
                                            END;

                                            //prethodni radni staž
                                            WB.RESET;
                                            WB.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                            WB.SETFILTER("Current Company", '%1', FALSE);
                                            WB.SETFILTER("Starting Date", '<=%1', Datee);
                                            WB.SETCURRENTKEY("Starting Date");
                                            WB.ASCENDING(FALSE);
                                            IF WB.FINDSET THEN
                                                REPEAT


                                                    WorkBooklet2 := WorkBooklet;
                                                    WorkBooklet2.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                    WorkBooklet2.SETFILTER("Current Company", '%1', FALSE);
                                                    WorkBooklet2.SETFILTER("Starting Date", '<=%1', Datee);
                                                    WorkBooklet2.SETCURRENTKEY("Starting Date");
                                                    WorkBooklet2.ASCENDING(FALSE);
                                                    WorkBooklet2.NEXT(1);
                                                    IF (WorkBooklet2."Ending Date" <> 0D) AND (WB."Contract No." <> WorkBooklet2."Contract No.") THEN BEGIN
                                                        IF (CALCDATE('<-' + FORMAT(BrojDana) + 'D>', WB."Starting Date") <= WorkBooklet2."Ending Date") THEN BEGIN

                                                            StartingDate := WB."Starting Date";
                                                            //korigovala
                                                            IF WorkBooklet2."Current Company" = TRUE THEN
                                                                WorkBooklet2.VALIDATE(Coefficient, 1);
                                                            Godine := Godine + WorkBooklet2.Years;
                                                            Mjeseci := Mjeseci + WorkBooklet2.Months;
                                                            Dani := Dani + WorkBooklet2.Days;

                                                        END;
                                                    END;

                                                UNTIL WB.NEXT = 0;

                                            StvarniStartDate := CALCDATE('<-' + FORMAT(Godine) + 'Y' + '-' + FORMAT(Mjeseci) + 'M' + '-' + FORMAT(Dani) + 'D>', Datee);
                                            StvarniEndDate := Datee;

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
                                                PlanGO.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                                                PlanGO.SETFILTER("Insert Date", '%1', Datee);
                                                IF PlanGO.FINDFIRST THEN BEGIN
                                                    PlanGO."Days based on Work experience" := 0;
                                                    PlanGO."Days based on Disability" := 0;
                                                    PlanGO."Based on Disabled Child" := 0;
                                                    NeAzuriraj := FALSE;


                                                    //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                                    //knjižici zaposlenik i treba da ima 4 dana.
                                                    PlanGO."Legal Grounds" := UkupniMjeseci;

                                                    //PlanGO."Legal Grounds":=WB.Months;
                                                    UsedDaysThisYear := 0;
                                                    Absence.RESET;
                                                    Absence.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                    Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                                    Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                                    IF Absence.FINDSET THEN
                                                        UsedDaysThisYear := Absence.COUNT;


                                                    //PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-UsedDaysThisYear;

                                                    //da li trebam obračunati prijelaz godine ako se desio
                                                    PlanPrijelaz.RESET;
                                                    PlanPrijelaz.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                                                    PlanPrijelaz.SETFILTER(Year, '%1', DATE2DMY(Datee, 3) - 1);
                                                    IF PlanPrijelaz.FINDFIRST THEN BEGIN
                                                        IF PlanPrijelaz."Legal Grounds" <= PlanGO."Legal Grounds" THEN
                                                            PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear - PlanPrijelaz."Legal Grounds"
                                                        ELSE
                                                            PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;

                                                    END
                                                    ELSE BEGIN
                                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                                    END;


                                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                                    IF PlanGO."Total days" > 35
                                                                                then
                                                        PlanGO."Total days" := 35;

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


                        END;

                    UNTIL EmployeeRec.NEXT = 0;

            end;
        }
        dataitem("<Employee3>"; "Employee")
        {

            trigger OnAfterGetRecord()
            begin
                NeAzuriraj := FALSE;
                IF "No." = '14803' THEN
                    MESSAGE('');
                WB.RESET;
                PlanGO.RESET;
                ECL.RESET;
                Absence.RESET;
                UsedDays := 0;


                EmployeeC.RESET;
                EmployeeC.SETFILTER("Employee No.", '%1', "No.");
                EmployeeC.SETFILTER("Show Record", '%1', TRUE);
                EmployeeC.SETFILTER("Starting Date", '<=%1', Datee);
                EmployeeC.SETFILTER("Ending Date", '%1|>=%2', 0D, Datee);
                EmployeeC.SETCURRENTKEY("Starting Date");
                EmployeeC.ASCENDING;
                IF EmployeeC.FINDLAST THEN BEGIN

                    EmployeeC.CALCFIELDS("Org Entity Code");

                    Vacationsetuphistory.RESET;
                    Vacationsetuphistory.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                    IF Vacationsetuphistory.FINDFIRST THEN BEGIN

                        IF EmployeeC."Org Entity Code" = 'FBIH' THEN
                            BrojDana := Vacationsetuphistory."Days FBIH";
                        IF EmployeeC."Org Entity Code" = 'RS' THEN
                            BrojDana := Vacationsetuphistory."Days RS";
                        IF EmployeeC."Org Entity Code" = 'BD' THEN
                            BrojDana := Vacationsetuphistory."Days BD";
                    END
                    ELSE BEGIN
                        ERROR('Ne postoje adekvatni podaci u postavi');
                    END;

                    AddYear := '<+' + FORMAT(BrojDana) + 'D>';

                END;



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
                ECLPrviPut.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', Datee), Datee);
                ECLPrviPut.SETFILTER("Show Record", '%1', TRUE);
                IF ECLPrviPut.FINDFIRST THEN BEGIN

                    //prvo zaposlenje gleda samo trenutnu radnu knjižicu
                    WB.RESET;
                    WB.SETFILTER("Employee No.", '%1', "No.");
                    WB.SETFILTER("Starting Date", '<=%1', Datee);
                    WB.SETFILTER("Current Company", '%1', TRUE);
                    WB.SETCURRENTKEY("Starting Date");
                    WB.ASCENDING;
                    IF WB.FINDLAST THEN BEGIN
                        IF WB.Months >= 6 THEN BEGIN
                            NeAzuriraj := TRUE;
                        END
                        ELSE BEGIN
                            PlanGO.RESET;
                            PlanGO.SETFILTER("Employee No.", '%1', "No.");
                            PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                            PlanGO.SETFILTER("Insert Date", '%1', Datee);
                            IF PlanGO.FINDFIRST THEN BEGIN
                                PlanGO."Days based on Work experience" := 0;
                                PlanGO."Days based on Disability" := 0;
                                PlanGO."Based on Disabled Child" := 0;
                                NeAzuriraj := FALSE;

                                //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                //knjižici zaposlenik i treba da ima 4 dana.
                                IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(Datee, 3) THEN BEGIN

                                    //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                    Found1 := FALSE;
                                    CountYears1 := 0;
                                    CountMonths1 := 0;
                                    Prethodni := 0;
                                    Trenutni := 0;

                                    RecDate1.RESET;
                                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                    RecDate1.SETRANGE("Period Start", WB."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3))));
                                    IF RecDate1.FINDSET THEN BEGIN
                                        LastFoundDate1 := WB."Starting Date";
                                        // *** find count of years ***
                                        TempDate1 := CALCDATE('<+1Y>', WB."Starting Date");
                                        //već sam povecala za 1 god
                                        Found1 := TRUE;
                                        REPEAT


                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                //ako zadovolji uslove treba povećati za +1G

                                                AddYear := '';
                                                CountYears1 += 1;

                                                //  LastFoundDate1 := TempDate1;
                                                AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                TempDate1 := CALCDATE(AddYear, WB."Starting Date");
                                            END
                                            ELSE
                                                Found1 := FALSE;
                                        UNTIL NOT Found1;

                                        //pronašao broj godina i onda temp1 ide dalje
                                        NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                        TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WB."Starting Date"));
                                        Found1 := TRUE;
                                        REPEAT

                                            IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                AddMonth := '';
                                                CountMonths1 += 1;

                                                // LastFoundDate1 := TempDate1;
                                                AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                TempDate1 := CALCDATE(AddMonth, WB."Starting Date");
                                            END
                                            ELSE
                                                Found1 := FALSE;
                                        UNTIL NOT Found1;

                                        NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                        Prethodni := CountMonths1;
                                    END;

                                    PlanGO."Legal Grounds" := WB.Months - Prethodni;
                                    UsedDaysThisYear := 0;
                                    Absence.RESET;
                                    Absence.SETFILTER("Employee No.", '%1', "No.");
                                    Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                    Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                    IF Absence.FINDSET THEN
                                        UsedDaysThisYear := Absence.COUNT;
                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                    IF PlanGO."Total days" > 35
                                                                then
                                        PlanGO."Total days" := 35;
                                    PlanGO.MODIFY;


                                    //kraj



                                END
                                ELSE BEGIN


                                    PlanGO."Legal Grounds" := WB.Months;
                                    UsedDaysThisYear := 0;
                                    Absence.RESET;
                                    Absence.SETFILTER("Employee No.", '%1', "No.");
                                    Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                    Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                    Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                    IF Absence.FINDSET THEN
                                        UsedDaysThisYear := Absence.COUNT;
                                    PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                    PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                    IF PlanGO."Total days" > 35
                                                                then
                                        PlanGO."Total days" := 35;

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
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', Datee), Datee);
                    IF ECL.FINDFIRST THEN BEGIN
                        //gledam ugovore koji su biro i duzi prekid radnog odnosa, oni također gledaju samo radnu knjižicu


                        //dodala

                        WB.RESET;
                        WB.SETFILTER("Employee No.", '%1', "No.");
                        WB.SETFILTER("Starting Date", '<=%1', Datee);
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        WB.SETCURRENTKEY("Starting Date");
                        WB.ASCENDING;
                        IF WB.FINDLAST THEN BEGIN

                            IF WB.Months >= 6 THEN BEGIN
                                NeAzuriraj := TRUE;
                            END
                            ELSE BEGIN
                                PlanGO.RESET;
                                PlanGO.SETFILTER("Employee No.", '%1', "No.");
                                PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                                PlanGO.SETFILTER("Insert Date", '%1', Datee);
                                IF PlanGO.FINDFIRST THEN BEGIN
                                    PlanGO."Days based on Work experience" := 0;
                                    PlanGO."Days based on Disability" := 0;
                                    PlanGO."Based on Disabled Child" := 0;
                                    NeAzuriraj := FALSE;

                                    //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                    //knjižici zaposlenik i treba da ima 4 dana.
                                    IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(Datee, 3) THEN BEGIN

                                        //početak  (Gledam koliko mjeseci ima u skladu sa 31.12.2019

                                        Found1 := FALSE;
                                        CountYears1 := 0;
                                        CountMonths1 := 0;
                                        Prethodni := 0;
                                        Trenutni := 0;

                                        RecDate1.RESET;
                                        RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                                        RecDate1.SETRANGE("Period Start", WB."Starting Date", CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3))));
                                        IF RecDate1.FINDSET THEN BEGIN
                                            LastFoundDate1 := WB."Starting Date";
                                            // *** find count of years ***
                                            TempDate1 := CALCDATE('<+1Y>', WB."Starting Date");
                                            //već sam povecala za 1 god
                                            Found1 := TRUE;
                                            REPEAT


                                                IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    //ako zadovolji uslove treba povećati za +1G

                                                    AddYear := '';
                                                    CountYears1 += 1;

                                                    //  LastFoundDate1 := TempDate1;
                                                    AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                                    TempDate1 := CALCDATE(AddYear, WB."Starting Date");
                                                END
                                                ELSE
                                                    Found1 := FALSE;
                                            UNTIL NOT Found1;

                                            //pronašao broj godina i onda temp1 ide dalje
                                            NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                                            TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WB."Starting Date"));
                                            Found1 := TRUE;
                                            REPEAT

                                                IF (TempDate1 <= CALCDATE('<+1D>', DMY2DATE(31, 12, DATE2DMY(WB."Starting Date", 3)))) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                                    AddMonth := '';
                                                    CountMonths1 += 1;

                                                    // LastFoundDate1 := TempDate1;
                                                    AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                                    TempDate1 := CALCDATE(AddMonth, WB."Starting Date");
                                                END
                                                ELSE
                                                    Found1 := FALSE;
                                            UNTIL NOT Found1;

                                            NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';
                                            Prethodni := CountMonths1;
                                        END;

                                        PlanGO."Legal Grounds" := WB.Months - Prethodni;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;
                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                        IF PlanGO."Total days" > 35
                                                                    then
                                            PlanGO."Total days" := 35;

                                        PlanGO.MODIFY;


                                        //kraj

                                    END
                                    ELSE BEGIN


                                        PlanGO."Legal Grounds" := WB.Months;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;
                                        PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                        IF PlanGO."Total days" > 35
                                                                    then
                                            PlanGO."Total days" := 35;

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
                        ECLRadni.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', Datee), Datee);
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

                            WB.RESET;
                            WB.SETFILTER("Employee No.", '%1', "No.");
                            WB.SETFILTER("Current Company", '%1', TRUE);
                            WB.SETFILTER("Starting Date", '<=%1', Datee);
                            //WB.SETFILTER("Hours change",'%1',FALSE);
                            WB.SETCURRENTKEY("Starting Date");
                            WB.ASCENDING;
                            IF WB.FINDLAST THEN BEGIN
                                TrenutniDatumZaposlenja := WB."Starting Date";
                                BrojR := WB."Contract No.";
                                Godine := Godine + WB.Years;
                                Mjeseci := Mjeseci + WB.Months;
                                Dani := Dani + WB.Days;
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

                            IF (TrenutniDatumZaposlenja <> 0D) AND ((TrenutniDatumZaposlenja <= Datee) AND (TrenutniDatumZaposlenja >= CALCDATE('<-6M>', Datee))) THEN BEGIN

                                WorkBooklet.RESET;
                                WorkBooklet.SETFILTER("Employee No.", '%1', "No.");

                                WorkBooklet.SETFILTER("Contract No.", '<>%1', BrojR);
                                WorkBooklet.SETFILTER("Starting Date", '<>%1 & <=%2', TrenutniDatumZaposlenja, Datee);
                                //WorkBooklet.SETFILTER("Starting Date",'<=%1',Datee);
                                WorkBooklet.SETCURRENTKEY("Starting Date");
                                WorkBooklet.ASCENDING(FALSE);
                                IF WorkBooklet.FINDFIRST THEN BEGIN
                                    //đemka
                                    IF ((CALCDATE('<-' + FORMAT(BrojDana) + 'D>', TrenutniDatumZaposlenja)) <= WorkBooklet."Ending Date") THEN BEGIN
                                        //DODALA
                                        IF WorkBooklet."Current Company" = TRUE THEN
                                            WorkBooklet.VALIDATE(Coefficient, 1);
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
                                WorkBooklet.SETFILTER("Starting Date", '<>%1 &<=%2', TrenutniDatumZaposlenja, Datee);
                                //WorkBooklet.SETFILTER("Starting Date",'<=%1',Datee);
                                WorkBooklet.SETCURRENTKEY("Starting Date");
                                WorkBooklet.ASCENDING(FALSE);
                                IF WorkBooklet.FINDSET THEN
                                    REPEAT


                                        WorkBooklet2 := WorkBooklet;
                                        WorkBooklet2.SETFILTER("Employee No.", '%1', "No.");
                                        //WorkBooklet2.SETFILTER("Current Company",'%1',FALSE);
                                        WorkBooklet2.SETFILTER("Contract No.", '<>%1', BrojR);
                                        WorkBooklet2.SETFILTER("Starting Date", '<>%1 & <=%2', TrenutniDatumZaposlenja, Datee);
                                        //ĐK WorkBooklet2.SETFILTER("Starting Date",'<=%1',Datee);
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

                                StvarniStartDate := CALCDATE('<-' + FORMAT(Godine) + 'Y' + '-' + FORMAT(Mjeseci) + 'M' + '-' + FORMAT(Dani) + 'D>', Datee);
                                StvarniEndDate := Datee;

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
                                    PlanGO.SETFILTER(Year, '%1', DATE2DMY(Datee, 3));
                                    PlanGO.SETFILTER("Insert Date", '%1', Datee);
                                    IF PlanGO.FINDFIRST THEN BEGIN
                                        PlanGO."Days based on Work experience" := 0;
                                        PlanGO."Days based on Disability" := 0;
                                        PlanGO."Based on Disabled Child" := 0;
                                        NeAzuriraj := FALSE;


                                        //ako je datum zaposlenja u godini različit u odnosu na trenutnu godinu u kojoj se vrši kalkulacija (npr u 2019 dobio je 2 dana u 2020 još 2 dana, a u radnoj
                                        //knjižici zaposlenik i treba da ima 4 dana.
                                        PlanGO."Legal Grounds" := UkupniMjeseci;

                                        //PlanGO."Legal Grounds":=WB.Months;
                                        UsedDaysThisYear := 0;
                                        Absence.RESET;
                                        Absence.SETFILTER("Employee No.", '%1', "No.");
                                        Absence.SETFILTER("Vacation from Year", '%1', DATE2DMY(Datee, 3));
                                        Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                                        Absence.SETFILTER("From Date", '>=%1', WB."Starting Date");
                                        IF Absence.FINDSET THEN
                                            UsedDaysThisYear := Absence.COUNT;


                                        //PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-UsedDaysThisYear;

                                        //da li trebam obračunati prijelaz godine ako se desio
                                        PlanPrijelaz.RESET;
                                        PlanPrijelaz.SETFILTER("Employee No.", '%1', "No.");
                                        PlanPrijelaz.SETFILTER(Year, '%1', DATE2DMY(Datee, 3) - 1);
                                        IF PlanPrijelaz.FINDFIRST THEN BEGIN
                                            IF PlanPrijelaz."Legal Grounds" <= PlanGO."Legal Grounds" THEN
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear - PlanPrijelaz."Legal Grounds"
                                            ELSE
                                                PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;

                                        END
                                        ELSE BEGIN
                                            PlanGO."Legal Grounds" := PlanGO."Legal Grounds" - UsedDaysThisYear;
                                        END;


                                        PlanGO."Total days" := PlanGO."Legal Grounds" + PlanGO."Days based on Work experience" + PlanGO."Days based on Disability" + PlanGO."Days based on Military service" + PlanGO."Days based on Working conditi" + PlanGO."Based on Disabled Child" - PlanGO."Number of days" - PlanGO."Used days at previous employer";
                                        IF PlanGO."Total days" > 35
                                                                    then
                                            PlanGO."Total days" := 35;

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

            trigger OnPreDataItem()
            begin
                SETFILTER("Termination Date", '%1|>=%2', 0D, Datee);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Datee; Datee)
                {
                    ApplicationArea = all;
                    Caption = 'Date';
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
        //REPORT.RUNMODAL(50020,FALSE,TRUE);
        DataItem1.RESET;
        DataItem1.SETFILTER("External employer Status", '<>%1', DataItem1."External employer Status"::" ");
        IF DataItem1.FINDSET THEN
            REPEAT
                PlanGO.RESET;
                PlanGO.SETFILTER("Employee No.", '%1', DataItem1."No.");
                IF PlanGO.FINDFIRST THEN
                    PlanGO.DELETE;

            UNTIL DataItem1.NEXT = 0;




        /*R_WorkExperience.SetEndingDate(Datee);
R_WorkExperience.RUN;
*/
        MESSAGE('Uspješno je ažuriran plan korištenja godišnjih odmora.');

    end;

    trigger OnPreReport()
    begin


        PointsperExperienceYears.DELETEALL;
        Experience.RESET;
        IF Experience.FINDSET THEN
            REPEAT
                PointsperExperienceYears.INIT;
                PointsperExperienceYears.TRANSFERFIELDS(Experience);
                PointsperExperienceYears.INSERT;
            UNTIL Experience.NEXT = 0;

        PointsperExperienceYears.RESET;
        PointsperExperienceYears.SETCURRENTKEY(No);
        PointsperExperienceYears.SetFilter("Points Category", '%1', PointsperExperienceYears."Points Category"::"Points per Experience Years");
        PointsperExperienceYears.ASCENDING;
        IF PointsperExperienceYears.FINDSET THEN
            REPEAT
                AddDayyy := '<+' + FORMAT(PointsperExperienceYears.LowerLimit2) + '>';
                AddDayyy2 := '<+' + FORMAT(PointsperExperienceYears.UpperLimit2) + '>';
                PointsperExperienceYears."Today Min" := CALCDATE(AddDayyy, Datee);
                PointsperExperienceYears."Today Max" := CALCDATE(AddDayyy2, Datee);
                PointsperExperienceYears.MODIFY;
            UNTIL PointsperExperienceYears.NEXT = 0;





        /*CurrYear := DATE2DMY(Datee,3);
        IF Year=0 THEN
          Year:=CurrYear;
        FirstDateOfMonth:= DMY2DATE(1, 12, Year);
        LastDateOfMonth:=CALCDATE('-1D', CALCDATE('+1M',FirstDateOfMonth));*/

        /*IF Year<>CurrYear THEN BEGIN
        R_WorkExperience.SetEndingDate(DMY2DATE(31,12,Year));
        //R_WorkExperience.RUN;
        END;*/

        WBTemp.DELETEALL;

        Employeetest.RESET;


        IF Employeetest.FINDSET THEN
            REPEAT


                WbReal.RESET;
                WbReal.SETFILTER("Employee No.", '%1', Employeetest."No.");
                WbReal.SETFILTER("Current Company", '%1', TRUE);
                WbReal.SETFILTER("Starting Date", '<=%1', Datee);
                WbReal.SETCURRENTKEY("Starting Date");
                WbReal.ASCENDING;
                IF WbReal.FINDLAST THEN BEGIN

                    WB.INIT;
                    WB.TRANSFERFIELDS(WbReal);
                    WB."Ending Date" := Datee;



                    //ubaci validaciju koeficijenta
                    CountDays := 0;
                    CountMonths1 := 0;
                    CountYears1 := 0;
                    Found1 := FALSE;
                    UkupniDani := 0;
                    UkupniMjeseci := 0;
                    UkupnoGodine := 0;

                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", WB."Starting Date", CALCDATE('<+1D>', WB."Ending Date"));
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := WB."Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y>', WB."Starting Date");
                        //već sam povecala za 1 god
                        Found1 := TRUE;
                        REPEAT


                            IF (TempDate1 <= CALCDATE('<+1D>', WB."Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                //ako zadovolji uslove treba povećati za +1G

                                AddYear := '';
                                CountYears1 += 1;

                                //  LastFoundDate1 := TempDate1;
                                AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                TempDate1 := CALCDATE(AddYear, WB."Starting Date");
                            END
                            ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;

                        //pronašao broj godina i onda temp1 ide dalje
                        NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                        TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, WB."Starting Date"));
                        Found1 := TRUE;
                        REPEAT

                            IF (TempDate1 <= CALCDATE('<+1D>', WB."Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                AddMonth := '';
                                CountMonths1 += 1;

                                // LastFoundDate1 := TempDate1;
                                AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                TempDate1 := CALCDATE(AddMonth, WB."Starting Date");
                            END
                            ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;

                        NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                        TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, WB."Starting Date"));
                        Found1 := TRUE;
                        REPEAT
                            IF (TempDate1 <= CALCDATE('<+1D>', WB."Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+1d>', TempDate1);
                            END
                            ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;
                    END;


                    WB.Days := CountDays;
                    WB.Months := CountMonths1;
                    WB.Years := CountYears1;

                    IF WB.Coefficient <> 1 THEN BEGIN
                        UkupniDani += ROUND((WB.Days + (WB.Months * 30) + (WB.Years * 12 * 30)) * WB.Coefficient, 1, '>');
                        UkupniMjeseci := 0;
                        UkupnoGodine := 0;

                        WB.Years := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                        WB.Months := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                        WB.Days := UkupniDani MOD 30;

                    END;






                    WB.INSERT;

                END;

            UNTIL Employeetest.NEXT = 0;



        Employeetest.RESET;


        IF Employeetest.FINDSET THEN
            REPEAT
                Counter := 0;

                WbReal.RESET;
                WbReal.SETFILTER("Employee No.", '%1', Employeetest."No.");
                //WbReal.SETFILTER("Current Company",'%1',TRUE);
                WbReal.SETFILTER("Starting Date", '<=%1', Datee);
                WbReal.SETCURRENTKEY("Starting Date");
                WbReal.ASCENDING;
                IF WbReal.FINDSET THEN
                    REPEAT
                        WB.RESET;
                        WB.SETFILTER("Starting Date", '%1', WbReal."Starting Date");
                        WB.SETFILTER("Employee No.", '%1', WbReal."Employee No.");
                        IF NOT WB.FINDFIRST THEN BEGIN
                            WB.INIT;
                            WB.TRANSFERFIELDS(WbReal);
                            IF WB."Current Company" = TRUE THEN
                                WB.VALIDATE(Coefficient, 1);
                            WB.INSERT;
                        END;
                    UNTIL WbReal.NEXT = 0;


            UNTIL Employeetest.NEXT = 0;


        Employeetest.RESET;

        IF Employeetest.FINDSET THEN
            REPEAT

                Dan := 0;
                Mjesec2 := 0;
                Godina := 0;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                UkupnoGodine := 0;
                /*************************************/
                WB.RESET;
                WB.SETFILTER("Employee No.", Employeetest."No.");
                WB.SETFILTER("Is not dekra", '%1', FALSE);
                IF WB.FINDFIRST THEN BEGIN
                    REPEAT
                        UkupniDani += WB.Days;
                        UkupniMjeseci += WB.Months;
                        UkupnoGodine += WB.Years;
                    UNTIL WB.NEXT = 0;




                    HumanResourcesSetup.GET;
                    //pri importu
                    UkupniDani += Employeetest."Brought Days of Experience 2";
                    UkupniMjeseci += Employeetest."Brought Months of Experience 2";
                    UkupnoGodine += Employeetest."Brought Years of Experience 2";
                    IF ((EmployeeTest.Status.AsInteger() = 0) OR (EmployeeTest.Status.AsInteger() = 1) OR (EmployeeTest.Status.AsInteger() = 2) OR (EmployeeTest.Status.AsInteger() = 3) OR (EmployeeTest.Status.AsInteger() = 8)) THEN BEGIN
                        Dan := UkupniDani MOD 30;
                        Mjesec2 := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                        Godina := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                    END;


                    IF ((EmployeeTest.Status.AsInteger() = 5) OR (EmployeeTest.Status.AsInteger() = 6) OR (EmployeeTest.Status.AsInteger() = 7) OR (EmployeeTest.Status.AsInteger() = 9) OR (EmployeeTest.Status.AsInteger() = 10) OR (EmployeeTest.Status.AsInteger() = 11) OR (EmployeeTest.Status.AsInteger() = 12)) THEN BEGIN
                        IF ((EmployeeTest.Status.AsInteger() = 5) OR (EmployeeTest.Status.AsInteger() = 6) OR (EmployeeTest.Status.AsInteger() = 7) OR (EmployeeTest.Status.AsInteger() = 9) OR (EmployeeTest.Status.AsInteger() = 10) OR (EmployeeTest.Status.AsInteger() = 11) OR (EmployeeTest.Status.AsInteger() = 12)) THEN BEGIN
                            Dan := (UkupniDani - Employeetest."Brought Days of Experience E") MOD 30;
                            Mjesec2 := ((UkupniMjeseci - Employeetest."Brought Months of Experience E") + ((UkupniDani - Employeetest."Brought Days of Experience E") DIV 30)) MOD 12;
                            Godina := (UkupnoGodine - Employeetest."Brought Years of Experience E") + (((UkupniMjeseci - Employeetest."Brought Months of Experience E") + ((UkupniDani - Employeetest."Brought Days of Experience E") DIV 30)) DIV 12);

                        END;

                    END;
                    WBTemp.RESET;
                    WBTemp.SETFILTER("Employee No.", '%1', Employeetest."No.");
                    IF NOT WBTemp.FINDFIRST THEN BEGIN
                        WBTemp.INIT;
                        WB.RESET;
                        WB.SETFILTER("Employee No.", Employeetest."No.");
                        WB.SETFILTER("Is not dekra", '%1', FALSE);
                        IF WB.FINDFIRST THEN BEGIN

                            WBTemp.TRANSFERFIELDS(WB);
                            WBTemp.Years := Godina;
                            WBTemp.Months := Mjesec2;
                            WBTemp.Days := Dan;
                            WBTemp.INSERT;
                        END;
                    END;
                END;
            /************************************************/

            UNTIL Employeetest.NEXT = 0;

    end;

    var
        user: Record "User";
        Year: Integer;
        EmployeeRec: Record "Employee";
        PlanGO: Record "Vacation Ground 2";
        PositionRec: Record "Position";
        EmployeeRelative: Record "Employee Relative";
        i: Integer;
        Starost: Integer;
        Mjesec: Integer;
        i7: Integer;
        MjesecT: Integer;
        MilitaryMonths: Integer;
        JobType: Record "Vacation setup history";
        Experience: Record "Points per Experience Years";
        Datttt: Date;
        PointsperExperienceYears: Record "Points per Experience Years" temporary;
        R_WorkExperience: Report "Work experience in Company";
        StartingDate: Date;
        WorkBooklet: Record "Work Booklet";
        //R_BroughtExperience: Report "Education Structure";
        Godine: Decimal;
        Mjeseci: Decimal;
        WorkBooklet2: Record "Work Booklet";
        Dani: Decimal;
        StvarniStartDate: Date;
        CChildren: integer;
        StvarniEndDate: Date;
        TrenutniDatumZaposlenja: Date;
        SocialStatus: Record "Points per Experience Years";

        //ĐK    SocialStatusEmployee: Record "Candidate Testing";
        PlanPrijelaz: Record "Vacation Ground 2";
        AddDayyy: Text;
        AddDayyy2: Text;
        BrojR: Integer;
        ECLRadni: Record "Employee Contract Ledger";
        SocialStatusValue: Integer;
        WageSetup: Record "Wage Setup";
        VacationSetup: Record "Vacation setup history";
        ECLPrviPut: Record "Employee Contract Ledger";
        FirstDateOfMonth: Date;
        Trenutni: Decimal;
        Vacationsetuphistory: Record "Vacation setup history";
        Prethodni: Decimal;
        LastDateOfMonth: Date;
        CurrYear: Integer;
        EmploymentDate: Date;
        WB: Record "Work Booklet" temporary;
        ECL: Record "Employee Contract Ledger";
        Absence: Record "Employee Absence";
        UsedDays: Integer;
        Year2: Integer;
        UsedDaysThisYear: Integer;
        WB2: Record "Work Booklet";
        WbPrevious: Record "Work Booklet";
        DodajMjesec: Integer;
        NeAzuriraj: Boolean;
        "oRDER": Integer;
        ELD: Record "Employee Level Of Disability";
        LevelValue: Integer;
        Level: Integer;
        BrojDana: Integer;
        AddMonth: Text;
        AddYear: Text;
        DodavanjeGodine: Boolean;
        Datee: Date;
        EmployeeC: Record "Employee Contract Ledger";
        WbReal: Record "Work Booklet";
        Employeetest: Record "Employee";
        UkupniDani: Integer;
        UkupniMjeseci: Integer;
        UkupnoGodine: Integer;
        g1: Integer;
        m1: Integer;
        d1: Integer;
        g2: Integer;
        m2: Integer;
        d2: Integer;
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
        Counter: Integer;
        HumanResourcesSetup: Record "Human Resources Setup";
        Dan: Integer;
        Mjesec2: Integer;
        Godina: Integer;
        WBTemp: Record "Work Booklet" temporary;
}

