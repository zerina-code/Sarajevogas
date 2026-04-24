table 50117 "Work Booklet"
{
    // HR 9.1.2017 - HR Customization
    // Krajnji datum i naziv kompanije se automatki insertuje kada se označi Treenutni poslodavac

    Caption = 'Work Booklet';
    DrillDownPageID = "Work booklet";
    LookupPageID = "Work booklet";
    //đk



    fields
    {
        field(1; "Contract No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Contract No.';
        }
        field(2; "Employee ID"; Code[13])
        {
            Caption = 'Employee ID';
            Editable = false;

            trigger OnValidate()
            begin

                //HR01 start
                IF "Employee ID" <> '' THEN BEGIN
                    T_Employee.SETFILTER("Employee ID", "Employee ID");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                    END;
                END;
                //HR01 end
            end;
        }
        field(4; "First Name"; Text[30])
        {
            Caption = 'First Name';
            Editable = false;
        }
        field(5; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            Editable = false;
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    T_Employee.SETFILTER("No.", "Employee No.");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                        "Employee ID" := T_Employee."Employee ID";
                    END;

                    //BH 01 start
                    IF "Ending Date" <> 0D THEN BEGIN
                        IF "Starting Date" = 0D THEN
                            ERROR(Text001);

                        IF "Starting Date" > "Ending Date" then
                            //FIELDERROR("Ending Date");
                            ERROR(Text002);
                        //BH 01 end
                    END;
                    //BH 01 update
                    IF "Ending Date" = 0D THEN
                        "Ending Date" := WORKDATE;
                    //
                    CountDays := 0;
                    CountMonths1 := 0;
                    CountYears1 := 0;
                    Found1 := FALSE;
                    UkupniDani := 0;
                    UkupniMjeseci := 0;
                    UkupnoGodine := 0;

                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", "Starting Date", CALCDATE('<+1D>', "Ending Date"));
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := "Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y>', "Starting Date");
                        //već sam povecala za 1 god
                        Found1 := TRUE;
                        REPEAT


                            IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                //ako zadovolji uslove treba povećati za +1G

                                AddYear := '';
                                CountYears1 += 1;

                                //  LastFoundDate1 := TempDate1;
                                AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                                TempDate1 := CALCDATE(AddYear, "Starting Date");
                            END
                            ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;

                        //pronašao broj godina i onda temp1 ide dalje
                        NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                        TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, "Starting Date"));
                        Found1 := TRUE;
                        REPEAT

                            IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                                AddMonth := '';
                                CountMonths1 += 1;

                                // LastFoundDate1 := TempDate1;
                                AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                                TempDate1 := CALCDATE(AddMonth, "Starting Date");
                            END
                            ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;

                        NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                        TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, "Starting Date"));
                        Found1 := TRUE;
                        REPEAT
                            IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+1d>', TempDate1);
                            END
                            ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;
                    END;


                    Days := CountDays;
                    Months := CountMonths1;
                    Years := CountYears1;

                    IF Coefficient <> 1 THEN BEGIN
                        UkupniDani += ROUND((Days + (Months * 30) + (Years * 12 * 30)) * Coefficient, 1, '>');
                        UkupniMjeseci := 0;
                        UkupnoGodine := 0;

                        Years := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                        Months := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                        Days := UkupniDani MOD 30;

                    END;
                    //BH 01 update 
                END;

                /*CloseDate:=Rec."Starting Date"-1;
                  WB.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                  IF WB.COUNT>=1 THEN BEGIN
                  IF WB.FIND('+')
                  THEN WB.VALIDATE("Ending Date",CloseDate);
                  WB.MODIFY;
                  END;*/
                HRSetup.GET;
                IF "Current Company" THEN
                    "Date For Delivery" := CALCDATE(HRSetup."Tax Administration Report Days", "Starting Date");
                //Coefficient:=1;
                //13.06.2019
                WageSetup.GET;
                T_Employee.RESET;
                T_Employee.SETFILTER("No.", '%1', Rec."Employee No.");
                IF T_Employee.FINDFIRST THEN BEGIN
                    IF "Current Company" = TRUE THEN
                        Coefficient := T_Employee."Hours In Day" / WageSetup."Hours in Day"
                    ELSE
                        Coefficient := 1;
                END;
                //VALIDATE("Current Company","Current Company");

            end;
        }
        field(7; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                //EC02
                IF "Ending Date" <> 0D THEN BEGIN
                    IF "Starting Date" = 0D THEN
                        ERROR(Text001);
                    //BH 01 start
                    IF "Starting Date" > "Ending Date" then
                        //FIELDERROR("Ending Date");
                        ERROR(Text003);
                    //BH 01 end
                END;
                //EC02e
                //VALIDATE(Coefficient,Coefficient);
                //VALIDATE("Current Company","Current Company");
                //BH 01 update start
                IF "Ending Date" = 0D THEN
                    "Ending Date" := WORKDATE;
                //
                CountDays := 0;
                CountMonths1 := 0;
                CountYears1 := 0;
                Found1 := FALSE;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                UkupnoGodine := 0;

                RecDate1.RESET;
                RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                RecDate1.SETRANGE("Period Start", "Starting Date", CALCDATE('<+1D>', "Ending Date"));
                IF RecDate1.FINDSET THEN BEGIN
                    LastFoundDate1 := "Starting Date";
                    // *** find count of years ***
                    TempDate1 := CALCDATE('<+1Y>', "Starting Date");
                    //već sam povecala za 1 god
                    Found1 := TRUE;
                    REPEAT


                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            //ako zadovolji uslove treba povećati za +1G

                            AddYear := '';
                            CountYears1 += 1;

                            //  LastFoundDate1 := TempDate1;
                            AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                            TempDate1 := CALCDATE(AddYear, "Starting Date");
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;

                    //pronašao broj godina i onda temp1 ide dalje
                    NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                    TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, "Starting Date"));
                    Found1 := TRUE;
                    REPEAT

                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                            AddMonth := '';
                            CountMonths1 += 1;

                            // LastFoundDate1 := TempDate1;
                            AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                            TempDate1 := CALCDATE(AddMonth, "Starting Date");
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;

                    NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                    TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, "Starting Date"));
                    Found1 := TRUE;
                    REPEAT
                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountDays += 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+1d>', TempDate1);
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;
                END;


                Days := CountDays;
                Months := CountMonths1;
                Years := CountYears1;

                IF Coefficient <> 1 THEN BEGIN
                    UkupniDani += ROUND((Days + (Months * 30) + (Years * 12 * 30)) * Coefficient, 1, '>');
                    UkupniMjeseci := 0;
                    UkupnoGodine := 0;

                    Years := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                    Months := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                    Days := UkupniDani MOD 30;

                END;
                //BH 01 update end


            end;
        }
        //BH 01 start

        field(51000; "Military Service"; Boolean)
        {
            Caption = 'Military Service';
        }

        //BH 01 end
        field(8; Employer; Text[250])
        {
            Caption = 'Employer';
        }
        field(9; Years; Integer)
        {
            Caption = 'Years';
        }
        field(10; Months; Integer)
        {
            Caption = 'Months';
        }
        field(11; Days; Integer)
        {
            Caption = 'Days';
        }
        field(13; Previous; Boolean)
        {
        }
        field(14; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(15; "Current Company"; Boolean)
        {
            Caption = 'Current Company';

            trigger OnValidate()
            begin
                //HR01 start
                IF "Current Company" = TRUE THEN BEGIN
                    EmployeeA.RESET;
                    EmployeeA.SETFILTER("No.", "Employee No.");
                    IF EmployeeA.FINDFIRST THEN BEGIN
                        IF (((EmployeeA.Status = EmployeeA.Status::Active) OR (EmployeeA."External employer Status" = EmployeeA."External employer Status"::Active)) AND ("Ending Date" = 0D)) THEN
                            "Ending Date" := WORKDATE;
                        Company.GET;
                        Employer := Company.Name;
                    END;
                END;
                //HR01 end

                /*IF "Current Company"=TRUE THEN BEGIN
                  WorkBooklet.RESET;
                  WorkBooklet.SETFILTER("Employee No.","Employee No.");
                  IF WorkBooklet.FINDLAST THEN BEGIN
                    IF WorkBooklet."Current Company"=FALSE THEN BEGIN
                      WorkBooklet.NEXT(-1);
                      REPEAT
                        IF WorkBooklet."Current Company"=TRUE THEN BEGIN
                          Employee.RESET;
                          Employee.SETFILTER("No.","Employee No.");
                          IF Employee.FINDFIRST THEN BEGIN
                            Employee."Returned to Company":=TRUE;
                            Employee.MODIFY;
                          END;
                        END;
                      UNTIL (WorkBooklet."Current Company"=TRUE) OR (WorkBooklet.NEXT(-1)=0);
                    END
                    ELSE BEGIN
                    Employee.RESET;
                          Employee.SETFILTER("No.","Employee No.");
                          IF Employee.FINDFIRST THEN BEGIN
                            Employee."Returned to Company":=TRUE;
                            Employee.MODIFY;
                          END;
                        END;
                  END;
                END;
                
                IF "Current Company"=FALSE THEN BEGIN
                  WorkBooklet.RESET;
                  WorkBooklet.SETFILTER("Employee No.","Employee No.");
                  WorkBooklet.SETFILTER("Current Company",'%1',TRUE);
                  IF WorkBooklet.COUNT<=1 THEN BEGIN
                          Employee.RESET;
                          Employee.SETFILTER("No.","Employee No.");
                          IF Employee.FINDFIRST THEN BEGIN
                            IF Employee."Returned to Company"=TRUE
                              THEN
                              Employee."Returned to Company":=FALSE;
                            Employee.MODIFY;
                          //  MESSAGE(FORMAT(Employee."Returned to Company"));
                          END;
                  END;
                END;*/

                IF "Current Company" = TRUE THEN BEGIN

                    WorkBooklet.RESET;
                    WorkBooklet.SETFILTER("Employee No.", "Employee No.");
                    WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                    WorkBooklet.SETFILTER("Starting Date", '<>%1 & <%2', "Starting Date", "Starting Date");
                    WorkBooklet.SETCURRENTKEY("Starting Date");
                    WorkBooklet.ASCENDING;
                    IF WorkBooklet.FINDLAST THEN BEGIN
                        IF "Starting Date" = CALCDATE('<+1D>', WorkBooklet."Ending Date") THEN BEGIN
                            WorkBooklet.RESET;
                            WorkBooklet.SETFILTER("Employee No.", "Employee No.");
                            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                            WorkBooklet.SETFILTER("Starting Date", '>%1', "Starting Date");
                            WorkBooklet.SETCURRENTKEY("Starting Date");
                            WorkBooklet.ASCENDING;
                            IF WorkBooklet.FINDLAST THEN BEGIN
                                IF "Ending Date" = CALCDATE('<-1D>', WorkBooklet."Starting Date") THEN BEGIN
                                    Empl.RESET;
                                    Empl.SETFILTER("No.", '%1', "Employee No.");
                                    IF Empl.FINDFIRST THEN BEGIN
                                        Empl."Returned to Company" := FALSE;
                                        Empl.MODIFY;
                                    END;

                                END
                                ELSE BEGIN
                                    Empl.RESET;
                                    Empl.SETFILTER("No.", '%1', "Employee No.");
                                    IF Empl.FINDFIRST THEN BEGIN
                                        Empl."Returned to Company" := TRUE;
                                        Empl.MODIFY;
                                    END;
                                END;
                            END;
                        END
                        ELSE BEGIN
                            Empl.RESET;
                            Empl.SETFILTER("No.", '%1', "Employee No.");
                            IF Empl.FINDFIRST THEN BEGIN
                                Empl."Returned to Company" := TRUE;
                                Empl.MODIFY;
                            END;

                        END;
                    END
                    ELSE BEGIN
                        WorkBooklet.RESET;
                        WorkBooklet.SETFILTER("Employee No.", "Employee No.");
                        WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                        WorkBooklet.SETFILTER("Starting Date", '<>%1 & >%2', "Starting Date", "Starting Date");
                        WorkBooklet.SETCURRENTKEY("Starting Date");
                        WorkBooklet.ASCENDING;
                        IF WorkBooklet.FINDFIRST THEN BEGIN
                            IF WorkBooklet."Starting Date" = CALCDATE('<+1D>', "Ending Date") THEN BEGIN
                                Empl.RESET;
                                Empl.SETFILTER("No.", '%1', "Employee No.");
                                IF Empl.FINDFIRST THEN BEGIN
                                    Empl."Returned to Company" := FALSE;
                                    Empl.MODIFY;
                                END;
                            END
                            ELSE BEGIN

                                IF (WorkBooklet."Ending Date" = WORKDATE) AND ("Ending Date" = WORKDATE) THEN BEGIN
                                    Empl.RESET;
                                    Empl.SETFILTER("No.", '%1', "Employee No.");
                                    IF Empl.FINDFIRST THEN BEGIN
                                        Empl."Returned to Company" := FALSE;
                                        Empl.MODIFY;
                                    END;
                                END
                                ELSE BEGIN
                                    Empl.RESET;
                                    Empl.SETFILTER("No.", '%1', "Employee No.");
                                    IF Empl.FINDFIRST THEN BEGIN
                                        Empl."Returned to Company" := TRUE;
                                        Empl.MODIFY;
                                    END;
                                END;






                            END;





                        END;
                    END;
                END;




                IF "Current Company" = FALSE THEN BEGIN


                    WorkBooklet.RESET;
                    WorkBooklet.SETFILTER("Employee No.", "Employee No.");
                    WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                    WorkBooklet.SETCURRENTKEY("Starting Date");
                    WorkBooklet.ASCENDING;
                    IF WorkBooklet.FINDLAST THEN BEGIN
                        WorkBooklet2.RESET;
                        WorkBooklet2.SETFILTER("Employee No.", "Employee No.");
                        WorkBooklet2.SETFILTER("Current Company", '%1', TRUE);
                        WorkBooklet2.SETFILTER("Starting Date", '<%1', WorkBooklet."Starting Date");
                        WorkBooklet2.SETCURRENTKEY("Starting Date");
                        WorkBooklet2.ASCENDING;
                        IF WorkBooklet2.FINDLAST THEN BEGIN
                            IF WorkBooklet2."Ending Date" = CALCDATE('<+1D>', WorkBooklet."Starting Date") THEN BEGIN
                                Employee.RESET;
                                Employee.SETFILTER("No.", '%1', WorkBooklet."Employee No.");
                                IF Employee.FINDFIRST THEN BEGIN
                                    Employee."Returned to Company" := FALSE;
                                    Employee.MODIFY;
                                END;


                            END
                            ELSE BEGIN
                                Employee.RESET;
                                Employee.SETFILTER("No.", '%1', WorkBooklet."Employee No.");
                                IF Employee.FINDFIRST THEN BEGIN
                                    Employee."Returned to Company" := FALSE;
                                    Employee.MODIFY;
                                END;
                            END;


                        END;
                    END;
                END;

                IF "Employee No." <> '' THEN BEGIN
                    T_Employee.SETFILTER("No.", "Employee No.");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                        "Employee ID" := T_Employee."Employee ID";
                    END;
                END;


                //sd01 start
                WB.RESET;
                WB.SETFILTER("Current Company", 'TRUE');
                WB.SETCURRENTKEY("Starting Date");
                WB.ASCENDING;
                IF WB.FINDLAST THEN BEGIN
                    Employee1.RESET;
                    Employee1.SETFILTER("No.", "Employee No.");
                    IF Employee1.FINDFIRST THEN BEGIN
                        Employee1."Employment Date" := "Starting Date";
                        Employee1.MODIFY;
                    END;
                END;
                //sd01 end

                HRSetup.GET;
                IF "Current Company" THEN
                    "Date For Delivery" := CALCDATE(HRSetup."Tax Administration Report Days", "Starting Date")
                ELSE
                    "Date For Delivery" := 0D;

                WorkBooklet.RESET;
                WorkBooklet.SETFILTER("Employee No.", "Employee No.");
                WorkBooklet.SETFILTER("Starting Date", '<>%1', Rec."Starting Date");
                WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                IF NOT WorkBooklet.FINDFIRST THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        IF Employee."Returned to Company" = TRUE
                          THEN
                            Employee."Returned to Company" := FALSE;
                        Employee.MODIFY;
                        //  MESSAGE(FORMAT(Employee."Returned to Company"));
                    END;
                END;
                //BH update start
                IF "Ending Date" = 0D THEN
                    "Ending Date" := WORKDATE;
                //
                CountDays := 0;
                CountMonths1 := 0;
                CountYears1 := 0;
                Found1 := FALSE;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                UkupnoGodine := 0;

                RecDate1.RESET;
                RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                RecDate1.SETRANGE("Period Start", "Starting Date", CALCDATE('<+1D>', "Ending Date"));
                IF RecDate1.FINDSET THEN BEGIN
                    LastFoundDate1 := "Starting Date";
                    // *** find count of years ***
                    TempDate1 := CALCDATE('<+1Y>', "Starting Date");
                    //već sam povecala za 1 god
                    Found1 := TRUE;
                    REPEAT


                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            //ako zadovolji uslove treba povećati za +1G

                            AddYear := '';
                            CountYears1 += 1;

                            //  LastFoundDate1 := TempDate1;
                            AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                            TempDate1 := CALCDATE(AddYear, "Starting Date");
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;

                    //pronašao broj godina i onda temp1 ide dalje
                    NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                    TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, "Starting Date"));
                    Found1 := TRUE;
                    REPEAT

                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                            AddMonth := '';
                            CountMonths1 += 1;

                            // LastFoundDate1 := TempDate1;
                            AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                            TempDate1 := CALCDATE(AddMonth, "Starting Date");
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;

                    NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                    TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, "Starting Date"));
                    Found1 := TRUE;
                    REPEAT
                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountDays += 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+1d>', TempDate1);
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;
                END;


                Days := CountDays;
                Months := CountMonths1;
                Years := CountYears1;

                IF Coefficient <> 1 THEN BEGIN
                    UkupniDani += ROUND((Days + (Months * 30) + (Years * 12 * 30)) * Coefficient, 1, '>');
                    UkupniMjeseci := 0;
                    UkupnoGodine := 0;

                    Years := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                    Months := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                    Days := UkupniDani MOD 30;

                END;
                //BH update end

            end;
        }
        field(16; "Work Booklet No."; Text[30])
        {
            Caption = 'Work Booklet No.';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    T_Employee.SETFILTER("No.", "Employee No.");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                        "Employee ID" := T_Employee."Employee ID";

                    END;
                END;

                WEmployee.SETFILTER("No.", "Employee No.");
                IF WEmployee.FINDFIRST THEN BEGIN
                    WEmployee."Work Booklet No." := "Work Booklet No.";
                    WEmployee.MODIFY;
                END;

            end;
        }
        field(17; "Work Experience Document"; Code[20])
        {
            Caption = 'Work Experience Document';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    T_Employee.SETFILTER("No.", "Employee No.");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                        "Employee ID" := T_Employee."Employee ID";
                    END;
                END;

                WEmployee.SETFILTER("No.", "Employee No.");
                IF WEmployee.FINDFIRST THEN BEGIN
                    WEmployee."Work Experience Document" := "Work Experience Document";
                    WEmployee.MODIFY;
                END;

            end;
        }
        field(18; Active; Boolean)
        {
            Caption = 'Active';

            trigger OnValidate()
            begin
                /*IF  Active=TRUE THEN BEGIN
                "Ending Date":=WORKDATE;
                Company.GET;
                Employer:=Company.Name;
                END*/
                /*IF ("Current Company"=TRUE AND Active=TRUE) THEN BEGIN
                "Ending Date":=WORKDATE;
                Company.GET;
                Employer:=Company.Name;
                END
                ELSE IF ("Current Company"=TRUE AND Active=FALSE) THEN BEGIN
                Company.GET;
                Employer:=Company.Name;
                END;*/

            end;
        }
        field(19; "Date For Delivery"; Date)
        {
            Caption = 'Date For Delivery';
        }
        field(20; Status; enum "Employee Status Ext")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';

        }
        field(21; "Serial No."; Text[40])
        {
            Caption = 'Serial No.';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    T_Employee.SETFILTER("No.", "Employee No.");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                        "Employee ID" := T_Employee."Employee ID";

                    END;
                END;

                WEmployee.SETFILTER("No.", "Employee No.");
                IF WEmployee.FINDFIRST THEN BEGIN
                    WEmployee."Work Booklet No." := "Work Booklet No.";
                    WEmployee.MODIFY;
                END;

            end;
        }
        field(22; Coefficient; Decimal)
        {
            //tu?
            Caption = 'Coefficient';

            trigger OnValidate()
            begin
                //
                IF "Ending Date" = 0D THEN
                    "Ending Date" := WORKDATE;
                //
                CountDays := 0;
                CountMonths1 := 0;
                CountYears1 := 0;
                Found1 := FALSE;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                UkupnoGodine := 0;

                RecDate1.RESET;
                RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                RecDate1.SETRANGE("Period Start", "Starting Date", CALCDATE('<+1D>', "Ending Date"));
                IF RecDate1.FINDSET THEN BEGIN
                    LastFoundDate1 := "Starting Date";
                    // *** find count of years ***
                    TempDate1 := CALCDATE('<+1Y>', "Starting Date");
                    //već sam povecala za 1 god
                    Found1 := TRUE;
                    REPEAT


                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            //ako zadovolji uslove treba povećati za +1G

                            AddYear := '';
                            CountYears1 += 1;

                            //  LastFoundDate1 := TempDate1;
                            AddYear := '<+' + FORMAT(CountYears1 + 1) + 'Y>';
                            TempDate1 := CALCDATE(AddYear, "Starting Date");
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;

                    //pronašao broj godina i onda temp1 ide dalje
                    NumberOfYear := '<+' + FORMAT(CountYears1) + 'Y>';

                    TempDate1 := CALCDATE('<+1M>', CALCDATE(NumberOfYear, "Starting Date"));
                    Found1 := TRUE;
                    REPEAT

                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN

                            AddMonth := '';
                            CountMonths1 += 1;

                            // LastFoundDate1 := TempDate1;
                            AddMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1 + 1) + 'M>';
                            TempDate1 := CALCDATE(AddMonth, "Starting Date");
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;

                    NumberOfMonth := '<' + FORMAT(CountYears1) + 'Y+' + FORMAT(CountMonths1) + 'M>';


                    TempDate1 := CALCDATE('<+1d>', CALCDATE(NumberOfMonth, "Starting Date"));
                    Found1 := TRUE;
                    REPEAT
                        IF (TempDate1 <= CALCDATE('<+1D>', "Ending Date")) AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountDays += 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+1d>', TempDate1);
                        END
                        ELSE
                            Found1 := FALSE;
                    UNTIL NOT Found1;
                END;


                Days := CountDays;
                Months := CountMonths1;
                Years := CountYears1;

                IF Coefficient <> 1 THEN BEGIN
                    UkupniDani += ROUND((Days + (Months * 30) + (Years * 12 * 30)) * Coefficient, 1, '>');
                    UkupniMjeseci := 0;
                    UkupnoGodine := 0;

                    Years := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                    Months := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                    Days := UkupniDani MOD 30;

                END;
            end;
        }
        field(23; "Validate Work Experience"; Boolean)
        {

            trigger OnValidate()
            begin
                R_WorkExperience.SetEmp("Employee No.", rec."Ending Date");
                R_WorkExperience.RUN;
            end;
        }
        field(24; "Contract Ledger Entry No."; Integer)
        {
            Caption = 'Contract Ledger Entry No.';
        }
        field(25; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;

        }
        field(26; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector Description';
            Editable = false;

        }
        field(27; "Group Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group Name';
            Editable = false;

        }
        field(28; "Team Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team Description';
            Editable = false;

        }
        field(29; "Old PIO No."; Code[20])
        {
            Caption = 'Old PIO No.';
        }
        field(50011; "Employee First Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;

        }
        field(50012; "Employee Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Last Name';
            Editable = false;

        }
        field(50013; "Is not dekra"; Boolean)
        {
        }
        field(50014; "Is dekra"; Boolean)
        {
        }
        field(50015; "Hours change"; Boolean)
        {
            Caption = 'Hours change';
        }


    }

    keys
    {
        key(Key1; "Contract No.", "Employee No.")
        {
        }
        key(Key2; "Starting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka!');

        END;

        WEmployee.RESET;
        WEmployee.SETFILTER("No.", "Employee No.");
        IF WEmployee.FINDFIRST THEN BEGIN
            WEmployee."Work Booklet No." := '';
            WEmployee.MODIFY;
        END;
        Rec.DELETE;
        WB.RESET;
        WB.SETFILTER("Current Company", '%1', TRUE);
        WB.SETFILTER("Employee No.", '%1', "Employee No.");
        WB.SETFILTER("Starting Date", '<>%1', Rec."Starting Date");
        WB.SETCURRENTKEY("Starting Date");
        WB.ASCENDING;
        IF WB.FINDLAST THEN BEGIN
            WbPrevious.RESET;
            WbPrevious.SETFILTER("Employee No.", '%1', WB."Employee No.");
            WbPrevious.SETFILTER("Current Company", '%1', TRUE);
            WbPrevious.SETFILTER("Starting Date", '<%1 & <>%2', WB."Starting Date", Rec."Starting Date");
            WbPrevious.SETCURRENTKEY("Starting Date");
            WbPrevious.ASCENDING;

            IF WbPrevious.FINDLAST THEN BEGIN
                IF WbPrevious."Ending Date" = CALCDATE('<-1D>', WB."Starting Date") THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", '%1', WB."Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        Employee."Returned to Company" := FALSE;
                        Employee.MODIFY;
                    END;
                END
                ELSE BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", '%1', WB."Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        Employee."Returned to Company" := TRUE;
                        Employee.MODIFY;
                    END;
                END;

            END;
        END
        ELSE BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", '%1', WB."Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Returned to Company" := FALSE;
                Employee.MODIFY;
            END;
        END;
        WorkBooklet.RESET;
        WorkBooklet.SETFILTER("Employee No.", "Employee No.");
        WorkBooklet.SETFILTER("Starting Date", '<>%1', Rec."Starting Date");
        WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
        IF WorkBooklet.COUNT <= 1 THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                IF Employee."Returned to Company" = TRUE
                  THEN
                    Employee."Returned to Company" := FALSE;
                Employee.MODIFY;
                //  MESSAGE(FORMAT(Employee."Returned to Company"));
            END;
        END;
    end;

    trigger OnInsert()
    begin
        //HR01 start

        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka!');

        END;


        IF "Employee No." <> '' THEN BEGIN
            T_Employee.SETFILTER("No.", "Employee No.");
            IF T_Employee.FINDFIRST THEN BEGIN
                "First Name" := T_Employee."First Name";
                "Last Name" := T_Employee."Last Name";
                "Employee ID" := T_Employee."Employee ID";
            END;
        END;
        //HR01 end
        enable := TRUE;
        Active := TRUE;

        Employee.RESET;
        Employee.SETFILTER("No.", "Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            Employee."Work Booklet No." := "Work Booklet No.";
            Employee."Work Experience Document" := "Work Experience Document";
            Employee.MODIFY;

            /* WorkBooklet.RESET;
             WorkBooklet.SETFILTER("Employee No.","Employee No.");
             IF WorkBooklet.FINDFIRST THEN BEGIN
               REPEAT
                 WorkBooklet.Active:=FALSE;
                 WorkBooklet.MODIFY;
                 UNTIL WorkBooklet.NEXT=0;
              END;

             Active:=TRUE;*/
        END;
        /*IF "Current Company"=FALSE THEN BEGIN
        Empl.RESET;
        Empl.SETFILTER(Empl."No.","Employee No.");
        IF Empl.FINDFIRST THEN
         // IF (Empl."Brought Days of Experience"<>0) OR (Empl."Brought Months of Experience"<>0) OR (Empl."Brought Years of Experience"<>0) THEN
          ECL."First Time Employed":=FALSE
          ELSE BEGIN
          ECL."First Time Employed":=TRUE;
         // END;
          END;
          ECL.MODIFY;
          END;*/
        IF "Current Company" = FALSE THEN BEGIN
            IF "Contract Ledger Entry No." <> 0 THEN BEGIN
                ECL.RESET;
                ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                IF ECL.FINDLAST THEN
                    ECL."First Time Employed" := FALSE
                ELSE BEGIN
                    ECL."First Time Employed" := TRUE;
                END;
                ECL.MODIFY;
            END;
        END;





    end;

    trigger OnModify()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka!');

        END;

        IF Active = TRUE THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Work Booklet No." := "Work Booklet No.";
                Employee."Work Experience Document" := "Work Experience Document";
                Employee.MODIFY;
            END;
        END;


    end;

    trigger OnRename()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka!');

        END;
    end;

    var
        EmpContrLedg: Record "Work Booklet";
        EmployeeCardPage: page "Employee Card";
        EmployeeListPage: Page "Employee List";
        T_Employee: Record "Employee";
        R_BroughtExperience: Report "Update Brought Experience";
        T_Department: Record "Department";
        Text001: Label 'Starting Date field cannot be blank.';
        t_CompInfo: Record "Company Information";
        enable: Boolean;
        Employee2: Record Employee;
        Company: Record "Company Information";
        WorkBooklet: Record "Work Booklet";
        Employee: Record "Employee";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        EntryNo: Code[10];
        WB: Record "Work Booklet";
        CloseDate: Date;
        WEmployee: Record "Employee";
        EmployeeA: Record "Employee";
        Employee1: Record "Employee";
        UkupniDani: Integer;
        UkupniMjeseci: Integer;
        UkupnoGodine: Integer;
        R_WorkExperience: Report "Work experience in Company";
        Empl: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        WageSetup: Record "Wage Setup";
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
        Text2: Label '''';
        Nesto: Date;
        YaerF: Date;
        Novi: Date;
        NumberOfMonth: Text;
        AddYear: Text;
        AddMonth: Text;
        WbPrevious: Record "Work Booklet";
        WorkBooklet2: Record "Work Booklet";
        UserPersonalization: Record "User Personalization";
        //BH 01 start
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';
    //BH 01 end

}

