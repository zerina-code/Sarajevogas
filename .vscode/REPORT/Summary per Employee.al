report 50053 "Summarry Per Employee"
{
    // //
    DefaultLayout = RDLC;
    RDLCLayout = './Summarry Per Employee.rdl';

    Caption = 'Summary per Employee';

    dataset
    {
        dataitem(WC; "Wage Calculation")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("No." = FILTER(<> ''));
            RequestFilterFields = "No.", "Month Of Wage", "Year of Wage", "Wage Calculation Type", "Contribution Category Code";
            column(CompanyName; CompInfo.Name)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Obustave; Obustave) { }
            column(Picture; CompInfo.Picture)
            {
            }
            column(User; USERID)
            {
            }
            column(IDYear; IDYear)
            {
            }
            column(EmployeeID; employee."Employee ID")
            {
            }
            column(LastName; LastName)
            {
            }
            column(FirstName; FirstName)
            {
            }
            column(No; "Employee No.")
            {
            }
            column(WageBase; "Wage (Base)")
            {
            }
            column(FinalNetWage; "Final Net Wage")
            {
            }
            column(WageReduction; "Wage Reduction")
            {
            }
            column(Payment; PaymentV)
            {
            }
            column(PreostaleUplateNetWage; "Net Wage")
            {
            }
            column(PreostaleUplateNetWageAT; NettoAmount)
            {
            }
            column(TaxLineIndirectWageAdditionAmount; "Indirect Wage Addition Amount")
            {
            }
            column(TaxDeductions; "Tax Deductions")
            {
            }
            column(tax; TaxR)
            {
            }
            column(Brutto; Brutto)
            {
            }
            column(ukupno2; ukupno2) { }
            column(regresTrosak; regresTrosak) { }
            column(WType; "Wage Calculation Type")
            {
            }
            column(ContributionFromBruto; ContributionFromBruto)
            {
            }
            column(ContributionOverBruto; ContributionOverBruto)
            {
            }
            column(UntaxableWage; "Untaxable Wage")
            {
            }
            column(Add; WC."Wage Addition")
            {
            }
            column(Transport; Transport)
            {
            }
            column(SatiMealToPay; "Meal to pay")
            {
            }
            column(AmountOverWage; "Contribution Over Brutto")
            {
            }
            column(HourPool; "Hour Pool")
            {
            }
            column(Sektor; Sektor)
            {
            }
            column(Odjel; Odjel)
            {
            }
            column(Grupa; Grupa)
            {
            }
            column(Tim; Tim)
            {
            }
            column(Deduction; "Wage Reduction")
            {
            }
            column(WHO; "Wage Header No.")
            {
            }
            column(WageType; WageType)
            {
            }
            column(PDate; PDate)
            {
            }
            column(CDate; CDate)
            {
            }
            column(RDate; RDate)
            {
            }
            column(Kredit; Kredit)
            {
            }
            column(TD; WC."Tax Deductions")
            {
            }
            column(AdditionalTax; WC."Contribution Over Netto")
            {
            }
            column(ContributionRS; WC."Reported Amount From Brutto")
            {
            }
            column(TaxRS; WC."Tax (RS)")
            {
            }
            column(RegresBrutto; WC."Regres Brutto")
            {
            }
            column(RegresNetto; WC."Regres Netto")
            {
            }
            column(OrgDio; OrgDio)
            {
            }
            column(NazivOrgDijela; NazivOrgDijela)
            {
            }
            column(OrgJedinica; OrgJedinica)
            {
            }
            column(NazivOrgJedinice; NazivOrgJedinice)
            {
            }
            column(JMB; WC."Employee No.")
            {
            }
            column(Gender; Gender)
            {
            }
            column(EmploymentDate; EmploymentDate)
            {
            }
            column(TerminationDate; TerminationDate)
            {
            }
            column(IDOJ; IDOJ)
            {
            }
            column(B1; B1)
            {
            }
            column(B1R; B1R)
            {
            }
            column(Str; Str)
            {
            }
            column(PositioCode; PositionCode)
            {
            }
            column(PositionDescription; PositionDescription)
            {
            }
            column(NivoRukovodstva; NivoRukovodstva)
            {
            }
            column(CubeFTE; CubeFTE)
            {
            }
            column(CostType; CostType)
            {
            }
            column(Type; Type)
            {
            }
            column(CubeCodeName; CubeCodeName)
            {
            }
            column(CubeHC; CubeHc)
            {
            }
            column(KoefOlaksice; WC."Tax Deductions")
            {
            }
            column(BaseDeduct; BaseDeduct)
            {
            }
            column(sumPIO; sumPIO)
            {
            }
            column(sumZDR; sumZDR)
            {
            }
            column(sumNZ; sumNZ)
            {
            }
            column(Djecija; Djecija)
            {
            }
            column(RVI; RVI)
            {
            }
            column(Komora; Komora)
            {
            }
            column(sumNZna; sumNZna)
            {
            }
            column(sumZDRna; sumZDRna)
            {
            }
            column(sumPIOna; sumPIOna)
            {
            }
            column(SMECORE; SMECORE)
            {
            }
            column(PROJFIN; PROJFIN)
            {
            }
            column(PUFIN; PUFIN)
            {
            }
            column(GM; GM)
            {
            }
            column(OVER; OVER)
            {
            }
            column(AFLUENT; AFFLUENT)
            {
            }
            column(ALM; ALM)
            {
            }
            column(SERVICE; SERVICE)
            {
            }
            column(BO; BO)
            {
            }
            column(HCC; HCC)
            {
            }
            column(HCP; HCP)
            {
            }
            column(MICRO; MICRO)
            {
            }
            column(PRIVATE; PRIVATE)
            {
            }
            column(vod; vod)
            {
            }
            column(elnep; elnep)
            {
            }
            column(TaxBasis; "Tax Basis")
            {
            }
            column(TotalCubeName; TotalCubeName)
            {
            }
            column(WEP; "Work Experience Percentage")
            {
            }
            column(WePNetto; "Experience Total")
            {
            }
            column(Use; "Use Netto")
            {
            }
            column(DepartmentType; DepartmentType)
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(regres; regres)
            {
            }
            column(regresneop; regresneop)
            {
            }
            column(topli; topli)
            {
            }
            column(toplineop; toplineop)
            {
            }
            column(prevoz; prevoz)
            {
            }
            column(prevozneop; prevozneop)
            {
            }
            column(ukupno; ukupno)
            {
            }
            column(Incentive; WC.Incentive)
            {
            }

            trigger OnAfterGetRecord()
            var
                EmplDefDim: Record "Employee Default Dimension";
            begin
                DateFrom := DMY2DATE(1, "Month Of Wage", "Year of Wage");
                DateTo := CALCDATE('-1D', CALCDATE('+1M', DateFrom));

                IF employee.GET("Employee No.") THEN BEGIN
                    FirstName := employee."First Name";
                    LastName := employee."Last Name";
                    Gender := employee.Gender;
                END;
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", '%1', employee."No.");
                EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', DateTo);
                EmployeeContractLedger.SETFILTER("Ending Date", '>=%1|%2', DateFrom, 0D);
                EmployeeContractLedger.SETCURRENTKEY("Starting Date");
                EmployeeContractLedger.ASCENDING;
                IF EmployeeContractLedger.FINDLAST THEN BEGIN
                    Sektor := EmployeeContractLedger."Sector Description";
                    Odjel := EmployeeContractLedger."Group Description";
                    Grupa := EmployeeContractLedger."Group Description";
                    Tim := EmployeeContractLedger."Team Description";
                END
                ELSE BEGIN
                    Sektor := '';
                    Odjel := '';
                    Grupa := '';
                    Tim := '';
                END;
                CompInfo.CALCFIELDS(Picture);
                IF Filter = '' THEN
                    WageType := 'Svi'

                ELSE
                    WageType := Filter;

                IF WH.GET("Wage Header No.") THEN BEGIN
                    PDate := WH."Payment Date";
                    CDate := WH."Date Of Calculation";
                END;
                RDate := TODAY;

                WageSetup.GET;
                BaseDeduct := WageSetup."Base Tax Deduction";

                RPE.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                RPE.SETFILTER("Employee No.", '%1', "Employee No.");
                RPE.SETFILTER(Type, '%1', 'KREDIT');

                Kredit := 0;
                IF RPE.FIND('-') THEN
                    REPEAT

                        Kredit += RPE.Amount;
                    UNTIL RPE.NEXT = 0;



                Obustave := 0;
                PAymentNetto := 0;
                UkupanDohodak := 0;
                WVE.SETFILTER("Employee No.", '%1', WC."Employee No.");
                WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                WVE.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7',
                WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience",
                WVE."Entry Type"::Taxable, WVE."Entry Type"::Untaxable, WVE."Entry Type"::"Meal to pay", WVE."Entry Type"::Transport);
                //2,12,14,13,11,7,9);
                IF WVE.FINDFIRST THEN BEGIN
                    WVE.CALCSUMS("Cost Amount (Netto)");
                    WVE.CALCSUMS("Cost Amount (Brutto)");
                    PAymentNetto := WVE."Cost Amount (Netto)";

                END;


                UkupanDohodak := PAymentNetto;
                Wve.RESET;
                Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                Wve.SETFILTER("Entry Type", '%1', Wve."Entry Type"::Reduction);
                IF Wve.FINDFIRST THEN BEGIN
                    Wve.CALCSUMS("Cost Amount (Actual)");
                    Obustave := Wve."Cost Amount (Actual)";
                END;
                AmountForPayment := 0;
                WVE.RESET;
                WVE.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                WVE.SETFILTER("Employee No.", '%1', WC."Employee No.");
                WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Untaxable,
                WVE."Entry Type"::Taxable, WVE."Entry Type"::"Meal to pay", WVE."Entry Type"::Transport, WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience");
                IF WVE.FINDFIRST THEN
                    REPEAT
                        AmountForPayment += WVE."Cost Amount (Netto)";
                    UNTIL WVE.NEXT = 0;



                /*IF (("Contribution Category Code"='FBIHRS') OR ("Contribution Category Code"='BDPIORS')) THEN // 'BPIORS'
                ContributionFromBruto:="Reported Amount From Brutto"
                ELSE
                  ContributionFromBruto:="Contribution From Brutto";
                
                IF (("Contribution Category Code"='FBIHRS') OR ("Contribution Category Code"='BDPIORS')) THEN  // 'BPIORS'
                ContributionOverBruto:=0
                ELSE
                  ContributionOverBruto:="Contribution Over Brutto";*/

                IF (("Contribution Category Code" = 'FBIHRS') OR ("Contribution Category Code" = 'BDPIORS')) THEN   // 'BPIORS'
                    TaxR := Tax
                ELSE
                    TaxR := Tax;

                if WC."Wage Type" = 'NETTO' then
                    PaymentV := UkupanDohodak - Obustave - Tax
                else
                    PaymentV := round(AmountForPayment, 0.00001, '>') - Obustave - TaxR;
                PaymentV := round(PaymentV, 0.00001, '=');

                IF (("Contribution Category Code" = 'FBIHRS') OR ("Contribution Category Code" = 'BDPIORS')) THEN   // 'BPIORS'
                BEGIN
                    IF (Brutto - "Contribution From Brutto" - Tax - "Wage Reduction") > 0 THEN
                        NettoAmount := Brutto - "Contribution From Brutto" - Tax - "Wage Reduction"
                    ELSE
                        NettoAmount := 0;
                END
                ELSE BEGIN
                    IF ("Net Wage After Tax" - "Use Netto" - "Wage Reduction") > 0 THEN
                        NettoAmount := "Net Wage After Tax" - "Use Netto"
                    // - "Wage Reduction"
                    ELSE
                        NettoAmount := 0;
                END;

                OrgDio := '';
                NazivOrgDijela := '';
                OrgJedinica := '';
                NazivOrgJedinice := '';
                IDOJ := '';
                B1 := '';
                B1R := '';
                Str := '';
                PositionCode := '';
                PositionDescription := '';
                NivoRukovodstva := '';
                DepartmentType := '';
                OVER := 0;
                SERVICE := 0;
                ALM := 0;
                MICRO := 0;
                PRIVATE := 0;
                AFFLUENT := 0;
                HCC := 0;
                HCP := 0;
                SMECORE := 0;

                topli := 0;
                toplineop := 0;
                regres := 0;
                regresneop := 0;
                Djecija := 0;
                Komora := 0;
                ukupno := 0;
                RVI := 0;
                PROJFIN := 0;
                PUFIN := 0;
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                IF EmployeeContractLedger.FINDLAST THEN BEGIN
                    EmployeeContractLedger.CALCFIELDS("Minimal Education Level");
                    EmployeeContractLedger.CALCFIELDS("Residence/Network");
                    //EmployeeContractLedger.CALCFIELDS("Sector Description","Department Cat. Description","Group Description");
                    PositionCode := EmployeeContractLedger."Position Code";
                    PositionDescription := EmployeeContractLedger."Position Description";
                    /*    SegmentationGroup.SETFILTER("Position No.", '%1', EmployeeContractLedger."Position Code");
                        SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                        SegmentationGroup.SETFILTER("Starting Date", '>=%1', DateFrom);
                        IF SegmentationGroup.FIND('+') THEN BEGIN
                            NivoRukovodstva := FORMAT(SegmentationGroup."Management Level");

                            CASE SegmentationGroup."Segmentation Code" OF
                                'SME CORE':
                                    BEGIN
                                        SMECORE := SegmentationGroup.Coefficient;
                                    END;
                                'PROJECT FINANCE':
                                    BEGIN
                                        PROJFIN := SegmentationGroup.Coefficient;
                                    END;
                                'PUBLIC FINANCE':
                                    BEGIN
                                        PUFIN := SegmentationGroup.Coefficient;
                                    END;
                                'GLOBAL MARKET':
                                    BEGIN
                                        GM := SegmentationGroup.Coefficient;
                                    END;
                                'PRIVATE':
                                    BEGIN
                                        PRIVATE := SegmentationGroup.Coefficient;
                                    END;

                                'MICRO':
                                    BEGIN
                                        MICRO := SegmentationGroup.Coefficient;
                                    END;

                                'AFFLUENT':
                                    BEGIN
                                        AFFLUENT := SegmentationGroup.Coefficient;
                                    END;
                                'OVERHEAD':
                                    BEGIN
                                        OVER := SegmentationGroup.Coefficient;
                                    END;
                                'ALM':
                                    BEGIN
                                        ALM := SegmentationGroup.Coefficient;
                                    END;
                                'SERVICE':
                                    BEGIN
                                        SERVICE := SegmentationGroup.Coefficient;
                                    END;
                                'BO':
                                    BEGIN
                                        BO := SegmentationGroup.Coefficient;
                                    END;
                                'HC CORE':
                                    BEGIN
                                        HCC := SegmentationGroup.Coefficient;
                                    END;
                                'HC PROJECT':
                                    BEGIN
                                        HCP := SegmentationGroup.Coefficient;
                                    END;
                            END;
                            //SegmentationGroup.SETFILTER("Segmentation Name",
                        END
                        ELSE BEGIN
                            NivoRukovodstva := '';
                        END;*/
                    TerminationDate := EmployeeContractLedger."Ending Date";
                    IF EmployeeContractLedger."Phisical Department Desc" <> '' THEN
                        Department.SETFILTER(Description, '%1', EmployeeContractLedger."Phisical Department Desc")
                    ELSE
                        Department.SETFILTER(Code, '%1', EmployeeContractLedger."Department Code");
                    IF Department.FIND('-') THEN BEGIN
                        OrgDio := COPYSTR(WC."Global Dimension 1 Code", 1, 3);
                        OrgJedinica := WC."Global Dimension 1 Code";
                        NazivOrgJedinice := Department.Description;
                        IDOJ := COPYSTR(WC."Global Dimension 1 Code", 1, 3);
                        B1 := EmployeeContractLedger."Sector Description";
                        B1R := EmployeeContractLedger."Department Cat. Description";
                        Str := EmployeeContractLedger."Group Description";
                        DepartmentType := FORMAT(Department."Department Type");
                    END
                    ELSE BEGIN
                        OrgDio := '';
                        OrgJedinica := '';
                        NazivOrgJedinice := '';
                        IDOJ := '';
                        B1 := '';
                        B1R := '';
                        Str := '';
                        DepartmentType := '';
                    END;
                    ORGD.SETFILTER(Code, '%1', Department."ORG Dio");
                    IF ORGD.FIND('-') THEN
                        NazivOrgDijela := ORGD.Description
                    ELSE
                        NazivOrgDijela := '';

                    CubeFTE := '';
                    CostType := '';
                    Type := '';
                    CubeCodeName := '';
                    CubeHc := '';
                    TotalCubeName := '';
                    Position.SETFILTER(Code, '%1', EmployeeContractLedger."Position Code");
                    Position.SETFILTER("Position ID", '%1', EmployeeContractLedger."Position ID");
                    IF Position.FIND('-') THEN BEGIN
                        CubeFTE := Position."Cube Codes";
                        CostType := Position."Cost Type";
                        Type := Position.Type;

                        /*  CC.SETFILTER("Cube Code FTE", '%1', Position."Cube Codes");
                          IF CC.FIND('-') THEN BEGIN
                              CubeCodeName := CC."Cube Code Name";
                              CubeHc := CC."Cube Code HC";
                              TotalCubeName := CC."Total Cube Code Name";
                          END
                          ELSE BEGIN*/
                        CubeCodeName := '';
                        CubeHc := '';
                        TotalCubeName := '';
                        // END;
                    END
                    ELSE BEGIN
                        CubeFTE := '';
                        CostType := '';
                        Type := '';
                    END
                END;

                EmploymentDate := 0D;
                WB.SETFILTER("Employee No.", '%1', "Employee No.");
                WB.SETFILTER("Current Company", '%1', TRUE);
                IF WB.FIND('-') THEN
                    EmploymentDate := WB."Starting Date"
                ELSE
                    EmploymentDate := 0D;


                sumZDR := 0;
                sumPIO := 0;
                sumNZ := 0;
                sumZDRna := 0;
                sumPIOna := 0;
                sumNZna := 0;



                t_ContrEmp.RESET;
                CLEAR(t_ContrEmp);
                t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp.SETFILTER("Contribution Code", '%1|%2', 'D-PIO-NA', 'D-PIORS');
                IF t_ContrEmp.FINDFIRST THEN
                    REPEAT
                        sumPIOna := t_ContrEmp."Amount Over Wage";
                    UNTIL t_ContrEmp.NEXT = 0;




                t_ContrEmp.RESET;
                CLEAR(t_ContrEmp);
                t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp.SETFILTER("Contribution Code", '%1|%2|%3', 'D-PIO-IZ', 'D-PIO-NA', 'D-PIORS');
                IF t_ContrEmp.FINDFIRST THEN
                    REPEAT
                        sumPIO += t_ContrEmp."Amount From Wage";
                    //       sumPIOna+=t_ContrEmp."Amount Over Wage"     ;
                    UNTIL t_ContrEmp.NEXT = 0;


                t_ContrEmp.RESET;
                CLEAR(t_ContrEmp);
                t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp.SETFILTER("Contribution Code", '%1', 'DJEC-ZAST');
                IF t_ContrEmp.FINDFIRST THEN
                    REPEAT
                        Djecija += t_ContrEmp."Amount From Wage";
                    //       sumPIOna+=t_ContrEmp."Amount Over Wage"     ;
                    UNTIL t_ContrEmp.NEXT = 0;



                WageSetup.GET;
                t_ContrEmp1.RESET;
                CLEAR(t_ContrEmp1);
                t_ContrEmp1.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp1.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp1.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp1.SETFILTER("Contribution Code", '%1|%2', 'D-ZDRAV-NA', 'D-ZDRAVRS');
                IF t_ContrEmp1.FINDFIRST THEN
                    REPEAT
                        IF t_ContrEmp1."Contribution Category Code" = 'FBIHRS' THEN
                            sumZDRna += t_ContrEmp1."Reported Amount From Wage" + ((WageSetup."Health Federation" / 100) * t_ContrEmp1."Amount Over Wage")
                        ELSE
                            sumZDRna += t_ContrEmp1."Amount Over Wage";
                    UNTIL t_ContrEmp1.NEXT = 0;

                t_ContrEmp1.RESET;
                CLEAR(t_ContrEmp1);
                t_ContrEmp1.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp1.SETFILTER("Wage Header No.", "Wage Header No.");
                // t_ContrEmp1.SETFILTER("Wage Calc No.","No.");
                t_ContrEmp1.SETFILTER("Contribution Code", '%1|%2|%3', 'D-ZDRAV-IZ', 'D-ZDRAV-NA', 'D-ZDRAVRS');
                IF t_ContrEmp1.FINDFIRST THEN
                    REPEAT
                        IF t_ContrEmp1."Contribution Category Code" = 'FBIHRS' THEN
                            sumZDR += t_ContrEmp1."Reported Amount From Wage" + ((WageSetup."Health Federation" / 100) * t_ContrEmp1."Amount From Wage")
                        ELSE
                            sumZDR += t_ContrEmp1."Amount From Wage";
                    // sumZDRna:=t_ContrEmp1."Amount Over Wage"     ;
                    UNTIL t_ContrEmp1.NEXT = 0;

                t_ContrEmp2.RESET;
                CLEAR(t_ContrEmp2);
                t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp2.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp2.SETFILTER("Contribution Code", '%1|%2', 'D-NEZAP-NA', 'D-ZAPOŠRS');
                IF t_ContrEmp2.FINDFIRST THEN
                    REPEAT
                        IF t_ContrEmp2."Contribution Category Code" = 'FBIHRS' THEN
                            sumNZna := t_ContrEmp2."Reported Amount From Wage" + ((WageSetup."Unemployment Federation" / 100) * t_ContrEmp2."Amount Over Wage")
                        ELSE
                            sumNZna := t_ContrEmp2."Amount Over Wage";
                    UNTIL t_ContrEmp2.NEXT = 0;


                t_ContrEmp2.RESET;
                CLEAR(t_ContrEmp2);
                t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp2.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp2.SETFILTER("Contribution Code", '%1', 'P-RVI');
                IF t_ContrEmp2.FINDFIRST THEN
                    REPEAT
                        IF t_ContrEmp2."Contribution Category Code" = 'FBIHRS' THEN
                            RVI := t_ContrEmp2."Reported Amount From Wage" + ((WageSetup."Unemployment Federation" / 100) * t_ContrEmp2."Amount Over Wage")
                        ELSE
                            RVI := t_ContrEmp2."Amount Over Wage";
                    UNTIL t_ContrEmp2.NEXT = 0;
                //P-KOM

                t_ContrEmp2.RESET;
                CLEAR(t_ContrEmp2);
                t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp2.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp2.SETFILTER("Contribution Code", '%1', 'P-KOM');
                IF t_ContrEmp2.FINDFIRST THEN
                    REPEAT
                        IF t_ContrEmp2."Contribution Category Code" = 'FBIHRS' THEN
                            Komora := t_ContrEmp2."Reported Amount From Wage" + ((WageSetup."Unemployment Federation" / 100) * t_ContrEmp2."Amount Over Wage")
                        ELSE
                            Komora := t_ContrEmp2."Amount Over Wage";
                    UNTIL t_ContrEmp2.NEXT = 0;





                t_ContrEmp2.RESET;
                CLEAR(t_ContrEmp2);
                t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                //  t_ContrEmp2.SETFILTER("Wage Calc No.","No.");
                t_ContrEmp2.SETFILTER("Contribution Code", '%1|%2|%3', 'D-NEZAP-IZ', 'D-NEZAP-NA', 'D-ZAPOŠRS');
                IF t_ContrEmp2.FINDFIRST THEN
                    REPEAT
                        IF t_ContrEmp2."Contribution Category Code" = 'FBIHRS' THEN
                            sumNZ += t_ContrEmp2."Reported Amount From Wage" + ((WageSetup."Unemployment Federation" / 100) * t_ContrEmp2."Amount From Wage")
                        ELSE
                            sumNZ += t_ContrEmp2."Amount From Wage";
                    //    sumNZna:=t_ContrEmp2."Amount Over Wage"     ;
                    UNTIL t_ContrEmp2.NEXT = 0;
                vod := 0;
                t_ContrEmp4.RESET;
                CLEAR(t_ContrEmp4);
                t_ContrEmp4.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp4.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp4.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp4.SETFILTER("Contribution Code", '%1', 'P-VOD');
                IF t_ContrEmp4.FINDFIRST THEN
                    REPEAT
                        vod := t_ContrEmp4."Amount Over Neto";
                    UNTIL t_ContrEmp4.NEXT = 0;

                t_ContrEmp5.RESET;
                CLEAR(t_ContrEmp5);
                t_ContrEmp5.SETFILTER("Employee No.", "Employee No.");
                t_ContrEmp5.SETFILTER("Wage Header No.", "Wage Header No.");
                t_ContrEmp5.SETFILTER("Wage Calc No.", "No.");
                t_ContrEmp5.SETFILTER("Contribution Code", '%1', 'P-ELNEP');
                IF t_ContrEmp5.FINDFIRST THEN
                    REPEAT
                        elnep := t_ContrEmp5."Amount Over Neto";
                    UNTIL t_ContrEmp5.NEXT = 0;

                ContributionFromBruto := sumZDR + sumPIO + sumNZ + Djecija;
                ContributionOverBruto := sumZDRna + sumPIOna + sumNZna + RVI + Komora;
                CALCFIELDS("Meal Correction");
                IF "Taxable Meal" <> 0 THEN
                    prevoz := ROUND(Transport, 0.00001, '=');

                IF "Taxable Transport" <> 0 THEN
                    prevozneop := ROUND(0, 1, '=')
                ELSE
                    prevozneop := ROUND(Transport, 0.00001, '=');
                CALCFIELDS("Regres Netto With Wage");
                prevoz := ROUND(Transport, 0.00001, '=');


                CALCFIELDS("Regres Netto With Wage UnTax");



                WageAdditionType.RESET;
                WageAdditionType.SETFILTER(Regres, '%1', TRUE);
                IF WageAdditionType.FINDSET THEN
                    REPEAT
                        Wve.RESET;
                        Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                        Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        Wve.SETFILTER("Cost Amount (Brutto)", '%1', 0);
                        Wve.SETFILTER(Description, '%1', WageAdditionType.Code);
                        IF Wve.FINDFIRST THEN BEGIN
                            Wve.CALCSUMS("Cost Amount (Netto)");
                            regresneop := Wve."Cost Amount (Netto)";
                        END;

                    UNTIL WageAdditionType.NEXT = 0;


                WageAdditionType.RESET;
                WageAdditionType.SETFILTER(Regres, '%1', TRUE);
                IF WageAdditionType.FINDSET THEN
                    REPEAT
                        Wve.RESET;
                        Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                        Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        Wve.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        Wve.SETFILTER(Description, '%1', WageAdditionType.Code);
                        IF Wve.FINDFIRST THEN BEGIN
                            Wve.CALCSUMS("Cost Amount (Netto)");
                            regres := Wve."Cost Amount (Netto)";
                        END;

                    UNTIL WageAdditionType.NEXT = 0;

                WageAdditionType.RESET;
                WageAdditionType.SETFILTER(Regres, '%1', TRUE);
                IF WageAdditionType.FINDSET THEN
                    REPEAT
                        Wve.RESET;
                        Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                        Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        Wve.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        Wve.SETFILTER(Description, '%1', WageAdditionType.Code);
                        IF Wve.FINDFIRST THEN BEGIN
                            Wve.CALCSUMS("Cost Amount (Actual)");
                            regresTrosak := Wve."Cost Amount (Actual)";
                        END;

                    UNTIL WageAdditionType.NEXT = 0;











                WageAdditionType.RESET;
                WageAdditionType.SETFILTER(Meal, '%1', TRUE);
                IF WageAdditionType.FINDSET THEN
                    REPEAT
                        Wve.RESET;
                        Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                        Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        Wve.SETFILTER("Cost Amount (Brutto)", '%1', 0);
                        Wve.SETFILTER(Description, '%1', WageAdditionType.Code);
                        IF Wve.FINDFIRST THEN BEGIN
                            Wve.CALCSUMS("Cost Amount (Netto)");
                            toplineop := Wve."Cost Amount (Netto)";
                        END;

                    UNTIL WageAdditionType.NEXT = 0;


                WageAdditionType.RESET;
                WageAdditionType.SETFILTER(Meal, '%1', TRUE);
                IF WageAdditionType.FINDSET THEN
                    REPEAT
                        Wve.RESET;
                        Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                        Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        Wve.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        Wve.SETFILTER(Description, '%1', WageAdditionType.Code);
                        IF Wve.FINDFIRST THEN BEGIN
                            Wve.CALCSUMS("Cost Amount (Netto)");
                            topli := Wve."Cost Amount (Netto)";
                        END;

                    UNTIL WageAdditionType.NEXT = 0;





                Wve.RESET;
                Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                Wve.SETFILTER("Entry Type", '<>%1 & <>%2', Wve."Entry Type"::Reduction, Wve."Entry Type"::Use);
                IF Wve.FINDFIRST THEN BEGIN
                    Wve.CALCSUMS("Cost Amount (Actual)");
                    ukupno := Wve."Cost Amount (Actual)";
                END;


                Wve.RESET;
                Wve.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                Wve.SETFILTER("Employee No.", '%1', WC."Employee No.");
                Wve.SETFILTER("Entry Type", '<>%1 & <>%2 & <>%3 & <>%4 & <>%5', Wve."Entry Type"::Reduction, Wve."Entry Type"::Use, Wve."Entry Type"::"Meal to pay", Wve."Entry Type"::"Meal to refund",
                Wve."Entry Type"::Transport);
                IF Wve.FINDFIRST THEN BEGIN
                    Wve.CALCSUMS("Cost Amount (Actual)");
                    ukupno2 := Wve."Cost Amount (Actual)";
                END;




                //ukupno

            end;

            trigger OnPreDataItem()
            begin
                Filter := GETFILTER("Wage Calculation Type");
                ContributionFromBruto := 0;
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
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
    end;

    var
        CompInfo: Record "Company Information";
        employee: Record "Employee";
        PaymentV: Decimal;
        IDYear: Integer;
        FirstName: Text[50];
        LastName: Text[50];
        "Filter": Text[150];
        Sektor: Text;
        Odjel: Text;
        Grupa: Text;
        Tim: Text;
        WageType: Text[150];
        WH: Record "Wage Header";
        WHO: Code[30];
        PDate: Date;
        CDate: Date;
        RDate: Date;
        Djecija: Decimal;
        RVI: Decimal;
        RPE: Record "Reduction per Wage";
        Komora: Decimal;
        Kredit: Decimal;
        ContributionFromBruto: Decimal;
        TaxR: Decimal;
        NettoAmount: Decimal;
        ContributionOverBruto: Decimal;
        Department: Record Department;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        //   SegmentationGroup: Record "Segmentation Data";
        OrgDio: Code[30];
        NazivOrgDijela: Text[250];
        ORGD: Record "ORG Dijelovi";
        OrgJedinica: Code[30];
        NazivOrgJedinice: Text[250];
        Gender: Code[10];
        EmploymentDate: Date;
        TerminationDate: Date;
        WB: Record "Work Booklet";
        IDOJ: Code[10];
        B1: Text[250];
        B1R: Text[250];
        Str: Code[230];
        PositionCode: Code[30];
        PositionDescription: Text[500];
        NivoRukovodstva: Code[30];
        CubeFTE: Code[30];
        Position: Record "Position";
        CostType: Code[50];
        Type: Code[30];
        //ĐK CC: Record "Cube codes";
        CubeCodeName: Text[250];
        CubeHc: Code[50];
        WageSetup: Record "Wage Setup";
        BaseDeduct: Decimal;
        t_ContrEmp2: Record "Contribution Per Employee";
        sumNZna: Decimal;
        sumZDRna: Decimal;
        sumPIOna: Decimal;
        sumNZ: Decimal;
        sumZDR: Decimal;
        sumPIO: Decimal;
        Obustave: Decimal;
        t_ContrEmp: Record "Contribution Per Employee";
        t_ContrEmp1: Record "Contribution Per Employee";
        TempCalc: Record "Wage Calculation";
        SMECORE: Decimal;
        PROJFIN: Decimal;
        PUFIN: Decimal;
        GM: Decimal;
        PRIVATE: Decimal;
        MICRO: Decimal;
        AFFLUENT: Decimal;
        OVER: Decimal;
        SERVICE: Decimal;
        BO: Decimal;
        HCC: Decimal;
        HCP: Decimal;
        regresTrosak: Decimal;
        ALM: Decimal;
        t_ContrEmp4: Record "Contribution Per Employee";
        t_ContrEmp5: Record "Contribution Per Employee";
        vod: Decimal;
        elnep: Decimal;
        TotalCubeName: Text[250];
        DepartmentType: Text[50];
        DateFrom: Date;
        DateTo: Date;
        regres: Decimal;
        regresneop: Decimal;
        PAymentNetto: Decimal;
        UkupanDohodak: Decimal;
        topli: Decimal;
        toplineop: Decimal;
        prevoz: Decimal;
        prevozneop: Decimal;
        ukupno: Decimal;
        Wve: Record "Wage Value Entry";
        WageAdditionType: Record "Wage Addition Type";
        ukupno2: Decimal;
        AmountForPayment: Decimal;
}

