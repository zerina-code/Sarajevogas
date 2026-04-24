report 50014 "Update Brought Experience"
{
    Caption = 'Update Brought Experience';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem2; "Employee")
        {
            column(BroughtYearsofExperience_Employee; DataItem2."Brought Years of Experience")
            {
            }
            column(BroughtMonthsofExperience_Employee; DataItem2."Brought Months of Experience")
            {
            }
            column(BroughtDaysofExperience_Employee; DataItem2."Brought Days of Experience")
            {
            }
            //BH 01 start
            column(Military_Years_of_Servisce; DataItem2."Military Years of Service")
            {
            }
            column(Military_Months_of_Service; DataItem2."Military Months of Service")
            {
            }
            column(Military_Days_of_Service; DataItem2."Military Days of Service")
            {
            }
            /*
            column(Experience_With_Military_Years; DataItem2."Years with military")
            {
            }
            column(Experience_With_Military_Months; DataItem2."Months with military")
            {
            }
            column(Experience_With_Military_Days; DataItem2."Days with military")
            {
            }*/
            //BH 01 end
            trigger OnAfterGetRecord()
            begin
                //HR01
                "Brought Years of Experience E" := 0;
                "Brought Months of Experience E" := 0;
                "Brought Days of Experience E" := 0;

                //BH 01 start
                "Military Years of Service" := 0;
                "Military Months of Service" := 0;
                "Military Days of Service" := 0;
                //BH 01 end

                IF EmpNo = '' THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "No.");
                    ECL.SETFILTER("Reason for Change", '%1|%2', ECL."Reason for Change"::"New Contract", ECL."Reason for Change"::Migration);
                    ECL.SETCURRENTKEY("Starting Date");
                    ECL.ASCENDING;
                    IF ECL.FINDLAST THEN BEGIN

                        WB.RESET;
                        WB.SETFILTER("Contract Ledger Entry No.", '<>%1 & <>%2', ECL."No.", 0);
                        IF WB.FINDFIRST THEN BEGIN

                            ECL2.RESET;
                            ECL2.SETFILTER("Employee No.", '%1', "No.");
                            ECL2.SETFILTER("No.", '<%1', WB."Contract Ledger Entry No.");
                            ECL2.SETCURRENTKEY("Starting Date");
                            ECL2.ASCENDING;
                            IF ECL2.FINDFIRST THEN BEGIN
                                IF ECL2."Position Description" = 'IZVRŠILAC POSLA - DEKRA' THEN BEGIN

                                    EmpNo := "No.";
                                    StatusECL := 'EXTERNAL';
                                    PositionE := ECL2."Position Description"
                                END;
                            END;
                        END;
                    END;
                END;

                UkupnoGodine := 0;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                t_WorkBooklet.RESET;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Current Company", '%1', FALSE);
                t_WorkBooklet.SETFILTER("Is not dekra", '%1', FALSE);
                t_WorkBooklet.SETFILTER("Military Service", '%1', FALSE);//kada je FALSE da ne ulazi u prijasnji staz

                IF t_WorkBooklet.FINDFIRST THEN
                    REPEAT
                    BEGIN
                        UkupniDani += t_WorkBooklet.Days;
                        UkupniMjeseci += t_WorkBooklet.Months;
                        UkupnoGodine += t_WorkBooklet.Years;
                    END;
                    UNTIL t_WorkBooklet.NEXT = 0;

                /*
                ECL.RESET;
                ECL.SETFILTER("Position Description",'%1',PositionE);
                ECL.SETFILTER(Active,'%1',TRUE);
                IF ECL.FINDFIRST THEN BEGIN
                  HRSetup.GET;
                  IF ECL."Engagement Type"<>HRSetup."External Description" THEN
                    PositionE:='IZVRŠILAC POSLA - DEKRA';
                  END
                  ELSE BEGIN
                  ECL.RESET;
                ECL.SETFILTER("Position Description",'%1',PositionE);
                IF ECL.FINDFIRST THEN BEGIN
                 IF ECL."Engagement Type"<>HRSetup."External Description" THEN
                    PositionE:='IZVRŠILAC POSLA - DEKRA';
                END;
               END;*/
                IF ((((Status.AsInteger() = 0)) OR (Status.AsInteger() = 1) OR (Status.AsInteger() = 2) OR (Status.AsInteger() = 3) OR (Status.AsInteger() = 8) OR (Status.AsInteger() = 0))) THEN BEGIN
                    validate("Brought Years of Experience", UkupnoGodine + (((UkupniMjeseci + "Brought Months of Experience 2") + ((UkupniDani + "Brought Days of Experience 2") DIV 30)) DIV 12) + "Brought Years of Experience 2");
                    "Brought Months of Experience" := ((UkupniMjeseci + "Brought Months of Experience 2") + ((UkupniDani + "Brought Days of Experience 2") DIV 30)) MOD 12;
                    "Brought Days of Experience" := (UkupniDani + "Brought Days of Experience 2") MOD 30;

                    MODIFY(true);
                END
                ELSE BEGIN

                    validate("Brought Years of Experience", "Brought Years of Experience 2");
                    "Brought Months of Experience" := "Brought Months of Experience 2";
                    "Brought Days of Experience" := "Brought Days of Experience 2";
                    MODIFY(true);
                END;

                UkupnoGodineE := 0;
                UkupniDaniE := 0;
                UkupniMjeseciE := 0;
                UkupnoGodineD := 0;
                UkupniDaniD := 0;
                UkupniMjeseciD := 0;
                t_WorkBooklet.RESET;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Current Company", '%1', FALSE);
                t_WorkBooklet.SETFILTER("Is not dekra", '%1', TRUE);


                IF t_WorkBooklet.FINDFIRST THEN
                    REPEAT
                    BEGIN
                        UkupniDaniE += t_WorkBooklet.Days;
                        UkupniMjeseciE += t_WorkBooklet.Months;
                        UkupnoGodineE += t_WorkBooklet.Years;
                    END;
                    UNTIL t_WorkBooklet.NEXT = 0;
                t_WorkBooklet.RESET;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Current Company", '%1', FALSE);
                t_WorkBooklet.SETFILTER("Is dekra", '%1', TRUE);


                IF t_WorkBooklet.FINDFIRST THEN
                    REPEAT
                    BEGIN
                        UkupniDaniD += t_WorkBooklet.Days;
                        UkupniMjeseciD += t_WorkBooklet.Months;
                        UkupnoGodineD += t_WorkBooklet.Years;
                    END;
                    UNTIL t_WorkBooklet.NEXT = 0;


                IF (UkupnoGodineE <> 0) OR (UkupniDaniE <> 0) OR (UkupniMjeseciE <> 0) OR (UkupnoGodineD <> 0) OR (UkupniDaniD <> 0) OR (UkupniMjeseciD <> 0) THEN BEGIN
                    "Brought Years of Experience E" := UkupnoGodineE + (((UkupniMjeseciE + "Brought Months of Experience 2") + ((UkupniDaniE + "Brought Days of Experience 2") DIV 30)) DIV 12) +
                    UkupnoGodineD + (((UkupniMjeseciD + "Brought Months of Experience 2") + ((UkupniDaniD + "Brought Days of Experience 2") DIV 30)) DIV 12);
                    "Brought Months of Experience E" := ((UkupniMjeseciE + "Brought Months of Experience 2") + ((UkupniDaniE + "Brought Days of Experience 2") DIV 30)) MOD 12 +
                    ((UkupniMjeseciD + "Brought Months of Experience 2") + ((UkupniDaniD + "Brought Days of Experience 2") DIV 30)) MOD 12;
                    "Brought Days of Experience E" := (UkupniDaniE + "Brought Days of Experience 2") MOD 30 + (UkupniDaniD + "Brought Days of Experience 2") MOD 30;
                    MODIFY(true);


                END
                ELSE BEGIN

                    IF ((Status.AsInteger() = 5) OR (Status.AsInteger() = 6) OR (Status.AsInteger() = 7) OR (Status.AsInteger() = 9) OR (Status.AsInteger() = 10) OR (Status.AsInteger() = 11) OR (Status.AsInteger() = 12) OR (Status.AsInteger() = 8) OR (StatusECL <> '')) THEN BEGIN
                        "Brought Years of Experience E" := UkupnoGodine + (((UkupniMjeseci + "Brought Months of Experience 2") + ((UkupniDani + "Brought Days of Experience 2") DIV 30)) DIV 12);
                        "Brought Months of Experience E" := ((UkupniMjeseci + "Brought Months of Experience 2") + ((UkupniDani + "Brought Days of Experience 2") DIV 30)) MOD 12;
                        "Brought Days of Experience E" := (UkupniDani + "Brought Days of Experience 2") MOD 30;
                        MODIFY(true);

                    END;
                END;
                /*UkupnoGodine:=0;
                UkupniDani:=0;
                UkupniMjeseci:=0;*/

                //BH 01 start
                VojneGodine := 0;
                VojniDani := 0;
                VojniMjeseci := 0;

                t_WorkBooklet.RESET;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Military service", '%1', TRUE);


                IF t_WorkBooklet.FINDFIRST THEN
                    REPEAT
                    BEGIN
                        VojniDani += t_WorkBooklet.Days;
                        VojniMjeseci += t_WorkBooklet.Months;
                        VojneGodine += t_WorkBooklet.Years;
                    END;
                    UNTIL t_WorkBooklet.NEXT = 0;


                "Military Years of Service" := VojneGodine + (((VojniMjeseci) + ((VojniDani) DIV 30)) DIV 12);
                "Military Months of Service" := ((VojniMjeseci) + ((VojniDani) DIV 30)) MOD 12;
                "Military Days of Service" := (VojniDani) MOD 30;
                MODIFY(true);

            end;
            //BH 01 end

            trigger OnPreDataItem()
            begin
                //SETFILTER(Status,'%1|%2|%3|%4',0,1,2,3);
                SETFILTER(Status, '<>%1', 4);
                IF EmpNo <> '' THEN
                    SETFILTER("No.", '%1', EmpNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        //ĐK  MESSAGE(Text0001);
        //ĐK EmployeeCardPage.Update(true);


    end;

    trigger OnPreReport()
    begin
        /*IF Previous=TRUE THEN
        Previous:=FALSE
        ELSE Previous:=TRUE;*/
        IF EmpNo <> '' THEN BEGIN

            Workkkk.RESET;
            Workkkk.SETFILTER("Employee No.", '%1', EmpNo);
            IF Workkkk.FINDSET THEN
                REPEAT
                    Workkkk.VALIDATE(Coefficient, Workkkk.Coefficient);
                    Workkkk.MODIFY;
                UNTIL Workkkk.NEXT = 0;
        END
        ELSE BEGIN
            Workkkk.RESET;
            IF Workkkk.FINDSET THEN
                REPEAT
                    Workkkk.VALIDATE(Coefficient, Workkkk.Coefficient);
                    Workkkk.MODIFY;
                UNTIL Workkkk.NEXT = 0;
        END;

    end;

    var
        Text0001: Label 'Brought Work experience is updated.';
        CompInfo: Record "Company Information";
        EmployeeCardPage: page "Employee Card";
        zadnji: Text[100];
        Str: Text[100];
        position: Integer;
        lenght: Integer;
        UkupniDani: Integer;
        UkupnoGodine: Integer;
        t_WorkBooklet: Record "Work Booklet";
        UkupniMjeseci: Integer;
        UkupniDaniBEZ: Integer;
        UkupnoGodineBEZ: Integer;
        UkupniMjeseciBEZ: Integer;
        EmployeeCL: Record "Work Booklet";
        DateRec: Date;
        EmployeeRec: Record "Employee";
        EmpNo: Code[10];
        StatusECL: Code[10];
        PositionE: Text[250];
        iMA: Boolean;
        ECL: Record "Employee Contract Ledger";
        ECL2: Record "Employee Contract Ledger";
        WB: Record "Work Booklet";
        StatusValue: Text;
        HRSetup: Record "Human Resources Setup";
        UkupniDaniE: Integer;
        UkupnoGodineE: Integer;
        UkupniMjeseciE: Integer;
        UkupniDaniD: Integer;
        UkupnoGodineD: Integer;
        UkupniMjeseciD: Integer;
        Workkkk: Record "Work Booklet";
        //BH 01 start

        VojneGodine: Integer;
        VojniMjeseci: Integer;
        VojniDani: Integer;/*
        UkupniSaVojnimGodine: Integer;
        UkupniSaVojnimMjeseci: Integer;
        UkupniSaVojnimDani: Integer;*/
    //BH 01 end

    procedure SetEmp(EmployeeNo: Code[10])
    begin

        EmpNo := EmployeeNo;

        //HR01
    end;

    procedure SetStatus(EmployeeNo: Code[10]; Status: Code[10]; PositionName: Text[250])
    begin

        StatusECL := Status;
        EmpNo := EmployeeNo;
        PositionE := PositionName;
        //HR01
    end;
}

