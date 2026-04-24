report 50049 "Obrazac PD3100"
{
    // //
    // //
    RDLCLayout = './Obrazac PD3100.rdlc';

    DefaultLayout = RDLC;

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
            column(JIB; JIB)
            {
            }
            column(CompanyName; Name)
            {
            }
            column(CompanyAdress; AddressOrg)
            {
            }
            column(PostCode; DataItem1."Post Code")
            {
            }
            column(MunicipalityCode; MunicipalityCode)
            {
            }
            column(City; DataItem1.City)
            {
            }
            column(CompEmail; DataItem1."Operater E-mail")
            {
            }
            column(CompPhone; DataItem1."Operater No")
            {
            }
            column(CompEmployeeNo; DataItem1."Employeess No.")
            {
            }
            column(Oblig; Oblig)
            {
            }
            column(Changed; Changed)
            {
            }
            column(Basic; Basic)
            {
            }
            dataitem(DataItem10; "Employee")
            {
                RequestFilterFields = "No.";
                column(BrutoIznos; BrutoIznos)
                {
                }
                column(EmpFirstName; EmpFirstName)
                {
                }
                column(Zanimanje; Zanimanje)
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
                column(EmpMunicipalityCode; EmpMunicipalityCode)
                {
                }
                column(EmpEduLevel; EmpEduLevel)
                {
                }
                column(EmpVoc; EmpVoc)
                {
                }
                column(EmpEmail; EmpEmail)
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
                column(Today; FORMAT(Today2))
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
                column(EmpMaidenName; EmpMaidenName)
                {
                }
                column(SvrhaDoprinosa; SvrhaDoprinosa)
                {
                }
                column(FirstNumber; FirstNumber)
                {
                }
                column(SecondNumber; SecondNumber)
                {
                }
                column(Registration; Registration)
                {
                }
                column(Cancellation; Cancellation)
                {
                }
                column(Promjena; Modification)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    DataItem10.RESET;
                    DataItem10.SETFILTER("No.", '%1', EmployeeNo);
                    IF DataItem10.FINDFIRST THEN BEGIN
                        EmpFirstName := DataItem10."First Name";
                        EmpLastName := DataItem10."Last Name";
                        EmpBirthDate := DataItem10."Birth Date";
                        EmpID := DataItem10."Employee ID";
                        EmpGender := DataItem10.Gender.AsInteger();
                        EmpAddress := DataItem10."Address CIPS";
                        EmpCity := DataItem10.City;
                        EmpPostCode := DataItem10."Post Code";

                        EmpMunicipalityCode := DataItem10."Municipality Code CIPS";
                        IF EmpMunicipalityCode = '' THEN
                            EmpMunicipalityCode := '000';
                        EmpEduLevel := DataItem10."Education Level".AsInteger();
                        EmpEmail := DataItem10."E-Mail";
                        EmpHours := DataItem10."Hours In Day";
                        //EmploymentDate:=DataItem10."Employment Date";
                        EmploymentDate := EmployeeContractLedger."Starting Date";
                        IF Modification = TRUE THEN
                            EmploymentDate := ModificationDate;
                        IF Cancellation = TRUE THEN
                            EmploymentDate := EmployeeContractLedger."Ending Date";
                        EmpPositionCode := DataItem10."Position Code";
                        EmpMaidenName := DataItem10."Maiden Name";
                        EmployeeContractLedger.CALCFIELDS("Org Entity Code");
                        EntityOrg := EmployeeContractLedger."Org Entity Code";
                    END;

                    AA.RESET;
                    AA.SETFILTER("Employee No.", '%1', EmployeeNo);
                    AA.SETFILTER(Active, '%1', TRUE);
                    IF AA.FINDFIRST THEN BEGIN
                        EntityAA := AA."Entity Code CIPS";
                    END;
                    IF EntityAA <> EntityOrg THEN BEGIN
                        IF EntityOrg = 'RS' THEN BEGIN
                            SvrhaDoprinosa := 'ÔáŽďĚ ÍŽďÍŃ Ńá ˇŽßáŰŃňŰĘďĚĎ ÍŃĚČšßáĺĘĎ š źúĚÂ/úßűĂÍĎ';
                            FirstNumber := '3';
                            SecondNumber := '9'
                        END
                        ELSE BEGIN
                            SvrhaDoprinosa := 'ÔáŽďĚ ÍŽďÍŃ š źúĚÂ/úßűĂÍĎ Ńá ˇŽßáŰŃňŰĘďĚĎ ÍŃĚČšßáĺĘĎ š PC';
                            FirstNumber := '4';
                            SecondNumber := '1'
                        END;
                    END
                    ELSE BEGIN
                        SvrhaDoprinosa := 'ÔáŽďĚ ÍŽďÍŃ';
                        FirstNumber := '0';
                        SecondNumber := '1';
                    END;

                    IF Gender.AsInteger() = 1 THEN
                        GenderVar := TRUE
                    ELSE
                        GenderVar := FALSE;

                    /*  CASE "Education Level" of

                          "Education Level"::"I Stepen četri razreda osnovne":
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
                      END;*/

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

                    Position.SETRANGE(Position.Code, "Position Code");
                    IF Position.FIND('-') THEN
                        PomInteger := Position."Education Level";

                    CASE PomInteger OF
                        1:
                            EmpPosition_pom := 'Niža';
                        2:
                            EmpPosition_pom := 'NK';
                        3:
                            EmpPosition_pom := 'KV';
                        4:
                            EmpPosition_pom := 'SSS';
                        5:
                            EmpPosition_pom := 'VKV';
                        6:
                            EmpPosition_pom := 'VŠS';
                        7:
                            EmpPosition_pom := 'VSS';
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    EmpPosition_pom := 'VSS';
                    //END;
                    IF Modification = TRUE THEN
                        EmploymentDate := ModificationDate;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompEmployee.SETRANGE(CompEmployee."No.", DataItem1."Employeess No.");
                IF CompEmployee.FIND('-') THEN BEGIN
                    CompEmpFirstName := CompEmployee."First Name";
                    CompEmpLastName := CompEmployee."Last Name";
                    CompEmpPhoneNo := CompEmployee."Phone No.";
                    CompEmpID := CompEmployee."Employee ID";
                END;

                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", '%1', EmployeeNo);
                EmployeeContractLedger.SETFILTER("No.", '%1', BrStavke);
                IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                    Zanimanje := EmployeeContractLedger."Position Description";
                    IF Registration = TRUE THEN BEGIN
                        BrutoIznos := EmployeeContractLedger.Brutto;
                    END
                    ELSE BEGIN
                        BrutoIznos := 0;
                    END;
                    EmployeeContractLedger.CALCFIELDS("Department City");
                    OrgDijelovi.RESET;
                    IF EmployeeContractLedger."GF of work Description" <> '' THEN
                        OrgDijelovi.SETFILTER(GF, '%1', EmployeeContractLedger."GF rada code")
                    ELSE
                        OrgDijelovi.SETFILTER(Code, '%1', EmployeeContractLedger."Org Dio");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        JIB := OrgDijelovi."ORG ID";
                        MunicipalityCode := OrgDijelovi."Municipality Code";
                        Name := OrgDijelovi.Description;
                        AddressOrg := OrgDijelovi.Address;
                    END
                    ELSE BEGIN
                        JIB := '';
                        Name := '';
                        AddressOrg := '';
                    END;

                    IF EmployeeContractLedger."Org Unit Name" <> '' THEN
                        Oblig := DataItem1."Name 2" + ' ' + ',' + EmployeeContractLedger."Org Unit Name";


                    IF (EmployeeContractLedger."GF of work Description" <> '') AND (STRPOS(EmployeeContractLedger."Department City", DataItem1.City) <> 0) THEN
                        Oblig := EmployeeContractLedger."GF of work Description";

                    IF (EmployeeContractLedger."GF of work Description" <> '') AND (STRPOS(EmployeeContractLedger."Department City", DataItem1.City) = 0) THEN
                        Oblig := DataItem1."Name 2" + ' ' + ',' + DataItem1."Prefix for JS" + ' ' + EmployeeContractLedger."Department City";
                END;
                Position.RESET;
                Position.SETFILTER("Org. Structure", '%1', EmployeeContractLedger."Org. Structure");
                Position.SETFILTER(Code, '%1', EmployeeContractLedger."Position Code");
                Position.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                Position.SETFILTER(Description, '%1', EmployeeContractLedger."Position Description");
                Position.SETFILTER("Position ID", '%1', EmployeeContractLedger."Position ID");
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
                IF VocationDescr = '' THEN
                    VocationDescr := EmployeeContractLedger."Position Description";
            end;

            trigger OnPreDataItem()
            begin
                IF (Registration = TRUE) OR (Cancellation = TRUE) THEN BEGIN
                    Basic := 'X';
                    Changed := '';
                END ELSE
                    IF Modification = TRUE THEN BEGIN
                        Basic := '';
                        Changed := 'X';
                    END;
            end;
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
                    ApplicationArea = all;
                    Caption = 'Date Of Report';
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
        Registration := TRUE;
        DateOfReport := TODAY;
        Today2 := TODAY;
    end;

    var
        EducationLevel_pom: Text;
        EmpPosition_pom: Text;
        Position: Record "Position";
        OrgDijelovi: Record "ORG Dijelovi";
        GenderVar: Boolean;
        AddressOrg: Text;
        JIB: Text;
        PomInteger: Integer;
        MunicipalityCode: Code[10];
        PomBool: Boolean;
        CompEmployee: Record "Employee";
        CompEmpFirstName: Text;
        CompEmpLastName: Text;
        CompEmpPhoneNo: Text;
        Today2: Date;
        CompEmpID: Text;
        EmpVoc: Text;
        EmploymentDate: Date;
        BrutoIznos: Decimal;
        Zanimanje: Text;
        wb: Record "Work Booklet";
        EmployeeNo: Code[10];
        EmpFirstName: Text;
        EmpLastName: Text;
        EmpBirthDate: Date;
        EmpID: Code[13];
        EmpGender: Integer;
        Name: Text;
        EmpAddress: Text;
        EmpCity: Text;
        EmpPostCode: Code[20];
        EmpEduLevel: Integer;
        EmpEmail: Text;
        EmpHours: Integer;
        EmpPositionCode: Code[30];
        EmpMaidenName: Text;
        EmpMunicipalityCode: Code[10];
        CompInfo: Record "Company Information";
        SvrhaDoprinosa: Text;
        AA: Record "Alternative Address";
        EntityAA: Code[10];
        EntityOrg: Code[10];
        FirstNumber: Code[10];
        SecondNumber: Code[10];
        DateOfReport: Date;
        Registration: Boolean;
        Modification: Boolean;
        ModificationDate: Date;
        Cancellation: Boolean;
        Oblig: Text;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        BrStavke: Integer;
        ROFist: Code[10];
        ROSecond: Code[10];
        RO: Text[250];
        VocationDescr: Text;
        Text000: Label 'XXXXXXXX';
        Changed: Text;
        Basic: Text;

    procedure SetParam(EmpNo: Code[10]; "Code": Integer)
    begin
        EmployeeNo := EmpNo;
        BrStavke := Code;
    end;
}

