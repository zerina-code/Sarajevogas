report 50054 "Izvjestaj za trening"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Izvjestaj za trening.rdl';
    PreviewMode = Normal;

    dataset

    {

        dataitem(DataItem1; "Employee Qualification")
        {

            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';


            RequestFilterFields = "From Date";

            column(Employee_No; "Employee No.")
            {

            }

            column(EmployeeNo; EmployeeNo)
            {

            }
            column(EmployeeFirstName_EmployeeQualification; "Employee First Name")
            {
            }
            column(EmployeeLastName_EmployeeQualification; "Employee Last Name")
            {
            }
            column(InstitutionCompany_EmployeeQualification; "Institution/Company")
            {
            }
            column(ToDate_EmployeeQualification; "To Date")
            {
            }
            column(Datum; Datum)
            {
            }
            column(Status_EmployeeQualification; Status)
            {
            }
            column(ProofOfEducation_EmployeeQualification; "Evidence of certification")
            {
            }
            column(ExpirationDate_EmployeeQualification; FORMAT("Expiration Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(Type_EmployeeQualification; Type)
            {
            }
            column(Department_Code; EmployeeContractLedger."Department Code")
            {
                IncludeCaption = true;
            }
            column(Picture; CompInfo.Picture)
            {
                IncludeCaption = true;
            }
            column(Adress; CompInfo.Address)
            {
                IncludeCaption = true;
            }
            column(City; CompInfo.City)
            {
                IncludeCaption = true;
            }
            column(PhoneNo; CompInfo."Phone No.")
            {
                IncludeCaption = true;
            }
            column(Name; CompInfo.Name)
            {
            }
            column(IDBr; CompInfo."Registration No.")
            {
            }
            column(QualificationCode_EmployeeQualification; "Qualification Code")
            {
            }
            column(Description_EmployeeQualification; "Description2")
            {
            }

            column(EducationName; EducationName)
            {

            }

            column(VrstaIzvjestaja; VrstaIzvjestaja)
            {

            }

            column(NumberOfParticipants; NumberOfParticipants)
            {

            }

            column(TotalNumberOfParticipants; TotalNumberOfParticipants)
            {

            }

            column(RowCounter; RowCounter)
            {

            }

            column(DatumStart; DatumStart)
            {

            }

            column(DatumEnd; DatumEnd)
            {

            }

            column(EducationCode; EducationCode)
            {

            }




            trigger OnAfterGetRecord()
            begin

                if (SelectedIzvjestaj = SelectedIzvjestaj::"Izvještaj za trening") then begin
                    VrstaIzvjestaja := 'Izvještaj za trening';
                end
                else
                    if (SelectedIzvjestaj = SelectedIzvjestaj::"Obuke na koje su upućivani radnici") then begin
                        VrstaIzvjestaja := 'Obuke na koje su upućivani radnici';
                    end
                    else begin
                        VrstaIzvjestaja := '';
                    end;

                if (VrstaIzvjestaja = 'Izvještaj za trening') then begin

                    DataItem1.CALCFIELDS("Employee First Name", "Employee Last Name");

                    //ZA DATUM DA ISPISE IME MJESECA I GODINU
                    Datum := FORMAT("To Date", 0, '<Month Text> <year4>');
                    //TimePeriod := FORMAT("To Date", 0, '<Month Text> <year4>');

                    IF "Evidence of certification" = "Evidence of certification"::Empty THEN
                        VarDokazEdukacije := ' '
                    ELSE
                        IF "Evidence of certification" = "Evidence of certification"::Certifikat THEN
                            VarDokazEdukacije := 'Certifikat'
                        ELSE
                            IF "Evidence of certification" = "Evidence of certification"::Atest THEN
                                VarDokazEdukacije := 'Atest'
                            ELSE
                                IF "Evidence of certification" = "Evidence of certification"::Uvjerenje THEN
                                    VarDokazEdukacije := 'Uvjerenje'
                                ELSE
                                    VarDokazEdukacije := 'Potvrda';

                    CompInfo.GET;
                    CompInfo.CALCFIELDS(Picture);


                    //EmployeeContractLedger.GET;
                    //ZA OJ
                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", '%1', "Employee No.");
                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                    if DataItem1."To Date" <> 0D then
                        EmployeeContractLedger.SetFilter("Ending Date", '<=%1|%2', DataItem1."To Date", 0D);
                    /*if DatumStart <> 0D then
                        EmployeeContractLedger.SetFilter("Ending Date", '<=%1|%2', DatumEnd, 0D);*/
                    EmployeeContractLedger.SetCurrentKey("Starting Date");

                    EmployeeContractLedger.Ascending;
                    IF EmployeeContractLedger.FindLast() THEN BEGIN
                        DepartmentCode := EmployeeContractLedger."Department Code";
                    END;


                    /*InputDate:="Employee Qualification"."To Date";
                    Month:=DATE2DMY(InputDate,2);
                    Year:=DATE2DMY(InputDate,3);*/


                    //var :="Employee Qualification"."To Date";
                    //Mjesec := DATE2DMY(var,2);
                    //Godina := DATE2DMY(var,2);
                    //MESSAGE(Text000,Mjesec,Godina);

                    //IF("Employee Qualification"."To Date") THEN
                    //MESSAGE("Januar");
                    //ELSE
                    //MESSAGE("Decembar");

                    //SifraKvalifikacije:='';

                    /*IF SifraKvalifikacije.FINDFIRST THEN
                      VarSifra:=SifraKvalifikacije;
                    ELSE
                      SifraKvalifikacije.DELETE;*/

                    /*IF "Employee Qualification"."Qualification Code".FINDFIRST THEN
                      SifraKvalifikacije:="Employee Qualification"."Qualification Code";
                    ELSE
                      SifraKvalifikacije:='';*/


                    /*Sales.SETRANGE("Posting Description", 'Test'); Sales.SETFILTER(Amount, '=%1', 0); IF Sales.FIND('-') THEN Sales.DELETEALL;*/
                end;
                //else
                if (VrstaIzvjestaja = 'Obuke na koje su upućivani radnici') then begin
                    //Datum := DataItem1.GetFilter("From Date");

                    EmpTrainingLedg.Reset();
                    EmpTrainingLedg.SetFilter("Employee No.", '%1', DataItem1."Employee No.");
                    if EmpTrainingLedg.FindSet() then begin
                        EducationName := EmpTrainingLedg.Name;
                        EducationCode := EmpTrainingLedg.Code2Entry;
                    end;

                    if EducationCode <> EducationCodePrevious then begin
                        RowCounter += 1;
                    end;
                    EducationCodePrevious := EducationCode;


                    if (Datum2 <> '') then begin
                        //SetCurrentKey(Description2);
                        //Ascending(true);
                        Evaluate(DatumStart, Datum2, 8);
                        Evaluate(DatumEnd, CopyStr(Datum2, 11));

                        /*EmpTrainingLedg.Reset();
                        EmpTrainingLedg.SetFilter(Name, '%1', DataItem1.Description2);
                        if EmpTrainingLedg.FindSet() then begin
                            EmployeeNo := EmpTrainingLedg."Employee No.";
                        end;*/

                        /*EmpTrainingLedg.Reset();
                        EmpTrainingLedg.SetFilter("Name", '%1', DataItem1.Description2);
                        EmpTrainingLedg.SetFilter("Start date of certificate", '<=%1', DatumEnd);
                        //EmpTrainingLedg.SetCurrentKey("Start date of certificate");
                        //EmpTrainingLedg.Ascending(true);
                        if EmpTrainingLedg.FindSet() then begin
                            EducationName := EmpTrainingLedg.Name;
                            EducationCode := EmpTrainingLedg.Code2Entry;
                        end;*/

                        /*if EducationCode <> EducationCodePrevious then begin
                            RowCounter += 1;
                        end;
                        */
                        EducationCodePrevious := EducationCode;

                        TrainingTimeEntry.Reset();
                        TrainingTimeEntry.SetFilter("Start date", '>=%1', DatumStart);
                        TrainingTimeEntry.SetFilter("End date", '<=%1', DatumEnd);
                        TrainingTimeEntry.SetFilter(Name, '%1', EducationName);
                        if TrainingTimeEntry.FindSet() then begin
                            TrainingTimeEntry.CalcFields("Number of people attended");
                            NumberOfParticipants := TrainingTimeEntry."Number of people attended";
                        end
                        else begin
                            NumberOfParticipants := 0;
                        end;

                        TrainingTimeEntry.Reset();
                        TrainingTimeEntry.SetFilter("Start date", '>=%1', DatumStart);
                        TrainingTimeEntry.SetFilter("End date", '<=%1', DatumEnd);
                        if TrainingTimeEntry.FindSet() then
                            repeat
                                TrainingTimeEntry.CalcFields("Number of people attended");
                                TotalNumberOfParticipants += TrainingTimeEntry."Number of people attended";
                            until TrainingTimeEntry.Next() = 0;

                    end
                    else begin

                        /*EmpTrainingLedg.Reset();
                        EmpTrainingLedg.SetFilter("Employee No.", '%1', DataItem1."Employee No.");
                        if EmpTrainingLedg.FindSet() then begin
                            EducationName := EmpTrainingLedg.Name;
                            EducationCode := EmpTrainingLedg.Code2Entry;
                        end;

                        if EducationCode <> EducationCodePrevious then begin
                            RowCounter += 1;
                        end;
                        EducationCodePrevious := EducationCode;*/

                        TrainingTimeEntry.Reset();
                        TrainingTimeEntry.SetFilter(Name, '%1', EducationName);
                        if TrainingTimeEntry.FindSet() then begin
                            TrainingTimeEntry.CalcFields("Number of people attended");
                            NumberOfParticipants := TrainingTimeEntry."Number of people attended";
                        end
                        else begin
                            NumberOfParticipants := 0;
                        end;

                        TrainingTimeEntry.Reset();
                        if TrainingTimeEntry.FindSet() then
                            repeat
                                TrainingTimeEntry.CalcFields("Number of people attended");
                                TotalNumberOfParticipants += TrainingTimeEntry."Number of people attended";
                            until TrainingTimeEntry.Next() = 0;
                    end;
                end;

            end;

            trigger OnPreDataItem()

            begin
                SETFILTER("Qualification Code", '<>%1', '');

                RowCounter := 0;
                NumberOfParticipants := 0;
                TotalNumberOfParticipants := 0;
                EducationNamePrevious := '';
                EducationName := '';
                EducationCodePrevious := 0;
                EmployeeNoPrevious := '';
                //SETFILTER(Type,'%1',"Employee Qualification"."Qualification Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(SelectedIzvjestaj; SelectedIzvjestaj)
                    {
                        Caption = 'Izbor izvještaja:';
                        OptionCaption = ' ,Izvještaj za trening,Obuke na koje su upućivani radnici';
                    }

                }

                group("Unesite period za obuke")
                {
                    Caption = 'Unesite period za obuke';
                    field(Datum2; Datum2)
                    {
                        ApplicationArea = All;
                        Caption = 'Od datuma..do datuma';
                    }

                }

            }
        }

        actions
        {
        }
    }


    labels
    {
        RptTitle = 'LISTA INDIKATORA ZA EDUKACIJE I TRENINGE';
    }

    trigger OnPreReport()
    begin
        if (SelectedIzvjestaj = SelectedIzvjestaj::" ") then begin
            Error('Izbor izještaja je obavezan')
        end;
    end;

    var
        InputDate: Date;
        Month: Integer;
        Date: Integer;
        Year: Integer;
        Datum: Text;
        VarDokazEdukacije: Text;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        DepartmentCode: Code[10];
        CompInfo: Record "Company Information";
        SifraKvalifikacije: Record "Employee Qualification";
        VarSifra: Record "Employee Qualification";
        VrstaIzvjestaja: Text[250];
        SelectedIzvjestaj: Option " ","Izvještaj za trening","Obuke na koje su upućivani radnici";
        TrainingCatalogue: Record "Training Catalogue";
        EmpTrainingLedg: Record "Employee Training Ledger";
        TrainingTimeEntry: Record "Training Time Entry";
        EducationName: Text[250];
        EducationNamePrevious: Text[250];
        RowCounter: Integer;
        NumberOfParticipants: Integer;
        EmployeeNo: Code[20];
        TotalNumberOfParticipants: Integer;
        TimePeriod: Text[50];
        DatumStart: Date;
        DatumEnd: Date;
        EmployeeQualification: Record "Employee Qualification";
        EducationCode: Integer;
        EducationCodePrevious: Integer;
        EmployeeNoPrevious: Code[20];
        Datum2: Text;
}

