table 50055 "ECL systematization"
{
    Caption = 'ECL systematization';
    DrillDownPageID = "ECL Systematizations";
    LookupPageID = "ECL Systematizations";


    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'Entry  No.';
        }
        field(594134; "Position complexity"; Decimal)

        {
            Caption = 'Position complexity';
        }
        field(594135; "Position Responsibility"; Decimal)

        {
            Caption = 'Position Responsibility';
        }
        field(594136; "Workplace conditions"; Decimal)
        {
            Caption = 'Workplace conditions';
        }

        field(594137; "School"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Position Minimal Educ Temp" where("Position Code" = field("Position Code"), "Position Name" = field("Position Description"), "Org Shema" = field("Org. Structure")));
            Caption = 'School';
            Editable = false;

        }
        field(5941378; "Employee Education Level"; enum School)
        {
            Caption = 'Employee Education Level';


        }
        field(594133; "Position Coefficient for Wage"; Decimal)
        {
            Caption = 'Position Coefficient for Wage';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No." WHERE(StatusExt = FILTER('Active|On boarding'));

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN
                    EVALUATE(Order, "Employee No.");
                Emp.RESET;
                Emp.SETFILTER("No.", '%1', "Employee No.");
                IF Emp.FINDFIRST THEN BEGIN
                    "Employee Name" := Emp."First Name" + '-' + Emp."Last Name";
                END
                ELSE BEGIN
                    "Employee Name" := '';
                END;
            end;
        }
        field(4; "Contract Activation Date"; Date)
        {
            Caption = 'Contract Activation Date';
        }
        field(5; "Contract Termination Date"; Date)
        {
            Caption = 'Contract Termination Date';
        }
        field(7; "Contract Type"; Code[20])
        {
            Caption = 'Contract Type';
            Editable = false;
        }
        field(9; Netto; Decimal)
        {
            Caption = 'Wage BasisNetto';
        }
        field(10; Brutto; Decimal)
        {
            Caption = 'Wage Basis Brutto';
        }
        field(11; "Testing Period"; Boolean)
        {
            Caption = 'Testing Period';
        }
        field(12; "Testing Period (Duration)"; DateFormula)
        {
            Caption = 'Testing Period (Duration)';
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Terminated';
            OptionMembers = Active,Terminated;

            trigger OnValidate()
            begin
                VALIDATE(Brutto, Brutto);
            end;
        }
        field(17; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                /***************NOVA VERZIJA*****************/
                /*********************************tRY**********************************/
                IF ("Contract Type" = '4') OR ("Contract Type" = '-1') OR ("Contract Type" = '5') THEN BEGIN
                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", "Starting Date", "Ending Date");
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := "Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y-1D>', LastFoundDate1);
                        Found1 := TRUE;
                        CountYears1 := 0;
                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountYears1 := 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+2Y-1D>', "Starting Date");
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountYears1 := 2;
                                LastFoundDate1 := TempDate1;
                            END;
                        END;

                        // *** find count of months ***
                        IF CountYears1 = 0 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M-1D>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<9M-1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 1 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<1Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+1Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<1Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<1Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<1Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<1Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<1Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+1Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<1Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<1Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<1Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<1Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<1Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<+1Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<1Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<1Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<1Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+1Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<1Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<1Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 2 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<2Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<2Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<2Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<2Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<2Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<2Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<2Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+2Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<2Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<2Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<2Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<2Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<2Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<2Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<2Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+2Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<2Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<2Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<2Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<2Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        "Work Days" := CountDays1;
                        "Work Months" := CountMonths1;
                        "Work Years" := CountYears1;
                    END;
                END
                ELSE BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Starting Date" = 0D) OR ("Ending Date" = 0D) THEN BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;

                IF "Contract Type" = '5' THEN BEGIN
                    "Testing Period" := TRUE;
                    "Testing Period Starting Date" := "Starting Date";
                END
                ELSE BEGIN
                    "Testing Period" := FALSE;
                    "Testing Period Starting Date" := 0D;
                END;

            end;
        }
        field(18; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(23; Previous; Boolean)
        {
        }
        field(24; "Contract No."; Code[10])
        {
            Caption = 'Contract No.';
        }
        field(25; "First Time Employed"; Boolean)
        {
            Caption = 'First Time Employed';
        }
        field(26; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(27; "Tax Deduction Amount"; Decimal)
        {
            Caption = 'Tax Deduction Amount';
        }
        field(28; "Brutto After Contributtion"; Decimal)
        {
            Caption = 'Brutto After Contributtion';
        }
        field(29; "Employee Name"; Text[81])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(30; "Testing Period Successful"; Option)
        {
            Caption = 'Testing Period Successful';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(31; "Wage Type"; Option)
        {
            Caption = 'Wage Type';
            OptionCaption = ' ,Brutto,Netto';
            OptionMembers = " ",Brutto,Netto;
        }
        field(32; "Way of Employment"; Option)
        {
            Caption = 'Way of Employment';
            OptionCaption = ' ,Employment Office,Longer Redundancy,From Employment,Court Ruling';
            OptionMembers = " ","Employment Office","Longer Redundancy","From Employment","Court Ruling";
        }
        field(33; Prentice; Boolean)
        {
            Caption = 'Prentice';
        }

        field(5941381; "Increment"; Decimal)

        {
            Caption = 'Increment';
        }

        field(34; KPI; Boolean)
        {
            Caption = 'KPI';
        }
        field(35; "Testing Period Starting Date"; Date)
        {
            Caption = 'Testing Period Starting Date';
        }
        field(36; "Testing Period Ending Date"; Date)
        {
            Caption = 'Testing Period Ending Date';
        }
        field(37; "Prohibition of Competition"; Boolean)
        {
            Caption = 'Prohibition of Competition';
        }
        field(38; "POC Starting Date"; Date)
        {
            Caption = 'POC Starting Date';
        }
        field(39; "POC Ending Date"; Date)
        {
            Caption = 'POC Ending Date';
        }
        field(41; IS; Boolean)
        {
            Caption = 'IS';
        }
        field(42; "IS Date From"; Date)
        {
            Caption = 'IS Date From';
        }
        field(43; "IS Date To"; Date)
        {
            Caption = 'IS Date To';
        }
        field(44; "Control Function"; Boolean)
        {
            Caption = 'Control Function';
        }
        field(45; "Control Function From"; Date)
        {
            Caption = 'Control Function From';
        }
        field(46; "Control Function To"; Date)
        {
            Caption = 'Control Function To';
        }
        field(47; "Additional Benefits"; Boolean)
        {
            Caption = 'Additional Benefits';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Contract Type" = '-1') OR ("Contract Type" = '4') OR ("Contract Type" = '5')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(48; "Manager Contract"; Boolean)
        {
            Caption = 'Manager Contract';
        }
        field(50; "Exit Interview"; Boolean)
        {
            Caption = 'Exit Interview';
        }
        field(51; "Employment Abroad"; Boolean)
        {
            Caption = 'Employment Abroad';
        }
        field(52; "Employment Abroad City"; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Empl. Abroad Country/Region" = FILTER('')) "Post Code".City
            ELSE
            IF ("Empl. Abroad Country/Region" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Empl. Abroad Country/Region"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(53; "Empl. Abroad Country/Region"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
        field(54; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(55; "Testing Period (Duration Opt.)"; Option)
        {
            Caption = 'Testing Period (Duration Opt.)';
            OptionCaption = ' ,1 month,2 months,3 months,4 months,5 months,6 months';
            OptionMembers = " ","1 month","2 months","3 months","4 months","5 months","6 months";
        }
        field(58; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
        }
        field(50280; "Order"; Integer)
        {
        }
        field(50281; "Testing Period - Comment"; Text[100])
        {
            Caption = 'Testing Period - comment';
        }
        field(50282; "Additional Responsiblity"; Text[200])
        {
            Caption = 'Additional Responsiblity';
            //ĐK TableRelation = "Additional Responsibility";
        }
        field(50283; "Testing period duration"; DateTime)
        {
        }
        field(50284; "Probation Days"; Integer)
        {
            Caption = 'Probation Days';
            Editable = false;
        }
        field(50285; "Probation Months"; Integer)
        {
            Caption = 'Probation Months';
            Editable = false;
        }
        field(50286; "Reason for Change"; enum "Reason for Change")
        {
            Caption = 'Reason for Change';

            trigger OnValidate()
            begin
                //Brojac:=0;
                /*IF ((xRec."Reason for Change"<>0) AND (Brojac=0)) THEN BEGIN
                  IF ((xRec."Reason for Change"<>Rec."Reason for Change") )
                     THEN BEGIN
                
                           Answer :=CONFIRM('Da li želite promijeiti vrijednost polja "%1" iz "%2" u "%3"?',TRUE,
                    FIELDCAPTION("Reason for Change"),xRec."Reason for Change",Rec."Reason for Change");
                    IF Answer =FALSE THEN BEGIN
                  "Reason for Change":= xRec."Reason for Change";
                    Brojac:=1;
                      END
                      ELSE BEGIN
                 MESSAGE ('Da') ;
                    END;
                   END
                  END;*/

            end;
        }
        field(50290; "Additional Position"; Boolean)
        {
            Caption = 'Additional Position';
        }
        field(50293; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(50294; "Residence/Network"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department temporary"."Residence/Network" WHERE("Code" = FIELD("Department Code"),
                                                                                 "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Residence/Network';
            Editable = false;

            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(50295; "Department Name"; Text[130])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department temporary".Description WHERE("Code" = FIELD("Department Code"),
                                                                           "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Department Name';
            Editable = false;

        }
        field(50296; "Department Address"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Address WHERE(Code = FIELD("Org Dio"),
                                                               GF = FIELD("GF rada code")));
            Caption = 'Department Address';
            Editable = false;

        }
        field(50297; "Department City"; Text[30])
        {
            Caption = 'Department City';
            Editable = false;
        }
        field(50298; Municipality; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code of agency" WHERE(Code = FIELD("Org Dio"),
                                                                                     GF = FIELD("GF rada code")));
            Caption = 'Municipality';
            Editable = false;

        }
        field(50299; Sector; Code[30])
        {
            Caption = 'Sector';
            Editable = false;
            TableRelation = "Sector temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50300; "Sector Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = "Sector temporary".Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                /*Department.SETFILTER ("Sector  Description",'%1',"Sector Description");
                    IF Department.FIND('-') THEN BEGIN

                      "Sector Description":=Department."Sector  Description";
                       IF ("Sector Description"<>'') AND ("Department Cat. Description"='') THEN BEGIN

                         VALIDATE("Department Code",Department.Sector);

                         VALIDATE(Sector,Department.Sector);
                        VALIDATE(Description,"Sector Description");
                         END;
                 END;




               IF "Sector Description"='' THEN BEGIN
                 Sector:='';
                 "Department Cat. Description":='';
                 "Department Category":='';
                 Group:='';
                 "Group Description":='';
                 Team:='';
                 "Team Description":='';
                 "Department Code":='';
                 "Department Name":='';

                 END;*/

                Department.RESET;
                Department.SETFILTER("Sector  Description", '%1', "Sector Description");
                Department.SETFILTER("Department Type", '%1|%2', 2, 1);
                IF Department.FINDFIRST THEN BEGIN
                    Team := Department."Team Code";
                    Sector := Department.Sector;
                    "Sector Description" := Department."Sector  Description";
                    "Department Category" := Department."Department Category";
                    "Department Cat. Description" := Department."Department Categ.  Description";
                    Group := Department."Group Code";
                    "Group Description" := Department."Group Description";
                    "Department Code" := Sector;
                    "Team Description" := Department."Team Description";
                    "Sector Identity" := Department."Sector Identity";

                END
                ELSE BEGIN
                    Team := '';
                    "Department Code" := '';
                    Sector := '';
                    "Sector Description" := '';
                    "Department Category" := '';
                    "Department Cat. Description" := '';
                    Group := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Sector Identity" := 0;





                END;


                DVCheck.Reset();
                DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                DVCheck.SetFilter(Name, '%1', Rec.Sector);
                if not DVCheck.FindFirst() then begin
                    DVCheck.Init();
                    DVCheck."Dimension Code" := 'TC';
                    DVCheck.Code := Rec.Sector;
                    DVCheck.Name := copystr(Rec."Sector Description", 1, 50);
                    DVCheck.Status := DVCheck.Status::A;
                end;

                DVCheck.Reset();
                DVCheck.SetFilter(Name, '%1', '');
                if DVCheck.FindFirst() then
                    Rec.validate("Dimension  Name", Rec.Sector);




                /*   IF ("Department Cat. Description" = '') AND ("Sector Description" <> '') THEN BEGIN
                       IF "Position Description" <> '' THEN BEGIN
                           ECLTC.RESET;
                           ECLTC.SETFILTER("Position Code", '%1', "Position Code");
                           ECLTC.SETFILTER("Position Description", '%1', "Position Description");
                           ECLTC.SETFILTER(Sector, '%1', Sector);
                           ECLTC.SETFILTER("Department Category", '%1', "Department Category");
                           ECLTC.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                           ECLTC.SETFILTER("Group Code", '%1', '');
                           ECLTC.SETFILTER("Group Description", '%1', '');
                           ECLTC.SETFILTER("Team Code", '%1', '');
                           ECLTC.SETFILTER("Team Description", '%1', '');
                           IF ECLTC.FINDFIRST THEN BEGIN
                               VALIDATE("Dimension  Name", ECLTC."Dimension  Name");
                           END
                           ELSE BEGIN
                               "Dimension  Name" := '';
                               "Dimension Value Code" := '';
                           END;
                       END;*/
            END;


        }
        field(50301; "Department Category"; Code[30])
        {
            Caption = 'Odjel';
            Editable = false;
            TableRelation = "Department Category temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"),
                                                                        Description = FIELD("Department Cat. Description"));
        }
        field(50302; "Department Cat. Description"; Text[250])
        {
            Caption = 'Department Cat. Description';
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                /*Department.SETFILTER ("Department Categ.  Description",'%1',"Department Cat. Description");
                    IF Department.FIND('-') THEN BEGIN*/


                /* "Department Cat. Description":=Department."Department Categ.  Description";
                  IF ("Department Cat. Description"<>'') AND ("Group Description"='') THEN BEGIN

                    VALIDATE("Department Code",Department."Department Category");
                    VALIDATE("Department Category",Department."Department Category");

                    VALIDATE(Sector,Department.Sector);
                    VALIDATE("Sector Description",Department."Sector  Description");
                     VALIDATE(Description,"Department Cat. Description");


                    END;*/

                Department.RESET;
                Department.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                Department.SETFILTER("Department Type", '%1|%2', 3, 5);
                IF Department.FINDFIRST THEN BEGIN
                    Team := Department."Team Code";
                    Sector := Department.Sector;
                    "Sector Description" := Department."Sector  Description";
                    "Department Category" := Department."Department Category";
                    "Department Cat. Description" := Department."Department Categ.  Description";
                    Group := Department."Group Code";
                    "Group Description" := Department."Group Description";
                    "Department Code" := "Department Category";
                    "Team Description" := Department."Team Description";
                    "Sector Identity" := Department."Sector Identity";
                END
                ELSE BEGIN
                    Team := '';
                    "Department Code" := '';
                    Sector := '';
                    "Sector Description" := '';
                    "Department Category" := '';
                    "Department Cat. Description" := '';
                    Group := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Sector Identity" := 0;





                END;

                IF "Department Cat. Description" = '' THEN BEGIN
                    "Department Category" := '';
                    "Sector Description" := '';
                    Sector := '';
                    "Department Code" := '';
                    "Department Name" := '';
                    "Position Description" := '';
                END;


                DVCheck.Reset();
                DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                DVCheck.SetFilter(Name, '%1', Rec.Sector);
                if not DVCheck.FindFirst() then begin
                    DVCheck.Init();
                    DVCheck."Dimension Code" := 'TC';
                    DVCheck.Code := Rec.Sector;
                    DVCheck.Name := copystr(Rec."Sector Description", 1, 50);
                    DVCheck.Status := DVCheck.Status::A;
                end;

                DVCheck.Reset();
                DVCheck.SetFilter(Name, '%1', '');
                if DVCheck.FindFirst() then
                    Rec.validate("Dimension  Name", Rec.Sector);
            end;
        }
        field(50303; Group; Code[30])
        {
            Caption = 'Group';
            Editable = false;
            TableRelation = "Group temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"),
                                                          Description = FIELD("Group Description"));
        }
        field(50304; "Group Description"; Text[250])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group temporary".Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                /*Department.SETFILTER ("Group Description",'%1',"Group Description");
                    IF Department.FIND('-') THEN BEGIN

                      "Group Description":=Department."Group Description";
                       IF ("Group Description"<>'') AND ("Team Description"='') THEN BEGIN


                        VALIDATE(Group,Department."Group Code");
                         VALIDATE("Department Category",Department."Department Category");
                         VALIDATE("Department Cat. Description",Department."Department Categ.  Description");
                         VALIDATE(Sector,Department.Sector);
                         VALIDATE("Sector Description",Department."Sector  Description");
                         VALIDATE(Description,"Group Description");
                         VALIDATE("Team Description",'');
                               VALIDATE("Department Code",Department."Group Code");
                         END;
                 END;


                 IF "Group Description"='' THEN BEGIN
                   Group:='';
                   "Department Cat. Description":='';
                   "Department Category":='';
                   Sector:='';
                   "Sector Description":='';
                    "Department Code":='';
                 "Department Name":='';

                   END;*/




                Department.RESET;
                Department.SETFILTER("Group Description", '%1', "Group Description");
                Department.SETFILTER("Department Type", '%1', 4);
                IF Department.FINDFIRST THEN BEGIN
                    Team := Department."Team Code";
                    Sector := Department.Sector;
                    "Sector Description" := Department."Sector  Description";
                    "Department Category" := Department."Department Category";
                    "Department Cat. Description" := Department."Department Categ.  Description";
                    Group := Department."Group Code";
                    "Group Description" := Department."Group Description";
                    "Department Code" := Group;
                    "Team Description" := Department."Team Description";
                    "Sector Identity" := Department."Sector Identity";
                END
                ELSE BEGIN
                    Team := '';
                    "Department Code" := '';
                    Sector := '';
                    "Sector Description" := '';
                    "Department Category" := '';
                    "Department Cat. Description" := '';
                    Group := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Sector Identity" := 0;





                END;


                DVCheck.Reset();
                DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                DVCheck.SetFilter(Name, '%1', Rec.Sector);
                if not DVCheck.FindFirst() then begin
                    DVCheck.Init();
                    DVCheck."Dimension Code" := 'TC';
                    DVCheck.Code := Rec.Sector;
                    DVCheck.Name := copystr(Rec."Sector Description", 1, 50);
                    DVCheck.Status := DVCheck.Status::A;
                end;

                DVCheck.Reset();
                DVCheck.SetFilter(Name, '%1', '');
                if DVCheck.FindFirst() then
                    Rec.validate("Dimension  Name", Rec.Sector);

            end;
        }
        field(50305; "Organizational Affiliation"; Code[10])
        {
            Caption = 'Organizational Affiliation';
        }
        field(50315; "Org. Structure"; Code[10])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
        }
        field(50316; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            Editable = false;
            TableRelation = IF ("Team Description" = FILTER(<> '')) "Department temporary".Code WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                  "Team Description" = FIELD("Team Description"),
                                                                                                  "Team Description" = FILTER(<> ''))
            ELSE
            IF ("Group Description" = FILTER(<> ''),
                                                                                                           "Team Description" = FILTER('')) "Department temporary".Code WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                           "Team Description" = FILTER(''),
                                                                                                                                                                           "Group Description" = FIELD("Group Description"),
                                                                                                                                                                           "Group Description" = FILTER(<> ''))
            ELSE
            IF ("Department Cat. Description" = FILTER(<> ''),
                                                                                                                                                                                    "Group Description" = FILTER('')) "Department temporary".Code WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                                                                                                     "Group Description" = FILTER(''),
                                                                                                                                                                                                                                                     "Department Categ.  Description" = FIELD("Department Cat. Description"),
                                                                                                                                                                                                                                                     "Department Categ.  Description" = FILTER(<> ''))
            ELSE
            IF ("Sector Description" = FILTER(<> ''),
                                                                                                                                                                                                                                                              "Department Cat. Description" = FILTER('')) "Department temporary".Code WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                                                                                                                                                                                         "Sector  Description" = FILTER(<> ''),
                                                                                                                                                                                                                                                                                                                                         "Sector  Description" = FIELD("Sector Description"),
                                                                                                                                                                                                                                                                                                                                         "Department Categ.  Description" = FILTER(''));

            trigger OnValidate()
            begin

                CALCFIELDS("Department Name");


                Department.SETFILTER("ORG Shema", "Org. Structure");
                IF Department.FINDFIRST THEN BEGIN
                    Department.SETFILTER(Code, "Department Code");
                    IF Department.FINDFIRST THEN BEGIN
                        Department.CALCFIELDS(Municipality);

                        parent2 := Department."Timesheets administrator";
                        parent3 := Department."Timesheets administrator 2";
                        /*ORG.SETFILTER(Code,Department."ORG Dio");
                        IF ORG.FINDFIRST THEN BEGIN
                        "Department Address":=ORG.Address;
                        "Department City":=ORG.City;

                        END;*/

                        IF ((COMPANYNAME = 'SB') AND ("Starting Date" >= 20170901D)) THEN BEGIN
                            WPConnSetup.FINDFIRST();


                            /*CREATE(conn, TRUE, TRUE);

                            conn.Open('PROVIDER=SQLOLEDB;SERVER=HR\NAVDEMO;DATABASE=c0_intranet2;UID=intranet;PWD=DynamicsNAV16!');
                            /*conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                                      +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));*/

                            /* CREATE(comm, TRUE, TRUE);

                             lvarActiveConnection := conn;
                             comm.ActiveConnection := lvarActiveConnection;

                             comm.CommandText := 'dbo.DepatmentCode_Update';
                             comm.CommandType := 4;
                             comm.CommandTimeout := 0;


                             param := comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
                             comm.Parameters.Append(param);

                             param := comm.CreateParameter('@Parent2', 200, 1, 30, parent2);
                             comm.Parameters.Append(param);
                             param := comm.CreateParameter('@Parent3', 200, 1, 30, parent3);
                             comm.Parameters.Append(param);

                             param := comm.CreateParameter('@b1_desc', 200, 1, 50, "Sector Description");
                             comm.Parameters.Append(param);

                             param := comm.CreateParameter('@b1_reg', 200, 1, 50, "Department Category");
                             comm.Parameters.Append(param);

                             param := comm.CreateParameter('@b1_reg_desc', 200, 1, 50, "Department Cat. Description");
                             comm.Parameters.Append(param);

                             param := comm.CreateParameter('@stream_desc', 200, 1, 50, "Group Description");
                             comm.Parameters.Append(param);


                             param := comm.CreateParameter('@DepartmentCode', 200, 1, 50, "Department Code");
                             comm.Parameters.Append(param);



                             param := comm.CreateParameter('@Sector', 200, 1, 250, "Department Name");
                             comm.Parameters.Append(param);


                             comm.Execute;
                             conn.Close;
                             CLEAR(conn);
                             CLEAR(comm);*/
                        END;


                        IF ("Starting Date" >= 20180901D) THEN BEGIN

                            CALCFIELDS(Municipality);
                            Emp.RESET;
                            Emp.SETFILTER("No.", "Employee No.");
                            IF Emp.FINDFIRST THEN BEGIN
                                Emp."Org Municipality" := Municipality;
                                //Emp."Org Dio" := Department."ORG Dio";
                                Emp.MODIFY;
                            END;
                        END;


                        /*SB
                        IF ("Starting Date">=010917D) THEN BEGIN
                        EDF.SETFILTER("No.",'%1',"Employee No.");
                        IF EDF.FIND('-') THEN BEGIN
                          EDF.VALIDATE("No.","Employee No.");
                          EDF."Dimension Code":='ORG.JED';
                          CALCFIELDS("Phisical Org Dio");
                           DV.SETFILTER (Code,'%1',"Phisical Org Dio"+'-'+"Department Code");
                          IF NOT DV.FIND('-') THEN BEGIN
                            DV.INIT;
                            DV."Dimension Code":='ORG.JED';
                            DV.Code:="Phisical Org Dio"+'-'+"Department Code";
                            DV."Global Dimension No.":=1;
                          DV.INSERT;
                          END;
                          IF (("Department Code"<>'') AND ("Phisical Org Dio"<>'')) THEN
                          EDF."Dimension Value Code":="Phisical Org Dio"+'-'+"Department Code"
                          ELSE
                          EDF."Dimension Value Code":='';
                          EDF."Amount Distribution Coeff.":=1;
                          EDF.MODIFY;
                          END

                        ELSE BEGIN
                          EDF.INIT;
                          EDF.VALIDATE("No.","Employee No.");
                          EDF."Dimension Code":='ORG.JED';
                          CALCFIELDS("Phisical Org Dio");
                             DV.SETFILTER (Code,'%1',"Phisical Org Dio"+'-'+"Department Code");
                          IF NOT DV.FIND('-') THEN BEGIN
                            DV.INIT;
                            DV."Dimension Code":='ORG.JED';
                            DV.Code:="Phisical Org Dio"+'-'+"Department Code";
                               DV."Global Dimension No.":=1;
                          DV.INSERT;
                          END;
                          IF (("Department Code"<>'') AND ("Phisical Org Dio"<>'')) THEN
                          EDF."Dimension Value Code":="Phisical Org Dio"+'-'+"Department Code"
                          ELSE
                            EDF."Dimension Value Code":='';
                          EDF."Amount Distribution Coeff.":=1;
                          EDF.INSERT;
                        END;
                          CALCFIELDS("Org Dio");
                        "Default Dimension":="Phisical Org Dio"+'-'+"Department Code";*/

                        /*NK corrections

                        WDV.SETFILTER("Employee No.",'%1',"Employee No.");
                        WDV.SETFILTER(Active,'%1',TRUE);
                        IF WDV.FIND('-') THEN REPEAT
                        WDV."Department Name":="Department Name";
                        WDV."Department Code":="Department Code";
                        CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                        WDV."Position Description":="Position Description";
                        WDV."B-1 (with regions) Description":="B-1 (with regions) Description";
                        WDV."B-1 Description":="B-1 Description";
                        WDV."Stream Description":="Stream Description";
                        SegmentationGroupWD.RESET;
                        SegmentationGroupWD.SETFILTER("Position No.",'%1',WDV."Position Code");
                        SegmentationGroupWD.SETFILTER("Segmentation Name",'%1',WDV."Position Description");
                        SegmentationGroupWD.SETFILTER(Coefficient,'<>%1',0);
                        SegmentationGroupWD.SETFILTER("Ending Date",'%1',0D);
                        IF SegmentationGroupWD.FIND('+') THEN
                            WDV."Management Level":=FORMAT(SegmentationGroupWD."Management Level");
                        WDV.MODIFY;
                        UNTIL WDV.NEXT=0;

                        WDVM.SETFILTER("Manager 1",'%1',"Employee No.");
                        WDVM.SETFILTER(Active,'%1',TRUE);
                        IF WDVM.FIND('-') THEN REPEAT
                        WDVM."Manager Department Code":="Department Code";
                        WDVM."Manager Department Name":="Department Name";
                        CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                        WDVM."Manager Position Description":="Position Description";
                        WDVM."Man. B-1 (with regions) Desc":="B-1 (with regions) Description";
                        WDVM."Manager B-1 Description":="B-1 Description";
                        WDVM."Manager Stream Description":="Stream Description";
                        SegmentationGroupWDM.RESET;
                        SegmentationGroupWDM.SETFILTER("Position No.",'%1',WDVM."Position Code");
                        SegmentationGroupWDM.SETFILTER("Segmentation Name",'%1',WDVM."Position Description");
                        SegmentationGroupWDM.SETFILTER(Coefficient,'<>%1',0);
                        SegmentationGroupWDM.SETFILTER("Ending Date",'%1',0D);
                        IF SegmentationGroupWDM.FIND('+') THEN
                            WDVM."Manager1 Management Level":=FORMAT(SegmentationGroupWDM."Management Level");
                        WDVM.MODIFY;
                        UNTIL WDVM.NEXT=0;

                        WDVR.SETFILTER("Reported By",'%1',"Employee No.");
                        WDVR.SETFILTER(Active,'%1',TRUE);
                        IF WDVR.FIND('-') THEN REPEAT
                        WDVR."Reported By Department Name":="Department Name";
                        WDVR."Reported By Department Code":="Department Code";
                        CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                        WDVR."Rep. Position Description":="Position Description";
                        WDVR."Rep.  B-1 (with regions) Desc":="B-1 (with regions) Description";
                        WDVR."Reported By B-1 Description":="B-1 Description";
                        WDVR."Reported By Stream Description":="Stream Description";
                        SegmentationGroupWDR.RESET;
                        SegmentationGroupWDR.SETFILTER("Position No.",'%1',WDVR."Position Code");
                        SegmentationGroupWDR.SETFILTER("Segmentation Name",'%1',WDVR."Position Description");
                        SegmentationGroupWDR.SETFILTER(Coefficient,'<>%1',0);
                        SegmentationGroupWDR.SETFILTER("Ending Date",'%1',0D);
                        IF SegmentationGroupWDR.FIND('+') THEN
                            WDVR."Reported By Management Level":=FORMAT(SegmentationGroupWDR."Management Level");
                        WDVR.MODIFY;
                        UNTIL WDVR.NEXT=0;

                        CM.SETFILTER("Comission Member No.",'%1',"Employee No.");
                        CM.SETFILTER(Active,'%1',TRUE);
                        IF CM.FIND('-') THEN REPEAT
                        CM."Department Name":="Department Name";
                        CM."Department Code":="Department Code";
                        CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                        CM."Position Description":="Position Description";
                        CM."B-1 (with regions) Desc":="B-1 (with regions) Description";
                        CM."B-1 Description":="B-1 Description";
                        CM."Stream Description":="Stream Description";
                        SegmentationGroupCM.RESET;
                        SegmentationGroupCM.SETFILTER("Position No.",'%1',"Position Code");
                        SegmentationGroupCM.SETFILTER("Segmentation Name",'%1',CM."Position Description");
                        SegmentationGroupCM.SETFILTER(Coefficient,'<>%1',0);
                        SegmentationGroupCM.SETFILTER("Ending Date",'%1',0D);
                        IF SegmentationGroupCM.FIND('+') THEN
                            CM."Management Level":=FORMAT(SegmentationGroupCM."Management Level");
                        CM.MODIFY;
                        UNTIL CM.NEXT=0; NK corrections*/
                    END;
                END;
                //END;

            end;
        }
        field(50317; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            Editable = false;
            TableRelation = "Position Menu temporary".Code WHERE("Org. Structure" = FIELD("Org. Structure"));
        }
        field(50318; "Position ID"; Code[10])
        {
            Caption = 'Position ID';
        }
        field(50319; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            Editable = true;
            TableRelation = "Position Menu temporary".Description WHERE("Org. Structure" = FIELD("Org. Structure"),
            "Department Code" = field("Department Code")
                                                                    );

            trigger OnValidate()
            var
                PosMe: Record "Position Menu temporary";
            begin
                PosMe.Reset();
                PosMe.SetFilter(Description, '%1', Rec."Position Description");
                PosMe.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                PosMe.SetFilter("Department Code", '%1', Rec."Department Code");
                if PosMe.FindFirst() then begin

                    IF PosMe."Management Level" = PosMe."Management Level"::CEO THEN BEGIN
                        Rec."Order By Managment" := 1;

                    END;
                    IF PosMe."Management Level" = PosMe."Management Level"::Exe THEN BEGIN
                        Rec."Order By Managment" := 2;

                    END;
                    IF PosMe."Management Level" = PosMe."Management Level"::Sector THEN BEGIN
                        "Order By Managment" := 3;

                    END;
                    IF PosMe."Management Level" = PosMe."Management Level"::"Department Category" THEN BEGIN
                        "Order By Managment" := 4;

                    END;
                    IF PosMe."Management Level" = PosMe."Management Level"::Group THEN BEGIN
                        "Order By Managment" := 5;

                    END;
                    IF PosMe."Management Level" = PosMe."Management Level"::E THEN BEGIN
                        "Order By Managment" := 6;

                    END;

                    IF PosMe."Management Level" = PosMe."Management Level"::Empty THEN BEGIN
                        "Order By Managment" := 7;
                    end;




                    "Position Code" := PosMe.Code;
                    Rec."Position Coefficient for Wage" := PosMe."Position Coefficient for Wage";
                    Rec."Position complexity" := PosMe."Position complexity";
                    Rec."Position Responsibility" := PosMe."Position complexity";
                    Rec."Workplace conditions" := PosMe."Workplace conditions"
                end
                else begin
                    "Position Code" := '';
                end;


                IF "Position Description" <> '' THEN BEGIN

                    DVCheck.Reset();
                    DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                    DVCheck.SetFilter(Name, '%1', Rec.Sector);
                    if not DVCheck.FindFirst() then begin
                        DVCheck.Init();
                        DVCheck."Dimension Code" := 'TC';
                        DVCheck.Code := Rec.Sector;
                        DVCheck.Name := copystr(Rec."Sector Description", 1, 50);
                        DVCheck.Status := DVCheck.Status::A;
                    end;

                    DVCheck.Reset();
                    DVCheck.SetFilter(Name, '%1', '');
                    if DVCheck.FindFirst() then
                        Rec.validate("Dimension  Name", Rec.Sector);

                END
                ELSE BEGIN
                    "Position Code" := '';
                    "Position Description" := '';
                    "Dimension  Name" := '';
                    "Dimension Value Code" := '';
                    SectorTemp.RESET;
                    SectorTemp.SETFILTER(Description, '%1', Rec."Sector Description");
                    IF SectorTemp.FINDFIRST THEN
                        "Sector Identity" := SectorTemp.Identity;
                END;
                // Rec."Difference Org/Position":=FALSE;
            end;
        }
        field(50326; "Org Dio"; Code[10])
        {
            Caption = 'Org. Part';
            TableRelation = "ORG Dijelovi".Code;

            trigger OnValidate()
            begin


                IF "Org Dio" <> '' THEN BEGIN
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                    OrgDijelovi.SETFILTER(Code, '%1', "Org Dio");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        // VALIDATE("GF rada code",OrgDijelovi.GF);
                        OrgDijelovi.SETFILTER(GF, "GF rada code");
                        IF OrgDijelovi.FINDFIRST THEN BEGIN
                            "Phisical Department Desc" := OrgDijelovi.City;
                            //"Regional Head Office":=OrgDijelovi."Regionalni Head Office";
                            // "Branch Agency":=OrgDijelovi."Filijala Agencije";
                            Municipality := OrgDijelovi."Municipality Code";
                            EmpOrg.RESET;
                            EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                            IF EmpOrg.FIND('-') THEN BEGIN
                                EmpOrg."Org Municipality" := Municipality;
                                EmpOrg."Org Entity Code" := OrgDijelovi."Entity Code";
                                EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";
                                EmpOrg.MODIFY;
                            END;

                        END;
                    END;
                END
                ELSE BEGIN
                    //"Regional Head Office":='';
                    // "Branch Agency":='';
                    "Phisical Department Desc" := '';
                    //VALIDATE("GF rada","GF rada");
                END;
            end;
        }
        field(50327; "Phisical Org Dio"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department."ORG Dio" WHERE(Code = FIELD("Org Dio")));
            Caption = 'Org. Part';


            TableRelation = Department."ORG Dio";
        }
        field(50328; "Phisical Department Desc"; Text[30])
        {
            Caption = 'Department Description';

            trigger OnValidate()
            begin
                /*NK01 start
                Department.SETFILTER("ORG Shema","Org. Structure");
                IF Department.FINDFIRST THEN BEGIN
                Department.SETFILTER(Code,"Phisical Department Code");
                IF Department.FINDFIRST THEN BEGIN
                
                //sd01 end
                EDF.SETFILTER("No.",'%1',"Employee No.");
                IF EDF.FIND('-') THEN BEGIN
                  EDF.VALIDATE("No.","Employee No.");
                  EDF."Dimension Code":='ORG.JED';
                  CALCFIELDS("Org Dio");
                   DV.SETFILTER (Code,'%1',Department."ORG Dio"+'-'+"Phisical Department Code");
                  IF NOT DV.FIND('-') THEN BEGIN
                    DV.INIT;
                    DV."Dimension Code":='ORG.JED';
                    DV.Code:=Department."ORG Dio"+'-'+"Phisical Department Code";
                  DV.INSERT;
                  END;
                  EDF."Dimension Value Code":=Department."ORG Dio"+'-'+"Phisical Department Code";
                  EDF."Amount Distribution Coeff.":=1;
                  EDF.MODIFY;
                  END
                
                ELSE BEGIN
                  EDF.INIT;
                  EDF.VALIDATE("No.","Employee No.");
                  EDF."Dimension Code":='ORG.JED';
                  CALCFIELDS("Org Dio");
                  DV.SETFILTER (Code,'%1',Department."ORG Dio"+'-'+"Phisical Department Code");
                  IF NOT DV.FIND('-') THEN BEGIN
                    DV.INIT;
                    DV."Dimension Code":='ORG.JED';
                    DV.Code:=Department."ORG Dio"+'-'+"Phisical Department Code";
                  DV.INSERT;
                  END;
                  EDF."Dimension Value Code":=Department."ORG Dio"+'-'+"Phisical Department Code";
                  EDF."Amount Distribution Coeff.":=1;
                  EDF.INSERT;
                END;
                END;
                END;
                NK01 END*/
                IF (("Starting Date" >= 20170901D)) THEN BEGIN
                    EDF.SETFILTER("No.", '%1', "Employee No.");
                    IF EDF.FIND('-') THEN BEGIN
                        EDF.VALIDATE("No.", "Employee No.");
                        EDF."Dimension Code" := 'ORG.JED';
                        CALCFIELDS("Phisical Org Dio");
                        DV.SETFILTER(Code, '%1', "Phisical Org Dio" + '-' + "Department Code");
                        IF NOT DV.FIND('-') THEN BEGIN
                            DV.INIT;
                            DV."Dimension Code" := 'ORG.JED';
                            DV.Code := "Phisical Org Dio" + '-' + "Department Code";
                            DV."Global Dimension No." := 1;
                            DV.INSERT;
                        END;
                        IF (("Department Code" <> '') AND ("Phisical Org Dio" <> '')) THEN
                            EDF."Dimension Value Code" := "Phisical Org Dio" + '-' + "Department Code"
                        ELSE
                            EDF."Dimension Value Code" := '';
                        EDF."Amount Distribution Coeff." := 1;
                        EDF.MODIFY;
                    END

                    ELSE BEGIN
                        EDF.INIT;
                        EDF.VALIDATE("No.", "Employee No.");
                        EDF."Dimension Code" := 'ORG.JED';
                        CALCFIELDS("Phisical Org Dio");
                        DV.SETFILTER(Code, '%1', "Phisical Org Dio" + '-' + "Department Code");
                        IF NOT DV.FIND('-') THEN BEGIN
                            DV.INIT;
                            DV."Dimension Code" := 'ORG.JED';
                            DV.Code := "Phisical Org Dio" + '-' + "Department Code";
                            DV."Global Dimension No." := 1;
                            DV.INSERT;
                        END;
                        IF (("Department Code" <> '') AND ("Phisical Org Dio" <> '')) THEN
                            EDF."Dimension Value Code" := "Phisical Org Dio" + '-' + "Department Code"
                        ELSE
                            EDF."Dimension Value Code" := '';
                        EDF."Amount Distribution Coeff." := 1;
                        EDF.INSERT;
                    END;
                END;

            end;
        }
        field(50329; "Employee Status"; enum "Employee Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';


        }
        field(50330; "Phisical Org Dio Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Description WHERE(Code = FIELD("Phisical Org Dio")));
            Caption = 'Org. Part Name';

        }
        field(50331; "Total Netto"; Decimal)
        {
            Caption = 'Total Netto';
        }
        field(50332; "Org Dio Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Description WHERE(Code = FIELD("Org Dio"),
                                                                   GF = FIELD("GF rada code")));
            Caption = 'Org. Part Name';

        }
        field(50333; "Municipality Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Municipality.Name WHERE(Code = FIELD("Org Municipality"), type = filter(regular)));
            Caption = 'Municipality Name';

            Editable = false;

        }
        field(50334; "Percentage of Fixed Part"; Decimal)
        {
            Caption = 'Percentage of Fixed Part';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50335; "Fixed Amount Brutto"; Decimal)
        {
            Caption = 'Fixed Amount Brutto';
        }
        field(50338; "Default Dimension"; Code[20])
        {
            Caption = 'Default Dimension';
        }
        field(50339; "Fixed Amount Netto"; Decimal)
        {
            Caption = 'Fixed Amount Netto';
        }
        field(50340; "Fixed Amount Total Netto"; Decimal)
        {
            Caption = 'Fixed Amount Total Netto';
        }
        field(50341; "Variable Amount Brutto"; Decimal)
        {
            Caption = 'Manager Addition Brutto';
        }
        field(50342; "Variable Amount Netto"; Decimal)
        {
            Caption = 'Fixed Amount Netto';
        }
        field(50343; "Manager Addition Total Netto"; Decimal)
        {
            Caption = 'Manager Addition Total Netto';
        }
        field(50344; "Percentage of Variable"; Decimal)
        {
            Caption = 'Percentage of Fixed Part';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50345; Import; Boolean)
        {
        }
        field(50346; "Wage Change"; Option)
        {
            Caption = 'Wage Change';
            OptionCaption = '  ,Change Position Coefficient';
            OptionMembers = "  ","Change Position Coefficient";
        }
        field(50347; Contract; Boolean)
        {
            Caption = 'Contract';

            trigger OnValidate()
            begin
                EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");


                Contract := TRUE;
            end;
        }
        field(50348; "Report Date"; Date)
        {
            Caption = 'Report Date';
        }
        field(50349; "Max Contract Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Starting Date" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Max Contract Date';

        }
        field(50350; "Definite Contract Start Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("Employee Contract Ledger"."Starting Date" WHERE("Contract Type" = FILTER('1'),
                                                                                "Employee No." = FIELD("Employee No.")));

        }
        field(50351; "Max Position Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Ending Date" WHERE("Employee No." = FIELD("Employee No."),
                                                                              "Position Code" = FIELD("Position Code")));
            Caption = 'Max Contract Date';

        }
        field(50352; "Report Ending Date"; Date)
        {
            Caption = 'Report Ending Date';
        }
        field(50353; "Agency Name"; Text[30])
        {
            Caption = 'Agency Name';
        }
        field(50354; Gender; enum "Employee Gender")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Gender WHERE("No." = FIELD("Employee No.")));
            Caption = 'Gender';


        }
        field(50355; "Birth Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Birth Date" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Birth Date';

        }
        field(50356; Age; Integer)
        {
            Caption = 'Age';
        }
        field(50357; "Org Municipality"; Code[20])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code for salary" WHERE(Code = FIELD("Org Dio"),
                                                                                      GF = FIELD("GF rada code")));
            Caption = 'Municipality';
            Editable = false;

        }
        field(50358; "Max Department"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Department Code" WHERE("Employee No." = FIELD("Employee No."),
                                                                                  "Org. Structure" = FIELD("Org. Structure")));

        }
        field(50359; Team; Code[30])
        {
            Caption = 'Team';
            Editable = false;
            TableRelation = "Team temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"),
                                                         Name = FIELD("Team Description"));

            trigger OnValidate()
            begin

                //TeamRec.SETFILTER("Org Shema",'%1',"Org Shema");
            end;
        }
        field(50360; "Team Description"; Text[250])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = "Team temporary".Name WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                Department.SETFILTER("Team Description", '%1', "Team Description");
                IF Department.FIND('-') THEN BEGIN

                    "Team Description" := Department."Team Description";
                    IF "Team Description" <> '' THEN BEGIN
                        Department.RESET;
                        Department.SETFILTER("Team Description", '%1', "Team Description");
                        IF Department.FINDFIRST THEN BEGIN
                            Team := Department."Team Code";
                            Sector := Department.Sector;
                            "Sector Description" := Department."Sector  Description";
                            "Department Category" := Department."Department Category";
                            "Department Cat. Description" := Department."Department Categ.  Description";
                            Group := Department."Group Code";
                            "Group Description" := Department."Group Description";
                            "Department Code" := Team;
                            "Sector Identity" := Department."Sector Identity";
                        END
                        ELSE BEGIN
                            Team := '';
                            "Department Code" := '';
                            Sector := '';
                            "Sector Description" := '';
                            "Department Category" := '';
                            "Department Cat. Description" := '';
                            Group := '';
                            "Group Description" := '';
                            "Sector Identity" := 0;
                            /*  VALIDATE(Team,Department."Team Code");
                              VALIDATE("Department Code",Department."Team Code");
                              VALIDATE(Group,Department."Group Code");
                              VALIDATE("Group Description",Department."Group Description");
                              VALIDATE("Department Category",Department."Department Category");
                              VALIDATE("Department Cat. Description",Department."Department Categ.  Description");
                              VALIDATE(Sector,Department.Sector);
                              VALIDATE("Sector Description",Department."Sector  Description");
                              VALIDATE(Description,"Team Description");*/
                        END;

                    END;
                END;
                IF "Team Description" = '' THEN BEGIN
                    Team := '';
                    "Department Cat. Description" := '';
                    "Department Category" := '';
                    Group := '';
                    "Group Description" := '';
                    Sector := '';
                    "Sector Description" := '';
                    "Department Code" := '';
                    "Department Name" := '';

                END;


                DVCheck.Reset();
                DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                DVCheck.SetFilter(Name, '%1', Rec.Sector);
                if not DVCheck.FindFirst() then begin
                    DVCheck.Init();
                    DVCheck."Dimension Code" := 'TC';
                    DVCheck.Code := Rec.Sector;
                    DVCheck.Name := copystr(Rec."Sector Description", 1, 50);
                    DVCheck.Status := DVCheck.Status::A;
                end;

                DVCheck.Reset();
                DVCheck.SetFilter(Name, '%1', '');
                if DVCheck.FindFirst() then
                    Rec.validate("Dimension  Name", Rec.Sector);
            END;


        }
        field(50361; "Management Level"; enum "Management Level")
        {
            Caption = 'Management Level';

        }
        field(50362; "Agremeent Code"; Code[10])
        {
            Caption = 'Agremeent Code';
            Editable = false;
        }
        /*    field(50363; "Agreement Name"; Text[200])
            {
                Caption = 'Agreement Name';
                TableRelation = "Document Register"."Document Description" WHERE(Group = FIELD("Contract Type Name"));
            }*/
        field(50364; "Contract Type Name"; Text[100])
        {
            Caption = 'Contract Type Description';
            TableRelation = "Employment Contract".Description;

            trigger OnValidate()
            begin

                IF "Contract Type Name" <> '' THEN BEGIN
                    EmploymentContract.SETFILTER(Description, '%1', "Contract Type Name");
                    IF EmploymentContract.FINDFIRST THEN BEGIN
                        //VALIDATE("Contract Type",EmploymentContract.Code)
                        "Contract Type" := EmploymentContract.Code;
                    END;
                END
                ELSE BEGIN
                    // VALIDATE("Contract Type",'');
                    "Contract Type" := '';
                END;



                ECL.SETFILTER("Employee No.", "Employee No.");
                IF ECL.FINDLAST THEN BEGIN
                    Emp.RESET;
                    Emp.SETFILTER("No.", "Employee No.");
                    IF Emp.FINDFIRST() THEN BEGIN
                        Emp."Emplymt. Contract Code" := "Contract Type";
                        Emp.MODIFY;
                    END;
                END;



                /*IF "Contract Type"<>'' THEN BEGIN
                 IF "Contract Type"='2' THEN BEGIN
                   "Testing Period":=TRUE;
                   "Testing Period Starting Date":=WORKDATE;
                   END
                   ELSE
                 IF "Contract Type"='5' THEN BEGIN
                  "Testing Period":=TRUE;
                   "Testing Period Starting Date":=WORKDATE;
                   END
                   ELSE BEGIN
                   "Testing Period":=FALSE;
                   "Testing Period Starting Date":=0D;
                    "Testing Period Ending Date":=0D;
                     "Probation Days":=0;
                  "Probation Months":=0;
                     END;
                   END;
                    */

            end;
        }
        field(50365; "Key Function"; Boolean)
        {
            Caption = 'Key Function';
        }
        field(50366; "IS Risk Materiality"; Option)
        {
            OptionMembers = " ","Less Material",Material;
        }
        field(50370; "Percentage of Fixed"; Decimal)
        {
            Caption = 'Percentage of Fixed Part';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50371; "Key Function From"; Date)
        {
            Caption = 'Key Function From';

            trigger OnValidate()
            begin
                IF "Control Function To" <> 0D THEN BEGIN
                    IF "Control Function From" = 0D THEN
                        ERROR(Text000);
                    IF "Control Function To" < "Control Function From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(50372; "Key Function To"; Date)
        {
            Caption = 'Key Function To';

            trigger OnValidate()
            begin
                IF "Control Function To" <> 0D THEN BEGIN
                    IF "Control Function From" = 0D THEN
                        ERROR(Text000);
                    IF "Control Function To" < "Control Function From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(50373; "Regionalni Head Office"; Option)
        {
            Caption = 'Regional office/Head Office';
            OptionCaption = ' ,Regional office,Head office';
            OptionMembers = " ","Regional Head Office","Head office";
        }
        field(50374; "Branch Agency"; Option)
        {
            Caption = 'Branch Agency';
            Editable = true;
            OptionCaption = ' ,Branch,Agency';
            OptionMembers = " ",Branch,Agency;

            trigger OnValidate()
            begin
                IF "Branch Agency" = 0 THEN BEGIN
                    VALIDATE("Org Unit Name", '');
                    VALIDATE("GF of work Description", '');
                END;
                IF "Branch Agency" = 1 THEN BEGIN
                    VALIDATE("Org Unit Name", '');
                    VALIDATE("Org Unit Name", "Org Unit Name");
                END;
                IF "Branch Agency" = 2 THEN BEGIN
                    VALIDATE("GF of work Description", '');
                    VALIDATE("GF of work Description", "GF of work Description");
                END;
            end;
        }
        field(50375; "Work Days"; Integer)
        {
            Caption = 'Work Days on definitely';
            Editable = false;
        }
        field(50376; "Work Months"; Integer)
        {
            Caption = 'Work Months on definitely';
            Editable = false;
        }
        field(50378; "Date of sending notification"; Date)
        {
            Caption = 'Date of sending notification';
        }
        field(50379; "Notification send"; Boolean)
        {
            Caption = 'Notification send';

            trigger OnValidate()
            begin
                IF "Notification send" = TRUE THEN
                    "Date of sending notification" := WORKDATE
                ELSE
                    "Date of sending notification" := 0D;
            end;
        }
        field(50380; "Temporary disposition"; Boolean)
        {
            Caption = 'Temporary disposition';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Contract Type" = '-1') OR ("Contract Type" = '4') OR ("Contract Type" = '5')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(50381; "Employee Benefits"; Integer)
        {
            CalcFormula = Count("Misc. article information" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Employee Benefits';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50382; "Internal ID"; Integer)
        {
            CalcFormula = Lookup(Employee."Internal ID" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Internal ID';
            FieldClass = FlowField;
        }
        field(50383; "GF rada code"; Code[10])
        {
            Caption = 'GF of works';
            TableRelation = "ORG Dijelovi".GF;

            trigger OnValidate()
            begin

                IF ("GF rada code" <> '') AND ("Org Dio" = '') THEN BEGIN
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                    OrgDijelovi.SETFILTER(GF, "GF rada code");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        "Phisical Department Desc" := OrgDijelovi.City;
                        "Regionalni Head Office" := OrgDijelovi."Regionalni Head Office";
                        Municipality := OrgDijelovi."Municipality Code";
                        EmpOrg.RESET;
                        EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                        IF EmpOrg.FIND('-') THEN BEGIN
                            EmpOrg."Org Municipality" := Municipality;
                            EmpOrg."Org Entity Code" := OrgDijelovi."Entity Code";
                            EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";
                            EmpOrg.MODIFY;
                        END;
                    END;
                END
                ELSE BEGIN
                    "Regionalni Head Office" := 0;
                    "Branch Agency" := 0;
                    "Phisical Department Desc" := '';
                END;
            end;
        }
        field(50384; "Work Years"; Integer)
        {
            Caption = 'Work Years on definitely';
            Editable = false;
        }
        field(50385; "Probation Year"; Integer)
        {
            Caption = 'Probation Years';
            Editable = false;
        }
        field(50386; Region; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Region WHERE(Code = FIELD("Org Dio"),
                                                              GF = FIELD("GF rada code")));
            Caption = 'Region';
            Editable = false;

        }
        field(50387; "Org Entity Code"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Entity Code" WHERE(Code = FIELD("Org Dio"),
                                                                     GF = FIELD("GF rada code")));
            Caption = 'Org Entity Code';
            Editable = false;

        }
        field(50388; "Municipality Code for salary"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code for salary" WHERE(Code = FIELD("Org Dio"),
                                                                                      GF = FIELD("GF rada code")));
            Caption = 'Municipality Code for salary';

        }
        field(50389; "Org Unit Name"; Text[100])
        {
            Caption = 'Org Unit Name';

            TableRelation = "ORG Dijelovi".Description WHERE("Branch Agency" = FIELD("Branch Agency"),
                                                              Code = FILTER(<> ''));


            trigger OnValidate()
            begin
                IF "Org Unit Name" <> '' THEN BEGIN

                    /*IF "Org Dio"<>'' THEN BEGIN*/
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                    /* OrgDijelovi.SETFILTER(Code,'%1',"Org Dio");*/
                    OrgDijelovi.SETFILTER(Description, '%1', "Org Unit Name");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        //VALIDATE("GF rada code",OrgDijelovi.GF);
                        "GF rada code" := OrgDijelovi.GF;
                        "GF of work Description" := '';
                        //VALIDATE("GF of work Description",OrgDijelovi.Description);
                        OrgDijelovi.SETFILTER(GF, "GF rada code");
                        IF OrgDijelovi.FINDFIRST THEN BEGIN
                            "Org Dio" := OrgDijelovi.Code;
                            "Phisical Department Desc" := OrgDijelovi.City;
                            "Regionalni Head Office" := OrgDijelovi."Regionalni Head Office";
                            //"Branch Agency":=OrgDijelovi."Branch Agency";
                            Municipality := OrgDijelovi."Municipality Code";
                            EmpOrg.RESET;
                            EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                            IF EmpOrg.FIND('-') THEN BEGIN
                                EmpOrg.Region := OrgDijelovi.Region;
                                EmpOrg."Org Municipality" := OrgDijelovi."Municipality Code of agency";
                                EmpOrg."Org Entity Code" := OrgDijelovi."Entity Code";
                                EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";
                                IF OrgDijelovi."Entity Code" = 'FBIH'
                                  THEN
                                    EmpOrg."Contribution Category Code" := 'FBIH';
                                IF ((OrgDijelovi."Entity Code" = 'RS') AND (EmpOrg."Entity Code CIPS" = 'FBIH'))
                                 THEN
                                    EmpOrg."Contribution Category Code" := 'RS';
                                IF ((OrgDijelovi."Entity Code" = 'FBIH') AND (EmpOrg."Entity Code CIPS" = 'RS'))
                                 THEN
                                    EmpOrg."Contribution Category Code" := 'FIHRS';
                                IF ((OrgDijelovi."Entity Code" = 'RS') AND (EmpOrg."Entity Code CIPS" = 'RS'))
                                 THEN
                                    EmpOrg."Contribution Category Code" := 'RS';
                                IF EmpOrg."Entity Code CIPS" = 'BD'
                                THEN
                                    EmpOrg."Contribution Category Code" := 'BDPIOFBIH';
                                EmpOrg.MODIFY;
                            END;
                        END;
                    END;
                END
                ELSE BEGIN
                    "Regionalni Head Office" := 0;
                    "Phisical Department Desc" := '';
                    "GF of work Description" := '';
                    "GF rada code" := '';
                    "Org Dio" := '';
                    VALIDATE("GF of work Description", "GF of work Description");
                    EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                    IF EmpOrg.FIND('-') THEN BEGIN

                        EmpOrg."Org Municipality" := '';
                        EmpOrg."Municipality Code for salary" := '';
                        EmpOrg."Org Entity Code" := '';
                        EmpOrg.Region := 0;
                        IF OrgDijelovi."Entity Code" = ''
                      THEN
                            EmpOrg."Contribution Category Code" := '';
                        EmpOrg.MODIFY;
                    END;
                END;

            end;
        }
        field(50390; "GF of work Description"; Text[100])
        {
            Caption = 'GF of works';
            TableRelation = "ORG Dijelovi".Description WHERE("Branch Agency" = FIELD("Branch Agency"),
                                                              Code = FILTER(''));

            trigger OnValidate()
            begin

                IF ("GF of work Description" <> '') AND ("Org Unit Name" = '') THEN BEGIN

                    /*IF ("GF rada"<>'') AND ("Org Dio"='') THEN BEGIN*/
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                    /*OrgDijelovi.SETFILTER(GF,"GF rada");*/
                    OrgDijelovi.SETFILTER(Description, "GF of work Description");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        "GF rada code" := OrgDijelovi.GF;
                        "Phisical Department Desc" := OrgDijelovi.City;

                        Municipality := OrgDijelovi."Municipality Code";
                        "Regionalni Head Office" := OrgDijelovi."Regionalni Head Office";
                        //"Branch Agency":=OrgDijelovi."Branch Agency";
                        EmpOrg.RESET;
                        EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                        IF EmpOrg.FIND('-') THEN BEGIN
                            EmpOrg.Region := OrgDijelovi.Region;
                            EmpOrg."Org Municipality" := OrgDijelovi."Municipality Code of agency";
                            EmpOrg."Org Entity Code" := OrgDijelovi."Entity Code";
                            EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";

                            EmpOrg.MODIFY;
                        END;
                    END;
                END
                ELSE BEGIN
                    "Regionalni Head Office" := 0;
                    "Phisical Department Desc" := '';
                    "GF of work Description" := '';
                    "GF rada code" := '';
                    EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                    IF EmpOrg.FIND('-') THEN BEGIN
                        EmpOrg."Org Municipality" := '';
                        EmpOrg."Municipality Code for salary" := '';
                        EmpOrg."Org Entity Code" := '';
                        EmpOrg.Region := 0;

                        IF OrgDijelovi."Entity Code" = ''
                      THEN
                            EmpOrg."Contribution Category Code" := '';
                        EmpOrg.MODIFY;
                    END;
                END;

            end;
        }
        field(50391; Email; Text[100])
        {
            CalcFormula = Lookup(Employee."Company E-Mail" WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(50392; "Order By"; Integer)
        {
        }
        field(50393; "BJF/GJF"; Option)
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Position."BJF/GJF" WHERE(Code = FIELD("Position Code")));
            Caption = 'BJF/GJF';

            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;
        }
        field(50395; "Attachment No."; Integer)
        {
        }
        field(50396; "Sent Mail Employment"; Boolean)
        {
        }
        field(50397; "Sent Mail Termination"; Boolean)
        {
        }
        field(50399; "Sent Mail Duration"; Boolean)
        {
        }
        field(50400; "Sent Mail Change Pos"; Boolean)
        {
        }
        field(50401; "Comment for contract"; Text[150])
        {
        }
        field(50402; "Other Attachment No."; Integer)
        {
        }
        field(50403; "Certifications and solutions C"; Code[10])
        {
            Caption = 'Certifications and Solutions Code';
        }
        /*     field(50404; "Cert and solu name"; Text[90])
             {
                 Caption = 'Certifications and Solutions';
                 TableRelation = "Other Document Register"."Document Description" WHERE("Show Template" = FILTER(TRUE));
             }*/
        field(50405; Change; Boolean)
        {
            Caption = 'Change';
        }
        field(50407; "Change other documents"; Boolean)
        {
            Caption = 'Change';
        }
        field(50408; "Org Modification Date"; Date)
        {
        }
        field(50409; "Number of protocol for documen"; Text[30])
        {
            Caption = 'Number of protocols for all documents';
        }
        field(50410; "Number for Contract"; Integer)
        {
            Caption = 'Number for Contract';
        }
        field(50411; "Changing Position"; Boolean)
        {
            Caption = 'Changing Position';

            trigger OnValidate()
            var
                UpdateDep: Report "Update dep";
            begin

                ORGShema.RESET;
                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                IF ORGShema.FINDLAST THEN BEGIN
                    IF ("Changing Position" = TRUE) AND (ORGShema."Change Org" = FALSE) THEN BEGIN
                        /* ORGShema.RESET;
                         ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                         IF ORGShema.FINDLAST THEN BEGIN
                             SectorOrginal.RESET;
                             SectorOrginal.SETFILTER("Org Shema", '%1', ORGShema.Code);
                             IF NOT SectorOrginal.FINDFIRST THEN BEGIN
                                 IF SectorTemp.FINDSET THEN
                                     REPEAT
                                         SectorOrginal.INIT;
                                         SectorOrginal.TRANSFERFIELDS(SectorTemp);
                                         OrgSNew.RESET;
                                         OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                         IF OrgSNew.FINDFIRST THEN BEGIN
                                             SectorOrginal."Last Date Modified" := OrgSNew."Date From";
                                             SectorOrginal."Operator No." := OrgSNew."Operator No.";
                                         END;

                                         //ovdje da pronađem id za gps ako postoji




                                         SectorParent22.RESET;
                                         SectorParent22.SETFILTER("ORG Shema", '%1', SectorTemp."Org Shema");
                                         SectorParent22.SETFILTER(Sector, '%1', COPYSTR(SectorTemp.Code, 1, 2));
                                         SectorParent22.SETFILTER("Management Level", '%1|%2|%3', SectorParent22."Management Level"::CEO, SectorParent22."Management Level"::Exe, SectorParent22."Management Level"::Sector);
                                         SectorParent22.SETCURRENTKEY("ORG Shema");
                                         SectorParent22.ASCENDING(FALSE);
                                         IF SectorParent22.FINDFIRST THEN BEGIN
                                             SectorOrginal.Parent := SectorParent22."Sector  Description";
                                         END
                                         ELSE BEGIN
                                             SectorOrginal.Parent := '';
                                         END;

                                         SectorParent2.RESET;
                                         SectorParent2.SETFILTER("Org Shema", '<>%1', SectorTemp."Org Shema");
                                         SectorParent2.SETFILTER(Code, '%1', SectorOrginal.Code);
                                         SectorParent2.SETFILTER(Description, '%1', SectorOrginal.Description);
                                         SectorParent2.SETFILTER(Parent, '%1', SectorOrginal.Parent);
                                         IF SectorParent2.FINDFIRST THEN BEGIN
                                             SectorOrginal."ID for GPS" := SectorParent2."ID for GPS";
                                             SectorOrginal.Ispis := FALSE;
                                         END
                                         ELSE BEGIN
                                             SectorOrginal."ID for GPS" := 0;
                                             SectorOrginal.Ispis := FALSE;
                                         END;

                                         //ID za gps završava

                                         SectorOrginal1.SETFILTER(Code, '%1', SectorOrginal.Code);
                                         SectorOrginal1.SETFILTER(Description, '%1', SectorOrginal.Description);
                                         SectorOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                         IF NOT SectorOrginal1.FINDFIRST THEN
                                             SectorOrginal.INSERT;
                                     UNTIL SectorTemp.NEXT = 0;
                             END;


                             IF DepCatTemp.FINDSET THEN
                                 REPEAT

                                     DepCatOrginal.INIT;
                                     DepCatOrginal.TRANSFERFIELDS(DepCatTemp);
                                     OrgSNew.RESET;
                                     OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                     IF OrgSNew.FINDFIRST THEN BEGIN
                                         DepCatOrginal."Last Date Modified" := OrgSNew."Date From";
                                         DepCatOrginal."Operator No." := OrgSNew."Operator No.";
                                     END;


                                     //ovdje da pronađem id za gps ako postoji
                                     SectorParent2.RESET;
                                     SectorParent2.SETFILTER(Code, '%1', COPYSTR(DepCatOrginal.Code, 1, 4));
                                     SectorParent2.SETFILTER("Org Shema", '%1', DepCatOrginal."Org Shema");
                                     SectorParent2.SETCURRENTKEY("Org Shema");
                                     SectorParent2.ASCENDING(FALSE);
                                     IF SectorParent2.FINDFIRST THEN BEGIN

                                         DepCatOrginal.Parent := SectorParent2.Description;

                                     END
                                     ELSE BEGIN
                                         DepCatOrginal.Parent := '';
                                     END;

                                     DepCat22.RESET;
                                     DepCat22.SETFILTER("Org Shema", '<>%1', DepCatOrginal."Org Shema");
                                     DepCat22.SETFILTER(Code, '%1', DepCatOrginal.Code);
                                     DepCat22.SETFILTER(Description, '%1', DepCatOrginal.Description);
                                     DepCat22.SETFILTER(Parent, '%1', DepCatOrginal.Parent);
                                     IF DepCat22.FINDFIRST THEN BEGIN
                                         DepCatOrginal."ID for GPS" := DepCat22."ID for GPS";
                                         DepCatOrginal.Ispis := FALSE;
                                     END
                                     ELSE BEGIN
                                         DepCatOrginal."ID for GPS" := 0;
                                         DepCatOrginal.Ispis := FALSE;
                                     END;


                                     DepCatOrginal1.SETFILTER(Description, '%1', DepCatOrginal.Description);
                                     DepCatOrginal1.SETFILTER(Code, '%1', DepCatOrginal.Code);
                                     DepCatOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                     IF NOT DepCatOrginal1.FINDFIRST THEN
                                         DepCatOrginal.INSERT;
                                 UNTIL DepCatTemp.NEXT = 0;



                             IF GroupTemp.FINDSET THEN
                                 REPEAT
                                     GroupOrginal.INIT;
                                     GroupOrginal.TRANSFERFIELDS(GroupTemp);
                                     OrgSNew.RESET;
                                     OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                     IF OrgSNew.FINDFIRST THEN BEGIN
                                         GroupOrginal."Last Date Modified" := OrgSNew."Date From";
                                         GroupOrginal."Operator No." := OrgSNew."Operator No.";
                                     END;
                                     //ID za gps
                                     GroupCat22.RESET;
                                     GroupCat22.SETFILTER("Org Shema", '<>%1', GroupOrginal."Org Shema");
                                     GroupCat22.SETFILTER(Code, '%1', GroupOrginal.Code);
                                     GroupCat22.SETFILTER(Description, '%1', GroupOrginal.Description);
                                     GroupCat22.SETFILTER("Belongs to Department Category", '%1', GroupOrginal."Belongs to Department Category");
                                     IF GroupCat22.FINDFIRST THEN BEGIN
                                         GroupOrginal."ID for GPS" := GroupCat22."ID for GPS";
                                         GroupOrginal.Ispis := FALSE;
                                     END
                                     ELSE BEGIN
                                         GroupOrginal."ID for GPS" := 0;
                                         GroupOrginal.Ispis := FALSE;
                                     END;
                                     //ID za gps

                                     GroupOrginal1.SETFILTER(Description, '%1', GroupOrginal.Description);
                                     GroupOrginal1.SETFILTER(Code, '%1', GroupOrginal.Code);
                                     GroupOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                     IF NOT GroupOrginal1.FINDFIRST THEN
                                         GroupOrginal.INSERT;
                                 UNTIL GroupTemp.NEXT = 0;

                             IF TeamTemp.FINDSET THEN
                                 REPEAT
                                     TeamOrginal.INIT;
                                     TeamOrginal.TRANSFERFIELDS(TeamTemp);
                                     OrgSNew.RESET;
                                     OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                     IF OrgSNew.FINDFIRST THEN BEGIN
                                         TeamOrginal."Last Date Modified" := OrgSNew."Date From";
                                         TeamOrginal."Operator No." := OrgSNew."Operator No.";
                                     END;


                                     //ID za gps
                                     TeamCat22.RESET;
                                     TeamCat22.SETFILTER("Org Shema", '<>%1', TeamOrginal."Org Shema");
                                     TeamCat22.SETFILTER(Code, '%1', TeamOrginal.Code);
                                     TeamCat22.SETFILTER(Name, '%1', TeamOrginal.Name);
                                     TeamCat22.SETFILTER("Belongs to Group", '%1', TeamOrginal."Belongs to Group");
                                     IF TeamCat22.FINDFIRST THEN BEGIN
                                         TeamOrginal."ID for GPS" := TeamCat22."ID for GPS";
                                         TeamOrginal.Ispis := FALSE;
                                     END
                                     ELSE BEGIN
                                         TeamOrginal."ID for GPS" := 0;
                                         TeamOrginal.Ispis := FALSE;
                                     END;
                                     //ID za gps



                                     TeamOrginal1.SETFILTER(Name, '%1', TeamOrginal.Name);
                                     TeamOrginal1.SETFILTER(Code, '%1', TeamOrginal.Code);
                                     TeamOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                     IF NOT TeamOrginal1.FINDFIRST THEN
                                         TeamOrginal.INSERT;
                                 UNTIL TeamTemp.NEXT = 0;
                             IF DepartmentTemp.FINDSET THEN
                                 REPEAT
                                     DepartmentOrginal.INIT;
                                     DepartmentOrginal.TRANSFERFIELDS(DepartmentTemp);
                                     DepartmentOrginal1.SETFILTER(Description, '%1', DepartmentOrginal.Description);
                                     DepartmentOrginal1.SETFILTER(Code, '%1', DepartmentOrginal.Code);
                                     DepartmentOrginal1.SETFILTER("Department Categ.  Description", '%1', DepartmentOrginal."Department Categ.  Description");
                                     DepartmentOrginal1.SETFILTER("Group Description", '%1', DepartmentOrginal."Group Description");
                                     DepartmentOrginal1.SETFILTER("Team Description", '%1', DepartmentOrginal."Team Description");
                                     DepartmentOrginal1.SETFILTER("ORG Shema", '%1', ORGShema.Code);
                                     IF NOT DepartmentOrginal1.FINDFIRST THEN
                                         DepartmentOrginal.INSERT;
                                 UNTIL DepartmentTemp.NEXT = 0;
                             IF HeadOfTemp.FINDSET THEN
                                 REPEAT
                                     HeadOfOrginal.INIT;
                                     HeadOfOrginal.TRANSFERFIELDS(HeadOfTemp);
                                     HeadOfOrginal1.SETFILTER("Department Code", '%1', HeadOfOrginal."Department Code");
                                     HeadOfOrginal1.SETFILTER("Sector  Description", '%1', HeadOfOrginal."Sector  Description");
                                     HeadOfOrginal1.SETFILTER("Department Categ.  Description", '%1', HeadOfOrginal."Department Categ.  Description");
                                     HeadOfOrginal1.SETFILTER("Group Description", '%1', HeadOfOrginal."Group Description");
                                     HeadOfOrginal1.SETFILTER("Team Description", '%1', HeadOfOrginal."Team Description");
                                     HeadOfOrginal1.SETFILTER("ORG Shema", '%1', ORGShema.Code);
                                     IF NOT HeadOfOrginal1.FINDFIRST THEN
                                         HeadOfOrginal.INSERT;
                                 UNTIL HeadOfTemp.NEXT = 0;
                             COMMIT;
                             NewReport.RUN;
                             COMMIT;
                             IF DimensionTempPos.FINDSET THEN
                                 REPEAT
                                     DimensionOrginalPos.INIT;
                                     DimensionOrginalPos.TRANSFERFIELDS(DimensionTempPos);
                                     DimensionOrginalPos1.RESET;
                                     DimensionOrginalPos1.SETFILTER("Position Code", '%1', DimensionOrginalPos."Position Code");
                                     DimensionOrginalPos1.SETFILTER("Position Description", '%1', DimensionOrginalPos."Position Description");
                                     DimensionOrginalPos1.SETFILTER("Dimension Value Code", '%1', DimensionOrginalPos."Dimension Value Code");
                                     DimensionOrginalPos1.SETFILTER("Org Belongs", '%1', DimensionOrginalPos."Org Belongs");
                                     DimensionOrginalPos1.SETFILTER("ORG Shema", '%1', DimensionTempPos."ORG Shema");
                                     IF NOT DimensionOrginalPos1.FINDFIRST THEN
                                         DimensionOrginalPos.INSERT;
                                 UNTIL DimensionTempPos.NEXT = 0;
                             IF BenefitsTemp.FINDSET THEN
                                 REPEAT
                                     BenefitsOrginal.INIT;
                                     BenefitsOrginal.TRANSFERFIELDS(BenefitsTemp);
                                     BenefitsOrginal1.RESET;
                                     BenefitsOrginal1.SETFILTER("Position Code", '%1', BenefitsTemp."Position Code");
                                     BenefitsOrginal1.SETFILTER("Position Name", '%1', BenefitsTemp."Position Name");
                                     BenefitsOrginal1.SETFILTER(Code, '%1', BenefitsTemp.Code);
                                     BenefitsOrginal1.SETFILTER("Org. Structure", '%1', BenefitsTemp."Org. Structure");
                                     IF NOT BenefitsOrginal1.FINDFIRST THEN
                                         BenefitsOrginal.INSERT;
                                 UNTIL BenefitsTemp.NEXT = 0;
                             IF PositionMenuTemp.FINDSET THEN
                                 REPEAT
                                     PositionMenuOrginal.INIT;
                                     PositionMenuOrginal.TRANSFERFIELDS(PositionMenuTemp);
                                     OrgSNew.RESET;
                                     OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                     IF OrgSNew.FINDFIRST THEN BEGIN
                                         PositionMenuOrginal."Last Date Modified" := OrgSNew."Date From";
                                         PositionMenuOrginal."Operator No." := OrgSNew."Operator No.";
                                     END;

                                     PoSMenDUp.RESET;
                                     PoSMenDUp.SETFILTER(Code, '%1', PositionMenuOrginal.Code);
                                     PoSMenDUp.SETFILTER(Description, '%1', PositionMenuOrginal.Description);
                                     PoSMenDUp.SETFILTER("Department Code", '%1', PositionMenuOrginal."Department Code");
                                     PoSMenDUp.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                                     IF NOT PoSMenDUp.FINDFIRST THEN
                                         PositionMenuOrginal.INSERT;
                                 UNTIL PositionMenuTemp.NEXT = 0;
                             PositionMenuOrginal.RESET;
                             PositionMenuOrginal.SETFILTER("Department Code", '%1', '');
                             PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                             IF PositionMenuOrginal.FINDSET THEN
                                 REPEAT
                                     DimensionTempPos.RESET;
                                     DimensionTempPos.SETFILTER("Position Code", '%1', PositionMenuOrginal.Code);
                                     DimensionTempPos.SETFILTER("Position Description", '%1', PositionMenuOrginal.Description);
                                     IF DimensionTempPos.FINDSET THEN
                                         REPEAT
                                             PositionMenuOrginal1.INIT;
                                             PositionMenuOrginal1.Code := DimensionTempPos."Position Code";
                                             OrgSNew.RESET;
                                             OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                             IF OrgSNew.FINDFIRST THEN BEGIN
                                                 PositionMenuOrginal1."Last Date Modified" := OrgSNew."Date From";
                                                 PositionMenuOrginal1."Operator No." := OrgSNew."Operator No.";
                                             END;
                                             PositionMenuOrginal1.Description := DimensionTempPos."Position Description";
                                             PositionMenuOrginal1."Org. Structure" := DimensionTempPos."ORG Shema";
                                             PositionMenuOrginal1."Key Function" := PositionMenuOrginal."Key Function";
                                             PositionMenuOrginal1."Control Function" := PositionMenuOrginal."Control Function";
                                             PositionMenuOrginal1."BJF/GJF" := PositionMenuOrginal."BJF/GJF";
                                             PositionMenuOrginal1."Management Level" := PositionMenuOrginal."Management Level";
                                             PositionMenuOrginal1.Role := PositionMenuOrginal.Role;
                                             PositionMenuOrginal1."Role Name" := PositionMenuOrginal."Role Name";
                                             PositionMenuOrginal1.Grade := PositionMenuOrginal.Grade;
                                             PositionMenuOrginal1."Official Translation" := PositionMenuOrginal."Official Translation";

                                             IF DimensionTempPos."Team Description" <> '' THEN
                                                 PositionMenuOrginal1."Department Code" := DimensionTempPos."Team Code";
                                             IF (DimensionTempPos."Group Description" <> '') AND (DimensionTempPos."Team Description" = '') THEN
                                                 PositionMenuOrginal1."Department Code" := DimensionTempPos."Group Code";
                                             IF (DimensionTempPos."Department Categ.  Description" <> '') AND (DimensionTempPos."Group Description" = '') THEN
                                                 PositionMenuOrginal1."Department Code" := DimensionTempPos."Department Category";
                                             IF (DimensionTempPos."Sector  Description" <> '') AND (DimensionTempPos."Department Categ.  Description" = '') THEN
                                                 PositionMenuOrginal1."Department Code" := DimensionTempPos.Sector;

                                             IF NOT PosMenOrg.GET(PositionMenuOrginal1.Code, PositionMenuOrginal1.Description, PositionMenuOrginal1."Department Code", PositionMenuOrginal1."Org. Structure") THEN
                                                 //Code,Description,Department Code,Org. Structure
                                                 PositionMenuOrginal1.INSERT;

                                         UNTIL DimensionTempPos.NEXT = 0
 UNTIL PositionMenuOrginal.NEXT = 0;
                             PositionMenuOrginal.RESET;
                             PositionMenuOrginal.SETFILTER("Department Code", '%1', '');
                             IF PositionMenuOrginal.FINDSET THEN
                                 REPEAT
                                     PositionMenuOrginal.DELETE;
                                 UNTIL PositionMenuOrginal.NEXT = 0;
                             ORGShema."Change Org" := TRUE;
                             ORGShema.MODIFY;
                         END;
                     END;
                     */
                    end;
                    Commit();
                    UpdateDep.Run();
                    Commit();
                    //NE DOSTAJE 1 END
                    IF (Rec."Employee No." <> '') THEN BEGIN

                        ECLSis.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF ECLSis.FINDFIRST THEN BEGIN
                            IF (ECLSis."Department Category" = '') AND (ECLSis."Sector Description" <> '') THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                SectorTemp.RESET;
                                SectorTemp.SETFILTER(Code, '%1', COPYSTR(Rec.Sector, 1, j));
                                IF SectorTemp.FINDFIRST THEN BEGIN
                                END
                                ELSE BEGIN
                                    IF STRLEN(ECLSis.Sector) > 2 THEN
                                        Yes := TRUE;
                                END;
                            END;

                            //3 UKLJUČITI NA SAMOM KRAJU

                            IF (Rec."Order By Managment" = 2) OR (Yes = TRUE) THEN BEGIN
                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;




                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;



                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');

                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');

                                        END;

                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');

                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');

                                        END;

                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');

                                        END;



                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;

                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                ECLORG1nEW."Show Record" := FALSE;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D;
                                                    ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    ECLORG1nEW."Show Record" := FALSE;
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D
                                                    END;
                                                    ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    ECLORG1nEW."Show Record" := FALSE;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //   MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //  MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //  MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;
                            END;


                            // AKO JE ORDER 3 ŠALJI MI I EXE I CEO

                            Brojac := 0;
                            IF Rec."Order By Managment" = 3 THEN BEGIN

                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                // 1 END
                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;

                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;


                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;

                                        //ĐK


                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;


                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');

                                        END;

                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN

                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '')


                                        END;

                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";


                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;


                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //   MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                // MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //  MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);

                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;


                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN

                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;

                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D;
                                                    ECLOrgNewb."Show Record" := TRUE;
                                                    ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                    END;
                                END;

                            END;



                            //AKO JE B2 ŠALJI MI B1,CEO I EXE

                            IF Rec."Order By Managment" = 4 THEN BEGIN

                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                //1 uključiti na kraju B2

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');

                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;


                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');

                                        END;

                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //          MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;

                                END;

                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");


                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);

                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN

                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');

                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');

                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);



                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //      MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //    MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;


                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;


                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');

                                        END;

                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');

                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');
                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN


                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');

                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;


                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //      MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //    MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;
                            END;


                            //AKO JE B3 ŠALJI MI B2,B1,CEO I EXE
                            IF Rec."Order By Managment" = 5 THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                //KOJI SVE ZATVARA 1

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');

                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');
                                        END;





                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //   MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");

                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN

                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');

                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;


                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //    MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;

                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;
                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //      MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //    MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;



                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 4);
                                ECLSYST2.SETFILTER("Department Category", '%1', Rec."Department Category");
                                ECLSYST2.SETFILTER("Department Cat. Description", '%1', Rec."Department Cat. Description");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;


                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');

                                        END;



                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');

                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //   MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                // MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;
                            END;






                            //AKO JE B4 ŠALJI MI B3,B2,B1,CEO I EXE
                            IF Rec."Order By Managment" = 6 THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');
                                        END;
                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //   MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;



                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;

                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //   MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;


                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //   MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                // MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;

                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 4);
                                ECLSYST2.SETFILTER("Department Category", '%1', Rec."Department Category");
                                ECLSYST2.SETFILTER("Department Cat. Description", '%1', Rec."Department Cat. Description");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //  MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //  MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 5);
                                ECLSYST2.SETFILTER(Group, '%1', Rec.Group);
                                ECLSYST2.SETFILTER("Group Description", '%1', Rec."Group Description");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');
                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //    MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //  MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;
                            END;



                            //AKO JE ŠALJI SVE S NJEGOVE ORGANIZACIJE
                            IF Rec."Order By Managment" > 6 THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');

                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');
                                        END;
                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //    MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //  MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //    MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //  MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;


                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //   MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //     MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;
                                IF (Rec."Department Category" <> '') AND (Rec."Department Cat. Description" <> '') THEN BEGIN
                                    ECLSYST2.RESET;
                                    ECLSYST2.SETFILTER("Order By Managment", '%1', 4);
                                    ECLSYST2.SETFILTER("Department Category", '%1', Rec."Department Category");
                                    ECLSYST2.SETFILTER("Department Cat. Description", '%1', Rec."Department Cat. Description");
                                    IF ECLSYST2.FINDFIRST THEN BEGIN
                                        ECLOrg.RESET;
                                        ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                            ECLOrgNewb.INIT;
                                            BR.RESET;
                                            BR.SETCURRENTKEY("No.");
                                            BR.ASCENDING;
                                            IF BR.FINDLAST THEN BEGIN
                                                IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                    IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                        ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                                END;
                                            END;
                                            ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                                DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Team Description", '');
                                            END;
                                            IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                                DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Group Description", '');
                                            END;

                                            IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                                DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                            END;
                                            IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                                DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Sector Description", '');
                                            END;

                                            PositionMenuOrginal.RESET;
                                            PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                            PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                            IF PositionMenuOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Position Description", '');

                                            IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                            END;
                                            IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("GF of work Description", '');
                                            END;

                                            ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                            ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                            PositionIDFind.RESET;
                                            PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            IF PositionIDFind.FINDFIRST THEN BEGIN
                                                ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                            END;

                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            ECLOrgNewb."Show Record" := FALSE;
                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            EmployeeContractLedger2.RESET;
                                            EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                                AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                                AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                                AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                                 (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                    ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                    ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                    IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D
                                                    END
                                                    ELSE BEGIN
                                                        IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                            ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END
                                                        ELSE BEGIN
                                                            ECLOrgNewb."Ending Date" := 0D;
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END;
                                                    END;
                                                    EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                    EmployeeContractLedger2.MODIFY(FALSE);
                                                    //ECLOrg."Show Record":=FALSE;
                                                END;
                                            END;
                                            ECLOrgNewb.Active := FALSE;
                                            ECLOrgNewb.INSERT(FALSE);
                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIs.INIT;
                                                    MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                    MAIs."Misc. Article Code" := PositionBenef.Code;
                                                    MAIs.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    //      MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                    //    MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                    MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                    IF MAI1.FINDFIRST THEN
                                                        MAIs."From Date" := MAI1."From Date";
                                                    MAIs.Amount := PositionBenef.Amount;
                                                    MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                    MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                    MAIs."Org Shema" := ORGShema.Code;
                                                //    MAIs.INSERT;
                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                    END;
                                END;
                                IF (Rec."Group Description" <> '') AND (Rec.Group <> '') THEN BEGIN

                                    ECLSYST2.RESET;
                                    ECLSYST2.SETFILTER("Order By Managment", '%1', 5);
                                    ECLSYST2.SETFILTER(Group, '%1', Rec.Group);
                                    ECLSYST2.SETFILTER("Group Description", '%1', Rec."Group Description");
                                    IF ECLSYST2.FINDFIRST THEN BEGIN
                                        ECLOrg.RESET;
                                        ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                            ECLOrgNewb.INIT;
                                            BR.RESET;
                                            BR.SETCURRENTKEY("No.");
                                            BR.ASCENDING;
                                            IF BR.FINDLAST THEN BEGIN
                                                IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                    IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                        ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                                END;
                                            END;
                                            ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                                DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Team Description", '');

                                            END;
                                            IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                                DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Group Description", '');
                                            END;

                                            IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                                DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                            END;
                                            IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                                DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Sector Description", '');
                                            END;


                                            PositionMenuOrginal.RESET;
                                            PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                            PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                            IF PositionMenuOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Position Description", '');


                                            IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                            END;
                                            IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("GF of work Description", '');
                                            END;

                                            ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                            ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                            PositionIDFind.RESET;
                                            PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            IF PositionIDFind.FINDFIRST THEN BEGIN
                                                ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                            END;

                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            ECLOrgNewb."Show Record" := FALSE;
                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            EmployeeContractLedger2.RESET;
                                            EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                                AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                                AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                                AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                                 (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                    ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                    ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                    IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D
                                                    END
                                                    ELSE BEGIN
                                                        IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                            ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END
                                                        ELSE BEGIN
                                                            ECLOrgNewb."Ending Date" := 0D;
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END;
                                                    END;
                                                    EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                    EmployeeContractLedger2.MODIFY(FALSE);
                                                    //ECLOrg."Show Record":=FALSE;
                                                END;
                                            END;
                                            ECLOrgNewb.Active := FALSE;
                                            ECLOrgNewb.INSERT(FALSE);
                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIs.INIT;
                                                    MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                    MAIs."Misc. Article Code" := PositionBenef.Code;
                                                    MAIs.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                    //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                    MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                    IF MAI1.FINDFIRST THEN
                                                        MAIs."From Date" := MAI1."From Date";
                                                    MAIs.Amount := PositionBenef.Amount;
                                                    MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                    MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                    MAIs."Org Shema" := ORGShema.Code;
                                                //    MAIs.INSERT;
                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                    END;
                                END;




                                IF (Rec.Team <> '') AND (Rec."Team Description" <> '') THEN BEGIN
                                    ECLSYST2.RESET;
                                    ECLSYST2.SETFILTER("Order By Managment", '%1', 6);
                                    ECLSYST2.SETFILTER(Team, '%1', Rec.Team);
                                    ECLSYST2.SETFILTER("Team Description", '%1', Rec."Team Description");
                                    IF ECLSYST2.FINDFIRST THEN BEGIN
                                        ECLOrg.RESET;
                                        ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                            ECLOrgNewb.INIT;
                                            BR.RESET;
                                            BR.SETCURRENTKEY("No.");
                                            BR.ASCENDING;
                                            IF BR.FINDLAST THEN BEGIN
                                                IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                    IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                        ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                                END;
                                            END;
                                            ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                                DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Team Description", '');
                                            END;
                                            IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                                DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Group Description", '');
                                            END;

                                            IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                                DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                            END;
                                            IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                                DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Sector Description", '');
                                            END;


                                            PositionMenuOrginal.RESET;
                                            PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                            PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                            IF PositionMenuOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Position Description", '');

                                            IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                            END;
                                            IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("GF of work Description", '');
                                            END;

                                            ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                            ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                            PositionIDFind.RESET;
                                            PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            IF PositionIDFind.FINDFIRST THEN BEGIN
                                                ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                            END;

                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            ECLOrgNewb."Show Record" := FALSE;
                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            EmployeeContractLedger2.RESET;
                                            EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                                AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                                AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                                AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                                 (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                    ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                    ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                    IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D
                                                    END
                                                    ELSE BEGIN
                                                        IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                            ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END
                                                        ELSE BEGIN
                                                            ECLOrgNewb."Ending Date" := 0D;
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END;
                                                    END;
                                                    EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                    EmployeeContractLedger2.MODIFY(FALSE);
                                                    //ECLOrg."Show Record":=FALSE;
                                                END;
                                            END;
                                            ECLOrgNewb.Active := FALSE;
                                            ECLOrgNewb.INSERT(FALSE);

                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIs.INIT;
                                                    MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                    MAIs."Misc. Article Code" := PositionBenef.Code;
                                                    MAIs.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    //    MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                    //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                    MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                    IF MAI1.FINDFIRST THEN
                                                        MAIs."From Date" := MAI1."From Date";
                                                    MAIs.Amount := PositionBenef.Amount;
                                                    MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                    MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                    MAIs."Org Shema" := ORGShema.Code;
                                                //   MAIs.INSERT;
                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                    END;
                                END;
                            END;


                            //Novi:=Novi+1;

                            ORGShema.RESET;
                            ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                            IF ORGShema.FINDFIRST THEN BEGIN

                            END;
                            ECLOrg.RESET;
                            ECLOrg.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            ECLOrg.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                            IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                ECLOrg.INIT;
                                //ECLSis.VALIDATE("Starting Date",ORGShema."Date From");
                                ECLSis."Starting Date" := ORGShema."Date From";
                                BR.RESET;
                                BR.SETCURRENTKEY("No.");
                                BR.ASCENDING;
                                IF BR.FINDLAST THEN BEGIN
                                    IF BR."No." + 1 <> ECLSis."No." THEN BEGIN
                                        //IF ECLSYSTChangeBR.GET(ECLSis."No.",ECLSis."Employee No.") THEN
                                        //  ECLSYSTChangeBR.RENAME(BR."No."+1,ECLSis."Employee No.") ;
                                    END;
                                END;

                                ECLOrg.TRANSFERFIELDS(ECLSis);
                                ECLOrg."No." := BR."No." + 1;
                                ECLOrg."Org. Structure" := ORGShema.Code;
                                IF Rec."Team Description" <> '' THEN BEGIN

                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                    DepartmentOrginal.SETFILTER("Team Description", '%1', Rec."Team Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Team Description", Rec."Team Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Team Description", '');
                                END;

                                IF (Rec."Group Description" <> '') AND (Rec."Team Description" = '') THEN BEGIN
                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                    DepartmentOrginal.SETFILTER("Group Description", '%1', Rec."Group Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Group Description", Rec."Group Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Group Description", '');
                                END;
                                IF (Rec."Department Cat. Description" <> '') AND (Rec."Group Description" = '') THEN BEGIN
                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                    DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', Rec."Department Cat. Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Department Cat. Description", Rec."Department Cat. Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Department Cat. Description", '');
                                END;
                                IF (Rec."Sector Description" <> '') AND (Rec."Department Cat. Description" = '') THEN BEGIN
                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                    DepartmentOrginal.SETFILTER("Sector  Description", '%1', Rec."Sector Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Sector Description", Rec."Sector Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Sector Description", '');
                                END;

                                PositionMenuOrginal.RESET;
                                PositionMenuOrginal.SETFILTER(Code, '%1', Rec."Position Code");
                                PositionMenuOrginal.SETFILTER(Description, '%1', Rec."Position Description");
                                PositionMenuOrginal.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                                PositionMenuOrginal.SETFILTER("Department Code", '%1', Rec."Department Code");
                                IF PositionMenuOrginal.FINDFIRST THEN
                                    ECLOrg.VALIDATE("Position Description", Rec."Position Description")
                                ELSE
                                    ECLOrg.VALIDATE("Position Description", '');

                                IF Rec."Org Unit Name" <> '' THEN BEGIN
                                    OrgDijelovi.RESET;
                                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                    OrgDijelovi.SETFILTER(Description, '%1', Rec."Org Unit Name");
                                    IF OrgDijelovi.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Org Unit Name", Rec."Org Unit Name")
                                    ELSE
                                        ECLOrg.VALIDATE("Org Unit Name", '');
                                END;
                                IF Rec."GF of work Description" <> '' THEN BEGIN
                                    OrgDijelovi.RESET;
                                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                    OrgDijelovi.SETFILTER(Description, '%1', Rec."GF of work Description");
                                    IF OrgDijelovi.FINDFIRST THEN
                                        ECLOrg.VALIDATE("GF of work Description", Rec."GF of work Description")
                                    ELSE
                                        ECLOrg.VALIDATE("GF of work Description", '');
                                END;

                                ECLOrg."Employee No." := Rec."Employee No.";
                                ECLOrg."Employee Name" := Rec."Employee Name";
                                ECLOrg."Operator No." := USERID;

                                PositionIDFind.RESET;
                                PositionIDFind.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                                PositionIDFind.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                IF PositionIDFind.FINDFIRST THEN BEGIN
                                    ECLOrg."Position ID" := PositionIDFind."Position ID";
                                END;

                                ECLOrg."Org. Structure" := ORGShema.Code;
                                ECLOrg.Status := ECLOrg.Status::Active;
                                EmployeeContractLedger2.RESET;
                                EmployeeContractLedger2.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                    IF (EmployeeContractLedger2."Reason for Change" = Rec."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = Rec."Sector Description")
                                    AND (EmployeeContractLedger2."Department Cat. Description" = Rec."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = Rec."Group Description")
                                    AND (EmployeeContractLedger2."Team Description" = ECLOrg."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrg."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrg."GF of work Description")
                                    AND (EmployeeContractLedger2."Position Description" = Rec."Position Description") AND (EmployeeContractLedger2.IS = Rec.IS) AND
                                     (EmployeeContractLedger2."IS Date From" = ECLOrg."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrg."IS Date To") THEN BEGIN
                                        ECLOrg."Starting Date" := EmployeeContractLedger2."Starting Date";
                                        ECLOrg."Ending Date" := EmployeeContractLedger2."Ending Date";
                                        ECLOrg."Show Record" := FALSE;
                                        ECLOrg.Status := ECLOrg.Status::Active;
                                    END
                                    ELSE BEGIN
                                        ECLOrg."Starting Date" := ORGShema."Date From";
                                        ECLOrg."Show Record" := TRUE;
                                        ECLOrg.Status := ECLOrg.Status::Active;
                                        IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                            ECLOrg."Ending Date" := 0D
                                        END
                                        ELSE BEGIN
                                            IF ECLOrg."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                ECLOrg."Ending Date" := EmployeeContractLedger2."Ending Date";

                                                //  ECLOrg.VALIDATE("Starting Date",ORGShema."Date From");
                                                ECLOrg."Starting Date" := ORGShema."Date From";

                                                ECLOrg."Show Record" := TRUE;
                                                ECLOrg.Status := ECLOrg.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrg."Ending Date" := 0D;

                                                ECLOrg."Work Days" := 0;
                                                ECLOrg."Work Months" := 0;
                                                ECLOrg."Work Years" := 0;
                                                ECLOrg."Probation Days" := 0;
                                                ECLOrg."Probation Months" := 0;
                                                ECLOrg."Probation Year" := 0;
                                                ECLOrg."Show Record" := TRUE;
                                                ECLOrg.Status := ECLOrg.Status::Active;
                                            END;
                                        END;
                                        EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                        EmployeeContractLedger2.MODIFY(FALSE);
                                        //ECLOrg."Show Record":=FALSE;
                                    END;
                                END;
                                ECLOrg."Attachment No." := 0;
                                //   ECLOrg."Agreement Name" := '';
                                ECLOrg."Agremeent Code" := '';
                                ECLOrg.Active := FALSE;
                                /* IF Rec."Reason for Change"=0 THEN BEGIN
                                 ECLOrg."Reason for Change":=16;
                                   Rec."Reason for Change":=16;
                                    END;*/

                                Finddate.RESET;
                                Finddate.SETFILTER(Status, '%1', Finddate.Status::Preparation);
                                IF Finddate.FINDFIRST THEN BEGIN
                                    ECL5.RESET;
                                    ECL5.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                    ECL5.SETFILTER("Starting Date", '<=%1', Finddate."Create date of org.prep");
                                    ORGShema.RESET;
                                    ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Active);
                                    IF ORGShema.FINDLAST THEN BEGIN
                                        ECL5.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                                    END;
                                    ECL5.SETCURRENTKEY("Starting Date");
                                    ECL5.ASCENDING;
                                    IF ECL5.FINDLAST THEN BEGIN
                                        IF ECL5."Reason for Change" = Rec."Reason for Change" THEN BEGIN
                                            ECLOrg."Reason for Change" := ECLOrg."Reason for Change"::Systematization;
                                            Rec."Reason for Change" := REc."Reason for Change"::Systematization;
                                        END
                                        ELSE BEGIN
                                            ECLOrg."Reason for Change" := Rec."Reason for Change";
                                        END;
                                    END;
                                END;
                                ECLOrg.Change := FALSE;
                                ECLOrg."Change other documents" := FALSE;
                                ECLOrg.INSERT(FALSE);
                                ORGShema.RESET;
                                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                                IF ORGShema.FINDFIRST THEN BEGIN

                                END;
                                PositionBenef.RESET;
                                PositionBenef.SETFILTER("Position Code", '%1', ECLOrg."Position Code");
                                PositionBenef.SETFILTER("Position Name", '%1', ECLOrg."Position Description");
                                PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrg."Org. Structure");
                                IF PositionBenef.FINDSET THEN
                                    REPEAT
                                        MAIs.INIT;
                                        MAIs."Employee No." := ECLOrg."Employee No.";
                                        MAIs."Misc. Article Code" := PositionBenef.Code;
                                        MAIs.Description := PositionBenef.Description;
                                        IF "Changing Position" = TRUE THEN
                                            MAIs."From Date" := ORGShema."Date From";
                                        MAIs.Amount := PositionBenef.Amount;
                                        MAIs."Position Code" := ECLOrg."Position Code";
                                        MAIs."Emp. Contract Ledg. Entry No." := ECLOrg."No.";
                                        MAIs."Org Shema" := ORGShema.Code;
                                        MAIs.INSERT;
                                    UNTIL PositionBenef.NEXT = 0;


                            END;

                        END;
                    END;
                END;

                //IF xRec."Changing Position"=TRUE AND Rec."Changing Position"=FALSE THEN BEGIN
                IF xRec."Changing Position" = TRUE THEN BEGIN
                    ECLDelete.RESET;
                    ECLDelete.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    //ECLDelete.SETFILTER("No.",'%1',Rec."No.");
                    ECLDelete.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                    IF ECLDelete.FINDFIRST THEN BEGIN
                        ECLDate.RESET;
                        ECLDate.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        ECLDate.SETFILTER("Org. Structure", '<>%1', ORGShema.Code);
                        ECLDate.SETFILTER(Active, '%1', TRUE);
                        ECLDate.SETFILTER("Starting Date", '<=%1', WORKDATE);
                        ECLDate.SETCURRENTKEY("Starting Date");
                        ECLDate.ASCENDING;
                        IF ECLDate.FINDLAST THEN BEGIN
                            ECLDate."Ending Date" := ECLDelete."Ending Date";
                            ECLDate.MODIFY;
                            ECLDelete.DELETE;
                            PositionDelete2.RESET;
                            PositionDelete2.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            PositionDelete2.SETFILTER(Description, '%1', Rec."Position Description");
                            PositionDelete2.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                            PositionDelete2.SETFILTER("Sector  Description", '%1', Rec."Sector Description");
                            PositionDelete2.SETFILTER("Department Categ.  Description", '%1', Rec."Department Cat. Description");
                            PositionDelete2.SETFILTER("Group Description", '%1', Rec."Group Description");
                            PositionDelete2.SETFILTER("Team Description", '%1', Rec."Team Description");
                            IF PositionDelete2.FINDFIRST THEN
                                PositionDelete2.DELETE;
                            ECLDate.VALIDATE("Ending Date", ECLDate."Ending Date");
                            ECLDate.MODIFY;

                        END;
                    END;
                    MaiDelete.RESET;
                    MaiDelete.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    //   MaiDelete.SETFILTER("Org Shema", '%1', Rec."Org. Structure");
                    IF MaiDelete.FINDSET THEN
                        REPEAT
                        //         MaiDelete.DELETE;
                        UNTIL MaiDelete.NEXT = 0;
                END;





                /*IF "Changing Position"=TRUE THEN
                "Will Be Changed Later":=FALSE;
                IF "Changing Position"=FALSE THEN
                "Will Be Changed Later":=FALSE;*/

                EmployeeContract.RESET;
                EmployeeContract.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                EmployeeContract.SETFILTER("Starting Date", '>%1', WORKDATE);
                IF EmployeeContract.FINDSET THEN
                    REPEAT
                        IF (EmployeeContract."Position Description" <> Rec."Position Description") OR (EmployeeContract."Org Belongs" <> Rec."Org Belongs")
                          THEN BEGIN
                            EmployeeContract.Conflict := TRUE;
                            EmployeeContract.MODIFY;
                        END;
                    UNTIL EmployeeContract.NEXT = 0;

                ORGShema.RESET;
                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                IF ORGShema.FINDLAST THEN BEGIN
                    OrgShema1.RESET;
                    OrgShema1.SETFILTER(Status, '%1', ORGShema.Status::Active);
                    IF OrgShema1.FINDLAST THEN BEGIN

                        ECL5.RESET;
                        ECL5.SETFILTER("Starting Date", '>%1', ORGShema."Create date of org.prep");
                        ECL5.SETFILTER("Modify the change is update", '%1', FALSE);
                        ECL5.SETFILTER("Org. Structure", '%1', OrgShema1.Code);
                        IF ECL5.FINDSET THEN
                            REPEAT
                                IF ECL5."Starting Date" <= WORKDATE THEN BEGIN
                                    ECL5.Conflict := TRUE;
                                    ECL5.MODIFY;
                                END;
                            UNTIL ECL5.NEXT = 0;
                    END;
                END;

            end;
        }
        field(50412; "Will Be Changed Later"; Boolean)
        {
            Caption = 'Will Be Changed Later';

            trigger OnValidate()
            begin
                IF "Will Be Changed Later" = TRUE THEN
                    "Changing Position" := FALSE;

                ORGShema.RESET;
                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                IF ORGShema.FINDLAST THEN BEGIN
                    IF ("Will Be Changed Later" = TRUE) AND (ORGShema."Change Org" = FALSE) THEN BEGIN
                        ORGShema.RESET;
                        ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                        IF ORGShema.FINDLAST THEN BEGIN
                            SectorOrginal.RESET;
                            SectorOrginal.SETFILTER("Org Shema", '%1', ORGShema.Code);
                            IF NOT SectorOrginal.FINDFIRST THEN BEGIN
                                IF SectorTemp.FINDSET THEN
                                    REPEAT
                                        SectorOrginal.INIT;
                                        SectorOrginal.TRANSFERFIELDS(SectorTemp);
                                        OrgSNew.RESET;
                                        OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                        IF OrgSNew.FINDFIRST THEN BEGIN
                                            SectorOrginal."Last Date Modified" := OrgSNew."Date From";
                                            SectorOrginal."Operator No." := OrgSNew."Operator No.";
                                        END;
                                        //ovdje da pronađem id za gps ako postoji







                                        SectorParent2.RESET;
                                        SectorParent2.SETFILTER("Org Shema", '<>%1', SectorTemp."Org Shema");
                                        SectorParent2.SETFILTER(Code, '%1', SectorOrginal.Code);
                                        SectorParent2.SETFILTER(Description, '%1', SectorOrginal.Description);
                                        SectorParent2.SETFILTER(Parent, '%1', SectorOrginal.Parent);
                                        IF SectorParent2.FINDFIRST THEN BEGIN
                                            SectorOrginal."ID for GPS" := SectorParent2."ID for GPS";
                                            SectorOrginal.Ispis := FALSE;
                                        END
                                        ELSE BEGIN
                                            SectorOrginal."ID for GPS" := 0;
                                            SectorOrginal.Ispis := FALSE;
                                        END;

                                        //ID za gps završava


                                        SectorOrginal1.SETFILTER(Code, '%1', SectorOrginal.Code);
                                        SectorOrginal1.SETFILTER(Description, '%1', SectorOrginal.Description);
                                        SectorOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                        IF NOT SectorOrginal1.FINDFIRST THEN
                                            SectorOrginal.INSERT;
                                    UNTIL SectorTemp.NEXT = 0;
                            END;
                            IF DepCatTemp.FINDSET THEN
                                REPEAT
                                    DepCatOrginal.INIT;
                                    DepCatOrginal.TRANSFERFIELDS(DepCatTemp);
                                    OrgSNew.RESET;
                                    OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                    IF OrgSNew.FINDFIRST THEN BEGIN
                                        DepCatOrginal."Last Date Modified" := OrgSNew."Date From";
                                        DepCatOrginal."Operator No." := OrgSNew."Operator No.";
                                    END;
                                    //ovdje da pronađem id za gps ako postoji
                                    SectorParent2.RESET;
                                    SectorParent2.SETFILTER(Code, '%1', COPYSTR(DepCatOrginal.Code, 1, 4));
                                    SectorParent2.SETFILTER("Org Shema", '%1', DepCatOrginal."Org Shema");
                                    SectorParent2.SETCURRENTKEY("Org Shema");
                                    SectorParent2.ASCENDING(FALSE);
                                    IF SectorParent2.FINDFIRST THEN BEGIN

                                        DepCatOrginal.Parent := SectorParent2.Description;

                                    END
                                    ELSE BEGIN
                                        DepCatOrginal.Parent := '';
                                    END;

                                    DepCat22.RESET;
                                    DepCat22.SETFILTER("Org Shema", '<>%1', DepCatOrginal."Org Shema");
                                    DepCat22.SETFILTER(Code, '%1', DepCatOrginal.Code);
                                    DepCat22.SETFILTER(Description, '%1', DepCatOrginal.Description);
                                    DepCat22.SETFILTER(Parent, '%1', DepCatOrginal.Parent);
                                    IF DepCat22.FINDFIRST THEN BEGIN
                                        DepCatOrginal."ID for GPS" := DepCat22."ID for GPS";
                                        DepCatOrginal.Ispis := FALSE;
                                    END
                                    ELSE BEGIN
                                        DepCatOrginal."ID for GPS" := 0;
                                        DepCatOrginal.Ispis := FALSE;
                                    END;
                                    DepCatOrginal1.SETFILTER(Description, '%1', DepCatOrginal.Description);
                                    DepCatOrginal1.SETFILTER(Code, '%1', DepCatOrginal.Code);
                                    DepCatOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                    IF NOT DepCatOrginal1.FINDFIRST THEN
                                        DepCatOrginal.INSERT;
                                UNTIL DepCatTemp.NEXT = 0;
                            IF GroupTemp.FINDSET THEN
                                REPEAT
                                    GroupOrginal.INIT;
                                    GroupOrginal.TRANSFERFIELDS(GroupTemp);
                                    OrgSNew.RESET;
                                    OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                    IF OrgSNew.FINDFIRST THEN BEGIN
                                        GroupOrginal."Last Date Modified" := OrgSNew."Date From";
                                        GroupOrginal."Operator No." := OrgSNew."Operator No.";
                                    END;

                                    //ID za gps
                                    GroupCat22.RESET;
                                    GroupCat22.SETFILTER("Org Shema", '<>%1', GroupOrginal."Org Shema");
                                    GroupCat22.SETFILTER(Code, '%1', GroupOrginal.Code);
                                    GroupCat22.SETFILTER(Description, '%1', GroupOrginal.Description);
                                    GroupCat22.SETFILTER("Belongs to Department Category", '%1', GroupOrginal."Belongs to Department Category");
                                    IF GroupCat22.FINDFIRST THEN BEGIN
                                        GroupOrginal."ID for GPS" := GroupCat22."ID for GPS";
                                        GroupOrginal.Ispis := FALSE;
                                    END
                                    ELSE BEGIN
                                        GroupOrginal."ID for GPS" := 0;
                                        GroupOrginal.Ispis := FALSE;
                                    END;
                                    //ID za gps

                                    GroupOrginal1.SETFILTER(Description, '%1', GroupOrginal.Description);
                                    GroupOrginal1.SETFILTER(Code, '%1', GroupOrginal.Code);
                                    GroupOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                                    IF NOT GroupOrginal1.FINDFIRST THEN
                                        GroupOrginal.INSERT;
                                UNTIL GroupTemp.NEXT = 0;

                            /*    IF TeamTemp.FINDSET THEN
                                    REPEAT
                                        TeamOrginal.INIT;
                                        TeamOrginal.TRANSFERFIELDS(TeamTemp);
                                        OrgSNew.RESET;
                                        OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                        IF OrgSNew.FINDFIRST THEN BEGIN
                                            TeamOrginal."Last Date Modified" := OrgSNew."Date From";
                                            TeamOrginal."Operator No." := OrgSNew."Operator No.";
                                        END;
                                        //ID za gps
                                        TeamCat22.RESET;
                                        TeamCat22.SETFILTER("Org Shema", '<>%1', TeamOrginal."Org Shema");
                                        TeamCat22.SETFILTER(Code, '%1', TeamOrginal.Code);
                                        TeamCat22.SETFILTER(Name, '%1', TeamOrginal.Name);
                                        TeamCat22.SETFILTER("Belongs to Group", '%1', TeamOrginal."Belongs to Group");
                                        IF TeamCat22.FINDFIRST THEN BEGIN
                                            TeamOrginal."ID for GPS" := TeamCat22."ID for GPS";
                                            TeamOrginal.Ispis := FALSE;
                                        END
                                        ELSE BEGIN
                                            TeamOrginal."ID for GPS" := 0;
                                            TeamOrginal.Ispis := FALSE;
                                        END;*/
                            //ID za gps
                            /*  TeamOrginal1.SETFILTER(Name, '%1', TeamOrginal.Name);
                              TeamOrginal1.SETFILTER(Code, '%1', TeamOrginal.Code);
                              TeamOrginal1.SETFILTER("Org Shema", '%1', ORGShema.Code);
                              IF NOT TeamOrginal1.FINDFIRST THEN
                                  TeamOrginal.INSERT;
                          UNTIL TeamTemp.NEXT = 0;*/
                            IF DepartmentTemp.FINDSET THEN
                                REPEAT
                                    DepartmentOrginal.INIT;
                                    DepartmentOrginal.TRANSFERFIELDS(DepartmentTemp);
                                    DepartmentOrginal1.SETFILTER(Description, '%1', DepartmentOrginal.Description);
                                    DepartmentOrginal1.SETFILTER(Code, '%1', DepartmentOrginal.Code);
                                    DepartmentOrginal1.SETFILTER("Department Categ.  Description", '%1', DepartmentOrginal."Department Categ.  Description");
                                    DepartmentOrginal1.SETFILTER("Group Description", '%1', DepartmentOrginal."Group Description");
                                    DepartmentOrginal1.SETFILTER("Team Description", '%1', DepartmentOrginal."Team Description");
                                    DepartmentOrginal1.SETFILTER("ORG Shema", '%1', ORGShema.Code);
                                    IF NOT DepartmentOrginal1.FINDFIRST THEN
                                        DepartmentOrginal.INSERT;
                                UNTIL DepartmentTemp.NEXT = 0;
                            IF HeadOfTemp.FINDSET THEN
                                REPEAT
                                    HeadOfOrginal.INIT;
                                    HeadOfOrginal.TRANSFERFIELDS(HeadOfTemp);
                                    HeadOfOrginal1.SETFILTER("Department Code", '%1', HeadOfOrginal."Department Code");
                                    HeadOfOrginal1.SETFILTER("Sector  Description", '%1', HeadOfOrginal."Sector  Description");
                                    HeadOfOrginal1.SETFILTER("Department Categ.  Description", '%1', HeadOfOrginal."Department Categ.  Description");
                                    HeadOfOrginal1.SETFILTER("Group Description", '%1', HeadOfOrginal."Group Description");
                                    HeadOfOrginal1.SETFILTER("Team Description", '%1', HeadOfOrginal."Team Description");
                                    HeadOfOrginal1.SETFILTER("ORG Shema", '%1', ORGShema.Code);
                                    IF NOT HeadOfOrginal1.FINDFIRST THEN
                                        HeadOfOrginal.INSERT;
                                UNTIL HeadOfTemp.NEXT = 0;
                            COMMIT;
                            NewReport.RUN;
                            COMMIT;
                            IF DimensionTempPos.FINDSET THEN
                                REPEAT
                                    DimensionOrginalPos.INIT;
                                    DimensionOrginalPos.TRANSFERFIELDS(DimensionTempPos);
                                    DimensionOrginalPos1.RESET;
                                    DimensionOrginalPos1.SETFILTER("Position Code", '%1', DimensionOrginalPos."Position Code");
                                    DimensionOrginalPos1.SETFILTER("Position Description", '%1', DimensionOrginalPos."Position Description");
                                    DimensionOrginalPos1.SETFILTER("Dimension Value Code", '%1', DimensionOrginalPos."Dimension Value Code");
                                    DimensionOrginalPos1.SETFILTER("Org Belongs", '%1', DimensionOrginalPos."Org Belongs");
                                    DimensionOrginalPos1.SETFILTER("ORG Shema", '%1', DimensionTempPos."ORG Shema");
                                    IF NOT DimensionOrginalPos1.FINDFIRST THEN
                                        DimensionOrginalPos.INSERT;
                                UNTIL DimensionTempPos.NEXT = 0;
                            IF BenefitsTemp.FINDSET THEN
                                REPEAT
                                    BenefitsOrginal.INIT;
                                    BenefitsOrginal.TRANSFERFIELDS(BenefitsTemp);
                                    BenefitsOrginal1.RESET;
                                    BenefitsOrginal1.SETFILTER("Position Code", '%1', BenefitsTemp."Position Code");
                                    BenefitsOrginal1.SETFILTER("Position Name", '%1', BenefitsTemp."Position Name");
                                    BenefitsOrginal1.SETFILTER(Code, '%1', BenefitsTemp.Code);
                                    BenefitsOrginal1.SETFILTER("Org. Structure", '%1', BenefitsTemp."Org. Structure");
                                    IF NOT BenefitsOrginal1.FINDFIRST THEN
                                        BenefitsOrginal.INSERT;
                                UNTIL BenefitsTemp.NEXT = 0;
                            IF PositionMenuTemp.FINDSET THEN
                                REPEAT
                                    PositionMenuOrginal.INIT;
                                    PositionMenuOrginal.TRANSFERFIELDS(PositionMenuTemp);
                                    OrgSNew.RESET;
                                    OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                    IF OrgSNew.FINDFIRST THEN BEGIN
                                        PositionMenuOrginal."Last Date Modified" := OrgSNew."Date From";
                                        PositionMenuOrginal."Operator No." := OrgSNew."Operator No.";
                                    END;

                                    PoSMenDUp.RESET;
                                    PoSMenDUp.SETFILTER(Code, '%1', PositionMenuOrginal.Code);
                                    PoSMenDUp.SETFILTER(Description, '%1', PositionMenuOrginal.Description);
                                    PoSMenDUp.SETFILTER("Department Code", '%1', PositionMenuOrginal."Department Code");
                                    PoSMenDUp.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                                    IF NOT PoSMenDUp.FINDFIRST THEN
                                        PositionMenuOrginal.INSERT;
                                UNTIL PositionMenuTemp.NEXT = 0;
                            PositionMenuOrginal.RESET;
                            PositionMenuOrginal.SETFILTER("Department Code", '%1', '');
                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                            IF PositionMenuOrginal.FINDSET THEN
                                REPEAT
                                    DimensionTempPos.RESET;
                                    DimensionTempPos.SETFILTER("Position Code", '%1', PositionMenuOrginal.Code);
                                    DimensionTempPos.SETFILTER("Position Description", '%1', PositionMenuOrginal.Description);
                                    IF DimensionTempPos.FINDSET THEN
                                        REPEAT
                                            PositionMenuOrginal1.INIT;
                                            PositionMenuOrginal1.Code := DimensionTempPos."Position Code";
                                            OrgSNew.RESET;
                                            OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                            IF OrgSNew.FINDFIRST THEN BEGIN
                                                PositionMenuOrginal1."Last Date Modified" := OrgSNew."Date From";
                                                PositionMenuOrginal1."Operator No." := OrgSNew."Operator No.";
                                            END;
                                            PositionMenuOrginal1.Description := DimensionTempPos."Position Description";
                                            PositionMenuOrginal1."Org. Structure" := DimensionTempPos."ORG Shema";
                                            PositionMenuOrginal1."Key Function" := PositionMenuOrginal."Key Function";
                                            PositionMenuOrginal1."Control Function" := PositionMenuOrginal."Control Function";
                                            PositionMenuOrginal1."BJF/GJF" := PositionMenuOrginal."BJF/GJF";
                                            PositionMenuOrginal1."Management Level" := PositionMenuOrginal."Management Level";
                                            //     PositionMenuOrginal1.Role := PositionMenuOrginal.Role;
                                            //    PositionMenuOrginal1."Role Name" := PositionMenuOrginal."Role Name";

                                            IF DimensionTempPos."Team Description" <> '' THEN
                                                PositionMenuOrginal1."Department Code" := DimensionTempPos."Team Code";
                                            IF (DimensionTempPos."Group Description" <> '') AND (DimensionTempPos."Team Description" = '') THEN
                                                PositionMenuOrginal1."Department Code" := DimensionTempPos."Group Code";
                                            IF (DimensionTempPos."Department Categ.  Description" <> '') AND (DimensionTempPos."Group Description" = '') THEN
                                                PositionMenuOrginal1."Department Code" := DimensionTempPos."Department Category";
                                            IF (DimensionTempPos."Sector  Description" <> '') AND (DimensionTempPos."Department Categ.  Description" = '') THEN
                                                PositionMenuOrginal1."Department Code" := DimensionTempPos.Sector;

                                            IF NOT PosMenOrg.GET(PositionMenuOrginal1.Code, PositionMenuOrginal1.Description, PositionMenuOrginal1."Department Code", PositionMenuOrginal1."Org. Structure") THEN
                                                //Code,Description,Department Code,Org. Structure
                                                PositionMenuOrginal1.INSERT;

                                        UNTIL DimensionTempPos.NEXT = 0
UNTIL PositionMenuOrginal.NEXT = 0;
                            PositionMenuOrginal.RESET;
                            PositionMenuOrginal.SETFILTER("Department Code", '%1', '');
                            IF PositionMenuOrginal.FINDSET THEN
                                REPEAT
                                    PositionMenuOrginal.DELETE;
                                UNTIL PositionMenuOrginal.NEXT = 0;
                            ORGShema."Change Org" := TRUE;
                            ORGShema.MODIFY;
                        END;
                    END;
                    //NE DOSTAJE 1 END
                    IF (Rec."Employee No." <> '') THEN BEGIN

                        ECLSis.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF ECLSis.FINDFIRST THEN BEGIN
                            IF (ECLSis."Department Category" = '') AND (ECLSis."Sector Description" <> '') THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                SectorTemp.RESET;
                                SectorTemp.SETFILTER(Code, '%1', COPYSTR(Rec.Sector, 1, j));
                                IF SectorTemp.FINDFIRST THEN BEGIN
                                END
                                ELSE BEGIN
                                    IF STRLEN(ECLSis.Sector) > 2 THEN
                                        Yes := TRUE;
                                END;
                            END;

                            //3 UKLJUČITI NA SAMOM KRAJU

                            IF (Rec."Order By Managment" = 2) OR (Yes = TRUE) THEN BEGIN
                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;



                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');

                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');

                                        END;

                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');

                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');

                                        END;

                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');

                                        END;



                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;

                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                ECLORG1nEW."Show Record" := FALSE;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D;
                                                    ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    ECLORG1nEW."Show Record" := FALSE;
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D
                                                    END;
                                                    ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    ECLORG1nEW."Show Record" := FALSE;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //       MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //   MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;
                            END;


                            // AKO JE ORDER 3 ŠALJI MI I EXE I CEO

                            Brojac := 0;
                            IF Rec."Order By Managment" = 3 THEN BEGIN

                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                // 1 END
                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;

                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;


                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;


                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;


                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');

                                        END;

                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN

                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '')


                                        END;

                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";


                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;


                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //    MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;


                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN

                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;

                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D;
                                                    ECLOrgNewb."Show Record" := TRUE;
                                                    ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                    END;
                                END;

                            END;



                            //AKO JE B2 ŠALJI MI B1,CEO I EXE

                            IF Rec."Order By Managment" = 4 THEN BEGIN

                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                //1 uključiti na kraju B2

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');

                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;


                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');

                                        END;

                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //       MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //      MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;

                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN

                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');

                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');

                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);



                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //    MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;


                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;


                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');

                                        END;

                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');

                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');
                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN


                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');

                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;


                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //     MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //     MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;
                            END;


                            //AKO JE B3 ŠALJI MI B2,B1,CEO I EXE
                            IF Rec."Order By Managment" = 5 THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                //KOJI SVE ZATVARA 1

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');

                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');
                                        END;





                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //        MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN

                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');

                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;


                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //      MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //     MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;

                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;
                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //        MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //       MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //     MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;



                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 4);
                                ECLSYST2.SETFILTER("Department Category", '%1', Rec."Department Category");
                                ECLSYST2.SETFILTER("Department Cat. Description", '%1', Rec."Department Cat. Description");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;


                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');

                                        END;



                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');

                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //           MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //           MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //           MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;

                                    END;
                                END;
                            END;






                            //AKO JE B4 ŠALJI MI B3,B2,B1,CEO I EXE
                            IF Rec."Order By Managment" = 6 THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');
                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');
                                        END;
                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //        MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;



                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;

                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');


                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //        MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;


                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //         MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;

                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 4);
                                ECLSYST2.SETFILTER("Department Category", '%1', Rec."Department Category");
                                ECLSYST2.SETFILTER("Department Cat. Description", '%1', Rec."Department Cat. Description");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //         MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 5);
                                ECLSYST2.SETFILTER(Group, '%1', Rec.Group);
                                ECLSYST2.SETFILTER("Group Description", '%1', Rec."Group Description");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');
                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //           MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //           MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //           MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;
                            END;



                            //AKO JE ŠALJI SVE S NJEGOVE ORGANIZACIJE
                            IF Rec."Order By Managment" > 6 THEN BEGIN
                                FOR i := 1 TO STRLEN(Rec.Sector) DO BEGIN
                                    String := Rec.Sector;
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 1 THEN
                                            j := i;

                                    END;
                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 1);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLORG1nEW.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLORG1nEW.TRANSFERFIELDS(ECLSYST2);
                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        IF ECLSYST2."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Team Description", '');

                                        END;

                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Group Description", '');
                                        END;
                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Sector Description", '');
                                        END;
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLORG1nEW.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLORG1nEW.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLORG1nEW.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLORG1nEW.VALIDATE("GF of work Description", '');
                                        END;
                                        ECLORG1nEW."Employee No." := ECLSYST2."Employee No.";
                                        ECLORG1nEW."Employee Name" := ECLSYST2."Employee Name";

                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLORG1nEW."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLORG1nEW."Org. Structure" := ORGShema.Code;
                                        ECLORG1nEW."Show Record" := FALSE;
                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLORG1nEW."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLORG1nEW."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLORG1nEW."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLORG1nEW."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLORG1nEW."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLORG1nEW."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLORG1nEW."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLORG1nEW."Position Description") AND (EmployeeContractLedger2.IS = ECLORG1nEW.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLORG1nEW."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLORG1nEW."IS Date To") THEN BEGIN
                                                ECLORG1nEW."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLORG1nEW."Starting Date" := ORGShema."Date From";
                                                ECLORG1nEW."Show Record" := FALSE;
                                                ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLORG1nEW."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLORG1nEW."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLORG1nEW."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLORG1nEW."Ending Date" := 0D;
                                                        ECLORG1nEW."Show Record" := TRUE;
                                                        ;
                                                        ECLORG1nEW.Status := ECLORG1nEW.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLORG1nEW.Active := FALSE;
                                        ECLORG1nEW.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLORG1nEW."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLORG1nEW."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLORG1nEW."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLORG1nEW."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //         MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //         MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLORG1nEW."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLORG1nEW."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //        MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;

                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 2);
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                if Rec."Department Category" = '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                if Rec."Department Cat. Description" = '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector Description");

                                if (Rec.Group = '') and (rec."Department Category" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                                if (Rec."Group Description" = '') and (Rec."Department Cat. Description" <> '') then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Cat. Description");

                                if Rec."Group" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group");
                                if Rec."Group Description" <> '' then
                                    ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;


                                end
                                else begin

                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                    if Posa.FindFirst() then
                                        Uprava := Posa.Code
                                    else
                                        Uprava := '';
                                end;


                                HeadOfExe.RESET;
                                HeadOfExe.SETFILTER("Position code", '%1', Uprava);
                                HeadOfExe.SETFILTER("ORG Shema", '%1', "Org. Structure");

                                IF HeadOfExe.FINDFIRST THEN
                                    HeadOfExe.CalcFields("Employee No.");






                                ECLSYST2.SETFILTER("Employee No.", '%1', HeadOfExe."Employee No.");
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;

                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);
                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //         MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //       MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;


                                ECLSYST2.RESET;
                                ECLSYST2.SETFILTER("Order By Managment", '%1', 3);
                                ECLSYST2.SETFILTER(Sector, '%1', Rec.Sector);
                                IF ECLSYST2.FINDFIRST THEN BEGIN
                                    ECLOrg.RESET;
                                    ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                    ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                    IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                        ECLOrgNewb.INIT;
                                        BR.RESET;
                                        BR.SETCURRENTKEY("No.");
                                        BR.ASCENDING;
                                        IF BR.FINDLAST THEN BEGIN
                                            IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                    ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                            END;
                                        END;
                                        ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                            DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Team Description", '');
                                        END;
                                        IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                            DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Group Description", '');
                                        END;

                                        IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                            DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                        END;
                                        IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                            DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Sector Description", '');
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN
                                            ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                        ELSE
                                            ECLOrgNewb.VALIDATE("Position Description", '');

                                        IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                        END;
                                        IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                            OrgDijelovi.RESET;
                                            OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                            OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                            IF OrgDijelovi.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("GF of work Description", '');
                                        END;


                                        ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                        ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                        END;

                                        ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                        ECLOrgNewb."Show Record" := FALSE;
                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                        EmployeeContractLedger2.RESET;
                                        EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                            IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                            AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                            AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                            AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                             (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                            END
                                            ELSE BEGIN
                                                ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                ECLOrgNewb."Show Record" := FALSE;
                                                ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                    ECLOrgNewb."Ending Date" := 0D
                                                END
                                                ELSE BEGIN
                                                    IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END
                                                    ELSE BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D;
                                                        ECLOrgNewb."Show Record" := TRUE;
                                                        ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                    END;
                                                END;
                                                EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                EmployeeContractLedger2.MODIFY(FALSE);
                                                //ECLOrg."Show Record":=FALSE;
                                            END;
                                        END;
                                        ECLOrgNewb.Active := FALSE;
                                        ECLOrgNewb.INSERT(FALSE);

                                        PositionBenef.RESET;
                                        PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                        PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                        PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                        IF PositionBenef.FINDSET THEN
                                            REPEAT
                                                MAIs.INIT;
                                                MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                MAIs."Misc. Article Code" := PositionBenef.Code;
                                                MAIs.Description := PositionBenef.Description;
                                                MAI1.RESET;
                                                //         MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                //         MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                IF MAI1.FINDFIRST THEN
                                                    MAIs."From Date" := MAI1."From Date";
                                                MAIs.Amount := PositionBenef.Amount;
                                                MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                MAIs."Org Shema" := ORGShema.Code;
                                            //          MAIs.INSERT;
                                            UNTIL PositionBenef.NEXT = 0;
                                    END;
                                END;
                                IF (Rec."Department Category" <> '') AND (Rec."Department Cat. Description" <> '') THEN BEGIN
                                    ECLSYST2.RESET;
                                    ECLSYST2.SETFILTER("Order By Managment", '%1', 4);
                                    ECLSYST2.SETFILTER("Department Category", '%1', Rec."Department Category");
                                    ECLSYST2.SETFILTER("Department Cat. Description", '%1', Rec."Department Cat. Description");
                                    IF ECLSYST2.FINDFIRST THEN BEGIN
                                        ECLOrg.RESET;
                                        ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                            ECLOrgNewb.INIT;
                                            BR.RESET;
                                            BR.SETCURRENTKEY("No.");
                                            BR.ASCENDING;
                                            IF BR.FINDLAST THEN BEGIN
                                                IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                    IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                        ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                                END;
                                            END;
                                            ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                                DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Team Description", '');
                                            END;
                                            IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                                DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Group Description", '');
                                            END;

                                            IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                                DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                            END;
                                            IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                                DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Sector Description", '');
                                            END;

                                            PositionMenuOrginal.RESET;
                                            PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                            PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                            IF PositionMenuOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Position Description", '');

                                            IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                            END;
                                            IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("GF of work Description", '');
                                            END;

                                            ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                            ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                            PositionIDFind.RESET;
                                            PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            IF PositionIDFind.FINDFIRST THEN BEGIN
                                                ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                            END;

                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            ECLOrgNewb."Show Record" := FALSE;
                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            EmployeeContractLedger2.RESET;
                                            EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                                AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                                AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                                AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                                 (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                    ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                    ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                    IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D
                                                    END
                                                    ELSE BEGIN
                                                        IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                            ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END
                                                        ELSE BEGIN
                                                            ECLOrgNewb."Ending Date" := 0D;
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END;
                                                    END;
                                                    EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                    EmployeeContractLedger2.MODIFY(FALSE);
                                                    //ECLOrg."Show Record":=FALSE;
                                                END;
                                            END;
                                            ECLOrgNewb.Active := FALSE;
                                            ECLOrgNewb.INSERT(FALSE);
                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIs.INIT;
                                                    MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                    MAIs."Misc. Article Code" := PositionBenef.Code;
                                                    MAIs.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    //              MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                    //             MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                    MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                    IF MAI1.FINDFIRST THEN
                                                        MAIs."From Date" := MAI1."From Date";
                                                    MAIs.Amount := PositionBenef.Amount;
                                                    MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                    MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                    MAIs."Org Shema" := ORGShema.Code;
                                                //           MAIs.INSERT;
                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                    END;
                                END;
                                IF (Rec.Group <> '') AND (Rec."Group Description" <> '') THEN BEGIN

                                    ECLSYST2.RESET;
                                    ECLSYST2.SETFILTER("Order By Managment", '%1', 5);
                                    ECLSYST2.SETFILTER(Group, '%1', Rec.Group);
                                    ECLSYST2.SETFILTER("Group Description", '%1', Rec."Group Description");
                                    IF ECLSYST2.FINDFIRST THEN BEGIN
                                        ECLOrg.RESET;
                                        ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                            ECLOrgNewb.INIT;
                                            BR.RESET;
                                            BR.SETCURRENTKEY("No.");
                                            BR.ASCENDING;
                                            IF BR.FINDLAST THEN BEGIN
                                                IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                    IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                        ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                                END;
                                            END;
                                            ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                                DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Team Description", '');

                                            END;
                                            IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                                DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Group Description", '');
                                            END;

                                            IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                                DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                            END;
                                            IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                                DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Sector Description", '');
                                            END;


                                            PositionMenuOrginal.RESET;
                                            PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                            PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                            IF PositionMenuOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Position Description", '');


                                            IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                            END;
                                            IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("GF of work Description", '');
                                            END;

                                            ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                            ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                            PositionIDFind.RESET;
                                            PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            IF PositionIDFind.FINDFIRST THEN BEGIN
                                                ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                            END;

                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            ECLOrgNewb."Show Record" := FALSE;
                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            EmployeeContractLedger2.RESET;
                                            EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                                AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                                AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                                AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                                 (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                    ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                    ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                    IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D
                                                    END
                                                    ELSE BEGIN
                                                        IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                            ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END
                                                        ELSE BEGIN
                                                            ECLOrgNewb."Ending Date" := 0D;
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END;
                                                    END;
                                                    EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                    EmployeeContractLedger2.MODIFY(FALSE);
                                                    //ECLOrg."Show Record":=FALSE;
                                                END;
                                            END;
                                            ECLOrgNewb.Active := FALSE;
                                            ECLOrgNewb.INSERT(FALSE);
                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIs.INIT;
                                                    MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                    MAIs."Misc. Article Code" := PositionBenef.Code;
                                                    MAIs.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    //            MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                    //            MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                    MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                    IF MAI1.FINDFIRST THEN
                                                        MAIs."From Date" := MAI1."From Date";
                                                    MAIs.Amount := PositionBenef.Amount;
                                                    MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                    MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                    MAIs."Org Shema" := ORGShema.Code;
                                                //           MAIs.INSERT;
                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                    END;
                                END;




                                IF (Rec.Team <> '') AND (Rec."Team Description" <> '') THEN BEGIN
                                    ECLSYST2.RESET;
                                    ECLSYST2.SETFILTER("Order By Managment", '%1', 6);
                                    ECLSYST2.SETFILTER(Team, '%1', Rec.Team);
                                    ECLSYST2.SETFILTER("Team Description", '%1', Rec."Team Description");
                                    IF ECLSYST2.FINDFIRST THEN BEGIN
                                        ECLOrg.RESET;
                                        ECLOrg.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                        ECLOrg.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                        IF NOT ECLOrg.FINDFIRST THEN BEGIN
                                            ECLOrgNewb.INIT;
                                            BR.RESET;
                                            BR.SETCURRENTKEY("No.");
                                            BR.ASCENDING;
                                            IF BR.FINDLAST THEN BEGIN
                                                IF BR."No." + 1 <> ECLSYST2."No." THEN BEGIN
                                                    IF ECLSYSTChangeBR.GET(ECLSYST2."No.", ECLSYST2."Employee No.") THEN
                                                        ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSYST2."Employee No.");
                                                END;
                                            END;
                                            ECLOrgNewb.TRANSFERFIELDS(ECLSYST2);
                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            IF ECLOrgNewb."Team Description" <> '' THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                                DepartmentOrginal.SETFILTER("Team Description", '%1', ECLSYST2."Team Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Team Description", ECLSYST2."Team Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Team Description", '');
                                            END;
                                            IF (ECLSYST2."Group Description" <> '') AND (ECLSYST2."Team Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                                DepartmentOrginal.SETFILTER("Group Description", '%1', ECLSYST2."Group Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Group Description", ECLSYST2."Group Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Group Description", '');
                                            END;

                                            IF (ECLSYST2."Department Cat. Description" <> '') AND (ECLSYST2."Group Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                                DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', ECLSYST2."Department Cat. Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", ECLSYST2."Department Cat. Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Department Cat. Description", '');
                                            END;
                                            IF (ECLSYST2."Sector Description" <> '') AND (ECLSYST2."Department Cat. Description" = '') THEN BEGIN
                                                DepartmentOrginal.RESET;
                                                DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                                DepartmentOrginal.SETFILTER("Sector  Description", '%1', ECLSYST2."Sector Description");
                                                DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLSYST2."Org. Structure");
                                                IF DepartmentOrginal.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Sector Description", ECLSYST2."Sector Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Sector Description", '');
                                            END;


                                            PositionMenuOrginal.RESET;
                                            PositionMenuOrginal.SETFILTER(Code, '%1', ECLSYST2."Position Code");
                                            PositionMenuOrginal.SETFILTER(Description, '%1', ECLSYST2."Position Description");
                                            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLSYST2."Department Code");
                                            IF PositionMenuOrginal.FINDFIRST THEN
                                                ECLOrgNewb.VALIDATE("Position Description", ECLSYST2."Position Description")
                                            ELSE
                                                ECLOrgNewb.VALIDATE("Position Description", '');

                                            IF ECLSYST2."Org Unit Name" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."Org Unit Name");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", ECLSYST2."Org Unit Name")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("Org Unit Name", '');
                                            END;
                                            IF ECLSYST2."GF of work Description" <> '' THEN BEGIN
                                                OrgDijelovi.RESET;
                                                OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                                OrgDijelovi.SETFILTER(Description, '%1', ECLSYST2."GF of work Description");
                                                IF OrgDijelovi.FINDFIRST THEN
                                                    ECLOrgNewb.VALIDATE("GF of work Description", ECLSYST2."GF of work Description")
                                                ELSE
                                                    ECLOrgNewb.VALIDATE("GF of work Description", '');
                                            END;

                                            ECLOrgNewb."Employee No." := ECLSYST2."Employee No.";
                                            ECLOrgNewb."Employee Name" := ECLSYST2."Employee Name";
                                            PositionIDFind.RESET;
                                            PositionIDFind.SETFILTER("Org. Structure", '%1', ECLSYST2."Org. Structure");
                                            PositionIDFind.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            IF PositionIDFind.FINDFIRST THEN BEGIN
                                                ECLOrgNewb."Position ID" := PositionIDFind."Position ID";
                                            END;

                                            ECLOrgNewb."Org. Structure" := ORGShema.Code;
                                            ECLOrgNewb."Show Record" := FALSE;
                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                            EmployeeContractLedger2.RESET;
                                            EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLSYST2."Employee No.");
                                            EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                IF (EmployeeContractLedger2."Reason for Change" = ECLOrgNewb."Reason for Change") AND (EmployeeContractLedger2."Sector Description" = ECLOrgNewb."Sector Description")
                                                AND (EmployeeContractLedger2."Department Cat. Description" = ECLOrgNewb."Department Cat. Description") AND (EmployeeContractLedger2."Group Description" = ECLOrgNewb."Group Description")
                                                AND (EmployeeContractLedger2."Team Description" = ECLOrgNewb."Team Description") AND (EmployeeContractLedger2."Org Unit Name" = ECLOrgNewb."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description" = ECLOrgNewb."GF of work Description")
                                                AND (EmployeeContractLedger2."Position Description" = ECLOrgNewb."Position Description") AND (EmployeeContractLedger2.IS = ECLOrgNewb.IS) AND
                                                 (EmployeeContractLedger2."IS Date From" = ECLOrgNewb."IS Date From") AND (EmployeeContractLedger2."IS Date To" = ECLOrgNewb."IS Date To") THEN BEGIN
                                                    ECLOrgNewb."Starting Date" := EmployeeContractLedger2."Starting Date";
                                                    ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                END
                                                ELSE BEGIN
                                                    ECLOrgNewb."Starting Date" := ORGShema."Date From";
                                                    ECLOrgNewb."Show Record" := FALSE;
                                                    ECLOrgNewb.Status := ECLORG1nEW.Status::Active;
                                                    IF EmployeeContractLedger2."Ending Date" = 0D THEN BEGIN
                                                        ECLOrgNewb."Ending Date" := 0D
                                                    END
                                                    ELSE BEGIN
                                                        IF ECLOrgNewb."Starting Date" <= EmployeeContractLedger2."Ending Date" THEN BEGIN
                                                            ECLOrgNewb."Ending Date" := EmployeeContractLedger2."Ending Date";
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END
                                                        ELSE BEGIN
                                                            ECLOrgNewb."Ending Date" := 0D;
                                                            ECLOrgNewb."Show Record" := TRUE;
                                                            ECLOrgNewb.Status := ECLOrgNewb.Status::Active;
                                                        END;
                                                    END;
                                                    EmployeeContractLedger2."Ending Date" := CALCDATE('<-1D>', ORGShema."Date From");
                                                    EmployeeContractLedger2.MODIFY(FALSE);
                                                    //ECLOrg."Show Record":=FALSE;
                                                END;
                                            END;
                                            ECLOrgNewb.Active := FALSE;
                                            ECLOrgNewb.INSERT(FALSE);

                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrgNewb."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrgNewb."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrgNewb."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIs.INIT;
                                                    MAIs."Employee No." := ECLOrgNewb."Employee No.";
                                                    MAIs."Misc. Article Code" := PositionBenef.Code;
                                                    MAIs.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    //       MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                    //        MAI1.SETFILTER("Misc. Article Code", '%1', MAIs."Misc. Article Code");
                                                    MAI1.SETFILTER(Description, '%1', MAIs.Description);
                                                    IF MAI1.FINDFIRST THEN
                                                        MAIs."From Date" := MAI1."From Date";
                                                    MAIs.Amount := PositionBenef.Amount;
                                                    MAIs."Position Code" := ECLOrgNewb."Position Code";
                                                    MAIs."Emp. Contract Ledg. Entry No." := ECLOrgNewb."No.";
                                                    MAIs."Org Shema" := ORGShema.Code;
                                                //        MAIs.INSERT;
                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                    END;
                                END;
                            END;
                            //Novi:=Novi+1;

                            ORGShema.RESET;
                            ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                            IF ORGShema.FINDFIRST THEN BEGIN

                            END;
                            ECLOrg.RESET;
                            ECLOrg.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            ECLOrg.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                            IF NOT ECLOrg.FINDFIRST THEN BEGIN

                                ECLOrg.INIT;
                                //ECLSis.VALIDATE("Starting Date",ORGShema."Date From");
                                ECLSis."Starting Date" := ORGShema."Date From";
                                BR.RESET;
                                BR.SETCURRENTKEY("No.");
                                BR.ASCENDING;
                                IF BR.FINDLAST THEN BEGIN
                                    IF BR."No." + 1 <> ECLSis."No." THEN BEGIN
                                        /*IF ECLSYSTChangeBR.GET(ECLSis."No.",ECLSis."Employee No.") THEN
                                         ECLSYSTChangeBR.RENAME(BR."No."+1,ECLSis."Employee No.") ;*/
                                    END;
                                END;
                                ECLOrg.TRANSFERFIELDS(ECLSis);
                                ECLOrg."No." := BR."No." + 1;
                                ECLOrg."Org. Structure" := ORGShema.Code;
                                IF Rec."Team Description" <> '' THEN BEGIN

                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1', 9);
                                    DepartmentOrginal.SETFILTER("Team Description", '%1', Rec."Team Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Team Description", Rec."Team Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Team Description", '');
                                END;

                                IF (Rec."Group Description" <> '') AND (Rec."Team Description" = '') THEN BEGIN
                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1', 4);
                                    DepartmentOrginal.SETFILTER("Group Description", '%1', Rec."Group Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Group Description", Rec."Group Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Group Description", '');
                                END;
                                IF (Rec."Department Cat. Description" <> '') AND (Rec."Group Description" = '') THEN BEGIN
                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 3, 5);
                                    DepartmentOrginal.SETFILTER("Department Categ.  Description", '%1', Rec."Department Cat. Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Department Cat. Description", Rec."Department Cat. Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Department Cat. Description", '');
                                END;
                                IF (Rec."Sector Description" <> '') AND (Rec."Department Cat. Description" = '') THEN BEGIN
                                    DepartmentOrginal.RESET;
                                    DepartmentOrginal.SETFILTER("Department Type", '%1|%2', 2, 1);
                                    DepartmentOrginal.SETFILTER("Sector  Description", '%1', Rec."Sector Description");
                                    DepartmentOrginal.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                    IF DepartmentOrginal.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Sector Description", Rec."Sector Description")
                                    ELSE
                                        ECLOrg.VALIDATE("Sector Description", '');
                                END;


                                PositionMenuOrginal.RESET;
                                PositionMenuOrginal.SETFILTER(Code, '%1', Rec."Position Code");
                                PositionMenuOrginal.SETFILTER(Description, '%1', Rec."Position Description");
                                PositionMenuOrginal.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                                PositionMenuOrginal.SETFILTER("Department Code", '%1', Rec."Department Code");
                                IF PositionMenuOrginal.FINDFIRST THEN
                                    ECLOrg.VALIDATE("Position Description", Rec."Position Description")
                                ELSE
                                    ECLOrg.VALIDATE("Position Description", '');

                                IF Rec."Org Unit Name" <> '' THEN BEGIN
                                    OrgDijelovi.RESET;
                                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                    OrgDijelovi.SETFILTER(Description, '%1', Rec."Org Unit Name");
                                    IF OrgDijelovi.FINDFIRST THEN
                                        ECLOrg.VALIDATE("Org Unit Name", Rec."Org Unit Name")
                                    ELSE
                                        ECLOrg.VALIDATE("Org Unit Name", '');
                                END;
                                IF Rec."GF of work Description" <> '' THEN BEGIN
                                    OrgDijelovi.RESET;
                                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                                    OrgDijelovi.SETFILTER(Description, '%1', Rec."GF of work Description");
                                    IF OrgDijelovi.FINDFIRST THEN
                                        ECLOrg.VALIDATE("GF of work Description", Rec."GF of work Description")
                                    ELSE
                                        ECLOrg.VALIDATE("GF of work Description", '');
                                END;

                                ECLOrg."Employee No." := Rec."Employee No.";
                                ECLOrg."Employee Name" := Rec."Employee Name";
                                ECLOrg."Operator No." := USERID;
                                ECLOrg."Starting Date" := 0D;
                                PositionIDFind.RESET;
                                PositionIDFind.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                                PositionIDFind.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                IF PositionIDFind.FINDFIRST THEN BEGIN
                                    ECLOrg."Position ID" := PositionIDFind."Position ID";
                                END;

                                ECLOrg."Org. Structure" := ORGShema.Code;
                                ECLOrg."Show Record" := TRUE;
                                ECLOrg.Status := ECLOrg.Status::Active;
                                /*
                              EmployeeContractLedger2.RESET;
                              EmployeeContractLedger2.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                              EmployeeContractLedger2.SETFILTER(Active,'%1',TRUE);
                              IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                              IF (EmployeeContractLedger2."Reason for Change"=Rec."Reason for Change") AND (EmployeeContractLedger2."Sector Description"=Rec."Sector Description")
                              AND(EmployeeContractLedger2."Department Cat. Description"=Rec."Department Cat. Description") AND (EmployeeContractLedger2."Group Description"=Rec."Group Description")
                              AND (EmployeeContractLedger2."Team Description"=Rec."Team Description") AND (EmployeeContractLedger2."Org Unit Name"=Rec."Org Unit Name") AND (EmployeeContractLedger2."GF of work Description"=Rec."GF of work Description")
                              AND (EmployeeContractLedger2."Position Description"=Rec."Position Description") AND (EmployeeContractLedger2.IS=Rec.IS) AND
                               (EmployeeContractLedger2."IS Date From"=Rec."IS Date From") AND (EmployeeContractLedger2."IS Date To"=Rec."IS Date To") THEN BEGIN
                               ECLOrg."Starting Date":=EmployeeContractLedger2."Starting Date";
                               ECLOrg."Ending Date":=EmployeeContractLedger2."Ending Date";
                               ECLOrg."Show Record":=FALSE;
                                ECLOrg.Status:=ECLOrg.Status::Active;
                              END
                              ELSE BEGIN */
                                ECLOrg."Starting Date" := 0D;
                                ECLOrg."Work Days" := 0;
                                ECLOrg."Work Months" := 0;
                                ECLOrg."Work Years" := 0;
                                ECLOrg."Probation Days" := 0;
                                ECLOrg."Probation Months" := 0;
                                ECLOrg."Probation Year" := 0;
                                ECLOrg."Show Record" := TRUE;
                                ECLOrg.Status := ECLOrg.Status::Active;
                                /*IF EmployeeContractLedger2."Ending Date"=0D THEN BEGIN
                                  ECLOrg."Work Days":=0;
                                                  ECLOrg."Work Months":=0;
                                                  ECLOrg."Work Years":=0;
                                                  ECLOrg."Probation Days":=0;
                                                  ECLOrg."Probation Months":=0;
                                                  ECLOrg."Probation Year":=0;
                                ECLOrg."Ending Date":=0D
                                END
                                ELSE BEGIN
                                  IF ECLOrg."Starting Date"<=EmployeeContractLedger2."Ending Date" THEN BEGIN
                                ECLOrg."Ending Date":=0D;

                                                  ECLOrg."Work Days":=0;
                                                  ECLOrg."Work Months":=0;
                                                  ECLOrg."Work Years":=0;
                                                  ECLOrg."Probation Days":=0;
                                                  ECLOrg."Probation Months":=0;
                                                  ECLOrg."Probation Year":=0;

                                       ECLOrg."Show Record":=TRUE;
                                  ECLOrg.Status:=ECLOrg.Status::Active;
                                    END
                                    ELSE BEGIN
                                      ECLOrg."Ending Date":=0D;

                                                  ECLOrg."Work Days":=0;
                                                  ECLOrg."Work Months":=0;
                                                  ECLOrg."Work Years":=0;
                                                  ECLOrg."Probation Days":=0;
                                                  ECLOrg."Probation Months":=0;
                                                  ECLOrg."Probation Year":=0;
                                         ECLOrg."Show Record":=TRUE;;
                                  ECLOrg.Status:=ECLOrg.Status::Active;
                                      END;
                                END;
                                //EmployeeContractLedger2."Ending Date":=CALCDATE('<-1D>',ORGShema."Date From");
                                EmployeeContractLedger2.MODIFY(FALSE);
                                  //ECLOrg."Show Record":=FALSE;
                                END;
                                  END;*/
                                ECLOrg."Attachment No." := 0;
                                //    ECLOrg."Agreement Name" := '';
                                ECLOrg."Agremeent Code" := '';
                                ECLOrg.Active := FALSE;
                                Finddate.RESET;
                                Finddate.SETFILTER(Status, '%1', Finddate.Status::Preparation);
                                IF Finddate.FINDFIRST THEN BEGIN
                                    ECL5.RESET;
                                    ECL5.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                    ECL5.SETFILTER("Starting Date", '<=%1', Finddate."Create date of org.prep");
                                    ECL5.SETCURRENTKEY("Starting Date");
                                    ECL5.ASCENDING;
                                    IF ECL5.FINDLAST THEN BEGIN
                                        IF ECL5."Reason for Change" = Rec."Reason for Change" THEN BEGIN
                                            ECLOrg."Reason for Change" := ECLOrg."Reason for Change"::Systematization;
                                            Rec."Reason for Change" := Rec."Reason for Change"::Systematization;
                                        END;
                                    END;
                                END;

                                DateOrg.RESET;
                                DateOrg.SETFILTER(Status, '%1', DateOrg.Status::Preparation);
                                IF DateOrg.FINDFIRST THEN BEGIN
                                    ECL5.RESET;
                                    ECL5.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                    ECL5.SETFILTER("Starting Date", '<=%1', DateOrg."Create date of org.prep");
                                    ECL5.SETCURRENTKEY("Starting Date");
                                    ECL5.ASCENDING;
                                    IF ECL5.FINDLAST THEN BEGIN
                                        IF ECL5."Reason for Change" = Rec."Reason for Change" THEN BEGIN
                                            ECLOrg."Reason for Change" := ECLOrg."Reason for Change"::Systematization;
                                            Rec."Reason for Change" := Rec."Reason for Change"::Systematization;
                                        END;
                                    END;
                                END;
                                ECLOrg.Change := FALSE;
                                ECLOrg."Change other documents" := FALSE;
                                ECLOrg.INSERT(FALSE);
                                ORGShema.RESET;
                                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                                IF ORGShema.FINDFIRST THEN BEGIN

                                END;
                                PositionBenef.RESET;
                                PositionBenef.SETFILTER("Position Code", '%1', ECLOrg."Position Code");
                                PositionBenef.SETFILTER("Position Name", '%1', ECLOrg."Position Description");
                                PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrg."Org. Structure");
                                IF PositionBenef.FINDSET THEN
                                    REPEAT
                                        MAIs.INIT;
                                        MAIs."Employee No." := ECLOrg."Employee No.";
                                        MAIs."Misc. Article Code" := PositionBenef.Code;
                                        MAIs.Description := PositionBenef.Description;
                                        IF "Changing Position" = TRUE THEN
                                            MAIs."From Date" := ORGShema."Date From";
                                        MAIs.Amount := PositionBenef.Amount;
                                        MAIs."Position Code" := ECLOrg."Position Code";
                                        MAIs."Emp. Contract Ledg. Entry No." := ECLOrg."No.";
                                        MAIs."Org Shema" := ORGShema.Code;
                                        MAIs.INSERT;
                                    UNTIL PositionBenef.NEXT = 0;


                            END;

                        END;
                    END;
                END;
                /* IF "Will Be Changed Later"=TRUE THEN
                 "Changing Position":=FALSE;
                 IF "Will Be Changed Later"=FALSE THEN
                 "Changing Position":=FALSE;
                 */

                IF xRec."Will Be Changed Later" = TRUE THEN BEGIN

                    ECLDelete.RESET;
                    ECLDelete.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    ECLDelete.SETFILTER("Org. Structure", '%1', ORGShema.Code);
                    IF ECLDelete.FINDFIRST THEN BEGIN

                        ECLDelete.DELETE;
                        PositionDelete2.RESET;
                        PositionDelete2.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        PositionDelete2.SETFILTER(Description, '%1', Rec."Position Description");
                        PositionDelete2.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                        PositionDelete2.SETFILTER("Sector  Description", '%1', Rec."Sector Description");
                        PositionDelete2.SETFILTER("Department Categ.  Description", '%1', Rec."Department Cat. Description");
                        PositionDelete2.SETFILTER("Group Description", '%1', Rec."Group Description");
                        PositionDelete2.SETFILTER("Team Description", '%1', Rec."Team Description");
                        IF PositionDelete2.FINDFIRST THEN
                            PositionDelete2.DELETE;

                    END;
                    MaiDelete.RESET;
                    MaiDelete.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    //  MaiDelete.SETFILTER("Org Shema", '%1', Rec."Org. Structure");
                    IF MaiDelete.FINDSET THEN
                        REPEAT
                        //        MaiDelete.DELETE;
                        UNTIL MaiDelete.NEXT = 0;


                END;
                EmployeeContract.RESET;
                EmployeeContract.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                EmployeeContract.SETFILTER("Starting Date", '>%1', WORKDATE);
                IF EmployeeContract.FINDSET THEN
                    REPEAT
                        IF (EmployeeContract."Position Description" <> Rec."Position Description") OR (EmployeeContract."Org Belongs" <> Rec."Org Belongs")
                          THEN BEGIN
                            EmployeeContract.Conflict := TRUE;
                            EmployeeContract.MODIFY;
                        END;
                    UNTIL EmployeeContract.NEXT = 0;
                ORGShema.RESET;
                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Preparation);
                IF ORGShema.FINDLAST THEN BEGIN
                    OrgShema1.RESET;
                    OrgShema1.SETFILTER(Status, '%1', ORGShema.Status::Active);
                    IF OrgShema1.FINDLAST THEN BEGIN

                        ECL5.RESET;
                        ECL5.SETFILTER("Starting Date", '>%1', ORGShema."Create date of org.prep");
                        ECL5.SETFILTER("Modify the change is update", '%1', FALSE);
                        ECL5.SETFILTER("Org. Structure", '%1', OrgShema1.Code);
                        IF ECL5.FINDSET THEN
                            REPEAT
                                IF ECL5."Starting Date" <= WORKDATE THEN BEGIN
                                    ECL5.Conflict := TRUE;
                                    ECL5.MODIFY;
                                END;
                            UNTIL ECL5.NEXT = 0;
                    END;
                END;

            end;
        }
        field(50413; "Temporary disposition starting"; Date)
        {
            Caption = 'Temporary disposition starting';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Contract Type" = '-1') OR ("Contract Type" = '4') OR ("Contract Type" = '5')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(50414; "Temporary disposition ending"; Date)
        {
            Caption = 'Temporary disposition ending';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Contract Type" = '-1') OR ("Contract Type" = '4') OR ("Contract Type" = '5')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(504014; "Order By Managment"; Integer)
        {
        }
        field(504115; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                /* IF "Dimension Value Code"<>''then BEGIN
                 "Dimension Code":='TC'*/
                /* IF "Dimension Value Code"<>'' THEN BEGIN
               DimensionValueTable.RESET;
               DimensionValueTable.SETFILTER(Code,'%1',Rec."Dimension Value Code");
               IF DimensionValueTable.FINDFIRST THEN BEGIN
               "Dimension  Name":=DimensionValueTable.Name;
               END
               ELSE BEGIN
                  "Dimension  Name":='';
                  END;
                     END;*/

            end;
        }
        field(504116; "Dimension  Name"; Text[100])
        {
            Caption = 'Dimension Code';
            Editable = true;
            TableRelation = "Dimension Value".Name WHERE(Status = CONST(A));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                DimensionValueTable.RESET;
                DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                IF DimensionValueTable.FINDFIRST THEN BEGIN
                    "Dimension Value Code" := DimensionValueTable.Code;
                END
                ELSE BEGIN
                    "Dimension Value Code" := '';
                END;

            end;
        }
        field(504117; "Sector Identity"; Integer)
        {
            FieldClass = Normal;
        }
        field(594118; "Org Belongs"; Text[130])
        {
            Caption = 'Org Belongs';
            Editable = true;
            TableRelation = "Department temporary".Description;

            trigger OnValidate()
            begin
                IF "Org Belongs" <> '' THEN BEGIN
                    DepartmentTempReal.RESET;
                    DepartmentTempReal.SETFILTER(Description, '%1', "Org Belongs");
                    IF DepartmentTempReal.FINDFIRST THEN BEGIN
                        Sector := DepartmentTempReal.Sector;
                        "Sector Description" := DepartmentTempReal."Sector  Description";
                        "Department Category" := DepartmentTempReal."Department Category";
                        "Department Cat. Description" := DepartmentTempReal."Department Categ.  Description";
                        Group := DepartmentTempReal."Group Code";
                        "Group Description" := DepartmentTempReal."Group Description";
                        Team := DepartmentTempReal."Team Code";
                        "Team Description" := DepartmentTempReal."Team Description";
                        IF "Team Description" <> '' THEN
                            "Department Code" := Team;
                        IF ("Team Description" = '') AND ("Group Description" <> '') THEN
                            "Department Code" := Group;
                        IF ("Department Cat. Description" <> '') AND ("Group Description" = '') THEN
                            "Department Code" := "Department Category";
                        IF ("Department Cat. Description" = '') AND ("Sector Description" <> '') and ("Group Description" = '') THEN
                            "Department Code" := Sector;
                        SectorTemp1.RESET;
                        SectorTemp1.SETFILTER(Description, '%1', "Sector Description");
                        IF SectorTemp1.FINDFIRST THEN
                            "Sector Identity" := SectorTemp1.Identity;

                    END;
                END

                ELSE BEGIN

                    VALIDATE("Team Description", '');
                    VALIDATE("Group Description", '');
                    VALIDATE("Department Cat. Description", '');
                    VALIDATE("Sector Description", '');
                    "Dimension Value Code" := '';
                    "Dimension  Name" := '';



                END;

                IF "Position Description" <> '' THEN BEGIN
                    DimensiontempForPos.RESET;
                    DimensiontempForPos.SETFILTER("Sector  Description", '%1', "Sector Description");
                    DimensiontempForPos.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                    DimensiontempForPos.SETFILTER("Group Description", '%1', "Group Description");
                    DimensiontempForPos.SETFILTER("Team Description", '%1', "Team Description");
                    DimensiontempForPos.SETFILTER("Position Description", '%1', "Position Description");


                    PositionMenuTemp.RESET;
                    PositionMenuTemp.SETFILTER(Description, '%1', Rec."Position Description");
                    PositionMenuTemp.SETFILTER(Code, '%1', Rec."Position Code");
                    IF PositionMenuTemp.FINDFIRST THEN BEGIN

                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::CEO THEN BEGIN
                            Rec."Order By Managment" := 1;
                            "Management Level" := "Management Level"::CEO;
                        END;
                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::Exe THEN BEGIN
                            "Order By Managment" := 2;
                            "Management Level" := "Management Level"::Exe;
                        END;
                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::Sector THEN BEGIN
                            "Order By Managment" := 3;
                            "Management Level" := "Management Level"::Sector;
                        END;
                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::"Department Category" THEN BEGIN
                            "Order By Managment" := 4;
                            "Management Level" := "Management Level"::"Department Category";
                        END;
                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::Group THEN BEGIN
                            "Order By Managment" := 5;
                            "Management Level" := "Management Level"::Group;
                        END;
                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::E THEN BEGIN
                            "Order By Managment" := 6;
                            "Management Level" := "Management Level"::E;
                        END;

                        IF PositionMenuTemp."Management Level" = PositionMenuTemp."Management Level"::Empty THEN BEGIN
                            "Order By Managment" := 7;
                            "Management Level" := "Management Level"::Empty;
                        END;
                    END;
                END
                ELSE BEGIN
                    "Position Code" := '';
                    "Dimension  Name" := '';
                    "Dimension Value Code" := '';
                END;

                //Rec."Difference Org/Position":=FALSE;

                DVCheck.Reset();
                DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                DVCheck.SetFilter(Name, '%1', Rec.Sector);
                if not DVCheck.FindFirst() then begin
                    DVCheck.Init();
                    DVCheck."Dimension Code" := 'TC';
                    DVCheck.Code := Rec.Sector;
                    DVCheck.Name := copystr(Rec."Sector Description", 1, 50);
                    DVCheck.Status := DVCheck.Status::A;
                end;

                DVCheck.Reset();
                DVCheck.SetFilter(Name, '%1', '');
                if DVCheck.FindFirst() then
                    Rec.validate("Dimension  Name", Rec.Sector);
            end;
        }
        field(594119; "Engagement Type"; Text[100])
        {
            Caption = 'Engagement Type ';
            TableRelation = "Employment Contract".Description WHERE(Description = FILTER(<> 'ANEKS'));
        }
        field(594120; "The Change is update"; Boolean)
        {
            Caption = 'The Change is update';
        }
        field(594121; Conflict; Boolean)
        {
            Caption = 'Conflict';
        }
        field(594122; "Modify the change is update"; Boolean)
        {
        }
        field(594124; "Is not extended"; Boolean)
        {
            Caption = 'Is not extended';
        }
        field(594125; "Is not extended expired"; Boolean)
        {
            Caption = 'Is not extended expired';
        }
        field(594126; "Is not extended P"; Boolean)
        {
            Caption = 'Is not extended P';
        }
        field(594127; "Is not extended expired P"; Boolean)
        {
            Caption = 'Is not extended expired P';
        }
        field(594128; "Three Years in company"; Boolean)
        {
            Caption = 'Three Years in company';
        }
        field(594223; "Difference Org/Position"; Boolean)
        {
            Caption = 'Difference Org/Position';
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        AttachmentRecord: Record "Attachment";
        HeadOfExe: Record "Head Of's temporary";
        ExeManager: Record "Exe Manager temporery";
        DVCheck: Record "Dimension Value";
        Posa: Record "Position Menu temporary";
        gro: Date;
        ECLCD: Record "ECL systematization";
        BruttoTotal: Decimal;
        TaxWe: Decimal;
        BruttoAfterDeductionWE: Decimal;
        BruttoAfterContributionWE: Decimal;
        WageAmounts: Record "Wage Amounts";
        EmployeeContractLedger: Record "ECL systematization";
        ConCat: Record "Contribution Category";
        BruttoAfterContribution: Decimal;
        BruttoAfterDeduction: Decimal;
        Employee: Record "Employee";
        SectorParent22: Record "Head Of's temporary";
        CompanyInfo: Record "Company Information";
        DateOrg: Record "ORG Shema";
        Employee1: Record "Employee";
        EmployeeContractLedger1: Record "ECL systematization";
        NewReport: Report "Update Head Of table";
        SectorParent2: Record "Sector";
        OrgSNew: Record "ORG Shema";
        Emp: Record "Employee";
        ECL: Record "ECL systematization";
        PostCode: Record "Post Code";
        GroundsForTermination: Record "Grounds for Termination";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        position: Record "Position temporery";
        "Position Benef": Record "Position Benefits temporery";
        MAI: Record "Misc. article information";
        IDMonth: Integer;
        TotalDays: Integer;
        WC: Record "Wage Calculation";
        Department: Record "Department temporary";
        ORG: Record "ORG Dijelovi";
        StartDate: Date;
        EndDate: Date;
        EDF: Record "Employee Default Dimension";
        DV: Record "Dimension Value";
        ORGShema: Record "ORG Shema";
        parent2: Code[30];
        parent3: Code[30];
        WPConnSetup: Record "Web portal connection setup";
        MaiDelete: Record "Misc. article information";
        /*conn: Automation;
        comm: Automation;
        param: Automation;*/
        lvarActiveConnection: Variant;
        Uprava: Code[20];
        //   WDV: Record "Work Duties Violation";
        // WDVM: Record "Work Duties Violation";
        // WDVR: Record "Work Duties Violation";
        //   CM: Record "Comission Members";
        /*  SegmentationGroupWDM: Record "Segmentation Data";
          SegmentationGroupWDR: Record "Segmentation Data";
          SegmentationGroupWD: Record "Segmentation Data";
          SegmentationGroupCM: Record "Segmentation Data";*/
        DepartmentW: Record "Department temporary";
        DepartmentM: Record "Department temporary";
        DepartmentR: Record "Department temporary";
        DepartmentCM: Record "Department temporary";
        // SegmentationP: Record "Segmentation Data";
        WPConnSetupPos: Record "Web portal connection setup";
        /*connPos: Automation;
        commPos: Automation;
        paramPos: Automation;*/
        lvarActiveConnectionPos: Variant;
        pos: Record "Position temporery";
        TeamRec: Record "Team temporary";
        DepCat: Record "Department Category temporary";
        Sec: Record "Sector temporary";
        Gr: Record "Group temporary";
        //    DocumentReg: Record "Document Register";
        WorkBook: Record "Work Booklet";
        WorkBook2: Record "Work Booklet";
        R_WorkExperience: Report "Work exp.in Comp.by Emp";
        OrgDijelovi: Record "ORG Dijelovi";
        ID_Month_novi: Integer;
        OneDay: Date;
        MonthDays: Date;
        NewPosition: Record "Position";
        RecDate: Record "Date";
        LastFoundDate: Date;
        TempDate: Date;
        Found: Boolean;
        CountYears: Integer;
        CountMonths: Integer;
        CountDays: Integer;
        RecDate1: Record "Date";
        LastFoundDate1: Date;
        TempDate1: Date;
        Found1: Boolean;
        CountMonths1: Integer;
        CountDays1: Integer;
        MannersForTermination: Record "Manner for Termination";
        EmploymentContract: Record "Employment Contract";
        Empl: Record "Employee";
        CountYears1: Integer;
        EmpOrg: Record "Employee";
        LastDate: Date;
        Feb: Integer;
        LengthCode: Integer;
        PosD: Record "Position temporery";
        ECLProb: Record "ECL systematization";
        posDis: Record "Position";
        Answer: Boolean;
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
        //   DR: Record "Document Register";
        ReportLayoutSelection: Record "Report Layout Selection";
        // ContractR: Report "test";
        // DR1: Record "Document Register";
        CRL1: Record "Custom Report Layout";
        // OtheDocumentRegister: Record "Other Document Register";
        //ODR: Record "Other Document Register";
        NewOtherAttachNo: Integer;
        CRL: Record "Custom Report Layout";
        // OtherDocumentRegister: Record "Other Document Register";
        CLR4: Record "Custom Report Layout";
        //  ContractTermination: Report "Agreement of termination -r";
        PosNew: Record "Position temporery";
        ID: Integer;
        ActivePosition: Record "Position temporery";
        ActiveECL: Record "ECL systematization";
        "Max": Integer;
        PositionDelete: Record "Position temporery";
        ECLNumber: Record "ECL systematization";
        ECLBefore: Record "ECL systematization";
        FileManagement: Codeunit "File Management";
        BrojUgovora: Integer;
        EclCheck: Record "ECL systematization";
        tempSaveDest: Text;
        /*ContractNEODREDJENOUTOKU: Report "60504";
        Contract60534: Report "60534";
        Contract60504: Report "60504";
        Contract60505: Report "60505";
        Contract60506: Report "60506";
        Contract60507: Report "60507";
        Contract60508: Report "60508";
        Contract60509: Report "60509";
        Contract60510: Report "60510";
        Contract60511: Report "60511";
        Contract60512: Report "60512";
        Contract60513: Report "60513";
        Contract60514: Report "60514";
        Contract60515: Report "60515";
        Contract60516: Report "60516";
        Contract60518: Report "60518";
        Contract60517: Report "60517";
        Contract60519: Report "60519";
        Contract60520: Report "60520";
        Contract60521: Report "60521";
        Contract60522: Report "60522";
        Contract60523: Report "60523";*/
        Text000: Label 'Start Date must have value.';
        Text001: Label 'End Date must not be before Start date.';
        Text002: Label 'Personalni broj ne smije biti prazan!';
        Text003: Label 'You have canceled the create process.';
        Text004: Label 'Replace existing attachment?';
        Text005: Label 'You have canceled the import process.';
        Text006: Label 'Export Attachment';
        Text007: Label 'Da li ste sigurni da zelite promijeniti vrijednost polja iz %1 u %2?';
        DepartmentFind: Record "Department temporary";
        PositonMenuTemp: Record "Position Menu temporary";
        DimensionTemp: Record "Dimension temp for position";
        PositionTempInsert: Record "Position temporery";
        PositionTempInsertNEW: Record "Position temporery";
        ForSis: Record "Sector temporary";
        ForSis1: Record "Department Category temporary";
        HeadOf: Record "Head Of's temporary";
        DepFindHead: Record "Department temporary";
        PositionFind: Record "Position temporery";
        PositionFind1: Record "Position temporery";
        PositionFindID: Record "Position temporery";
        idnext: Integer;
        GroupTem: Record "Group temporary";
        DepCatTemp: Record "Department Category temporary";
        SectorTemp: Record "Sector temporary";
        PositionMenuTemp: Record "Position Menu temporary";
        ECLTC: Record "Dimension temp for position";
        DimensionValueTable: Record "Dimension Value";
        DepartmentTempReal: Record "Department temporary";
        DimensionTempFindTC: Record "Dimension temporary";
        DimensiontempForPos: Record "Dimension temp for position";
        SectorOrginal: Record "Sector";
        DepCatOrginal: Record "Department Category";
        SectorOrginal1: Record "Sector";
        DepCatOrginal1: Record "Department Category";
        GroupOrginal: Record "Group";
        GroupOrginal1: Record "Group";
        GroupTemp: Record "Group temporary";
        TeamTemp: Record "Team temporary";
        //     TeamOrginal: Record "TeamT";
        //   TeamOrginal1: Record "TeamT";
        DepartmentTemp: Record "Department temporary";
        DepartmentOrginal: Record "Department";
        DepartmentOrginal1: Record "Department";
        HeadOfTemp: Record "Head Of's temporary";
        HeadOfOrginal: Record "Head Of's";
        HeadOfOrginal1: Record "Head Of's";
        DimensionOrginalPos: Record "Dimension for position";
        DimensionTempPos: Record "Dimension temp for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuOrginal: Record "Position Menu";
        ECLOrg11: Record "Employee Contract Ledger";
        PositionMenuOrginal1: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        ECLSyst: Record "ECL systematization";
        ECLOrg: Record "Employee Contract Ledger";
        PoSMenDUp: Record "Position Menu";
        Brojac: Integer;
        ECLSis: Record "ECL systematization";
        Novi: Integer;
        PositionIDFind: Record "Position";
        DimensionForPos: Record "Dimension for position";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        OrgShemaA: Record "ORG Shema";
        //    ReportNotification: Report "Systematization e-mail";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsOrginal1: Record "Position Benefits";
        ECLOrg1: Record "Employee Contract Ledger";
        ELCEndDATE: Record "Employee Contract Ledger";
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        ECLORG1nEW: Record "Employee Contract Ledger";
        ECLSYST2: Record "ECL systematization";
        Yes: Boolean;
        String: Text;
        i: Integer;
        j: Integer;
        ECLOrgNewb: Record "Employee Contract Ledger";
        SectorTemp1: Record "Sector temporary";
        PositionBenef: Record "Position Benefits temporery";
        MAIs: Record "Misc. article information";
        MAI1: Record "Misc. article information";
        PosMne: Record "Dimension for position";
        EmployeeContract: Record "Employee Contract Ledger";
        BR: Record "Employee Contract Ledger";
        ECLSYSTChangeBR: Record "ECL systematization";
        ECLDelete: Record "Employee Contract Ledger";
        ECLDate: Record "Employee Contract Ledger";
        ECLEndingDate: Record "Employee Contract Ledger";
        PositionDelete2: Record "Position";
        OrgShema1: Record "ORG Shema";
        ECL5: Record "Employee Contract Ledger";
        Finddate: Record "ORG Shema";
        DepCat22: Record "Department Category";
        GroupCat22: Record "Group";
    //   TeamCat22: Record "TeamT";

    procedure CreateAttachment()
    var
        Attachment: Record "Attachment";
        InteractTmplLanguage: Record "Employee Contract Ledger";
        WordManagement: Codeunit "WordManagement";
        NewAttachNo: Integer;
    begin
    end;

    procedure OpenAttachment()
    var
        Attachment: Record "Attachment";
    begin
        /*{IF "Attachment No." = 0 THEN
          EXIT;
        Attachment.GET("Attachment No.");
        {IF Change=TRUE THEN BEGIN
        Attachment.OpenAttachment(FORMAT("No.")+ ' ' + "Employee No.",FALSE,'');}
          END
          ELSE BEGIN}
          CLEAR(ContractR);
          CLEAR(FileManagement);
        DR.SETFILTER("Agreement Code",'%1',"Agremeent Code");
        IF DR.FIND('-') THEN BEGIN
          CRL.SETFILTER("Report ID",'%1',DR."NAV Agreement Code");
          IF CRL.FIND('-') THEN BEGIN
           ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
           IF "Agremeent Code"='26' THEN BEGIN
           { ContractR.SetParam("Employee No.",'26');
             // REPORT.RUNMODAL(DR."NAV Agreement Code");
            ContractR.RUN;}
            ContractR.SetParam("Employee No.",'26');
        
          //REPORT.RUN(60251,FALSE,FALSE);
         // ContractR.RUN; // ovo otvara report kao dialog -- ne treba nam to ovo je problem
        
          tempSaveDest := 'C:\Temp\'+FORMAT("Employee No.")+'.docx';
          ContractR.SAVEASWORD(tempSaveDest);
          FileManagement.DownloadToFile(tempSaveDest,tempSaveDest);
            END;
           ReportLayoutSelection.SetTempLayoutSelected(0);
           END;
        
        END;*/
        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment(FORMAT("No.") + ' ' + "Employee No.", FALSE, '');

    end;

    procedure CopyFromAttachment()
    var
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
    begin
        IF Attachment.GET("Attachment No.") THEN
            Attachment.TESTFIELD("Read Only", FALSE);

        IF "Attachment No." <> 0 THEN BEGIN
            IF NOT CONFIRM(Text004, FALSE) THEN
                EXIT;
            RemoveAttachment(FALSE);
            "Attachment No." := 0;
            MODIFY;
            COMMIT;
        END;

        //InteractTmplLanguage.SETFILTER("Attachment No.",'<>%1',0);
        //IF PAGE.RUNMODAL(0,InteractTmplLanguage) = ACTION::LookupOK THEN BEGIN
        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
        IF NewAttachNo <> 0 THEN BEGIN
            "Attachment No." := NewAttachNo;
            MODIFY;
        END;
        //END;
    end;

    procedure ImportAttachment()
    var
        Attachment: Record "Attachment";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            /* IF NOT CONFIRM(Text001,FALSE) THEN
               EXIT;*/
        END;
        ECL.RESET;
        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        IF ECL.FIND('-') THEN BEGIN
            BrojUgovora := ECL.COUNT;
        END;
        // ĐK Attachment.SetParam(Rec."Employee No.", "No.", 1);
        IF Attachment.ImportAttachmentFromClientFile('C:\Temp' + '\' + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx', FALSE, FALSE) THEN BEGIN
            "Attachment No." := Attachment."No.";
            /* Change:=TRUE;
             MODIFY;*/
        END;
        /*END ELSE
          ERROR(Text002);*/

    end;

    procedure ExportAttachment()
    var
        TempBlob: Codeunit "Temp Blob";
        MarketingSetup: Record "Marketing Setup";
        FileMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text;
        ExportToFile: Text;
    begin
        MarketingSetup.GET;
        ExportToFile := '';
        IF AttachmentRecord.GET("Attachment No.") THEN
            WITH AttachmentRecord DO BEGIN
                IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN
                    /* CALCFIELDS(Attachment);
                     IF Attachment.HASVALUE THEN BEGIN
                         FileName := "Employee No." + '.' + "File Extension";
                         TempBlob.Blob := Attachment;
                         FileMgt.BLOBExport(TempBlob, FileName, TRUE);
                     END;*/
                END ELSE BEGIN
                    IF "Storage Type" = "Storage Type"::"Disk File" THEN BEGIN
                        IF MarketingSetup."Attachment Storage Type" = MarketingSetup."Attachment Storage Type"::"Disk File" THEN
                            MarketingSetup.TESTFIELD("Attachment Storage Location");
                        FileFilter := UPPERCASE("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
                    END;

                    ExportToFile := "Employee No." + '.' + "File Extension";
                    DOWNLOAD(ConstDiskFileName, Text005, '', FileFilter, ExportToFile);
                END;
            END;
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Attachment No.") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Attachment No." := 0;
                MODIFY;
            END;
    end;

    local procedure ConstDiskFileName() DiskFileName: Text[1024]
    begin
        DiskFileName := AttachmentRecord."Storage Pointer" + '\' + FORMAT(AttachmentRecord."No.") + '.';
    end;
}

