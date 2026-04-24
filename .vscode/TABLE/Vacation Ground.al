table 50015 "Vacation Ground 2"
{
    Caption = 'Vacation Ground 2';

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                t_Employee.SETFILTER("No.", '%1', "Employee No."); //uzima jednog zaposlenog ciji No je unesen 
                IF t_Employee.FIND('-') THEN BEGIN
                    "First Name" := t_Employee."First Name";
                    "Last Name" := t_Employee."Last Name";
                    "Work experience" := t_Employee."Years of Experience";
                END;

                Year := DATE2DMY(WORKDATE, 3);

                //OVO NIJE BIO KOMENTAR
                /*VacationSetup.GET;                 
                "Legal Grounds" := VacationSetup."Base Days";*/

                VacationSetuphistory.SETFILTER(Year, '%1', Year);
                IF VacationSetuphistory.FindFirst() then;
                "Legal Grounds" := VacationSetuphistory."Base Days";

                //"End Date of Year" := DMY2DATE(1, 12, CurrYear);
                //LastDateOfMonth:=CALCDATE('-1D', CALCDATE('+1M',"End Date of Year"));
                //MESSAGE(FORMAT(LastDateOfMonth));

                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
                EVALUATE(Order, "Employee No.");

                EmployeeRec.RESET;
                EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                IF EmployeeRec."Returned to Company" = FALSE THEN BEGIN
                    UsedDaysThisYear := 0;
                    Year2 := DATE2DMY(TODAY, 3);
                    WB.RESET;
                    PlanGO.RESET;
                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL.SETFILTER("Reason for Change", '%1', 1);
                    ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                    //ECL.SETFILTER(Active,'%1',TRUE);
                    IF ECL.FINDFIRST THEN BEGIN
                        WB.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        IF WB.FIND('+') THEN BEGIN
                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(TODAY, 3) THEN
                                "Legal Grounds" := WB.Months - (12 - DATE2DMY(WB."Starting Date", 2))
                            ELSE
                                "Legal Grounds" := WB.Months;
                            Year := Year2;

                            Absence.RESET;
                            Absence.SETFILTER("Employee No.", '%1', "Employee No.");
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDaysThisYear := Absence.COUNT;


                            // PlanGO.CALCFIELDS("Used Days");
                            // PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-PlanGO."Used Days";
                            "Legal Grounds" := "Legal Grounds" - UsedDaysThisYear;
                            Year := Year2;

                        END;
                    END
                    ELSE BEGIN
                        EmployeeRec.RESET;
                        EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                        IF EmployeeRec.FINDFIRST THEN BEGIN
                            VacationSetup.GET('', Date2DMY(Today, 3));
                            "Legal Grounds" := VacationSetup."Base Days";
                            Year := Year2;
                            Experience.SETFILTER(LowerLimit, '<=%1', EmployeeRec."Current Years Total");
                            Experience.SETFILTER(UpperLimit, '>=%1', EmployeeRec."Current Years Total");
                            IF Experience.FINDFIRST THEN BEGIN
                                "Days based on Work experience" := Experience.Vacation;
                                Year := Year2;
                            END
                            ELSE BEGIN
                                "Days based on Work experience" := 0;
                                Year := Year2;

                            END;

                            // po stepenu invalidnosti

                            IF ((EmployeeRec."Disabled Person" = TRUE) OR (EmployeeRec."Chronic Disease" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No", '%1', 1);
                                SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Days based on Disability" := SocialStatus.Points;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Days based on Disability" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Days based on Disability" := 0;
                                Year := Year2;
                            END;




                            //roditelj djece sa posebnim potrebama
                            IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                SocialStatus.SETFILTER("No", '%1', 2);
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Based on Disabled Child" := SocialStatus.Points;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Based on Disabled Child" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Based on Disabled Child" := 0;
                                Year := Year2;
                            END;
                        END;



                    END;


                    UsedDaysThisYear := 0;
                    WB.RESET;
                    PlanGO.RESET;

                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL.SETFILTER("Reason for Change", '%1', 1);
                    ECL.SETFILTER("Way of Employment", '%1|%2|%3', 1, 2, 0);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                    //ECL.SETFILTER(Active,'%1',TRUE);
                    ECL.SETFILTER("First Time Employed", '%1', TRUE);
                    IF ECL.FINDFIRST THEN BEGIN
                        WB.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        IF WB.FIND('+') THEN BEGIN

                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(TODAY, 3) THEN
                                "Legal Grounds" := WB.Months - (12 - DATE2DMY(WB."Starting Date", 2))
                            ELSE
                                "Legal Grounds" := WB.Months;
                            Year := Year2;

                            Absence.RESET;
                            Absence.SETFILTER("Employee No.", '%1', "Employee No.");
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDaysThisYear := Absence.COUNT;


                            // PlanGO.CALCFIELDS("Used Days");
                            // PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-PlanGO."Used Days";
                            "Legal Grounds" := "Legal Grounds" - UsedDaysThisYear;
                            Year := Year2;
                        END;
                    END
                    ELSE BEGIN
                        VacationSetup.GET('', Date2DMY(Today, 3));
                        ;
                        "Legal Grounds" := VacationSetup."Base Days";
                        EmployeeRec.RESET;
                        EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                        IF EmployeeRec.FINDFIRST THEN BEGIN
                            Experience.SETFILTER(LowerLimit, '<=%1', EmployeeRec."Current Years Total");
                            Experience.SETFILTER(UpperLimit, '>=%1', EmployeeRec."Current Years Total");
                            IF Experience.FINDFIRST THEN BEGIN
                                "Days based on Work experience" := Experience.Vacation;
                                Year := Year2;
                            END
                            ELSE BEGIN
                                "Days based on Work experience" := 0;
                                Year := Year2;
                            END;



                            // po stepenu invalidnosti
                            IF ((EmployeeRec."Disabled Person" = TRUE) OR (EmployeeRec."Chronic Disease" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No", '%1', 1);
                                SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Days based on Disability" := SocialStatus.Points;
                                    Year := Year2;

                                END
                                ELSE BEGIN
                                    "Days based on Disability" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Days based on Disability" := 0;
                                Year := Year2;
                            END;




                            //roditelj djece sa posebnim potrebama
                            IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No", '%1', 2);
                                SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Based on Disabled Child" := SocialStatus.Points;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Based on Disabled Child" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Based on Disabled Child" := 0;
                                Year := Year2;
                            END;

                        END;
                        Year := Year2;
                    END;
                END;

                EmployeeRec.RESET;
                EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                IF EmployeeRec."Returned to Company" = TRUE THEN BEGIN
                    WB.RESET;
                    PlanGO.RESET;
                    ECL.RESET;
                    Absence.RESET;
                    UsedDays := 0;
                    ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL.SETFILTER("Reason for Change", '%1', 1);
                    ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-14D', TODAY), TODAY);
                    IF ECL.FINDFIRST THEN BEGIN

                        WB.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        IF WB.FIND('+') THEN BEGIN

                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(TODAY, 3) THEN
                                "Legal Grounds" := WB.Months - (12 - DATE2DMY(WB."Starting Date", 2))
                            ELSE
                                "Legal Grounds" := WB.Months;
                            Year := Year2;

                            Absence.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                            //Absence.SETFILTER("Vacation from Year",'<>%1',0);
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            //Absence.SETFILTER("From Date",'%1..%2',CALCDATE('-14D',TODAY),TODAY);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDays := Absence.COUNT;
                            "Legal Grounds" := "Legal Grounds" - UsedDays;
                            Year := Year2;

                        END
                        ELSE BEGIN
                            VacationSetup.GET('', Date2DMY(Today, 3));
                            ;
                            "Legal Grounds" := VacationSetup."Base Days";
                            EmployeeRec.RESET;
                            EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                            IF EmployeeRec.FINDFIRST THEN BEGIN
                                Experience.SETFILTER(LowerLimit, '<=%1', EmployeeRec."Current Years Total");
                                Experience.SETFILTER(UpperLimit, '>=%1', EmployeeRec."Current Years Total");
                                IF Experience.FINDFIRST THEN BEGIN
                                    "Days based on Work experience" := Experience.Vacation;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Days based on Work experience" := 0;
                                    Year := Year2;
                                END;



                                // po stepenu invalidnosti
                                IF ((EmployeeRec."Disabled Person" = TRUE) OR (EmployeeRec."Chronic Disease" = TRUE)) THEN BEGIN
                                    SocialStatus.SETFILTER("No", '%1', 1);
                                    SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                    IF SocialStatus.FINDFIRST THEN BEGIN
                                        "Days based on Disability" := SocialStatus.Points;
                                        Year := Year2;

                                    END
                                    ELSE BEGIN
                                        "Days based on Disability" := 0;
                                        Year := Year2;
                                    END;
                                END
                                ELSE BEGIN
                                    "Days based on Disability" := 0;
                                    Year := Year2;
                                END;




                                //roditelj djece sa posebnim potrebama
                                IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                    SocialStatus.SETFILTER("No", '%1', 2);
                                    SocialStatus.SetFilter("Points Category", '%1', SocialStatus."Points Category"::"Points per Disability Status");
                                    IF SocialStatus.FINDFIRST THEN BEGIN
                                        "Based on Disabled Child" := SocialStatus.Points;
                                        Year := Year2;
                                    END
                                    ELSE BEGIN
                                        "Based on Disabled Child" := 0;
                                        Year := Year2;
                                    END;
                                END
                                ELSE BEGIN
                                    "Based on Disabled Child" := 0;
                                    Year := Year2;
                                END;

                            END;







                        END;
                        Year := Year2;
                    END;
                END;


            end;
        }
        field(2; "Work experience"; Integer)
        {
            Caption = 'Work experience';
            Editable = false;
        }
        field(3; "Legal Grounds"; Integer)
        {
            Caption = 'Legal Grounds';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;

                EVALUATE(Order, "Employee No.");
            end;
        }
        field(4; "Days based on Work experience"; Integer)
        {
            Caption = 'Days based on Work experience';
            Editable = false;

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(5; "Days based on Disability"; Integer)
        {
            Caption = 'Days based on Disability';
            Editable = false;

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        //ED 02 START
        field(24; "Days based on Military service"; Integer)
        {
            Caption = 'Days based on Military service';
            Editable = false;

            trigger OnValidate()
            begin
                //"Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(25; "Days based on Working conditi"; Integer)
        {
            Caption = 'Days based on  Working conditions';
            Editable = false;

            trigger OnValidate()
            begin
                //"Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(34; "Used days at previous employer"; Integer)
        {
        }
        field(35; "Date of report"; Date)
        {
        }
        //ED 02 END
        field(6; Sector; Text[250])
        {
            /*FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                 Active = CONST(true)));*/
            //ED 02


            Caption = 'Sector';

        }
        field(7; SpecialCircumstances; integer)
        {
            Caption = 'Special Circumstances';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(8; SingleParent; integer)
        {
            Caption = 'Single Parent';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(9; MotherWithMoreCH; integer)
        {
            Caption = 'Mother with more children';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(10; Millitary; integer)
        {
            Caption = 'Millitary';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(11; "Total days"; Integer)
        {
            Caption = 'Total Days';
            Editable = false;
        }
        field(12; Year; Integer)
        {
            Caption = 'Year';
        }
        field(13; "First Name"; Text[50])
        {
            Caption = 'Ime';
            Editable = false;
        }
        field(14; "Last Name"; Text[50])
        {
            Caption = 'Prezime';
            Editable = false;
        }
        field(15; "Starting Date of I part"; Date)
        {
            Caption = 'Starting Date of I part';
        }
        field(16; "Ending Date of I part"; Date)
        {
            Caption = 'Ending Date of I part';

            trigger OnValidate()
            begin

                if "Ending Date of I part" <> 0D then begin

                    "First Part" := (AbsenceFill.GetHourPoolForVacation("Starting Date of I part", "Ending Date of I part", EmployeeRec."Hours In Day")) / 8;


                    /*WPConnSetup.FINDFIRST();


                    CREATE(conn, TRUE, TRUE);

                    conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                              +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

                    CREATE(comm,TRUE, TRUE);

                    lvarActiveConnection := conn;
                    comm.ActiveConnection := lvarActiveConnection;

                    comm.CommandText := 'dbo.Vacation_Requests_Insert';
                    comm.CommandType := 4;
                    comm.CommandTimeout := 0;


                    param:=comm.CreateParameter('@emp', 200, 1, 30, "Employee No.");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@CreationDate', 7, 1, 0, TODAY);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@h_from', 7, 1, 0, "Starting Date of I part");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@h_to', 7, 1, 0, "Ending Date of I part");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@status', 3, 1, 0, 1);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@type', 200, 1, 30, 'DEC');
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@year',3, 1, 0, Year);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@duration', 3, 1, 0,"Ending Date of I part"-"Starting Date of I part");
                    comm.Parameters.Append(param);

                    comm.Execute;
                    conn.Close;
                    CLEAR(conn);
                    CLEAR(comm);
                    ĐK*/


                    /*

                    WPConnSetup.FINDFIRST();
                    CREATE(conn, TRUE, TRUE);

                    conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                              +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

                    CREATE(comm,TRUE, TRUE);

                    lvarActiveConnection := conn;
                    comm.ActiveConnection := lvarActiveConnection;

                    comm.CommandText := 'dbo.Vacation_Requests_Update';
                    comm.CommandType := 4;
                    comm.CommandTimeout := 0;


                    param:=comm.CreateParameter('@emp', 200, 1, 30, "Employee No.");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@CreationDate', 7, 1, 0, TODAY);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@h_from', 7, 1, 0, "Starting Date of I part");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@h_to', 7, 1, 0, "Ending Date of I part");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@status', 3, 1, 0, 1);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@type', 200, 1, 30, 'DEC');
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@year',3, 1, 0, Year);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@duration', 3, 1, 0,"Ending Date of I part"-"Starting Date of I part");
                    comm.Parameters.Append(param);

                    comm.Execute;
                    conn.Close;
                    CLEAR(conn);
                    CLEAR(comm);
                    */
                end;

            end;
        }
        field(17; "Starting Date of II part"; Date)
        {
            Caption = 'Starting Date of II part';
        }
        field(18; "Ending Date of II part"; Date)
        {
            Caption = 'Ending Date of II part';
        }
        field(19; "Based on Disabled Child"; Integer)
        {
            Caption = 'Based onn Disabled Child';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent - "Number of days";
            end;
        }
        field(21; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /*field(22;"Max Days";Decimal)
        {
            CalcFormula = Max(OpRisk.Quantity WHERE ("Employee No."=FIELD("Employee No.")));
            FieldClass = FlowField;
        }*/
        /*field(23; "Used Days"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Count("Employee Absence" WHERE("Employee No." = FIELD("Employee No."),
                                                          "Vacation from Year" = FIELD(Year)));

        }*/
        field(27; "Manager contract"; Boolean)
        {
            Caption = 'Manager contract';
        }
        field(28; "Number of days"; Integer)
        {
            Caption = 'Number of days';

            trigger OnValidate()
            begin
                IF ("Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days") < 0 THEN
                    ERROR(Text01);

                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";

            end;
        }
        field(29; "Position Name"; Text[250])
        {
            /*FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                 Active = CONST(true)));*/
            Caption = 'Position Name';
        }
        field(30; Duration; Integer)
        {
            Caption = 'Duration';
        }
        field(31; "Insert Date"; Date)
        {
            Caption = 'Insert Date';
        }
        field(32; UsedDays; Integer)
        {
        }
        field(33; "First Part"; Integer)
        {
        }
        field(37; "No. Series"; Code[20])
        {

        }
        field(38; "Document Text"; Text[250])
        {
            Caption = 'Document Text';
        }
        field(36; "Document No."; Code[20])
        {
            Caption = 'Document No.';

        }
        /*ĐK ne treba    field(40; "Max Days"; Decimal)
            {
                FieldClass = FlowField;
                Caption = 'Max Days';
                CalcFormula = Max(OpRisk.Quantity WHERE("Employee No." = FIELD("Employee No.")));
            }*/




    }

    keys
    {
        key(Key1; "Employee No.", "Insert Date", Year)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        myInt: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        VacHistory: Record "Vacation setup history";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        CodeN: Code[20];
    begin
        GeneralLedgerSetup.get();

        IF (GeneralLedgerSetup."Is Simple Page" = true) THEN BEGIN
            VacHistory.Reset();
            CodeN := '';
            VacHistory.SetFilter(Year, '%1', REc.Year);
            if VacHistory.FindFirst() then begin
                NoSeriesMgt.InitSeries(VacHistory."No. series Code", xRec."No. Series", 0D, CodeN, "No. Series");
                Rec."Document No." := CodeN;
            end
            else begin
                ERROR('Vacation Setup history!');

            end;

        END;



    end;

    var
        t_Employee: Record "Employee";
        PositionRec: Record "Position";
        EmployeeRec: Record "Employee";
        CurrYear: Integer;
        LastDateOfMonth: Date;
        VacationSetup: Record "Vacation Setup history";
        VacationSetuphistory: Record "Vacation setup history";
        //   VacationCalculation: Report "Vacation Calculation";
        UsedDaysThisYear: Integer;
        Year2: Integer;
        WB: Record "Work Booklet";
        PlanGO: Record "Vacation Ground 2";
        ECL: Record "Employee Contract Ledger";
        Absence: Record "Employee Absence";
        UsedDays: Integer;
        Experience: Record "Points per Experience Years";
        SocialStatus: Record "Points per Experience Years";
        AbsenceFill: Codeunit "Absence Fill";

        /*SQLConn: DotNet SqlConnection;
        ConnectionString: Text;
        SQLCommand: DotNet SqlCommand;
        SQLParameter: DotNet SqlParameter;
        SQLDbType: DotNet DbType;
        WPConnSetup: Record "Web portal connection setup";
        conn: Automation;
        comm: Automation;
        param: Automation;
        lvarActiveConnection: Variant;*/
        Text01: Label 'You can''t insert number od used days more then available value!';

}

