report 50011 "StatusExt update"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Employee Contract Ledger2"; "Employee Contract Ledger")
        {
            DataItemTableView = WHERE("Show Record" = CONST(TRUE));

            trigger OnAfterGetRecord()
            begin

                SETFILTER(Active, '%1', TRUE);
                SETFILTER("Ending Date", '<>%1&<%2', 0D, WORKDATE);
                SETFILTER("Show Record", '%1', TRUE);
                IF FINDFIRST THEN
                    REPEAT
                        IF "Grounds for Term. Code" = '' THEN BEGIN
                            Active := FALSE;
                            HeadOfRefresh2.RESET;
                            HeadOfRefresh2.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            HeadOfRefresh2.SETFILTER("Position Code", '%1', "Position Code");
                            IF HeadOfRefresh2.FINDLAST THEN Status := Status::Terminated;
                            MODIFY;
                        END;

                        IF ("Grounds for Term. Code" <> '') THEN BEGIN
                            IF (WORKDATE >= CALCDATE('<+1D>', "Ending Date")) THEN BEGIN
                                Active := TRUE;
                                HeadOfRefresh2.RESET;
                                HeadOfRefresh2.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                HeadOfRefresh2.SETFILTER("Position Code", '%1', "Position Code");
                                IF HeadOfRefresh2.FINDLAST THEN Status := Status::Terminated;
                                MODIFY;
                            END;
                        END;
                    UNTIL NEXT = 0;
                RESET;
                SETFILTER("Grounds for Term. Code", '<>%1', '');
                SETFILTER("Show Record", '%1', TRUE);
                IF FINDFIRST THEN
                    REPEAT
                        IF "Grounds for Term. Code" <> '' THEN BEGIN
                            IF (WORKDATE >= CALCDATE('<+1D>', "Ending Date")) THEN BEGIN
                                Active := TRUE;
                                HeadOfRefresh2.RESET;
                                HeadOfRefresh2.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                HeadOfRefresh2.SETFILTER("Position Code", '%1', "Position Code");
                                IF HeadOfRefresh2.FINDLAST THEN Status := Status::Terminated;
                                MODIFY;
                            END;
                        END;


                    UNTIL NEXT = 0;

            end;
        }
        dataitem(DataItem1; "Employee Contract Ledger")
        {
            DataItemTableView = WHERE("Show Record" = CONST(TRUE));

            trigger OnAfterGetRecord()
            begin
                IF ("Grounds for Term. Code" <> '') THEN BEGIN
                    IF (WORKDATE = CALCDATE('<+1D>', "Ending Date")) THEN BEGIN
                        Employee.RESET;
                        Employee."No." := '';
                        Employee.SETFILTER("No.", '%1', "Employee Contract Ledger2"."Employee No.");
                        IF Employee.FIND('-') THEN BEGIN

                            Ugovori.RESET;
                            Ugovori.SETFILTER("Ending Date", '%1', CALCDATE('<-1D>', WORKDATE));
                            Ugovori.SETFILTER("Grounds for Term. Description", '<>%1', '');
                            Ugovori.SETFILTER("Show Record", '%1', TRUE);
                            IF Ugovori.FINDSET THEN
                                REPEAT
                                    Zaposlenik.RESET;
                                    Zaposlenik.SETFILTER("No.", '%1', Ugovori."Employee No.");
                                    IF Zaposlenik.FINDFIRST THEN BEGIN
                                        IF (Zaposlenik.StatusExt.AsInteger() < 4) THEN BEGIN
                                            Zaposlenik.VALIDATE(StatusExt, 3);
                                            Zaposlenik.VALIDATE("External employer Status", 0);
                                        END
                                        ELSE BEGIN
                                            Zaposlenik.VALIDATE("External employer Status", 4);
                                        END;
                                        Zaposlenik.MODIFY;
                                    END;
                                UNTIL Ugovori.NEXT = 0;



                            VALIDATE("Grounds for Term. Description", "Grounds for Term. Description");
                            MODIFY;
                            HeadOfRefresh.RESET;
                            HeadOfRefresh.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            HeadOfRefresh.SETFILTER("Position Code", '%1', "Position Code");
                            IF HeadOfRefresh.FINDLAST THEN Status := Status::Terminated;



                        END;
                    END;
                END;

                IF "Employee Contract Ledger2"."Show Record" = TRUE THEN BEGIN

                    IF "Starting Date" = WORKDATE THEN BEGIN
                        //////dodali
                        VALIDATE("Starting Date", WORKDATE);

                        PositionNema.RESET;
                        PositionNema.SETFILTER("Employee No.", '%1', "Employee No.");
                        PositionNema.SETFILTER(Code, '%1', "Position Code");
                        PositionNema.SETFILTER(Description, '%1', "Position Description");
                        PositionNema.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF NOT PositionNema.FINDFIRST THEN
                            VALIDATE("Position Description", "Position Description");

                        VALIDATE("Grounds for Term. Description", "Grounds for Term. Description");
                        MODIFY(TRUE);

                        Employee.RESET;
                        Employee."No." := '';
                        Employee.SETFILTER("No.", '%1', "Employee Contract Ledger2"."Employee No.");
                        IF Employee.FIND('-') THEN BEGIN

                            Ugovori.RESET;
                            Ugovori.SETFILTER("Starting Date", '%1', WORKDATE);
                            IF Ugovori.FINDSET THEN
                                REPEAT
                                    Zaposlenik.RESET;
                                    Zaposlenik.SETFILTER("No.", '%1', Ugovori."Employee No.");
                                    IF Zaposlenik.FINDFIRST THEN BEGIN

                                        IF Zaposlenik.StatusExt.AsInteger() = 3 THEN
                                            Zaposlenik.VALIDATE(StatusExt, 0);
                                        IF "Grounds for Term. Description" = '' THEN
                                            Zaposlenik."Termination Date" := 0D;
                                        IF Zaposlenik."External employer Status" = 5 THEN
                                            Zaposlenik.VALIDATE("External employer Status", 1);




                                        IF ((Zaposlenik.StatusExt.AsInteger() > 4) AND (Zaposlenik."External employer Status" = 4)) THEN
                                            Zaposlenik.VALIDATE("External employer Status", 1);
                                        HRsetup.GET;
                                        IF ((Zaposlenik.StatusExt.AsInteger() > 4) AND (Ugovori."Contract Type Name" <> HRsetup."External Description")) THEN BEGIN
                                            Zaposlenik.VALIDATE(StatusExt, 0);
                                            Zaposlenik.VALIDATE("External employer Status", 0);
                                        END;

                                        Zaposlenik.MODIFY;
                                        //END;
                                    END;
                                UNTIL Ugovori.NEXT = 0;
                        END;


                    END;

                END;

                /*Employee.RESET;
                Employee."No.":='';
                Employee.SETFILTER("No.",'%1',Employee Contract Ledger2."Employee No.");
                IF Employee.FIND('-') THEN   BEGIN*/
                /*Ugovori.RESET;
                  Ugovori.SETFILTER("Starting Date",'%1',WORKDATE);
                  IF Ugovori.FINDSET THEN REPEAT
                    Zaposlenik.RESET;
                    Zaposlenik.SETFILTER("No.",'%1',Ugovori."Employee No.");
                    IF Zaposlenik.FINDFIRST THEN BEGIN

                    IF Zaposlenik.StatusExt=4 THEN
                    Zaposlenik.StatusExt:=0;
                    IF Zaposlenik."External employer StatusExt"=5 THEN
                      Zaposlenik."External employer StatusExt":=1;




              IF ((Zaposlenik.StatusExt>4) AND (Zaposlenik."External employer StatusExt"=4) )  THEN
                Zaposlenik."External employer StatusExt":=1;
              HRsetup.GET;
              //IF ((Zaposlenik.StatusExt>4) AND (Ugovori."Contract Type Name"<>HRsetup."External Description") )  THEN BEGIN
                Zaposlenik.StatusExt:=0;
                Zaposlenik."External employer StatusExt":=0;
                END;

                    Zaposlenik.MODIFY;
                  //END;
                //  END;
                  UNTIL Ugovori.NEXT=0;
                //  END;*/

                /*VALIDATE("Starting Date",WORKDATE);
                  VALIDATE("Grounds for Term. Description","Grounds for Term. Description");
                 MODIFY(TRUE);*/
                //END;


                ECL2.RESET;
                ECL2.SETFILTER("Reason for Change", '%1', 2);
                ECL2.SETFILTER("Starting Date", '%1', WORKDATE);
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                IF ECL2.FINDFIRST THEN BEGIN
                    ECL3.RESET;
                    ECL3.SETFILTER("Employee No.", '%1', ECL2."Employee No.");
                    ECL3.SETFILTER("No.", '<>%1', ECL2."No.");
                    ECL3.SETFILTER("Starting Date", '<=%1', ECL2."Starting Date");
                    ECL3.SETCURRENTKEY("Starting Date");
                    ECL3.SETFILTER("Show Record", '%1', TRUE);
                    ECL3.ASCENDING;
                    IF ECL3.FINDLAST THEN BEGIN
                        HRsetup.GET;
                        // IF (ECL3."Contract Type"<>'') AND(ECL3."Contract Type Name"<>HRsetup."External Description") THEN BEGIN
                        Employee.RESET;
                        Employee.SETFILTER("No.", '%1', ECL3."Employee No.");
                        IF Employee.FINDFIRST THEN BEGIN
                            IF (Employee.StatusExt.AsInteger() <> 2) OR (Employee.StatusExt.AsInteger() <> 1) THEN BEGIN
                                Employee.VALIDATE(StatusExt, Employee.StatusExt::Active);
                                Employee.MODIFY;
                                //  END;
                            END;
                        END;
                    END;
                END;


            end;

            trigger OnPostDataItem()
            var
                IH2: Record "Installation History";
            begin
                IH.reset;
                ih.SetFilter("Installation Date", '%1', today);
                if ih.FindSet() then
                    repeat
                        if (ih."Dismantling date" <> 0D) and (ih."Reason for dismantling" <> '') then begin
                            if ih.Active = true then begin
                                ih.Active := False;
                                //poništi postojeće razloge
                                ih2.Reset();
                                IH2.SetFilter(code, '%1', ih.Code);
                                IH2.SetFilter("Installation Date", '%1', ih."Installation Date");
                                ih2.SetFilter("Reason for dismantling", '%1', '');
                                if ih2.FindFirst() then begin


                                    ih.Modify();
                                end;

                            end;

                        end
                        else begin
                            ih.Active := True;
                            ih.Modify();
                        end;


                    until ih.Next() = 0;


                ih.Reset();
                ih.SetFilter(Active, '%1', true);
                ih.SetFilter("Dismantling date", '<>%1', 0D);
                if ih.findset then
                    repeat
                        IH2.Reset();
                        IH2.SetFilter("Measuring Point Code", '%1', ih."Measuring Point Code");
                        IH2.SetFilter("Customer No.", '%1', ih."Customer No.");
                        ih2.SetFilter("Installation Date", '>%1', ih."Installation Date");
                        if not ih2.FindFirst() then begin
                            ih."Dismantling date" := 0D;
                            ih.Modify();
                        end;
                    until ih.next = 0;



                ECL2.SETFILTER(Active, '%1', TRUE);
                ECL2.SETFILTER("Reason for Change", '%1', ECL2."Reason for Change"::"New Contract");
                ECL2.SETFILTER("Starting Date", '%1', TODAY);
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                IF ECL2.FIND('-') THEN
                    REPEAT

                        employee2.SETFILTER("No.", '%1', ECL2."Employee No.");
                        employee2.SETFILTER(StatusExt, '<>%1', employee2.StatusExt::Active);
                        IF employee2.FIND('-') THEN BEGIN
                            IF employee2.StatusExt.AsInteger < 4 THEN BEGIN
                                IF (employee2.StatusExt.AsInteger <> 2) OR (employee2.StatusExt.AsInteger <> 1) THEN
                                    employee2.VALIDATE(StatusExt, employee2.StatusExt::Active)
                            END
                            ELSE BEGIN
                                employee2.VALIDATE("External employer Status", employee2."External employer Status"::Active);
                                employee2.MODIFY;
                            END;
                        END;

                    UNTIL ECL2.NEXT = 0;
                OrgShema.RESET;
                OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Active);
                IF OrgShema.FINDLAST THEN BEGIN
                    ECLOrg9.RESET;
                    ECLOrg9.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                    ECLOrg9.SETFILTER("Show Record", '%1', TRUE);
                    ECLOrg9.SETFILTER("Position Description", '<>%1', '');
                    ECLOrg9.SETFILTER("Starting Date", '%1', CALCDATE('<+1D>', WORKDATE));
                    ECLOrg9.SETFILTER("Reason for Change", '%1..%2|%3..%4|%5|%6', 2, 4, 7, 12, 15, 16);
                    IF ECLOrg9.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(213, FALSE, FALSE, ECLOrg9);
                        COMMIT;

                    END
                    ELSE BEGIN
                        ECLOrg9.RESET;
                        ECLOrg9.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                        ECLOrg9.SETFILTER("Show Record", '%1', TRUE);
                        ECLOrg9.SETFILTER("Position Description", '<>%1', '');
                        ECLOrg9.SETFILTER("Ending Date", '%1', CALCDATE('<+1D>', WORKDATE));
                        ECLOrg9.SETFILTER("Grounds for Term. Description", '<>%1', '');
                        IF ECLOrg9.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(213, FALSE, FALSE, ECLOrg9);
                            COMMIT;
                        END;


                    END;
                END;


                WorkBooklet.RESET;
                WorkBooklet.SETFILTER("Ending Date", '<%1', WORKDATE);
                WorkBooklet.SETFILTER(Active, '%1', TRUE);
                IF WorkBooklet.FINDSET THEN
                    REPEAT
                        IF WorkBooklet."Ending Date" <> 0D THEN BEGIN
                            WorkBooklet.Active := FALSE;
                            WorkBooklet.MODIFY
                        END;

                    UNTIL WorkBooklet.NEXT = 0;



                Employee.RESET;
                Employee.SETFILTER(StatusExt, '%1', 3);
                IF Employee.FINDSET THEN
                    REPEAT
                        WorkBooklet2.RESET;
                        WorkBooklet2.SETFILTER("Employee No.", '%1', Employee."No.");
                        WorkBooklet2.SETFILTER("Current Company", '%1', TRUE);
                        WorkBooklet2.SETCURRENTKEY("Starting Date");
                        WorkBooklet2.ASCENDING;
                        IF WorkBooklet2.FINDLAST THEN BEGIN
                            IF WorkBooklet2."Starting Date" = WORKDATE THEN BEGIN
                                Employee.VALIDATE(StatusExt, Employee.StatusExt::Active);
                                Employee.MODIFY;
                            END;
                        END;
                    UNTIL Employee.NEXT = 0;






                EmployeeRec.RESET;
                EmployeeRec.SETFILTER("Org Entity Code", '%1', 'FBIH');
                EmployeeRec.SETFILTER("Current Years Total", '%1', 2);
                EmployeeRec.SETFILTER("Current Months Total", '>=%1', 4);
                IF EmployeeRec.FINDSET THEN
                    REPEAT
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        ECL.SETFILTER(Active, '%1', TRUE);
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        IF ECL.FINDFIRST THEN BEGIN
                            IF ECL."Contract Type Name" = 'ODREĐENO' THEN BEGIN
                                ECL."Three Years in company" := TRUE;
                                ECL.MODIFY;
                            END;
                        END;
                    UNTIL EmployeeRec.NEXT = 0;
                EmployeeRec.RESET;
                EmployeeRec.SETFILTER("Org Entity Code", '%1|%2', 'RS', 'BD');
                EmployeeRec.SETFILTER("Current Years Total", '%1', 1);
                EmployeeRec.SETFILTER("Current Months Total", '>=%1', 4);
                IF EmployeeRec.FINDSET THEN
                    REPEAT
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', EmployeeRec."No.");
                        ECL.SETFILTER(Active, '%1', TRUE);
                        IF ECL.FINDFIRST THEN BEGIN
                            IF ECL."Contract Type Name" = 'ODREĐENO' THEN BEGIN
                                DateBefore3Years := CALCDATE('<-3Y>', WORKDATE);
                                WorkBooklet.RESET;
                                WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                                WorkBooklet.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                                WorkBooklet.SETFILTER("Starting Date", '>=%1', DateBefore3Years);
                                IF WorkBooklet.FINDFIRST THEN BEGIN
                                    ECL."Three Years in company" := TRUE;
                                END;
                                ECL.MODIFY;
                            END;
                        END;
                    UNTIL EmployeeRec.NEXT = 0;






                //"Current Years Total"
                MESSAGE(TEXT);
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
    var
        IH: Record "Installation History";
    begin
        HRsetup.GET;
        DateUse := HRsetup."Expiry period (contracts)";

        Date10 := CALCDATE(DateUse, TODAY);
        EmployeeContractLedger2.RESET;
        EmployeeContractLedger2.SETFILTER("Grounds for Term. Code", '<>%1', '');
        EmployeeContractLedger2.SETFILTER("Show Record", '%1', TRUE);
        EmployeeContractLedger2.SETCURRENTKEY("Starting Date");

        IF EmployeeContractLedger2.FINDSET THEN
            REPEAT
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", '%1', EmployeeContractLedger2."Employee No.");
                EmployeeContractLedger.SETFILTER("Starting Date", '>%1 & <=%2', EmployeeContractLedger2."Starting Date", WORKDATE);
                //EmployeeContractLedger.SETFILTER("Grounds for Term. Description",'%1','');
                EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                // EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                IF EmployeeContractLedger.FINDFIRST THEN BEGIN

                    EmployeeContractLedger2.Active := FALSE;
                    EmployeeContractLedger2.MODIFY;
                    IF EmployeeContractLedger."Starting Date" <= WORKDATE THEN BEGIN
                        Employee.RESET;
                        Employee.SETFILTER("No.", '%1', EmployeeContractLedger2."Employee No.");
                        IF Employee.FIND('-') THEN BEGIN

                            IF (Employee.StatusExt = Employee.StatusExt::Terminated) OR (Employee.StatusExt = Employee.StatusExt::"On boarding") THEN BEGIN
                                IF (Employee.StatusExt.AsInteger() <> 1) OR (Employee.StatusExt.AsInteger <> 2) THEN BEGIN
                                    Employee.VALIDATE(StatusExt, Employee.StatusExt::Active);
                                    Employee.MODIFY;
                                END;
                            END;
                        END;
                        /* EmployeeContractLedger.VALIDATE("Starting Date",WORKDATE);
                        EmployeeContractLedger. MODIFY(TRUE);*/

                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', EmployeeContractLedger2."Employee No.");
                        ECL.SETFILTER("Starting Date", '>%1 & <=%2', EmployeeContractLedger."Starting Date", WORKDATE);
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        IF ECL.FINDFIRST THEN BEGIN
                            EmployeeContractLedger.Active := FALSE;
                            EmployeeContractLedger.MODIFY;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.Active := TRUE;
                            EmployeeContractLedger.MODIFY;
                        END;
                    END;
                END

                ELSE BEGIN
                    IF EmployeeContractLedger2."Ending Date" <= WORKDATE THEN BEGIN
                        EmployeeContractLedger2.VALIDATE("Grounds for Term. Code", EmployeeContractLedger2."Grounds for Term. Code");
                        EmployeeContractLedger2.Active := TRUE;
                        EmployeeContractLedger2.MODIFY;
                    END;
                    //END;

                END;



            UNTIL EmployeeContractLedger2.NEXT = 0;



        ECLExpering.RESET;
        ECLExpering.SETFILTER(Active, '%1', TRUE);
        ECLExpering.SETFILTER("Grounds for Term. Description", '%1', '');
        ECLExpering.SETRANGE("Ending Date", TODAY, Date10);
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering2.RESET;
                ECLExpering2.SETFILTER("Employee No.", '%1', ECLExpering."Employee No.");
                ECLExpering2.SETFILTER("Starting Date", '>%1', ECLExpering."Starting Date");
                ECLExpering2.SETFILTER("Show Record", '%1', TRUE);
                ECLExpering2.SETCURRENTKEY("Starting Date");
                ECLExpering2.ASCENDING;
                IF ECLExpering2.FINDLAST THEN BEGIN
                    IF (ECLExpering2."Ending Date" <> 0D) AND (ECLExpering2."Ending Date" <= Date10) THEN BEGIN
                        ECLExpering."Is not extended" := TRUE;
                        ECLExpering.MODIFY;
                    END;
                    ne := FALSE
                END
                ELSE BEGIN
                    ECLExpering."Is not extended" := TRUE;
                    ECLExpering.MODIFY;
                END;


            UNTIL ECLExpering.NEXT = 0;

        //ugovori koji su istekli
        ECLExpering.RESET;
        ECLExpering.SETFILTER("Grounds for Term. Description", '%1', '');
        ECLExpering.SETRANGE("Ending Date", CALCDATE('-30D', TODAY), CALCDATE('<-1D>', TODAY));
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering2.RESET;
                ECLExpering2.SETFILTER("Employee No.", '%1', ECLExpering."Employee No.");
                ECLExpering2.SETFILTER("Starting Date", '>%1', ECLExpering."Starting Date");
                ECLExpering2.SETCURRENTKEY("Starting Date");
                ECLExpering2.ASCENDING;
                IF ECLExpering2.FINDLAST THEN BEGIN
                    ne := FALSE
                END
                ELSE BEGIN
                    ECLExpering."Is not extended expired" := TRUE;
                    ECLExpering.MODIFY;
                END;
            UNTIL ECLExpering.NEXT = 0;

        //probni ističe
        ECLExpering.RESET;
        ECLExpering.SETFILTER(Active, '%1', TRUE);
        ECLExpering.SETRANGE("Testing Period Ending Date", TODAY, CALCDATE(HRsetup."Probation Expire Days", TODAY));
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering2.RESET;
                ECLExpering2.SETFILTER("Employee No.", '%1', ECLExpering."Employee No.");
                ECLExpering2.SETFILTER("Starting Date", '>%1', ECLExpering."Starting Date");
                ECLExpering2.SETFILTER("Show Record", '%1', TRUE);
                ECLExpering2.SETCURRENTKEY("Starting Date");
                ECLExpering2.ASCENDING;
                IF ECLExpering2.FINDLAST THEN BEGIN
                    IF (ECLExpering2."Ending Date" <> 0D) AND (ECLExpering2."Ending Date" <= CALCDATE(HRsetup."Probation Expire Days", TODAY)) THEN BEGIN
                        ECLExpering."Is not extended P" := TRUE;
                        ECLExpering.MODIFY;

                    END;
                    ne := FALSE
                END
                ELSE BEGIN
                    ECLExpering."Is not extended P" := TRUE;
                    ECLExpering.MODIFY;
                END;
            UNTIL ECLExpering.NEXT = 0;

        //probni istekao
        date := 20010101D;
        ECLExpering.RESET;
        //ECLExpering.SETFILTER(Active,'%1',TRUE);
        ECLExpering.SETRANGE("Testing Period Ending Date", date, CALCDATE('<-1D>', TODAY));
        ECLExpering.SETFILTER("Grounds for Term. Description", '%1', '');
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering2.RESET;
                ECLExpering2.SETFILTER("Employee No.", '%1', ECLExpering."Employee No.");
                ECLExpering2.SETFILTER("Starting Date", '>%1', ECLExpering."Starting Date");
                ECLExpering2.SETCURRENTKEY("Starting Date");
                ECLExpering2.ASCENDING;
                IF ECLExpering2.FINDLAST THEN BEGIN
                    ne := FALSE
                END
                ELSE BEGIN
                    ECLExpering."Is not extended expired P" := TRUE;
                    ECLExpering.MODIFY;
                END;
            UNTIL ECLExpering.NEXT = 0;

        UnionEmployee.RESET;
        UnionEmployee.SETFILTER(Active, '%1', TRUE);
        UnionEmployee.SETFILTER("Date To", '<>%1 & <%2', 0D, WORKDATE);
        UnionEmployee.SetFilter(Types, '%1', UnionEmployee.Types::"Union Employees");
        IF UnionEmployee.FINDSET THEN
            REPEAT
                UnionEmployee.Active := FALSE;
                UnionEmployee.MODIFY;
            UNTIL UnionEmployee.NEXT = 0;
        UgovoriIstekli.RESET;
        UgovoriIstekli.SETFILTER("Ending Date", '<>%1&<%2', 0D, WORKDATE);
        UgovoriIstekli.SETFILTER("Grounds for Term. Description", '%1', '');
        UgovoriIstekli.SETFILTER(Active, '%1', TRUE);
        UgovoriIstekli.SETFILTER("Show Record", '%1', TRUE);
        IF UgovoriIstekli.FINDSET THEN
            REPEAT
                UgovoriIstekli.Active := FALSE;
                UgovoriIstekli.Status := UgovoriIstekli.Status::Terminated;
                UgovoriIstekli.MODIFY;

            UNTIL UgovoriIstekli.NEXT = 0;

        UgovoriIstekli.RESET;
        UgovoriIstekli.SETFILTER(Active, '%1', TRUE);
        UgovoriIstekli.SETFILTER("Show Record", '%1', FALSE);
        IF UgovoriIstekli.FINDSET THEN
            REPEAT
                UgovoriIstekli.Active := FALSE;
                UgovoriIstekli.MODIFY;

            UNTIL UgovoriIstekli.NEXT = 0;


        UgovoriIstekli.RESET;
        UgovoriIstekli.SETFILTER(Active, '%1', TRUE);
        UgovoriIstekli.SETFILTER("Show Record", '%1', TRUE);
        UgovoriIstekli.SETFILTER("Starting Date", '>%1', WORKDATE);
        IF UgovoriIstekli.FINDSET THEN
            REPEAT
                UgovoriIstekli.Active := FALSE;
                UgovoriIstekli.MODIFY;

            UNTIL UgovoriIstekli.NEXT = 0;

        ECL.RESET;
        ECL.CALCFIELDS("Manager 1");
        ECL.SETFILTER("Show Record", '%1', TRUE);
        ECL.SETFILTER("Manager 1", '%1', '');
        IF ECL.FINDSET THEN
            REPEAT
                PositionNema.RESET;
                PositionNema.SETFILTER("Org. Structure", '%1', ECL."Org. Structure");
                PositionNema.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                PositionNema.SETFILTER(Code, '%1', ECL."Position Code");
                PositionNema.SETFILTER(Description, '%1', ECL."Position Description");
                PositionNema.SETFILTER("Department Code", '%1', ECL."Department Code");
                PositionNema.SETFILTER("Department Name", '%1', ECL."Department Name");
                IF NOT PositionNema.FINDFIRST THEN
                    ECL.VALIDATE("Position Description", ECL."Position Description");
            UNTIL ECL.NEXT = 0;
        ECL5.RESET;
        ECL5.SETFILTER("Show Record", '%1', TRUE);
        ECL5.SETFILTER("Position Description", '<>%1', '');
        ECL5.SETFILTER("Starting Date", '<>%1', 0D);
        ECL5.SETFILTER("Reason for Change", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 3, 7, 8, 9, 10, 12, 4, 11, 15, 16);
        ECL5.SETCURRENTKEY("Starting Date");
        IF ECL5.FINDSET THEN
            REPEAT
                ECL.RESET;
                ECL.SETFILTER("Employee No.", '%1', ECL5."Employee No.");
                ECL.SETFILTER(Active, '%1', TRUE);
                IF ECL.FINDFIRST THEN BEGIN
                    ECL2.RESET;
                    ECL2.SETFILTER("Starting Date", '>%1', ECL."Starting Date");
                    ECL2.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                    ECL2.SETCURRENTKEY("Starting Date");
                    ECL2.SETFILTER("Show Record", '%1', TRUE);
                    ECL2.ASCENDING;
                    IF ECL2.FINDFIRST THEN BEGIN
                        IF ECL2."Starting Date" = ECL5."Starting Date" THEN BEGIN
                            ECL."Org Modification Date" := ECL5."Starting Date";
                            ECL.MODIFY;
                        END;
                    END;
                END;
            UNTIL ECL5.NEXT = 0;

        ECLOrg9.RESET;
        ECLOrg9.SETFILTER(Active, '%1', TRUE);
        IF ECLOrg9.FINDSET THEN
            REPEAT
                IF ECLOrg9."Ending Date" <> 0D THEN BEGIN
                    ECL2.RESET;
                    ECL2.SETFILTER("Employee No.", '%1', ECLOrg9."Employee No.");
                    ECL2.SETFILTER("Starting Date", '%1', CALCDATE('<+1D>', WORKDATE));
                    IF ECL2.FINDFIRST THEN BEGIN
                        ECLOrg9."Org Modification Date" := ECL2."Starting Date";
                        ECLOrg9.MODIFY;
                    END
                    ELSE BEGIN
                        ECLOrg9."Org Modification Date" := ECLOrg9."Starting Date";
                        ECLOrg9.MODIFY;
                    END;

                END
                ELSE BEGIN
                    ECLOrg9."Org Modification Date" := ECLOrg9."Starting Date";
                    ECLOrg9.MODIFY;
                END;


            UNTIL ECLOrg9.NEXT = 0;

    end;

    trigger OnPreReport()
    begin
        ECLExpering.RESET;
        ECLExpering.SETFILTER("Is not extended", '%1', TRUE);
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering."Is not extended" := FALSE;
                ECLExpering.MODIFY;
            UNTIL ECLExpering.NEXT = 0;
        ECLExpering.RESET;
        ECLExpering.SETFILTER("Is not extended expired", '%1', TRUE);
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering."Is not extended expired" := FALSE;
                ECLExpering.MODIFY;
            UNTIL ECLExpering.NEXT = 0;
        ECLExpering.RESET;
        ECLExpering.SETFILTER("Is not extended expired P", '%1', TRUE);
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering."Is not extended expired P" := FALSE;
                ECLExpering.MODIFY;
            UNTIL ECLExpering.NEXT = 0;
        ECLExpering.RESET;
        ECLExpering.SETFILTER("Is not extended P", '%1', TRUE);
        ECLExpering.SETFILTER("Show Record", '%1', TRUE);
        IF ECLExpering.FINDSET THEN
            REPEAT
                ECLExpering."Is not extended P" := FALSE;
                ECLExpering.MODIFY;
            UNTIL ECLExpering.NEXT = 0;
        ECL.RESET;
        ECL.SETFILTER("Three Years in company", '%1', TRUE);
        IF ECL.FINDSET THEN
            REPEAT
                ECL."Three Years in company" := FALSE;
                ECL.MODIFY;

            UNTIL ECL.NEXT = 0;
        ECL.RESET;
        ECL.SETFILTER("Department Code", '<>%1', '');
        ECL.SETFILTER("Department Name", '%1', '');
        ECL.SETFILTER("Show Record", '%1', TRUE);
        IF ECL.FINDSET THEN
            REPEAT
                IF ECL."Team Description" <> '' THEN BEGIN
                    Dep.RESET;
                    Dep.SETFILTER("Department Type", '%1', 9);
                    Dep.SETFILTER(Code, '%1', ECL.Team);
                    Dep.SETFILTER(Description, '%1', ECL."Team Description");
                    IF Dep.FINDFIRST THEN BEGIN
                        ECL."Department Name" := Dep.Description;
                        ECL.MODIFY;
                    END;
                END;
                IF (ECL."Group Description" <> '') AND (ECL."Team Description" = '') THEN BEGIN
                    Dep.RESET;
                    Dep.SETFILTER("Department Type", '%1', 2);
                    Dep.SETFILTER(Code, '%1', ECL.Group);
                    Dep.SETFILTER(Description, '%1', ECL."Group Description");
                    IF Dep.FINDFIRST THEN BEGIN
                        ECL."Department Name" := Dep.Description;
                        ECL.MODIFY;
                    END;
                END;
                IF (ECL."Group Description" = '') AND (ECL."Department Cat. Description" <> '') THEN BEGIN
                    Dep.RESET;
                    Dep.SETFILTER("Department Type", '%1', 4);
                    Dep.SETFILTER(Code, '%1', ECL."Department Category");
                    Dep.SETFILTER(Description, '%1', ECL."Department Cat. Description");
                    IF Dep.FINDFIRST THEN BEGIN
                        ECL."Department Name" := Dep.Description;
                        ECL.MODIFY;
                    END;
                END;
                IF (ECL."Sector Description" <> '') AND (ECL."Department Cat. Description" = '') THEN BEGIN
                    Dep.RESET;
                    Dep.SETFILTER("Department Type", '%1', 8);
                    Dep.SETFILTER(Code, '%1', ECL.Sector);
                    Dep.SETFILTER(Description, '%1', ECL."Sector Description");
                    IF Dep.FINDFIRST THEN BEGIN
                        ECL."Department Name" := Dep.Description;
                        ECL.MODIFY;
                    END;
                END;
            UNTIL ECL.NEXT = 0;



        Uggg.RESET;
        Uggg.SETFILTER("Starting Date", '%1', WORKDATE);
        IF Uggg.FINDSET THEN
            REPEAT
                Employee.RESET;
                Employee.SETFILTER("No.", '%1', Uggg."Employee No.");
                IF Employee.FINDSET THEN
                    REPEAT
                        WorkBooklet2.RESET;
                        WorkBooklet2.SETFILTER("Employee No.", '%1', Employee."No.");
                        WorkBooklet2.SETFILTER("Current Company", '%1', TRUE);
                        WorkBooklet2.SETFILTER("Hours change", '%1', FALSE);
                        WorkBooklet2.SETCURRENTKEY("Starting Date");
                        WorkBooklet2.ASCENDING;
                        IF WorkBooklet2.FINDLAST THEN BEGIN
                            Employee."Employment Date" := WorkBooklet2."Starting Date";
                            Employee.MODIFY;
                        END;
                    UNTIL Employee.NEXT = 0;
            UNTIL Uggg.NEXT = 0;
    end;

    var
        Employee: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        employee2: Record "Employee";
        HeadOfRefresh: Record "Head Of's";
        HeadOfRefresh2: Record "Head Of's";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        ECL2: Record "Employee Contract Ledger";
        ECL3: Record "Employee Contract Ledger";
        ECL4: Record "Employee Contract Ledger";
        ECLOrg9: Record "Employee Contract Ledger";
        OrgShema: Record "ORG Shema";
        WorkBooklet: Record "Work Booklet";
        TEXT: Label 'Update is done';
        ECLExpering: Record "Employee Contract Ledger";
        Date10: Date;
        HRsetup: Record "Human Resources Setup";
        ECLExpering2: Record "Employee Contract Ledger";
        ne: Boolean;
        DateUse: DateFormula;
        date: Date;
        WorkBooklet2: Record "Work Booklet";
        UnionEmployee: Record "Employee Diseases";
        UgovoriIstekli: Record "Employee Contract Ledger";
        Ugovori: Record "Employee Contract Ledger";
        Zaposlenik: Record "Employee";
        EmployeeRec: Record "Employee";
        DateBefore3Years: Date;
        Dep: Record "Department";
        PositionNema: Record "Position";
        Misc: Record "Misc. article information";
        Misc2: Record "Misc. article information";
        ECL5: Record "Employee Contract Ledger";
        Uggg: Record "Employee Contract Ledger";
        IH: Record "Installation History";
}

