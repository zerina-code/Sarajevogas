/*report 50205 "Personal track"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Personal track.rdlc';
    Caption = 'Personal track';
    EnableHyperlinks = true;
    PreviewMode = Normal;

    dataset
    {
        dataitem(DataItem10; "Personal track report")
        {
            UseTemporary = true;
            column(EmployeeNo; Pers."Employee No.")
            {
            }
            column(FirstName; FirstName)
            {
            }
            column(Evidencija; Evidencija)
            {
            }
            column(JMBG; JMBG)
            {
            }
            column(Gender; GenderText)
            {
            }
            column(LastName; LastName)
            {
            }
            column(BirthDate; BirthDate)
            {
            }
            column(BirthCity; BirthCity)
            {
            }
            column(BirthMunicipality; BirthMunicipality)
            {
            }
            column(BirthState; BirthState)
            {
            }
            column(CityCIPS; CityCIPS)
            {
            }
            column(AddressCIPS; AddressCIPS)
            {
            }
            column(MunicipalityCIPS; MunicipalityCIPS)
            {
            }
            column(EntitetCIPS; EntitetCIPS)
            {
            }
            column(Citizenship; Citizenship)
            {
            }
            column(WorkPermitCode; WorkPermitCode)
            {
            }
            column(WorkPermitType; WorkPermitType)
            {
            }
            column(WorkPermitFrom; WorkPermitFrom)
            {
            }
            column(WorkPermitTo; WorkPermitTo)
            {
            }
            column(ResidenceCode; ResidenceCode)
            {
            }
            column(ResidenceFrom; ResidenceFrom)
            {
            }
            column(ResidenceTo; ResidenceTo)
            {
            }
            column(EducationLevel; EducationLevel)
            {
            }
            column(ProffesionalExam; ProffesionalExam)
            {
            }
            column(AdditionalEducation; AdditionalEducation)
            {
            }
            column(TitleDesc; TitleDesc)
            {
            }
            column(ExtractAdditional; ExtractAdditional)
            {
            }
            column(Certificate; Certificate)
            {
            }
            column(BrojUgovora; BrojUgovora)
            {
            }
            column(DatumZakljucenjaUgovora; DatumZakljucenjaUgovora)
            {
            }
            column(DatumZaposlenja; DatumZaposlenja)
            {
            }
            column(PositionName; PositionName)
            {
            }
            column(WorkingPlace; WorkingPlace)
            {
            }
            column(ContractType; ContractType)
            {
            }
            column(ContractFrom; ContractFrom)
            {
            }
            column(ContractTo; ContractTO)
            {
            }
            column(ProbationFrom; ProbationFrom)
            {
            }
            column(ProbationTo; ProbationTo)
            {
            }
            column(PrenticeContractNo; PrenticeContractNo)
            {
            }
            column(PrenticeContractFrom; PrenticeContractFrom)
            {
            }
            column(PrenticeContractTo; PrenticeContractTo)
            {
            }
            column(ProffExamDate; ProffExamDate)
            {
            }
            column(ProffExamResult; ProffExamResult)
            {
            }
            column(AbroadFrom; AbroadFrom)
            {
            }
            column(AbroadTo; AbroadTo)
            {
            }
            column(AbroadCity; AbroadCity)
            {
            }
            column(AbroadState; AbroadState)
            {
            }
            column(WorkinHoursWeek; WorkinHoursWeek)
            {
            }
            column(WorkingHoursDay; WorkingHoursDay)
            {
            }
            column(Indication2; Indication2)
            {
            }
            column(Indication1; Indication1)
            {
            }
            column(AnotherPlace; AnotherPlace)
            {
            }
            column(WorkExperienceYear; WorkExperienceYear)
            {
            }
            column(WorkExperienceMonth; WorkExperienceMonth)
            {
            }
            column(WorkExperienceDay; WorkExperienceDay)
            {
            }
            column(RetYear; RetYear)
            {
            }
            column(RetMonth; RetMonth)
            {
            }
            column(RetDay; RetDay)
            {
            }
            column(InactionTO; InactionTO)
            {
            }
            column(InactionFrom; InactionFrom)
            {
            }
            column(TerminationDate; TerminationDate)
            {
            }
            column(TerminationReason; TerminationReason)
            {
            }
            column(PregnancyKeepingFrom; PregnancyKeepingFrom)
            {
            }
            column(PregnancyLeaveFrom; PregnancyLeaveFrom)
            {
            }
            column(LineNo_Personaltrackreport; DataItem10."Line No.")
            {
            }
            column(BreastfeedingFrom; BreastfeedingFrom)
            {
            }
            column(ProffessionalIllness; ProffessionalIllness)
            {
            }
            column(DecreaseInability; DecreaseInability)
            {
            }
            column(EmployeeDisability; EmployeeDisability)
            {
            }
            column(WorkViolationNote; WorkViolationNote)
            {
            }
            column(Other; Other)
            {
            }
            column(ActDate; ActDate)
            {
            }
            column(ActName; ActName)
            {
            }
            column(NumberOfAct; NumberOfAct)
            {
            }
            column(Proof; Proof)
            {
            }
            column(DateOfChange; DateOfChange)
            {
            }
            column(OpisiPoslova; OpisiPoslova)
            {
            }
            column(URLTEXT; URLTEXT)
            {
            }
            column(EmployeeContractNo; "Employee Contract o.")
            {
            }
            column(LineNo; LineNo)
            {
            }
            column(AdresaReal; AdresaReal)
            {
            }
            column(CityReal; CityReal)
            {
            }
            column(MunicipalityReal; MunicipalityReal)
            {
            }
            column(EntitetReal; EntitetReal)
            {
            }
            column(SvrhaPosla; SvrhaPosla)
            {
            }
            column(WorkingState; WorkingState)
            {
            }
            column(WorkingMunicipality; WorkingMunicipality)
            {
            }
            column(Uzivalac; Uzivalac)
            {
            }
            column(DaLiSamostalno; DaLiSamostalno)
            {
            }
            column(RadniciNepotpuno; RadniciNepotpuno)
            {
            }
            column(DjelatnostPoslodavca; DjelatnostPoslodavca)
            {
            }
            column(SamohraniRoditelj; SamohraniRoditelj)
            {
            }
            column(StatusUsvojitelja; StatusUsvojitelja)
            {
            }
            column(ProfesionalnaNesposobnost; ProfesionalnaNesposobnost)
            {
            }
            column(Smanjenje; Smanjenje)
            {
            }
            column(NeposretnoSmanjenje; NeposretnoSmanjenje)
            {
            }
            column(NeposrednoInvalidnost; NeposrednoInvalidnost)
            {
            }
            column(StepenInvalidnosti; StepenInvalidnosti)
            {
            }
            column(Identitet; DataItem10.Identitet)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Persss.COPYFILTERS(DataItem10);




                AutoInt := 0;
                PostCodeJob := '';
                UlazniFiltterPoss := '';
                Employeetest3.DELETEALL;
                Persss.SETCURRENTKEY("Line No.");
                Persss.ASCENDING;

                IF Persss.FINDSET THEN
                    REPEAT

                        Employeetest3.RESET;
                        Employeetest3.SETFILTER("Employee No.", '%1', Persss."Employee No.");
                        //%Employeetest3.SETFILTER("Org Shema",'%1',Persss."Org Shema");
                        Employeetest3.SETCURRENTKEY("Line No.");
                        Employeetest3.ASCENDING;

                        IF NOT Employeetest3.FINDFIRST THEN BEGIN
                            Employeetest3.INIT;
                            Employeetest3."Employee No." := Persss."Employee No.";
                            //%Employeetest3."Org Shema":=Persss."Org Shema";
                            Employeetest3."Date of change" := Persss."Date of change";
                            AutoInt := AutoInt + 1;
                            Employeetest3.AutoIncrement := AutoInt;
                            Employeetest3.INSERT;
                        END;


                    UNTIL Persss.NEXT = 0;


                Employeetest3.RESET;
                Employeetest3.SETFILTER("Employee No.", '%1', Persss."Employee No.");
                //%Employeetest3.SETFILTER("Org Shema",'<>%1','');
                IF Employeetest3.FINDSET THEN
                    REPEAT
                    //%UlazniFilterOrg:=UlazniFilterOrg+Employeetest3."Org Shema"+'|';

                    UNTIL Employeetest3.NEXT = 0;
                IF STRLEN(UlazniFilterOrg) >= 1 THEN
                    UlazniFilterOrg := COPYSTR(UlazniFilterOrg, 1, STRLEN(UlazniFilterOrg) - 1);

                Employeetest3.DELETEALL;




                Employeetest3.DELETEALL;
                //AutoInt:=0;
                PostCodeJob := '';
                UlazniFiltterPoss := '';
                Employeetest3.DELETEALL;

                //%Persss.SETFILTER("Position Code",'<>%1','');
                Persss.SETCURRENTKEY("Line No.");
                Persss.ASCENDING;
                IF Persss.FINDSET THEN
                    REPEAT

                        Employeetest3.RESET;
                        Employeetest3.SETFILTER("Employee No.", '%1', Persss."Employee No.");
                        //%Employeetest3.SETFILTER("Position Code",'%1',Persss."Position Code");
                        Employeetest3.SETCURRENTKEY("Line No.");
                        Employeetest3.ASCENDING;

                        IF NOT Employeetest3.FINDFIRST THEN BEGIN
                            Employeetest3.INIT;
                            Employeetest3."Employee No." := Persss."Employee No.";
                            //%Employeetest3."Position Code":=Persss."Position Code";
                            Employeetest3."Date of change" := Persss."Date of change";
                            AutoInt := AutoInt + 1;
                            Employeetest3.AutoIncrement := AutoInt;

                            Employeetest3.INSERT;
                        END;


                    UNTIL Persss.NEXT = 0;


                Employeetest3.RESET;
                Employeetest3.SETFILTER("Employee No.", '%1', Persss."Employee No.");
                //%Employeetest3.SETFILTER("Position Code",'<>%1','');
                Employeetest3.SETCURRENTKEY("Line No.");
                Employeetest3.ASCENDING;
                IF Employeetest3.FINDSET THEN
                    REPEAT
                    //%UlazniFiltterPoss:=UlazniFiltterPoss+Employeetest3."Position Code"+'|';

                    UNTIL Employeetest3.NEXT = 0;
                IF STRLEN(UlazniFiltterPoss) >= 1 THEN
                    UlazniFiltterPoss := COPYSTR(UlazniFiltterPoss, 1, STRLEN(UlazniFiltterPoss) - 1);

                Employeetest3.DELETEALL;



                URLTEXT := 'DynamicsNAV://localhost:7046/DynamicsNAV90/RAIFFAISEN BANK/runpage?page=429&$filter=''Job position Code''%20IS%20''' + UlazniFiltterPoss + '''%20AND%20''Org Shema''%20IS%20''' + UlazniFilterOrg + '''';
                F;
            end;

            trigger OnPostDataItem()
            begin








                //URLTEXT:='DynamicsNAV://localhost:7046/DynamicsNAV90/RAIFFAISEN BANK/runpage?page=429&$filter=''Job position Code='''+UlazniFiltterPoss+'''';
                
               // MESSAGE(URLTEXT);

            end;

            trigger OnPreDataItem()
            begin
                IF Evidencija = Evidencija::"Evidencija  o radnicima - matična evidencija kod poslodavca" THEN
                    Filter := '1'
                ELSE
                    Filter := '2';
                OpisiPoslova := 'Opis poslova';

                SETCURRENTKEY("Line No.");
                ASCENDING;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Evidencija; Evidencija)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        RptTitle = 'Certificate for scholarship';
    }

    trigger OnInitReport()
    begin
        TAB := 10;
    end;

    trigger OnPreReport()
    begin
        IF Evidencija = Evidencija::"Evidencija  o radnicima - matična evidencija kod poslodavca" THEN
            Filter := '1'
        ELSE
            Filter := '2';
        OpisiPoslova := 'Opis poslova';
        Pers.RESET;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);

        Pers.SETCURRENTKEY("Line No.");

        Pers.ASCENDING;
        IF Pers.FINDSET THEN
            REPEAT
                DataItem10.RESET;
                DataItem10.SETFILTER("Employee No.", '%1', Pers."Employee No.");

                IF NOT DataItem10.FINDFIRST THEN BEGIN
                    DataItem10.INIT;
                    DataItem10.TRANSFERFIELDS(Pers);
                    DataItem10.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        UlazniFilterOrg := '';
        UlazniFilterSifra := '';
    end;

    var
        Evidencija: Option "Evidencija  o radnicima - matična evidencija kod poslodavca","Evidencija  o drugim licima angažovanim na radu";
        "Filter": Text;
        LastName: Text;
        PersTemp2: Record "Personal track report" temporary;
        PersTemp3: Record "Personal track report" temporary;
        Pers: Record "Personal track report";
        PersTemp: Record "Personal track report" temporary;
        FirstName: Text;
        JMBG: Text;
        OpisiPoslova: Text;
        GenderText: Text;
        Indication1: Text;
        Employeetest3: Record "Personal track report" temporary;
        Persss: Record "Personal track report";
        TitleDesc: Text;
        UlazniFilterSifra: Text;
        UlazniFilterOrg: Text;
        BirthDate: Text;
        ResidenceTo: Text;
        SamohraniRoditelj: Text;
        ResidenceFrom: Text;
        RetMonth: Text;
        EntitetReal: Text;
        ResidenceCode: Text;
        EntitetCIPS: Text;
        DateOfChange: Text;
        RetDay: Text;
        BreastfeedingFrom: Text;
        Uzivalac: Text;
        Proof: Text;
        LineNo: Text;
        TerminationReason: Text;
        //    Jobdescriptionpersonal: Record "Job description personal";
        StepenInvalidnosti: Text;
        ll: Integer;
        AdresaReal: Text;
        Filterz: Text;
        Smanjenje: Text;
        CityReal: Text;
        RadniciNepotpuno: Text;
        DaLiSamostalno: Text;
        DjelatnostPoslodavca: Text;
        URLTEXT: Text;
        InactionFrom: Text;
        PostCodeJob: Text;
        NeposretnoSmanjenje: Text;
        MunicipalityReal: Text;
        ProfesionalnaNesposobnost: Text;
        UlazniFiltterPoss: Text;
        AbroadState: Text;
        ProffessionalIllness: Text;
        TAB: Char;
        WorkExperienceYear: Text;
        ActDate: Text;
        NumberOfAct: Text;
        WorkViolationNote: Text;
        PregnancyKeepingFrom: Text;
        RetYear: Text;
        ActName: Text;
        AutoInt: Integer;
        DecreaseInability: Text;
        EmployeeDisability: Text;
        PersCo: Code[10];
        AbroadTo: Text;
        TerminationDate: Text;
        PregnancyLeaveFrom: Text;
        Other: Text;
        InactionTO: Text;
        BirthCity: Text;
        WorkinHoursWeek: Text;
        AnotherPlace: Text;
        BirthMunicipality: Text;
        WorkExperienceDay: Text;
        WorkExperienceMonth: Text;
        AbroadCity: Text;
        ProffExamResult: Text;
        Indication2: Text;
        BirthState: Text;
        WorkingHoursDay: Text;
        ProffExamDate: Text;
        AbroadFrom: Text;
        CityCIPS: Text;
        AddressCIPS: Text;
        PrenticeContractTo: Text;
        PrenticeContractFrom: Text;
        MunicipalityCIPS: Text;
        Citizenship: Text;
        WorkPermitCode: Text;
        WorkPermitType: Text;
        WorkPermitFrom: Text;
        WorkPermitTo: Text;
        EducationLevel: Text;
        ProffesionalExam: Text;
        AdditionalEducation: Text;
        ExtractAdditional: Text;
        Certificate: Text;
        BrojUgovora: Text;
        DatumZakljucenjaUgovora: Text;
        DatumZaposlenja: Text;
        PositionName: Text;
        WorkingPlace: Text;
        ContractType: Text;
        ContractFrom: Text;
        ContractTO: Text;
        ProbationFrom: Text;
        ProbationTo: Text;
        PrenticeContractNo: Text;
        ProffesionalExamFrom: Text;
        ProffesionalExamTo: Text;
        Nema: Text;
        SvrhaPosla: Text;
        WorkingState: Text;
        WorkingMunicipality: Text;
        Personaltrack2: Record "Personal track 2";
        StatusUsvojitelja: Text;
        NeposrednoInvalidnost: Text;

    procedure F()
    var
        EmployeeTest: Record "Personal track report" temporary;
        EmpAuto: Record "Personal track report" temporary;
    begin
        AutoInt := 0;

        FirstName := '';
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);

        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("First Name", '%1', Pers."First Name");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."First Name" := Pers."First Name";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                FirstName := FirstName + EmployeeTest."First Name" + '/' + FORMAT(TAB);
                PersCo := Pers."Employee No.";
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(FirstName) >= 1 THEN
            FirstName := COPYSTR(FirstName, 1, STRLEN(FirstName) - 2);

        EmployeeTest.DELETEALL;
                LastName := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Last Name", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Last Name", '%1', Pers."Last Name");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Last Name" := Pers."Last Name";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                LastName := LastName + EmployeeTest."Last Name" + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(LastName) >= 1 THEN
            LastName := COPYSTR(LastName, 1, STRLEN(LastName) - 2);




        LineNo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Line No.", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Line No.", '%1', Pers."Line No.");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Line No." := Pers."Line No.";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                LineNo := LineNo + FORMAT(EmployeeTest."Line No.") + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(LineNo) >= 1 THEN
            LineNo := COPYSTR(LineNo, 1, STRLEN(LineNo) - 2);
















        Uzivalac := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Disability and pension persona", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Disability and pension persona", '%1', Pers."Disability and pension persona");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Disability and pension persona" := Pers."Disability and pension persona";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                Uzivalac := Uzivalac + EmployeeTest."Disability and pension persona" + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Uzivalac) >= 1 THEN
            Uzivalac := COPYSTR(Uzivalac, 1, STRLEN(Uzivalac) - 2);




        RadniciNepotpuno := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Part-time workers", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Part-time workers", '%1', Pers."Part-time workers");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Part-time workers" := Pers."Part-time workers";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                RadniciNepotpuno := RadniciNepotpuno + EmployeeTest."Part-time workers" + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(RadniciNepotpuno) >= 1 THEN
            RadniciNepotpuno := COPYSTR(RadniciNepotpuno, 1, STRLEN(RadniciNepotpuno) - 2);




        DaLiSamostalno := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Self-employment", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Self-employment", '%1', Pers."Self-employment");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Self-employment" := Pers."Self-employment";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                DaLiSamostalno := DaLiSamostalno + EmployeeTest."Self-employment" + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(DaLiSamostalno) >= 1 THEN
            DaLiSamostalno := COPYSTR(DaLiSamostalno, 1, STRLEN(DaLiSamostalno) - 2);



        DjelatnostPoslodavca := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Employee activity", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Employee activity", '%1', Pers."Employee activity");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Employee activity" := Pers."Employee activity";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                DjelatnostPoslodavca := DjelatnostPoslodavca + EmployeeTest."Employee activity" + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(DjelatnostPoslodavca) >= 1 THEN
            DjelatnostPoslodavca := COPYSTR(DjelatnostPoslodavca, 1, STRLEN(DjelatnostPoslodavca) - 2);




















        EmployeeTest.DELETEALL;
               JMBG := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER(JMBG, '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER(JMBG, '%1', Pers.JMBG);
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest.JMBG := Pers.JMBG;
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                JMBG := JMBG + EmployeeTest.JMBG + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(JMBG) >= 1 THEN
            JMBG := COPYSTR(JMBG, 1, STRLEN(JMBG) - 2);

              EmployeeTest.DELETEALL;
        GenderText := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER(Gender, '<>%1', Pers.Gender::" ");
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER(Gender, '%1', Pers.Gender);
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest.Gender := Pers.Gender;
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                GenderText := GenderText + FORMAT(EmployeeTest.Gender) + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(GenderText) >= 1 THEN
            GenderText := COPYSTR(GenderText, 1, STRLEN(GenderText) - 2);
        EmployeeTest.DELETEALL;
              BirthDate := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Birth Date", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Birth Date", '%1', Pers."Birth Date");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Birth Date" := Pers."Birth Date";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                BirthDate := BirthDate + FORMAT(EmployeeTest."Birth Date", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);

            //FORMAT(EmployeeTest."Birth Date",0,'<Day,2>.<Month,2>.<Year4>.')
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(BirthDate) >= 1 THEN
            BirthDate := COPYSTR(BirthDate, 1, STRLEN(BirthDate) - 2);

        EmployeeTest.DELETEALL;
      BirthCity := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Place of birth", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Place of birth", '%1', Pers."Place of birth");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Place of birth" := Pers."Place of birth";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF EmployeeTest.FINDSET THEN
            REPEAT
                BirthCity := BirthCity + FORMAT(EmployeeTest."Place of birth") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(BirthCity) >= 1 THEN
            BirthCity := COPYSTR(BirthCity, 1, STRLEN(BirthCity) - 2);

        EmployeeTest.DELETEALL;
                BirthMunicipality := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Birth Municipality", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Birth Municipality", '%1', Pers."Birth Municipality");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Birth Municipality" := Pers."Birth Municipality";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                BirthMunicipality := BirthMunicipality + FORMAT(EmployeeTest."Birth Municipality") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(BirthMunicipality) >= 1 THEN
            BirthMunicipality := COPYSTR(BirthMunicipality, 1, STRLEN(BirthMunicipality) - 2);
        EmployeeTest.DELETEALL;
                BirthState := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Birth State", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Birth State", '%1', Pers."Birth State");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Birth State" := Pers."Birth State";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                BirthState := BirthState + FORMAT(EmployeeTest."Birth State") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(BirthState) >= 1 THEN
            BirthState := COPYSTR(BirthState, 1, STRLEN(BirthState) - 2);
        EmployeeTest.DELETEALL;
               CityCIPS := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("City CIPS", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("City CIPS", '%1', Pers."City CIPS");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."City CIPS" := Pers."City CIPS";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                CityCIPS := CityCIPS + FORMAT(EmployeeTest."City CIPS") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(CityCIPS) >= 1 THEN
            CityCIPS := COPYSTR(CityCIPS, 1, STRLEN(CityCIPS) - 2);
        EmployeeTest.DELETEALL;





      
        CityReal := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("City Real", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("City Real", '%1', Pers."City Real");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."City Real" := Pers."City Real";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                CityReal := CityCIPS + FORMAT(EmployeeTest."City Real") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(CityReal) >= 1 THEN
            CityReal := COPYSTR(CityReal, 1, STRLEN(CityReal) - 2);
        EmployeeTest.DELETEALL;








        
        AddressCIPS := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Address CIPS", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Address CIPS", '%1', Pers."Address CIPS");
                EmployeeTest.SETFILTER("Municipality CIPS", '%1', Pers."Municipality CIPS");
                EmployeeTest.SETFILTER("Entity CIPS", '%1', Pers."Entity CIPS");
                EmployeeTest.SETFILTER("City CIPS", '%1', Pers."City CIPS");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Address CIPS" := Pers."Address CIPS";
                    EmployeeTest."Municipality CIPS" := Pers."Municipality CIPS";
                    EmployeeTest."Entity CIPS" := Pers."Entity CIPS";
                    EmployeeTest."City CIPS" := Pers."City CIPS";


                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;


        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT


                AddressCIPS := AddressCIPS + FORMAT(EmployeeTest."Address CIPS" + ' ;' + EmployeeTest."Municipality CIPS" + ' ;' + EmployeeTest."City CIPS" + '  ;' + EmployeeTest."Entity CIPS" + ' ') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AddressCIPS) >= 1 THEN
            AddressCIPS := COPYSTR(AddressCIPS, 1, STRLEN(AddressCIPS) - 2);
        EmployeeTest.DELETEALL;



        AdresaReal := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Address Real", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT
                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Address Real", '%1', Pers."Address Real");
                EmployeeTest.SETFILTER("Municipality Real", '%1', Pers."Municipality Real");
                EmployeeTest.SETFILTER("Entity Real", '%1', Pers."Entity Real");
                EmployeeTest.SETFILTER("City Real", '%1', Pers."City Real");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Address Real" := Pers."Address Real";
                    EmployeeTest."Municipality Real" := Pers."Municipality Real";
                    EmployeeTest."Entity Real" := Pers."Entity Real";
                    EmployeeTest."City Real" := Pers."City Real";

                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT

                AdresaReal := AdresaReal + FORMAT(EmployeeTest."Address Real" + ' ;' + EmployeeTest."Municipality Real" + ' ;' + EmployeeTest."City Real" + '  ;' + EmployeeTest."Entity Real" + ' ') + '/' + FORMAT(TAB);




            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AdresaReal) >= 1 THEN
            AdresaReal := COPYSTR(AdresaReal, 1, STRLEN(AdresaReal) - 2);
        EmployeeTest.DELETEALL;



        
        MunicipalityCIPS := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Municipality CIPS", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Municipality CIPS", '%1', Pers."Municipality CIPS");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Municipality CIPS" := Pers."Municipality CIPS";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                MunicipalityCIPS := MunicipalityCIPS + FORMAT(EmployeeTest."Municipality CIPS") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(MunicipalityCIPS) >= 1 THEN
            MunicipalityCIPS := COPYSTR(MunicipalityCIPS, 1, STRLEN(MunicipalityCIPS) - 2);







        MunicipalityReal := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Municipality Real", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Municipality Real", '%1', Pers."Municipality Real");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Municipality Real" := Pers."Municipality Real";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                MunicipalityReal := MunicipalityReal + FORMAT(EmployeeTest."Municipality Real") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(MunicipalityReal) >= 1 THEN
            MunicipalityReal := COPYSTR(MunicipalityReal, 1, STRLEN(MunicipalityReal) - 2);







       
        EntitetCIPS := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Entity CIPS", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Entity CIPS", '%1', Pers."Entity CIPS");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Entity CIPS" := Pers."Entity CIPS";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                EntitetCIPS := EntitetCIPS + FORMAT(EmployeeTest."Entity CIPS") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(EntitetCIPS) >= 1 THEN
            EntitetCIPS := COPYSTR(EntitetCIPS, 1, STRLEN(EntitetCIPS) - 2);




        EntitetReal := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Entity Real", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Entity Real", '%1', Pers."Entity Real");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Entity Real" := Pers."Entity Real";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                EntitetReal := EntitetReal + FORMAT(EmployeeTest."Entity Real") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(EntitetReal) >= 1 THEN
            EntitetReal := COPYSTR(EntitetReal, 1, STRLEN(EntitetReal) - 2);







      
        EmployeeTest.DELETEALL;
        Citizenship := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER(Citizenship, '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER(Citizenship, '%1', Pers.Citizenship);
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest.Citizenship := Pers.Citizenship;
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                Citizenship := Citizenship + FORMAT(EmployeeTest.Citizenship) + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Citizenship) >= 1 THEN
            Citizenship := COPYSTR(Citizenship, 1, STRLEN(Citizenship) - 2);
        EmployeeTest.DELETEALL;
        

        WorkPermitCode := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Work Permit Code", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Work Permit Code", '%1', Pers."Work Permit Code");
                EmployeeTest.SETFILTER("Work Permit From", '%1', Pers."Work Permit From");
                EmployeeTest.SETFILTER("Work Permit Type", '%1', Pers."Work Permit Type");
                EmployeeTest.SETFILTER("Work Permit To", '%1', Pers."Work Permit To");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Work Permit Code" := Pers."Work Permit Code";
                    EmployeeTest."Work Permit From" := Pers."Work Permit From";
                    EmployeeTest."Work Permit To" := Pers."Work Permit To";
                    EmployeeTest."Work Permit Type" := Pers."Work Permit Type";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkPermitCode := WorkPermitCode + FORMAT(EmployeeTest."Work Permit Type") + ';' +
               FORMAT(EmployeeTest."Work Permit Code") + ';' + FORMAT(EmployeeTest."Work Permit From", 0, '<Day,2>.<Month,2>.<Year4>.') +
               '-' + FORMAT(EmployeeTest."Work Permit To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkPermitCode) >= 1 THEN
            WorkPermitCode := COPYSTR(WorkPermitCode, 1, STRLEN(WorkPermitCode) - 2);
        EmployeeTest.DELETEALL;







       ResidenceCode := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Residence Permit Code", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Residence Permit Code", '%1', Pers."Residence Permit Code");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Residence Permit Code" := Pers."Residence Permit Code";
                    EmployeeTest."Residence Permit From" := Pers."Residence Permit From";
                    EmployeeTest."Residence Permit To" := Pers."Residence Permit To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT

                ResidenceCode := ResidenceCode + FORMAT(EmployeeTest."Residence Permit Code") + ';' +
            FORMAT(EmployeeTest."Residence Permit From", 0, '<Day,2>.<Month,2>.<Year4>.') +
             '-' + FORMAT(EmployeeTest."Residence Permit To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);


            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ResidenceCode) >= 1 THEN
            ResidenceCode := COPYSTR(ResidenceCode, 1, STRLEN(ResidenceCode) - 2);
        EmployeeTest.DELETEALL;








        ResidenceFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Residence Permit From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Residence Permit From", '%1', Pers."Residence Permit From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Residence Permit From" := Pers."Residence Permit From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ResidenceFrom := ResidenceFrom + FORMAT(EmployeeTest."Residence Permit From") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ResidenceFrom) >= 1 THEN
            ResidenceFrom := COPYSTR(ResidenceFrom, 1, STRLEN(ResidenceFrom) - 2);



        ResidenceTo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Residence Permit To", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Residence Permit To", '%1', Pers."Residence Permit To");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Residence Permit To" := Pers."Residence Permit To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ResidenceTo := ResidenceTo + FORMAT(EmployeeTest."Residence Permit To") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ResidenceTo) >= 1 THEN
            ResidenceTo := COPYSTR(ResidenceTo, 1, STRLEN(ResidenceTo) - 2);







        WorkPermitType := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Work Permit Type", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Work Permit Type", '%1', Pers."Work Permit Type");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Work Permit Type" := Pers."Work Permit Type";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkPermitType := WorkPermitType + FORMAT(EmployeeTest."Work Permit Type") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkPermitType) >= 1 THEN
            WorkPermitType := COPYSTR(WorkPermitType, 1, STRLEN(WorkPermitType) - 2);
        EmployeeTest.DELETEALL;
    
        WorkPermitFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Work Permit From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Work Permit From", '%1', Pers."Work Permit From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Work Permit From" := Pers."Work Permit From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkPermitFrom := WorkPermitFrom + FORMAT(EmployeeTest."Work Permit From", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkPermitFrom) >= 1 THEN
            WorkPermitFrom := COPYSTR(WorkPermitFrom, 1, STRLEN(WorkPermitFrom) - 2);
        EmployeeTest.DELETEALL;
        
        WorkPermitTo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Work Permit To", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Work Permit To", '%1', Pers."Work Permit To");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Work Permit To" := Pers."Work Permit To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkPermitTo := WorkPermitTo + FORMAT(EmployeeTest."Work Permit To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkPermitTo) >= 1 THEN
            WorkPermitTo := COPYSTR(WorkPermitTo, 1, STRLEN(WorkPermitTo) - 2);
        EmployeeTest.DELETEALL;
       
        EducationLevel := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Education Level", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Education Level", '%1', Pers."Education Level");
                EmployeeTest.SETFILTER("Title Description", '%1', Pers."Title Description");

                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Education Level" := Pers."Education Level";
                    EmployeeTest."Title Description" := Pers."Title Description";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                EducationLevel := EducationLevel + FORMAT(EmployeeTest."Education Level") + ' ;' + EmployeeTest."Title Description" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(EducationLevel) >= 1 THEN
            EducationLevel := COPYSTR(EducationLevel, 1, STRLEN(EducationLevel) - 2);
        EmployeeTest.DELETEALL;
       
        ProffesionalExam := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Proffessional Exam", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Proffessional Exam", '%1', Pers."Proffessional Exam");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Proffessional Exam" := Pers."Proffessional Exam";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;


        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProffesionalExam := ProffesionalExam + FORMAT(EmployeeTest."Proffessional Exam") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProffesionalExam) >= 1 THEN
            ProffesionalExam := COPYSTR(ProffesionalExam, 1, STRLEN(ProffesionalExam) - 2);

        EmployeeTest.DELETEALL;

     
        ProffesionalExamFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Proffessional Exam From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Proffessional Exam From", '%1', Pers."Proffessional Exam From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Proffessional Exam From" := Pers."Proffessional Exam From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProffesionalExamFrom := ProffesionalExamFrom + FORMAT(EmployeeTest."Proffessional Exam From", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProffesionalExamFrom) >= 1 THEN
            ProffesionalExamFrom := COPYSTR(ProffesionalExamFrom, 1, STRLEN(ProffesionalExamFrom) - 2);

        EmployeeTest.DELETEALL;
        
        ProffesionalExamTo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Proffessional Exam To", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Proffessional Exam To", '%1', Pers."Proffessional Exam To");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Proffessional Exam To" := Pers."Proffessional Exam To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;


        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProffesionalExamTo := ProffesionalExamTo + FORMAT(EmployeeTest."Proffessional Exam To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProffesionalExamTo) >= 1 THEN
            ProffesionalExamTo := COPYSTR(ProffesionalExamTo, 1, STRLEN(ProffesionalExamTo) - 2);
        EmployeeTest.DELETEALL;
        
        AdditionalEducation := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Additional Education", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Additional Education", '%1', Pers."Additional Education");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Additional Education" := Pers."Additional Education";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                AdditionalEducation := AdditionalEducation + FORMAT(EmployeeTest."Additional Education") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AdditionalEducation) >= 1 THEN
            AdditionalEducation := COPYSTR(AdditionalEducation, 1, STRLEN(AdditionalEducation) - 2);
        EmployeeTest.DELETEALL;





        TitleDesc := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Title Description", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Title Description", '%1', Pers."Title Description");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Title Description" := Pers."Title Description";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                TitleDesc := TitleDesc + FORMAT(EmployeeTest."Title Description") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(TitleDesc) >= 1 THEN
            TitleDesc := COPYSTR(TitleDesc, 1, STRLEN(TitleDesc) - 2);
        EmployeeTest.DELETEALL;


      
        ExtractAdditional := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Extract Additional", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Pers."Extract Additional");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Extract Additional" := Pers."Extract Additional";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ExtractAdditional := ExtractAdditional + FORMAT(EmployeeTest."Extract Additional") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ExtractAdditional) >= 1 THEN
            ExtractAdditional := COPYSTR(ExtractAdditional, 1, STRLEN(ExtractAdditional) - 2);
        EmployeeTest.DELETEALL;
       
        Certificate := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER(Certificate, '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER(Certificate, '%1', Pers.Certificate);
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest.Certificate := Pers.Certificate;
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                Certificate := Certificate + FORMAT(EmployeeTest.Certificate) + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Certificate) >= 1 THEN
            Certificate := COPYSTR(Certificate, 1, STRLEN(Certificate) - 2);
        EmployeeTest.DELETEALL;



        
        DatumZakljucenjaUgovora := '';
        BrojUgovora := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Starting Date Contract", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Employee Contract o.", '<>%1', '');
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Starting Date Contract", '%1', Pers."Starting Date Contract");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Starting Date Contract" := Pers."Starting Date Contract";
                    EmployeeTest."Employee Contract o." := Pers."Employee Contract o.";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                DatumZakljucenjaUgovora := DatumZakljucenjaUgovora + FORMAT(EmployeeTest."Employee Contract o.") + ';' + FORMAT(EmployeeTest."Starting Date Contract", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(DatumZakljucenjaUgovora) >= 1 THEN
            DatumZakljucenjaUgovora := COPYSTR(DatumZakljucenjaUgovora, 1, STRLEN(DatumZakljucenjaUgovora) - 2);
        EmployeeTest.DELETEALL;
        BrojUgovora := 'test';
        
        DatumZaposlenja := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Employment Date", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Employment Date", '%1', Pers."Employment Date");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Employment Date" := Pers."Employment Date";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                DatumZaposlenja := DatumZaposlenja + FORMAT(EmployeeTest."Employment Date", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(DatumZaposlenja) >= 1 THEN
            DatumZaposlenja := COPYSTR(DatumZaposlenja, 1, STRLEN(DatumZaposlenja) - 2);
        EmployeeTest.DELETEALL;
       
        PositionName := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Position Name", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Position Name", '%1', Pers."Position Name");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Position Name" := Pers."Position Name";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                PositionName := PositionName + FORMAT(EmployeeTest."Position Name") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(PositionName) >= 1 THEN
            PositionName := COPYSTR(PositionName, 1, STRLEN(PositionName) - 2);
        EmployeeTest.DELETEALL;





        SvrhaPosla := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Position Name", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Position Name", '%1', Pers."Position Name");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Position Name" := Pers."Position Name";
                    EmployeeTest."Position Code" := Pers."Position Code";
                    EmployeeTest."Org Shema" := Pers."Org Shema";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT


                IF SvrhaPosla <> '' THEN
                    SvrhaPosla := SvrhaPosla + '/' + FORMAT(TAB)
                ELSE
                    SvrhaPosla := '';
           



            UNTIL EmployeeTest.NEXT = 0;

        EmployeeTest.DELETEALL;




        
        WorkingPlace := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Working Place", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Working Place", '%1', Pers."Working Place");
                EmployeeTest.SETFILTER("Working State", '%1', Pers."Working State");
                EmployeeTest.SETFILTER("Municipality Working", '%1', Pers."Municipality Working");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Working Place" := Pers."Working Place";
                    EmployeeTest."Working State" := Pers."Working State";
                    EmployeeTest."Municipality Working" := Pers."Municipality Working";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkingPlace := WorkingPlace + FORMAT(EmployeeTest."Working Place") + ' ;' + EmployeeTest."Municipality Working" + ' ;' + EmployeeTest."Working State" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkingPlace) >= 1 THEN
            WorkingPlace := COPYSTR(WorkingPlace, 1, STRLEN(WorkingPlace) - 2);
        EmployeeTest.DELETEALL;



        WorkingState := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Working State", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Working State", '%1', Pers."Working State");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Working State" := Pers."Working State";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkingState := WorkingState + FORMAT(EmployeeTest."Working State") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkingState) >= 1 THEN
            WorkingState := COPYSTR(WorkingState, 1, STRLEN(WorkingState) - 2);
        EmployeeTest.DELETEALL;




        WorkingMunicipality := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Municipality Working", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Municipality Working", '%1', Pers."Municipality Working");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Municipality Working" := Pers."Municipality Working";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkingMunicipality := WorkingMunicipality + FORMAT(EmployeeTest."Municipality Working") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkingMunicipality) >= 1 THEN
            WorkingMunicipality := COPYSTR(WorkingMunicipality, 1, STRLEN(WorkingMunicipality) - 2);
        EmployeeTest.DELETEALL;







        
        ContractType := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Contract type", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Contract type", '%1', Pers."Contract type");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Contract type" := Pers."Contract type";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ContractType := ContractType + FORMAT(EmployeeTest."Contract type") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ContractType) >= 1 THEN
            ContractType := COPYSTR(ContractType, 1, STRLEN(ContractType) - 2);
        EmployeeTest.DELETEALL;
        
        ContractFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Definitely Contract From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                // EmployeeTest.SETFILTER("Definitely Contract From",'%1',Pers."Definitely Contract From");
                EmployeeTest.SETFILTER("Contract No", '%1', DataItem10."Contract No");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Definitely Contract From" := Pers."Definitely Contract From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ContractFrom := ContractFrom + FORMAT(EmployeeTest."Definitely Contract From", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ContractFrom) >= 1 THEN
            ContractFrom := COPYSTR(ContractFrom, 1, STRLEN(ContractFrom) - 2);
        EmployeeTest.DELETEALL;
        
        ContractTO := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Definitely Contract To", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                //EmployeeTest.SETFILTER("Definitely Contract To",'%1',Pers."Definitely Contract To");
                EmployeeTest.SETFILTER("Contract No", '%1', DataItem10."Contract No");

                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Definitely Contract To" := Pers."Definitely Contract To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ContractTO := ContractTO + FORMAT(EmployeeTest."Definitely Contract To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ContractTO) >= 1 THEN
            ContractTO := COPYSTR(ContractTO, 1, STRLEN(ContractTO) - 2);
        EmployeeTest.DELETEALL;
        
        ProbationFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Definitely Contract From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Definitely Contract From", '%1', Pers."Definitely Contract From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Definitely Contract From" := Pers."Definitely Contract From";
                    EmployeeTest."Definitely Contract To" := Pers."Definitely Contract To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProbationFrom := ProbationFrom + FORMAT(EmployeeTest."Definitely Contract From", 0, '<Day,2>.<Month,2>.<Year4>.') + '-' + FORMAT(EmployeeTest."Definitely Contract To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProbationFrom) >= 1 THEN
            ProbationFrom := COPYSTR(ProbationFrom, 1, STRLEN(ProbationFrom) - 2);
        EmployeeTest.DELETEALL;
        
        ProbationTo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Probation From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Probation From", '%1', Pers."Probation From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Probation From" := Pers."Probation From";
                    EmployeeTest."Probation To" := Pers."Probation To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProbationTo := ProbationTo + FORMAT(EmployeeTest."Probation From", 0, '<Day,2>.<Month,2>.<Year4>.') + '-' + FORMAT(EmployeeTest."Probation To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);

            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProbationTo) >= 1 THEN
            ProbationTo := COPYSTR(ProbationTo, 1, STRLEN(ProbationTo) - 2);
        EmployeeTest.DELETEALL;
        
        PrenticeContractNo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Prentice Contract No.", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Prentice Contract No.", '%1', Pers."Prentice Contract No.");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Prentice Contract No." := Pers."Prentice Contract No.";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                PrenticeContractNo := PrenticeContractNo + FORMAT(EmployeeTest."Prentice Contract No.") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(PrenticeContractNo) >= 1 THEN
            PrenticeContractNo := COPYSTR(PrenticeContractNo, 1, STRLEN(PrenticeContractNo) - 2);
        EmployeeTest.DELETEALL;
        
        PrenticeContractFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Prentice Contract From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Prentice Contract From", '%1', Pers."Prentice Contract From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Prentice Contract From" := Pers."Prentice Contract From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                PrenticeContractFrom := PrenticeContractFrom + FORMAT(EmployeeTest."Prentice Contract From", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(PrenticeContractFrom) >= 1 THEN
            PrenticeContractFrom := COPYSTR(PrenticeContractFrom, 1, STRLEN(PrenticeContractFrom) - 2);
        EmployeeTest.DELETEALL;
        
        PrenticeContractTo := '';


        //ContractFrom
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Prentice Contract To", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Prentice Contract To", '%1', Pers."Prentice Contract To");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Prentice Contract To" := Pers."Prentice Contract To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                PrenticeContractTo := PrenticeContractTo + FORMAT(EmployeeTest."Prentice Contract To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(PrenticeContractTo) >= 1 THEN
            PrenticeContractTo := COPYSTR(PrenticeContractTo, 1, STRLEN(PrenticeContractTo) - 2);
        EmployeeTest.DELETEALL;
        
        ProffExamDate := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Proffesional Exam Date", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Proffesional Exam Date", '%1', Pers."Proffesional Exam Date");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Proffesional Exam Date" := Pers."Proffesional Exam Date";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProffExamDate := ProffExamDate + FORMAT(EmployeeTest."Proffesional Exam Date", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProffExamDate) >= 1 THEN
            ProffExamDate := COPYSTR(ProffExamDate, 1, STRLEN(ProffExamDate) - 2);
        EmployeeTest.DELETEALL;
        
        ProffExamResult := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Proffesional Exam Result", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Proffesional Exam Result", '%1', Pers."Proffesional Exam Result");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Proffesional Exam Result" := Pers."Proffesional Exam Result";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProffExamResult := ProffExamResult + FORMAT(EmployeeTest."Proffesional Exam Result") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProffExamResult) >= 1 THEN
            ProffExamResult := COPYSTR(ProffExamResult, 1, STRLEN(ProffExamResult) - 2);
        EmployeeTest.DELETEALL;
        

        AbroadFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Abroad From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Abroad From", '%1', Pers."Abroad From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Abroad From" := Pers."Abroad From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                AbroadFrom := AbroadFrom + FORMAT(EmployeeTest."Abroad From", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AbroadFrom) >= 1 THEN
            AbroadFrom := COPYSTR(AbroadFrom, 1, STRLEN(AbroadFrom) - 2);
        EmployeeTest.DELETEALL;

        AbroadTo := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Abroad To", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Abroad To", '%1', Pers."Abroad To");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Abroad To" := Pers."Abroad To";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                AbroadTo := AbroadTo + FORMAT(EmployeeTest."Abroad To", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AbroadTo) >= 1 THEN
            AbroadTo := COPYSTR(AbroadTo, 1, STRLEN(AbroadTo) - 2);
        EmployeeTest.DELETEALL;
        
        AbroadCity := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Abroad City", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Abroad City", '%1', Pers."Abroad City");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Abroad City" := Pers."Abroad City";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                AbroadCity := AbroadCity + FORMAT(EmployeeTest."Abroad City") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AbroadCity) >= 1 THEN
            AbroadCity := COPYSTR(AbroadCity, 1, STRLEN(AbroadCity) - 2);
        EmployeeTest.DELETEALL;
        
        AbroadState := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Abroad State", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Abroad State", '%1', Pers."Abroad State");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Abroad State" := Pers."Abroad State";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                AbroadState := AbroadState + FORMAT(EmployeeTest."Abroad State") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AbroadState) >= 1 THEN
            AbroadState := COPYSTR(AbroadState, 1, STRLEN(AbroadState) - 2);
        EmployeeTest.DELETEALL;
        
        WorkinHoursWeek := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Working Hours Week", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Working Hours Week", '%1', Pers."Working Hours Week");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Working Hours Week" := Pers."Working Hours Week";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkinHoursWeek := WorkinHoursWeek + FORMAT(EmployeeTest."Working Hours Week") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkinHoursWeek) >= 1 THEN
            WorkinHoursWeek := COPYSTR(WorkinHoursWeek, 1, STRLEN(WorkinHoursWeek) - 2);
        EmployeeTest.DELETEALL;
        
        WorkingHoursDay := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Working Hours Day", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Working Hours Day", '%1', Pers."Working Hours Day");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Working Hours Day" := Pers."Working Hours Day";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkingHoursDay := WorkingHoursDay + FORMAT(EmployeeTest."Working Hours Day") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkingHoursDay) >= 1 THEN
            WorkingHoursDay := COPYSTR(WorkingHoursDay, 1, STRLEN(WorkingHoursDay) - 2);
        EmployeeTest.DELETEALL;
        
        Indication1 := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Indication for work experience", '<>%1', FALSE);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Indication for work experience", '%1', Pers."Indication for work experience");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Indication for work experience" := Pers."Indication for work experience";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                IF EmployeeTest."Indication for work experience" = FALSE THEN
                    Indication1 := Indication1 + 'Ne' + '/' + FORMAT(TAB)
                ELSE
                    Indication1 := Indication1 + 'Da' + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Indication1) >= 1 THEN
            Indication1 := COPYSTR(Indication1, 1, STRLEN(Indication1) - 2);
        EmployeeTest.DELETEALL;
        
        Indication2 := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Indication of capability", '<>%1', FALSE);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Indication of capability", '%1', Pers."Indication of capability");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Indication of capability" := Pers."Indication of capability";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                IF EmployeeTest."Indication of capability" = FALSE THEN
                    Indication2 := Indication2 + 'Ne' + '/' + FORMAT(TAB)
                ELSE
                    Indication2 := Indication2 + 'Da' + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Indication2) >= 1 THEN
            Indication2 := COPYSTR(Indication2, 1, STRLEN(Indication2) - 2);
        EmployeeTest.DELETEALL;
        
        AnotherPlace := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Another place of work", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Another place of work", '%1', Pers."Another place of work");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Another place of work" := Pers."Another place of work";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                AnotherPlace := AnotherPlace + FORMAT(EmployeeTest."Another place of work") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(AnotherPlace) >= 1 THEN
            AnotherPlace := COPYSTR(AnotherPlace, 1, STRLEN(AnotherPlace) - 2);
        EmployeeTest.DELETEALL;

        WorkExperienceYear := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Pers.FINDSET THEN
            REPEAT
                IF (Pers."Work Experience Year" <> 0) OR (Pers."Work Experience Month" <> 0) OR (Pers."Work Experience Day" <> 0) THEN BEGIN
                    EmployeeTest.RESET;
                    EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                    EmployeeTest.SETFILTER("Work Experience Year", '%1', Pers."Work Experience Year");
                    EmployeeTest.SETFILTER("Work Experience Month", '%1', Pers."Work Experience Month");
                    EmployeeTest.SETFILTER("Work Experience Day", '%1', Pers."Work Experience Day");

                    IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                        EmployeeTest.INIT;
                        EmployeeTest."Employee No." := Pers."Employee No.";
                        EmployeeTest."Work Experience Year" := Pers."Work Experience Year";
                        EmployeeTest."Work Experience Month" := Pers."Work Experience Month";
                        EmployeeTest."Work Experience Day" := Pers."Work Experience Day";
                        EmployeeTest."Date of change" := Pers."Date of change";
                        AutoInt := AutoInt + 1;

                        EmployeeTest.AutoIncrement := AutoInt;
                        EmployeeTest.INSERT;
                    END;
                END;
            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkExperienceYear := WorkExperienceYear + FORMAT(EmployeeTest."Work Experience Year") + '.' + FORMAT(EmployeeTest."Work Experience Month") + '.' + FORMAT(EmployeeTest."Work Experience Day")
               + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkExperienceYear) >= 1 THEN
            WorkExperienceYear := COPYSTR(WorkExperienceYear, 1, STRLEN(WorkExperienceYear) - 2);
        IF WorkExperienceYear = '' THEN
            WorkExperienceYear := '0.0.0.';
        EmployeeTest.DELETEALL;
        
        WorkExperienceMonth := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Work Experience Month", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Work Experience Month", '%1', Pers."Work Experience Month");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Work Experience Month" := Pers."Work Experience Month";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkExperienceMonth := WorkExperienceMonth + FORMAT(EmployeeTest."Work Experience Month") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkExperienceMonth) >= 1 THEN
            WorkExperienceMonth := COPYSTR(WorkExperienceMonth, 1, STRLEN(WorkExperienceMonth) - 2);
        WorkExperienceMonth := '';
        EmployeeTest.DELETEALL;
        
        WorkExperienceDay := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Work Experience Day", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Work Experience Day", '%1', Pers."Work Experience Day");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Work Experience Day" := Pers."Work Experience Day";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkExperienceDay := WorkExperienceDay + FORMAT(EmployeeTest."Work Experience Day") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkExperienceDay) >= 1 THEN
            WorkExperienceDay := COPYSTR(WorkExperienceDay, 1, STRLEN(WorkExperienceDay) - 2);
        WorkExperienceDay := '';
        EmployeeTest.DELETEALL;
        

        RetYear := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Ret. Work Experience Year", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Ret. Work Experience Year", '%1', Pers."Ret. Work Experience Year");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Ret. Work Experience Year" := Pers."Ret. Work Experience Year";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                RetYear := RetYear + FORMAT(EmployeeTest."Ret. Work Experience Year") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(RetYear) >= 1 THEN
            RetYear := COPYSTR(RetYear, 1, STRLEN(RetYear) - 2);
        RetMonth := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Ret. Work Experience Month", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Ret. Work Experience Month", '%1', Pers."Ret. Work Experience Month");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Ret. Work Experience Month" := Pers."Ret. Work Experience Month";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                RetMonth := RetMonth + FORMAT(EmployeeTest."Ret. Work Experience Month") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(RetMonth) >= 1 THEN
            RetMonth := COPYSTR(RetMonth, 1, STRLEN(RetMonth) - 2);
        RetDay := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Ret. Work Experience Year", '<>%1', 0);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Retirement Work Experience Day", '%1', Pers."Retirement Work Experience Day");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Retirement Work Experience Day" := Pers."Retirement Work Experience Day";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                RetDay := RetDay + FORMAT(EmployeeTest."Retirement Work Experience Day") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(RetYear) >= 1 THEN
            RetDay := COPYSTR(RetDay, 1, STRLEN(RetDay) - 2);
        
        InactionFrom := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Inaction From", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Inaction From", '%1', Pers."Inaction From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Inaction From" := Pers."Inaction From";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                InactionFrom := InactionFrom + FORMAT(EmployeeTest."Inaction From", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(InactionFrom) >= 1 THEN
            InactionFrom := COPYSTR(InactionFrom, 1, STRLEN(InactionFrom) - 2);

        InactionTO := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Inaction to", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Inaction to", '%1', Pers."Inaction to");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Inaction to" := Pers."Inaction to";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                InactionTO := InactionTO + FORMAT(EmployeeTest."Inaction to", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(InactionTO) >= 1 THEN
            InactionTO := COPYSTR(InactionTO, 1, STRLEN(InactionTO) - 2);
        
        TerminationDate := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Termination Date", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Termination Date", '%1', Pers."Termination Date");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Termination Date" := Pers."Termination Date";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                TerminationDate := TerminationDate + FORMAT(EmployeeTest."Termination Date", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(TerminationDate) >= 1 THEN
            TerminationDate := COPYSTR(TerminationDate, 1, STRLEN(TerminationDate) - 2);
        
        TerminationReason := '';
        EmployeeTest.DELETEALL;
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Termination Reason", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Termination Reason", '%1', Pers."Termination Reason");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Termination Reason" := Pers."Termination Reason";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                TerminationReason := TerminationReason + FORMAT(EmployeeTest."Termination Reason") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(TerminationReason) >= 1 THEN
            TerminationReason := COPYSTR(TerminationReason, 1, STRLEN(TerminationReason) - 2);
    




        PregnancyKeepingFrom := '';
        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
       
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Pregnancy Keeping From", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Pregnancy Keeping From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Pregnancy Keeping From";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                PregnancyKeepingFrom := PregnancyKeepingFrom + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(PregnancyKeepingFrom) >= 1 THEN
            PregnancyKeepingFrom := COPYSTR(PregnancyKeepingFrom, 1, STRLEN(PregnancyKeepingFrom) - 2);







        
        PregnancyLeaveFrom := '';
        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Pregnancy Leave From", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Pregnancy Leave From");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Pregnancy Leave From";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                PregnancyLeaveFrom := PregnancyLeaveFrom + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(PregnancyLeaveFrom) >= 1 THEN
            PregnancyLeaveFrom := COPYSTR(PregnancyLeaveFrom, 1, STRLEN(PregnancyLeaveFrom) - 2);





        
        BreastfeedingFrom := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Breastfeeding from", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Breastfeeding from");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Breastfeeding from";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                BreastfeedingFrom := BreastfeedingFrom + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(BreastfeedingFrom) >= 1 THEN
            BreastfeedingFrom := COPYSTR(BreastfeedingFrom, 1, STRLEN(BreastfeedingFrom) - 2);






        ProffessionalIllness := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;


        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Proffessional Illness", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Proffessional Illness");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Proffessional Illness";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProffessionalIllness := ProffessionalIllness + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProffessionalIllness) >= 1 THEN
            ProffessionalIllness := COPYSTR(ProffessionalIllness, 1, STRLEN(ProffessionalIllness) - 2);





        WorkViolationNote := '';
        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Work Violation Note", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Work Violation Note");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Work Violation Note";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                WorkViolationNote := WorkViolationNote + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(WorkViolationNote) >= 1 THEN
            WorkViolationNote := COPYSTR(WorkViolationNote, 1, STRLEN(WorkViolationNote) - 2);















        DecreaseInability := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;


        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Decrease Inability", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Decrease Inability");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Decrease Inability";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                DecreaseInability := DecreaseInability + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(DecreaseInability) >= 1 THEN
            DecreaseInability := COPYSTR(DecreaseInability, 1, STRLEN(DecreaseInability) - 2);



















        
        EmployeeDisability := '';


        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;


        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Employee Disability", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Employee Disability");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Employee Disability";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                EmployeeDisability := EmployeeDisability + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(EmployeeDisability) >= 1 THEN
            EmployeeDisability := COPYSTR(EmployeeDisability, 1, STRLEN(EmployeeDisability) - 2);







        
        Other := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Others data set", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Others data set");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Others data set";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                Other := Other + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Other) >= 1 THEN
            Other := COPYSTR(Other, 1, STRLEN(Other) - 2);


        SamohraniRoditelj := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Status samohranog roditelj", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Status samohranog roditelj");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Status samohranog roditelj";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                SamohraniRoditelj := SamohraniRoditelj + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(SamohraniRoditelj) >= 1 THEN
            SamohraniRoditelj := COPYSTR(SamohraniRoditelj, 1, STRLEN(SamohraniRoditelj) - 2);








        //
        StatusUsvojitelja := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Adaption status", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Adaption status");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Adaption status";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                StatusUsvojitelja := StatusUsvojitelja + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(StatusUsvojitelja) >= 1 THEN
            StatusUsvojitelja := COPYSTR(StatusUsvojitelja, 1, STRLEN(StatusUsvojitelja) - 2);


        //ProfesionalnaNesposobnost


        ProfesionalnaNesposobnost := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER(Unproffesionality, '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2.Unproffesionality);
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2.Unproffesionality;
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ProfesionalnaNesposobnost := ProfesionalnaNesposobnost + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ProfesionalnaNesposobnost) >= 1 THEN
            ProfesionalnaNesposobnost := COPYSTR(ProfesionalnaNesposobnost, 1, STRLEN(ProfesionalnaNesposobnost) - 2);





        Smanjenje := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Partial decrease Inability", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Partial decrease Inability");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Partial decrease Inability";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                Smanjenje := Smanjenje + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Smanjenje) >= 1 THEN
            Smanjenje := COPYSTR(Smanjenje, 1, STRLEN(Smanjenje) - 2);





        //NeposretnoSmanjenje
        NeposretnoSmanjenje := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Risk of impairment", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Risk of impairment");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Risk of impairment";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                NeposretnoSmanjenje := NeposretnoSmanjenje + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(NeposretnoSmanjenje) >= 1 THEN
            NeposretnoSmanjenje := COPYSTR(NeposretnoSmanjenje, 1, STRLEN(NeposretnoSmanjenje) - 2);


        //NeposrednoInvalidnost

        NeposrednoInvalidnost := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Risk of disability", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Risk of disability");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Risk of disability";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                NeposrednoInvalidnost := NeposrednoInvalidnost + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(NeposrednoInvalidnost) >= 1 THEN
            NeposrednoInvalidnost := COPYSTR(NeposrednoInvalidnost, 1, STRLEN(NeposrednoInvalidnost) - 2);







        StepenInvalidnosti := '';

        Personaltrack2.RESET;
        EmployeeTest.DELETEALL;
        

        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Personaltrack2.SETFILTER("Level of partial disability", '<>%1', '');
        Personaltrack2.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");

        IF Personaltrack2.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Extract Additional", '%1', Personaltrack2."Level of partial disability");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Personaltrack2."Employee No.";
                    EmployeeTest."Extract Additional" := Personaltrack2."Level of partial disability";
                    EmployeeTest."Date of change" := Personaltrack2."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Personaltrack2.NEXT = 0;

        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                StepenInvalidnosti := StepenInvalidnosti + EmployeeTest."Extract Additional" + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(StepenInvalidnosti) >= 1 THEN
            StepenInvalidnosti := COPYSTR(StepenInvalidnosti, 1, STRLEN(StepenInvalidnosti) - 2);









        
        ActDate := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        //%Pers.SETFILTER("Act Date",'<>%1',0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                //%EmployeeTest.SETFILTER("Act Date",'%1',Pers."Act Date");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    //%EmployeeTest."Act Date":=Pers."Act Date";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
            //%ActDate:=ActDate+FORMAT(EmployeeTest."Act Date",0,'<Day,2>.<Month,2>.<Year4>.')+'/'+FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ActDate) >= 1 THEN
            ActDate := COPYSTR(ActDate, 1, STRLEN(ActDate) - 2);

        ActName := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Name of Act", '<>%1', '');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Name of Act", '%1', Pers."Name of Act");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Name of Act" := Pers."Name of Act";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                ActName := ActName + FORMAT(EmployeeTest."Name of Act") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(ActName) >= 1 THEN
            ActName := COPYSTR(ActName, 1, STRLEN(ActName) - 2);
        
        NumberOfAct := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        //%Pers.SETFILTER("Number of Act",'<>%1','');
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                //%EmployeeTest.SETFILTER("Number of Act",'%1',Pers."Number of Act");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    //%EmployeeTest."Number of Act":=Pers."Number of Act";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
            //%NumberOfAct:=NumberOfAct+FORMAT(EmployeeTest."Number of Act")+'/'+FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(NumberOfAct) >= 1 THEN
            NumberOfAct := COPYSTR(NumberOfAct, 1, STRLEN(NumberOfAct) - 2);
        
        Proof := 'FALSE';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Proof of doing job", '<>%1', FALSE);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Proof of doing job", '%1', Pers."Proof of doing job");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Proof of doing job" := Pers."Proof of doing job";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;

                    EmployeeTest.AutoIncrement := AutoInt;
                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                Proof := Proof + FORMAT(EmployeeTest."Proof of doing job") + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(Proof) >= 1 THEN
            Proof := COPYSTR(Proof, 1, STRLEN(Proof) - 2);
        
        DateOfChange := '';
        Pers.RESET;
        EmployeeTest.DELETEALL;
        IF Filter = '1' THEN
            Pers.SETFILTER("Employee type", '%1', 1)
        ELSE
            Pers.SETFILTER("Employee type", '<>%1', 1);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        Pers.SETFILTER("Date of change", '<>%1', 0D);
        Pers.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF Pers.FINDSET THEN
            REPEAT

                EmployeeTest.RESET;
                EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
                EmployeeTest.SETFILTER("Date of change", '%1', Pers."Date of change");
                IF NOT EmployeeTest.FINDFIRST THEN BEGIN
                    EmployeeTest.INIT;
                    EmployeeTest."Employee No." := Pers."Employee No.";
                    EmployeeTest."Date of change" := Pers."Date of change";
                    AutoInt := AutoInt + 1;
                    // EmployeeTest."Date of change":=Pers."Date of change";AutoInt:=AutoInt+1;

                    EmployeeTest.AutoIncrement := AutoInt;

                    EmployeeTest.INSERT;
                END;

            UNTIL Pers.NEXT = 0;
        EmployeeTest.RESET;
        EmployeeTest.SETFILTER("Employee No.", '%1', DataItem10."Employee No.");
        IF EmployeeTest.FINDSET THEN
            REPEAT
                DateOfChange := DateOfChange + FORMAT(EmployeeTest."Date of change", 0, '<Day,2>.<Month,2>.<Year4>.') + '/' + FORMAT(TAB);
            UNTIL EmployeeTest.NEXT = 0;
        IF STRLEN(DateOfChange) >= 1 THEN
            DateOfChange := COPYSTR(DateOfChange, 1, STRLEN(DateOfChange) - 2);

        //MESSAGE(FORMAT(ProbationFrom));
        //MESSAGE(FORMAT(ProbationTo));
        ResidenceFrom := '';
        ResidenceTo := '';
        WorkPermitFrom := '';
        WorkPermitTo := '';
        WorkPermitType := '';

    end;
}

*/