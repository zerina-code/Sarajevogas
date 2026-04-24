report 50056 "Pay List Final"
{
    // //NK
    DefaultLayout = RDLC;
    RDLCLayout = './Pay list final.rdl';

    Caption = 'Pay List Final';

    dataset
    {
        dataitem(EMPL; "Employee")
        {
            DataItemTableView = SORTING("Last Name", "First Name", "Middle Name")
                                ORDER(Ascending)
                                WHERE("Wage Posting Group" = FILTER('FBIH'));
            RequestFilterFields = "No.";
            dataitem(DataItem12; "Integer")
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CompanyName; CompInfo.Name)
                {
                }
                column(t_wageADDesc; t_wageADD.Description)
                {
                }
                column(Address; CompInfo.Address)
                {
                }
                column(Picture; CompInfo.Picture)
                {
                }
                column(PostCode; CompInfo."Post Code")
                {
                }
                column(Ttype; TType)
                {
                }
                column(Wtype; WType)
                {
                }
                column(City; CompInfo.City)
                {
                }
                column(DoW; DoW)
                {
                }
                column(PD; t_WageHeader."Payment Date")
                {
                }
                column(WHNo; t_WageHeader."No.")
                {
                }
                column(DoC; t_WageHeader."Date Of Calculation")
                {
                }
                column(MoC; t_WageHeader."Month of Calculation")
                {
                }
                column(YoC; t_WageHeader."Year of Calculation")
                {
                }
                column(ConCatCode; Employee."Contribution Category Code")
                {
                }
                column(AddTax; Employee."Additional Tax")
                {
                }
                column(IndTax; Employee."Tax Individual")
                {
                }
                column(EmployeeID; Employee."Employee ID")
                {
                }
                column(LastName; Employee."Last Name")
                {
                }
                column(FirstName; Employee."First Name")
                {
                }
                column(WEP; FORMAT(Employee."Work Experience Percentage", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                {
                }
                column(No; Employee."No.")
                {
                }
                column(Average; Average) { }
                column(Coeff; Coeff) { }
                column(Statute; Statute) { }
                column(Direktor; Direktor) { }
                column(DimText; DimText)
                {
                }
                column(PageNo; PageNo)
                {
                }
                column(BankAccountNo; BankAccount)
                {
                }
                column(WorkExperiencePercentage; FORMAT(WorkExperiencePercentage, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                {
                }
                column(BrutoBod; BrutoBod)
                {

                }
                column(KoeficijentRadnogMjesta; KoeficijentRadnogMjesta)
                {

                }
                column(WageBase; FORMAT(WageBase, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                {
                }
                column(Sati; Sati)
                {

                }

                column(IDMonth; IDMonth)
                {
                }
                column(IDYear; IDYear)
                {
                }
                dataitem(DataItem182; "Wage Value Entry")
                {
                    DataItemTableView = WHERE("Wage Calculation Type" = FILTER('Regular'));
                    column(TotalHours; FORMAT(TotalHours, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(ContributionPercent; ContributionPercent)
                    {
                    }
                    column(ContributionCategory; "DataItem182"."Contribution Category Code")
                    {
                    }
                    column(ContributionOn; ContributionOn)
                    {
                    }
                    column(Umanjenje; Umanjenje)
                    {
                    }
                    column(Akontacija; Akontacija)
                    {
                    }
                    column(PaymentOn; PaymentOn)
                    {
                    }
                    column(BruttoAmountOn; BruttoAmountOn)
                    {
                    }
                    column(PAymentContributionOver; PAymentContributionOver)
                    {
                    }
                    column(PoreskaOsnovica; PoreskaOsnovica)
                    {
                    }
                    column(PAymentNettoOporezivi; PAymentNettoOporezivi)
                    {
                    }
                    column(COAContributioOVer; COAContributioOVer)
                    {
                    }
                    column(PaymentContributionSpecial; PaymentContributionSpecial)
                    {
                    }
                    column(PercenteSpecial; FORMAT(PercenteSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(WageBaseSpecial; FORMAT(WageBaseSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NetoSpecial; FORMAT(NetoSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalSumSpecial; FORMAT(TotalSumSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NettoReduction; NettoReduction)
                    {
                    }
                    column(ReductionCode; ReductionCode)
                    {
                    }
                    column(ReductionText; ReductionText)
                    {
                    }
                    column(Partija; Partija)
                    {
                    }
                    column(ReductionAmount; FORMAT(ReductionAmount, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(ReductionDue; FORMAT(ReductionDue, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(AmountR; FORMAT(AmountR, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalReduction; FORMAT(TotalReduction, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalDue; FORMAT(TotalDue, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalAmountR; FORMAT(TotalAmountR, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(Porez; FORMAT(Porez, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(Coefficient; Coefficient)
                    {
                    }
                    column(BenefitsDed; BenefitsDed)
                    {
                    }
                    column(Postotak; Postotak)
                    {
                    }
                    column(ContributionNezaposlenost; ContributionNezaposlenost)
                    {
                    }
                    column(ContributionNezaposlenostfalse; ContributionNezaposlenostfalse)
                    {
                    }
                    column(PaymentContributionSpecial2; PaymentContributionSpecial2)
                    {
                    }
                    column(COASpecial2; COASpecial2)
                    {
                    }
                    column(PercenteSpecial2; FORMAT(PercenteSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(WageBaseSpecial2; FORMAT(WageBaseSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NetoSpecial2; FORMAT(NetoSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalSumSpecial2; FORMAT(TotalSumSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(COASpecial; COASpecial)
                    {
                    }
                    column(Entry; DataItem182."Entry No.")
                    {
                    }
                    column(EntryValue; EntryValue)
                    {
                    }
                    column(PaymentType; DataItem182.Description)
                    {
                    }

                    column(Amount; DataItem182."Cost Amount (Netto)")
                    {
                    }
                    column(BruttoAmount; DataItem182."Cost Amount (Brutto)")
                    {
                    }
                    column(Name; CompanyInfo.Name)
                    {
                    }
                    column(CEO; CompanyInfo.CEO)
                    {
                    }
                    column(Hours; SatiM)
                    {
                    }
                    column(COADescription; UPPERCASE(COADescription))
                    {
                    }
                    column(TipUlazaP; TipUlazaP)
                    {

                    }
                    column(OrderV; OrderV)
                    {

                    }
                    column(TIpUlazaR; TIpUlazaR)
                    { }
                    column(Suma1_B; Suma1_B)
                    {

                    }
                    column(Suma1_N; Suma1_N) { }
                    column(Suma1_S; Suma1_S) { }


                    column(Suma2_B; Suma2_B)
                    {

                    }
                    column(Suma2_N; Suma2_N) { }
                    column(Suma2_S; Suma2_S) { }

                    column(Suma3_B; Suma3_B)
                    {

                    }
                    column(Suma3_N; Suma3_N) { }
                    column(Suma3_S; Suma3_S) { }

                    column(Suma4_B; Suma4_B)
                    {

                    }
                    column(Suma4_N; Suma4_N) { }
                    column(Suma4_S; Suma4_S) { }
                    column(SumaR_2; SumaR_2) { }
                    column(Suma_R1; Suma_R1) { }


                    column(StartDate; StartDate)
                    {
                    }
                    column(EndDate; EndDate)
                    {
                    }
                    column(COAType; COAType)
                    {
                    }
                    column(ContributionFrom; ContributionFrom)
                    {
                    }
                    column(ContributionOver; ContributionOver)
                    {
                    }
                    column(ReductionType; ReductionType)
                    {
                    }
                    column(Reduction; DataItem182."Reduction Type")
                    {
                    }
                    column(Contribution; DataItem182."Contribution Type")
                    {
                    }
                    column(ATFrom; DataItem182."AT From")
                    {
                    }
                    column(ATFromNetto; DataItem182."AT From neto")
                    {
                    }
                    column(Basis; DataItem182.Basis)
                    {
                    }
                    column(PaymentTotal; PAymentNetto)
                    {
                    }
                    column(ReductiionTotal; PaymentRed)
                    {
                    }
                    column(ContributionFromTotal; PaymentContribution)
                    {
                    }
                    column(ContributionOverTotal; PAymentContributionOver)
                    {
                    }
                    column(BruttoTotal; PaymentBrutto)
                    {
                    }
                    column(ContrRS; ContrRS)
                    {
                    }
                    column(NetoPlaca; FORMAT(NetoPlaca, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(UkupanDohodak; FORMAT(UkupanDohodak, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NetoZaIsplatu; NetoZaIsplatu)
                    {
                    }
                    column(RegistrationCompany; CompanyInfo."Registration No.")
                    {

                    }
                    column(TaxNo; CompanyInfo."Tax No.")
                    {

                    }

                    column(IBAN; CompanyInfo."IBAN")
                    {

                    }

                    column(MBS; CompanyInfo."MBS")
                    {

                    }

                    column(IndustrialClasification; companyinfo."Industrial Classification")
                    {

                    }
                    column(RegistrationText; CompanyInfo."Registration Text")
                    {

                    }
                    column(transaction4; transaction4)
                    {

                    }

                    column(transaction4Name; transaction4Name)
                    {

                    }

                    column(transaction1Name; transaction1Name)
                    {

                    }

                    column(transaction2Name; transaction2Name)
                    {

                    }

                    column(transaction3Name; transaction3Name)
                    {

                    }
                    column(transaction5Name; transaction5Name)
                    {

                    }
                    column(transaction5; transaction5)
                    {

                    }

                    column(transaction2; transaction2)
                    {

                    }
                    column(transaction1; transaction1)
                    {

                    }

                    column(transaction3; transaction3)
                    {

                    }

                    column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
                    {
                    }


                    column(transaction6Name; transaction6Name)
                    {

                    }
                    column(transaction6; transaction6)
                    {

                    }
                    column(transaction7Name; transaction7Name)
                    {

                    }

                    column(transaction7; transaction7)
                    {

                    }


                    column(transaction8; transaction8)
                    {

                    }
                    column(transaction8Name; transaction8name)
                    {

                    }
                    column(transaction9Name; transaction9name)
                    {

                    }

                    column(transaction9; transaction9)
                    {

                    }

                    column(transaction10; transaction10)
                    {

                    }
                    column(transaction10Name; transaction10name)
                    {

                    }
                    column(transaction11Name; transaction11name)
                    {

                    }
                    column(transaction11; transaction11)
                    {

                    }
                    column(transaction12Name; transaction12name)
                    {

                    }
                    column(transaction12; transaction12)
                    {

                    }
                    column(transaction13Name; transaction13name)
                    {

                    }
                    column(transaction13; transaction13)
                    {

                    }
                    column(transaction14Name; transaction14name)
                    {

                    }
                    column(transaction14; transaction14)
                    {

                    }


                    trigger OnAfterGetRecord()
                    begin



                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 1");
                        if banacc.FindFirst() then begin

                            transaction1 := banacc."Bank Account No.";
                            transaction1Name := banacc.Name;
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 2");
                        if banacc.FindFirst() then begin
                            transaction2name := banacc.Name;
                            transaction2 := banacc."Bank Account No.";
                        end;
                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 3");
                        if banacc.FindFirst() then begin
                            transaction3Name := banacc.Name;
                            transaction3 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 4");
                        if banacc.FindFirst() then begin
                            transaction4Name := banacc.Name;
                            transaction4 := banacc."Bank Account No.";
                        end;
                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 5");
                        if banacc.FindFirst() then begin

                            transaction5Name := banacc.Name;
                            transaction5 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 6");
                        if banacc.FindFirst() then begin

                            transaction6Name := banacc.Name;
                            transaction6 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 7");
                        if banacc.FindFirst() then begin

                            transaction7Name := banacc.Name;
                            transaction7 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 8");
                        if banacc.FindFirst() then begin

                            transaction8Name := banacc.Name;
                            transaction8 := banacc."Bank Account No.";
                        end;


                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 9");
                        if banacc.FindFirst() then begin

                            transaction9Name := banacc.Name;
                            transaction9 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 10");
                        if banacc.FindFirst() then begin

                            transaction10Name := banacc.Name;
                            transaction10 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 11");
                        if banacc.FindFirst() then begin

                            transaction11Name := banacc.Name;
                            transaction11 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 12");
                        if banacc.FindFirst() then begin

                            transaction12Name := banacc.Name;
                            transaction12 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 13");
                        if banacc.FindFirst() then begin

                            transaction13Name := banacc.Name;
                            transaction13 := banacc."Bank Account No.";
                        end;

                        banacc.Reset();
                        banacc.SetFilter("No.", CompanyInfo."Bank No. 14");
                        if banacc.FindFirst() then begin

                            transaction14Name := banacc.Name;
                            transaction14 := banacc."Bank Account No.";
                        end;


                        PaymentOrder.RESET;
                        PaymentOrder.SETFILTER(SvrhaDoznake3, '%1', "Employee No.");
                        PaymentOrder.SETFILTER("Wage Header No.", '%1', "Document No.");
                        PaymentOrder.SETFILTER(Contributon, '%1', 'PLAĆA');
                        IF PaymentOrder.FINDFIRST THEN
                            BankAccount := PaymentOrder.RacunPrimaoca

                        ELSE BEGIN
                            BankAccount := Employee."Bank Account No.";
                        END;
                        Direktor := false;

                        EmployeeRec.RESET;
                        EmployeeRec.SETFILTER("No.", '%1', EmployeeFilter);
                        IF EmployeeRec.FINDFIRST THEN BEGIN
                            //Coefficient:=EmployeeRec."Benefit Coefficient";
                            //BenefitsDed:=EmployeeRec."Tax Deduction Amount";

                            WageCalculation.RESET;
                            WageCalculation.SETFILTER("Employee No.", '%1', EmployeeFilter);
                            WageCalculation.SETFILTER("Wage Header No.", '%1', WH."No.");
                            IF WageCalculation.FINDFIRST THEN BEGIN
                                WT.Reset();
                                WT.SetFilter(Code, '%1', Employee."Wage Type");
                                if WT.FindFirst() then begin
                                    if WT."Wage Calculation Type" = WT."Wage Calculation Type"::Netto2 then begin
                                        Direktor := true


                                    end;
                                end;
                                ws.GET;
                                WorkExperiencePercentage := WageCalculation."Work Experience Percentage";
                                BrutoBod := WageCalculation."Wage Base";
                                KoeficijentRadnogMjesta := WageCalculation."Position Coefficient for Wage";
                                Sati := WageCalculation."Hour Pool";
                                Average := WageCalculation."Average Salary FBIH";
                                Statute := WageCalculation."Average coefficient statute";
                                Coeff := WageCalculation."Position Coefficient";


                                ECL.RESET;
                                FinalDate := ABSFill.GetMonthRange(IDMonth, IDYear, FALSE);
                                ECL.RESET;
                                ECL.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                ECL.SETFILTER("Starting Date", '<=%1', FinalDate);
                                ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, FinalDate);
                                ECL.SETFILTER("Show Record", '%1', TRUE);
                                ECL.SETCURRENTKEY("Starting Date");
                                ECL.ASCENDING;
                                IF ECL.FINDLAST THEN BEGIN
                                    WageBase := ECL.Brutto;
                                END
                                ELSE BEGIN
                                    ECL.RESET;
                                    ECL.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                    ECL.SETFILTER("Starting Date", '<=%1', FinalDate);
                                    ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, StartDate);
                                    ECL.SETFILTER("Show Record", '%1', TRUE);
                                    ECL.SETCURRENTKEY("Starting Date");
                                    ECL.ASCENDING;
                                    IF ECL.FINDLAST THEN BEGIN
                                        WageBase := ECL.Brutto;

                                    END;
                                END;



                                // Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction";

                                /*IF ws."Base Tax Deduction"<>0 THEN BEGIN



                                   IF ((WageCalculation."Contribution Category Code"='FBIH') OR (WageCalculation."Contribution Category Code"='FBIHRS') ) THEN

                                     Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction";

                                      IF ((WageCalculation."Contribution Category Code"='RS')) THEN

                                    Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction RS";

                                        IF ((WageCalculation."Contribution Category Code"='BDPIOFBIH') OR (WageCalculation."Contribution Category Code"='BDPIORS')) THEN

                                     Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction BD";



                                END;*/

                                IF (WageCalculation."Contribution Category Code" = 'FBIH') OR (WageCalculation."Contribution Category Code" = 'FBIHRS') THEN BEGIN
                                    TaxDed.RESET;
                                    TaxDed.SETFILTER("Entity Code", '%1', 'FBIH');
                                    TaxDed.setfilter("Type", '%1', TaxDed.type::"Tax List");
                                    TaxDed.SETFILTER("Valid Year", '<=%1', WageCalculation."Year of Wage");
                                    TaxDed.SETFILTER(Month, '<=%1', WageCalculation."Month Of Wage");
                                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                                    TaxDed.ASCENDING;
                                    IF TaxDed.FINDLAST THEN
                                        Coefficient := WageCalculation."Tax Deductions" / TaxDed.Amount
                                    ELSE
                                        Coefficient := 0;
                                END
                                else begin
                                    BrutoBod := 0;
                                    KoeficijentRadnogMjesta := 0;
                                    Sati := 0;
                                    Average := 0;
                                    Statute := 0;
                                    Coeff := 0;
                                    ECL.RESET;
                                    FinalDate := ABSFill.GetMonthRange(IDMonth, IDYear, FALSE);
                                    ECL.RESET;
                                    ECL.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                    ECL.SETFILTER("Starting Date", '<=%1', FinalDate);
                                    ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, FinalDate);
                                    ECL.SETFILTER("Show Record", '%1', TRUE);
                                    ECL.SETCURRENTKEY("Starting Date");
                                    ECL.ASCENDING;
                                    IF ECL.FINDLAST THEN BEGIN
                                        WageBase := ECL.Brutto;
                                    END
                                    ELSE BEGIN
                                        ECL.RESET;
                                        ECL.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                        ECL.SETFILTER("Starting Date", '<=%1', FinalDate);
                                        ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, StartDate);
                                        ECL.SETFILTER("Show Record", '%1', TRUE);
                                        ECL.SETCURRENTKEY("Starting Date");
                                        ECL.ASCENDING;
                                        IF ECL.FINDLAST THEN BEGIN
                                            WageBase := ECL.Brutto;

                                        END;
                                    END;


                                end;


                                IF (WageCalculation."Contribution Category Code" = 'RS') THEN BEGIN
                                    TaxDed.RESET;
                                    TaxDed.SETFILTER("Entity Code", '%1', 'RS');
                                    TaxDed.setfilter("Type", '%1', TaxDed.type::"Tax List");
                                    TaxDed.SETFILTER("Valid Year", '<=%1', WageCalculation."Year of Wage");
                                    TaxDed.SETFILTER(Month, '<=%1', WageCalculation."Month Of Wage");
                                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                                    TaxDed.ASCENDING;
                                    IF TaxDed.FINDLAST THEN
                                        Coefficient := WageCalculation."Tax Deductions" / TaxDed.Amount
                                    ELSE
                                        Coefficient := 0;
                                END;

                                IF ((WageCalculation."Contribution Category Code" = 'BDPIOFBIH') OR (WageCalculation."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                                    TaxDed.RESET;
                                    TaxDed.SETFILTER("Entity Code", '%1', 'BD');
                                    TaxDed.setfilter("Type", '%1', TaxDed.type::"Tax List");
                                    TaxDed.SETFILTER("Valid Year", '<=%1', WageCalculation."Year of Wage");
                                    TaxDed.SETFILTER(Month, '<=%1', WageCalculation."Month Of Wage");
                                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                                    TaxDed.ASCENDING;
                                    IF TaxDed.FINDLAST THEN
                                        Coefficient := WageCalculation."Tax Deductions" / TaxDed.Amount
                                    ELSE
                                        Coefficient := 0;
                                END;







                                IF WageCalculation."Contribution Category Code" = 'RS' THEN
                                    Coefficient := 0;
                                BenefitsDed := WageCalculation."Tax Deductions";
                            END;


                        END
                        ELSE BEGIN
                            Coefficient := 0;
                            BenefitsDed := 0;
                            WorkExperiencePercentage := 0;
                        END;

                        COADescription := '';
                        TipUlazaP := 0;
                        TIpUlazaR := 0;
                        COA.RESET;
                        COA.SETFILTER("Short Code", '%1', Description);
                        IF COA.FINDFIRST THEN BEGIN
                            COADescription := COA.Description;
                            if COA."Payment Type" = COA."Payment Type"::"Regular Work" then
                                TipUlazaP := 1;
                            if COA."Payment Type" = COA."Payment Type"::"Additional>" then
                                TipUlazaP := 3;
                            if COA."Payment Type" = COA."Payment Type"::"Other Additional" then
                                TipUlazaP := 4;

                            if COA."Payment Type" = COA."Payment Type"::"Work Performance" then
                                TipUlazaP := 2;

                            OrderV := COA.Order;


                        END
                        ELSE BEGIN
                            WAT.RESET;
                            WAT.SETFILTER(Code, '%1', Description);
                            IF WAT.FINDFIRST THEN BEGIN
                                COADescription := WAT.Description;
                                if WAT."Payment Type" = WAT."Payment Type"::"Regular Work" then
                                    TipUlazaP := 1;
                                if WAT."Payment Type" = WAT."Payment Type"::"Additional>" then
                                    TipUlazaP := 3;
                                if WAT."Payment Type" = WAT."Payment Type"::"Other Additional" then
                                    TipUlazaP := 4;

                                if WAT."Payment Type" = WAT."Payment Type"::"Work Performance" then begin

                                    TipUlazaP := 2;
                                    if WAT."Default Amount" <> 0 then begin
                                        DataItem182.Hours := WAT."Default Amount";
                                        DecimalPart := FORMAT(DataItem182.Hours, 0, '<Decimals,2>');
                                        //   if (DecimalPart='00') or(DecimalPart='') then 
                                        // DataItem182.Hours := WAT."Default Amount"


                                    end;

                                end;
                                OrderV := WAT.Order;




                            END
                            ELSE BEGIN
                                Red.RESET;
                                Red.SETFILTER(Code, '%1', Description);
                                IF Red.FINDFIRST THEN BEGIN
                                    COADescription := Red.Description;
                                END
                                ELSE BEGIN
                                    Contribution.RESET;

                                    Contribution.SETFILTER("Short Code", '%1', Description);

                                    IF Description = '' THEN
                                        Contribution.SETFILTER(Code, '%1', FORMAT("Contribution Type"));
                                    IF Contribution.FINDFIRST THEN BEGIN
                                        COADescription := Contribution.Description;
                                        ContributionCategory.RESET;
                                        ContributionCategory.SETFILTER("Contribution Code", '%1', "Contribution Type");
                                        WageCalculation.RESET;
                                        WageCalculation.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                        WageCalculation.SETFILTER("Wage Header No.", '%1', WH."No.");
                                        IF WageCalculation.FINDFIRST THEN
                                            ContributionCategory.SETFILTER("Category Code", '%1', WageCalculation."Contribution Category Code");
                                        ContributionCategory.SETFILTER("Over Brutto", '%1', FALSE);
                                        IF ContributionCategory.FINDFIRST THEN
                                            ContributionNezaposlenost := ContributionCategory.Percentage;
                                        ContributionCategory.RESET;
                                        ContributionCategory.SETFILTER("Contribution Code", '%1', "Contribution Type");
                                        WageCalculation.RESET;
                                        WageCalculation.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                        WageCalculation.SETFILTER("Wage Header No.", '%1', WH."No.");
                                        IF WageCalculation.FINDFIRST THEN
                                            ContributionCategory.SETFILTER("Category Code", '%1', WageCalculation."Contribution Category Code");
                                        ContributionCategory.SETFILTER("Over Brutto", '%1', TRUE);
                                        IF ContributionCategory.FINDFIRST THEN
                                            ContributionNezaposlenostfalse := ContributionCategory.Percentage;
                                        ContributionCategory.RESET;
                                        ContributionCategory.SETFILTER("Contribution Code", '%1', "Contribution Type");
                                        IF ContributionCategory.FINDFIRST THEN BEGIN
                                            PercenteSpecial := ContributionCategory.Percentage;
                                            IF WageCalculation."Contribution Category Code" = 'RS' THEN
                                                PercenteSpecial := 0;

                                            WageBaseSpecial := DataItem182.Basis;
                                            NetoSpecial := DataItem182."Cost Amount (Netto)";

                                        END;



                                    END
                                    ELSE
                                        IF ("Entry Type" = 14) THEN begin
                                            COADescription := 'Minuli rad';

                                        end;
                                    IF ("Entry Type" = 7) THEN
                                        COADescription := 'Naknada za prevoz u novcu';



                                END;
                            END;
                        END;

                        IF ("Entry Type" = 14) THEN begin
                            COADescription := 'Minuli rad';
                            TipUlazaP := 3;
                        end;

                        IF (DataItem182."Entry Type" = 7) THEN begin
                            COADescription := 'Naknada za prevoz u novcu';
                            TipUlazaP := 4;
                        end;
                        SatiM := DataItem182.Hours;
                        if DataItem182."Entry Type" = 14 then
                            SatiM := WorkExperiencePercentage;

                        //TipUlazaP



                        if TipUlazaP = 1 then begin
                            Suma1_B += DataItem182."Cost Amount (Brutto)";
                            Suma1_N += DataItem182."Cost Amount (Netto)";
                            Suma1_S += DataItem182.Hours;

                        end;

                        if TipUlazaP = 2 then begin
                            Suma2_B += "Cost Amount (Brutto)";
                            Suma2_N += "Cost Amount (Netto)";
                            Suma2_S += Hours;

                        end;

                        if TipUlazaP = 3 then begin
                            Suma3_B += "Cost Amount (Brutto)";
                            Suma3_N += "Cost Amount (Netto)";
                            Suma3_S += Hours;

                        end;

                        if TipUlazaP = 4 then begin
                            Suma4_B += "Cost Amount (Brutto)";
                            Suma4_N += "Cost Amount (Netto)";
                            Suma4_S += Hours;

                        end;




                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7',
                        WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience",
                        WVE."Entry Type"::Taxable, WVE."Entry Type"::Untaxable, WVE."Entry Type"::"Meal to pay", WVE."Entry Type"::Transport);
                        //2,12,14,13,11,7,9);
                        IF WVE.FINDFIRST THEN BEGIN
                            WVE.CALCSUMS("Cost Amount (Netto)");
                            WVE.CALCSUMS("Cost Amount (Brutto)");
                            PAymentNetto := WVE."Cost Amount (Netto)";
                            PaymentBrutto := WVE."Cost Amount (Brutto)";
                        END;



                        WVE2.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE2.SETFILTER("Document No.", '%1', WH."No.");
                        WVE2.SETFILTER("Reduction Type", '<>%1', '');
                        WVE2.SETFILTER("Wage Calculation Type", '%1', WVE2."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        IF WVE2.FINDFIRST THEN BEGIN
                            WVE2.CALCSUMS("Cost Amount (Netto)");
                            PaymentRed := WVE2."Cost Amount (Netto)";
                        END;


                        WVE3.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE3.SETFILTER("Document No.", '%1', WH."No.");
                        WVE3.SETFILTER("AT From", '%1', TRUE);
                        WVE3.SETFILTER("Wage Calculation Type", '%1', WVE3."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        IF WVE3.FINDFIRST THEN BEGIN
                            WVE3.CALCSUMS("Cost Amount (Netto)");
                            PaymentContribution := WVE3."Cost Amount (Netto)";
                        END;

                        WVE4.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE4.SETFILTER("Document No.", '%1', WH."No.");
                        WVE4.SETFILTER("AT From", '%1', FALSE);
                        WVE4.SETFILTER("AT From neto", '%1', FALSE);
                        WVE4.SETFILTER("Contribution Type", '<>%1', '');
                        WVE4.SETFILTER("Wage Calculation Type", '%1', WVE4."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);CO
                        IF WVE4.FINDFIRST THEN BEGIN
                            WVE4.CALCSUMS("Cost Amount (Netto)");
                            PAymentContributionOver := WVE4."Cost Amount (Netto)";
                        END;

                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("AT From neto", '%1', TRUE);
                        WVE.SETFILTER("Entry Type", '%1', "Entry Type"::Contribution);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        IF WVE.FINDFIRST THEN BEGIN
                            WVE.CALCSUMS("Cost Amount (Netto)");
                            TotalSumSpecial := WVE."Cost Amount (Netto)";
                        END;





                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1|%2', DataItem182."Entry Type"::"Net Wage", DataItem182."Entry Type"::Taxable);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        TotalHours := 0;
                        IF WVE.FINDSET THEN
                            REPEAT
                                TotalHours := TotalHours + WVE.Hours;
                            UNTIL WVE.NEXT = 0;


                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6',
                        WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience",
                        WVE."Entry Type"::Taxable, WVE."Entry Type"::Untaxable, WVE."Entry Type"::"Meal to pay");
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        WVE.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        //2,12,14,13,11,7,9);
                        IF WVE.FINDFIRST THEN BEGIN
                            WVE.CALCSUMS("Cost Amount (Netto)");
                            WVE.CALCSUMS("Cost Amount (Brutto)");
                            PAymentNettoOporezivi := WVE."Cost Amount (Netto)";
                            WVE.RESET;
                            WVE.SETFILTER("Employee No.", '%1', DataItem182."Employee No.");
                            WVE.SETFILTER("Document No.", '%1', DataItem182."Document No.");
                            WVE.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                            WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            WVE.SETFILTER(Description, '%1', '820');
                            IF WVE.FINDFIRST THEN
                                PAymentNettoOporezivi := PAymentNettoOporezivi - WVE."Cost Amount (Netto)";

                            // PaymentBrutto:=WVE."Cost Amount (Brutto)";
                        END;






                        IF DataItem182."Entry Type" = DataItem182."Entry Type"::Reduction THEN BEGIN
                            ReductionCode := DataItem182."Reduction Type";
                            ReductionTypes.RESET;
                            ReductionTypes.SETFILTER(Code, '%1', ReductionCode);
                            IF ReductionTypes.FINDFIRST THEN BEGIN
                                ReductionText := ReductionTypes.Description;
                                if ReductionTypes."Reduction Type" = ReductionTypes."Reduction Type"::Memberships then
                                    TIpUlazaR := 1;
                                if ReductionTypes."Reduction Type" = ReductionTypes."Reduction Type"::Unions then
                                    TIpUlazaR := 2;

                                EntryValue := DataItem182."Entry No.";
                                ReductionList.RESET;
                                ReductionList.SETFILTER("No.", '%1', DataItem182."Reduction No.");
                                IF ReductionList.FINDFIRST THEN BEGIN
                                    Partija := ReductionList."Party No.";

                                    ReductionAmount := ReductionList."Reduction Amount";
                                    //ReductionDue:=ReductionList."Remaining Due";
                                    //ReductionDue:=ReductionList."Reduction Amount"-(ReductionList."Opening balance"+ReductionList."Paid Amount");
                                    ReductionPerEmployee.RESET;
                                    ReductionPerEmployee.SETFILTER("Employee No.", '%1', DataItem182."Employee No.");
                                    ReductionPerEmployee.SETFILTER("Wage Header No.", '<=%1', DataItem182."Document No.");
                                    ReductionPerEmployee.SETFILTER("Reduction No.", '%1', ReductionList."No.");
                                    IF ReductionPerEmployee.FINDFIRST THEN BEGIN
                                        ReductionPerEmployee.CALCSUMS(Amount);
                                        IF NOT ReductionTypes.AmountIsPercentage THEN
                                            ReductionDue := ReductionList."Reduction Amount" - ReductionPerEmployee.Amount - ReductionList."Opening balance"
                                        ELSE
                                            ReductionDue := 0;
                                    END
                                    ELSE BEGIN
                                        ReductionDue := 0;
                                    END;
                                    AmountR := DataItem182."Cost Amount (Netto)";
                                    TotalReduction := TotalReduction + ReductionAmount;
                                    TotalDue := TotalDue + ReductionDue;
                                    TotalAmountR := TotalAmountR + AmountR;

                                END;
                            END;
                            AmountR := DataItem182."Cost Amount (Netto)";

                            if TIpUlazaR = 1 then begin
                                Suma_R1 += AmountR;
                            end;

                            if TIpUlazaR = 2 then begin
                                SumaR_2 += AmountR;
                            end;

                            //TotalAmountR:=TotalAmountR+AmountR;
                            CALCSUMS("Cost Amount (Netto)");
                        END;
                        IF TotalAmountR = 0 THEN BEGIN
                            WVE.RESET;
                            WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                            WVE.SETFILTER("Document No.", '%1', WH."No.");
                            WVE.SETFILTER("Entry Type", '%1', DataItem182."Entry Type"::Reduction);
                            WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            //2,12,14,13,11,7,9);
                            IF WVE.FINDFIRST THEN BEGIN
                                WVE.CALCSUMS("Cost Amount (Netto)");
                                TotalAmountR := WVE."Cost Amount (Netto)";
                            END;
                            TotalReduction := TotalReduction + ReductionAmount;
                        END;


                        //  UNTIL WVE.NEXT=0;
                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1', DataItem182."Entry Type"::Reduction);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        TotalReduction := 0;
                        TotalDue := 0;
                        //TotalAmountR:=0;
                        IF WVE.FINDSET THEN
                            REPEAT

                                ReductionList.RESET;
                                ReductionList.SETFILTER("No.", '%1', WVE."Reduction No.");
                                IF ReductionList.FINDFIRST THEN BEGIN
                                    TotalReduction := TotalReduction + ReductionList."Reduction Amount";
                                    TotalDue := TotalDue + ReductionList."Remaining Due";
                                    //TotalAmountR:=TotalAmountR+WVE."Cost Amount (Netto)";
                                END;
                            //END;

                            UNTIL WVE.NEXT = 0;



                        CompanyInfo.GET;
                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1', DataItem182."Entry Type"::Tax);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        IF WVE.FINDFIRST THEN
                            Porez := WVE."Cost Amount (Netto)";
                        RecordTaxClass.RESET;
                        //   RecordTaxClass.SETFILTER(Active, '%1', TRUE);
                        IF COPYSTR(WVE."Contribution Category Code", 1, 2) = 'RS' THEN
                            RecordTaxClass.SETFILTER(Code, '%1', WVE."Contribution Category Code")
                        ELSE
                            RecordTaxClass.SETFILTER("Entity Code", '%1', CompanyInfo."Entity Code");
                        //    RecordTaxClass.SETFILTER(Active, '%1', TRUE);
                        IF RecordTaxClass.FINDFIRST THEN BEGIN

                            Postotak := RecordTaxClass.Percentage;

                        END;


                        Umanjenje := 0;
                        PoreskaOsnovica := 0;
                        Akontacija := 0;
                        NetoPlaca := PAymentNettoOporezivi;
                        UkupanDohodak := PAymentNetto;

                        Calc.RESET;
                        Calc.SETRANGE("Month Of Wage", IDMonth);
                        Calc.SETRANGE("Year of Wage", IDYear);
                        Calc.SETFILTER("Employee No.", '%1', "DataItem182"."Employee No.");
                        IF Calc.FINDFIRST THEN BEGIN
                            IF Calc."Contribution Category Code" = 'RS' THEN BEGIN
                                Umanjenje := BenefitsDed;
                                PoreskaOsnovica := Calc."Tax Basis";
                                Akontacija := ((Calc."Tax Basis") * Postotak) / 100;
                                NetoPlaca := PAymentNettoOporezivi - ((Calc."Tax Basis") * Postotak) / 100;
                                //UkupanDohodak:=PAymentNetto-((PAymentNettoOporezivi-BenefitsDed)*Postotak)/100;
                                UkupanDohodak := PAymentNetto - Porez;


                            END
                            ELSE BEGIN


                                IF PAymentNettoOporezivi - BenefitsDed < 0 THEN BEGIN
                                    Umanjenje := 0;
                                    PoreskaOsnovica := 0;
                                    Akontacija := 0;
                                    NetoPlaca := PAymentNettoOporezivi;
                                    UkupanDohodak := PAymentNetto;
                                END
                                ELSE BEGIN
                                    Umanjenje := BenefitsDed;
                                    PoreskaOsnovica := PAymentNettoOporezivi - BenefitsDed;
                                    Akontacija := ((PAymentNettoOporezivi - BenefitsDed) * Postotak) / 100;
                                    NetoPlaca := PAymentNettoOporezivi - ((PAymentNettoOporezivi - BenefitsDed) * Postotak) / 100;
                                    //UkupanDohodak:=PAymentNetto-((PAymentNettoOporezivi-BenefitsDed)*Postotak)/100;
                                    UkupanDohodak := PAymentNetto - Porez;
                                END;
                            END;

                        END;
                        IF Calc."Wage Type" = 'NETO' then begin
                            NetoZaIsplatu := UkupanDohodak - TotalAmountR
                            //- Calc."Untaxable Wage";

                        end
                        else begin


                            NetoZaIsplatu := UkupanDohodak - TotalAmountR;
                        end;

                        /*
                        WCh.SETFILTER("No.",'%1',"Employee No.");
                        IF NOT WCh.FINDFIRST THEN BEGIN
                        WCh.INIT;
                        WCh."No.":="Employee No.";
                        WCh.Payment:= NetoZaIsplatu;
                        WCh.INSERT;
                        END;*/

                    end;

                    trigger OnPreDataItem()
                    begin
                        //SETFILTER("Entry Type",'%1|%2|%3|%4|%5|%6|%7|%8|%9',2,6,7,9,10,11,12,13,14);
                        Suma1_B := 0;
                        Suma1_N := 0;
                        Suma1_S := 0;
                        Suma2_B := 0;
                        Suma2_N := 0;
                        Suma2_S := 0;

                        Suma3_B := 0;
                        Suma3_N := 0;
                        Suma3_S := 0;

                        Suma4_B := 0;
                        Suma4_N := 0;
                        Suma4_S := 0;

                        WH.RESET;
                        WH.SETRANGE("Month Of Wage", IDMonth);
                        WH.SETRANGE("Year Of Wage", IDYear);


                        //IF NOT WH.FIND('-') THEN ERROR('Ne postoji taj obračun plata');
                        Calc.RESET;
                        Calc.SETRANGE("Month Of Wage", IDMonth);
                        Calc.SETRANGE("Year of Wage", IDYear);

                        IF Calc.FINDFIRST THEN BEGIN
                            DataItem182."Document No." := Calc."Wage Header No.";
                        END
                        ELSE BEGIN
                            DataItem182."Document No." := '';
                        END;





                        SETFILTER("Entry Type", '<>%1', 0);

                        CompanyInfo.GET;
                        COADescription := '';
                        Base := 0;
                        WHNo := GETFILTER("Document No.");
                        IF WHNo <> '' THEN BEGIN
                            WageHeader.GET(WHNo);
                            StartDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
                            EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);

                            //StartDate:=IDMonth;
                            //EndDate:=IDYear;

                        END;


                        COAType := FALSE;
                        ContributionFrom := FALSE;
                        ContributionOver := FALSE;
                        ReductionType := FALSE;
                        Percentage := 0;
                        emp := GETFILTER("Employee No.");
                        PAymentNetto := 0;
                        PaymentBrutto := 0;
                        PaymentContribution := 0;
                        PAymentContributionOver := 0;
                        PaymentRed := 0;
                        COADescription := '';
                        TotalSumSpecial := 0;
                        TotalAmountR := 0;
                        NetoPlaca := 0;
                        UkupanDohodak := 0;

                        IF StartDate = 0D THEN BEGIN
                            StartDate := AbsenceFill.GetMonthRange(IDMonth, IDYear, TRUE);
                            EndDate := AbsenceFill.GetMonthRange(IDMonth, IDYear, FALSE);
                        END;
                        SETFILTER("Employee No.", '%1', EmployeeFilter);
                        SETFILTER("Document No.", '%1', WH."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CPE.SETFILTER("Employee No.", EmployeeFilter);
                    CPE.SETFILTER("Wage Calculation Entry No.", TempCalc."No.");
                    IF CPE.FINDFIRST THEN BEGIN
                        REPEAT
                            IF CPE."Contribution Code" <> 'DJEC-ZAST' THEN
                                ContrRS += CPE."Reported Amount From Wage";
                        UNTIL CPE.NEXT = 0
                    END;

                    IF NOT TempCalc.FIND('-') THEN CurrReport.SKIP;
                    TempCalc.Payment := TempCalc.Payment + TempCalc."Sick Leave-Fund";
                    Suma_R1 := 0;
                    SumaR_2 := 0;


                    Employee.GET(TempCalc."Employee No.");
                    /*  ConfData.SETFILTER("Position No.", Employee."No.");
                      ConfData.SETFILTER("Segmentation Code", Setup."Commission Code");
                      IF ConfData.FIND('+') THEN
                          EVALUATE(CommissionAmount, ConfData.Description)
                      ELSE*/
                    CommissionAmount := 0;
                    /*
                    WageCalculation.RESET;
                     WageCalculation.SETFILTER("Wage Header No.",'%1',WH."No.");
                     WageCalculation.SETFILTER("Employee No.",'%1',EmployeeFilter);
                     IF WageCalculation.FINDLAST THEN BEGIN
                     WageBase:=WageCalculation."Wage (Base)";
                     END
                      ELSE BEGIN
                      WageBase:=0;
                    END;*/


                end;

                trigger OnPreDataItem()
                begin

                    CompInfo.GET;
                    TempCalc.RESET;
                    TempCalc.DELETEALL;
                    Setup.GET;
                    StartDate := AF.GetMonthRange(IDMonth, IDYear, TRUE);
                    EndDate := AF.GetMonthRange(IDMonth, IDYear, FALSE);
                    CompInfo.GET;
                    CompInfo.CALCFIELDS(Picture);
                    ei := '0';
                    WH.RESET;
                    WH.SETRANGE("Month Of Wage", IDMonth);
                    WH.SETRANGE("Year Of Wage", IDYear);


                    IF NOT WH.FIND('-') THEN ERROR('Ne postoji taj obračun plata');

                    Calc.RESET;
                    Calc.SETRANGE("Month Of Wage", IDMonth);
                    Calc.SETRANGE("Year of Wage", IDYear);
                    IF DepartmentR <> '' THEN
                        Calc.SETFILTER("Department Code", DepartmentR);
                    IF EmployeeFilter <> '' THEN
                        Calc.SETFILTER("Employee No.", EmployeeFilter);
                    IF Calc.FIND('-') THEN
                        REPEAT
                            IF TempCalc.GET(Calc."No.") THEN BEGIN
                            END
                            ELSE BEGIN

                                TempCalc.INIT;



                                TempCalc.TRANSFERFIELDS(Calc);



                                TempCalc.INSERT;
                            END;
                        UNTIL Calc.NEXT = 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                EmplDefDim: Record "Employee Default Dimension";
            begin
                t_WageHeader.SETFILTER("Month Of Wage", FORMAT(IDMonth));
                t_WageHeader.SETFILTER("Year Of Wage", FORMAT(IDYear));
                //t_WageHeader.SETFILTER("Employee No.","No.");
                t_WageHeader.FINDFIRST;
                t_WageCalc.SETFILTER("Month Of Wage", FORMAT(IDMonth));
                t_WageCalc.SETFILTER("Year of Wage", FORMAT(IDYear));
                t_WageCalc.SETFILTER("Employee No.", "No.");
                IF t_WageCalc.FINDFIRST THEN
                    poruka := 't';
                //begin
                BEGIN
                    EmployeeFilter := "No.";
                    TotalNonNetto := 0;

                END;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGE;
                use := 0;
                BankAccount := '';
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
                    field(Month; IDMonth)
                    {
                        ApplicationArea = all;
                        Caption = 'Month';
                    }
                    field(Year; IDYear)
                    {
                        ApplicationArea = all;
                        Caption = 'Year';
                    }
                    field(DepartmentR; DepartmentR)
                    {
                        ApplicationArea = all;
                        Caption = 'Depaartment';
                        TableRelation = Department;
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

        CLEARALL;
        IDMonth := DATE2DMY(CALCDATE('0D', WORKDATE), 2);
        IDYear := DATE2DMY(CALCDATE('0D', WORKDATE), 3);
    end;

    trigger OnPreReport()
    begin
        // IDMonth := 12;
        // IDYear := 2016;
        ObustaveNo := 0;

        CASE IDMonth OF
            1:
                DoW := 'Januar';
            2:
                DoW := 'Februar';
            3:
                DoW := 'Mart';
            4:
                DoW := 'April';
            5:
                DoW := 'Maj';
            6:
                DoW := 'Juni';
            7:
                DoW := 'Juli';
            8:
                DoW := 'August';
            9:
                DoW := 'Septembar';
            10:
                DoW := 'Oktobar';
            11:
                DoW := 'Novembar';
            12:
                DoW := 'Decembar';
        END;

        ws.GET;

        MealHeader.RESET;
        MealHeader.SETRANGE("Year Of Wage", IDYear);
        MealHeader.SETRANGE("Month Of Wage", IDMonth);
        IF NOT MealHeader.FIND('-') THEN MealHeader.INIT;
        MealLine.SETRANGE("Document No.", MealHeader."No.");

        CompInfo.GET;
        PageNo := 0;
    end;

    var
        PaymentOrder: Record "Payment Order";
        WT: Record "Wage Type";
        Average: Decimal;
        Coeff: Decimal;
        Statute: Decimal;
        Direktor: Boolean;

        DecimalPart: Text[250];

        OrderV: Integer;
        SatiM: Decimal;
        TipUlazaP: Integer;
        Suma1_S: Decimal;
        Suma1_B: Decimal;
        Suma1_N: Decimal;

        Suma2_S: Decimal;
        Suma2_B: Decimal;
        Suma2_N: Decimal;

        Suma3_S: Decimal;
        Suma3_B: Decimal;
        Suma3_N: Decimal;

        Suma4_S: Decimal;
        Suma4_B: Decimal;
        Suma4_N: Decimal;

        Suma_R1: Decimal;
        SumaR_2: Decimal;


        TIpUlazaR: Integer;

        BrutoBod: Decimal;
        KoeficijentRadnogMjesta: Decimal;

        TipUlaza: Record "Wage Value Entry";
        BankAccount: Code[20];
        DepartmentR: Code[20];
        ei: Code[10];
        t_wageADD: Record "Wage Addition";
        poruka: Text;
        TType: Text;
        WType: Text[150];
        t_WageCalc: Record "Wage Calculation";
        t_WageHeader: Record "Wage Header";
        PoreskaOsnovica: Decimal;
        TempCalc: Record "Wage Calculation" temporary;
        IDMonth: Integer;
        IDYear: Integer;
        EmployeeFilter: Code[20];
        ReductionPerEmployee: Record "Reduction per Wage";
        IsFirst: Boolean;
        Employee: Record "Employee";
        Umanjenje: Decimal;
        ATCatCon: Record "Contribution Category Conn.";
        ABSFill: Codeunit "Absence Fill";
        ATCat: Record "Contribution Category";
        TaxClass: Record "Tax Class";
        Red: Record "Reduction types";
        Akontacija: Decimal;
        CompInfo: Record "Company Information";
        Post: Record "Post Code";
        CityPercent: Decimal;
        AF: Codeunit "Absence Fill";
        Absence: Record "Employee Absence";
        AbCount: Integer;
        CodeArray: array[100] of Code[10];
        TotalArray: array[100] of Decimal;
        TaxDed: Record "Tax deduction list";
        Found: Boolean;
        FinalDate: Date;
        I: Integer;
        Description: Text[50];
        Quantity: Decimal;
        AbType: Record "Cause of Absence";
        Value: Decimal;
        HourWage: Decimal;
        //   ConfData: Record "Segmentation Data";
        Setup: Record "Wage Setup";
        CommissionAmount: Decimal;
        WageType: Record "Wage Type";
        TaxPercent: Decimal;
        // ESG: Record "Misc. Article Information (B)";
        ws: Record "Wage Setup";
        TotalHours: Decimal;
        TotalNetto: Decimal;
        TBasis: Decimal;
        RT: Record "Reduction types";
        RAmount: Text[30];
        at: Record "Contribution";
        MR: Decimal;
        COAValue: Decimal;
        EC: Record "Employment Contract";
        DoW: Text[150];
        LMHourValue: Decimal;
        SatnicaT: Decimal;
        WCForEC: Record "Wage Calculation";
        Sati: Decimal;
        WCAdd: Record "Wage Calculation";
        ",": Decimal;
        WAPerc: Decimal;
        TotalNonNetto: Decimal;
        MealHeader: Record "Meal Header";
        MealLine: Record "Meal Line";
        WorkDays: Integer;
        DimValue: Record "Dimension Value";
        DimText: Text[200];
        ABCode: Code[10];
        WAJM: Text[10];
        WageTypeT: Text[30];
        ATPercentage: Decimal;
        PageNo: Integer;
        Txt008: Label 'There is no work day in last 12 months for employee %1';
        RemarksRowNo: Integer;
        ObustaveNo: Integer;
        Text000: Label 'PAY LIST';
        Text001: Label 'UGOVOR O DJELU';
        Text002: Label 'UGOVOR O DJELU';
        Text003: Label 'ISPLATA AUTORSKOG HONORARA';
        Text004: Label 'Porez na dohodak';
        Text005: Label 'Porez na dr. sam. djel. - NER';
        Text006: Label 'Porez na dr. sam. djel. - R';
        Percentagesign: Code[10];
        ATCatConFromBrutto: Record "Contribution Category";
        ATCatConFromBruttoRS: Record "Contribution Category";
        ATCatConOverBrutto: Record "Contribution Category Conn.";
        atfrom: Record "Contribution";
        atover: Record "Contribution";
        ATPercentageFrom: Decimal;
        ConCat: Record "Contribution Category";
        NetAmount: Decimal;
        TaxPercentage: Decimal;
        WC: Record "Wage Calculation";
        ATPercentageRS: Decimal;
        ATPercentageRSFrom: Decimal;
        ContrRS: Decimal;
        WA3Description: Text;
        WA3Sum: Decimal;
        use: Decimal;
        T_HumanResourceSetup: Record "Human Resources Setup";
        CompanyInfo: Record "Company Information";
        COA: Record "Cause of Absence";
        COADescription: Text[250];
        WAT: Record "Wage Addition Type";
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        WHNo: Text;
        WageHeader: Record "Wage Header";
        Contribution: Record "Contribution";
        COAType: Boolean;
        ContributionFrom: Boolean;
        ContributionOver: Boolean;
        ReductionType: Boolean;
        COADescriptionR: Text[250];
        Percentage: Decimal;
        ContributionPercentage: Record "Contribution Category Conn.";
        WVE: Record "Wage Value Entry";
        emp: Code[10];
        PAymentNetto: Decimal;
        PaymentBrutto: Decimal;
        PaymentContribution: Decimal;
        PaymentRed: Decimal;
        WVE2: Record "Wage Value Entry";
        WVE3: Record "Wage Value Entry";
        WVE4: Record "Wage Value Entry";
        PAymentContributionOver: Decimal;
        CPE: Record "Contribution Per Employee";
        Base: Decimal;
        EmployeeRec: Record "Employee";
        BankAccountNo: Code[30];
        FirstName: Text;
        LastName: Text;
        WorkExperiencePercentage: Decimal;
        WageBase: Decimal;
        WageCalculation: Record "Wage Calculation";
        PaymentType: Text;
        BruttoAmount: Decimal;
        TaxAll: Decimal;
        PAymentNetto2: Decimal;
        ContributionPercent: Decimal;
        ContributionCategory: Record "Contribution Category Conn.";
        ContributionOn: Text;
        PaymentOn: Text;
        BruttoAmountOn: Decimal;
        Orderby: Integer;
        RedovanRad: Text;
        RedovanRad2: Text;
        BrutoRedovan: Decimal;
        GO: Text;
        GO2: Text;
        BrutoGO: Decimal;
        Vjerski: Text;
        Vjerski2: Text;
        BrutoVjerski: Decimal;
        HoursRed: Integer;
        HoursGo: Integer;
        HoursVje: Integer;
        RedovanNeto: Decimal;
        GONeto: Decimal;
        VjerskiNeto: Decimal;
        Meal: Text;
        Meal2: Text;
        BrutoMeal: Decimal;
        NetoMeal: Decimal;
        Meal1: Text;
        Meal12: Text;
        BrutoMeal1: Decimal;
        NetoMeal1: Decimal;
        Brojac: Integer;
        Hours2: Integer;
        COADescription2: Text;
        PaymentType2: Text;
        BruttoAmount2: Decimal;
        COADescription3: Text;
        PaymentType3: Text;
        BruttoAmount3: Decimal;
        NettoAmount3: Decimal;
        Transport: Decimal;
        COADescription4: Text;
        PaymentType4: Text;
        PAymentNettoOporezivi: Decimal;
        PaymentContribution2: Text;
        ContributionR: Record "Contribution";
        COAContributioOVer: Text;
        PercenteC: Decimal;
        WageBaseContri: Decimal;
        NetoCont: Decimal;
        TotalSumCon: Decimal;
        TotalPercent: Decimal;
        TotalSumSpecial: Decimal;
        PaymentContributionSpecial: Text;
        COASpecial: Text;
        PercenteSpecial: Decimal;
        WageBaseSpecial: Decimal;
        NetoSpecial: Decimal;
        NettoReduction: Decimal;
        ReductionCode: Code[10];
        ReductionText: Text;
        ReductionTypes: Record "Reduction types";
        ReductionList: Record "Reduction";
        Partija: Text;
        ReductionAmount: Decimal;
        ReductionDue: Decimal;
        AmountR: Decimal;
        TotalReduction: Decimal;
        TotalDue: Decimal;
        TotalAmountR: Decimal;
        Porez: Decimal;
        Coefficient: Decimal;
        BenefitsDed: Decimal;
        RecordTaxClass: Record "Tax Class";
        Postotak: Decimal;
        COADescriptionTopli: Integer;
        COADescription5: Text;
        PenzijCode: Text;
        PenzijDescription: Text;
        ContributionPenzij: Decimal;
        BrutoPenzij: Decimal;
        ZdravCode: Text;
        ZdravDescription: Text;
        ContributionZdrav: Decimal;
        BrutoZdrav: Decimal;
        NezaposlenostCode: Text;
        NezaposlenostDescription: Text;
        ContributionNezaposlenost: Decimal;
        BrutoNezaposlenost: Decimal;
        TotalCont: Decimal;
        PenzijCodefalse: Text;
        PenzijDescriptionfalse: Text;
        ContributionPenzijfalse: Decimal;
        BrutoPenzijfalse: Decimal;
        ZdravCodefalse: Text;
        ZdravDescriptionfalse: Text;
        ContributionZdravfalse: Decimal;
        BrutoZdravfalse: Decimal;
        NezaposlenostCodefalse: Text;
        NezaposlenostDescriptionfalse: Text;
        ContributionNezaposlenostfalse: Decimal;
        BrutoNezaposlenostfalse: Decimal;
        TotalContfalse: Decimal;
        Brojac2: Integer;
        PaymentContributionSpecial2: Text;
        COASpecial2: Text;
        PercenteSpecial2: Decimal;
        WageBaseSpecial2: Decimal;
        NetoSpecial2: Decimal;
        TotalSumSpecial2: Decimal;
        EntryValue: Integer;
        WH: Record "Wage Header";
        Calc: Record "Wage Calculation";
        NetoPlaca: Decimal;
        UkupanDohodak: Decimal;
        NetoZaIsplatu: Decimal;
        ECL: Record "Employee Contract Ledger";
        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        UserM: record "User Setup";
        transaction1: text[100];
        transaction3: text[100];

        transaction4: text[100];
        transaction3Name: text[100];

        transaction2Name: text[100];
        transaction4Name: text[100];
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];
        transaction8Name: TEXT[100];
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];
        transaction10: TEXT[100];
        banacc: Record "Bank account";
        transaction11Name: TEXT[100];
        transaction11: TEXT[100];
        transaction12Name: TEXT[100];
        transaction12: TEXT[100];
        transaction13Name: TEXT[100];
        transaction13: TEXT[100];
        transaction14Name: TEXT[100];
        transaction14: TEXT[100];




    procedure SetPayList(Month: Integer; Year: Integer)
    begin
        IDMonth := Month;
        IDYear := Year;
    end;
}
