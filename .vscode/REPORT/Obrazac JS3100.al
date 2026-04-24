report 50048 "Obrazac JS3100"
{
    RDLCLayout = './Obrazac JS3100.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
            column(CompEmployeeNo; DataItem1."Employee No.")
            {
            }
            column(SBName; DataItem1.Name)
            {
            }
            column(SBCity; DataItem1.City)
            {
            }
            column(Oblig; Oblig)
            {
            }
            dataitem(DataItem10; "Employee")
            {
                RequestFilterFields = "No.";
                column(JIB; JIB)
                {
                }
                column(MunicpalityName; "Municipality Name CIPS")
                {
                }
                column(CompanyName; Name)
                {
                }
                column(CompanyAdress; AddressOrg)
                {
                }
                column(City; ORGCity)
                {
                }
                column(MunicipalityCode; Municipality)
                {
                }
                column(EmpFirstName; EmpFirstName)
                {
                }
                column(EmpLastName; EmpLastName)
                {
                }
                column(EmpBirthDate; EmpBirthDate)
                {
                }
                column(EmpID; EmpID)
                {
                }
                column(EmpGender; EmpGender)
                {
                }
                column(EmpAddress; EmpAddress)
                {
                }
                column(EmpCity; EmpCity)
                {
                }
                column(EmpPostCode; EmpPostCode)
                {
                }
                column(EmpMaidenName; EmpMaidenName)
                {
                }
                column(EmpMunicipalityCode; EmpMunicipalityCode)
                {
                }
                column(EmpEduLevel; EmpEduLevel)
                {
                }
                column(EmpVoc; EmpVoc)
                {
                }
                column(EmpHours; EmpHours)
                {
                }
                column(EmploymentDate; EmploymentDate)
                {
                }
                column(EducationLevel_pom; EducationLevel_pom)
                {
                }
                column(EmpPositionCode; EmpPositionCode)
                {
                }
                column(EmpPosition_pom; EmpPosition_pom)
                {
                }
                column(GenderVar; GenderVar)
                {
                }
                column(CompEmpFirstName; CompEmpFirstName)
                {
                }
                column(CompEmpLastName; CompEmpLastName)
                {
                }
                column(CompEmpID; CompEmpID)
                {
                }
                column(CompEmpPhoneNo; CompEmpPhoneNo)
                {
                }
                column(Address; AddressOrg)
                {
                }
                column(CityReal; CityReal)
                {
                }
                column(PostCodeReal; PostCodeReal)
                {
                }
                column(VocationDescr; VocationDescr)
                {
                }
                column(CompPhone; CompPhone)
                {
                }
                column(CompEmail; CompEmail)
                {
                }
                column(UserFullName; CompEmpFirstName)
                {
                }
                column(MunName; MunName)
                {
                }
                column(JMB; JMB)
                {
                }
                column(PostCode; PostCodee)
                {
                }
                column(Registration; Registration)
                {
                }
                column(Modification; Modification)
                {
                }
                column(Cancellation; Cancellation)
                {
                }
                column(InactiveDate; InactiveDate)
                {
                }
                column(PostCode2; PostCode2)
                {
                }
                column(TodayDate; FORMAT(DateOfReport, 0, '<Day,2>.<Month,2>.<Year4>.'))
                {
                }
                column(AddressReal; AddressReal)
                {
                }
                column(ModificationDate; ModificationDate)
                {
                }
                column(Brutto; Brutto)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CompPhoneEmployeeNo; CompPhoneEmployeeNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Org Dio");
                    DataItem10.RESET;
                    DataItem10.SETFILTER("No.", '%1', EmpNo);
                    IF DataItem10.FINDFIRST THEN BEGIN
                        EmpFirstName := DataItem10."First Name";
                        EmpLastName := DataItem10."Last Name";
                        EmpBirthDate := DataItem10."Birth Date";
                        EmpID := DataItem10."Employee ID";
                        EmpGender := DataItem10.Gender.AsInteger();
                        EmpAddress := DataItem10."Address CIPS";
                        EmpCity := DataItem10."City CIPS";
                        EmpPostCode := DataItem10."Post Code CIPS";
                        EmpMaidenName := DataItem10."Maiden Name";
                        EmpMunicipalityCode := DataItem10."Municipality Code CIPS";
                        EmpEduLevel := DataItem10."Education Level".AsInteger();
                        EmpHours := DataItem10."Hours In Day";
                        IF DataItem10."Municipality Code" <> '' THEN
                            PostCode2 := DataItem10."Post Code"
                        ELSE
                            PostCode2 := '00000';
                        //EmpPositionCode:=DataItem10."Position Code";
                        PostCodeReal := DataItem10."Post Code";
                        AddressReal := DataItem10.Address;
                        CityReal := DataItem10.City;
                        /* CompPhone:=DataItem10."Phone No.";
                        CompEmail:=DataItem10."E-Mail";*/
                        DataItem1.GET;
                        CompEmail := DataItem1."Operater E-mail";
                        CompPhone := DataItem1."Operater No";
                        CompPhoneEmployeeNo := DataItem10."Phone No.";

                    END;
                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", '%1', EmpNo);
                    EmployeeContractLedger.SETFILTER("No.", '%1', ECLNO);
                    IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                        EmployeeContractLedger.CALCFIELDS("Department City");
                        IF EmployeeContractLedger."Org Unit Name" <> '' THEN
                            Oblig := DataItem1."Name 2" + ' ' + ',' + EmployeeContractLedger."Org Unit Name";


                        IF (EmployeeContractLedger."GF of work Description" <> '') AND (STRPOS(EmployeeContractLedger."Department City", DataItem1.City) <> 0) THEN
                            Oblig := EmployeeContractLedger."GF of work Description";

                        IF (EmployeeContractLedger."GF of work Description" <> '') AND (STRPOS(EmployeeContractLedger."Department City", DataItem1.City) = 0) THEN
                            Oblig := DataItem1."Name 2" + ' ' + ',' + DataItem1."Prefix for JS" + ' ' + EmployeeContractLedger."Department City";
                    END;
                    EmployeeContractLedger.RESET;
                    /* EmployeeContractLedger.SETFILTER("Employee No.","No.");
                     EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);*/
                    EmployeeContractLedger.SETFILTER("No.", '%1', ECLNO);
                    EmployeeContractLedger.SETFILTER("Employee No.", '%1', EmpNo);
                    IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                        EmpPositionCode := EmployeeContractLedger."Position Code";
                        "ORG Dijelovi".SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        "ORG Dijelovi".SETFILTER(GF, '%1', EmployeeContractLedger."GF rada code");
                        IF "ORG Dijelovi".FINDFIRST THEN BEGIN
                            IF "ORG Dijelovi"."ORG ID" <> '' THEN
                                JIB := "ORG Dijelovi"."ORG ID"
                            ELSE
                                JIB := "ORG Dijelovi"."Registration No.";

                            Name := "ORG Dijelovi".Description;
                            AddressOrg := "ORG Dijelovi".Address;
                            IF Registration = TRUE THEN
                                Brutto := EmployeeContractLedger.Brutto
                            ELSE
                                Brutto := 0;
                            Position.SETFILTER("Org. Structure", '%1', EmployeeContractLedger."Org. Structure");
                            Position.SETFILTER(Code, '%1', EmployeeContractLedger."Position Code");
                            Position.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                            Position.SETFILTER(Description, '%1', EmployeeContractLedger."Position Description");
                            //Position.SETFILTER("Position ID",'%1',EmployeeContractLedger."Position ID");
                            IF Position.FIND('-') THEN BEGIN
                                VocationDescr := Position.Description;
                                IF Position."Vocation Description" <> '' THEN
                                    EmpVoc := Position.Vocation
                                ELSE
                                    EmpVoc := Text000;

                            END
                            ELSE BEGIN
                                EmpVoc := Text000;
                                VocationDescr := '';
                            END;
                        END
                        ELSE BEGIN
                            EmpVoc := Text000;
                            VocationDescr := '';
                        END;
                        IF VocationDescr = '' THEN
                            VocationDescr := EmployeeContractLedger."Position Description";

                        //MESSAGE(EmpVoc);
                        ORGCity := "ORG Dijelovi".City;
                        PostCodee := "ORG Dijelovi"."Post Code";
                        Municipality := "ORG Dijelovi"."Municipality Code of agency";
                    END;
                    Mun.SETFILTER(Code, Municipality);
                    IF Mun.FINDFIRST THEN
                        MunName := Mun.Name;
                    IF Gender.AsInteger() = 1 THEN
                        GenderVar := TRUE
                    ELSE
                        GenderVar := FALSE;
                    if "Education Level".AsInteger() in [1, 2, 3, 4] then
                        EducationLevel_pom := 'Niža';
                    if "Education Level".AsInteger() in [5, 6, 7] then
                        EducationLevel_pom := 'SSS';
                    if "Education Level".AsInteger() = 8 then
                        EducationLevel_pom := 'KV';
                    if "Education Level".AsInteger() in [9, 10] then
                        EducationLevel_pom := 'VKV';
                    if "Education Level".AsInteger() = 11 then
                        EducationLevel_pom := 'VŠS';
                    if "Education Level".AsInteger() in [12, 13, 14] then
                        EducationLevel_pom := 'VSS';
                    if "Education Level".AsInteger() in [15, 16, 17] then
                        EducationLevel_pom := 'MR';
                    if "Education Level".AsInteger() in [18, 19] then
                        EducationLevel_pom := 'DR';

                    /*   CASE "Education Level" OF
                          "Education Level".AsInteger()=1:
                               EducationLevel_pom := 'Niža';
                           "Education Level"::"II Stepen - osnovna škola":
                               EducationLevel_pom := 'Niža';
                           "Education Level"::"III Stepen - SSS srednja škola":
                               EducationLevel_pom := 'SSS';
                           "Education Level"::"IV Stepen - SSS srednja škola":
                               EducationLevel_pom := 'SSS';
                           "Education Level"::"V Stepen - VKV - SSS srednja škola":
                               EducationLevel_pom := 'VKV';
                           "Education Level"::"VI Stepen - VS viša škola":
                               EducationLevel_pom := 'VŠS';
                           "Education Level"::"VII Stepen - VSS visoka stručna sprema":
                               EducationLevel_pom := 'VSS';
                           "Education Level"::"VII-1 Stepen - Specijalista":
                               EducationLevel_pom := 'VSS';
                           "Education Level"::"VII-2 Stepen - Magistratura":
                               EducationLevel_pom := 'MR';
                           "Education Level"::"VIII Stepen - Doktorat  ":
                               EducationLevel_pom := 'DR';
   */

                    //END;
                    //ECL.SETFILTER("Employee No.","No.);
                    ECL.SETFILTER("Employee No.", '%1', EmpNo);
                    ECL.SETFILTER("No.", '%1', ECLNO);
                    IF ECL.FINDLAST THEN BEGIN
                        IF ECL."Ending Date" = 0D THEN
                            InactiveDate := 19730101D
                        ELSE
                            InactiveDate := ECL."Ending Date"
                    END;
                    EmploymentDate := 0D;
                    IF Modification <> TRUE THEN BEGIN
                        ECL1.RESET;
                        ECL1.SETFILTER("Employee No.", "No.");
                        //ECL1.SETFILTER(Active,'%1',TRUE);
                        ECL1.SETFILTER("No.", '%1', ECLNO);
                        IF ECL1.FINDLAST THEN BEGIN
                            EmploymentDate := ECL1."Starting Date"
                        END
                        ELSE BEGIN
                            EmploymentDate := 0D;
                        END;
                    END;
                    IF Modification = TRUE THEN
                        EmploymentDate := ModificationDate;

                end;

                trigger OnPreDataItem()
                begin
                    IF (Modification AND (ModificationDate = 0D))
                      THEN
                        ERROR('Potrebno je unijeti datum promjene!');
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateOfReport; DateOfReport)
                {
                    Caption = 'Date Of Report';
                    ApplicationArea = all;
                }
                field(Registration; Registration)
                {
                    ApplicationArea = all;
                    Caption = 'Insurance Registration';
                }
                field(Modification; Modification)
                {
                    ApplicationArea = all;
                    Caption = 'Insurance Modification';
                }
                field(ModificationDate; ModificationDate)
                {
                    ApplicationArea = all;
                    Caption = 'Modification Date';
                }
                field(Cancellation; Cancellation)
                {
                    ApplicationArea = all;
                    Caption = 'Insurance Cancelation';
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

    trigger OnInitReport()
    begin
        DateOfReport := TODAY;
        Registration := TRUE;
    end;

    trigger OnPostReport()
    begin
        //MESSAGE(FORMAT(EmpVoc));
    end;

    var
        EducationLevel_pom: Text;
        EmpPosition_pom: Text;
        Position: Record "Position";
        GenderVar: Boolean;
        PomInteger: Integer;
        PomBool: Boolean;
        CompEmployee: Record "Employee";
        CompEmpFirstName: Text;
        CompEmpLastName: Text;
        CompEmpPhoneNo: Text;
        CompEmpID: Text;
        EmpVoc: Text;
        EmploymentDate: Date;
        wb: Record "Work Booklet";
        AddEdd: Record "Additional Education";
        "ORG Dijelovi": Record "ORG Dijelovi";
        JIB: Text;
        Name: Text;
        AddressOrg: Text;
        ORGCity: Text;
        Municipality: Code[10];
        EmpAddress: Text;
        AlternativeAddress: Record "Alternative Address";
        VocationRecord: Record "Vocation";
        VocationDescr: Text;
        UP: Record "User";
        Phone: Text;
        EMail: Text;
        Mun: Record "Municipality";
        MunName: Text;
        JMB: Text;
        PostCodee: Code[10];
        Registration: Boolean;
        Cancellation: Boolean;
        Modification: Boolean;
        ECL: Record "Employee Contract Ledger";
        InactiveDate: Date;
        ECL1: Record "Employee Contract Ledger";
        PostCode2: Code[10];
        AAL: Record "Alternative Address";
        PostCodeCIPS: Code[10];
        TodayDate: Date;
        DateText: Text[20];
        Employee2: Record "Employee";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        ModificationDate: Date;
        DateOfReport: Date;
        Brutto: Decimal;
        Pos: Record "Position";
        Text000: Label 'XXXXXXXX';
        ECLNO: Integer;
        EmpNo: Code[10];
        EmpFirstName: Text;
        EmpLastName: Text;
        EmpBirthDate: Date;
        EmpID: Code[13];
        EmpGender: Integer;
        EmpCity: Text[250];
        EmpPostCode: Code[30];
        EmpMaidenName: Text[250];
        EmpMunicipalityCode: Code[30];
        EmpEduLevel: Integer;
        EmpHours: Integer;
        EmpPositionCode: Code[30];
        PostCodeReal: Code[30];
        AddressReal: Text;
        CityReal: Text[208];
        CompPhone: Text;
        CompEmail: Text;
        CompPhoneEmployeeNo: Text;
        Oblig: Text;

    procedure SetParam(EmployeeNo: Code[10]; EntryNo: Integer)
    begin

        ECLNO := EntryNo;
        EmpNo := EmployeeNo;
    end;
}

