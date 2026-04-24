/*codeunit 50021 "Employee/Resource Update 2020"
{
    //Permissions = TableData 156 = rimd;

    trigger OnRun()
    begin
    end;

    var
        Res: Record "Resource";
        myint: Integer;
        PersonalTrack: Record "Personal track report";
        EmployeeAbsence2: Record "Employee Absence";
        //korigovati na 2
        EmployeeDisease: Record "Employee Diseases";
        AlternativeAddress: Record "Alternative Address";
        HRCL: Record "Human Resource Comment Line";
        AdditionalEducation: Record "Additional Education";
        //   WorkViolations: Record "Work Duties Violation";
        EmployeeDisability: Record "Employee Level Of Disability";
        EmployeeAbsence: Record "Employee Absence";
        EmployeeAbsence1: Record "Employee Absence";
        Employee: Record "Employee";
        EmployeeLevelOfDisability: Record "Employee Level Of Disability";
        WageSetupRecord: Record "Wage Setup";
        EmploymentContract: Record "Employment Contract";
        CountryRegion: Record "Country/Region";
        EmployeeDiseas: Record "Employee Diseases";
        PersonalDoc: Record "Personal Documents";
        Qualifications: Record "Employee Qualification";
        WorkBooklet: Record "Work Booklet";
        Department: Record "Department";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeSurname: Record "Employee Surname";
        LineNo: Integer;
        Counter: Integer;
        PersonalTrackNo: Record "Personal track report";
        ecl: Record "Employee Contract Ledger";
        CountryCode: Record "Country/Region";
        MunicipalityCode: Record "Municipality";
        EndDate: Date;
        CompInf: Record "Company Information";
        PersonalDocument: Record "Personal Documents";
        WorkDays: Integer;
        Bom: Record Employee temporary;
        VocCount: Integer;
        counter2: Integer;
        EndDateFinal: Date;
        Qualification: Record "Employee Qualification";
        TotalDays: Integer;
        wd: Integer;
        StartDate: Date;
        CauseofAbsence: Record "Cause of Absence";
        Qua: Record "Qualification";
        StartDateFinal: Date;
        CodeAddr: Integer;
        EA1: Record "Employee Absence";

        //korigovati na 2
        ea: Record "Employee Absence";
        //korigovati na 2
        CodeAdditi: Integer;
        //   JobDescription: Record "Job description";
        //      JobDescriptionPers: Record "Job description personal";
        //    JobDescriptionPers2: Record "Job description personal";
        Personaltrack2: Record "Personal track 2";

    procedure HumanResToRes(OldEmployee: Record "Employee"; Employee: Record "Employee"; EmpOrECL: Integer) DatumPromjene: Date
    begin
    end;

    procedure ResUpdate(Employee: Record "Employee")
    begin
        Res.GET(Employee."Resource No.");
        Res."Job Title" := Employee."Job Title";
        Res.Name := COPYSTR(Employee.FullName, 1, 30);
        Res.Address := Employee.Address;
        Res."Address 2" := Employee."Address 2";
        Res.VALIDATE("Post Code", Employee."Post Code");
        Res."Social Security No." := Employee."Social Security No.";
        Res."Employment Date" := Employee."Employment Date";
        Res.MODIFY(TRUE)
    end;

    procedure AlternativeAddressFunc(OldAddress: Record "Alternative Address"; NewAddress: Record "Alternative Address")
    begin
        Bom.DeleteAll();
        PersonalTrack.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        if OldAddress.Code <> '' then
            Evaluate(myint, OldAddress."Code")
        else
            myint := 0;
        PersonalTrack.SETFILTER("Code Addr", '%1', myint);
        PersonalTrack.SETFILTER("Code Additional", '%1', 0);
        PersonalTrack.SETFILTER("Code Personal", '%1', '');
        PersonalTrack.SETFILTER("Contract No", '%1', 0);
        IF PersonalTrack.FINDSET THEN
            REPEAT


                if OldAddress."Code" <> '' then
                    Evaluate(myint, OldAddress."Code")
                else
                    myint := 0;


                IF (myint <> 0) OR (OldAddress."Insert Date" <> 0D) THEN
                    PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;
        PersonalTrack.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Code Addr", '%1', 0);
        IF PersonalTrack.FINDSET THEN
            REPEAT
                PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;


        PersonalTrack.INIT;
        PersonalTrack."Date of change" := TODAY;
        PersonalTrack."Indication for work experience" := FALSE;
        PersonalTrack."Indication of capability" := FALSE;
        if NewAddress.Code <> '' then
            Evaluate(myint, NewAddress."Code")
        else
            myint := 0;
        PersonalTrack."Code Addr" := myint;
        Employee.RESET;
        Employee.SETFILTER("No.", '%1', NewAddress."Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            PersonalTrack.JMBG := Employee."Employee ID";
            IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
                PersonalTrack."Employee type" := 1
            ELSE
                PersonalTrack."Employee type" := 2;

            //ugovoreni dnevni
            PersonalTrack."Working Hours Day" := Employee."Hours In Day";
            //ugovoreni sedmični
            PersonalTrack."Working Hours Week" := Employee."Hours In Day" * 5;

            //prethodni radni staž
            PersonalTrack."Work Experience Year" := Employee."Brought Years Total";
            PersonalTrack."Work Experience Month" := Employee."Brought Months Total";
            PersonalTrack."Work Experience Day" := Employee."Brought Days Total";

            //zaposlenikom stručni ispis - datum polaganja
            PersonalTrack."Proffesional Exam Date" := Employee."Professional Examination Date";


            //rezultat stručnog ispita

            PersonalTrack."Proffesional Exam Result" := FORMAT(Employee."Professional Exam. Result");

            //certifikat
            HRCL.RESET;
            HRCL.SETFILTER("No.", '%1', NewAddress."Employee No.");

            HRCL.SETFILTER(Comment, '%1', 'Certifikat');
            IF HRCL.FINDFIRST THEN BEGIN
                //Employee Qualification tabela
                Qualifications.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
                Qualifications.SETFILTER("Line No.", '%1', HRCL."Table Line No.");
                IF Qualifications.FINDFIRST THEN
                    PersonalTrack.Certificate := Qualifications.Description
                ELSE
                    PersonalTrack.Certificate := '';
            END;


            //datum zaposlenja
            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);

            IF NewAddress."Date From (CIPS)" = 0D THEN
                WorkBooklet.SETFILTER("Starting Date", '<=%1', NewAddress."Insert Date")
            ELSE
                WorkBooklet.SETFILTER("Starting Date", '<=%1', NewAddress."Date From");
            WorkBooklet.SETCURRENTKEY("Starting Date");
            WorkBooklet.ASCENDING;
            IF WorkBooklet.FINDLAST THEN
                PersonalTrack."Employment Date" := WorkBooklet."Starting Date";


            //naziv stručnog ispita
            Qualification.RESET;
            Qualification.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
            IF NewAddress."Date From (CIPS)" = 0D THEN
                Qualification.SETFILTER("From Date", '<=%1', NewAddress."Insert Date")
            ELSE
                Qualification.SETFILTER("From Date", '<=%1', NewAddress."Date From");

            IF Qualification.FINDSET THEN
                REPEAT
                    Qua.RESET;
                    Qua.SETFILTER(Code, '%1', Qualification."Qualification Code");
                    IF Qua.FINDFIRST THEN BEGIN
                        PersonalTrack."Proffessional Exam" := PersonalTrack."Proffessional Exam" + ' /' + Qualification.Description;
                    END
                    ELSE BEGIN
                        PersonalTrack."Proffessional Exam" := '';
                    END;
                UNTIL Qualification.NEXT = 0;


            //dosje

            PersonalTrack."Line No." := Employee."Internal ID";

            //personalni broj
            PersonalTrack."Employee No." := NewAddress."Employee No.";
            //ime
            PersonalTrack."First Name" := Employee."First Name";

            //prezime
            PersonalTrack."Last Name" := Employee."Last Name";

            //spol
            PersonalTrack.Gender := Employee.Gender;

            //datum rođenja
            PersonalTrack."Birth Date" := Employee."Birth Date";

            // grad rođenja
            PersonalTrack."Birth City" := Employee."Birth City";

            //mjesto rođenja
            PersonalTrack."Place of birth" := Employee."Place of birth";

            //država rođenja
            CountryCode.RESET;
            CountryCode.SETFILTER(Code, '%1', Employee."Country/Region Code of Birth");
            IF CountryCode.FINDFIRST THEN
                PersonalTrack."Birth State" := CountryCode.Name

            ELSE
                PersonalTrack."Birth State" := '';


            //opština rođenja
            MunicipalityCode.RESET;
            MunicipalityCode.SETFILTER(Code, '%1', Employee."Municipality Code of Birth");
            MunicipalityCode.SETFILTER("Country/Region Code", '%1', Employee."Country/Region Code of Birth");
            MunicipalityCode.SetFilter(type, '%1', MunicipalityCode.Type::Regular);
            IF MunicipalityCode.FINDFIRST THEN
                PersonalTrack."Birth Municipality" := MunicipalityCode.Name
            ELSE
                PersonalTrack."Birth Municipality" := '';

            //državljanstvo


            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::Citizenship);
            IF NewAddress."Date From (CIPS)" = 0D THEN
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAddress."Insert Date")
            ELSE
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAddress."Date From (CIPS)");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN
                PersonalTrack.Citizenship := PersonalDocument."Citizenship Description"
            ELSE
                PersonalTrack.Citizenship := '';


            AdditionalEducation.RESET;
            AdditionalEducation.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
            IF NewAddress."Date From (CIPS)" = 0D THEN
                AdditionalEducation.SETFILTER("From Date", '<=%1', NewAddress."Insert Date")
            ELSE
                AdditionalEducation.SETFILTER("From Date", '<=%1', NewAddress."Date From (CIPS)");
            AdditionalEducation.SETCURRENTKEY("From Date");
            AdditionalEducation.ASCENDING;
            IF AdditionalEducation.FINDLAST THEN BEGIN

                //stručna sprema
                PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level");
                //završena obrazovna

                PersonalTrack."Additional Education" := AdditionalEducation."School of Graduation";
                //zvanje
                PersonalTrack."Title Description" := AdditionalEducation."Title Description";
            END
            ELSE BEGIN
                //stručna sprema
                PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level"::Empty);
                //završena obrazovna

                PersonalTrack."Additional Education" := '';
                //zvanje
                PersonalTrack."Title Description" := '';

            END;


            //radna dozvola

            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Work Permit");
            IF NewAddress."Date From (CIPS)" = 0D THEN
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAddress."Insert Date")
            ELSE
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAddress."Date From (CIPS)");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Work Permit Code" := PersonalDocument."Work Permit";
                PersonalTrack."Work Permit Type" := FORMAT(PersonalDocument."Type Of Work Permit");
                PersonalTrack."Work Permit To" := PersonalDocument."Date To";
                PersonalTrack."Work Permit From" := PersonalDocument."Date From";
            END
            ELSE BEGIN
                PersonalTrack."Work Permit Code" := '';
                PersonalTrack."Work Permit Type" := '';
                PersonalTrack."Work Permit To" := 0D;
                PersonalTrack."Work Permit From" := 0D;
            END;




            //boravišna dozvola

            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Residence Permit");
            IF NewAddress."Date From (CIPS)" = 0D THEN
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAddress."Insert Date")
            ELSE
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAddress."Date From (CIPS)");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Residence Permit Code" := PersonalDocument."Residence Permit";
                PersonalTrack."Residence Permit From" := PersonalDocument."Date From";
                PersonalTrack."Residence Permit To" := PersonalDocument."Date To";
            END
            ELSE BEGIN
                PersonalTrack."Residence Permit Code" := '';
                PersonalTrack."Residence Permit From" := 0D;
                PersonalTrack."Residence Permit To" := 0D;
            END;



        END;

        Personaltrack2.RESET;
        Personaltrack2.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        Personaltrack2.SETFILTER("Date of change", '%1', TODAY);
        if NewAddress."Code" <> '' then
            Evaluate(myint, NewAddress."Code")
        else
            myint := 0;
        Personaltrack2.SETFILTER("Code Addr", '%1', myint);
        Personaltrack2.SETFILTER("Code Additional", '%1', 0);
        Personaltrack2.SETFILTER("Code Personal", '%1', '');
        Personaltrack2.SETFILTER("Contract No", '%1', 0);
        IF Personaltrack2.FINDFIRST THEN
            Personaltrack2.DELETE;

        Personaltrack2.RESET;
        Personaltrack2.INIT;
        Personaltrack2."Line No." := Employee."Internal ID";
        IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
            Personaltrack2."Employee type" := 1
        ELSE
            Personaltrack2."Employee type" := 2;


        if NewAddress."Code" <> '' then
            Evaluate(myint, NewAddress."Code")
        else
            myint := 0;

        Personaltrack2."Code Addr" := myint;
        Personaltrack2."Code Additional" := 0;
        Personaltrack2."Code Personal" := '';
        Personaltrack2."Employee No." := Employee."No.";
        Personaltrack2."First Name" := Employee."First Name";
        Personaltrack2."Last Name" := Employee."Last Name";
        Personaltrack2."Date of change" := TODAY;

        //čuvanje trudnoće

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_6', 'B_7');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence."Code");
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_6', 'B_7');
        IF Bom.FINDSET THEN
            REPEAT




                IF Personaltrack2."Pregnancy Keeping From" <> '' THEN
                    Personaltrack2."Pregnancy Keeping From" := Personaltrack2."Pregnancy Keeping From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Keeping From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
UNTIL Bom.NEXT = 0;







        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        // majčinstvo
        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF Bom.FINDSET THEN
            REPEAT

                IF Personaltrack2."Pregnancy Leave From" <> '' THEN
                    Personaltrack2."Pregnancy Leave From" := Personaltrack2."Pregnancy Leave From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Leave From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Pregnancy Leave From" <> '' THEN
            Personaltrack2."Pregnancy Leave From" := COPYSTR(Personaltrack2."Pregnancy Leave From", 1, STRLEN(Personaltrack2."Pregnancy Leave From") - 1);


        //povreda na radu


        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_4', 'B_5');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_4', 'B_5');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Work Violation Note" <> '' THEN
                    Personaltrack2."Work Violation Note" := Personaltrack2."Work Violation Note" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Work Violation Note" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Work Violation Note" <> '' THEN
            Personaltrack2."Work Violation Note" := COPYSTR(Personaltrack2."Work Violation Note", 1, STRLEN(Personaltrack2."Work Violation Note") - 1);




        //invalidnost
        Personaltrack2."Employee Disability" := 'Ne';

        //Decrease Inability
        //Smanjenje radne sposobnosti uz preostalu radnu sposobnost

        EmployeeLevelOfDisability.RESET;
        EmployeeLevelOfDisability.SETFILTER("Employee No.", '%1', NewAddress."Employee No.");
        IF NewAddress."Date From (CIPS)" = 0D THEN
            EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', NewAddress."Insert Date")
        ELSE
            EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', NewAddress."Date From (CIPS)");
        EmployeeLevelOfDisability.SETCURRENTKEY("Date From");
        EmployeeLevelOfDisability.ASCENDING;
        IF EmployeeLevelOfDisability.FINDLAST THEN BEGIN


            Personaltrack2."Decrease Inability" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Employee Disability" := 'Da';

            Personaltrack2."Partial decrease Inability" := EmployeeLevelOfDisability."Level of Disability";
            Personaltrack2."Risk of impairment" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Level of partial disability" := EmployeeLevelOfDisability."Level of Disability";
        END
        ELSE BEGIN
            Personaltrack2."Decrease Inability" := '';
            Personaltrack2."Employee Disability" := 'Ne';
            Personaltrack2."Partial decrease Inability" := '';
            Personaltrack2."Risk of impairment" := '';
            Personaltrack2."Level of partial disability" := '';
        END;

        IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
            Personaltrack2."Employee type" := 1
        ELSE
            Personaltrack2."Employee type" := 2;

        //NE    Personaltrack2.INSERT;


        //prebivalište
        PersonalTrack."Address CIPS" := NewAddress."Address CIPS";
        PersonalTrack."City CIPS" := NewAddress."City CIPS";
        PersonalTrack."Municipality CIPS" := NewAddress."Municipality Name CIPS";
        PersonalTrack."Entity CIPS" := NewAddress."Entity Code CIPS";


        //boravište
        PersonalTrack."Address Real" := NewAddress.Address;
        PersonalTrack."City Real" := NewAddress.City;
        PersonalTrack."Municipality Real" := NewAddress."Municipality Name";
        PersonalTrack."Entity Real" := NewAddress."Entity Code";
        CompInf.GET;
        PersonalTrack."Employee activity" := CompInf."Industrial Classification";
        //NE   PersonalTrack.INSERT;
    end;

    procedure EmployeeChange(OldEmployee: Record "Employee"; NewEmployee: Record "Employee")
    begin



        AlternativeAddress.RESET;
        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
        AlternativeAddress.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        IF AlternativeAddress.FINDFIRST THEN begin


            if AlternativeAddress."Code" <> '' then
                Evaluate(myint, AlternativeAddress."Code")
            else
                myint := 0;


            CodeAddr := myint;
        end;
        AdditionalEducation.RESET;
        AdditionalEducation.SETFILTER(Active, '%1', TRUE);
        AdditionalEducation.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        IF AdditionalEducation.FINDFIRST THEN
            CodeAdditi := AdditionalEducation."Entry No.";

        AdditionalEducation.RESET;
        AdditionalEducation.SETFILTER(Active, '%1', TRUE);
        AdditionalEducation.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        IF AdditionalEducation.FINDFIRST THEN
            PersonalTrack.SETFILTER("Code Additional", '%1', AdditionalEducation."Entry No.");

        PersonalTrack.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);


        if AlternativeAddress."Code" <> '' then
            Evaluate(myint, AlternativeAddress."Code")
        else
            myint := 0;

        PersonalTrack.SETFILTER("Code Addr", '%1', myint);

        IF PersonalTrack.FINDSET THEN
            REPEAT
                PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;










        PersonalTrack.INIT;
        PersonalTrack."Date of change" := TODAY;
        PersonalTrack."Indication for work experience" := FALSE;
        PersonalTrack."Indication of capability" := FALSE;


        //adresa CIPS
        PersonalTrack."Code Addr" := CodeAddr;
        PersonalTrack."Address CIPS" := AlternativeAddress."Address CIPS";
        PersonalTrack."City CIPS" := AlternativeAddress."City CIPS";
        PersonalTrack."Municipality CIPS" := AlternativeAddress."Municipality Name CIPS";
        PersonalTrack."Entity CIPS" := AlternativeAddress."Entity Code CIPS";

        //adresa stvarna
        PersonalTrack."Address Real" := AlternativeAddress.Address;
        PersonalTrack."City Real" := AlternativeAddress.City;
        PersonalTrack."Municipality Real" := AlternativeAddress."Municipality Name";
        PersonalTrack."Entity Real" := AlternativeAddress."Entity Code";


        Employee.RESET;
        Employee.SETFILTER("No.", '%1', NewEmployee."No.");
        IF Employee.FINDFIRST THEN BEGIN
            PersonalTrack.JMBG := NewEmployee."Employee ID";
            IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
                PersonalTrack."Employee type" := 1
            ELSE
                PersonalTrack."Employee type" := 2;


            PersonalTrack."Working Hours Day" := NewEmployee."Hours In Day";
            PersonalTrack."Working Hours Week" := NewEmployee."Hours In Day" * 5;
            PersonalTrack."Work Experience Year" := NewEmployee."Brought Years Total";
            PersonalTrack."Work Experience Month" := NewEmployee."Brought Months Total";
            PersonalTrack."Work Experience Day" := NewEmployee."Brought Days Total";
            PersonalTrack."Proffesional Exam Date" := NewEmployee."Professional Examination Date";
            PersonalTrack."Proffesional Exam Result" := FORMAT(NewEmployee."Professional Exam. Result");
            HRCL.SETFILTER("No.", '%1', NewEmployee."No.");
            HRCL.SETFILTER(Comment, '%1', 'Certifikat');
            IF HRCL.FINDFIRST THEN BEGIN
                //Employee Qualification tabela
                Qualifications.SETFILTER("Employee No.", '%1', NewEmployee."No.");
                Qualifications.SETFILTER("Line No.", '%1', HRCL."Table Line No.");
                IF Qualifications.FINDFIRST THEN
                    PersonalTrack.Certificate := Qualifications.Description
                ELSE
                    PersonalTrack.Certificate := '';
            END;

            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", '%1', NewEmployee."No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
            WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY);
            WorkBooklet.SETCURRENTKEY("Starting Date");
            WorkBooklet.ASCENDING;
            IF WorkBooklet.FINDLAST THEN
                PersonalTrack."Employment Date" := WorkBooklet."Starting Date";

            //naziv stručnog ispita

            Qualification.RESET;
            Qualification.SETFILTER("Employee No.", '%1', NewEmployee."No.");
            Qualification.SETFILTER("From Date", '<=%1', TODAY);

            IF Qualification.FINDSET THEN
                REPEAT
                    Qua.RESET;
                    Qua.SETFILTER(Code, '%1', Qualification."Qualification Code");
                    IF Qua.FINDFIRST THEN BEGIN
                        PersonalTrack."Proffessional Exam" := PersonalTrack."Proffessional Exam" + ' ;' + Qualification.Description;
                    END
                    ELSE BEGIN
                        PersonalTrack."Proffessional Exam" := '';
                    END;
                UNTIL Qualification.NEXT = 0;


            PersonalTrack."Line No." := NewEmployee."Internal ID";
            PersonalTrack."Employee No." := NewEmployee."No.";
            PersonalTrack."First Name" := NewEmployee."First Name";
            PersonalTrack."Last Name" := NewEmployee."Last Name";

            PersonalTrack.Gender := NewEmployee.Gender;
            PersonalTrack."Birth Date" := NewEmployee."Birth Date";
            PersonalTrack."Birth City" := NewEmployee."Birth City";
            PersonalTrack."Place of birth" := NewEmployee."Place of birth";


            CountryCode.RESET;
            CountryCode.SETFILTER(Code, '%1', NewEmployee."Country/Region Code of Birth");
            IF CountryCode.FINDFIRST THEN
                PersonalTrack."Birth State" := CountryCode.Name
            ELSE
                PersonalTrack."Birth State" := '';



            MunicipalityCode.RESET;
            MunicipalityCode.SETFILTER(Code, '%1', NewEmployee."Municipality Code of Birth");
            MunicipalityCode.SETFILTER("Country/Region Code", '%1', NewEmployee."Country/Region Code of Birth");
            MunicipalityCode.SetFilter(type, '%1', MunicipalityCode.Type::Regular);
            IF MunicipalityCode.FINDFIRST THEN
                PersonalTrack."Birth Municipality" := MunicipalityCode.Name
            ELSE
                PersonalTrack."Birth Municipality" := '';



            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewEmployee."No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::Citizenship);
            PersonalDocument.SETFILTER("Date From", '<=%1', TODAY);
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN
                PersonalTrack.Citizenship := PersonalDocument."Citizenship Description"
            ELSE
                PersonalTrack.Citizenship := '';



            AdditionalEducation.RESET;
            AdditionalEducation.SETFILTER("Employee No.", '%1', NewEmployee."No.");
            AdditionalEducation.SETFILTER("From Date", '<=%1', TODAY);
            AdditionalEducation.SETCURRENTKEY("From Date");
            AdditionalEducation.ASCENDING;
            IF AdditionalEducation.FINDLAST THEN BEGIN
                PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level");
                PersonalTrack."Additional Education" := AdditionalEducation."School of Graduation";
                PersonalTrack."Title Description" := AdditionalEducation."Title Description";
                PersonalTrack."Code Additional" := AdditionalEducation."Entry No.";
            END
            ELSE BEGIN
                PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level"::Empty);
                PersonalTrack."Additional Education" := '';
                PersonalTrack."Title Description" := '';
                PersonalTrack."Code Additional" := 0;


            END;

            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewEmployee."No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Work Permit");
            PersonalDocument.SETFILTER("Date From", '<=%1', TODAY);
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Work Permit Code" := PersonalDocument."Work Permit";
                PersonalTrack."Work Permit Type" := FORMAT(PersonalDocument."Type Of Work Permit");
                PersonalTrack."Work Permit To" := PersonalDocument."Date To";
                PersonalTrack."Work Permit From" := PersonalDocument."Date From";
            END
            ELSE BEGIN
                PersonalTrack."Work Permit Code" := '';
                PersonalTrack."Work Permit Type" := '';
                PersonalTrack."Work Permit To" := 0D;
                PersonalTrack."Work Permit From" := 0D;
            END;


            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewEmployee."No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Residence Permit");
            PersonalDocument.SETFILTER("Date From", '<=%1', TODAY);
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Residence Permit Code" := PersonalDocument."Residence Permit";
                PersonalTrack."Residence Permit From" := PersonalDocument."Date From";
                PersonalTrack."Residence Permit To" := PersonalDocument."Date To";
            END
            ELSE BEGIN
                PersonalTrack."Residence Permit Code" := '';
                PersonalTrack."Residence Permit To" := 0D;
                PersonalTrack."Residence Permit From" := 0D;
            END;
        END;



        Personaltrack2.RESET;
        Personaltrack2.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        Personaltrack2.SETFILTER("Date of change", '%1', TODAY);
        Personaltrack2.SETFILTER("Code Addr", '%1', CodeAddr);
        IF Personaltrack2.FINDFIRST THEN
            Personaltrack2.DELETE;

        Personaltrack2.RESET;
        Personaltrack2.INIT;
        Personaltrack2."Date of change" := TODAY;
        Personaltrack2."Line No." := NewEmployee."Internal ID";
        Personaltrack2."Code Addr" := CodeAddr;
        Personaltrack2."Code Additional" := AdditionalEducation."Entry No.";
        Personaltrack2."Code Personal" := PersonalDocument.Code;
        Personaltrack2."Employee No." := NewEmployee."No.";
        Personaltrack2."First Name" := NewEmployee."First Name";
        Personaltrack2."Last Name" := NewEmployee."Last Name";

        //čuvanje trudnoće

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_6', 'B_7');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_6', 'B_7');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Pregnancy Keeping From" <> '' THEN
                    Personaltrack2."Pregnancy Keeping From" := Personaltrack2."Pregnancy Keeping From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Keeping From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
UNTIL Bom.NEXT = 0;







        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        // majčinstvo
        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;







            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        Bom.SETFILTER("Search Name", '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Pregnancy Leave From" <> '' THEN
                    Personaltrack2."Pregnancy Leave From" := Personaltrack2."Pregnancy Leave From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Leave From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Pregnancy Leave From" <> '' THEN
            Personaltrack2."Pregnancy Leave From" := COPYSTR(Personaltrack2."Pregnancy Leave From", 1, STRLEN(Personaltrack2."Pregnancy Leave From") - 1);


        //povreda na radu


        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_4', 'B_5');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_4', 'B_5');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Work Violation Note" <> '' THEN
                    Personaltrack2."Work Violation Note" := Personaltrack2."Work Violation Note" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Work Violation Note" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")

UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Work Violation Note" <> '' THEN
            Personaltrack2."Work Violation Note" := COPYSTR(Personaltrack2."Work Violation Note", 1, STRLEN(Personaltrack2."Work Violation Note") - 1);




        //invalidnost
        Personaltrack2."Employee Disability" := 'Ne';

        //Decrease Inability
        //Smanjenje radne sposobnosti uz preostalu radnu sposobnost

        EmployeeLevelOfDisability.RESET;
        EmployeeLevelOfDisability.SETFILTER("Employee No.", '%1', NewEmployee."No.");
        EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', TODAY);
        EmployeeLevelOfDisability.SETCURRENTKEY("Date From");
        EmployeeLevelOfDisability.ASCENDING;
        IF EmployeeLevelOfDisability.FINDLAST THEN BEGIN
            Personaltrack2."Decrease Inability" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Employee Disability" := 'Da';

            Personaltrack2."Partial decrease Inability" := EmployeeLevelOfDisability."Level of Disability";
            Personaltrack2."Risk of impairment" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Level of partial disability" := EmployeeLevelOfDisability."Level of Disability";
        END
        ELSE BEGIN
            Personaltrack2."Decrease Inability" := '';
            Personaltrack2."Employee Disability" := 'Ne';
            Personaltrack2."Partial decrease Inability" := '';
            Personaltrack2."Risk of impairment" := '';
            Personaltrack2."Level of partial disability" := '';
        END;

        IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
            Personaltrack2."Employee type" := 1
        ELSE
            Personaltrack2."Employee type" := 2;

        //NE    Personaltrack2.INSERT;
        CompInf.GET;
        PersonalTrack."Employee activity" := CompInf."Industrial Classification";
        //NE  PersonalTrack.INSERT;
    end;

    procedure AdditionalEducation2(OldAdditionalE: Record "Additional Education"; NewAdditionalE: Record "Additional Education")
    begin

        PersonalTrack.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Code Additional", '%1', NewAdditionalE."Entry No.");
        PersonalTrack.SETFILTER("Code Personal", '%1', '');
        PersonalTrack.SETFILTER("Contract No", '%1', 0);
        PersonalTrack.SETFILTER("Code Addr", '%1', 0);

        IF PersonalTrack.FINDSET THEN
            REPEAT
                IF (NewAdditionalE."Entry No." <> 0) THEN
                    PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;
        PersonalTrack.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Code Additional", '%1', 0);
        PersonalTrack.SETFILTER("Code Personal", '%1', '');
        PersonalTrack.SETFILTER("Contract No", '%1', 0);
        PersonalTrack.SETFILTER("Code Addr", '%1', 0);


        IF PersonalTrack.FINDSET THEN
            REPEAT
                PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;


        PersonalTrack.INIT;
        PersonalTrack."Date of change" := TODAY;
        PersonalTrack."Indication for work experience" := FALSE;
        PersonalTrack."Indication of capability" := FALSE;
        PersonalTrack."Code Additional" := NewAdditionalE."Entry No.";
        Employee.RESET;
        Employee.SETFILTER("No.", '%1', NewAdditionalE."Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            PersonalTrack.JMBG := Employee."Employee ID";
            IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
                PersonalTrack."Employee type" := 1
            ELSE
                PersonalTrack."Employee type" := 2;
            PersonalTrack."Working Hours Day" := Employee."Hours In Day";
            PersonalTrack."Working Hours Week" := Employee."Hours In Day" * 5;
            PersonalTrack."Work Experience Year" := Employee."Brought Years Total";
            PersonalTrack."Work Experience Month" := Employee."Brought Months Total";
            PersonalTrack."Work Experience Day" := Employee."Brought Days Total";
            PersonalTrack."Proffesional Exam Date" := Employee."Professional Examination Date";
            PersonalTrack."Proffesional Exam Result" := FORMAT(Employee."Professional Exam. Result");
            HRCL.SETFILTER("No.", '%1', NewAdditionalE."Employee No.");
            HRCL.SETFILTER(Comment, '%1', 'Certifikat');
            IF HRCL.FINDFIRST THEN BEGIN
                //Employee Qualification tabela
                Qualifications.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
                Qualifications.SETFILTER("Line No.", '%1', HRCL."Table Line No.");
                IF Qualifications.FINDFIRST THEN
                    PersonalTrack.Certificate := Qualifications.Description
                ELSE
                    PersonalTrack.Certificate := '';
            END;

            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);



            IF NewAdditionalE."From Date" = 0D THEN
                WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY)
            ELSE
                WorkBooklet.SETFILTER("Starting Date", '<=%1', NewAdditionalE."From Date");
            WorkBooklet.SETCURRENTKEY("Starting Date");
            WorkBooklet.ASCENDING;
            IF WorkBooklet.FINDLAST THEN
                PersonalTrack."Employment Date" := WorkBooklet."Starting Date";


            Qualification.RESET;
            Qualification.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
            IF NewAdditionalE."From Date" = 0D THEN
                Qualification.SETFILTER("From Date", '<=%1', TODAY)
            ELSE
                Qualification.SETFILTER("From Date", '<=%1', NewAdditionalE."From Date");

            IF Qualification.FINDSET THEN
                REPEAT
                    Qua.RESET;
                    Qua.SETFILTER(Code, '%1', Qualification."Qualification Code");
                    IF Qua.FINDFIRST THEN BEGIN
                        PersonalTrack."Proffessional Exam" := PersonalTrack."Proffessional Exam" + ' ;' + Qualification.Description;
                    END
                    ELSE BEGIN
                        PersonalTrack."Proffessional Exam" := '';
                    END;
                UNTIL Qualification.NEXT = 0;


            PersonalTrack."Line No." := Employee."Internal ID";
            PersonalTrack."Employee No." := NewAdditionalE."Employee No.";
            PersonalTrack."First Name" := Employee."First Name";
            PersonalTrack."Last Name" := Employee."Last Name";
            PersonalTrack.Gender := Employee.Gender;
            PersonalTrack."Birth Date" := Employee."Birth Date";
            PersonalTrack."Birth City" := Employee."Birth City";
            PersonalTrack."Place of birth" := Employee."Place of birth";
            CountryCode.RESET;
            CountryCode.SETFILTER(Code, '%1', Employee."Country/Region Code of Birth");
            IF CountryCode.FINDFIRST THEN
                PersonalTrack."Birth State" := CountryCode.Name
            ELSE
                PersonalTrack."Birth State" := '';
            MunicipalityCode.RESET;
            MunicipalityCode.SETFILTER(Code, '%1', Employee."Municipality Code of Birth");
            MunicipalityCode.SETFILTER("Country/Region Code", '%1', Employee."Country/Region Code of Birth");
            MunicipalityCode.SetFilter(type, '%1', MunicipalityCode.Type::Regular);
            IF MunicipalityCode.FINDFIRST THEN
                PersonalTrack."Birth Municipality" := MunicipalityCode.Name
            ELSE
                PersonalTrack."Birth Municipality" := '';


            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::Citizenship);
            IF NewAdditionalE."From Date" = 0D THEN
                PersonalDocument.SETFILTER("Date From", '<=%1', TODAY)
            ELSE
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAdditionalE."From Date");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN
                PersonalTrack.Citizenship := PersonalDocument."Citizenship Description"
            ELSE
                PersonalTrack.Citizenship := '';



            PersonalTrack."Education Level" := FORMAT(NewAdditionalE."Education Level");
            PersonalTrack."Additional Education" := NewAdditionalE."School of Graduation";
            PersonalTrack."Title Description" := NewAdditionalE."Title Description";


            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Work Permit");
            IF NewAdditionalE."From Date" = 0D THEN
                PersonalDocument.SETFILTER("Date From", '<=%1', TODAY)
            ELSE
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAdditionalE."From Date");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Work Permit Code" := PersonalDocument."Work Permit";
                PersonalTrack."Work Permit Type" := FORMAT(PersonalDocument."Type Of Work Permit");
                PersonalTrack."Work Permit To" := PersonalDocument."Date To";
                PersonalTrack."Work Permit From" := PersonalDocument."Date From";
            END
            ELSE BEGIN
                PersonalTrack."Work Permit Code" := '';
                PersonalTrack."Work Permit Type" := '';
                PersonalTrack."Work Permit To" := 0D;
                PersonalTrack."Work Permit From" := 0D;
            END;



            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Residence Permit");
            IF NewAdditionalE."From Date" = 0D THEN
                PersonalDocument.SETFILTER("Date From", '<=%1', TODAY)
            ELSE
                PersonalDocument.SETFILTER("Date From", '<=%1', NewAdditionalE."From Date");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Residence Permit Code" := PersonalDocument."Residence Permit";
                PersonalTrack."Residence Permit To" := PersonalDocument."Date To";
                PersonalTrack."Residence Permit From" := PersonalDocument."Date From";
            END
            ELSE BEGIN
                PersonalTrack."Residence Permit Code" := '';
                PersonalTrack."Residence Permit To" := 0D;
                PersonalTrack."Residence Permit From" := 0D;
            END;



        END;



        AlternativeAddress.RESET;
        AlternativeAddress.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        IF NewAdditionalE."From Date" = 0D THEN
            AlternativeAddress.SETFILTER("Date From (CIPS)", '<=%1', TODAY)
        ELSE
            AlternativeAddress.SETFILTER("Date From (CIPS)", '<=%1', NewAdditionalE."From Date");
        AlternativeAddress.SETCURRENTKEY("Date From (CIPS)");
        AlternativeAddress.ASCENDING;
        IF AlternativeAddress.FINDLAST THEN BEGIN
            PersonalTrack."Address CIPS" := AlternativeAddress."Address CIPS";
            PersonalTrack."City CIPS" := AlternativeAddress."City CIPS";
            PersonalTrack."Municipality CIPS" := AlternativeAddress."Municipality Name CIPS";
            PersonalTrack."Entity CIPS" := AlternativeAddress."Entity Code CIPS";

            PersonalTrack."Address Real" := AlternativeAddress.Address;
            PersonalTrack."City Real" := AlternativeAddress.City;
            PersonalTrack."Municipality Real" := AlternativeAddress."Municipality Name";
            PersonalTrack."Entity Real" := AlternativeAddress."Entity Code";


        END;



        Personaltrack2.RESET;
        Personaltrack2.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        Personaltrack2.SETFILTER("Date of change", '%1', TODAY);
        Personaltrack2.SETFILTER("Code Additional", '%1', NewAdditionalE."Entry No.");
        IF Personaltrack2.FINDFIRST THEN
            Personaltrack2.DELETE;

        Personaltrack2.RESET;
        Personaltrack2.INIT;
        Personaltrack2."Date of change" := TODAY;
        Personaltrack2."Line No." := Employee."Internal ID";
        Personaltrack2."Code Addr" := 0;
        Personaltrack2."Code Additional" := NewAdditionalE."Entry No.";
        Personaltrack2."Code Personal" := '';
        Personaltrack2."Employee No." := Employee."No.";
        Personaltrack2."First Name" := Employee."First Name";
        Personaltrack2."Last Name" := Employee."Last Name";

        //čuvanje trudnoće

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_6', 'B_7');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_6', 'B_7');
        IF Bom.FINDSET THEN
            REPEAT

                IF Personaltrack2."Pregnancy Keeping From" <> '' THEN
                    Personaltrack2."Pregnancy Keeping From" := Personaltrack2."Pregnancy Keeping From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Keeping From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
UNTIL Bom.NEXT = 0;







        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        // majčinstvo
        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF Bom.FINDSET THEN
            REPEAT

                IF Personaltrack2."Pregnancy Leave From" <> '' THEN
                    Personaltrack2."Pregnancy Leave From" := Personaltrack2."Pregnancy Leave From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Leave From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Pregnancy Leave From" <> '' THEN
            Personaltrack2."Pregnancy Leave From" := COPYSTR(Personaltrack2."Pregnancy Leave From", 1, STRLEN(Personaltrack2."Pregnancy Leave From") - 1);


        //povreda na radu


        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_4', 'B_5');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_4', 'B_5');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Work Violation Note" <> '' THEN
                    Personaltrack2."Work Violation Note" := Personaltrack2."Work Violation Note" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Work Violation Note" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Work Violation Note" <> '' THEN
            Personaltrack2."Work Violation Note" := COPYSTR(Personaltrack2."Work Violation Note", 1, STRLEN(Personaltrack2."Work Violation Note") - 1);




        //invalidnost
        Personaltrack2."Employee Disability" := 'Ne';

        //Decrease Inability
        //Smanjenje radne sposobnosti uz preostalu radnu sposobnost

        EmployeeLevelOfDisability.RESET;
        EmployeeLevelOfDisability.SETFILTER("Employee No.", '%1', NewAdditionalE."Employee No.");
        IF NewAdditionalE."From Date" = 0D THEN
            EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', NewAdditionalE."Insert Date")
        ELSE
            EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', NewAdditionalE."From Date");
        EmployeeLevelOfDisability.SETCURRENTKEY("Date From");
        EmployeeLevelOfDisability.ASCENDING;
        IF EmployeeLevelOfDisability.FINDLAST THEN BEGIN
            Personaltrack2."Decrease Inability" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Employee Disability" := 'Da';

            Personaltrack2."Partial decrease Inability" := EmployeeLevelOfDisability."Level of Disability";
            Personaltrack2."Risk of impairment" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Level of partial disability" := EmployeeLevelOfDisability."Level of Disability";
        END
        ELSE BEGIN
            Personaltrack2."Decrease Inability" := '';
            Personaltrack2."Employee Disability" := 'Ne';
            Personaltrack2."Partial decrease Inability" := '';
            Personaltrack2."Risk of impairment" := '';
            Personaltrack2."Level of partial disability" := '';
        END;
        IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
            Personaltrack2."Employee type" := 1
        ELSE
            Personaltrack2."Employee type" := 2;

        //Personaltrack2.INSERT;


        CompInf.GET;
        PersonalTrack."Employee activity" := CompInf."Industrial Classification";

        // PersonalTrack.INSERT;
    end;

    procedure PersonalDocument2(OldPersonalD: Record "Personal Documents"; NewPersonalD: Record "Personal Documents"; CodePersonal: Code[10])
    begin


        PersonalTrack.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Code Personal", '%1', OldPersonalD.Code);
        PersonalTrack.SETFILTER("Code Additional", '%1', 0);
        PersonalTrack.SETFILTER("Code Addr", '%1', 0);
        PersonalTrack.SETFILTER("Contract No", '%1', 0);

        IF PersonalTrack.FINDSET THEN
            REPEAT
                IF (NewPersonalD.Code <> '') THEN
                    PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;
        PersonalTrack.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Code Additional", '%1', 0);
        PersonalTrack.SETFILTER("Code Addr", '%1', 0);
        PersonalTrack.SETFILTER("Code Personal", '%1', '');
        IF PersonalTrack.FINDSET THEN
            REPEAT
                PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;


        PersonalTrack.INIT;
        PersonalTrack."Date of change" := TODAY;
        PersonalTrack."Indication for work experience" := FALSE;
        PersonalTrack."Indication of capability" := FALSE;
        PersonalTrack."Code Personal" := CodePersonal;
        Employee.RESET;
        Employee.SETFILTER("No.", '%1', NewPersonalD."Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            PersonalTrack.JMBG := Employee."Employee ID";
            IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
                PersonalTrack."Employee type" := 1
            ELSE
                PersonalTrack."Employee type" := 2;
            PersonalTrack."Working Hours Day" := Employee."Hours In Day";
            PersonalTrack."Working Hours Week" := Employee."Hours In Day" * 5;
            PersonalTrack."Work Experience Year" := Employee."Brought Years Total";
            PersonalTrack."Work Experience Month" := Employee."Brought Months Total";
            PersonalTrack."Work Experience Day" := Employee."Brought Days Total";
            PersonalTrack."Proffesional Exam Date" := Employee."Professional Examination Date";
            PersonalTrack."Proffesional Exam Result" := FORMAT(Employee."Professional Exam. Result");
            HRCL.SETFILTER("No.", '%1', NewPersonalD."Employee No.");
            HRCL.SETFILTER(Comment, '%1', 'Certifikat');
            IF HRCL.FINDFIRST THEN BEGIN
                //Employee Qualification tabela
                Qualifications.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
                Qualifications.SETFILTER("Line No.", '%1', HRCL."Table Line No.");
                IF Qualifications.FINDFIRST THEN
                    PersonalTrack.Certificate := Qualifications.Description
                ELSE
                    PersonalTrack.Certificate := '';
            END;

            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
            IF NewPersonalD."Date From" = 0D THEN
                WorkBooklet.SETFILTER("Starting Date", '<=%1', TODAY)
            ELSE
                WorkBooklet.SETFILTER("Starting Date", '<=%1', NewPersonalD."Date From");
            WorkBooklet.SETCURRENTKEY("Starting Date");
            WorkBooklet.ASCENDING;
            IF WorkBooklet.FINDLAST THEN
                PersonalTrack."Employment Date" := WorkBooklet."Starting Date";


            Qualification.RESET;
            Qualification.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
            IF NewPersonalD."Date From" = 0D THEN
                Qualification.SETFILTER("From Date", '<=%1', TODAY)
            ELSE
                Qualification.SETFILTER("From Date", '<=%1', NewPersonalD."Date From");

            IF Qualification.FINDSET THEN
                REPEAT
                    Qua.RESET;
                    Qua.SETFILTER(Code, '%1', Qualification."Qualification Code");
                    IF Qua.FINDFIRST THEN BEGIN
                        PersonalTrack."Proffessional Exam" := PersonalTrack."Proffessional Exam" + ' ;' + Qualification.Description;
                    END
                    ELSE BEGIN
                        PersonalTrack."Proffessional Exam" := '';
                    END;
                UNTIL Qualification.NEXT = 0;


            PersonalTrack."Line No." := Employee."Internal ID";
            PersonalTrack."Employee No." := NewPersonalD."Employee No.";
            PersonalTrack."First Name" := Employee."First Name";
            PersonalTrack."Last Name" := Employee."Last Name";

            PersonalTrack.Gender := Employee.Gender;
            PersonalTrack."Birth Date" := Employee."Birth Date";
            PersonalTrack."Birth City" := Employee."Birth City";
            PersonalTrack."Place of birth" := Employee."Place of birth";
            CountryCode.RESET;
            CountryCode.SETFILTER(Code, '%1', Employee."Country/Region Code of Birth");
            IF CountryCode.FINDFIRST THEN
                PersonalTrack."Birth State" := CountryCode.Name
            ELSE
                PersonalTrack."Birth State" := '';

            MunicipalityCode.RESET;
            MunicipalityCode.SETFILTER(Code, '%1', Employee."Municipality Code of Birth");
            MunicipalityCode.SETFILTER("Country/Region Code", '%1', Employee."Country/Region Code of Birth");
            MunicipalityCode.SetFilter(type, '%1', MunicipalityCode.Type::Regular);
            IF MunicipalityCode.FINDFIRST THEN
                PersonalTrack."Birth Municipality" := MunicipalityCode.Name
            ELSE
                PersonalTrack."Birth Municipality" := '';


            IF NewPersonalD.Switch = NewPersonalD.Switch::Citizenship THEN BEGIN
                PersonalTrack.Citizenship := NewPersonalD."Citizenship Description";
            END
            ELSE BEGIN

                PersonalDocument.RESET;
                PersonalDocument.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
                PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::Citizenship);
                IF NewPersonalD."Date From" = 0D THEN
                    PersonalDocument.SETFILTER("Date From", '<=%1', TODAY)
                ELSE
                    PersonalDocument.SETFILTER("Date From", '<=%1', NewPersonalD."Date From");
                PersonalDocument.SETCURRENTKEY("Date From");
                PersonalDocument.ASCENDING;
                IF PersonalDocument.FINDLAST THEN
                    PersonalTrack.Citizenship := PersonalDocument."Citizenship Description";

            END;


            AdditionalEducation.RESET;
            AdditionalEducation.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
            IF NewPersonalD."Date From" = 0D THEN
                AdditionalEducation.SETFILTER("From Date", '<=%1', TODAY)
            ELSE
                AdditionalEducation.SETFILTER("From Date", '<=%1', NewPersonalD."Date From");
            AdditionalEducation.SETCURRENTKEY("From Date");
            AdditionalEducation.ASCENDING;
            IF AdditionalEducation.FINDLAST THEN BEGIN
                PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level");
                PersonalTrack."Additional Education" := AdditionalEducation."School of Graduation";
                PersonalTrack."Title Description" := AdditionalEducation."Title Description";
            END;

            PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level");
            PersonalTrack."Additional Education" := AdditionalEducation."School of Graduation";
            PersonalTrack."Title Description" := AdditionalEducation."Title Description";

            IF NewPersonalD.Switch = NewPersonalD.Switch::"Work Permit" THEN BEGIN
                PersonalTrack."Work Permit Code" := NewPersonalD."Work Permit";
                PersonalTrack."Work Permit Type" := FORMAT(NewPersonalD."Type Of Work Permit");
                PersonalTrack."Work Permit To" := NewPersonalD."Date To";
                PersonalTrack."Work Permit From" := NewPersonalD."Date From";
            END
            ELSE BEGIN
                PersonalDocument.RESET;
                PersonalDocument.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
                PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Work Permit");
                IF NewPersonalD."Date From" = 0D THEN
                    PersonalDocument.SETFILTER("Date From", '<=%1', TODAY)
                ELSE
                    PersonalDocument.SETFILTER("Date From", '<=%1', NewPersonalD."Date From");
                PersonalDocument.SETCURRENTKEY("Date From");
                PersonalDocument.ASCENDING;
                IF PersonalDocument.FINDLAST THEN BEGIN
                    PersonalTrack."Work Permit Code" := PersonalDocument."Work Permit";
                    PersonalTrack."Work Permit Type" := FORMAT(PersonalDocument."Type Of Work Permit");
                    PersonalTrack."Work Permit To" := PersonalDocument."Date To";
                    PersonalTrack."Work Permit From" := PersonalDocument."Date From";
                END
                ELSE BEGIN
                    PersonalTrack."Work Permit Code" := '';
                    PersonalTrack."Work Permit Type" := '';
                    PersonalTrack."Work Permit To" := 0D;
                    PersonalTrack."Work Permit From" := 0D;
                END;



            END;






            IF NewPersonalD.Switch = NewPersonalD.Switch::"Residence Permit" THEN BEGIN
                PersonalTrack."Residence Permit Code" := NewPersonalD."Residence Permit";
                //PersonalTrack."Work Permit Type":=FORMAT(NewPersonalD."Type Of Work Permit");
                PersonalTrack."Residence Permit From" := NewPersonalD."Date From";
                PersonalTrack."Residence Permit To" := NewPersonalD."Date To";
            END
            ELSE BEGIN
                PersonalDocument.RESET;
                PersonalDocument.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
                PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Residence Permit");
                IF NewPersonalD."Date From" = 0D THEN
                    PersonalDocument.SETFILTER("Date From", '<=%1', TODAY)
                ELSE
                    PersonalDocument.SETFILTER("Date From", '<=%1', NewPersonalD."Date From");
                PersonalDocument.SETCURRENTKEY("Date From");
                PersonalDocument.ASCENDING;
                IF PersonalDocument.FINDLAST THEN BEGIN
                    PersonalTrack."Residence Permit Code" := PersonalDocument."Residence Permit";
                    //PersonalTrack."Work Permit Type":=FORMAT(PersonalDocument."Type Of Work Permit");
                    PersonalTrack."Residence Permit To" := PersonalDocument."Date To";
                    PersonalTrack."Residence Permit From" := PersonalDocument."Date From";
                END
                ELSE BEGIN
                    PersonalTrack."Residence Permit Code" := '';
                    //PersonalTrack."Work Permit Type":='';
                    PersonalTrack."Residence Permit To" := 0D;
                    PersonalTrack."Residence Permit From" := 0D;
                END;



            END;










            AlternativeAddress.RESET;
            AlternativeAddress.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
            IF NewPersonalD."Date From" = 0D THEN
                AlternativeAddress.SETFILTER("Date From (CIPS)", '<=%1', TODAY)
            ELSE
                AlternativeAddress.SETFILTER("Date From (CIPS)", '<=%1', NewPersonalD."Date From");
            AlternativeAddress.SETCURRENTKEY("Date From (CIPS)");
            AlternativeAddress.ASCENDING;
            IF AlternativeAddress.FINDLAST THEN BEGIN
                PersonalTrack."Address CIPS" := AlternativeAddress."Address CIPS";
                PersonalTrack."City CIPS" := AlternativeAddress."City CIPS";
                PersonalTrack."Municipality CIPS" := AlternativeAddress."Municipality Name CIPS";
                PersonalTrack."Entity CIPS" := AlternativeAddress."Entity Code CIPS";

                PersonalTrack."Address Real" := AlternativeAddress.Address;
                PersonalTrack."City Real" := AlternativeAddress.City;
                PersonalTrack."Municipality Real" := AlternativeAddress."Municipality Name";
                PersonalTrack."Entity Real" := AlternativeAddress."Entity Code";
            END;

        END;


        Personaltrack2.RESET;
        Personaltrack2.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        Personaltrack2.SETFILTER("Date of change", '%1', TODAY);
        Personaltrack2.SETFILTER("Code Personal", '%1', NewPersonalD.Code);
        IF Personaltrack2.FINDFIRST THEN
            Personaltrack2.DELETE;

        Personaltrack2.RESET;
        Personaltrack2.INIT;
        Personaltrack2."Date of change" := TODAY;
        Personaltrack2."Line No." := Employee."Internal ID";
        Personaltrack2."Code Personal" := NewPersonalD.Code;
        Personaltrack2."Code Additional" := 0;
        Personaltrack2."Code Addr" := 0;
        Personaltrack2."Employee No." := Employee."No.";
        Personaltrack2."First Name" := Employee."First Name";
        Personaltrack2."Last Name" := Employee."Last Name";

        //čuvanje trudnoće

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_6', 'B_7');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_6', 'B_7');
        IF Bom.FINDSET THEN
            REPEAT

                IF Personaltrack2."Pregnancy Keeping From" <> '' THEN
                    Personaltrack2."Pregnancy Keeping From" := Personaltrack2."Pregnancy Keeping From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Keeping From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;







        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        // majčinstvo
        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Pregnancy Leave From" <> '' THEN
                    Personaltrack2."Pregnancy Leave From" := Personaltrack2."Pregnancy Leave From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Leave From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Pregnancy Leave From" <> '' THEN
            Personaltrack2."Pregnancy Leave From" := COPYSTR(Personaltrack2."Pregnancy Leave From", 1, STRLEN(Personaltrack2."Pregnancy Leave From") - 1);


        //povreda na radu


        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_4', 'B_5');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_4', 'B_5');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Work Violation Note" <> '' THEN
                    Personaltrack2."Work Violation Note" := Personaltrack2."Work Violation Note" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Work Violation Note" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");

            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Work Violation Note" <> '' THEN
            Personaltrack2."Work Violation Note" := COPYSTR(Personaltrack2."Work Violation Note", 1, STRLEN(Personaltrack2."Work Violation Note") - 1);




        //invalidnost
        Personaltrack2."Employee Disability" := 'Ne';

        //Decrease Inability
        //Smanjenje radne sposobnosti uz preostalu radnu sposobnost

        EmployeeLevelOfDisability.RESET;
        EmployeeLevelOfDisability.SETFILTER("Employee No.", '%1', NewPersonalD."Employee No.");
        IF NewPersonalD."Date From" = 0D THEN
            EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', NewPersonalD."Date From")
        ELSE
            EmployeeLevelOfDisability.SETFILTER("Date From", '<=%1', NewPersonalD."Date From");
        EmployeeLevelOfDisability.SETCURRENTKEY("Date From");
        EmployeeLevelOfDisability.ASCENDING;
        IF EmployeeLevelOfDisability.FINDLAST THEN BEGIN
            Personaltrack2."Decrease Inability" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Employee Disability" := 'Da';

            Personaltrack2."Partial decrease Inability" := EmployeeLevelOfDisability."Level of Disability";
            Personaltrack2."Risk of impairment" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Level of partial disability" := EmployeeLevelOfDisability."Level of Disability";
        END
        ELSE BEGIN
            Personaltrack2."Decrease Inability" := '';
            Personaltrack2."Employee Disability" := 'Ne';
            Personaltrack2."Partial decrease Inability" := '';
            Personaltrack2."Risk of impairment" := '';
            Personaltrack2."Level of partial disability" := '';
        END;

        IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
            Personaltrack2."Employee type" := 1
        ELSE
            Personaltrack2."Employee type" := 2;
        //  Personaltrack2.INSERT;

        CompInf.GET;
        PersonalTrack."Employee activity" := CompInf."Industrial Classification";
        //  PersonalTrack.INSERT;
    end;

    procedure EmployeeContractLedger2(OldECL: Record "Employee Contract Ledger"; NewECL: Record "Employee Contract Ledger")
    begin




        PersonalTrack.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Contract No", '%1', OldECL."No.");

        IF PersonalTrack.FINDSET THEN
            REPEAT
                PersonalTrack.DELETE;
            UNTIL PersonalTrack.NEXT = 0;



        PersonalTrack.INIT;
        PersonalTrack."Date of change" := TODAY;
        PersonalTrack."Indication for work experience" := FALSE;
        PersonalTrack."Indication of capability" := FALSE;
        Employee.RESET;
        Employee.SETFILTER("No.", '%1', NewECL."Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            PersonalTrack.JMBG := Employee."Employee ID";
            IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
                PersonalTrack."Employee type" := 1
            ELSE
                PersonalTrack."Employee type" := 2;
            PersonalTrack."Working Hours Day" := Employee."Hours In Day";
            PersonalTrack."Working Hours Week" := Employee."Hours In Day" * 5;
            PersonalTrack."Work Experience Year" := Employee."Brought Years Total";
            PersonalTrack."Work Experience Month" := Employee."Brought Months Total";
            PersonalTrack."Work Experience Day" := Employee."Brought Days Total";
            PersonalTrack."Proffesional Exam Date" := Employee."Professional Examination Date";
            PersonalTrack."Proffesional Exam Result" := FORMAT(Employee."Professional Exam. Result");
            AlternativeAddress.RESET;
            AlternativeAddress.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            AlternativeAddress.SETFILTER("Date From (CIPS)", '<=%1', NewECL."Starting Date");


            AlternativeAddress.SETCURRENTKEY("Date From (CIPS)");
            AlternativeAddress.ASCENDING;
            IF AlternativeAddress.FINDLAST THEN BEGIN
                PersonalTrack."Address CIPS" := AlternativeAddress."Address CIPS";
                PersonalTrack."City CIPS" := AlternativeAddress."City CIPS";
                PersonalTrack."Municipality CIPS" := AlternativeAddress."Municipality Name CIPS";
                PersonalTrack."Entity CIPS" := AlternativeAddress."Entity Code CIPS";
                PersonalTrack."Address Real" := AlternativeAddress.Address;
                PersonalTrack."City Real" := AlternativeAddress.City;
                PersonalTrack."Municipality Real" := AlternativeAddress."Municipality Name";
                PersonalTrack."Entity Real" := AlternativeAddress."Entity Code";

            END;


            HRCL.SETFILTER("No.", '%1', NewECL."Employee No.");
            HRCL.SETFILTER(Comment, '%1', 'Certifikat');
            IF HRCL.FINDFIRST THEN BEGIN
                //Employee Qualification tabela
                Qualifications.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
                Qualifications.SETFILTER("Line No.", '%1', HRCL."Table Line No.");
                IF Qualifications.FINDFIRST THEN
                    PersonalTrack.Certificate := Qualifications.Description
                ELSE
                    PersonalTrack.Certificate := '';
            END;

            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
            WorkBooklet.SETFILTER("Starting Date", '<=%1', NewECL."Starting Date");
            WorkBooklet.SETCURRENTKEY("Starting Date");
            WorkBooklet.ASCENDING;
            IF WorkBooklet.FINDLAST THEN
                PersonalTrack."Employment Date" := WorkBooklet."Starting Date";


            Qualification.RESET;
            Qualification.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            Qualification.SETFILTER("From Date", '<=%1', NewECL."Starting Date");

            IF Qualification.FINDSET THEN
                REPEAT
                    Qua.RESET;
                    Qua.SETFILTER(Code, '%1', Qualification."Qualification Code");
                    IF Qua.FINDFIRST THEN BEGIN
                        PersonalTrack."Proffessional Exam" := PersonalTrack."Proffessional Exam" + ' ;' + Qualification.Description;
                    END
                    ELSE BEGIN
                        PersonalTrack."Proffessional Exam" := '';
                    END;
                UNTIL Qualification.NEXT = 0;


            PersonalTrack."Line No." := Employee."Internal ID";
            PersonalTrack."Employee No." := NewECL."Employee No.";
            PersonalTrack."First Name" := Employee."First Name";
            PersonalTrack."Last Name" := Employee."Last Name";


            PersonalTrack."Contract No" := NewECL."No.";
            NewECL.CALCFIELDS("Org Municipality of ag");

            MunicipalityCode.RESET;
            MunicipalityCode.SETFILTER(Code, '%1', NewECL."Org Municipality of ag");
            //MunicipalityCode.SETFILTER("Country/Region Code",'%1',Employee."Country/Region Code of Birth");
            IF MunicipalityCode.FINDFIRST THEN BEGIN
                PersonalTrack."Municipality Working" := MunicipalityCode.Name;

                CountryCode.RESET;
                CountryCode.SETFILTER(Code, '%1', MunicipalityCode."Country/Region Code");
                IF CountryCode.FINDFIRST THEN
                    PersonalTrack."Working State" := CountryCode.Name
                ELSE
                    PersonalTrack."Working State" := '';


            END
            ELSE BEGIN
                PersonalTrack."Municipality Working" := '';
                PersonalTrack."Working State" := '';
            END;



            PersonalTrack."Position Name" := NewECL."Position Description";
            PersonalTrack."Starting Date Contract" := NewECL."Starting Date";
            PersonalTrack."Probation From" := NewECL."Testing Period Starting Date";
            PersonalTrack."Probation To" := NewECL."Testing Period Ending Date";
            IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
                PersonalTrack."Employee type" := 1
            ELSE
                PersonalTrack."Employee type" := 2;

            NewECL.CALCFIELDS(Municipality);

            PersonalTrack."Contract type" := NewECL."Contract Type";
            PersonalTrack."Termination Reason" := NewECL."Grounds for Term. Description";
            PersonalTrack."Working Place" := NewECL."Phisical Department Desc";




            PersonalTrack."Another place of work" := NewECL."Additional Responsiblity";
            PersonalTrack."Employee Contract o." := NewECL."Number of protocol for documen";
            PersonalTrack."Position Code" := NewECL."Position Code";
            PersonalTrack."Org Shema" := NewECL."Org. Structure";


            //Pripravnik
            IF NewECL.Prentice = TRUE THEN BEGIN
                PersonalTrack."Prentice Contract No." := NewECL."Number of protocol for documen";

                PersonalTrack."Prentice Contract From" := NewECL."Starting Date";
                PersonalTrack."Prentice Contract To" := NewECL."Ending Date";
            END
            ELSE BEGIN
                PersonalTrack."Prentice Contract No." := '';
                PersonalTrack."Prentice Contract From" := 0D;
                PersonalTrack."Prentice Contract To" := 0D;
            END;





            IF NewECL."Grounds for Term. Description" <> '' THEN
                PersonalTrack."Termination Date" := NewECL."Ending Date";
            IF (NewECL."Contract Type Name" = 'ODREĐENO') OR (NewECL."Contract Type Name" = 'ODREĐENO PROBNI') THEN BEGIN
                PersonalTrack."Definitely Contract From" := NewECL."Starting Date";
                PersonalTrack."Definitely Contract To" := NewECL."Ending Date";
            END;
            IF NewECL."Contract Type Name" = 'MIROVANJE' THEN BEGIN
                PersonalTrack."Inaction From" := NewECL."Starting Date";
                PersonalTrack."Inaction to" := NewECL."Ending Date";
            END;

            IF NewECL."Employment Abroad" = TRUE THEN BEGIN
                PersonalTrack."Abroad From" := NewECL."Starting Date";
                PersonalTrack."Abroad To" := NewECL."Ending Date";
                PersonalTrack."Abroad City" := NewECL."Employment Abroad City";


                CountryCode.RESET;
                CountryCode.SETFILTER(Code, '%1', NewECL."Empl.Abroad Country/Region");
                IF CountryCode.FINDFIRST THEN
                    PersonalTrack."Abroad State" := CountryCode.Name;

            END;



            PersonalTrack.Gender := Employee.Gender;
            PersonalTrack."Birth Date" := Employee."Birth Date";
            PersonalTrack."Birth City" := Employee."Birth City";
            PersonalTrack."Place of birth" := Employee."Place of birth";


            CountryCode.RESET;
            CountryCode.SETFILTER(Code, '%1', Employee."Country/Region Code of Birth");
            IF CountryCode.FINDFIRST THEN
                PersonalTrack."Birth State" := CountryCode.Name;
            MunicipalityCode.RESET;
            MunicipalityCode.SETFILTER(Code, '%1', Employee."Municipality Code of Birth");
            MunicipalityCode.SETFILTER("Country/Region Code", '%1', Employee."Country/Region Code of Birth");
            MunicipalityCode.SetFilter(type, '%1', MunicipalityCode.Type::Regular);
            IF MunicipalityCode.FINDFIRST THEN
                PersonalTrack."Birth Municipality" := MunicipalityCode.Name;


            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::Citizenship);
            PersonalDocument.SETFILTER("Date From", '<=%1', NewECL."Starting Date");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN
                PersonalTrack.Citizenship := PersonalDocument."Citizenship Description";

            AdditionalEducation.RESET;
            AdditionalEducation.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            AdditionalEducation.SETFILTER("From Date", '<=%1', NewECL."Starting Date");
            AdditionalEducation.SETCURRENTKEY("From Date");
            AdditionalEducation.ASCENDING;
            IF AdditionalEducation.FINDLAST THEN BEGIN
                PersonalTrack."Education Level" := FORMAT(AdditionalEducation."Education Level");
                PersonalTrack."Additional Education" := AdditionalEducation."School of Graduation";
                PersonalTrack."Title Description" := AdditionalEducation."Title Description";
                // PersonalTrack."Code Additional":=AdditionalEducation."Entry No.";
            END;

            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Work Permit");
            PersonalDocument.SETFILTER("Date From", '<=%1', NewECL."Starting Date");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Work Permit Code" := PersonalDocument."Work Permit";
                PersonalTrack."Work Permit Type" := FORMAT(PersonalDocument."Type Of Work Permit");
                PersonalTrack."Work Permit To" := PersonalDocument."Date To";
                PersonalTrack."Work Permit From" := PersonalDocument."Date From";
            END
            ELSE BEGIN
                PersonalTrack."Work Permit Code" := '';
                PersonalTrack."Work Permit Type" := '';
                PersonalTrack."Work Permit To" := 0D;
                PersonalTrack."Work Permit From" := 0D;
            END;

            PersonalDocument.RESET;
            PersonalDocument.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
            PersonalDocument.SETFILTER(Switch, '%1', PersonalDocument.Switch::"Residence Permit");
            PersonalDocument.SETFILTER("Date From", '<=%1', NewECL."Starting Date");
            PersonalDocument.SETCURRENTKEY("Date From");
            PersonalDocument.ASCENDING;
            IF PersonalDocument.FINDLAST THEN BEGIN
                PersonalTrack."Residence Permit Code" := PersonalDocument."Residence Permit";
                PersonalTrack."Residence Permit To" := PersonalDocument."Date To";
                PersonalTrack."Residence Permit From" := PersonalDocument."Date From";
            END
            ELSE BEGIN
                PersonalTrack."Residence Permit Code" := '';
                PersonalTrack."Residence Permit To" := 0D;
                PersonalTrack."Residence Permit From" := 0D;
            END;



        END;


        Personaltrack2.RESET;
        Personaltrack2.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        Personaltrack2.SETFILTER("Date of change", '%1', TODAY);
        Personaltrack2.SETFILTER("Contract No", '%1', NewECL."No.");
        IF Personaltrack2.FINDFIRST THEN
            Personaltrack2.DELETE;

        Personaltrack2.RESET;
        Personaltrack2.INIT;
        Personaltrack2."Date of change" := TODAY;
        Personaltrack2."Line No." := Employee."Internal ID";
        Personaltrack2."Contract No" := NewECL."No.";
        Personaltrack2."Code Additional" := 0;
        Personaltrack2."Code Addr" := 0;
        Personaltrack2."Code Personal" := '';
        Personaltrack2."Employee No." := Employee."No.";
        Personaltrack2."First Name" := Employee."First Name";
        Personaltrack2."Last Name" := Employee."Last Name";

        //čuvanje trudnoće

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_6', 'B_7');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_6', 'B_7');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Pregnancy Keeping From" <> '' THEN
                    Personaltrack2."Pregnancy Keeping From" := Personaltrack2."Pregnancy Keeping From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Keeping From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;







        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        // majčinstvo
        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;







            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2|%3|%4|%5', 'B_10', 'B_11', 'B_12', 'B_13', 'B_14');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Pregnancy Leave From" <> '' THEN
                    Personaltrack2."Pregnancy Leave From" := Personaltrack2."Pregnancy Leave From" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Pregnancy Leave From" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Pregnancy Leave From" <> '' THEN
            Personaltrack2."Pregnancy Leave From" := COPYSTR(Personaltrack2."Pregnancy Leave From", 1, STRLEN(Personaltrack2."Pregnancy Leave From") - 1);


        //povreda na radu


        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        IF Bom.FINDSET THEN
            REPEAT
                Bom.DELETE;
            UNTIL Bom.NEXT = 0;

        CauseofAbsence.RESET;
        CauseofAbsence.SETFILTER(Code, '%1|%2', 'B_4', 'B_5');
        IF CauseofAbsence.FINDSET THEN
            REPEAT
                VocCount := 1;
                WorkDays := 1;
                LineNo := 1;
                counter2 := 0;
                ea.RESET;
                EA1.RESET;
                ea.SETFILTER("Cause of Absence Code", '%1', CauseofAbsence.Code);
                ea.SETFILTER("Employee No.", '%1', Employee."No.");

                ea.SETCURRENTKEY("Employee No.", "From Date");
                ea.ASCENDING;
                IF ea.FINDFIRST THEN
                    REPEAT
                        Counter := 0;
                        IF (counter2 = 0) THEN
                            StartDateFinal := ea."From Date";
                        counter2 := counter2 + 1;
                        StartDate := ea."From Date";
                        wd := DATE2DWY(StartDate, 1);
                        TotalDays := WorkDays + ((WorkDays + wd - 1) DIV 5) * 2;
                        IF (wd > 5) THEN
                            TotalDays -= (wd - 5);
                        EA1 := ea;
                        EA1.COPYFILTERS(ea);
                        EA1.SETCURRENTKEY("Employee No.", "From Date");
                        EA1.ASCENDING;
                        EA1.NEXT(1);
                        EndDate := EA1."To Date";
                        EndDateFinal := ea."From Date";
                        IF (EndDate = StartDate + TotalDays) THEN
                            IF
                            ((COPYSTR(ea."Cause of Absence Code Corr.", 1, 1) = 'Z'))
                             THEN
                                Counter += 1
                            ELSE
                                VocCount += 1
                        ELSE BEGIN

                            IF ((VocCount >= 1) AND (Counter = 0)) THEN BEGIN
                                counter2 := 0;

                                Bom.INIT;
                                Bom.Order := LineNo;
                                Bom."Employee No." := EA1."Employee No.";
                                Bom."Years of Experience in Company" := VocCount;
                                Bom."Starting Date" := StartDateFinal;
                                Bom."Search Name" := EA1."Cause of Absence Code";
                                Bom."Ending Date" := EndDateFinal;
                                Bom.INSERT;
                                LineNo += 1;
                            END;
                            VocCount := 1;
                        END;

                    UNTIL (ea.NEXT = 0);

                VocCount := 1;






            UNTIL CauseofAbsence.NEXT = 0;
        Bom.RESET;
        Bom.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        Bom.SETFILTER("Search Name", '%1|%2', 'B_4', 'B_5');
        IF Bom.FINDSET THEN
            REPEAT
                IF Personaltrack2."Work Violation Note" <> '' THEN
                    Personaltrack2."Work Violation Note" := Personaltrack2."Work Violation Note" + '/' + FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date")
                ELSE
                    Personaltrack2."Work Violation Note" := FORMAT(Bom."Starting Date") + '-' + FORMAT(Bom."Ending Date");
            UNTIL Bom.NEXT = 0;

        IF Personaltrack2."Work Violation Note" <> '' THEN
            Personaltrack2."Work Violation Note" := COPYSTR(Personaltrack2."Work Violation Note", 1, STRLEN(Personaltrack2."Work Violation Note") - 1);




        //invalidnost
        Personaltrack2."Employee Disability" := 'Ne';

        //Decrease Inability
        //Smanjenje radne sposobnosti uz preostalu radnu sposobnost

        EmployeeLevelOfDisability.RESET;
        EmployeeLevelOfDisability.SETFILTER("Employee No.", '%1', NewECL."Employee No.");
        EmployeeLevelOfDisability.SETFILTER(Active, '%1', TRUE);

        EmployeeLevelOfDisability.SETCURRENTKEY("Date From");
        EmployeeLevelOfDisability.ASCENDING;
        IF EmployeeLevelOfDisability.FINDLAST THEN BEGIN
            Personaltrack2."Decrease Inability" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Employee Disability" := 'Da';

            Personaltrack2."Partial decrease Inability" := EmployeeLevelOfDisability."Level of Disability";
            Personaltrack2."Risk of impairment" := EmployeeLevelOfDisability.Description;
            Personaltrack2."Level of partial disability" := EmployeeLevelOfDisability."Level of Disability";
        END
        ELSE BEGIN
            Personaltrack2."Decrease Inability" := '';
            Personaltrack2."Employee Disability" := 'Ne';
            Personaltrack2."Partial decrease Inability" := '';
            Personaltrack2."Risk of impairment" := '';
            Personaltrack2."Level of partial disability" := '';
        END;
        IF Employee."External employer Status" = Employee."External employer Status"::" " THEN
            Personaltrack2."Employee type" := 1
        ELSE
            Personaltrack2."Employee type" := 2;

        //        Personaltrack2.INSERT;


        //prebivalište
        PersonalTrack."Address CIPS" := Employee."Address CIPS";
        PersonalTrack."City CIPS" := Employee."City CIPS";
        PersonalTrack."Municipality CIPS" := Employee."Municipality Name CIPS";
        PersonalTrack."Entity CIPS" := Employee."Entity Code CIPS";


        //boravište
        PersonalTrack."Address Real" := Employee.Address;
        PersonalTrack."City Real" := Employee.City;
        PersonalTrack."Municipality Real" := Employee."Municipality Name";
        PersonalTrack."Entity Real" := Employee."Entity Code";
        CompInf.GET;
        PersonalTrack."Employee activity" := CompInf."Industrial Classification";
        IF NewECL."No." <> 0 THEN BEGIN
            IF NewECL."Attachment No." = 0 THEN BEGIN
                PersonalTrack."Starting Date Contract" := 0D;

            END;

            //ĐK JOŠ NE     PersonalTrack.INSERT;

        END;

    end;
}
*/