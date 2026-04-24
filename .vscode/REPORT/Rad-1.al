report 50070 "Rad-1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Rad-1.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(SF1; Integer)
        {
            MaxIteration = 1;
            column(Ukupno; output[1] [1])
            {
            }
            column(UkupnoZene; output[1] [2])
            {
            }
            column(UkupnoDosli; output[2] [1])
            {
            }
            column(ZeneDosli; output[2] [2])
            {
            }
            column(UkupnoOtisli; output[3] [1])
            {
            }
            column(ZeneOtisli; output[3] [2])
            {
            }
            column(UkupnoMart; output[4] [1])
            {
            }
            column(ZeneMart; output[4] [2])
            {
            }
            column(PripravniciUK; output[5] [1])
            {
            }
            column(PripravniciZene; output[5] [2])
            {
            }
            column(NazivKomp; CompInfo.Name)
            {
            }
            column(JIB; CompInfo."VAT Registration No.")
            {
            }
            column(AdresaKomp; CompInfo.Address)
            {
            }
            column(TelefonKomp; CompInfo."Phone No.")
            {
            }
            column(DjelatnostKomp; CompInfo."Industrial Classification")
            {
            }
            column(Name2; CompInfo."Name 2")
            {
            }
            column(KompKanton; Kanton)
            {
            }
            column(KompOpcina; Opcina)
            {
            }
            column(LastDateOfMonth; LastDateOfMonth)
            {
            }
            column(DayBeforeFirstDate; DayBeforeFirstDate)
            {
            }
            column(Monthlbl; Monthlbl)
            {
            }
            column(OrgName; OrgName)
            {
            }
            column(OrgID; OrgID)
            {
            }
            column(OrgAddress; OrgAddress)
            {
            }
            column(OrgTelephone; OrgTelephone)
            {
            }
            column(OrgJIB; OrgJIB)
            {
            }
            column(OrgJIBName; OrgJIBName)
            {
            }
            column(BROJAC; BROJAC)
            {
            }
            column(Telefon; Telefon)
            {
            }
            column(emaill; emaill)
            {
            }
            column(Dateof; FORMAT(Dateof, 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                BROJAC := BROJAC + 1;
                /*CompCanton.SETFILTER(Code,'%1',CompInfo.County);
                IF CompCanton.FINDFIRST THEN
                  Kanton:=CompCanton.Description;
                
                
                
                IF CompMunicipality.FIND('-')  THEN
                REPEAT
                 IF CompInfo."Municipality Code" = CompMunicipality.Code THEN
                       Opcina:=CompMunicipality.Name;
                UNTIL CompMunicipality.NEXT=0;*/


                Org.SETFILTER("Municipality Code", '%1', Municipality);
                Org.SETFILTER(Description, '%1', OrgJeddd);
                Org.SETFILTER(Active, '%1', TRUE);
                IF Org.FINDFIRST THEN BEGIN
                    OrgName := Org.Description;
                    OrgID := Org."ORG ID";
                    OrgAddress := Org.Address;
                    OrgTelephone := Org.Telephone;
                    OrgJIB := Org."Industrial Classification";
                    OrgJIBName := Org."Industrial Classification Name";
                END;

                IF OrgID = '' THEN
                    OrgID := '                                  ';
                IF OrgJIB = '' THEN
                    OrgJIB := '      ';

                CompMunicipality.SETFILTER(Code, '%1', Municipality);
                IF CompMunicipality.FINDFIRST THEN BEGIN
                    Opcina := CompMunicipality.Name;
                    PostCode.SETFILTER(City, '%1', CompMunicipality.City);
                    IF PostCode.FINDFIRST THEN BEGIN
                        CompCanton.SETFILTER(Code, '%1', PostCode."Canton Code");
                        IF CompCanton.FINDFIRST THEN BEGIN
                            Kanton := CompCanton.Description;
                        END;
                    END;
                END;

                UserPer.RESET;
                UserPer.SETFILTER("User Name", '%1', USERID);
                IF UserPer.FINDFIRST THEN BEGIN
                    Empppp.RESET;
                    Empppp.SETFILTER("No.", '%1', UserPer."Employee No.");
                    IF Empppp.FINDFIRST THEN BEGIN
                        Telefon := Empppp."Company Phone No.";
                        emaill := Empppp."Company E-Mail";
                        Dateof := TODAY;
                    END;


                END;

                f1;

            end;

            trigger OnPreDataItem()
            begin
                /*
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                EmployeeContractLedger.SETFILTER("Show Record",'%1',TRUE);
                IF EmployeeContractLedger.FINDLAST THEN REPEAT
                  EmployeeContractLedger.CALCFIELDS("Org Municipality");
                  EmpOrg.SETFILTER("No.",'%1',EmployeeContractLedger."Employee No.");
                  IF EmpOrg.FIND('-') THEN BEGIN
                    EmpOrg."Org Municipality":=EmployeeContractLedger."Org Municipality";
                    EmpOrg.MODIFY;
                    END;
                  UNTIL EmployeeContractLedger.NEXT=0;*/

                Start2 := Fill.GetMonthRange(Month, Year, TRUE);
                End2 := Fill.GetMonthRange(Month, Year, FALSE);
                /* EmployeeContractLedger.RESET;
                 EmployeeContractLedger.SETFILTER("Starting Date",'<=%1',End2);
                 EmployeeContractLedger.SETFILTER("Report Ending Date",'>=%1',Start2);
                EmployeeContractLedger.SETFILTER("Show Record",'%1',TRUE);
                 IF EmployeeContractLedger.FINDSET THEN REPEAT
                  EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");
                 EmpOrg.SETFILTER("No.",'%1',EmployeeContractLedger."Employee No.");
                 IF EmpOrg.FIND('-') THEN BEGIN
                   EmpOrg."Org Municipality":=EmployeeContractLedger."Org Municipality of ag";
                   EmpOrg.MODIFY;
                   END;
                 UNTIL EmployeeContractLedger.NEXT=0;*/

            end;
        }
        dataitem(SF2; Integer)
        {
            MaxIteration = 1;
            column(BrutoUkupno; output[6] [1])
            {
            }
            column(DoprinosiIzPlate; output[6] [2])
            {
            }
            column(ProsjecniBruto; outputdecimal[1] [1])
            {
            }
            column(PorezNaDohodak; output[6] [3])
            {
            }
            column(NetoIsplata; output[6] [1] - output[6] [2] - output[6] [3])
            {
            }
            column(NetoPros; NetoPros)
            {
            }
            column(BrojZaposlenih; output[6] [5])
            {
            }
            column(BrojPlacenihSati; BrojPlacenih)
            {
            }
            column(SatiNaBolovanju; SickHour)
            {
            }
            column(SatiGodisnjeg; GOHour)
            {
            }
            column(SatiPraznika; DRHour)
            {
            }
            column(SatiPLO; PLHour)
            {
            }
            column(SatiPrekovremeni; DRHourAdd)
            {
                DecimalPlaces = 1 : 2;
            }

            trigger OnAfterGetRecord()
            begin
                f2;
            end;
        }
        dataitem(SF3; Integer)
        {
            MaxIteration = 1;
            column(UkupnoTopliObrok; output[5] [1])
            {
            }
            column(BrojRadnikaTopliObrok; output[5] [2])
            {
            }
            column(UkupnoPrevoz; output[5] [3])
            {
            }
            column(BrojRadnikaPrevoz; output[5] [4])
            {
            }
            column(UkupnoRegres; output[5] [5])
            {
            }
            column(BrojRadnikaRegres; output[5] [6])
            {
            }
            column(Naknade; Naknade)
            {
            }
            column(NaknadeOporezive; NaknadeOporezive)
            {
            }
            column(NaknadeBruto; NaknadeBruto)
            {
            }
            column(OstaleNaknade; OstaleNaknade)
            {
            }
            column(NaknadeLjudi; Naknadeljudi)
            {
            }
            column(NetoOporeziviToplBrLjudi; output[5] [8])
            {
            }
            column(NetoOporeziviTopl; output[5] [9])
            {
            }
            column(BrutoOporeziviTopl; output[5] [10])
            {
            }
            column(RegresOpBrojZaposlenih; output[6] [6])
            {
            }
            column(RegresOp; output[6] [7])
            {
            }
            column(RegresbrutoBrojLjudi; output[6] [8])
            {
            }
            column(RegresBruto; output[6] [9])
            {
            }

            trigger OnAfterGetRecord()
            begin
                f3;
            end;
        }
        dataitem(SF7; Integer)
        {
            MaxIteration = 1;
            column(VSS; output[10] [1])
            {
            }
            column(VSSZene; output[10] [2])
            {
            }
            column("VŠS"; output[11] [1])
            {
            }
            column("VŠSZene"; output[11] [2])
            {
            }
            column(SSS; output[12] [1])
            {
            }
            column(SSSZene; output[12] [2])
            {
            }
            column(NizeStrucno; output[13] [1])
            {
            }
            column(NizeStrucnoZene; output[13] [2])
            {
            }
            column(VKV; output[14] [1])
            {
            }
            column(VKVZene; output[14] [2])
            {
            }
            column(KV; output[15] [1])
            {
            }
            column(KVZene; output[15] [2])
            {
            }
            column(PK; output[16] [1])
            {
            }
            column(PKZene; output[16] [2])
            {
            }
            column(NK; output[17] [1])
            {
            }
            column(NKZene; output[17] [2])
            {
            }
            column(DR; output[18] [1])
            {
            }
            column(DRZene; output[18] [2])
            {
            }
            column(MR; output[19] [1])
            {
            }
            column(MRZene; output[19] [2])
            {
            }

            trigger OnAfterGetRecord()
            begin
                f7;
            end;
        }
        dataitem(SF7a; Integer)
        {
            MaxIteration = 1;
            column(Do18; output[20] [1])
            {
            }
            column(Do18Zene; output[20] [2])
            {
            }
            column(Od19Do24; output[21] [1])
            {
            }
            column(Od19Do24Zene; output[21] [2])
            {
            }
            column(Od25Do29; output[22] [1])
            {
            }
            column(Od25Do29DoZene; output[22] [2])
            {
            }
            column(Od30Do34; output[23] [1])
            {
            }
            column(Od30Do34Zene; output[23] [2])
            {
            }
            column(Od35Do39; output[24] [1])
            {
            }
            column(Od35Do39Zene; output[24] [2])
            {
            }
            column(Od40Do44; output[25] [1])
            {
            }
            column(Od40Do44Zene; output[25] [2])
            {
            }
            column(Od45Do49; output[26] [1])
            {
            }
            column(Od45Do49Zene; output[26] [2])
            {
            }
            column(Od50Do54; output[27] [1])
            {
            }
            column(Od50Do54Zene; output[27] [2])
            {
            }
            column(Od55Do59; output[28] [1])
            {
            }
            column(Od55Do59Zene; output[28] [2])
            {
            }
            column(Od60Do64; output[29] [1])
            {
            }
            column(Od60Do64Zene; output[29] [2])
            {
            }
            column(Od65Vise; output[30] [1])
            {
            }
            column(Od65ViseZene; output[30] [2])
            {
            }

            trigger OnAfterGetRecord()
            begin
                f7a;
            end;
        }
        dataitem(SF8; Integer)
        {
            MaxIteration = 1;
            column(ManjeOd160; output[31] [1])
            {
            }
            column(Do350; output[32] [1])
            {
            }
            column(Od351Do500; output[33] [1])
            {
            }
            column(Od501Do650; output[34] [1])
            {
            }
            column(Od651Do800; output[35] [1])
            {
            }
            column(Od801Do950; output[36] [1])
            {
            }
            column(Od951Do1100; output[37] [1])
            {
            }
            column(Od1101Do1400; output[38] [1])
            {
            }
            column(Od1401Do1700; output[39] [1])
            {
            }
            column(Od1701Do2000; output[40] [1])
            {
            }
            column(Od2001Do2500; output[41] [1])
            {
            }
            column(Od2501Do3000; output[42] [1])
            {
            }
            column(Preko3000; output[43] [1])
            {
            }
            column(Preko200; output[44] [1])
            {
            }

            trigger OnAfterGetRecord()
            begin
                f8;
            end;
        }
        dataitem(SF8a; Integer)
        {
            MaxIteration = 1;
            column(ZapZenePreth; output[45] [3])
            {
            }
            column(ZapMuskPreth; output[46] [3])
            {
            }
            column(VSSPrethodna; output[47] [3])
            {
            }
            column("VŠSPrethodna"; output[48] [3])
            {
            }
            column(SSSPrethodna; output[49] [3])
            {
            }
            column(NizaStrucnaPreth; output[50] [3])
            {
            }
            column(VKPrethodna; output[51] [3])
            {
            }
            column(KVPrethodna; output[52] [3])
            {
            }
            column(PKPrethodna; output[53] [3])
            {
            }
            column(NKPrethodna; output[54] [3])
            {
            }
            column(NetoPrethZene; output[45] [2])
            {
            }
            column(NetoPrethMuskarci; output[46] [2])
            {
            }
            column(NetoVSSPrethodna; output[47] [2])
            {
            }
            column("NetoVŠSPrethodna"; output[48] [2])
            {
            }
            column(NetoSSSPrethodna; output[49] [2])
            {
            }
            column(NetoNizaPrethodna; output[50] [2])
            {
            }
            column(NetoVKVPrethodna; output[51] [2])
            {
            }
            column(NetoKVPrethodna; output[52] [2])
            {
            }
            column(NetoPKPrethodna; output[53] [2])
            {
            }
            column(NetoNKPrethodna; output[54] [2])
            {
            }
            column(BrutoPrethZene; output[45] [1])
            {
            }
            column(BrutoPrethMuskarci; output[46] [1])
            {
            }
            column(BrutoVSSPrethodna; output[47] [1])
            {
            }
            column("BrutoVŠSPrethodna"; output[48] [1])
            {
            }
            column(BrutoSSSPrethodna; output[49] [1])
            {
            }
            column(BrutoNizaPrethodna; output[50] [1])
            {
            }
            column(BrutoVKVPrethodna; output[51] [1])
            {
            }
            column(BrutoKVPrethodna; output[52] [1])
            {
            }
            column(BrutoPKPrethodna; output[53] [1])
            {
            }
            column(BrutoNKPrethodna; output[54] [1])
            {
            }
            column(ProsjNetoPrethZene; output[45] [4])
            {
            }
            column(ProsjNetoPrethMuskarci; output[46] [4])
            {
            }
            column(ProsjNetoVSSPrethodna; output[47] [4])
            {
            }
            column("ProsjNetoVŠSPrethodna"; output[48] [4])
            {
            }
            column(ProsjNetoSSSPrethodna; output[49] [4])
            {
            }
            column(ProsjNetoNizaPrethodna; output[50] [4])
            {
            }
            column(ProsjNetoVKVPrethodna; output[51] [4])
            {
            }
            column(ProsjNetoKVPrethodna; output[52] [4])
            {
            }
            column(ProsjNetoPKPrethodna; output[53] [4])
            {
            }
            column(ProsjNetoNKPrethodna; output[54] [4])
            {
            }

            trigger OnAfterGetRecord()
            begin
                f8a;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Month and year';
                    field(Month; Month)
                    {
                        Caption = 'Month';
                    }
                    field(Year; Year)
                    {
                        Caption = 'Year';
                    }
                    field(Municipality; Municipality)
                    {
                        Caption = 'Municipality';
                        TableRelation = Municipality where(type = filter(Regular));
                        Visible = False;
                    }
                    field(OrgJeddd; OrgJeddd)
                    {
                        Caption = 'OrgDescription';
                        TableRelation = "ORG Dijelovi".Description;
                        Visible = False;
                    }
                    field(UpdateOrg; UpdateOrg)
                    {
                        Caption = 'Ažuriraj podatke u platama';
                        Visible = False;
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
    }

    trigger OnInitReport()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        Year := DATE2DMY(CALCDATE('0D', WORKDATE), 3);
        Month := DATE2DMY(CALCDATE('0D', WORKDATE), 2);
        BROJAC := 0;
        DodatniSiht := 0;
        Org.Reset();
        Org.SetFilter(Active, '%1', true);
        if Org.FindFirst() then begin
            Municipality := Org."Municipality Code of agency";
            OrgJeddd := Org.Description;
            UpdateOrg := true;
        end;
    end;

    trigger OnPostReport()
    begin
        //MESSAGE(FORMAT(PLHour));
        //MESSAGE(FORMAT(DRHour));
    end;

    trigger OnPreReport()
    begin
        FirstDateOfMonth := DMY2DATE(1, Month, Year);
        LastDateOfMonth := CALCDATE('-1D', CALCDATE('+1M', FirstDateOfMonth));
        DayBeforeFirstDate := CALCDATE('-1D', FirstDateOfMonth);

        IF UpdateOrg = TRUE THEN BEGIN
            COMMIT;
            WCU.Reset();
            WCU.SetFilter("Month Of Wage", '%1', Month);
            WCU.SetFilter("Year of Wage", '%1', Year);
            if WCU.FindSet() then
                repeat
                    //ĐK  Prazno.RUN;
                    ECLUpdate.Reset();
                    ECLUpdate.SetFilter("Employee No.", '<=%1', WCU."Employee No.");
                    ECLUpdate.SetFilter("Starting Date", '<=%1', WCU."Payment Date");
                    ECLUpdate.SetCurrentKey("Starting Date");
                    ECLUpdate.Ascending;
                    if ECLUpdate.FindLast() then begin
                        WCU.Munif := ECLUpdate."Org Municipality of ag";
                        WCU."Org Jed" := ECLUpdate."Org Unit Name";
                        ADDSchool.Reset();
                        ADDSchool.SetFilter("Employee No.", '%1', WCU."Employee No.");
                        ADDSchool.SetFilter("From Date", '<=%1', WCU."Payment Date");
                        ADDSchool.SetCurrentKey("From Date");
                        ADDSchool.Ascending;
                        if ADDSchool.FindLast() then
                            WCU."Education Level" := ADDSchool."Education Level";
                        EUpdate.get(WCu."Employee No.");
                        WCU.Gender := EUpdate.Gender;
                        WCU.Modify();


                    end;
                until WCU.Next() = 0;
            COMMIT;
        END;
        // MESSAGE(FORMAT(FirstDateOfMonth)+' ' +FORMAT(LastDateOfMonth)+' '+FORMAT(DayBeforeFirstDate));
        CASE Month OF

            1:
                Monthlbl := '01';
            2:
                Monthlbl := '02';
            3:
                Monthlbl := '03';
            4:
                Monthlbl := '04';
            5:
                Monthlbl := '05';
            6:
                Monthlbl := '06';
            7:
                Monthlbl := '07';
            8:
                Monthlbl := '08';
            9:
                Monthlbl := '09';
            10:
                Monthlbl := '10';
            11:
                Monthlbl := '11';
            12:
                Monthlbl := '12';


        /*1: Monthlbl:='JANUAR';
        2: Monthlbl:='FEBRUAR';
        3: Monthlbl:='MART';
        4: Monthlbl:='APRIL';
        5: Monthlbl:='MAJ';
        6: Monthlbl:='JUNI';
        7: Monthlbl:='JULI';
        8: Monthlbl:='AVGUST';
        9: Monthlbl:='SEPTEMBAR';
        10: Monthlbl:='OKTOBAR';
        11: Monthlbl:='NOVEMBAR';
        12: Monthlbl:='DECEMBAR';*/

        END;
        End2 := Fill.GetMonthRange(Month, Year, FALSE);
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                IF EmployeeContractLedger."Ending Date" = 0D THEN
                    EmployeeContractLedger."Report Ending Date" := End2
                ELSE
                    EmployeeContractLedger."Report Ending Date" := EmployeeContractLedger."Ending Date";
                EmployeeContractLedger.MODIFY;

            UNTIL EmployeeContractLedger.NEXT = 0;

        /*IF   CurrReport.PREVIEW THEN  begin
        // Use the REPORT.SAVEAS function to save the report as a PDF file
        
        Content.CREATE('TestFile.pdf');
        
        Content.CREATEOUTSTREAM(OStream);
        
        REPORT.OPENAS(206,XmlParameters,REPORTFORMAT::Pdf,OStream);
        
        Content.CLOSE;    end; */
        SickHour := 0;

    end;

    var
        WACont: Record "Wage Addition";
        ECLUpdate: Record "Employee Contract Ledger";
        ADDSchool: Record "Additional Education";
        EUpdate: Record Employee;
        WCU: Record "Wage Calculation";
        ConCat: Record "Contribution Category";
        WVEAdditions: Record "Wage Value Entry";
        Month: Integer;
        Monthlbl: Text;
        NaknadeBruto: Decimal;
        sumaTemp10: Decimal;
        OstaleNaknade: Decimal;
        Sumica: Decimal;
        OrgJed: Text[50];
        NemajuUg: Decimal;
        //ĐK   Prazno: Report "65564";
        Neaktivni: Decimal;
        WageContact: Record "Wage Calculation";
        Neaktivnizene: Decimal;
        UpdateOrg: Boolean;
        NemajuUgZene: Decimal;
        emaill: Text;
        WageVTopli: Record "Wage Value Entry";
        DodatniCause: Record "Cause of Absence";
        OrgJeddd: Text;
        DodatniSiht: Decimal;
        suma8topli: Decimal;
        suma9topli: Decimal;
        NetoPros: Decimal;
        NemaOp: Boolean;
        NaknadeOporezive: Decimal;
        Naknadeljudi: Integer;
        WageAddTopli: Record "Wage Addition Type";
        SumaKorekcijeToplog: Decimal;
        DodatniSatiSihtarice: Record "Employee Absence";
        BrojPlacenih: Integer;
        Year: Integer;
        Sumaaa: Integer;
        OduzmiPorez: Decimal;
        Oduzmi: Decimal;
        sumaaa9: Decimal;
        sumaTemp11: Decimal;
        RAADDDD: Record "Wage Addition Type";
        Naknadeljudi2: Decimal;
        wADD: Record "Wage Addition";
        E: Record "Employee";
        iNTV: Integer;
        Neplaceni: Decimal;
        Testttt2: Record Employee temporary;
        WA2: Record "Wage Addition Type";
        Dateof: Date;
        WaddAdd: Record "Wage Addition";
        Sumaprekododataka: Decimal;
        SumaKorekcija: Decimal;
        Dupli: Integer;
        DRHourAdd: Decimal;
        Empppp: Record "Employee";
        UserPer: Record "User Setup";
        WA: Record "Wage Addition Type";
        Bolesti: Decimal;
        SumaaaaaaZene: Integer;
        Testttt: Record Employee temporary;
        output: array[55, 10] of Integer;
        outputTemp: array[12, 12] of Decimal;
        FirstDateOfMonth: Date;
        Telefon: Text;
        sumaaa8: Decimal;
        WageV: Record "Wage Value Entry";
        ECLRec: Record "Employee Contract Ledger";
        LastDateOfMonth: Date;
        BROJAC: Integer;
        DayBeforeFirstDate: Date;
        ECCFilter: Text[1024];
        WVE: Record "Wage Value Entry";
        WAD: Record "Wage Addition Type";
        WH: Record "Wage Header";
        WLE: Record "Wage Ledger Entry";
        ECL2: Record "Employee Contract Ledger";
        EA: Record "Employee Absence";
        COA: Record "Cause of Absence";
        WC: Record "Wage Calculation";
        COAFilter: Text[1024];
        Start2: Date;
        End2: Date;
        Fill: Codeunit "Absence Fill";
        i: Integer;
        j: Integer;
        k: Integer;
        z: Integer;
        CompInfo: Record "Company Information";
        Kanton: Text;
        Opcina: Text;
        CompCanton: Record "Canton";
        CompMunicipality: Record Municipality;
        sumaTemp1: Decimal;
        sumaTemp2: Decimal;
        outputdecimal: array[30, 10] of Decimal;
        sumaTemp3: Decimal;
        sumaTemp4: Decimal;
        sumaTemp5: Decimal;
        EmpAbs: Record "Employee Absence";
        sumaTemp6: Decimal;
        sumaTemp7: Decimal;
        sumaTemp8: Decimal;
        sumaTemp9: Decimal;
        StartDateD: Date;
        EndDateD: Date;
        CO: Record "Cause of Absence";
        SickHour: Decimal;
        GOHour: Decimal;
        DRHour: Decimal;
        PLHour: Decimal;
        suma1: Decimal;
        Text1: Label 'You cannot see preview of this report.';
        OStream: OutStream;
        IStream: InStream;
        CurrentUser: Code[10];
        Content: File;
        TempFileName: Text;
        XMLParameters: Text;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeContractLedger1: Record "Employee Contract Ledger";
        Municipality: Code[10];
        Naknade: Decimal;
        Org: Record "ORG Dijelovi";
        OrgName: Text;
        OrgID: Text;
        OrgAddress: Text;
        OrgTelephone: Text;
        OrgJIB: Text;
        OrgJIBName: Text;
        PostCode: Record "Post Code";
        "EmployeeContractLedger.": Record "Employee Contract Ledger";
        EmpOrg: Record "Employee";
        DodatnoBruto: Decimal;
        DodatnoNeto: Decimal;
        WageType: Record "Wage Addition Type";
        WageAddition: Record "Wage Addition";
        Dates: Date;
        DodatnoDohodak: Decimal;
        DodatnoDoprinos: Decimal;
        DodatnoUkupnoRegres: Decimal;
        DodatnoRegresOp: Decimal;
        DodatnoRegresBruto: Decimal;
        DodatnoRegresBrojLjudi: Decimal;
        WageCalculation: Record "Wage Calculation";

    procedure f1()
    var
        ETemp: Record "employee" temporary;
        ETemp2: Record "Employee";
        ETemp3: Record "Employee";
        ETemp4: Record "Employee";
        ETemp5: Record "Employee";
        ETemp6: Record "Employee";
        ETemp7: Record "Employee";
    begin

        FOR i := 1 TO 30 DO
            FOR j := 1 TO 2 DO
                output[i] [j] := 0;

        E.RESET;


        //OrgJed:='Agencija Bijeljina';

        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', DayBeforeFirstDate);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', DayBeforeFirstDate);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        IF OrgJeddd <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJeddd);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                /*ĐK IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                     EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJeddd);
                 IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                     EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        EmployeeContractLedger.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");
                //######################## 1
                WH.RESET;


                WH.SETRANGE("Month Of Wage", DATE2DMY(DayBeforeFirstDate, 2));
                WH.SETRANGE("Year Of Wage", DATE2DMY(DayBeforeFirstDate, 3));
                //WH.SETRANGE("Wage Calculation Type",WH."Wage Calculation Type"::Normal);

                IF WH.FIND('-') THEN BEGIN
                    WC.RESET;
                    WC.SETRANGE("Wage Header No.", WH."No.");
                    WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                    // WC.SETRANGE("Department Municipality",Municipality);
                    WC.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");

                    IF WC.FIND('-') THEN BEGIN
                        E.GET(WC."Employee No.");
                        ETemp.INIT;
                        ETemp."No." := WC."Employee No.";
                        i := WC."Calculation Type";
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                        ETemp.Gender := E.Gender;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."E-Mail" := OrgJeddd;
                        //MESSAGE(ETemp."No.");
                        IF ETemp.INSERT THEN
                            ETemp.MODIFY
                        ELSE
                            ETemp.MODIFY;
                    END
                END
                ELSE BEGIN
                    E.GET(EmployeeContractLedger."Employee No.");
                    IF EmployeeContractLedger."Contract Type Name" <> 'EXTERNI ANGAZMAN' THEN BEGIN
                        ETemp.INIT;
                        ETemp."No." := EmployeeContractLedger."Employee No.";
                        i := 0;
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                        ETemp.Gender := E.Gender;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."E-Mail" := OrgJeddd;
                        //MESSAGE(ETemp."No.");
                        IF ETemp.INSERT THEN
                            ETemp.MODIFY
                        ELSE
                            ETemp.MODIFY;

                    END;
                END;

            UNTIL EmployeeContractLedger.NEXT = 0;


        //kraj posljednjeg mjeseca
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '>%1', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Employment Date", '<%1', DayBeforeFirstDate);

        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);

        ETemp.SETFILTER(Status, '%1|%2|%3', 0, 1, 2);
        IF ETemp.FINDFIRST THEN BEGIN
            output[1] [1] := ETemp.COUNT;
            // MESSAGE(ETemp."No.");
            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            output[1] [2] := ETemp.COUNT;

        END;
        //END;


        //######################## Ostalo
        ETemp.RESET;
        ETemp.SETFILTER("Employment Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Employment Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;
        ETemp.RESET;
        ETemp.SETFILTER(Gender, '<>%1', ETemp.Gender::" ");
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp.Gender := ETemp.Gender::" ";
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;

        /* ETemp.RESET;
     ETemp.SETFILTER("Org Municipality",'<>%1','');
     ETemp."Org Municipality":=Municipality;
       ETemp."E-Mail":=OrgJeddd;
     IF ETemp.FINDSET THEN REPEAT
       ETemp."Org Municipality":='';
       ETemp.MODIFY;
        UNTIL ETemp.NEXT=0;*/


        //DOSLI DA JE ZAPOCELO U 8 MJESECU PRELAZ, ODNOSNO DA JE DATUM POCETKA MANJI OD 31.08.2018 ALI DA JE ISTO I DATUM POCETKA VECI OD 31.07.2018

        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1 & >%2', End2, DayBeforeFirstDate);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', Start2);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
        IF OrgJeddd <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJeddd);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                /*ĐK   IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                       EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJeddd);
                   IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                       EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);


        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");

                ECL2.RESET;
                ECL2.SETFILTER("Starting Date", '<=%1', End2);
                ECL2.SETFILTER("Report Ending Date", '>=%1', CALCDATE('<-1D>', Start2));
                ECL2.SETCURRENTKEY("Starting Date");
                ECL2.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
                IF OrgJeddd = '' THEN
                    ECL2.SETFILTER("Org Municipality of ag", '<>%1', Municipality);

                IF OrgJeddd <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJeddd);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        /*  IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                              ECL2.SETFILTER("Org Unit Name", '<>%1', OrgJeddd)
                          ELSE
                              ECL2.SETFILTER("GF of work Description", '<>%1', OrgJeddd);*/
                    END;
                END;

                ECL2.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                ECL2.ASCENDING;
                IF ECL2.FINDFIRST THEN BEGIN
                    IF ECL2."Starting Date" < EmployeeContractLedger."Starting Date" THEN BEGIN
                        ECL2.CALCFIELDS("Org Municipality of ag");
                        WH.RESET;
                        WH.SETRANGE("Month Of Wage", Month);
                        WH.SETRANGE("Year Of Wage", Year);
                        WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);

                        IF WH.FIND('-') THEN BEGIN
                            WC.RESET;
                            WC.SETRANGE("Wage Header No.", WH."No.");
                            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                            WC.SETFILTER("Employee No.", '%1', ECL2."Employee No.");
                            IF WC.FIND('-') THEN BEGIN
                                E.GET(ECL2."Employee No.");
                                ETemp.INIT;
                                ETemp."No." := WC."Employee No.";
                                i := WC."Calculation Type";
                                ETemp."First Name" := FORMAT(i);
                                ETemp."Termination Date" := CALCDATE('<+1D>', Start2);
                                ETemp."Employment Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp.Gender := E.Gender;
                                ETemp."Org Municipality" := Municipality;
                                ETemp."E-Mail" := OrgJeddd;

                                IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;
                            END;
                        END;
                    END;



                END;
            UNTIL EmployeeContractLedger.NEXT = 0;




        //########################
        NemajuUg := 0;
        NemajuUgZene := 0;
        ETemp.RESET;
        // ETemp.SETFILTER("Termination Date",'%1',0D,CALCDATE('<+1D>',Start2));
        ETemp.SETFILTER("Employment Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        IF ETemp.FINDFIRST THEN BEGIN
            output[2] [1] := ETemp.COUNT;
            //ETemp.SETRANGE(Gender, ETemp.Gender::Female);

        END;
        ETemp.RESET;
        ETemp.SETFILTER("Employment Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        ETemp.SETFILTER(Gender, '%1', ETemp.Gender::Female);
        IF ETemp.FINDFIRST THEN BEGIN
            output[2] [2] := ETemp.COUNT;
        END;


        EmployeeContractLedger.RESET;
        //korekcija1
        EmployeeContractLedger.SETFILTER("Starting Date", '>=%1 & <=%2', CALCDATE('<-1D>', FirstDateOfMonth), LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Reason for Change", '%1', EmployeeContractLedger."Reason for Change"::"New Contract");
        EmployeeContractLedger.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF OrgJeddd <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJeddd);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                /*    IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                        EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJeddd);
                    IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                        EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
            END;
        END;


        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                NemajuUg := NemajuUg + 1;
                Empppp.RESET;
                Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                IF Empppp.FINDFIRST THEN BEGIN
                    IF Empppp.Gender = Empppp.Gender::Female THEN
                        NemajuUgZene := NemajuUgZene + 1;
                END;
            UNTIL EmployeeContractLedger.NEXT = 0;

        output[2] [1] := output[2] [1] + NemajuUg;
        output[2] [2] := output[2] [2] + NemajuUgZene;



        //OTISLI TO JESTE U 8 MJESECU IMAJU RAZLICITE ORGANIZACIONE JEDINICE
        ETemp.RESET;
        ETemp.SETFILTER("Employment Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Employment Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;


        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', End2);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', Start2);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
        IF OrgJeddd <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJeddd);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                /*  IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                      EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJeddd);
                  IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                      EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);

        //DA PRONADE BILO KOJI KOJI JE O79 NPR
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");
                ECL2.RESET;
                ECL2.SETFILTER("Starting Date", '<=%1', End2);
                ECL2.SETFILTER("Report Ending Date", '>=%1', Start2);
                ECL2.SETCURRENTKEY("Starting Date");
                ECL2.SETFILTER("Org Municipality of ag", '<>%1', Municipality);
                IF OrgJeddd <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJeddd);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        /* IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                             ECL2.SETFILTER("Org Unit Name", '%1', OrgJeddd)
                         ELSE
                             ECL2.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
                    END;
                END;

                //END;
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                ECL2.ASCENDING;
                IF ECL2.FINDFIRST THEN BEGIN
                    IF EmployeeContractLedger."Starting Date" < ECL2."Starting Date" THEN BEGIN
                        ECL2.CALCFIELDS("Org Municipality of ag");
                        WH.RESET;
                        WH.SETRANGE("Month Of Wage", Month);
                        WH.SETRANGE("Year Of Wage", Year);
                        WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);

                        IF WH.FIND('-') THEN BEGIN
                            WC.RESET;
                            WC.SETRANGE("Wage Header No.", WH."No.");
                            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                            WC.SETFILTER("Employee No.", '%1', ECL2."Employee No.");
                            // WC.SETRANGE("Department Municipality",Municipality);
                            IF WC.FIND('-') THEN BEGIN
                                E.GET(WC."Employee No.");
                                ETemp.INIT;
                                ETemp."No." := WC."Employee No.";
                                i := WC."Calculation Type";
                                ETemp."First Name" := FORMAT(i);
                                ETemp."Termination Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp."Employment Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp.Gender := E.Gender;
                                ETemp."Org Municipality" := Municipality;
                                ETemp."E-Mail" := OrgJeddd;
                                IF ETemp.INSERT
                                 THEN
                                    ETemp.MODIFY ELSE
                                    ETemp.MODIFY
                            END;

                        END;
                    END;
                END;
            UNTIL EmployeeContractLedger.NEXT = 0;

        //######################## 3
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        IF ETemp.FINDFIRST THEN BEGIN
            output[3] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            output[3] [2] := ETemp.COUNT;
        END;

        Sumaaa := 0;
        SumaaaaaaZene := 0;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Report Ending Date", '%1..%2', CALCDATE('<-1D>', FirstDateOfMonth), LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Grounds for Term. Description", '%1', '');
        IF OrgJeddd <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJeddd);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                /*   IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                       EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJeddd);
                   IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                       EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
            END;
        END;


        EmployeeContractLedger.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        //DA PRONADE BILO KOJI KOJI JE O79 NPR
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");
                IF EmployeeContractLedger."Grounds for Term. Description" <> '' THEN BEGIN
                    Empppp.RESET;
                    Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                    IF Empppp.FINDFIRST THEN BEGIN
                        IF Empppp.Gender = Empppp.Gender::Female THEN
                            SumaaaaaaZene := SumaaaaaaZene + 1;
                    END;
                    Sumaaa := Sumaaa + 1;
                END;
                ECL2.RESET;
                ECL2.SETFILTER("Starting Date", '%1..%2', FirstDateOfMonth, LastDateOfMonth);

                IF OrgJeddd = '' THEN
                    ECL2.SETFILTER("Org Municipality of ag", '<>%1', Municipality);
                IF OrgJeddd <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJeddd);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        /*  IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                              ECL2.SETFILTER("Org Unit Name", '<>%1', OrgJeddd)
                          ELSE
                              ECL2.SETFILTER("GF of work Description", '<>%1', OrgJeddd);*/
                    END;
                END;
                ECL2.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                ECL2.ASCENDING;
                IF ECL2.FINDFIRST THEN BEGIN
                    Empppp.RESET;
                    Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                    IF Empppp.FINDFIRST THEN BEGIN
                        IF Empppp.Gender = Empppp.Gender::Female THEN
                            SumaaaaaaZene := SumaaaaaaZene + 1;

                    END;
                    Sumaaa := Sumaaa + 1;
                END;
            UNTIL EmployeeContractLedger.NEXT = 0;
        output[3] [1] := output[3] [1] + Sumaaa;


        //######################## 3
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        ETemp.SETFILTER(Gender, '%1', ETemp.Gender::Female);
        IF ETemp.FINDFIRST THEN BEGIN
            output[3] [2] := ETemp.COUNT;
        END;
        output[3] [2] := output[3] [2] + SumaaaaaaZene;

        Neaktivni := 0;
        Neaktivnizene := 0;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Ending Date", '<%1 & >=%2', LastDateOfMonth, CALCDATE('<-1D>', FirstDateOfMonth));
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        IF OrgJeddd <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJeddd);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                /* IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                     EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJeddd);
                 IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                     EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        EmployeeContractLedger.SETFILTER("Grounds for Term. Description", '<>%1', '');
        EmployeeContractLedger.SETFILTER("Contract Type Name", '<>%1', 'EXTERNI ANGAZMAN');
        //DA PRONADE BILO KOJI KOJI JE O79 NPR
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                Neaktivni := Neaktivni + 1;
                Empppp.RESET;
                Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                IF Empppp.FINDFIRST THEN BEGIN
                    IF Empppp.Gender = Empppp.Gender::Female THEN
                        Neaktivnizene := Neaktivnizene + 1;

                END;

            UNTIL EmployeeContractLedger.NEXT = 0;

        output[3] [1] := output[3] [1] + Neaktivni;
        output[3] [2] := output[3] [2] + Neaktivnizene;







        output[4] [1] := output[1] [1] + output[2] [1] - output[3] [1];
        output[4] [2] := output[1] [2] + output[2] [2] - output[3] [2];

        ///pripravnici
        ETemp6.RESET;
        ETemp6.SETFILTER("Termination Date", '%1|>%2', 0D, LastDateOfMonth);
        ETemp6.SETFILTER("Probation Period", '%1', TRUE);
        ETemp6.SETFILTER("Probation Period End", '>%1|<%2', FirstDateOfMonth, LastDateOfMonth);
        ETemp6.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp6.SETFILTER("E-Mail", '%1', OrgJeddd);
        IF ETemp6.FINDFIRST THEN BEGIN
            output[5] [1] := ETemp6.COUNT;
            ETemp6.SETRANGE(Gender, ETemp6.Gender::Female);
            output[5] [2] := ETemp6.COUNT;
        END;
        //END;

    end;

    procedure f2()
    var
        prosjecni: Decimal;
        ETemp: Record "Employee" temporary;
        ETemp1: Record "Employee";
    begin
        E.RESET;
        WH.RESET;
        sumaTemp1 := 0;
        sumaTemp2 := 0;
        sumaTemp3 := 0;
        sumaTemp4 := 0;
        sumaTemp5 := 0;
        sumaTemp6 := 0;
        Neplaceni := 0;
        DodatnoBruto := 0;
        DodatnoNeto := 0;
        DodatnoDoprinos := 0;



        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;

        WH.SETRANGE("Month Of Wage", DATE2DMY(FirstDateOfMonth, 2));
        WH.SETRANGE("Year Of Wage", DATE2DMY(FirstDateOfMonth, 3));

        WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);
        IF WH.FIND('-') THEN BEGIN
            WC.RESET;
            WC.SETRANGE("Wage Header No.", WH."No.");
            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
            // WC.SETRANGE("Department Municipality",Municipality);
            //WC.SETFILTER("Employee No.",'%1',EmployeeContractLedger."Employee No.");

            IF WC.FIND('-') THEN
                REPEAT
                    ECL2.RESET;
                    ECL2.SETFILTER("Employee No.", '%1', WC."Employee No.");
                    ECL2.SETFILTER("Starting Date", '<=%1', End2);
                    ECL2.SETFILTER("Report Ending Date", '>=%1', End2);
                    ECL2.SETFILTER("Org Municipality of ag", '%1', Municipality);
                    //ECL2.SETFILTER("Employee No.",'%1',EmployeeContractLedger."Employee No.");
                    IF OrgJeddd <> '' THEN BEGIN
                        Org.RESET;
                        Org.SETFILTER(Description, '%1', OrgJeddd);
                        Org.SETFILTER(Active, '%1', TRUE);
                        IF Org.FINDFIRST THEN BEGIN
                            /*  IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                                  ECL2.SETFILTER("Org Unit Name", '%1', OrgJeddd)
                              ELSE
                                  ECL2.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
                        END;
                    END;
                    ECL2.SETFILTER("Show Record", '%1', TRUE);
                    IF ECL2.FINDFIRST THEN BEGIN
                        E.GET(WC."Employee No.");
                        ETemp.INIT;
                        ETemp."No." := WC."Employee No.";
                        i := WC."Calculation Type";
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := Start2;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."E-Mail" := OrgJeddd;
                        IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;
                        //  END
                        /*ELSE BEGIN

                      EmployeeContractLedger.RESET;
                      EmployeeContractLedger.SETFILTER("Ending Date",'<%1 & >=%2',LastDateOfMonth,FirstDateOfMonth);
                      EmployeeContractLedger.SETFILTER("Org Municipality of ag",'%1',Municipality);
                      IF OrgJed <> '' THEN BEGIN
                          Org.RESET;
                          Org.SETFILTER(Description, '%1', OrgJed);
                          Org.SETFILTER(Active, '%1', TRUE);
                          IF Org."Branch Agency"=Org."Branch Agency"::Agency THEN
                            EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed);
                          IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                            EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                          END;
                       EmployeeContractLedger.SETFILTER("Show Record",'%1',TRUE);
                       EmployeeContractLedger.SETFILTER("Grounds for Term. Description",'<>%1','');
                       EmployeeContractLedger.SETFILTER("Employee No.",'%1',WC."Employee No.");
                      //DA PRONADE BILO KOJI KOJI JE O79 NPR
                      IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                        E.GET(EmployeeContractLedger."Employee No.");
                        ETemp.INIT;
                        ETemp."No." := EmployeeContractLedger."Employee No.";
                        i := WC."Calculation Type";
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := Start2;
                        ETemp."Org Municipality":=Municipality;
                        IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;
                       END;*/
                    END;


                UNTIL WC.NEXT = 0;

            WH.SETRANGE("Month Of Wage", DATE2DMY(FirstDateOfMonth, 2));
            WH.SETRANGE("Year Of Wage", DATE2DMY(FirstDateOfMonth, 3));

            WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);
            IF WH.FIND('-') THEN BEGIN
                WC.RESET;
                WC.SETRANGE("Wage Header No.", WH."No.");
                WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                // WC.SETRANGE("Department Municipality",Municipality);
                //WC.SETFILTER("Employee No.",'%1',EmployeeContractLedger."Employee No.");

                IF WC.FIND('-') THEN
                    REPEAT
                        ECL2.RESET;
                        ECL2.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        ECL2.SETFILTER("Ending Date", '<%1 & >=%2', End2, Start2);
                        ECL2.SETFILTER("Org Municipality of ag", '%1', Municipality);
                        //  ECL2.SETFILTER("Employee No.",'%1',EmployeeContractLedger."Employee No.");
                        IF OrgJeddd <> '' THEN BEGIN
                            Org.RESET;
                            Org.SETFILTER(Description, '%1', OrgJeddd);
                            Org.SETFILTER(Active, '%1', TRUE);
                            IF Org.FINDFIRST THEN BEGIN
                                /*     IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                                         ECL2.SETFILTER("Org Unit Name", '%1', OrgJeddd)
                                     ELSE
                                         ECL2.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
                            END;
                        END;

                        ECL2.SETFILTER("Grounds for Term. Description", '<>%1', '');
                        ECL2.SETFILTER("Show Record", '%1', TRUE);
                        IF ECL2.FINDFIRST THEN BEGIN
                            E.GET(WC."Employee No.");
                            ETemp.INIT;
                            ETemp."No." := WC."Employee No.";
                            i := WC."Calculation Type";
                            ETemp."First Name" := FORMAT(i);
                            ETemp."Termination Date" := Start2;
                            ETemp."Org Municipality" := Municipality;
                            ETemp."E-Mail" := OrgJeddd;
                            IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;
                            //

                        END;
                    UNTIL WC.NEXT = 0;

            END;

            SumaKorekcija := 0;
            Oduzmi := 0;
            OduzmiPorez := 0;



            ETemp.RESET;
            ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
            ETemp.SETFILTER("Org Municipality", Municipality);
            IF OrgJeddd <> '' THEN
                ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
            IF ETemp.FIND('-') THEN
                REPEAT
                    IF WC.FIND('-') THEN
                        REPEAT
                            IF WC."Employee No." = ETemp."No." THEN BEGIN

                                WVEAdditions.RESET;
                                WVEAdditions.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                WVEAdditions.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                WVEAdditions.SETFILTER("Wage Calculation Type", '%1', WVEAdditions."Wage Calculation Type"::Additions);
                                WVEAdditions.SETFILTER("Entry Type", '%1|%2|%3|%4', WVEAdditions."Entry Type"::"Net Wage", WVEAdditions."Entry Type"::"Work Experience",
                                WVEAdditions."Entry Type"::Taxable, WVEAdditions."Entry Type"::Untaxable);
                                WVEAdditions.CALCFIELDS("RAD-1 Wage Excluded");
                                WVEAdditions.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);
                                IF WVEAdditions.FINDFIRST THEN BEGIN
                                    WVEAdditions.CALCSUMS("Cost Amount (Netto)", "Cost Amount (Actual)");
                                    DodatnoDohodak := WVEAdditions."Cost Amount (Netto)" - WVEAdditions."Cost Amount (Actual)";
                                END;

                                WVEAdditions.RESET;
                                WVEAdditions.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                WVEAdditions.SETFILTER("Wage Calculation Type", '%1', WVEAdditions."Wage Calculation Type"::Additions);
                                WVEAdditions.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                WVEAdditions.SETFILTER("Entry Type", '%1', WVEAdditions."Entry Type"::Contribution);
                                WVEAdditions.SETFILTER("AT From", '%1', TRUE);
                                WVEAdditions.CALCFIELDS("RAD-1 Wage Excluded");
                                WVEAdditions.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);
                                IF WVEAdditions.FINDFIRST THEN BEGIN
                                    WVEAdditions.CALCSUMS("Cost Amount (Netto)");
                                    DodatnoDoprinos := DodatnoDoprinos + WVEAdditions."Cost Amount (Netto)";
                                END;

                                //  sumaTemp1:=sumaTemp1+ROUND(WC.Brutto,1, '=');
                                ConCat.SETFILTER(Code, '%1', WC."Contribution Category Code");
                                IF ConCat.FINDSET THEN BEGIN
                                    ConCat.CALCFIELDS("From Brutto");
                                    WACont.RESET;
                                    WACont.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                    WACont.SETFILTER("Wage Header No.", '%1', WC."Wage Header No.");
                                    WACont.SETFILTER(Meal, '%1', TRUE);
                                    WACont.SETFILTER("Wage Addition Type", '%1', '821');
                                    IF WACont.FINDFIRST THEN
                                        WACont.CALCSUMS(Brutto);

                                    sumaTemp2 := sumaTemp2 + (ROUND(WC."Contribution From Brutto", 0.00001, '>') - ((ConCat."From Brutto" / 100) * ROUND(WACont.Brutto, 0.00001, '>')));
                                END;

                                WVEAdditions.RESET;
                                WVEAdditions.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                WVEAdditions.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                WVEAdditions.SETFILTER("Wage Calculation Type", '%1', WVEAdditions."Wage Calculation Type"::Regular);
                                WVEAdditions.SETFILTER("Entry Type", '%1|%2|%3|%4', WVEAdditions."Entry Type"::"Net Wage", WVEAdditions."Entry Type"::"Work Experience",
                                WVEAdditions."Entry Type"::Taxable, WVEAdditions."Entry Type"::Untaxable);
                                WVEAdditions.CALCFIELDS("RAD-1 Wage Excluded");
                                WVEAdditions.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);
                                IF WVEAdditions.FINDFIRST THEN BEGIN

                                    WVEAdditions.CALCSUMS("Cost Amount (Netto)", "Cost Amount (Actual)");
                                    sumaTemp3 += WVEAdditions."Cost Amount (Netto)" - WVEAdditions."Cost Amount (Actual)";
                                    // sumaTemp3:=sumaTemp3+WC.Tax;
                                END;

                                sumaTemp4 := sumaTemp4 + WC."Net Wage After Tax";
                                //  sumaTemp4:=sumaTemp1-sumaTemp2-sumaTemp3;
                                sumaTemp5 := sumaTemp5 + WC."Individual Hour Pool";
                                WaddAdd.RESET;
                                WaddAdd.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                WaddAdd.SETFILTER("Wage Header No.", '%1', WC."Wage Header No.");
                                WaddAdd.SETFILTER("No. Of Hours", '<>%1', 0);
                                WaddAdd.SETFILTER("Wage Addition Type", '<>%1 & <>%2 & <>%3', '820', '821', '822');
                                IF WaddAdd.FINDFIRST THEN BEGIN
                                    WaddAdd.CALCSUMS("No. Of Hours");
                                    SumaKorekcija := SumaKorekcija + WaddAdd."No. Of Hours";
                                    //<>820 & <>821 & <>822

                                END;

                                DodatniCause.RESET;
                                DodatniCause.SETFILTER("Add Hours", '%1', TRUE);
                                IF DodatniCause.FINDSET THEN
                                    REPEAT

                                        DodatniSatiSihtarice.RESET;
                                        DodatniSatiSihtarice.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                        DodatniSatiSihtarice.SETFILTER("From Date", '%1..%2', FirstDateOfMonth, LastDateOfMonth);
                                        DodatniSatiSihtarice.SETFILTER("Cause of Absence Code", '%1', DodatniCause.Code);
                                        IF DodatniSatiSihtarice.FINDFIRST THEN BEGIN
                                            DodatniSatiSihtarice.CALCSUMS(Quantity);


                                            WageContact.RESET;
                                            WageContact.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                            WageContact.SETFILTER("Wage Header No.", '%1', WC."Wage Header No.");
                                            IF WageContact.FINDFIRST THEN BEGIN
                                                IF WageContact."Contact Center" = TRUE THEN
                                                    DodatniSiht := DodatniSiht + DodatniSatiSihtarice.Quantity;
                                            END;
                                        END;


                                    UNTIL DodatniCause.NEXT = 0;




                            END;
                        UNTIL WC.NEXT = 0;
                UNTIL ETemp.NEXT = 0;
        END;




        ETemp.RESET;
        WC.RESET;
        WC.SETRANGE("Wage Header No.", WH."No.");
        WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
        //WC.SETRANGE("Department Municipality",Municipality);
        WC.SETFILTER(WC.Brutto, '<>%1', 0);
        ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);

        IF ETemp.FIND('-') THEN
            REPEAT
                IF WC.FIND('-') THEN
                    REPEAT
                        IF WC."Employee No." = ETemp."No." THEN BEGIN

                            //NK  sumaTemp1:=sumaTemp1 + WC.Brutto;
                            // bruto plata
                            WVEAdditions.RESET;
                            WVEAdditions.SETFILTER("Employee No.", '%1', WC."Employee No.");
                            WVEAdditions.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                            WVEAdditions.SETFILTER("Wage Calculation Type", '%1', WVEAdditions."Wage Calculation Type"::Regular);
                            WVEAdditions.SETFILTER("Entry Type", '%1|%2|%3|%4', WVEAdditions."Entry Type"::"Net Wage", WVEAdditions."Entry Type"::"Work Experience",
                              WVEAdditions."Entry Type"::Taxable, WVEAdditions."Entry Type"::Untaxable);
                            WVEAdditions.CALCFIELDS("RAD-1 Wage Excluded");
                            WVEAdditions.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);

                            IF WVEAdditions.FINDFIRST THEN BEGIN

                                WVEAdditions.CALCSUMS("Cost Amount (Brutto)");
                                RAADDDD.RESET;
                                RAADDDD.SETFILTER(Code, '%1', WVEAdditions.Description);
                                IF RAADDDD.FINDFIRST THEN BEGIN
                                    IF RAADDDD."Bruto (RAD)" = FALSE THEN
                                        sumaTemp1 := sumaTemp1 + WVEAdditions."Cost Amount (Brutto)";
                                END
                                ELSE BEGIN
                                    sumaTemp1 := sumaTemp1 + WVEAdditions."Cost Amount (Brutto)";
                                END;
                            END;

                            RAADDDD.RESET;
                            RAADDDD.SETFILTER("Bruto (RAD)", '%1', TRUE);
                            IF RAADDDD.FINDSET THEN
                                REPEAT


                                    WVEAdditions.RESET;
                                    WVEAdditions.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                    WVEAdditions.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                    WVEAdditions.SETFILTER("Wage Calculation Type", '%1', WVEAdditions."Wage Calculation Type"::Regular);
                                    WVEAdditions.SETFILTER("Entry Type", '%1|%2|%3|%4', WVEAdditions."Entry Type"::"Net Wage", WVEAdditions."Entry Type"::"Work Experience",
                                      WVEAdditions."Entry Type"::Taxable, WVEAdditions."Entry Type"::Untaxable);
                                    WVEAdditions.SETFILTER(Description, '%1', RAADDDD.Code);
                                    IF WVEAdditions.FINDFIRST THEN BEGIN
                                        WVEAdditions.CALCSUMS("Cost Amount (Brutto)");
                                        Oduzmi := Oduzmi + WVEAdditions."Cost Amount (Brutto)";
                                        OduzmiPorez := OduzmiPorez + WVEAdditions."Cost Amount (Netto)" - WVEAdditions."Cost Amount (Actual)";

                                    END;


                                UNTIL RAADDDD.NEXT = 0;







                            COA.RESET;
                            COA.SETFILTER("Unpaid days", '%1', TRUE);
                            IF COA.FINDSET THEN
                                REPEAT

                                    EmpAbs.RESET;
                                    EmpAbs.SETFILTER("Employee No.", '%1', ETemp."No.");
                                    EmpAbs.SETFILTER("From Date", '%1..%2', FirstDateOfMonth, LastDateOfMonth);
                                    EmpAbs.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                    IF EmpAbs.FINDFIRST THEN BEGIN
                                        EmpAbs.CALCSUMS(Quantity);
                                        Neplaceni := Neplaceni + EmpAbs.Quantity;

                                    END;
                                UNTIL COA.NEXT = 0;
                        END;





                    UNTIL WC.NEXT = 0;
            UNTIL ETemp.NEXT = 0;



        WVEAdditions.RESET;
        WVEAdditions.SETFILTER("Employee No.", '%1', WC."Employee No.");
        WVEAdditions.SETFILTER("Wage Calculation Type", '%1', WVEAdditions."Wage Calculation Type"::Additions);
        WVEAdditions.SETFILTER("Document No.", '%1', WC."Wage Header No.");
        WVEAdditions.SETFILTER("Entry Type", '%1|%2|%3|%4', WVEAdditions."Entry Type"::"Net Wage", WVEAdditions."Entry Type"::"Work Experience",
        WVEAdditions."Entry Type"::Taxable, WVEAdditions."Entry Type"::Untaxable);
        WVEAdditions.CALCFIELDS("RAD-1 Wage Excluded");
        WVEAdditions.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);
        IF WVEAdditions.FINDFIRST THEN BEGIN

            WVEAdditions.CALCSUMS("Cost Amount (Brutto)");
            WVEAdditions.CALCSUMS("Cost Amount (Actual)");


            DodatnoBruto := DodatnoBruto + WVEAdditions."Cost Amount (Brutto)";
            DodatnoNeto := DodatnoNeto + WVEAdditions."Cost Amount (Netto)";

        END;




        //oduzmi od bruta




        output[6] [1] := ROUND(sumaTemp1 + DodatnoBruto - Oduzmi, 1, '=');
        output[6] [2] := ROUND(output[6] [1] * 0.31, 1, '=');
        output[6] [3] := ROUND(sumaTemp3 + DodatnoDohodak - OduzmiPorez, 1, '=');
        output[6] [4] := ROUND(sumaTemp4 + DodatnoNeto, 1, '=');
        output[6] [5] := ETemp.COUNT;
        IF ETemp.COUNT <> 0 THEN
            outputdecimal[1] [1] := ROUND((sumaTemp1 + DodatnoBruto - Oduzmi) / ETemp.COUNT, 0.0001, '=')
        ELSE
            outputdecimal[1] [1] := 0;

        IF ETemp.COUNT <> 0 THEN
            NetoPros := ROUND((output[6] [1] - output[6] [2] - output[6] [3]) / ETemp.COUNT, 0.0001, '=')
        ELSE
            NetoPros := 0;


        //bruto prosjecni

        outputdecimal[1] [2] := sumaTemp5;
        //SumaKorekcija:=SumaKorekcija+sumaTemp5;
        BrojPlacenih := ROUND(sumaTemp5 + SumaKorekcija - Neplaceni + DodatniSiht, 1, '=');

        SickHour := 0;
        Bolesti := 0;
        EmpAbs.RESET;

        //sati na bolovanju

        StartDateD := DMY2DATE(1, Month, Year);
        EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
        CO.RESET;
        CO.SETFILTER("Sick Leave RAD -1", '%1', TRUE);
        IF CO.FINDSET THEN
            REPEAT
                ETemp.RESET;
                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                IF ETemp.FIND('-') THEN
                    REPEAT
                        EmpAbs.RESET;

                        EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                        EmpAbs.SETFILTER("Employee No.", '%1', ETemp."No.");
                        EmpAbs.SETFILTER("Cause of Absence Code", '%1', CO.Code);
                        IF EmpAbs.FINDFIRST THEN BEGIN
                            EmpAbs.CALCSUMS(Quantity);
                            SickHour += EmpAbs.Quantity;
                        END;

                    UNTIL ETemp.NEXT = 0;


            UNTIL CO.NEXT = 0;





        //END;



        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        IF ETemp.FIND('-') THEN
            REPEAT

                WAD.RESET;
                WAD.SETFILTER("Hours Sick Leave", '%1', TRUE);
                IF WAD.FINDSET THEN
                    REPEAT
                        wADD.RESET;
                        wADD.SETFILTER("Month of Wage", '%1', DATE2DMY(FirstDateOfMonth, 2));
                        wADD.SETFILTER("Year of Wage", '%1', DATE2DMY(FirstDateOfMonth, 3));
                        wADD.SETFILTER("Employee No.", '%1', ETemp."No.");
                        wADD.SETFILTER("Wage Addition Type", '%1', WAD.Code);
                        IF wADD.FINDSET THEN
                            REPEAT
                                Bolesti := Bolesti + wADD."No. Of Hours";
                            UNTIL wADD.NEXT = 0;

                    UNTIL WAD.NEXT = 0;

            UNTIL ETemp.NEXT = 0;
        SickHour := SickHour + Bolesti;


        ETemp.RESET;
        EmpAbs.RESET;
        CO.RESET;
        //sati godisnjeg odmora
        ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        IF ETemp.FIND('-') THEN BEGIN
            REPEAT
                EmpAbs.SETFILTER("Employee No.", ETemp."No.");
                IF EmpAbs.FIND('-') THEN
                    StartDateD := DMY2DATE(1, Month, Year);
                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                CO.SETRANGE(Vacation, TRUE);
                //CO.SETRANGE("No Report",FALSE);
                IF CO.FIND('-') THEN
                    REPEAT
                        EmpAbs.SETRANGE("Cause of Absence Code", CO.Code);
                        EmpAbs.CALCSUMS(Quantity);
                        GOHour += EmpAbs.Quantity;
                    UNTIL CO.NEXT = 0;
            UNTIL ETemp.NEXT = 0;
        END;
        ETemp.RESET;
        DRHour := 0;
        CO.RESET;

        //sati praznika
        CO.RESET;
        CO.SETRANGE(Holiday, TRUE);
        IF CO.FIND('-') THEN
            REPEAT


                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                IF ETemp.FIND('-') THEN BEGIN
                    REPEAT
                        EmpAbs.RESET;
                        EmpAbs.SETFILTER("Employee No.", ETemp."No.");
                        StartDateD := DMY2DATE(1, Month, Year);
                        EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                        EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                        EmpAbs.SETRANGE("Cause of Absence Code", CO.Code);
                        IF EmpAbs.FIND('-') THEN BEGIN
                            EmpAbs.CALCSUMS(Quantity);
                            DRHour += EmpAbs.Quantity;
                        END;
                    UNTIL ETemp.NEXT = 0;
                END;
            UNTIL CO.NEXT = 0;


        ETemp.RESET;
        DRHourAdd := 0;
        CO.RESET;

        //sati prekovremeni
        CO.RESET;
        CO.SETRANGE("Add Hours", TRUE);
        IF CO.FIND('-') THEN
            REPEAT


                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                IF ETemp.FIND('-') THEN BEGIN
                    REPEAT
                        EmpAbs.RESET;
                        EmpAbs.SETFILTER("Employee No.", ETemp."No.");
                        StartDateD := DMY2DATE(1, Month, Year);
                        EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                        EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                        EmpAbs.SETRANGE("Cause of Absence Code", CO.Code);
                        IF EmpAbs.FIND('-') THEN BEGIN
                            EmpAbs.CALCSUMS(Quantity);
                            DRHourAdd += EmpAbs.Quantity;
                        END;
                    UNTIL ETemp.NEXT = 0;
                END;
            UNTIL CO.NEXT = 0;

        Sumaprekododataka := 0;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        IF ETemp.FIND('-') THEN
            REPEAT

                WAD.RESET;
                WAD.SETFILTER("Add Hours", '%1', TRUE);
                IF WAD.FINDSET THEN
                    REPEAT
                        wADD.RESET;
                        wADD.SETFILTER("Month of Wage", '%1', DATE2DMY(FirstDateOfMonth, 2));
                        wADD.SETFILTER("Year of Wage", '%1', DATE2DMY(FirstDateOfMonth, 3));
                        wADD.SETFILTER("Employee No.", '%1', ETemp."No.");
                        wADD.SETFILTER("Wage Addition Type", '%1', WAD.Code);
                        IF wADD.FINDSET THEN
                            REPEAT
                                Sumaprekododataka := Sumaprekododataka + wADD."No. Of Hours";
                            UNTIL wADD.NEXT = 0;

                    UNTIL WAD.NEXT = 0;

            UNTIL ETemp.NEXT = 0;
        DRHourAdd := DRHourAdd + Sumaprekododataka;




        ETemp.RESET;
        EmpAbs.RESET;
        CO.RESET;
        PLHour := 0;
        CO.SETRANGE("Calculation Type", CO."Calculation Type"::"Paid Absence");
        IF CO.FINDSET THEN
            REPEAT
                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                IF ETemp.FIND('-') THEN
                    REPEAT
                        EmpAbs.SETFILTER("Employee No.", ETemp."No.");
                        StartDateD := DMY2DATE(1, Month, Year);
                        EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                        EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                        EmpAbs.SETRANGE("Cause of Absence Code", CO.Code);
                        IF EmpAbs.FIND('-') THEN BEGIN


                            EmpAbs.CALCSUMS(Quantity);
                            PLHour += EmpAbs.Quantity;

                        END;
                    UNTIL ETemp.NEXT = 0;

            UNTIL CO.NEXT = 0;

    end;

    procedure f3()
    var
        ETemp: Record "Employee" temporary;
        ETemp1: Record "Employee";
    begin
        Testttt2.DeleteAll();
        E.RESET;
        WH.RESET;
        sumaTemp7 := 0;
        SumaKorekcijeToplog := 0;
        sumaTemp8 := 0;
        sumaTemp9 := 0;
        Sumica := 0;
        DodatnoRegresBrojLjudi := 0;
        DodatnoRegresBruto := 0;
        DodatnoRegresOp := 0;
        DodatnoUkupnoRegres := 0;

        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;

        WH.SETRANGE("Month Of Wage", DATE2DMY(FirstDateOfMonth, 2));
        WH.SETRANGE("Year Of Wage", DATE2DMY(FirstDateOfMonth, 3));

        WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);
        IF WH.FIND('-') THEN BEGIN
            WC.RESET;
            WC.SETRANGE("Wage Header No.", WH."No.");
            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
            // WC.SETRANGE("Department Municipality",Municipality);
            IF WC.FIND('-') THEN
                REPEAT
                    ECL2.RESET;
                    ECL2.SETFILTER("Employee No.", '%1', WC."Employee No.");
                    ECL2.SETFILTER("Starting Date", '<=%1', End2);
                    ECL2.SETFILTER("Report Ending Date", '>=%1', End2);
                    ECL2.SETFILTER("Org Municipality of ag", '%1', Municipality);
                    IF OrgJeddd <> '' THEN BEGIN
                        Org.RESET;
                        Org.SETFILTER(Description, '%1', OrgJeddd);
                        Org.SETFILTER(Active, '%1', TRUE);
                        IF Org.FINDFIRST THEN BEGIN
                            /*   IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                                   ECL2.SETFILTER("Org Unit Name", '%1', OrgJeddd)
                               ELSE
                                   ECL2.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
                        END;
                    END;

                    ECL2.SETFILTER("Show Record", '%1', TRUE);
                    IF ECL2.FINDFIRST THEN BEGIN
                        E.GET(WC."Employee No.");
                        ETemp.INIT;
                        ETemp."No." := WC."Employee No.";
                        i := WC."Calculation Type";
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := Start2;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."E-Mail" := OrgJeddd;
                        IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;

                    END;
                UNTIL WC.NEXT = 0;

            WH.SETRANGE("Month Of Wage", DATE2DMY(FirstDateOfMonth, 2));
            WH.SETRANGE("Year Of Wage", DATE2DMY(FirstDateOfMonth, 3));

            WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);
            IF WH.FIND('-') THEN BEGIN
                WC.RESET;
                WC.SETRANGE("Wage Header No.", WH."No.");
                WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                // WC.SETRANGE("Department Municipality",Municipality);
                IF WC.FIND('-') THEN
                    REPEAT
                        ECL2.RESET;
                        ECL2.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        ECL2.SETFILTER("Ending Date", '<%1 & >=%2', End2, Start2);
                        ECL2.SETFILTER("Org Municipality of ag", '%1', Municipality);
                        IF OrgJeddd <> '' THEN BEGIN
                            Org.RESET;
                            Org.SETFILTER(Description, '%1', OrgJeddd);
                            Org.SETFILTER(Active, '%1', TRUE);
                            IF Org.FINDFIRST THEN BEGIN
                                /*  IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                                      ECL2.SETFILTER("Org Unit Name", '%1', OrgJeddd)
                                  ELSE
                                      ECL2.SETFILTER("GF of work Description", '%1', OrgJeddd);*/
                            END;
                        END;
                        ECL2.SETFILTER("Grounds for Term. Description", '<>%1', '');
                        ECL2.SETFILTER("Show Record", '%1', TRUE);
                        IF ECL2.FINDFIRST THEN BEGIN
                            E.GET(WC."Employee No.");
                            ETemp.INIT;
                            ETemp."No." := WC."Employee No.";
                            i := WC."Calculation Type";
                            ETemp."First Name" := FORMAT(i);
                            ETemp."Termination Date" := Start2;
                            ETemp."Org Municipality" := Municipality;
                            ETemp."E-Mail" := OrgJeddd
                        END;

                        IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;
                    //


                    UNTIL WC.NEXT = 0;

            END;


            Testttt.DELETEALL;
            // topli obrok
            ETemp.RESET;
            ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
            ETemp.SETFILTER("Org Municipality", Municipality);
            IF OrgJeddd <> '' THEN
                ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);

            IF ETemp.FIND('-') THEN
                REPEAT
                    WageV.RESET;
                    WageV.SETFILTER("Entry Type", '%1|%2', WageV."Entry Type"::"Meal to pay", WageV."Entry Type"::"Meal to refund");
                    WageV.SETFILTER("Employee No.", '%1', ETemp."No.");
                    WageV.SETFILTER("Document No.", '%1', WH."No.");
                    WageV.SETFILTER("Cost Amount (Brutto)", '%1', 0);
                    IF WageV.FINDSET THEN
                        REPEAT


                            sumaTemp7 := sumaTemp7 + ROUND(WageV."Cost Amount (Netto)", 0.0001, '>');

                            Testttt.RESET;
                            Testttt.SETFILTER("Employee No.", '%1', WageV."Employee No.");
                            IF NOT Testttt.FINDFIRST THEN BEGIN
                                Testttt.INIT;
                                //Testttt2.RESET;
                                // Testttt2.SETCURRENTKEY("Entry No.");
                                /*IF Testttt2.FINDLAST THEN
                                   Testttt."Entry No.":=Testttt2."Entry No."+1
                                ELSE
                                  Testttt."Entry No.":=1;*/
                                IF EVALUATE(iNTV, WageV."Employee No.") THEN
                                    Testttt.Order := iNTV;
                                Testttt."Employee No." := WageV."Employee No.";
                                Testttt.INSERT;
                            END;


                        //output[5][2]+=1;
                        UNTIL WageV.NEXT = 0;

                    WageAddTopli.RESET;
                    WageAddTopli.SETFILTER("Meal add RAD", '%1', TRUE);
                    IF WageAddTopli.FINDSET THEN
                        REPEAT

                            WageVTopli.RESET;
                            WageVTopli.SETFILTER("Employee No.", '%1', ETemp."No.");
                            WageVTopli.SETFILTER("Document No.", '%1', WH."No.");
                            WageVTopli.SETFILTER("Cost Amount (Brutto)", '%1', 0);
                            WageVTopli.SETFILTER(Description, '%1', WageAddTopli.Code);
                            IF WageVTopli.FINDFIRST THEN BEGIN

                                WageVTopli.CALCSUMS("Cost Amount (Netto)");
                                SumaKorekcijeToplog := SumaKorekcijeToplog + ROUND(WageVTopli."Cost Amount (Netto)", 0.0001, '>');

                            END;

                        UNTIL WageAddTopli.NEXT = 0;


                UNTIL ETemp.NEXT = 0;


            output[5] [1] := ROUND(sumaTemp7 + SumaKorekcijeToplog, 1, '=');



            //oporezivi
            sumaaa8 := 0;
            sumaaa9 := 0;
            suma8topli := 0;
            suma9topli := 0;
            // topli obrok
            ETemp.RESET;
            ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
            ETemp.SETFILTER("Org Municipality", Municipality);
            IF OrgJeddd <> '' THEN
                ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);


            IF ETemp.FIND('-') THEN
                REPEAT
                    WageV.RESET;
                    WageV.SETFILTER("Entry Type", '%1|%2', WageV."Entry Type"::"Meal to pay", WageV."Entry Type"::"Meal to refund");
                    WageV.SETFILTER("Employee No.", '%1', ETemp."No.");
                    WageV.SETFILTER("Document No.", '%1', WH."No.");
                    WageV.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                    IF WageV.FINDSET THEN
                        REPEAT


                            sumaaa8 := sumaaa8 + ROUND(WageV."Cost Amount (Netto)", 0.0001, '>');
                            Sumica := Sumica + ROUND(WageV."Cost Amount (Brutto)", 0.0001, '>');
                            output[5] [8] += 1;
                            Testttt.RESET;
                            Testttt.SETFILTER("Employee No.", '%1', WageV."Employee No.");
                            IF NOT Testttt.FINDFIRST THEN BEGIN
                                Testttt.INIT;

                                IF EVALUATE(iNTV, WageV."Employee No.") THEN
                                    Testttt.Order := iNTV;
                                Testttt."Employee No." := WageV."Employee No.";
                                Testttt.INSERT;
                            END;

                        UNTIL WageV.NEXT = 0;

                    WageAddTopli.RESET;
                    WageAddTopli.SETFILTER("Meal add RAD", '%1', TRUE);
                    IF WageAddTopli.FINDSET THEN
                        REPEAT

                            WageVTopli.RESET;
                            WageVTopli.SETFILTER("Employee No.", '%1', ETemp."No.");
                            WageVTopli.SETFILTER("Document No.", '%1', WH."No.");
                            WageVTopli.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                            WageVTopli.SETFILTER(Description, '%1', WageAddTopli.Code);
                            IF WageVTopli.FINDFIRST THEN BEGIN

                                WageVTopli.CALCSUMS("Cost Amount (Netto)", "Cost Amount (Brutto)");
                                suma8topli := suma8topli + ROUND(WageVTopli."Cost Amount (Netto)", 0.0001, '>');
                                suma9topli := suma9topli + ROUND(WageVTopli."Cost Amount (Brutto)", 0.0001, '>');

                            END;

                        UNTIL WageAddTopli.NEXT = 0;


                UNTIL ETemp.NEXT = 0;

            output[5] [9] := ROUND(sumaaa8 + suma8topli, 1, '=');
            output[5] [10] := ROUND(Sumica + suma9topli, 1, '=');
            //oporezivi


            Testttt.RESET;
            IF Testttt.FINDFIRST THEN
                output[5] [2] := Testttt.COUNT;






            //output[5][2]:= WC.COUNT;


            //prevoz
            WC.RESET;
            WC.SETRANGE("Wage Header No.", WH."No.");
            ETemp.RESET;
            ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
            ETemp.SETFILTER("Org Municipality", Municipality);
            IF OrgJeddd <> '' THEN
                ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
            WC.SETFILTER(Transport, '<>%1', 0);


            IF ETemp.FIND('-') THEN
                REPEAT
                    IF WC.FIND('-') THEN
                        REPEAT
                            IF WC."Employee No." = ETemp."No." THEN BEGIN
                                sumaTemp8 := sumaTemp8 + ROUND(WC.Transport, 0.0001, '>');
                                output[5] [4] += 1;
                            END;
                        UNTIL WC.NEXT = 0;
                UNTIL ETemp.NEXT = 0;

            output[5] [3] := ROUND(sumaTemp8, 1, '=');


            //ukupan iznos za regres
            //prevoz

            /*WageType.SETFILTER("RAD 1 Dodaci",'%1',TRUE);
            IF WageAddition.FINDFIRST THEN BEGIN
            WageAddition.RESET;
            WageAddition
              WageV.RESET;
              WageV.SETFILTER("Employee No.",'%1',WC."Employee No.");
              WageV.SETFILTER("Wage Addition Type",'%1', WageType.Code);

              WageV.CALCSUMS("Cost Amount (Brutto)");
              WageV.CALCSUMS("Cost Amount (Netto)");*/







            /*END;
            UNTIL WageType.NEXT=0;*/
            Testttt.DELETEALL;

            WC.RESET;
            WC.SETRANGE("Wage Header No.", WH."No.");
            ETemp.RESET;
            ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
            ETemp.SETFILTER("Org Municipality", Municipality);
            IF OrgJeddd <> '' THEN
                ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
            //WC.SETFILTER(Vacation, '<>%1',0 );
            IF ETemp.FIND('-') THEN
                REPEAT
                    IF WC.FIND('-') THEN
                        REPEAT
                            IF WC."Employee No." = ETemp."No." THEN BEGIN
                                WC.CALCFIELDS("Regres Netto With Wage UnTax", "Regres Netto UnTax Separate");

                                sumaTemp9 := sumaTemp9 + ROUND(WC."Regres Netto With Wage UnTax" + WC."Regres Netto UnTax Separate", 0.00001, '>');
                                IF (WC."Regres Netto With Wage UnTax" + WC."Regres Netto UnTax Separate") <> 0 THEN BEGIN
                                    Testttt.RESET;
                                    Testttt.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                    IF NOT Testttt.FINDFIRST THEN BEGIN
                                        Testttt.INIT;

                                        IF EVALUATE(iNTV, WC."Employee No.") THEN
                                            Testttt.Order := iNTV;
                                        Testttt."Employee No." := WC."Employee No.";
                                        Testttt.INSERT;
                                    END;
                                END;


                                output[5] [6] += 1;
                            END;
                        UNTIL WC.NEXT = 0;
                UNTIL ETemp.NEXT = 0;

            output[5] [5] := ROUND(sumaTemp9, 1, '=');

        END;
        //oporezici
        NemaOp := FALSE;
        WC.RESET;
        WC.SETRANGE("Wage Header No.", WH."No.");
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        // WC.SETFILTER(Vacation, '<>%1',0 );
        IF ETemp.FIND('-') THEN
            REPEAT
                IF WC.FIND('-') THEN
                    REPEAT
                        IF WC."Employee No." = ETemp."No." THEN BEGIN
                            IF NemaOp = FALSE THEN
                                output[5] [6] += 0;
                            WC.CALCFIELDS("Regres Netto Tax Separate", "Regres Netto With Wage Taxable", "Regres Netto With Wage Tax RAD");
                            sumaTemp10 := sumaTemp10 + ROUND(WC."Regres Netto Tax Separate" + WC."Regres Netto With Wage Tax RAD", 0.0001, '>');
                            output[5] [6] += 1;
                            output[6] [6] += 1;
                        END;
                    UNTIL WC.NEXT = 0;
            UNTIL ETemp.NEXT = 0;

        output[6] [7] := ROUND(sumaTemp10, 1, '=');

        WC.RESET;
        WC.SETRANGE("Wage Header No.", WH."No.");
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJeddd <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
        // WC.SETFILTER(Vacation, '<>%1',0 );
        IF ETemp.FIND('-') THEN
            REPEAT
                IF WC.FIND('-') THEN
                    REPEAT
                        IF WC."Employee No." = ETemp."No." THEN BEGIN
                            WC.CALCFIELDS("Regres Brutto");
                            sumaTemp11 := sumaTemp11 + ROUND(WC."Regres Brutto", 0.0001, '>');
                            //ĐK     IF ROUND(WC."Regres Brutto",0.0001, '>') > 0.0001 THEN

                            IF WC."Regres Brutto" <> 0 THEN BEGIN
                                Testttt.RESET;
                                Testttt.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                IF NOT Testttt.FINDFIRST THEN BEGIN
                                    Testttt.INIT;

                                    IF EVALUATE(iNTV, WC."Employee No.") THEN
                                        Testttt.Order := iNTV;
                                    Testttt."Employee No." := WC."Employee No.";
                                    Testttt.INSERT;
                                END;



                            END;
                        END;
                    UNTIL WC.NEXT = 0;
            UNTIL ETemp.NEXT = 0;

        output[6] [9] := ROUND(sumaTemp11, 1, '=');


        Testttt.RESET;
        IF Testttt.FINDFIRST THEN
            output[6] [8] := Testttt.COUNT
        ELSE
            output[6] [8] := 0;




        Naknadeljudi := 0;
        Naknadeljudi2 := 0;
        WA.RESET;
        Testttt.DELETEALL;
        WA.SETFILTER("Bonus and material right", '%1', TRUE);
        IF WA.FINDSET THEN
            REPEAT

                //ostala novcana primanja
                ETemp.RESET;
                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                // WC.SETFILTER(Vacation, '<>%1',0 );
                IF ETemp.FIND('-') THEN
                    REPEAT
                        WageV.RESET;
                        //WageV.SETFILTER("Entry Type",'%1|%2',WageV."Entry Type"::"Meal to pay",WageV."Entry Type"::"Meal to refund");
                        WageV.SETFILTER("Employee No.", '%1', ETemp."No.");
                        WageV.SETFILTER("Document No.", '%1', WH."No.");
                        WageV.SETFILTER("Cost Amount (Brutto)", '%1', 0);
                        WageV.SETFILTER(Description, '%1', WA.Code);
                        IF WageV.FINDSET THEN
                            REPEAT
                                Naknade := Naknade + ROUND(WageV."Cost Amount (Netto)", 0.0001, '>');
                                IF ROUND(WageV."Cost Amount (Netto)", 0.0001, '>') > 0.0001 THEN
                                    Naknadeljudi2 := Naknadeljudi2 + 1;

                                Testttt.RESET;
                                Testttt.SETFILTER("Employee No.", '%1', WageV."Employee No.");
                                IF NOT Testttt.FINDFIRST THEN BEGIN
                                    Testttt.INIT;

                                    IF EVALUATE(iNTV, WageV."Employee No.") THEN
                                        Testttt.Order := iNTV;
                                    Testttt."Employee No." := WageV."Employee No.";
                                    Testttt.INSERT;
                                END;
                            UNTIL WageV.NEXT = 0;


                    /* IF ROUND(WageV."Cost Amount (Actual)",0.0001, '>') > 0.0001 THEN
                   Naknadeljudi:=Naknadeljudi+1;*/
                    UNTIL ETemp.NEXT = 0;
            UNTIL WA.NEXT = 0;



        NaknadeOporezive := 0;
        NemaOp := FALSE;
        //NAKNADE OPOREZIVE
        WA.RESET;
        WA.SETFILTER("Bonus and material right", '%1', TRUE);
        IF WA.FINDSET THEN
            REPEAT


                //ostala novcana primanja
                ETemp.RESET;
                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                // WC.SETFILTER(Vacation, '<>%1',0 );
                IF ETemp.FIND('-') THEN
                    REPEAT
                        ///ĐK NaknadeOporezive:=0;
                        //Naknadeljudi2:=0;
                        WageV.RESET;

                        //WageV.SETFILTER("Entry Type",'%1|%2',WageV."Entry Type"::"Meal to pay",WageV."Entry Type"::"Meal to refund");
                        WageV.SETFILTER("Employee No.", '%1', ETemp."No.");
                        WageV.SETFILTER("Document No.", '%1', WH."No.");
                        WageV.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        WageV.SETFILTER(Description, '%1', WA.Code);
                        IF WageV.FINDSET THEN
                            REPEAT

                                //IF ROUND(WageV."Cost Amount (Actual)",0.0001, '>') > 0.0001 THEN
                                // Naknadeljudi2:=Naknadeljudi2+1;
                                NaknadeOporezive := NaknadeOporezive + ROUND(WageV."Cost Amount (Netto)", 0.0001, '>');

                                Testttt.RESET;
                                Testttt.SETFILTER("Employee No.", '%1', WageV."Employee No.");
                                IF NOT Testttt.FINDFIRST THEN BEGIN
                                    Testttt.INIT;
                                    /*Testttt2.RESET;
                                    Testttt2.SETCURRENTKEY("Entry No.");
                                    IF Testttt2.FINDLAST THEN
                                       Testttt."Entry No.":=Testttt2."Entry No."+1
                                    ELSE
                                      Testttt."Entry No.":=1;*/
                                    IF EVALUATE(iNTV, WageV."Employee No.") THEN
                                        Testttt.Order := iNTV;
                                    Testttt."Employee No." := WageV."Employee No.";
                                    Testttt.INSERT;
                                END;


                            UNTIL WageV.NEXT = 0;

                    UNTIL ETemp.NEXT = 0;
            UNTIL WA.NEXT = 0;


        Testttt.RESET;
        IF Testttt.FINDFIRST THEN
            Naknadeljudi := Testttt.COUNT;


        NaknadeBruto := 0;
        //NAKNADE OPOREZIVE
        WA.RESET;
        WA.SETFILTER("Bonus and material right", '%1', TRUE);
        IF WA.FINDSET THEN
            REPEAT
                //ostala novcana primanja

                ETemp.RESET;
                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                // WC.SETFILTER(Vacation, '<>%1',0 );
                IF ETemp.FIND('-') THEN
                    REPEAT

                        WageV.RESET;
                        //WageV.SETFILTER("Entry Type",'%1|%2',WageV."Entry Type"::"Meal to pay",WageV."Entry Type"::"Meal to refund");
                        WageV.SETFILTER("Employee No.", '%1', ETemp."No.");
                        WageV.SETFILTER("Document No.", '%1', WH."No.");
                        WageV.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        WageV.SETFILTER(Description, '%1', WA.Code);
                        /// WageV.CALCFIELDS("RAD-1 Wage Other");
                        // WageV.SETFILTER("RAD-1 Wage Other",'%1',TRUE);
                        IF WageV.FINDSET THEN
                            REPEAT
                                NaknadeBruto := NaknadeBruto + ROUND(WageV."Cost Amount (Brutto)", 0.0001, '>');

                            UNTIL WageV.NEXT = 0;

                    UNTIL ETemp.NEXT = 0;
            UNTIL WA.NEXT = 0;



        //ostale naknade

        OstaleNaknade := 0;
        //NAKNADE OPOREZIVE
        WA.RESET;
        WA.SETFILTER("Other bonus from brutto", '%1', TRUE);
        IF WA.FINDSET THEN
            REPEAT
                //ostala novcana primanja
                ETemp.RESET;
                ETemp.SETFILTER("Termination Date", '>%2', 0D, DayBeforeFirstDate);
                ETemp.SETFILTER("Org Municipality", Municipality);
                IF OrgJeddd <> '' THEN
                    ETemp.SETFILTER("E-Mail", '%1', OrgJeddd);
                // WC.SETFILTER(Vacation, '<>%1',0 );
                IF ETemp.FIND('-') THEN
                    REPEAT

                        WageV.RESET;
                        //WageV.SETFILTER("Entry Type",'%1|%2',WageV."Entry Type"::"Meal to pay",WageV."Entry Type"::"Meal to refund");
                        WageV.SETFILTER("Employee No.", '%1', ETemp."No.");
                        WageV.SETFILTER("Document No.", '%1', WH."No.");
                        WageV.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        WageV.SETFILTER(Description, '%1', WA.Code);
                        IF WageV.FINDSET THEN
                            REPEAT
                                OstaleNaknade := OstaleNaknade + ROUND(WageV."Cost Amount (Brutto)", 0.0001, '>');
                            UNTIL WageV.NEXT = 0;

                    UNTIL ETemp.NEXT = 0;
            UNTIL WA.NEXT = 0;

        //END;

    end;

    procedure f7()
    var
        ETemp: Record "Employee" temporary;
    begin
    end;

    procedure f7a()
    var
        ETemp: Record "Employee" temporary;
    begin
    end;

    procedure f8()
    var
        ETemp: Record "Employee" temporary;
        ETemp2: Record "Employee" temporary;
        ETemp3: Record "Employee" temporary;
    begin
    end;

    procedure f8a()
    var
        ETemp: Record "Employee" temporary;
        ETemp2: Record "Employee" temporary;
        ETemp3: Record "Employee" temporary;
        ETemp4: Record "Employee" temporary;
        ETemp5: Record "Employee" temporary;
        ETemp6: Record "Employee" temporary;
        ETemp7: Record "Employee" temporary;
        ETemp8: Record "Employee" temporary;
    begin
    end;
}

