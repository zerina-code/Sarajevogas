codeunit 50002 "Wage Calculation"
{
    // //NK

    TableNo = "Wage Header";

    trigger OnRun()
    var
        MealAQuantity: Decimal;
        COA: Record "Cause of Absence";
        ConfData: Record "Wage Amounts";
        BruttoStimulation: Decimal;
        EmplDefDim: Record "Employee Default Dimension";
        GLSetup: Record "General Ledger Setup";
        CalculateReductions: Boolean;
        Calculation2: Record "Wage Calculation";
        EndDate2: Date;
        CauseA: Record "Cause of Absence";
        UnPaidHours: Decimal;
        TaxUnPaid: Decimal;
        TaxBasisUnPaid: Decimal;
        WorkExperienceUnpaid: Decimal;
        PaidHours: Decimal;
        BasisH: Decimal;
        WANetto2: Record "Wage Addition";
        WATypeFind: Record "Wage Addition Type";
        WageAdditionAmount: decimal;
        BruttoValue: Decimal;
    begin

        Employee.LOCKTABLE;
        Absences.LOCKTABLE;
        Cause.LOCKTABLE;
        Setup.LOCKTABLE;
        Header.LOCKTABLE;
        CalcTemp.LOCKTABLE;
        AddTaxes.LOCKTABLE;
        AddTaxCat.LOCKTABLE;
        ATCCon.LOCKTABLE;
        ATEmpTemp.LOCKTABLE;
        Class.LOCKTABLE;
        TaxEmp.LOCKTABLE;
        TaxEmpTemp.LOCKTABLE;
        Errors.LOCKTABLE;
        EmpContract.LOCKTABLE;
        WA.LOCKTABLE;
        WAT.LOCKTABLE;


        StartTempLine := '99999';

        Header := Rec;
        Setup.GET;

        StartDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", TRUE);
        EndDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", FALSE);


        IF Header.Transportation THEN BEGIN
            TransHeader.RESET;
            TransHeader.SETFILTER("Year of Wage", '%1', Header."Year Of Wage");
            TransHeader.SETFILTER("Month Of Wage", '%1', Header."Month Of Wage");
            TransHeader.SETFILTER(Status, '<>%1', 2);
            TransHeader.FINDFIRST;
        END;

        IF Header.Meal THEN BEGIN
            MealHeader.RESET;
            MealHeader.SETFILTER("Year Of Wage", '%1', Header."Year Of Wage");
            MealHeader.SETFILTER("Month Of Wage", '%1', Header."Month Of Wage");
            MealHeader.SETFILTER(Status, '<>%1', 2);
            MealHeader.FINDFIRST;
        END;

        IF Header.Reduction THEN BEGIN
            RedNo := '0000000000';
            ReductionReal.RESET;
            IF ReductionReal.FIND('+') THEN
                RedNo := ReductionReal."No.";
        END;

        IF Header."Wage Calculation Type" = Header."Wage Calculation Type"::Normal THEN
            Employee.SETRANGE(Employee."For Calculation", TRUE);

        IF Rec."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add" THEN
            Employee.SETRANGE("Calculate Wage Addition", TRUE);

        WA.SETRANGE("Wage Header No.", Header."No.");
        WA.SETRANGE("Wage Header Entry No.", Header."Entry No.");

        CurrRecNo := 0;
        TotalRecNo := Employee.COUNT;

        Window.OPEN('Obrada plata: \@1@@@@@@@@@@@@@@@@@@@@@  :: Radnici\');
        Window.UPDATE(1, 0);

        CalcTemp.RESET;
        CalcTemp.SETRANGE(CalcTemp."Wage Header No.", Header."No.");
        //
        WageSetup.GET;
        CompInfo.GET;

        AbsenceEmp.RESET;
        AbsenceEmp.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
        AbsenceEmp.SETRANGE("From Date", StartDate, EndDate);
        AbsenceEmp.SETRANGE(Calculated, FALSE);

        LTEA.RESET;
        LTEA.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
        LTEA.SETRANGE("From Date", StartDate, EndDate);
        LTEA.SETRANGE(Calculated, FALSE);



        IF Employee.FINDFIRST THEN
            REPEAT
                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                /* IF EmpContract.GET(Employee."Emplymt. Contract Code") THEN
                  EmployeeContractType:=EmpContract."Calculation Type"
                 ELSE*/
                EmployeeContractType := EmployeeContractType::Worker;

                CalcTemp.SETRANGE(CalcTemp."Employee No.", Employee."No.");
                GLSetup.GET;

                CalculateReductions := TRUE;
                IF CalcTemp.FINDFIRST THEN
                    REPEAT
                        PostCode.GET(Employee."Post Code CIPS", Employee."City CIPS");
                        Municipality.GET(Employee."Municipality Code CIPS");
                        WageType.GET(Employee."Wage Type");
                        GetAddTaxesPercentage(AddTaxesPercentage);
                        EmplDefDim.SETRANGE("No.", Employee."No.");
                        EmplDefDim.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
                        EmplDefDim.SETRANGE("Dimension Value Code", CalcTemp."Global Dimension 1 Code");
                        EmplDefDim.FINDFIRST;




                        CASE WageType."Wage Calculation Type" OF
                            WageType."Wage Calculation Type"::Netto:
                                BEGIN
                                    // NETTO CALCULATION CODE
                                    ConfData.RESET;
                                    ConfData.SETRANGE("Employee No.", Employee."No.");
                                    ConfData.FINDFIRST;

                                    IF ConfData."Net Amount" THEN
                                        WageAmount := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff."
                                    ELSE
                                        WageAmount := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff." / WageSetup."Coefficient Netto to Brutto";


                                    CalcTemp."Wage (Base)" := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";
                                    CalcTemp."Wage (Base) is Neto" := ConfData."Net Amount";


                                    EndDate2 := AbsenceFill.GetMonthRange(Date2DMY(calcdate('<-1M>', StartDate), 2), Date2DMY(calcdate('<-1M>', StartDate), 3), FALSE);

                                    AbsBruto.Reset();
                                    AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                    AbsBruto.SetFilter("Sick Leave", '%1', true);
                                    AbsBruto.SetFilter("From Date", '%1..%2', calcdate('<-1M>', StartDate), EndDate2);
                                    AbsBruto.SetCurrentKey("From Date");
                                    AbsBruto.Ascending;
                                    if AbsBruto.FindLast() then begin
                                        //ako je u prošlom mjesecu bilo bolovanje, onda ide bruto osnovica ovog mjeseca
                                        CalcTemp."Sick Leave Brutto" := WageAmount;

                                    end
                                    else begin

                                        AbsBruto.Reset();
                                        AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                        AbsBruto.SetFilter("Sick Leave", '%1', false);
                                        AbsBruto.SetFilter("From Date", '%1..%2', calcdate('<-1M>', StartDate), EndDate2);
                                        AbsBruto.SetCurrentKey("From Date");
                                        AbsBruto.Ascending;
                                        if AbsBruto.FindLast() then begin

                                            WWeBruto.Reset();
                                            WWeBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                            WWeBruto.SetFilter("Entry Type", '%1|%2|%3', WWeBruto."Entry Type"::"Net Wage", WWeBruto."Entry Type"::Use, WWeBruto."Entry Type"::Taxable);
                                            WWeBruto.SetFilter("Document No.", '%1', AbsBruto."Wage Header No.");
                                            WWeBruto.SetFilter("Include WVE", '%1', false);
                                            WWeBruto.SetFilter("Wage Calculation Type", '%1', CalcTemp."Wage Calculation Type");
                                            if WWeBruto.FindFirst() then begin
                                                WWeBruto.CalcSums("Cost Amount (Brutto)");
                                                if WWeBruto."Cost Amount (Brutto)" > WageAmount then
                                                    CalcTemp."Sick Leave Brutto" := WWeBruto."Cost Amount (Brutto)"
                                                else
                                                    CalcTemp."Sick Leave Brutto" := WageAmount;
                                            end
                                            else begin
                                                CalcTemp."Sick Leave Brutto" := CalcTemp."Sick Leave Brutto";
                                            end;
                                        end

                                        else begin
                                            CalcTemp."Sick Leave Brutto" := WageAmount;

                                        end;
                                    end;
                                    if CalcTemp."Sick Leave Brutto" = 0 then
                                        CalcTemp."Sick Leave Brutto" := WageAmount;

                                    CalcTemp.MODIFY;

                                    CalcTemp."Net Wage" := WageAmount;


                                    //ĐK probaj   EmpCoefficient := CalcTemp."Net Wage" / CalcTemp."Hour Pool";
                                    EmpCoefficient := CalcTemp."Netto Wage Base" / CalcTemp."Hour Pool";
                                    CalcTemp."Employee Coefficient" := EmpCoefficient;
                                    CalcTemp.MODIFY;

                                    WageFromHours(CalcTemp."Net Wage", EmpCoefficient, EmplDefDim."Amount Distribution Coeff.");
                                    AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                    BruttoFromNetto;
                                    WageFromBrutto(TRUE, CalculateReductions, CalcTemp."Global Dimension 1 Code", CalcTemp."Global Dimension 2 Code");
                                    CalculateReductions := FALSE;
                                END;


                            WageType."Wage Calculation Type"::Netto2:
                                BEGIN
                                    // NETTO2 CALCULATION CODE

                                    ConfData.RESET;
                                    ConfData.SETRANGE("Employee No.", Employee."No.");
                                    ConfData.FINDFIRST;
                                    /*IF CalculateReductions THEN CalcReductions;
                                    CalculateReductions := FALSE;*/
                                    //da uzmem oaj Net Amount 2 //neto iznos sa isplato

                                    StartDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", TRUE);
                                    EndDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", FALSE);

                                    BruttoValue := 0;


                                    AbsFill.reset;
                                    AbsFill.setfilter("Employee No.", '%1', CalcTemp."Employee No.");
                                    AbsFill.setfilter("From Date", '%1..%2', StartDate, EndDate);
                                    AbsFill.SetFilter(Quantity, '<>%1', 0);
                                    if AbsFill.FindSet() THEN
                                        repeat
                                            CauseA.Reset();
                                            CauseA.SetFilter(Code, '%1', AbsFill."Cause of Absence Code");
                                            if CauseA.FindFirst() then begin
                                                BruttoValue += CauseA.Coefficient * AbsFill.Quantity;


                                            end;


                                        UNTIL AbsFill.NEXT = 0;
                                    //kraj djemina

                                    //                                    ConfData."Net Amount 2" := (ConfData."Net Amount 2" * BruttoValue) / CalcTemp."Hour Pool";
                                    CalcTemp.Payment := ROUND((ConfData."Net Amount 2" * EmplDefDim."Amount Distribution Coeff."), 0.01, '=');
                                    //ĐK CalcTemp."Final Net Wage" := CalcTemp.Payment - CalcTemp."Wage Reduction";
                                    CalcTemp."Final Net Wage" := CalcTemp.Payment;
                                    CalcTemp.MODIFY;


                                    TransportAndMeal(EmplDefDim."Amount Distribution Coeff.");
                                    AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                    CalcTemp."Net Wage After Tax" := ROUND((CalcTemp."Final Net Wage" - CalcTemp."Wage Addition"), 0.01, '=');
                                    CalcTemp."Untaxable Wage" := CalcTemp.Transport + CalcTemp."Meal to pay" + CalcTemp."Wage Addition";
                                    CalcTemp.MODIFY;

                                    //ĐK    IndirectWageAddition;
                                    AddTaxCat.GET(CalcTemp."Contribution Category Code");
                                    Class.RESET;
                                    Class.SETCURRENTKEY("Valid From Amount");
                                    Class.SETRANGE(Active, TRUE);
                                    Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                                    Class.FINDFIRST;
                                    //NK Tax Deductions
                                    WageCalc.SETFILTER("Employee No.", '%1', CalcTemp."Employee No.");
                                    WageCalc.SETFILTER("Month Of Wage", '%1', CalcTemp."Month Of Wage");
                                    WageCalc.SETFILTER("Year of Wage", '%1', CalcTemp."Year Of Wage");
                                    IF WageCalc.FIND('-') THEN
                                        WageCalc.CALCSUMS("Tax Deductions");
                                    //CalcTemp."Tax Deductions":=Employee."Tax Deduction Amount";
                                    CalcTemp."Tax Deductions" := Employee."Tax Deduction Amount" - WageCalc."Tax Deductions";

                                    Percent := Class.Percentage / 100 * AddTaxCat."Tax Payment Percentage" / 100;
                                    PraviousV := CalcTemp."Net Wage";
                                    CalcTemp."Net Wage" := ((CalcTemp."Net Wage After Tax" + CalcTemp."Indirect Wage Addition Amount") -
                                                   CalcTemp."Tax Deductions" * Percent) / (1 - Percent);

                                    if CalcTemp."Contribution Category Code" = 'RS' then
                                        CalcTemp.Tax := (CalcTemp.Brutto - CalcTemp."Tax Deductions") * Percent
                                    else
                                        CalcTemp.Tax := (CalcTemp."Net Wage" - CalcTemp."Tax Deductions") * Percent;





                                    BruttoFromNetto;



                                    //ovdje bih ja sada dodala i a

                                    //  WageFromBrutto(TRUE, CalculateReductions, CalcTemp."Global Dimension 1 Code", CalcTemp."Global Dimension 2 Code");

                                    CalcTemp."Net Wage Netto 2" += (CalcTemp."Net Wage" - CalcTemp."Indirect Wage Addition Amount" - ((CalcTemp."Wage Addition Brutto") / (1 / (1 - AddTaxesPercentage / 100)))) /
                                                                     (1 + (Employee."Work Experience Percentage" / 100));
                                    CalcTemp.MODIFY;
                                    StartDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", TRUE);
                                    EndDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", FALSE);



                                    EndDate2 := AbsenceFill.GetMonthRange(Date2DMY(calcdate('<-1M>', StartDate), 2), Date2DMY(calcdate('<-1M>', StartDate), 3), FALSE);

                                    AbsBruto.Reset();
                                    AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                    AbsBruto.SetFilter("Sick Leave", '%1', true);
                                    AbsBruto.SetFilter("From Date", '%1..%2', calcdate('<-1M>', StartDate), EndDate2);
                                    AbsBruto.SetCurrentKey("From Date");
                                    AbsBruto.Ascending;
                                    if AbsBruto.FindLast() then begin
                                        //ako je u prošlom mjesecu bilo bolovanje, onda ide bruto osnovica ovog mjeseca
                                        CalcTemp."Sick Leave Brutto" := CalcTemp.Brutto;

                                    end
                                    else begin

                                        AbsBruto.Reset();
                                        AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                        AbsBruto.SetFilter("Sick Leave", '%1', false);
                                        AbsBruto.SetFilter("From Date", '%1..%2', calcdate('<-1M>', StartDate), EndDate2);
                                        AbsBruto.SetCurrentKey("From Date");
                                        AbsBruto.Ascending;
                                        if AbsBruto.FindLast() then begin

                                            WWeBruto.Reset();
                                            WWeBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                            WWeBruto.SetFilter("Entry Type", '%1|%2|%3', WWeBruto."Entry Type"::"Net Wage", WWeBruto."Entry Type"::Use, WWeBruto."Entry Type"::Taxable);
                                            WWeBruto.SetFilter("Document No.", '%1', AbsBruto."Wage Header No.");
                                            WWeBruto.SetFilter("Include WVE", '%1', false);
                                            WWeBruto.SetFilter("Wage Calculation Type", '%1', CalcTemp."Wage Calculation Type");
                                            if WWeBruto.FindFirst() then begin
                                                WWeBruto.CalcSums("Cost Amount (Brutto)");
                                                if WWeBruto."Cost Amount (Brutto)" > CalcTemp.Brutto then
                                                    CalcTemp."Sick Leave Brutto" := WWeBruto."Cost Amount (Brutto)"
                                                else
                                                    CalcTemp."Sick Leave Brutto" := CalcTemp.Brutto;
                                            end
                                            else begin
                                                CalcTemp."Sick Leave Brutto" := CalcTemp."Sick Leave Brutto";
                                            end;
                                        end

                                        else begin
                                            CalcTemp."Sick Leave Brutto" := CalcTemp.Brutto;

                                        end;
                                    end;
                                    if CalcTemp."Sick Leave Brutto" = 0 then
                                        CalcTemp."Sick Leave Brutto" := CalcTemp.Brutto;

                                    UnPaidHours := 0;
                                    PaidHours := 0;
                                    TaxBasisUnPaid := 0;
                                    AbsFill.reset;
                                    AbsFill.setfilter("Employee No.", '%1', CalcTemp."Employee No.");
                                    AbsFill.setfilter("From Date", '%1..%2', StartDate, EndDate);
                                    AbsFill.SetFilter(Quantity, '<>%1', 0);
                                    if AbsFill.FindSet() THEN
                                        repeat
                                            CauseA.Reset();
                                            CauseA.SetFilter(Code, '%1', AbsFill."Cause of Absence Code");
                                            CauseA.SetFilter(Coefficient, '%1', 0);
                                            if CauseA.FindFirst() then begin
                                                UnPaidHours += AbsFill.Quantity;//ovo je 72
                                                                                //112 sati
                                            end;



                                        UNTIL AbsFill.NEXT = 0;


                                    AbsFill.setfilter("Employee No.", '%1', CalcTemp."Employee No.");
                                    AbsFill.setfilter("From Date", '%1..%2', StartDate, EndDate);
                                    AbsFill.SetFilter(Quantity, '<>%1', 0);
                                    if AbsFill.FindSet() THEN
                                        repeat
                                            CauseA.Reset();
                                            CauseA.SetFilter(Code, '%1', AbsFill."Cause of Absence Code");
                                            CauseA.SetFilter(Coefficient, '<>%1', 0);
                                            if CauseA.FindFirst() then begin
                                                PaidHours += AbsFill.Quantity;//ovo je 112
                                                                              //112 sati
                                            end;



                                        UNTIL AbsFill.NEXT = 0;

                                    //za mene 4225,25 

                                    WageAdditionAmount := 0;
                                    WANetto2.reset;
                                    WANetto2.setfilter("Employee NO.", '%1', CalcTemp."Employee No.");
                                    WANetto2.setfilter("Calculated", '%1', false);
                                    WANetto2.SetFilter(Meal, '%1', false);
                                    WANetto2.SetFilter("Month of Wage", '%1', CalcTemp."Month Of Wage");
                                    WANetto2.SetFilter("Year of Wage", '%1', CalcTemp."Year Of Wage");
                                    if WANetto2.FindSet() then
                                        repeat
                                            WATypeFind.Reset();
                                            WATypeFind.setfilter(Code, '%1', WANetto2."Wage Addition Type");
                                            if WATypeFind.FindFirst() then begin
                                                if (WATypeFind."Calculate Experience" = false) and (WATypeFind."Meal" = false) then
                                                    WageAdditionAmount += WANetto2.Amount;

                                            end;

                                        until WANetto2.Next() = 0;


                                    TaxBasisUnPaid := ((((CalcTemp."Final Net Wage" * PaidHours) / CalcTemp."Hour Pool") + CalcTemp."Indirect Wage Addition Amount") + WageAdditionAmount -

                                                                                      CalcTemp."Tax Deductions" * Percent) / (1 - Percent);



                                    TaxUnPaid := round(TaxBasisUnPaid, 0.01, '=');

                                    TaxUnPaid := (TaxUnPaid) / (1 - AddTaxesPercentage / 100);

                                    BasisH := TaxUnPaid / (1 + Employee."Work Experience Percentage" / 100);
                                    if CalcTemp."Sick Leave Brutto" = CalcTemp.Brutto then
                                        CalcTemp."Sick Leave Brutto" := BasisH;



                                    //2824,30


                                    //CalcTemp."Net Wage Netto 2" +=(CalcTemp."Net Wage"-CalcTemp."Indirect Wage Addition Amount")/
                                    //  (1+(Employee."Work Experience Percentage"/100));
                                    //SubtractNettoAdditions;
                                    //  CalcTemp."Net Wage Netto 2":=NetWageNetto2;
                                    CalcTemp.MODIFY;
                                    CalcTemp."Employee Coefficient" := CalcTemp."Net Wage Netto 2" / CalcTemp."Hour Pool";


                                    CalcTemp."Individual Hour Pool" := CalcTemp."Hour Pool";
                                    CalcTemp."Brutto Wage Base" := CalcTemp."Net Wage Netto 2" * (1) / (1 - AddTaxesPercentage / 100);
                                    CalcTemp."Netto Wage Base" := CalcTemp."Net Wage Netto 2";
                                    CalcTemp.MODIFY;
                                    if ((UnPaidHours <> 0) or (BruttoValue <> CalcTemp."Hour Pool")) and (PaidHours <> 0) then begin


                                        WageFromHoursNetto2(CalcTemp."Net Wage After Tax", (BasisH / PaidHours) / ((1) / (1 - AddTaxesPercentage / 100)), EmplDefDim."Amount Distribution Coeff.", PaidHours);
                                        if (UnPaidHours <> 0) then CalcTemp."Net Wage" := TaxBasisUnPaid;
                                        ConfData."Net Amount 2" := CalcTemp."Net Wage" - ((CalcTemp."Net Wage" - CalcTemp."Tax Deductions") * Class.Percentage / 100);


                                    end
                                    else begin

                                        WageFromHours(CalcTemp."Net Wage After Tax", CalcTemp."Employee Coefficient", EmplDefDim."Amount Distribution Coeff.");
                                        WageAdditionAmount := 0;
                                        WANetto2.reset;
                                        WANetto2.setfilter("Employee NO.", '%1', CalcTemp."Employee No.");
                                        WANetto2.setfilter("Calculated", '%1', false);
                                        WANetto2.SetFilter(Meal, '%1', false);
                                        WANetto2.SetFilter("Month of Wage", '%1', CalcTemp."Month Of Wage");
                                        WANetto2.SetFilter("Year of Wage", '%1', CalcTemp."Year Of Wage");
                                        if WANetto2.FindSet() then
                                            repeat
                                                WATypeFind.Reset();
                                                WATypeFind.setfilter(Code, '%1', WANetto2."Wage Addition Type");
                                                if WATypeFind.FindFirst() then begin
                                                    if (WATypeFind."Calculate Experience" = false) and (WATypeFind."Meal" = false) then
                                                        WageAdditionAmount += WANetto2.Amount;

                                                end;

                                            until WANetto2.Next() = 0;
                                        CalcTemp."Net Wage" := CalcTemp."Net Wage" + WageAdditionAmount;
                                        ConfData."Net Amount 2" := CalcTemp."Net Wage" - ((CalcTemp."Net Wage" - CalcTemp."Tax Deductions") * Class.Percentage / 100);

                                    end;
                                    //djemina dodala


                                    CalcTemp.Payment := ROUND((ConfData."Net Amount 2" * EmplDefDim."Amount Distribution Coeff."), 0.05, '=');
                                    //ĐK CalcTemp."Final Net Wage" := CalcTemp.Payment - CalcTemp."Wage Reduction";
                                    CalcTemp."Final Net Wage" := CalcTemp.Payment;
                                    CalcTemp.MODIFY;


                                    //    TransportAndMeal(EmplDefDim."Amount Distribution Coeff.");
                                    //  AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                    CalcTemp."Net Wage After Tax" := ROUND((CalcTemp."Final Net Wage" - CalcTemp."Wage Addition"), 0.05, '=');
                                    CalcTemp."Untaxable Wage" := CalcTemp.Transport + CalcTemp."Meal to pay" + CalcTemp."Wage Addition";
                                    CalcTemp.MODIFY;

                                    //ĐK    IndirectWageAddition;
                                    AddTaxCat.GET(CalcTemp."Contribution Category Code");
                                    Class.RESET;
                                    Class.SETCURRENTKEY("Valid From Amount");
                                    Class.SETRANGE(Active, TRUE);
                                    Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                                    Class.FINDFIRST;
                                    //NK Tax Deductions
                                    WageCalc.SETFILTER("Employee No.", '%1', CalcTemp."Employee No.");
                                    WageCalc.SETFILTER("Month Of Wage", '%1', CalcTemp."Month Of Wage");
                                    WageCalc.SETFILTER("Year of Wage", '%1', CalcTemp."Year Of Wage");
                                    IF WageCalc.FIND('-') THEN
                                        WageCalc.CALCSUMS("Tax Deductions");
                                    //CalcTemp."Tax Deductions":=Employee."Tax Deduction Amount";
                                    CalcTemp."Tax Deductions" := Employee."Tax Deduction Amount" - WageCalc."Tax Deductions";

                                    Percent := Class.Percentage / 100 * AddTaxCat."Tax Payment Percentage" / 100;
                                    PraviousV := CalcTemp."Net Wage";
                                    CalcTemp."Net Wage" := ((CalcTemp."Net Wage After Tax" + CalcTemp."Indirect Wage Addition Amount") -
                                                   CalcTemp."Tax Deductions" * Percent) / (1 - Percent);

                                    if CalcTemp."Contribution Category Code" = 'RS' then
                                        CalcTemp.Tax := (CalcTemp.Brutto - CalcTemp."Tax Deductions") * Percent
                                    else
                                        CalcTemp.Tax := (CalcTemp."Net Wage" - CalcTemp."Tax Deductions") * Percent;


                                    BruttoFromNetto;
                                    WageFromBrutto(TRUE, CalculateReductions, CalcTemp."Global Dimension 1 Code", CalcTemp."Global Dimension 2 Code");

                                    CalcTemp."Net Wage Netto 2" := (CalcTemp."Net Wage" - CalcTemp."Indirect Wage Addition Amount" - ((CalcTemp."Wage Addition Brutto") / (1 / (1 - AddTaxesPercentage / 100)))) /
                                                                     (1 + (Employee."Work Experience Percentage" / 100));
                                    CalcTemp.MODIFY;
                                    //CalcTemp."Net Wage Netto 2" +=(CalcTemp."Net Wage"-CalcTemp."Indirect Wage Addition Amount")/
                                    //  (1+(Employee."Work Experience Percentage"/100));
                                    //SubtractNettoAdditions;
                                    //  CalcTemp."Net Wage Netto 2":=NetWageNetto2;
                                    CalcTemp.MODIFY;
                                    //     CalcTemp."Employee Coefficient" := CalcTemp."Net Wage Netto 2" / CalcTemp."Hour Pool";
                                    CalcTemp."Individual Hour Pool" := CalcTemp."Hour Pool";
                                    CalcTemp."Brutto Wage Base" := CalcTemp."Net Wage Netto 2" * (1) / (1 - AddTaxesPercentage / 100);
                                    CalcTemp."Netto Wage Base" := CalcTemp."Net Wage Netto 2";
                                    CalcTemp.MODIFY;

                                    //kraj djemina
                                    if UnPaidHours <> 0 then begin

                                        CalcTemp."Wage (Base)" := CalcTemp."Net Wage Netto 2" * (1) / (1 - AddTaxesPercentage / 100);
                                        CalcTemp."Individual Hour Pool" := PaidHours;
                                        CalcTemp."Experience Total" := CalcTemp."Experience Total" * (1) * (1 - AddTaxesPercentage / 100);
                                    end
                                    else begin
                                        CalcTemp."Wage (Base)" := (CalcTemp."Employee Coefficient" * CalcTemp."Hour Pool") * ((1) / (1 - AddTaxesPercentage / 100));
                                    end;

                                    CalcTemp."Net Wage" := CalcTemp."Net Wage";
                                    //+ PraviousV;
                                    CalcTemp.MODIFY;


                                END;
                            //WG01

                            WageType."Wage Calculation Type"::Brutto:
                                BEGIN
                                    IF Header."Wage Calculation Type" = Header."Wage Calculation Type"::Normal THEN BEGIN
                                        ConfData.RESET;
                                        ConfData.SETRANGE("Employee No.", Employee."No.");
                                        ConfData.FINDFIRST;
                                        IF ConfData."Net Amount" THEN
                                            WageAmount := ConfData."Wage Amount" * WageSetup."Coefficient Netto to Brutto" * EmplDefDim."Amount Distribution Coeff."
                                        ELSE BEGIN
                                            IF (("Closing Date" > DMY2DATE(1, DATE2DMY("Closing Date", 2), DATE2DMY("Closing Date", 3))) AND ("Closing Date" < ConfData."Application Date"))
                                            THEN
                                                WageAmount := ConfData."Old Amount" * EmplDefDim."Amount Distribution Coeff."
                                            ELSE
                                                WageAmount := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";
                                        END;
                                        Position.RESET;
                                        Position.SETFILTER("Employee No.", '%1', Employee."No.");
                                        Position.SETFILTER("Active Position", '%1', TRUE);
                                        IF Position.FINDLAST THEN BEGIN

                                            CalcTemp."SAP 1" := '';
                                            CalcTemp."SAP 2" := '';
                                            CalcTemp."Org Entity Code" := Employee."Org Entity Code";
                                            EmployeeContractLedger.RESET;
                                            EmployeeContractLedger.SETFILTER("Employee No.", Employee."No.");
                                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                                            IF EmployeeContractLedger.FINDLAST THEN BEGIN
                                                EmployeeContractLedger.CALCFIELDS("Residence/Network");
                                                /*   SegmentationGroup.RESET;
                                                   SegmentationGroup.SETFILTER("Position No.", '%1', EmployeeContractLedger."Position Code");
                                                   SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                                                   SegmentationGroup.SETFILTER(Coefficient, '<>%1', 0);
                                                   SegmentationGroup.SETFILTER("Ending Date", '%1', 0D);
                                                   IF SegmentationGroup.FIND('+') THEN
                                                       CalcTemp."Management Level" := FORMAT(SegmentationGroup."Management Level");*/
                                                CalcTemp."Management Level" := format(EmployeeContractLedger."Management Level");
                                                CalcTemp."Position Code" := EmployeeContractLedger."Position Code";
                                                CalcTemp."Position ID" := EmployeeContractLedger."Position ID";
                                                CalcTemp."Position Description" := EmployeeContractLedger."Position Description";
                                                CalcTemp."Department Code" := EmployeeContractLedger."Department Code";
                                                CalcTemp."Department Name" := EmployeeContractLedger."Department Name";
                                                CalcTemp."B-1" := EmployeeContractLedger.Sector;
                                                CalcTemp."B-1 Description" := EmployeeContractLedger."Sector Description";
                                                CalcTemp."B-1 (with regions)" := EmployeeContractLedger."Department Category";
                                                CalcTemp."B-1 (with regions) Description" := EmployeeContractLedger."Department Cat. Description";
                                                CalcTemp.Stream := EmployeeContractLedger.Group;
                                                CalcTemp."Stream Description" := EmployeeContractLedger."Group Description";
                                                CalcTemp."Total Netto by Contract" := EmployeeContractLedger."Total Netto";
                                                CalcTemp."Netto by Contract" := EmployeeContractLedger.Netto;
                                                CalcTemp."Planned Transport Amount" := Employee."Transport Amount Planned";
                                                CalcTemp."Contact Center" := Employee."Contact Center";

                                                CalcTemp.MODIFY;
                                            END;
                                        END;
                                        IF (("Closing Date" > DMY2DATE(1, DATE2DMY("Closing Date", 2), DATE2DMY("Closing Date", 3))) AND ("Closing Date" < ConfData."Application Date"))
                                          THEN
                                            CalcTemp."Wage (Base)" := ConfData."Old Amount" * EmplDefDim."Amount Distribution Coeff."
                                        ELSE
                                            CalcTemp."Wage (Base)" := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";

                                        CalcTemp."Wage (Base) is Neto" := ConfData."Net Amount";
                                        CalcTemp."Date Of Calculation" := Header."Date Of Calculation";
                                        CalcTemp."Brutto Wage Base" := WageAmount;
                                        EndDate2 := AbsenceFill.GetMonthRange(Date2DMY(calcdate('<-1M>', StartDate), 2), Date2DMY(calcdate('<-1M>', StartDate), 3), FALSE);
                                        AbsBruto.Reset();
                                        AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                        AbsBruto.SetFilter("Sick Leave", '%1', true);
                                        AbsBruto.SetFilter("From Date", '%1..%2', calcdate('<-1M>', StartDate), EndDate2);
                                        AbsBruto.SetCurrentKey("From Date");
                                        AbsBruto.Ascending;
                                        if AbsBruto.FindLast() then begin
                                            //ako je u prošlom mjesecu bilo bolovanje, onda ide bruto osnovica ovog mjeseca
                                            CalcTemp."Sick Leave Brutto" := WageAmount;

                                        end
                                        else begin

                                            AbsBruto.Reset();
                                            AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                            AbsBruto.SetFilter("Sick Leave", '%1', false);
                                            AbsBruto.SetFilter("From Date", '%1..%2', calcdate('<-1M>', StartDate), EndDate2);
                                            AbsBruto.SetCurrentKey("From Date");
                                            AbsBruto.Ascending;
                                            if AbsBruto.FindLast() then begin

                                                WWeBruto.Reset();
                                                WWeBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                                WWeBruto.SetFilter("Entry Type", '%1|%2|%3', WWeBruto."Entry Type"::"Net Wage", WWeBruto."Entry Type"::Use, WWeBruto."Entry Type"::Taxable);
                                                WWeBruto.SetFilter("Document No.", '%1', AbsBruto."Wage Header No.");
                                                WWeBruto.SetFilter("Include WVE", '%1', false);
                                                WWeBruto.SetFilter("Wage Calculation Type", '%1', CalcTemp."Wage Calculation Type");
                                                if WWeBruto.FindFirst() then begin
                                                    WWeBruto.CalcSums("Cost Amount (Brutto)");
                                                    if WWeBruto."Cost Amount (Brutto)" > WageAmount then
                                                        CalcTemp."Sick Leave Brutto" := WWeBruto."Cost Amount (Brutto)"
                                                    else
                                                        CalcTemp."Sick Leave Brutto" := WageAmount;
                                                end
                                                else begin
                                                    CalcTemp."Sick Leave Brutto" := CalcTemp."Sick Leave Brutto";
                                                end;
                                            end

                                            else begin
                                                CalcTemp."Sick Leave Brutto" := WageAmount;

                                            end;
                                        end;
                                        if CalcTemp."Sick Leave Brutto" = 0 then
                                            CalcTemp."Sick Leave Brutto" := WageAmount;
                                        CalcTemp.MODIFY;

                                        AbsBruto.Reset();
                                        AbsBruto.SetFilter("Employee No.", '%1', CalcTemp."Employee No.");
                                        AbsBruto.SetFilter("Sick Leave", '%1', true);
                                        AbsBruto.SetFilter("From Date", '%1..%2', StartDate, EndDate);
                                        AbsBruto.SetCurrentKey("From Date");
                                        AbsBruto.Ascending;
                                        if AbsBruto.FindFirst() then begin
                                            AbsBruto2.Reset();
                                            AbsBruto2.CopyFilters(AbsBruto);
                                            if AbsBruto2.findset then
                                                repeat
                                                    COABruto.Get(AbsBruto2."Cause of Absence Code");
                                                    CalcTemp.Brutto += (CalcTemp."Sick Leave Brutto" / CalcTemp."Hour Pool") * AbsBruto2.Quantity * COABruto.Coefficient;

                                                //+ (WageAmount / CalcTemp."Hour Pool") * (CalcTemp."Hour Pool" - AbsBruto.Quantity);

                                                until AbsBruto2.Next() = 0;

                                            AbsBruto2.Reset();
                                            AbsBruto2.CopyFilters(AbsBruto);
                                            AbsBruto2.SetFilter("Add Hours", '%1', false);
                                            AbsBruto2.SetFilter(Weekend, '%1', false);
                                            AbsBruto2.SetFilter("Sick Leave", '%1', false);
                                            if AbsBruto2.findset then
                                                repeat
                                                    COABruto.Get(AbsBruto2."Cause of Absence Code");
                                                    CalcTemp.Brutto += (WageAmount / CalcTemp."Hour Pool") * AbsBruto2.Quantity * COABruto.Coefficient;

                                                until AbsBruto2.Next() = 0;





                                            /*   AbsBruto.CalcSums(Quantity);
                                               AbsBruto2.Reset();
                                               AbsBruto2.CopyFilters(AbsBruto);
                                               AbsBruto2.SetFilter("Sick Leave", '%1', false);

                                               if AbsBruto2.FindFirst() then begin
                                                   AbsBruto2.CalcSums(Quantity);

                                                   //COA.CoefficientĐKovde
                                                   COABruto.Get(AbsBruto)
                                                   CalcTemp.Brutto := (CalcTemp."Sick Leave Brutto" / CalcTemp."Hour Pool") * AbsBruto.Quantity + (WageAmount / CalcTemp."Hour Pool") * (CalcTemp."Hour Pool" - AbsBruto.Quantity);


                                               end
                                               else begin
                                                   CalcTemp.Brutto := (CalcTemp."Sick Leave Brutto" / CalcTemp."Hour Pool") * AbsBruto.Quantity;
                                               end;

   */


                                        end
                                        else begin
                                            CalcTemp.Brutto := WageAmount;
                                            //ako nema bruto osnovicu
                                        end;



                                        //ĐK ovdje dodati polovicu od bolovanja   ;



                                        NettoFromBrutto;
                                        CalcTemp."Netto Wage Base" := CalcTemp."Brutto Wage Base" * (1 - AddTaxesPercentage / 100);
                                        CalcTemp.MODIFY;
                                        /*  IF CalcTemp."Hour Pool"=0 THEN BEGIN
                                            Employee.CALCFIELDS("Department code");
                                         IF ((Employee."Department code"='D.2.3.') OR (Employee."Hours In Day"<8))  THEN BEGIN
                                              StartDate:= AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage",CalcTemp."Year Of Wage",TRUE);
                                              EndDate:= AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage",CalcTemp."Year Of Wage",FALSE);
                                           COACT.RESET;
                                           COACT.SETFILTER("Added To Hour Pool",'%1',FALSE);
                                           IF COACT.FINDFIRST THEN REPEAT
                                           AbsenceCT.SETFILTER("Employee No.",CalcTemp."Employee No.");
                                           AbsenceCT.SETFILTER("Cause of Absence Code",'%1',COACT.Code);
                                           AbsenceCT.SETFILTER("From Date",'%1..%2',StartDate,EndDate);
                                           AbsenceCT.CALCSUMS(Quantity);
                                        CalcTemp."Hour Pool"+=AbsenceCT.Quantity;
                                      CalcTemp.MODIFY;
                                       UNTIL COACT.NEXT=0;
                                       END
                                        ELSE BEGIN
                                        CalcTemp."Hour Pool" := "Hour Pool"*EmplDefDim."Amount Distribution Coeff.";
                                        CalcTemp.MODIFY;
                                      END;
                                       END;*/

                                        //ĐK Korekcija
                                        IF NOT Employee."Contact Center" THEN
                                            EmpCoefficient := CalcTemp."Netto Wage Base" / CalcTemp."Hour Pool"
                                        ELSE
                                            //    EmpCoefficient := CalcTemp."Wage (Base)"/CalcTemp."Hour Pool";
                                            EmpCoefficient := CalcTemp."Netto Wage Base" / CalcTemp."Hour Pool";



                                        OldEmpCoefficient := (ConfData."Old Amount" / CalcTemp."Hour Pool") * (1 - AddTaxesPercentage / 100);

                                        CalcTemp."Employee Coefficient" := EmpCoefficient;
                                        CalcTemp.Status := Employee.StatusExt;
                                        CalcTemp."Department Municipality" := Employee."Org Municipality";
                                        IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                                            Orgdijelovi.RESET;
                                            Orgdijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                                            Orgdijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                                            Orgdijelovi.SETFILTER(GF, '%1', Employee.GF);
                                            IF Orgdijelovi.FINDFIRST THEN
                                                CalcTemp."JIB Contributes" := Orgdijelovi."JIB Contributes";
                                        END;
                                        CalcTemp."Employee Name" := Employee."Last Name" + ' ' + Employee."First Name";
                                        CalcTemp."Old Brutto" := ConfData."Old Amount";
                                        CalcTemp.MODIFY;

                                        WageFromHours(CalcTemp."Net Wage", EmpCoefficient, EmplDefDim."Amount Distribution Coeff.");
                                        WageFromHoursOld(CalcTemp."Net Wage", OldEmpCoefficient, EmplDefDim."Amount Distribution Coeff."); //
                                        AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");


                                        Bruto := 0;
                                        Coef := 0;
                                        AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                                        AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', 'NPL-O');
                                        AbsenceEmp.CALCSUMS(Quantity);
                                        IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                                            CalcTemp."Unpaid Absence" := (((CalcTemp.Brutto / CalcTemp."Hour Pool")) * AbsenceEmp.Quantity);
                                            CalcTemp."Unpaid Absence Hours" := (AbsenceEmp.Quantity);
                                            COA.RESET;
                                            IF COA.FINDFIRST THEN
                                                REPEAT
                                                    AbsenceEmp2.RESET;
                                                    AbsenceEmp2.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");

                                                    AbsenceEmp2.SETFILTER("Employee No.", Employee."No.");
                                                    AbsenceEmp2.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                                    AbsenceEmp2.SETRANGE("From Date", StartDate, EndDate);

                                                    AbsenceEmp2.CALCSUMS(Quantity);
                                                    IF COA.Code <> 'NPL-O' THEN BEGIN
                                                        Bruto += (((CalcTemp.Brutto / CalcTemp."Hour Pool") * COA.Coefficient) * AbsenceEmp2.Quantity);
                                                        BBruto += (((CalcTemp.Brutto / CalcTemp."Hour Pool")) * AbsenceEmp2.Quantity);
                                                        Coef += (((CalcTemp.Brutto / CalcTemp."Hour Pool") * (1 - COA.Coefficient)) * AbsenceEmp2.Quantity)
                                                    END;
                                                UNTIL COA.NEXT = 0;

                                            CalcTemp."Wage (Base)" := BBruto;
                                            CalcTemp.Brutto := Bruto + (CalcTemp."Wage (Base)" * CalcTemp."Work Experience Percentage" / 100);
                                            CalcTemp."Work Experience Brutto" := (CalcTemp."Wage (Base)" * (CalcTemp."Work Experience Percentage" / 100));
                                            CalcTemp."Coeff. Difference" := Coef + CalcTemp."Work Experience Brutto";
                                            NettoFromBrutto;

                                        END
                                        ELSE
                                            BruttoFromNetto;

                                        //NK start
                                        Coef2 := 0;
                                        AbsenceEmp3.SETFILTER("Employee No.", Employee."No.");
                                        AbsenceEmp3.SETFILTER("Cause of Absence Code", '%1', 'NPL-O');
                                        AbsenceEmp3.CALCSUMS(Quantity);
                                        IF AbsenceEmp3.Quantity = 0 THEN BEGIN

                                            COA.RESET;
                                            IF COA.FINDFIRST THEN
                                                REPEAT
                                                    AbsenceEmp4.RESET;
                                                    AbsenceEmp4.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");

                                                    AbsenceEmp4.SETFILTER("Employee No.", Employee."No.");
                                                    AbsenceEmp4.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                                    AbsenceEmp4.SETRANGE("From Date", StartDate, EndDate);

                                                    AbsenceEmp4.CALCSUMS(Quantity);
                                                    //IF ((COA.Code='BOL') OR (COA.Code='BOL-42')) THEN  BEGIN
                                                    IF (COA."Calculation Type" = COA."Calculation Type"::Sick) THEN BEGIN
                                                        Coef2 += (((CalcTemp."Wage (Base)" / CalcTemp."Hour Pool") * (1 - COA.Coefficient)) * AbsenceEmp4.Quantity)
                                                    END;
                                                UNTIL COA.NEXT = 0;
                                            CalcTemp."Coeff. Difference" := Coef2;
                                        END;

                                        //WG1
                                        CalcTemp.Brutto += BruttoStimulation;
                                        WageFromBrutto(TRUE, CalculateReductions, CalcTemp."Global Dimension 1 Code", CalcTemp."Global Dimension 2 Code");
                                        // WageFromBruttoIncentive(TRUE,CalculateReductions,CalcTemp."Global Dimension 1 Code",CalcTemp."Global Dimension 2 Code");
                                        IF WageType."Wage Calculation Type" <> 3 THEN
                                            CalcTemp.Payment := CalcTemp."Net Wage" + CalcTemp."Untaxable Wage" - CalcTemp.Tax - CalcTemp."Wage Reduction";
                                        CalcTemp."Net Wage After Tax" := CalcTemp."Net Wage" - CalcTemp.Tax;
                                        CalcTemp.CALCFIELDS("Use Netto");
                                        CalcTemp."Total Netto Without Use" := CalcTemp."Net Wage" - CalcTemp."Use Netto" + CalcTemp."Untaxable Wage";
                                        CalcTemp."Total Netto Without Untaxable" := (CalcTemp."Net Wage" - CalcTemp."Use Netto");
                                        CalcTemp.MODIFY;
                                        CalculateReductions := FALSE;
                                    END;
                                END;
                        //WGA01
                        END;
                        IF Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add" THEN BEGIN

                            Calculation.SETFILTER("Wage Header No.", '%1', "No.");
                            // Calculation.SETFILTER("No.", CalcTemp."No.");
                            Calculation.SETFILTER("Wage Calculation Type", '%1', 0);
                            Calculation.SETFILTER("Employee No.", Employee."No.");
                            ShowMessage := FALSE;
                            IF Calculation.FINDFIRST THEN BEGIN
                                REPEAT
                                    R_DeleteWC.SETWC(Calculation, ShowMessage);
                                    R_DeleteWC.RUN;
                                UNTIL Calculation.NEXT = 0;
                                Header.Meal := TRUE;
                                Header.Taxable := TRUE;
                                //Header.Reduction:=TRUE;
                                Header.Transportation := TRUE;
                                Header.MODIFY;
                                ConfData.RESET;
                                ConfData.SETRANGE("Employee No.", Employee."No.");
                                ConfData.FINDFIRST;
                                IF ConfData."Net Amount" THEN
                                    WageAmount := ConfData."Wage Amount" * WageSetup."Coefficient Netto to Brutto" * EmplDefDim."Amount Distribution Coeff."
                                ELSE
                                    WageAmount := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";
                                CalcTemp."Wage (Base)" := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";
                                CalcTemp."Wage (Base) is Neto" := ConfData."Net Amount";
                                CalcTemp.MODIFY;
                                CalcTemp.Brutto := WageAmount;
                                NettoFromBrutto;

                                //ĐK korekcija
                                EmpCoefficient := CalcTemp."Netto Wage Base" / CalcTemp."Hour Pool";
                                CalcTemp."Employee Coefficient" := EmpCoefficient;
                                CalcTemp.Paid := TRUE;
                                CalcTemp.MODIFY;
                                WageFromHours(CalcTemp."Net Wage", EmpCoefficient, EmplDefDim."Amount Distribution Coeff.");

                                AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                //WG01
                                Bruto := 0;
                                Coef := 0;
                                AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                                AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', 'NPL-O');
                                AbsenceEmp.CALCSUMS(Quantity);
                                IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                                    CalcTemp."Unpaid Absence" := (((CalcTemp.Brutto / CalcTemp."Hour Pool")) * AbsenceEmp.Quantity);
                                    CalcTemp."Unpaid Absence Hours" := (AbsenceEmp.Quantity);
                                    COA.RESET;
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            AbsenceEmp2.RESET;
                                            AbsenceEmp2.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
                                            AbsenceEmp2.SETFILTER("Employee No.", Employee."No.");
                                            AbsenceEmp2.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            AbsenceEmp2.SETRANGE("From Date", StartDate, EndDate);
                                            AbsenceEmp2.CALCSUMS(Quantity);
                                            IF COA.Code <> 'NPL-O' THEN BEGIN
                                                Bruto += (((CalcTemp.Brutto / CalcTemp."Hour Pool") * COA.Coefficient) * AbsenceEmp2.Quantity);
                                                BBruto += (((CalcTemp.Brutto / CalcTemp."Hour Pool")) * AbsenceEmp2.Quantity);
                                                Coef += (((CalcTemp.Brutto / CalcTemp."Hour Pool") * (1 - COA.Coefficient)) * AbsenceEmp2.Quantity)
                                            END;
                                        UNTIL COA.NEXT = 0;
                                    CalcTemp."Wage (Base)" := BBruto;
                                    CalcTemp.Brutto := Bruto + (CalcTemp."Wage (Base)" * CalcTemp."Work Experience Percentage" / 100);
                                    CalcTemp."Work Experience Brutto" := (CalcTemp."Wage (Base)" * (CalcTemp."Work Experience Percentage" / 100));
                                    CalcTemp."Coeff. Difference" := Coef + CalcTemp."Work Experience Brutto";
                                    NettoFromBrutto;
                                    //   WageFromHours(CalcTemp."Net Wage",EmpCoefficient,EmplDefDim."Amount Distribution Coeff.");

                                    //  AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                    NettoFromBrutto;
                                END
                                ELSE
                                    BruttoFromNetto;
                                Coef2 := 0;
                                AbsenceEmp3.SETFILTER("Employee No.", Employee."No.");
                                AbsenceEmp3.SETFILTER("Cause of Absence Code", '%1', 'NPL-O');
                                AbsenceEmp3.CALCSUMS(Quantity);
                                IF AbsenceEmp3.Quantity = 0 THEN BEGIN
                                    COA.RESET;
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            AbsenceEmp4.RESET;
                                            AbsenceEmp4.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
                                            AbsenceEmp4.SETFILTER("Employee No.", Employee."No.");
                                            AbsenceEmp4.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            AbsenceEmp4.SETRANGE("From Date", StartDate, EndDate);
                                            AbsenceEmp4.CALCSUMS(Quantity);
                                            //  IF ((COA.Code='BOL') OR (COA.Code='BOL-42')) THEN
                                            IF (COA."Calculation Type" = COA."Calculation Type"::Sick) THEN BEGIN
                                                Coef2 += (((CalcTemp."Wage (Base)" / CalcTemp."Hour Pool") * (1 - COA.Coefficient)) * AbsenceEmp4.Quantity)
                                            END;
                                        UNTIL COA.NEXT = 0;
                                    CalcTemp."Coeff. Difference" := Coef2;
                                END;
                                //WG1
                                CalcTemp.Brutto += BruttoStimulation;
                                WageFromBrutto(TRUE, CalculateReductions, CalcTemp."Global Dimension 1 Code", CalcTemp."Global Dimension 2 Code");
                                IF WageType."Wage Calculation Type" <> 3 THEN
                                    CalcTemp.Payment := CalcTemp."Net Wage" + CalcTemp."Untaxable Wage" - CalcTemp.Tax - CalcTemp."Wage Reduction";
                                CalcTemp."Net Wage After Tax" := CalcTemp."Net Wage" - CalcTemp.Tax;
                                CalcTemp.MODIFY;
                                CalculateReductions := FALSE;
                                //END
                            END;
                        END;

                        /*        IF Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add" THEN BEGIN
                   Calculation2.SETFILTER("Wage Header No.", "No.");
                   Calculation2.SETFILTER("Employee No.",Employee."No.");
                   Calculation2.SETFILTER("No.",CalcTemp."No.");
                   IF NOT Calculation2.FINDFIRST THEN

               AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");

                          END;*/

                        //sd01 start
                        IF Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Average Amount Add" THEN BEGIN

                            Calculation.SETFILTER("Wage Header No.", '%1', "No.");
                            // Calculation.SETFILTER("No.", CalcTemp."No.");
                            Calculation.SETFILTER("Employee No.", Employee."No.");
                            ShowMessage := FALSE;
                            IF Calculation.FINDFIRST THEN BEGIN
                                REPEAT
                                // R_DeleteWC.SETWC(Calculation,ShowMessage);
                                // R_DeleteWC.RUN;
                                UNTIL Calculation.NEXT = 0;
                                Header.Meal := TRUE;
                                Header.Taxable := TRUE;
                                //Header.Reduction:=TRUE;
                                Header.Transportation := TRUE;
                                Header.MODIFY;
                                ConfData.RESET;
                                ConfData.SETRANGE("Employee No.", Employee."No.");
                                ConfData.FINDFIRST;
                                IF ConfData."Net Amount" THEN
                                    WageAmount := ConfData."Wage Amount" * WageSetup."Coefficient Netto to Brutto" * EmplDefDim."Amount Distribution Coeff."
                                ELSE
                                    WageAmount := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";
                                CalcTemp."Wage (Base)" := ConfData."Wage Amount" * EmplDefDim."Amount Distribution Coeff.";
                                CalcTemp."Wage (Base) is Neto" := ConfData."Net Amount";
                                CalcTemp.MODIFY;
                                CalcTemp.Brutto := WageAmount;
                                NettoFromBrutto;
                                ///ĐK korekcija
                                EmpCoefficient := CalcTemp."Netto Wage Base" / CalcTemp."Hour Pool";
                                CalcTemp."Employee Coefficient" := EmpCoefficient;
                                CalcTemp.MODIFY;
                                WageFromHours(CalcTemp."Net Wage", EmpCoefficient, EmplDefDim."Amount Distribution Coeff.");
                                AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                //WG01
                                Bruto := 0;
                                Coef := 0;
                                AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                                AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', 'NPL-O');
                                AbsenceEmp.CALCSUMS(Quantity);
                                IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                                    CalcTemp."Unpaid Absence" := (((CalcTemp.Brutto / CalcTemp."Hour Pool")) * AbsenceEmp.Quantity);
                                    CalcTemp."Unpaid Absence Hours" := (AbsenceEmp.Quantity);
                                    COA.RESET;
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            AbsenceEmp2.RESET;
                                            AbsenceEmp2.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
                                            AbsenceEmp2.SETFILTER("Employee No.", Employee."No.");
                                            AbsenceEmp2.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            AbsenceEmp2.SETRANGE("From Date", StartDate, EndDate);
                                            AbsenceEmp2.CALCSUMS(Quantity);
                                            IF COA.Code <> 'NPL-O' THEN BEGIN
                                                Bruto += (((CalcTemp.Brutto / CalcTemp."Hour Pool") * COA.Coefficient) * AbsenceEmp2.Quantity);
                                                BBruto += (((CalcTemp.Brutto / CalcTemp."Hour Pool")) * AbsenceEmp2.Quantity);
                                                Coef += (((CalcTemp.Brutto / CalcTemp."Hour Pool") * (1 - COA.Coefficient)) * AbsenceEmp2.Quantity)
                                            END;
                                        UNTIL COA.NEXT = 0;
                                    CalcTemp."Wage (Base)" := BBruto;
                                    CalcTemp.Brutto := Bruto + (CalcTemp."Wage (Base)" * CalcTemp."Work Experience Percentage" / 100);
                                    CalcTemp."Work Experience Brutto" := (CalcTemp."Wage (Base)" * (CalcTemp."Work Experience Percentage" / 100));
                                    CalcTemp."Coeff. Difference" := Coef + CalcTemp."Work Experience Brutto";
                                    NettoFromBrutto;
                                    //   WageFromHours(CalcTemp."Net Wage",EmpCoefficient,EmplDefDim."Amount Distribution Coeff.");

                                    //  AddNettoAdditions(EmplDefDim."Amount Distribution Coeff.");
                                    NettoFromBrutto;
                                END
                                ELSE
                                    BruttoFromNetto;
                                Coef2 := 0;
                                AbsenceEmp3.SETFILTER("Employee No.", Employee."No.");
                                AbsenceEmp3.SETFILTER("Cause of Absence Code", '%1', 'NPL-O');
                                AbsenceEmp3.CALCSUMS(Quantity);
                                IF AbsenceEmp3.Quantity = 0 THEN BEGIN
                                    COA.RESET;
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            AbsenceEmp4.RESET;
                                            AbsenceEmp4.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
                                            AbsenceEmp4.SETFILTER("Employee No.", Employee."No.");
                                            AbsenceEmp4.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            AbsenceEmp4.SETRANGE("From Date", StartDate, EndDate);
                                            AbsenceEmp4.CALCSUMS(Quantity);
                                            //  IF ((COA.Code='BOL') OR (COA.Code='BOL-42')) THEN
                                            IF (COA."Calculation Type" = COA."Calculation Type"::Sick) THEN BEGIN
                                                Coef2 += (((CalcTemp."Wage (Base)" / CalcTemp."Hour Pool") * (1 - COA.Coefficient)) * AbsenceEmp4.Quantity)
                                            END;
                                        UNTIL COA.NEXT = 0;
                                    CalcTemp."Coeff. Difference" := Coef2;
                                END;
                                //WG1
                                CalcTemp.Brutto += BruttoStimulation;
                                WageFromBrutto(TRUE, CalculateReductions, CalcTemp."Global Dimension 1 Code", CalcTemp."Global Dimension 2 Code");
                                IF WageType."Wage Calculation Type" <> 3 THEN
                                    CalcTemp.Payment := CalcTemp."Net Wage" + CalcTemp."Untaxable Wage" - CalcTemp.Tax - CalcTemp."Wage Reduction";
                                CalcTemp."Net Wage After Tax" := CalcTemp."Net Wage" - CalcTemp.Tax;
                                CalcTemp.MODIFY;
                                CalculateReductions := FALSE;
                                //END
                            END;
                        END;

                    //sd01 end

                    UNTIL CalcTemp.NEXT = 0;

            UNTIL Employee.NEXT = 0;


        Window.CLOSE;

        CalcTemp.RESET;

    end;

    var
        Orgdijelovi: Record "ORG Dijelovi";
        AbsFill: Record "Employee Absence";
        PraviousV: Decimal;
        BaseHourWageSick: Decimal;
        WWeBruto: Record "Wage Value Entry";
        AbsBruto: Record "Employee Absence";
        AbsBruto2: Record "Employee Absence";
        COABruto: Record "Cause of Absence";
        CantonAmount: Decimal;
        WagSetup: Record "Wage Setup";
        Position: Record "Position";
        ATTemp: Record "Contribution Per Employee";
        Desc: Text[250];
        ATax: Record "Contribution";
        WVE: Record "Wage Value Entry";
        TOAmountREF: Decimal;
        TOAmountISP: Decimal;
        Employee: Record "Employee";
        Absences: Record "Employee Absence";
        Cause: Record "Cause of Absence";
        Setup: Record "Wage Setup";
        Header: Record "Wage Header";
        CalcTemp: Record "Wage Calculation Temp";
        CalcTempTemp: Record "Wage Calculation Temp";
        Calculation: Record "Wage Calculation";
        AddTaxes: Record "Contribution";
        AddTaxesRS: Record "Contribution";
        AddTaxCat: Record "Contribution Category";
        ATCCon: Record "Contribution Category Conn.";
        ATCConRS: Record "Contribution Category Conn.";
        ATEmpTemp: Record "Contribution Per Employee Temp";
        Class: Record "Tax Class";
        NetWageNetto2: Decimal;
        TaxEmp: Record "Tax Per Employee";
        TaxEmpTemp: Record "Tax Per Employee Temp";
        TempTax: Record "Tax Per Employee" temporary;
        Errors: Record "Error";
        StartDate: Date;
        EndDate: Date;
        AbsenceFill: Codeunit "Absence Fill";
        SickHourWage: Decimal;
        PostCode: Record "Post Code";
        WageAmount: Decimal;
        TaxBasis: Decimal;
        EmpCountMax: Integer;
        Percent: Decimal;
        EmpCount: Integer;
        TransHeader: Record "Transport Header";
        TransLine: Record "Transport Line";
        TransLineTemp: Record "Transport Line Temp";
        MealHeader: Record "Meal Header";
        MealLine: Record "Meal Line";
        MealLineTemp: Record "Meal Line Temp";
        RecKey: Code[10];
        RedTotal: Decimal;
        WageType: Record "Wage Type";
        TempTaxDeduct: Decimal;
        SumSickFund: Decimal;
        SumInsurance: Decimal;
        SumLife: Decimal;
        SumHealth: Decimal;
        SumPension: Decimal;
        SumTransport: Decimal;
        ATEmp: Record "Contribution Per Employee";
        TempAT: Record "Contribution Per Employee" temporary;
        SUMVAT: Decimal;
        I: Integer;
        TestCause: Boolean;
        PreviousMonth: Integer;
        Txt002: Label 'Program code is not defined for wage type for employee %1!';
        Txt003: Label 'Missing work type: Sick Leave!';
        CommissionAmount: Decimal;
        PrevHeaderExists: Boolean;
        StartTempLine: Code[20];
        EndDay: Integer;
        AbCount: Integer;
        CoefficientBrutto: Decimal;
        Txt004: Label 'You did not define calculation type!';
        EmpContract: Record "Employment Contract";
        EmployeeContractType: Option Worker,Board,Supervisor,Trainee;
        Odstupanje: Decimal;
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        WA: record "Wage Addition";
        WAT: record "Wage Addition Type";
        Municipality: Record "Municipality";
        CompInfo: Record "Company Information";
        WageSetup: Record "Wage Setup";
        EmpCoefficient: Decimal;
        OldEmpCoefficient: Decimal;
        AbsenceEmp: Record "Employee Absence";
        Err03: Label 'Wage addition %1 is not defined properly';
        ReductionReal: Record "Reduction per Wage";
        RedNo: Code[10];
        AddTaxesPercentage: Decimal;
        //đK    IWA: Record "Indirect Wage Addition";
        LTEA: Record "Employee Absence";
        AbsenceEmp2: Record "Employee Absence";
        AbsenceEmp3: Record "Employee Absence";
        AbsenceEmp4: Record "Employee Absence";
        Coef2: Decimal;
        Coef: Decimal;
        BBruto: Decimal;
        Bruto: Decimal;
        ATPercentRS: Decimal;
        R_DeleteWC: Report "Delete Calculation by Employee";
        WagePrecalculation: Codeunit "Wage Precalculation";
        ShowMessage: Boolean;
        WHAdd: Record "Wage Header";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        WageCalc: Record "Wage Calculation";
        Employee1: Record "Employee";
        Department1: Record "Department";
        Txt005: Label 'BONUS';
        EmployeeContractLedger: Record "Employee Contract Ledger";
        //   SegmentationGroup: Record "Segmentation Data";
        AbsenceCT: Record "Employee Absence";
        COACT: Record "Cause of Absence";

    procedure WageFromBrutto(WithInsert: Boolean; CalculateReductions: Boolean; Dim1: Code[20]; Dim2: Code[20])
    var
        ATBasis: Decimal;
        ATPercent: Decimal;
        ATAmount: Decimal;
        ATAmountRS: Decimal;
        ATCode: Code[10];
        ATTotal: Decimal;
        ATTotalRS: Decimal;
        TaxAmount: Decimal;
        TaxBasis: Decimal;
        TaxTotal: Decimal;
        COA: Record "Cause of Absence";
        MealAQuantity: Integer;
        BaseAmountForBrutto: Decimal;
        LTDays: Decimal;
        OrgDijelovi: Record "ORG Dijelovi";
        ATempAlready: Record "Contribution Per Employee";
        ATempAlready2: Record "Contribution Per Employee";

        TaxAlready: Record "Tax Per Employee";
        TaxAlready2: Record "Tax Per Employee";

    begin

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        ATEmpTemp.RESET;

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        CalcTemp.CALCFIELDS(Incentive);
                        ATBasis := CalcTemp.Brutto;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        IF ((CalcTemp."Contribution Category Code" = 'FBIHRS2') OR (CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                            IF ATCConRS.GET('RS', AddTaxes.Code) THEN
                                ATPercentRS := ATCConRS.Percentage / 100;
                        END;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');
                        ATAmountRS := ROUND(ATBasis * ATPercentRS, 0.00001, '=');
                        IF WithInsert THEN BEGIN
                            ATEmpTemp.INIT;
                            ATEmpTemp."Employee No." := Employee."No.";
                            ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                            ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                            ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                            ATEmpTemp."Contribution Code" := AddTaxes.Code;
                            RoundIt(ATAmount);
                            ATEmpTemp."Amount From Wage" := ATAmount;
                            ATEmpTemp."Reported Amount From Wage" := ATAmountRS;
                            ATEmpTemp."Amount Over Wage" := 0;
                            ATEmpTemp."Amount Over Neto" := 0;

                            ATEmpTemp."Global Dimension 1 Code" := Dim1;
                            ATEmpTemp."Global Dimension 2 Code" := Dim2;
                            ATEmpTemp.Basis := ATBasis;
                            ATEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
                            IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                                OrgDijelovi.RESET;
                                OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                                OrgDijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                                OrgDijelovi.SETFILTER(GF, '%1', Employee.GF);
                                IF OrgDijelovi.FINDFIRST THEN
                                    ATEmpTemp."JIB Contributes" := OrgDijelovi."JIB Contributes";
                            END;
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmpTemp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                        ATTotalRS := ATTotalRS + ATAmountRS;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;

        CalcTemp."Contribution From Brutto" := ATTotal;
        IF (CalcTemp."Contribution Category Code" = 'FBIHRS2') OR (CalcTemp."Contribution Category Code" = 'BDPIORS') THEN BEGIN
            CalcTemp."Reported Amount From Brutto" := ATTotalRS;
            CalcTemp."Tax Basis (RS)" := CalcTemp.Brutto - CalcTemp."Reported Amount From Brutto";

            Class.RESET;
            Class.SETCURRENTKEY("Valid From Amount");
            Class.SETRANGE(Active, TRUE);
            Class.SETRANGE("Entity Code", CompInfo."Entity Code");
            Class.FINDFIRST;


            CalcTemp."Tax (RS)" := Class.Percentage * CalcTemp."Tax Basis (RS)";
            CalcTemp.MODIFY;
        END;




        Employee1.SETFILTER("No.", CalcTemp."Employee No.");
        IF Employee1.FINDFIRST THEN BEGIN
            CalcTemp."Municipality CIPS" := Employee1."Municipality Code CIPS";
        END;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Brutto", '%1', TRUE);
        AddTaxes.SETFILTER("Fixed Amount", '%1', FALSE);

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        ATBasis := CalcTemp.Brutto;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');
                        ATAmountRS := ROUND(ATBasis * ATPercentRS, 0.00001, '>');
                        IF WithInsert THEN BEGIN
                            ATEmpTemp.INIT;
                            ATEmpTemp."Employee No." := Employee."No.";
                            ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                            ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                            ATEmpTemp."Wage Calc No." := CalcTemp."No.";


                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                            ATEmpTemp."Contribution Code" := AddTaxes.Code;
                            ATEmpTemp."Amount From Wage" := 0;
                            RoundIt(ATAmount);
                            ATEmpTemp."Amount Over Wage" := ATAmount;
                            ATEmpTemp."Amount Over Neto" := 0;
                            IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN
                                ATEmpTemp."Amount On Wage" := 0
                            ELSE
                                ATEmpTemp."Amount On Wage" := ATAmount;
                            ATEmpTemp."Reported Amount On Wage" := ATAmountRS;
                            ATEmpTemp.Basis := ATBasis;
                            ATEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
                            IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN ATEmpTemp.Special := TRUE;
                            IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN ATEmpTemp."Special Contribution Amount" := ATAmount;
                            ;
                            // ATEmpTemp."Reported Amount On Wage":= ATAmountRS;
                            ATEmpTemp."Global Dimension 1 Code" := Dim1;
                            ATEmpTemp."Global Dimension 2 Code" := Dim2;
                            IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                                OrgDijelovi.RESET;
                                OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                                OrgDijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                                OrgDijelovi.SETFILTER(GF, '%1', Employee.GF);
                                IF OrgDijelovi.FINDFIRST THEN
                                    ATEmpTemp."JIB Contributes" := OrgDijelovi."JIB Contributes";
                            END;
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmpTemp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                        ATTotalRS := ATTotalRS + ATAmountRS;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;

        CalcTemp."Contribution Over Brutto" := ATTotal;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Brutto", '%1', TRUE);
        AddTaxes.SETFILTER("Fixed Amount", '%1', TRUE);

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN BEGIN
            IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                IF NOT ATCCon.Blocked THEN BEGIN
                    ATBasis := AddTaxes.Minimum;
                    EndDay := DATE2DMY(EndDate, 1);
                    ATBasis := ATBasis / EndDay;
                    ATPercent := ATCCon.Percentage / 100;
                    ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');

                    Absences.RESET;
                    Absences.SETFILTER("Employee No.", Employee."No.");
                    Absences.SETRANGE("From Date", StartDate, EndDate);
                    Absences.SETRANGE(Calculated, FALSE);
                    Absences.SETRANGE("RS Code", '00');
                    AbCount := Absences.COUNT;
                    ATBasis := ATBasis * AbCount;
                    ATAmount := ATAmount * AbCount;

                    IF WithInsert THEN BEGIN
                        ATEmpTemp.INIT;
                        ATEmpTemp."Employee No." := Employee."No.";
                        ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                        ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                        ATEmpTemp."Wage Calc No." := CalcTemp."No.";


                        ATempAlready.Reset();
                        ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                        ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                        if ATempAlready.FindFirst() then begin
                            ATempAlready2.Reset();
                            ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            ATempAlready2.SetCurrentKey("Wage Calc No.");
                            ATempAlready2.Ascending;
                            if ATempAlready2.FindLast() then begin
                                ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                            end;
                        end;


                        ATEmpTemp."Contribution Code" := AddTaxes.Code;
                        ATEmpTemp."Amount From Wage" := 0;
                        RoundIt(ATAmount);
                        ATEmpTemp."Amount Over Wage" := ATAmount;
                        ATEmpTemp."Amount Over Neto" := 0;
                        IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN
                            ATEmpTemp."Amount On Wage" := 0
                        ELSE
                            ATEmpTemp."Amount On Wage" := ATAmount;
                        ATEmpTemp.Basis := ATBasis;
                        ATEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
                        ATEmpTemp."Global Dimension 1 Code" := Dim1;
                        ATEmpTemp."Global Dimension 2 Code" := Dim2;
                        IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                            OrgDijelovi.RESET;
                            OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                            OrgDijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                            OrgDijelovi.SETFILTER(GF, '%1', Employee.GF);
                            IF OrgDijelovi.FINDFIRST THEN
                                ATEmpTemp."JIB Contributes" := OrgDijelovi."JIB Contributes";
                        END;
                        IF Employee."Org Entity Code" = 'RS' THEN ATEmpTemp.Special := TRUE;
                        IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN

                            CompInfo.GET;
                            ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                        END
                        ELSE BEGIN
                            ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                        END;
                        ATEmpTemp.INSERT(TRUE);
                    END;
                    ATTotal := ATTotal + ATAmount;
                    IF ATEmpTemp.Special THEN ATEmpTemp."Special Contribution Amount" += ATAmount;
                END;
            END;
        END;

        CalcTemp."Contribution Over Brutto" += ATTotal;

        CalcTemp."Earnings Deduction" += CalcTemp."Contribution From Brutto";

        AddTaxCat.GET(CalcTemp."Contribution Category Code");

        //NK
        WageCalc.SETFILTER("Employee No.", '%1', Employee."No."); //  WageCalc.SETFILTER("Employee No.",'%1',CalcTemp."Employee No.");
        WageCalc.SETFILTER("Month Of Wage", '%1', CalcTemp."Month Of Wage");
        WageCalc.SETFILTER("Year of Wage", '%1', CalcTemp."Year Of Wage");
        IF WageCalc.FIND('-') THEN
            //  WageCalc.CALCSUMS("Tax Deductions");
            //CalcTemp."Tax Deductions":=Employee."Tax Deduction Amount";
            //MESSAGE(FORMAT(Employee."No."));
            IF Employee."Tax Deduction Amount" > WageCalc."Tax Deductions" THEN
                CalcTemp."Tax Deductions" := Employee."Tax Deduction Amount" - WageCalc."Tax Deductions"
            ELSE
                CalcTemp."Tax Deductions" := 0;
        CalcTemp.MODIFY;




        IF (CalcTemp."Net Wage" <= CalcTemp."Tax Deductions") and (CalcTemp."Contribution Category Code" <> 'RS') THEN BEGIN
            CalcTemp."Tax Basis" := 0;
            CalcTemp.Tax := 0;
            CalcTemp."Contribution Per City" := 0;
            //CalcTemp."Tax Deductions":= CalcTemp."Net Wage";
        END
        ELSE

            if CalcTemp."Contribution Category Code" = 'RS' then begin

                CalcTemp."Tax Basis" := CalcTemp.Brutto - CalcTemp."Tax Deductions";
                if (CalcTemp."Brutto" <= CalcTemp."Tax Deductions") then
                    CalcTemp."Tax Basis" := 0;
            end
            else begin


                CalcTemp."Tax Basis" := CalcTemp."Net Wage" - CalcTemp."Tax Deductions";
            end;

        Class.RESET;
        Class.SETCURRENTKEY("Valid From Amount");
        Class.SETRANGE(Active, TRUE);
        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
        Class.FINDFIRST;
        TaxTotal := 0;

        REPEAT
            TaxAmount := 0;
            IF (CalcTemp."Tax Basis" <= Class."Valid To Amount") AND (CalcTemp."Tax Basis" > Class."Valid From Amount") THEN
                TaxAmount := (CalcTemp."Tax Basis" - Class."Valid From Amount") * Class.Percentage / 100 *
                           AddTaxCat."Tax Payment Percentage" / 100

            ELSE
                IF CalcTemp."Tax Basis" > Class."Valid To Amount" THEN
                    TaxAmount := (Class."Valid To Amount" - Class."Valid From Amount")
                               * Class.Percentage / 100 * AddTaxCat."Tax Payment Percentage" / 100;
            IF WithInsert THEN
                RoundIt(TaxAmount);
            TaxTotal := TaxTotal + TaxAmount;

            IF WithInsert THEN BEGIN
                TaxEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                TaxEmpTemp."Entry No." := CalcTemp."Entry No.";
                TaxEmpTemp."Wage Calculation No." := CalcTemp."No.";

                TaxAlready.Reset();
                TaxAlready.SetFilter("Wage Calculation No.", '%1', TaxEmpTemp."Wage Calculation No.");
                if ATempAlready.FindFirst() then begin
                    TaxAlready2.Reset();
                    TaxAlready2.SetCurrentKey("Wage Calculation No.");
                    TaxAlready2.Ascending;
                    if ATempAlready2.FindLast() then begin
                        TaxEmpTemp."Wage Calculation No." := IncStr(ATempAlready2."Wage Calc No.");
                    end;
                end;



                TaxEmpTemp."Tax Code" := Class.Code;
                TaxEmpTemp."Employee No." := CalcTemp."Employee No.";
                TaxEmpTemp."Contribution Category Code" := Employee."Contribution Category Code";
                TaxEmpTemp."Org Jed" := Employee."Org Jed";
                TaxEmpTemp.GF := Employee.GF;
                TaxEmpTemp.Amount := TaxAmount;
                CompInfo.GET;
                IF Employee."Entity Code CIPS" = Employee."Org Entity Code" THEN
                    TaxEmpTemp."Tax Number" := Municipality."Tax Number"
                ELSE
                    TaxEmpTemp."Tax Number" := Employee."Org Municipality";
                TaxEmpTemp."Canton Code" := Employee."County CIPS";

                IF ((Employee."Contribution Category Code" = 'FBIHRS')) THEN BEGIN
                    IF Employee."Entity Code CIPS" = 'RS' THEN
                        TaxEmpTemp."Tax Number" := Employee."Org Municipality"
                    ELSE
                        TaxEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                END;
            END;
            TaxEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
            IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                OrgDijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                OrgDijelovi.SETFILTER(GF, '%1', Employee.GF);
                IF OrgDijelovi.FINDFIRST THEN
                    TaxEmpTemp."JIB Contributes" := OrgDijelovi."JIB Contributes";
            END;
            TaxEmpTemp.INSERT;

        UNTIL Class.NEXT = 0;

        CalcTemp.Tax := TaxTotal;

        CalcTemp."Earnings Deduction" += CalcTemp.Tax;

        CalcTemp."Net Wage After Tax" := ROUND((CalcTemp.Brutto - CalcTemp."Earnings Deduction"
                                         - CalcTemp."Indirect Wage Addition Amount" - CalcTemp."Minimal Netto Wage Difference"), 0.05, '=');

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Netto", '%1', TRUE);     //Zapravo je Over Netto
        ATTotal := 0;
        ATEmpTemp.RESET;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        IF ((CalcTemp."Contribution Category Code" = 'BDPIOFBIH') OR (CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                            CalcTemp.CALCFIELDS("Regres Netto Tax Separate");
                            ATBasis := CalcTemp."Net Wage" - CalcTemp.Tax - CalcTemp."Regres Netto Tax Separate";
                        END
                        ELSE BEGIN
                            ATBasis := CalcTemp."Net Wage" - CalcTemp.Tax;
                        END;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');

                        IF WithInsert THEN BEGIN
                            ATEmpTemp.INIT;
                            ATEmpTemp."Employee No." := Employee."No.";
                            ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                            ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                            ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                            ATEmpTemp."Contribution Code" := AddTaxes.Code;
                            RoundIt(ATAmount);
                            ATEmpTemp."Amount From Wage" := 0;
                            ATEmpTemp."Amount Over Wage" := 0;
                            ATEmpTemp."Amount Over Neto" := ATAmount;
                            ATEmpTemp."Amount On Wage" := 0;
                            ATEmpTemp.Basis := ATBasis;
                            ATEmpTemp."Global Dimension 1 Code" := Dim1;
                            ATEmpTemp."Global Dimension 2 Code" := Dim2;
                            ATEmpTemp.Special := TRUE;
                            IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                                OrgDijelovi.RESET;
                                OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                                OrgDijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                                OrgDijelovi.SETFILTER(GF, '%1', Employee.GF);
                                IF OrgDijelovi.FINDFIRST THEN
                                    ATEmpTemp."JIB Contributes" := OrgDijelovi."JIB Contributes";
                            END;
                            IF ATEmpTemp.Special THEN ATEmpTemp."Special Contribution Amount" := ATAmount;
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmpTemp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;

                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;

        IF WithInsert THEN BEGIN
            IF Employee."Contribution Category Code" = 'RS' THEN BEGIN
                ATEmpTemp.INIT;
                ATEmpTemp."Employee No." := Employee."No.";
                ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                ATempAlready.Reset();
                ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                if ATempAlready.FindFirst() then begin
                    ATempAlready2.Reset();
                    ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                    ATempAlready2.SetCurrentKey("Wage Calc No.");
                    ATempAlready2.Ascending;
                    if ATempAlready2.FindLast() then begin
                        ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                    end;
                end;


                ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                ATEmpTemp."Contribution Code" := 'P-VOD';
                RoundIt(ATAmount);
                ATEmpTemp."Amount From Wage" := 0;
                ATEmpTemp."Amount Over Wage" := 0;
                ATEmpTemp."Amount Over Neto" := 1;
                ATEmpTemp."Amount On Wage" := 0;
                ATEmpTemp.Basis := 0;
                ATEmpTemp."Global Dimension 1 Code" := Dim1;
                ATEmpTemp."Global Dimension 2 Code" := Dim2;
                ATEmpTemp.Special := TRUE;
                IF ((Employee."Contribution Category Code" = 'RS')) THEN BEGIN
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Employee."Municipality Code for salary");
                    OrgDijelovi.SETFILTER(Code, '%1', Employee."Org Jed");
                    OrgDijelovi.SETFILTER(GF, '%1', Employee.GF);
                    IF OrgDijelovi.FINDFIRST THEN
                        ATEmpTemp."JIB Contributes" := OrgDijelovi."JIB Contributes";
                END;
                IF ATEmpTemp.Special THEN ATEmpTemp."Special Contribution Amount" := 1;
                IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                    CompInfo.GET;
                    ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                END
                ELSE BEGIN
                    ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                END;
                ATEmpTemp.INSERT(TRUE);
            END;
            ATTotal := ATTotal + 1;

        END;

        CalcTemp."Contribution Over Netto" := ATTotal;


        CalcTemp."Final Net Wage" :=
        CalcTemp."Net Wage After Tax" +
        CalcTemp."Untaxable Wage";

        // IF CalculateReductions THEN
        CalcReductions;

        IF WageType."Wage Calculation Type" <> 3 THEN
            CalcTemp.Payment := CalcTemp."Net Wage" + CalcTemp."Untaxable Wage" - CalcTemp.Tax - CalcTemp."Wage Reduction";

        IF WithInsert THEN BEGIN
            IF CalcTemp.Payment <> 0 THEN
                CalcTemp.MODIFY
            ELSE
                DeleteCalcTemp;
        END;
    end;

    procedure NettoFromBrutto()
    var
        ATPercent: Decimal;
    begin

        //NettoFromBrutto

        CalcTemp."Net Wage" := CalcTemp.Brutto * (1 - AddTaxesPercentage / 100);
        CalcTemp.MODIFY;
    end;

    procedure BruttoFromNetto()
    var
        ATPercent: Decimal;
    begin

        //BruttoFromNetto

        CalcTemp.Brutto := CalcTemp."Net Wage" / (1 - AddTaxesPercentage / 100);
        CalcTemp.MODIFY;
    end;

    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    begin

        Percentage := 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);

        ATEmpTemp.RESET;
        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(Employee."Contribution Category Code", AddTaxes.Code) THEN
                    IF ATCCon."Calculated in Total Brutto" THEN
                        Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;

    procedure WageFromHours(var StartAmount: Decimal; BaseHourWage: Decimal; AmtDistrCoeff: Decimal)
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        ExperienceBase: Decimal;
        SickFund: Decimal;
        SickCompany: Decimal;
        COA: Record "Cause of Absence";
        WAmounts: Record "Wage Amounts";
        COACT: Record "Cause of Absence";
        AbsenceEmpCOACT: Record "Employee Absence";
        NettoAmountTBase: Decimal;
    begin

        NettoAmount := 0;
        ExperienceBase := 0;
        SickFund := 0;
        SickCompany := 0;

        IF Employee."Contact Center" THEN BEGIN
            COACT.RESET;
            COACT.SETFILTER("Added To Hour Pool", '%1', FALSE);
            IF COACT.FINDFIRST THEN
                REPEAT
                    AbsenceEmpCOACT.SETFILTER("Employee No.", Employee."No.");
                    AbsenceEmpCOACT.SETRANGE("From Date", StartDate, EndDate);
                    AbsenceEmpCOACT.SETFILTER("Old Wage Base", '%1', FALSE);
                    AbsenceEmpCOACT.SETFILTER("Cause of Absence Code", '%1', COACT.Code);
                    AbsenceEmpCOACT.CALCSUMS(Quantity);
                    //ĐK VB     CalcTemp."Individual Hour Pool" += AbsenceEmpCOACT.Quantity;
                    CalcTemp."Individual Hour Pool" := CalcTemp."Hour Pool";
                UNTIL COACT.NEXT = 0;
            CalcTemp.MODIFY;
        END;

        COA.RESET;
        IF COA.FINDFIRST THEN
            REPEAT
                AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                AbsenceEmp.SETFILTER("Old Wage Base", '%1', FALSE);
                AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                AbsenceEmp.CALCSUMS(Quantity);
                IF NOT Employee."Contact Center" THEN
                    CalcTemp."Individual Hour Pool" += AbsenceEmp.Quantity;


                CalcTemp.MODIFY;
                WageSetup.GET;



                IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                    IF COA."Sick Leave Paid By Company" THEN BEGIN

                        if CalcTemp."Sick Leave Brutto" <> 0 then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;

                        end;



                        NettoAmount += NettoAmountT;
                        SickCompany += NettoAmountT;
                        //ĐK provjeriti   ExperienceBase += NettoAmountT;

                        //ovdje da ne ide start amount jer je to neto iznos od bruto osnovice, već od cijelog iznosa
                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountTBase;
                        // ExperienceBase += CalcTemp."Netto Wage Base" * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;
                    END;

                    IF COA."Sick Leave" AND NOT COA."Sick Leave Paid By Company" THEN BEGIN
                        /*  IF AbsenceEmp.Quantity >= WageSetup."Maximum hours for sick wage" THEN
                              NettoAmountT := WageSetup."Canton Sick-Leave Amount" * WageSetup."Maximum hours for sick wage"
                          ELSE
                              NettoAmountT := AbsenceEmp.Quantity * (WageSetup."Canton Sick-Leave Amount");

                          IF AbsenceEmp.Quantity = Header."Hour Pool" THEN
                              NettoAmountT := WageSetup."Canton Sick-Leave Amount" * Header."Hour Pool";

  */

                        /*   IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                               CalcTemp."Wage (Base)" := (WageSetup."Canton Sick-Leave Amount" * Header."Hour Pool") / (1 - AddTaxesPercentage / 100);
                               ;
                               CalcTemp.MODIFY;
                           END;*/
                        //ĐK   NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;

                        if (CalcTemp."Sick Leave Brutto" <> 0) then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end;

                        Class.RESET;
                        Class.SETCURRENTKEY("Valid From Amount");
                        Class.SETRANGE(Active, TRUE);
                        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                        Class.FINDFIRST;


                        WageSetup.Get();
                        if (WageSetup."Canton Amount" < NettoAmountT) and (CalcTemp.Canton = false) then
                            NettoAmountT := NettoAmountT - (WageSetup."Canton Amount") / ((1 - Class.Percentage / 100));
                        CantonAmount := (WageSetup."Canton Amount" / ((1 - Class.Percentage / 100))) / ((1 - AddTaxesPercentage / 100));
                        IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                            CalcTemp."Wage (Base)" := CalcTemp."Wage (Base)" - CantonAmount;
                            CalcTemp.Canton := true;
                            CalcTemp.Modify();
                        end;



                        SickFund += NettoAmountT;
                        NettoAmount += NettoAmountT;
                        //ĐK VB   ExperienceBase += NettoAmountT;
                        IF COA."Calculate Experience" THEN

                            //ĐK ExperienceBase += NettoAmountT;
                            //  ExperienceBase += CalcTemp."Netto Wage Base" * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;
                            ExperienceBase += NettoAmountTBase;
                    END;

                    // IF CalcTemp."Employee No."='1' THEN MESSAGE(COA.Code);
                    IF NOT (COA."Sick Leave" OR COA."Sick Leave Paid By Company" OR COA."Added To Hour Pool") THEN BEGIN
                        //ĐK  NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        if (CalcTemp."Sick Leave Brutto" <> 0) and (COA."Sick Leave" = true) then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            if COA."Calculate Experience" = true then
                                NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff
                            else
                                NettoAmountTBase := AbsenceEmp.Quantity * 0 * BaseHourWage * AmtDistrCoeff

                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            if COA."Calculate Experience" = true then
                                NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff
                            else
                                NettoAmountTBase := AbsenceEmp.Quantity * 0 * BaseHourWage * AmtDistrCoeff
                        end;


                        //bt01
                        // MESSAGE((FORMAT(AbsenceEmp.Quantity)));
                        //MESSAGE((FORMAT(COA.Coefficient)));
                        //MESSAGE((FORMAT(BaseHourWage)));
                        // MESSAGE((FORMAT(AmtDistrCoeff)));

                        NettoAmount += NettoAmountT;
                        IF COA."Calculate Experience" THEN
                            //ĐK   ExperienceBase += NettoAmountT;
                            ExperienceBase += NettoAmountTBase;
                        //+= CalcTemp."Netto Wage Base" * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;

                    END;



                    IF COA."Added To Hour Pool" THEN BEGIN
                        NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        NettoAmount += NettoAmountT;
                        //ĐK VB  ExperienceBase += NettoAmountT;

                    END;
                END;
            UNTIL COA.NEXT = 0;


        //NE sada probaj ExperienceBase := (CalcTemp."Wage Base" * CalcTemp."Position Coefficient for Wage") * (1 - AddTaxesPercentage / 100);

        CalcTemp."Net Wage (Calculated Base)" := NettoAmount;
        CalcTemp."Work Experience (Base)" := ExperienceBase;

        NettoAmount += ExperienceBase * (Employee."Work Experience Percentage" / 100);
        CalcTemp."Experience Total" += ExperienceBase * (Employee."Work Experience Percentage" / 100);

        //Ne sada probaj CalcTemp."Experience Total" := (CalcTemp."Wage Base" * CalcTemp."Work Experience Percentage" * CalcTemp."Position Coefficient for Wage" / 100) * (1 - AddTaxesPercentage / 100);


        /*
        IF CalcTemp."Department Code"<>'D.2.3.' THEN
        CalcTemp."Work Experience (Base)" := ExperienceBase
        ELSE
        CalcTemp."Work Experience (Base)" := CalcTemp."Wage (Base)";
        IF CalcTemp."Department Code"<>'D.2.3.' THEN
         NettoAmount+=ExperienceBase*(Employee."Work Experience Percentage"/100)
        ELSE
          NettoAmount+=CalcTemp."Wage (Base)"*(Employee."Work Experience Percentage"/100)* (1-AddTaxesPercentage/100);
         IF CalcTemp."Department Code"<>'D.2.3.' THEN
        CalcTemp."Experience Total"+=ExperienceBase*(Employee."Work Experience Percentage"/100)
         ELSE
        CalcTemp."Experience Total"+=CalcTemp."Wage (Base)"*(Employee."Work Experience Percentage"/100)* (1-AddTaxesPercentage/100);
        */

        CalcTemp."Sick Leave-Company" += SickCompany;
        CalcTemp."Sick Fund Total" += SickFund;
        CalcTemp.MODIFY;


        CalcTemp."Net Wage" := NettoAmount;
        IF CalcTemp."Contribution Category Code" = 'RS' THEN
            CalcTemp."Tax Basis" := CalcTemp.Brutto
        ELSE
            CalcTemp."Tax Basis" := NettoAmount;
        RoundIt(CalcTemp."Net Wage");
        CalcTemp.MODIFY;

    end;

    procedure WageFromHoursNetto2(var StartAmount: Decimal; BaseHourWage: Decimal; AmtDistrCoeff: Decimal; PaidHourd: Decimal)
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        ExperienceBase: Decimal;
        SickFund: Decimal;
        SickCompany: Decimal;
        COA: Record "Cause of Absence";
        WAmounts: Record "Wage Amounts";
        COACT: Record "Cause of Absence";
        AbsenceEmpCOACT: Record "Employee Absence";
        NettoAmountTBase: Decimal;
    begin

        NettoAmount := 0;
        ExperienceBase := 0;
        SickFund := 0;
        SickCompany := 0;

        IF Employee."Contact Center" THEN BEGIN
            COACT.RESET;
            COACT.SETFILTER("Added To Hour Pool", '%1', FALSE);
            IF COACT.FINDFIRST THEN
                REPEAT
                    AbsenceEmpCOACT.SETFILTER("Employee No.", Employee."No.");
                    AbsenceEmpCOACT.SETRANGE("From Date", StartDate, EndDate);
                    AbsenceEmpCOACT.SETFILTER("Old Wage Base", '%1', FALSE);
                    AbsenceEmpCOACT.SETFILTER("Cause of Absence Code", '%1', COACT.Code);
                    AbsenceEmpCOACT.CALCSUMS(Quantity);
                    //ĐK VB     CalcTemp."Individual Hour Pool" += AbsenceEmpCOACT.Quantity;
                    CalcTemp."Individual Hour Pool" := CalcTemp."Hour Pool";
                UNTIL COACT.NEXT = 0;
            CalcTemp.MODIFY;
        END;

        COA.RESET;
        IF COA.FINDFIRST THEN
            REPEAT
                AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                AbsenceEmp.SETFILTER("Old Wage Base", '%1', FALSE);
                AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                AbsenceEmp.CALCSUMS(Quantity);
                IF NOT Employee."Contact Center" THEN
                    CalcTemp."Individual Hour Pool" += AbsenceEmp.Quantity;


                CalcTemp.MODIFY;
                WageSetup.GET;



                IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                    IF COA."Sick Leave Paid By Company" THEN BEGIN

                        /*
    (1 - AddTaxesPercentage / 100)
                        */

                        if CalcTemp."Sick Leave Brutto" <> 0 then begin
                            BaseHourWageSick := ((CalcTemp."Sick Leave Brutto") / PaidHourd) / ((1) / (1 - AddTaxesPercentage / 100));
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * (BaseHourWage) * AmtDistrCoeff;
                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * (BaseHourWage) * AmtDistrCoeff;

                        end;



                        NettoAmount += NettoAmountT;
                        SickCompany += NettoAmountT;
                        //ĐK provjeriti   ExperienceBase += NettoAmountT;

                        //ovdje da ne ide start amount jer je to neto iznos od bruto osnovice, već od cijelog iznosa
                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountTBase;
                        // ExperienceBase += CalcTemp."Netto Wage Base" * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;
                    END;

                    IF COA."Sick Leave" AND NOT COA."Sick Leave Paid By Company" THEN BEGIN
                        /*  IF AbsenceEmp.Quantity >= WageSetup."Maximum hours for sick wage" THEN
                              NettoAmountT := WageSetup."Canton Sick-Leave Amount" * WageSetup."Maximum hours for sick wage"
                          ELSE
                              NettoAmountT := AbsenceEmp.Quantity * (WageSetup."Canton Sick-Leave Amount");

                          IF AbsenceEmp.Quantity = Header."Hour Pool" THEN
                              NettoAmountT := WageSetup."Canton Sick-Leave Amount" * Header."Hour Pool";

  */

                        /*   IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                               CalcTemp."Wage (Base)" := (WageSetup."Canton Sick-Leave Amount" * Header."Hour Pool") / (1 - AddTaxesPercentage / 100);
                               ;
                               CalcTemp.MODIFY;
                           END;*/
                        //ĐK   NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;

                        if (CalcTemp."Sick Leave Brutto" <> 0) then begin
                            BaseHourWageSick := ((CalcTemp."Sick Leave Brutto") / PaidHourd) / ((1) / (1 - AddTaxesPercentage / 100));
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end;

                        Class.RESET;
                        Class.SETCURRENTKEY("Valid From Amount");
                        Class.SETRANGE(Active, TRUE);
                        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                        Class.FINDFIRST;


                        WageSetup.Get();
                        if (WageSetup."Canton Amount" < NettoAmountT) and (CalcTemp.Canton = false) then
                            NettoAmountT := NettoAmountT - (WageSetup."Canton Amount") / ((1 - Class.Percentage / 100));
                        CantonAmount := (WageSetup."Canton Amount" / ((1 - Class.Percentage / 100))) / ((1 - AddTaxesPercentage / 100));
                        IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                            CalcTemp."Wage (Base)" := CalcTemp."Wage (Base)" - CantonAmount;
                            CalcTemp.Canton := true;
                            CalcTemp.Modify();
                        end;



                        SickFund += NettoAmountT;
                        NettoAmount += NettoAmountT;
                        //ĐK VB   ExperienceBase += NettoAmountT;
                        IF COA."Calculate Experience" THEN

                            //ĐK ExperienceBase += NettoAmountT;
                            //  ExperienceBase += CalcTemp."Netto Wage Base" * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;
                            ExperienceBase += NettoAmountTBase;
                    END;

                    // IF CalcTemp."Employee No."='1' THEN MESSAGE(COA.Code);
                    IF NOT (COA."Sick Leave" OR COA."Sick Leave Paid By Company" OR COA."Added To Hour Pool") THEN BEGIN
                        //ĐK  NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        if (CalcTemp."Sick Leave Brutto" <> 0) and (COA."Sick Leave" = true) then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / PaidHourd) / (1 / (1 - AddTaxesPercentage / 100));
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            if COA."Calculate Experience" = true then
                                NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff
                            else
                                NettoAmountTBase := AbsenceEmp.Quantity * 0 * BaseHourWage * AmtDistrCoeff

                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            if COA."Calculate Experience" = true then
                                NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff
                            else
                                NettoAmountTBase := AbsenceEmp.Quantity * 0 * BaseHourWage * AmtDistrCoeff
                        end;


                        //bt01
                        // MESSAGE((FORMAT(AbsenceEmp.Quantity)));
                        //MESSAGE((FORMAT(COA.Coefficient)));
                        //MESSAGE((FORMAT(BaseHourWage)));
                        // MESSAGE((FORMAT(AmtDistrCoeff)));

                        NettoAmount += NettoAmountT;
                        IF COA."Calculate Experience" THEN
                            //ĐK   ExperienceBase += NettoAmountT;
                            ExperienceBase += NettoAmountTBase;
                        //+= CalcTemp."Netto Wage Base" * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;

                    END;



                    IF COA."Added To Hour Pool" THEN BEGIN
                        NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        NettoAmount += NettoAmountT;
                        //ĐK VB  ExperienceBase += NettoAmountT;

                    END;
                END;
            UNTIL COA.NEXT = 0;
        //NE sada probaj ExperienceBase := (CalcTemp."Wage Base" * CalcTemp."Position Coefficient for Wage") * (1 - AddTaxesPercentage / 100);

        //ExperienceBase := ExperienceBase / (1 / (1 - AddTaxesPercentage / 100));
        CalcTemp."Net Wage (Calculated Base)" := NettoAmount;
        CalcTemp."Work Experience (Base)" := ExperienceBase;

        NettoAmount += ExperienceBase * (Employee."Work Experience Percentage" / 100);
        CalcTemp."Experience Total" += ExperienceBase * (Employee."Work Experience Percentage" / 100);

        //Ne sada probaj CalcTemp."Experience Total" := (CalcTemp."Wage Base" * CalcTemp."Work Experience Percentage" * CalcTemp."Position Coefficient for Wage" / 100) * (1 - AddTaxesPercentage / 100);


        /*
        IF CalcTemp."Department Code"<>'D.2.3.' THEN
        CalcTemp."Work Experience (Base)" := ExperienceBase
        ELSE
        CalcTemp."Work Experience (Base)" := CalcTemp."Wage (Base)";
        IF CalcTemp."Department Code"<>'D.2.3.' THEN
         NettoAmount+=ExperienceBase*(Employee."Work Experience Percentage"/100)
        ELSE
          NettoAmount+=CalcTemp."Wage (Base)"*(Employee."Work Experience Percentage"/100)* (1-AddTaxesPercentage/100);
         IF CalcTemp."Department Code"<>'D.2.3.' THEN
        CalcTemp."Experience Total"+=ExperienceBase*(Employee."Work Experience Percentage"/100)
         ELSE
        CalcTemp."Experience Total"+=CalcTemp."Wage (Base)"*(Employee."Work Experience Percentage"/100)* (1-AddTaxesPercentage/100);
        */

        CalcTemp."Sick Leave-Company" += SickCompany;
        CalcTemp."Sick Fund Total" += SickFund;
        CalcTemp.MODIFY;


        CalcTemp."Net Wage" := NettoAmount;
        IF CalcTemp."Contribution Category Code" = 'RS' THEN
            CalcTemp."Tax Basis" := CalcTemp.Brutto
        ELSE
            CalcTemp."Tax Basis" := NettoAmount;
        RoundIt(CalcTemp."Net Wage");
        CalcTemp.MODIFY;

    end;

    procedure AddNettoAdditions(Coeff: Decimal)
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        NettoBase: Decimal;
        ExperienceBase: Decimal;
        ExperienceBaseT: Decimal;
        WageAddition: Decimal;
        UntaxableWage: Decimal;
        BruttoBasis: Decimal;
        NetWage: Decimal;
        ConCat: Record "Contribution Category";
        UseAddition: Decimal;
    begin
        WA.RESET;
        WA.SETRANGE("Month of Wage", Header."Month Of Wage");
        WA.SETRANGE("Year of Wage", Header."Year Of Wage");

        WA.SETRANGE("Employee No.", Employee."No.");
        WA.SETRANGE(Locked, FALSE);
        WA.SETRANGE(Calculated, FALSE);
        WA.SETFILTER(Amount, '<>0');

        NettoAmount := 0;
        ExperienceBase := 0;
        UseAddition := 0;
        IF WA.FINDFIRST THEN
            REPEAT
                WAT.GET(WA."Wage Addition Type");

                NettoAmountT := 0;
                NettoBase := 0;
                ExperienceBaseT := 0;

                IF ((WAT."Calculation Type" = WAT."Calculation Type"::Fixed) OR ((WAT."Calculation Type" = WAT."Calculation Type"::Percentage) AND
                  (WAT."Calculated on Brutto"))) THEN BEGIN

                    NettoAmountT := WA.Amount;
                    IF WAT."Calculate Experience" THEN
                        ExperienceBaseT := WA.Amount;
                END;

                IF ((WAT."Calculation Type" = WAT."Calculation Type"::Percentage) AND NOT (WAT."Calculated on Brutto")) THEN BEGIN
                    /* IF (WAT."Calculated on Neto (Calc.)" AND WAT."Calculated on Neto (Base)")
                        OR
                        (NOT WAT."Calculated on Neto (Calc.)" AND NOT WAT."Calculated on Neto (Base)")
                        THEN ERROR(Err03,WAT.Code);*/
                    IF WAT."Calculated on Neto (Calc.)" THEN BEGIN
                        //CalcNettoBaseForAddition(Employee."No.",Header."Year Of Wage",Header."Month Of Wage",NettoBase);
                        NettoBase := CalcTemp."Net Wage"
                    END;

                    IF WAT."Calculated on Neto (Base)" THEN BEGIN
                        IF CalcTemp."Wage (Base) is Neto" THEN
                            NettoBase := CalcTemp."Wage (Base)"
                        ELSE
                            NettoBase := CalcTemp."Wage (Base)" * (1 - AddTaxesPercentage / 100);
                    END;
                    //NKWG

                    NettoAmountT := NettoBase * WA."Amount to Pay" / 100;
                    IF WAT."Calculate Experience" THEN
                        ExperienceBaseT += NettoAmountT;
                END;
                WA."Calculated Amount" := NettoAmountT;
                //WA."Calculated Amount" += NettoAmountT;
                WA."Wage Header No." := Header."No.";
                WA."Wage Header Entry No." := Header."Entry No.";
                WA.Taxable := WAT.Taxable;
                //WG01
                IF WA.Taxable THEN BEGIN
                    IF Employee."Contribution Category Code" = 'FBIHRS'
                      THEN
                        ConCat.SETFILTER(Code, '%1', 'FBIH')
                    ELSE
                        ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                    IF ConCat.FINDFIRST THEN BEGIN
                        ConCat.CALCFIELDS("From Brutto");
                        ConCat.CALCFIELDS("From Brutto(RS)");
                        /*  IF Employee."Contribution Category Code"='BDPIORS' THEN
                            WA."Calculated Amount Brutto":=(WA."Amount to Pay")/((1-ConCat."From Brutto(RS)"/100))
                          ELSE*/
                        WA."Calculated Amount Brutto" := (WA.Amount) / ((1 - ConCat."From Brutto" / 100));
                        //NK BD WA."Calculated Amount Brutto":=(WA.Amount)/((1-ConCat."From Brutto"/100));
                        //WA."Amount to Pay":=(WA."Calculated Amount Brutto")-(WA."Calculated Amount Brutto"*(ConCat."From Brutto"/100));
                    END;
                    CalcTemp."Wage Addition Brutto" += WA."Calculated Amount Brutto";
                    //CalcTemp."Wage Addition Netto":=WA."Amount to Pay";
                    CalcTemp.MODIFY;
                END;
                //WG01
                WA."Wage Calculation Entry No." := CalcTemp."No.";
                WA.Locked := TRUE;
                WA."Closing Date" := Header."Date Of Calculation";
                WA.MODIFY;
                NettoAmountT += ExperienceBaseT * (Employee."Work Experience Percentage" / 100);



                /*IF WAT."Add. Taxable" THEN BEGIN
                 NettoAmount += NettoAmountT;
                 ExperienceBase += ExperienceBaseT;
                END
                ELSE BEGIN
                 WageAddition += NettoAmountT;
                END;*/

                IF Header.Taxable THEN BEGIN
                    IF WAT.Taxable THEN BEGIN
                        TaxBasis += NettoAmountT;
                        NettoAmount += NettoAmountT;
                        ExperienceBase += ExperienceBaseT;
                    END
                    ELSE BEGIN
                        UntaxableWage += NettoAmountT;
                        WageAddition += NettoAmountT;
                    END;
                END
                ELSE BEGIN
                    UntaxableWage += NettoAmountT;
                    WageAddition += NettoAmountT;
                END;
            UNTIL WA.NEXT = 0;

        /*ĐK         IWA.RESET;
                IWA.SETRANGE("Month of Wage", Header."Month Of Wage");
                IWA.SETRANGE("Year of Wage", Header."Year Of Wage");

                IWA.SETRANGE("Employee No.", Employee."No.");
                IWA.SETRANGE(Locked, FALSE);
                IWA.SETFILTER(Amount, '<>0');

                CalcTemp."Indirect Wage Addition Amount" := 0;
                IF (CompInfo."Entity Code" = 'FBIH') THEN
                    IF IWA.FINDFIRST THEN
                        REPEAT
                            CalcTemp."Indirect Wage Addition Amount" += IWA.Amount;
                        UNTIL IWA.NEXT = 0; kraj*/

        TransLineTemp.INIT;
        TransLineTemp.Amount := 0;
        IF Header.Transportation THEN BEGIN
            TransLineTemp.RESET;
            TransLineTemp.SETFILTER("Document No.", TransHeader."No.");
            TransLineTemp.SETFILTER("Employee No.", Employee."No.");
            IF TransLineTemp.FINDFIRST THEN
                IF (TransLineTemp."Netto Before Tax" = 0) THEN
                    CalcTemp.Transport := TransLineTemp.Amount * Coeff
                ELSE BEGIN
                    CalcTemp.Transport := TransLineTemp.Amount * Coeff;
                    CalcTemp."Taxable Transport" := TransLineTemp.Amount * Coeff;
                    CalcTemp."Brutto Transport" := TransLineTemp."Brutto Amount" * Coeff;

                END;
        END;

        MealLineTemp.INIT;
        MealLineTemp.Amount := 0;

        IF Header.Meal THEN BEGIN
            MealLineTemp.RESET;
            MealLineTemp.SETFILTER("Document No.", MealHeader."No.");
            MealLineTemp.SETFILTER("Employee No.", Employee."No.");
            IF MealLineTemp.FINDFIRST THEN
                IF (MealLineTemp."Netto Before Tax" = 0) THEN
                    CalcTemp."Meal to pay" := MealLineTemp.Amount * Coeff
                ELSE BEGIN
                    CalcTemp."Meal to pay" := MealLineTemp.Amount * Coeff;
                    //CalcTemp."Taxable Meal":= MealLineTemp."Netto Before Tax" * Coeff;
                    CalcTemp."Taxable Meal" := MealLineTemp.Amount * Coeff;
                    CalcTemp."Brutto Meal" := MealLineTemp."Brutto Amount" * Coeff;

                END;
        END;


        IF Header.Taxable THEN BEGIN
            /*BD01 IF ((Employee."Contribution Category Code" = 'BDPIOFBIH') OR (Employee."Contribution Category Code" = 'BDPIORS')
            OR (Employee."Contribution Category Code" = 'RS') ) THEN BEGIN*/
            IF (Employee."Contribution Category Code" = 'RS') THEN BEGIN
                // NettoAmount +=MealLineTemp."Netto Before Tax"+TransLineTemp."Netto Before Tax";
                // NettoAmount +=MealLineTemp.Amount+TransLineTemp.Amount;
                NettoAmount += MealLineTemp.Amount;
                // TaxBasis+=MealLineTemp."Netto Before Tax"+TransLineTemp."Netto Before Tax";
                // TaxBasis+=MealLineTemp.Amount+TransLineTemp.Amount;
                TaxBasis += MealLineTemp.Amount;
                //  UntaxableWage += TransLineTemp.Amount;
            END
            ELSE BEGIN
                UntaxableWage += TransLineTemp.Amount + MealLineTemp.Amount;
                NettoAmount += CalcTemp."Indirect Wage Addition Amount";
                TaxBasis += CalcTemp."Indirect Wage Addition Amount";

            END;
        END
        ELSE
            UntaxableWage += TransLineTemp.Amount + MealLineTemp.Amount;

        CalcTemp."Wage Addition" += WageAddition;
        CalcTemp."Net Wage" += NettoAmount;
        //M
        //đK NE ExperienceBase := CalcTemp."Wage Base" * CalcTemp."Position Coefficient for Wage" * (1 - AddTaxesPercentage / 100);
        CalcTemp."Work Experience (Base)" += ExperienceBase;
        CalcTemp."Net Wage (Calculated Base)" += ExperienceBase;
        CalcTemp."Experience Total" += ExperienceBase * (Employee."Work Experience Percentage" / 100);
        //ne sada  CalcTemp."Experience Total" := (CalcTemp."Wage Base" * CalcTemp."Work Experience Percentage" * CalcTemp."Position Coefficient for Wage" / 100) * (1 - AddTaxesPercentage / 100);
        ;

        IF Header."Wage Calculation Type" = Header."Wage Calculation Type"::Normal THEN
            CalcTemp."Untaxable Wage" += UntaxableWage * Coeff;
        CalcTemp."Tax Basis" += TaxBasis;

        RoundIt(CalcTemp."Net Wage");
        RoundIt(CalcTemp."Work Experience (Base)");
        RoundIt(CalcTemp."Experience Total");
        RoundIt(CalcTemp."Wage Addition");
        RoundIt(CalcTemp."Net Wage (Calculated Base)");
        RoundIt(CalcTemp."Tax Basis");
        RoundIt(CalcTemp."Untaxable Wage");
        CalcTemp.MODIFY;

    end;

    procedure RoundIt(var Input: Decimal)
    begin
        //Input:=ROUND(Input,0.00001,'=');
    end;

    procedure DeleteCalcTemp()
    var
        CheckCOA: Record "Cause of Absence";
        CheckEA: Record "Employee Absence";
    begin
        CheckCOA.RESET;
        CheckEA.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date", "To Date");
        CheckEA.SETRANGE("Employee No.", CalcTemp."Employee No.");
        CheckEA.SETRANGE("From Date", StartDate, EndDate);
        IF CheckCOA.FINDFIRST THEN
            REPEAT
                CheckEA.SETRANGE("Cause of Absence Code", CheckCOA.Code);
                IF CheckEA.FINDFIRST THEN
                    REPEAT
                        IF CheckEA.Quantity > 0 THEN EXIT;
                    UNTIL CheckEA.NEXT = 0;
            UNTIL CheckCOA.NEXT = 0;


        ATEmpTemp.RESET;
        ATEmpTemp.SETFILTER("Wage Calc No.", CalcTemp."No.");

        IF NOT ATEmpTemp.ISEMPTY THEN
            ATEmpTemp.DELETEALL;

        TaxEmpTemp.RESET;
        TaxEmpTemp.SETFILTER("Wage Calculation No.", CalcTemp."No.");
        IF NOT TaxEmpTemp.ISEMPTY THEN
            TaxEmpTemp.DELETEALL;

        CalcTemp.DELETE;
    end;

    procedure DeleteTemps()
    begin
        IF NOT ATEmpTemp.ISEMPTY THEN
            ATEmpTemp.DELETEALL(TRUE);
        IF NOT TaxEmpTemp.ISEMPTY THEN
            TaxEmpTemp.DELETEALL(TRUE);
    end;

    procedure CheckCoefficient(PC: Text[10]; CEO: Boolean; Coeff: Decimal; WithMessage: Boolean) CCReturn: Boolean
    var
        CCRangesValues: array[12, 12] of Decimal;
        CCRangesTypes: array[12] of Text[10];
        i: Integer;
        flag: Boolean;
        TT001: Label 'Koeficijent mora biti od %1 do %2 za tip radnika: %3';
    begin
        Odstupanje := 0;

        CCRangesTypes[1] := 'NK';
        CCRangesTypes[2] := 'PK';
        CCRangesTypes[3] := 'KV';
        CCRangesTypes[4] := 'SSS';
        CCRangesTypes[5] := 'VK';
        CCRangesTypes[6] := 'VS';
        CCRangesTypes[7] := 'VSS';
        CCRangesTypes[8] := 'VSS-D';

        CCRangesValues[1, 1] := 1.0;
        CCRangesValues[1, 2] := 2.4;

        CCRangesValues[2, 1] := 1.0;
        CCRangesValues[2, 2] := 2.4;

        CCRangesValues[3, 1] := 2.4;
        CCRangesValues[3, 2] := 3.1;

        CCRangesValues[4, 1] := 2.4;
        CCRangesValues[4, 2] := 3.1;

        CCRangesValues[5, 1] := 3.1;
        CCRangesValues[5, 2] := 3.8;

        CCRangesValues[6, 1] := 3.1;
        CCRangesValues[6, 2] := 3.8;

        CCRangesValues[7, 1] := 3.8;
        CCRangesValues[7, 2] := 5.0;

        CCRangesValues[8, 1] := 6;
        CCRangesValues[8, 2] := 6;

        CCReturn := FALSE;

        flag := FALSE;
        i := 0;
        IF CEO THEN PC += '-D';


        REPEAT
            i += 1;
            IF CCRangesTypes[i] = PC THEN BEGIN
                IF (CCRangesValues[i, 1] <= Coeff) AND
                   (CCRangesValues[i, 2] >= Coeff) THEN BEGIN
                    CCReturn := TRUE;
                    EXIT;
                END
                ELSE BEGIN
                    IF WithMessage THEN
                        MESSAGE(TT001, CCRangesValues[i, 1], CCRangesValues[i, 2], CCRangesTypes[i]);
                    IF (CCRangesValues[i, 1] >= Coeff) THEN
                        Odstupanje := Coeff - CCRangesValues[i, 1]
                    ELSE
                        Odstupanje := Coeff - CCRangesValues[i, 2];
                    EXIT;
                END;
            END;
        UNTIL (i = ARRAYLEN(CCRangesTypes));
    end;

    procedure GetOdstupanje() Odst: Decimal
    begin
        EXIT(Odstupanje);
    end;

    procedure CalcTaxes()
    var
        TaxMax: array[20] of Decimal;
        IMax: Integer;
        CID: array[20] of Code[10];
        TaxActual: Decimal;
        IX: Integer;
        ATTemp: Decimal;
        "Min": array[20] of Decimal;
        "Max": array[20] of Decimal;
        Percent: array[20] of Decimal;
        IDMin: Integer;
        IDMax: Integer;
        ATCode: array[20] of Code[10];
        EarnMin: Decimal;
        EarnMax: Decimal;
        NulAT: array[20] of Decimal;
        MinAT: array[20] of Decimal;
        MaxAT: array[20] of Decimal;
        NetMax: array[20] of Decimal;
        Earnings: Decimal;
        ATMin: Record "Contribution";
        ATMax: Record "Contribution";
        I: Integer;
        J: Integer;
        IDXMin: Integer;
        IDXMax: Integer;
        TaxLast: Decimal;
        CurrPercent: Decimal;
        AmountDeducted: Decimal;
        CityTax: Decimal;
        Min1: Decimal;
        Max1: Decimal;
        Percent1: Decimal;
        SCityTax: Decimal;
        RSHighCityTax: Decimal;
        TaxAmount: Decimal;
        TaxAmountBase: Decimal;
        TaxAmountBasePerType: Decimal;
        WH: Record "Wage Header";
        TaxTotal: Decimal;
    begin
        IF NOT Header.Taxable THEN EXIT;
        CalcTemp.RESET;
        CalcTemp.SETFILTER(CalcTemp."Wage Header No.", Header."No.");
        CalcTemp.SETRANGE(CalcTemp."Entry No.", Header."Entry No.");
        CompInfo.GET;

        Employee.SETRANGE(Employee."For Calculation", TRUE);
        IF Employee.FINDFIRST THEN
            REPEAT

                /*IF EmpContract.GET(Employee."Emplymt. Contract Code") THEN
                 EmployeeContractType:=EmpContract."Calculation Type"
                ELSE*/
                EmployeeContractType := EmployeeContractType::Worker;

                PostCode.GET(Employee."Post Code CIPS", Employee."City CIPS");
            UNTIL Employee.NEXT = 0;

    end;

    procedure CalcNettoBaseForAddition(EmployeeNo: Code[10]; yOfWage: Integer; mOfWage: Integer; var NettoBase: Decimal)
    var
        COATemp: Record "Cause of Absence";
        EATemp: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        sDate: Date;
        eDate: Date;
    begin
        WageSetup.GET;
        sDate := DMY2DATE(1, mOfWage, yOfWage);
        eDate := CALCDATE('<-1D>', CALCDATE('<+1M>', sDate));
        NettoBase := 0;
        EATemp.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date");
        EATemp.SETFILTER("Employee No.", EmployeeNo);
        EATemp.SETRANGE("From Date", sDate, eDate);
        EATemp.SETRANGE("Cause of Absence Code", WageSetup."Workday Code");
        EATemp.CALCSUMS(Quantity);
        IF EATemp.Quantity <> 0 THEN BEGIN
            NettoBase := EATemp.Quantity * EmpCoefficient;
        END;
    end;

    procedure CalcReductions()
    var
        Reductions: Record "Reduction";
        RedTotal: Decimal;
        RedTemp: Record "Reduction per Wage Temp";
        ReductionTemp: Record "Reduction per Wage Temp";
        RedType: Record "Reduction types";
        TotalWageForRed: Decimal;
    begin
        IF Header.Reduction THEN BEGIN

            Reductions.SETFILTER("Employee No.", Employee."No.");
            Reductions.SETFILTER(Status, '%1', 1);
            IF Reductions.FINDFIRST THEN
                REPEAT
                    Reductions.CALCFIELDS("Paid Amount", "No. of Installments paid");

                    TotalWageForRed := 0;
                    ReductionTemp.INIT;
                    RedNo := INCSTR(RedNo);
                    ReductionTemp."No." := RedNo;
                    ReductionTemp."Reduction No." := Reductions."No.";
                    ReductionTemp."Wage Header No." := Header."No.";
                    ReductionTemp."Wage Header Entry No." := Header."Entry No.";
                    ReductionTemp."Employee No." := Employee."No.";
                    ReductionTemp.Type := Reductions.Type;
                    ReductionTemp.SGC := Employee."Statistics Group Code";
                    ReductionTemp."Reduction Name" := Reductions.Description;
                    ReductionTemp."Bank Account No." := Reductions.BankAccountCodeNo;

                    IF RedType.GET(Reductions.Type) THEN BEGIN
                        IF RedType.AmountIsPercentage THEN BEGIN
                            //ako je procenat
                            CalcTemp.CALCFIELDS("Reduction Netto");

                            TotalWageForRed := CalcTemp."Net Wage After Tax";

                            ReductionTemp.Amount := Reductions."Installment Amount" * TotalWageForRed / 100;

                            IF NOT RedType.AmountWithoutLimit THEN
                                IF (Reductions."No. of Installments paid" + 1) = Reductions."No. of Installments" THEN
                                    ReductionTemp.Amount := Reductions."Reduction Amount" - Reductions."Paid Amount";
                        END
                        ELSE BEGIN

                            if ((Reductions."Installment Amount" + Reductions."Opening balance" + Reductions."Paid Amount") - (Reductions."Reduction Amount") >= -1)
                            and ((Reductions."Installment Amount" + Reductions."Opening balance" + Reductions."Paid Amount") - (Reductions."Reduction Amount") <= 1)
                            then
                                ReductionTemp.Amount := Reductions."Reduction Amount" - Reductions."Opening balance" - Reductions."Paid Amount"
                            else
                                ReductionTemp.Amount := Reductions."Installment Amount";

                            IF NOT RedType.AmountWithoutLimit THEN BEGIN
                                IF (Reductions."No. of Installments paid" + 1) = Reductions."No. of Installments" THEN
                                    ReductionTemp.Amount := Reductions."Reduction Amount" - Reductions."Paid Amount"
                                ELSE
                                    IF ((Reductions."Reduction Amount" - Reductions."Paid Amount") < Reductions."Installment Amount") THEN
                                        ReductionTemp.Amount := (Reductions."Reduction Amount" - Reductions."Paid Amount");
                            END;
                        END;
                    END
                    ELSE BEGIN
                        ReductionTemp.Amount := Reductions."Installment Amount";
                        IF NOT RedType.AmountWithoutLimit THEN BEGIN
                            IF (Reductions."No. of Installments paid" + 1) = Reductions."No. of Installments" THEN
                                ReductionTemp.Amount := Reductions."Reduction Amount" - Reductions."Paid Amount"
                            ELSE
                                IF ((Reductions."Reduction Amount" - Reductions."Paid Amount") < Reductions."Installment Amount") THEN
                                    ReductionTemp.Amount := (Reductions."Reduction Amount" - Reductions."Paid Amount");
                        END;
                    END;
                    ReductionTemp."User ID" := USERID;
                    ReductionTemp."Date of Calculation" := Header."Date Of Calculation";
                    ReductionTemp."Wage Calculation Entry No." := CalcTemp."No.";
                    ReductionTemp.INSERT;
                    IF NOT RedType.AmountIsPercentage THEN
                        Reductions."Remaining Due" := Reductions."Reduction Amount" - Reductions."Paid Amount" - Reductions."Opening balance" - ReductionTemp.Amount;
                    Reductions.MODIFY;
                UNTIL Reductions.NEXT = 0;
        END;

        IF Header.Reduction THEN BEGIN

            RedTotal := 0;
            RedTemp.RESET;
            RedTemp.SETFILTER("Wage Header No.", CalcTemp."Wage Header No.");
            RedTemp.SETFILTER("Employee No.", Employee."No.");
            IF RedTemp.FINDFIRST THEN
                REPEAT
                    RedTotal := RedTotal + RedTemp.Amount;
                UNTIL RedTemp.NEXT = 0;
            CalcTemp."Wage Reduction" := RedTotal;
            CalcTemp.MODIFY;
        END;
    end;

    procedure TransportAndMeal(Coeff: Decimal)
    begin
        TransLineTemp.INIT;
        TransLineTemp.Amount := 0;
        IF Header.Transportation THEN BEGIN
            TransLineTemp.RESET;
            TransLineTemp.SETFILTER("Document No.", TransHeader."No.");
            TransLineTemp.SETFILTER("Employee No.", Employee."No.");
            IF TransLineTemp.FINDFIRST THEN
                CalcTemp.Transport := TransLineTemp.Amount * Coeff;
        END;

        MealLineTemp.INIT;
        MealLineTemp.Amount := 0;

        IF Header.Meal THEN BEGIN
            MealLineTemp.RESET;
            MealLineTemp.SETFILTER("Document No.", MealHeader."No.");
            MealLineTemp.SETFILTER("Employee No.", Employee."No.");
            IF MealLineTemp.FINDFIRST THEN
                CalcTemp."Meal to pay" := MealLineTemp.Amount * Coeff;
        END;
        CalcTemp.MODIFY;
    end;

    /*đK procedure IndirectWageAddition()
    begin
        IWA.RESET;
        IWA.SETRANGE("Month of Wage", Header."Month Of Wage");
        IWA.SETRANGE("Year of Wage", Header."Year Of Wage");

        IWA.SETRANGE("Employee No.", Employee."No.");
        IWA.SETRANGE(Locked, FALSE);
        IWA.SETFILTER(Amount, '<>0');

        CalcTemp."Indirect Wage Addition Amount" := 0;
        IF (CompInfo."Entity Code" = 'FBIH') THEN
            IF IWA.FINDFIRST THEN
                REPEAT
                    CalcTemp."Indirect Wage Addition Amount" += IWA.Amount;
                UNTIL IWA.NEXT = 0;
        CalcTemp.MODIFY;
    end;
*/
    procedure WageFromHoursNetto2(BaseHourWage: Decimal; AmtDistrCoeff: Decimal)
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        ExperienceBase: Decimal;
        SickFund: Decimal;
        SickCompany: Decimal;
        COA: Record "Cause of Absence";
    begin
        NettoAmount := 0;
        ExperienceBase := 0;
        SickFund := 0;
        SickCompany := 0;

        COA.RESET;
        IF COA.FINDFIRST THEN
            REPEAT
                AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                AbsenceEmp.CALCSUMS(Quantity);

                IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                    IF COA."Sick Leave Paid By Company" THEN BEGIN
                        // NettoAmountT := AbsenceEmp.Quantity*COA.Coefficient*BaseHourWage*AmtDistrCoeff;
                        NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient;

                        NettoAmount += NettoAmountT;
                        SickCompany += NettoAmountT;
                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountT;
                    END;

                    IF COA."Sick Leave" AND NOT COA."Sick Leave Paid By Company" THEN BEGIN
                        /*   IF AbsenceEmp.Quantity >= WageSetup."Maximum hours for sick wage" THEN
                               NettoAmountT := WageSetup."Canton Sick-Leave Amount" * WageSetup."Maximum hours for sick wage"
                           ELSE
                               NettoAmountT := AbsenceEmp.Quantity * (WageSetup."Canton Sick-Leave Amount");

                           IF AbsenceEmp.Quantity = Header."Hour Pool" THEN
                               NettoAmountT := WageSetup."Canton Sick-Leave Amount" * WageSetup."Maximum hours for sick wage";

                          */
                        //ĐK   NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        if CalcTemp."Sick Leave Brutto" <> 0 then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;

                        end;



                        Class.RESET;
                        Class.SETCURRENTKEY("Valid From Amount");
                        Class.SETRANGE(Active, TRUE);
                        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                        Class.FINDFIRST;


                        WageSetup.Get();
                        if (WageSetup."Canton Amount" < NettoAmountT) and (CalcTemp.Canton = false) then
                            NettoAmountT := NettoAmountT - (WageSetup."Canton Amount") / ((1 - Class.Percentage / 100));
                        CantonAmount := (WageSetup."Canton Amount" / ((1 - Class.Percentage / 100))) / ((1 - AddTaxesPercentage / 100));
                        IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                            CalcTemp."Wage (Base)" := CalcTemp."Wage (Base)" - CantonAmount;
                            CalcTemp.Canton := true;
                            CalcTemp.Modify();
                        end;


                        SickFund += NettoAmountT;
                        NettoAmount += NettoAmountT;
                    END;

                    IF NOT (COA."Sick Leave" OR COA."Sick Leave Paid By Company") THEN BEGIN
                        // NettoAmountT:=AbsenceEmp.Quantity*COA.Coefficient*BaseHourWage*AmtDistrCoeff;
                        NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient;

                        NettoAmount += NettoAmountT;
                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountT;
                    END;
                END;
            UNTIL COA.NEXT = 0;

        //NettoAmount+=ExperienceBase*(Employee."Work Experience Percentage"/100);
        //CalcTemp."Expirience Total"+=ExperienceBase*(Employee."Work Experience Percentage"/100);
        CalcTemp."Sick Leave-Company" += SickCompany;
        CalcTemp."Sick Fund Total" += SickFund;
        IF NettoAmount <> 0 THEN BEGIN
            CalcTemp."Employee Coefficient" := CalcTemp."Net Wage Netto 2" / NettoAmount;
            CalcTemp."Wage (Base)" := CalcTemp."Employee Coefficient" * CalcTemp."Hour Pool";
            //   CalcTemp."Experience Total" := CalcTemp."Wage (Base)" * Employee."Work Experience Percentage" / 100;
            //mijenjala ja, a nisam sigurna kad sam ovo promijenila
            CalcTemp."Experience Total" := ExperienceBase * Employee."Work Experience Percentage" / 100;
            //možda   CalcTemp."Experience Total" := (CalcTemp."Wage Base" * CalcTemp."Work Experience Percentage" * CalcTemp."Position Coefficient for Wage" / 100) * (1 - AddTaxesPercentage / 100);
            ;

        END;
        CalcTemp.MODIFY;
    end;

    procedure SubtractNettoAdditions(): Decimal
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        NettoBase: Decimal;
        ExperienceBase: Decimal;
        ExperienceBaseT: Decimal;
        WageAddition: Decimal;
        UntaxableWage: Decimal;
        BruttoBasis: Decimal;
        NetWage: Decimal;
    begin
        CalcTempTemp.INIT;
        NetWageNetto2 := 0;

        CalcTempTemp.RESET;
        CalcTempTemp.SETFILTER("Wage Header No.", CalcTemp."Wage Header No.");
        CalcTempTemp.SETRANGE("Employee No.", CalcTemp."Employee No.");

        IF CalcTempTemp.FINDFIRST THEN
            REPEAT
                NetWageNetto2 += CalcTempTemp."Net Wage Netto 2";

            UNTIL CalcTempTemp.NEXT = 0;
    end;

    procedure Coefficient()
    begin
        CalcTempTemp.INIT;
        CalcTempTemp := CalcTemp;

        CalcTempTemp.RESET;
        CalcTempTemp.SETFILTER("Wage Type", 'NETTO2');
        CalcTempTemp.SETFILTER("Wage Header No.", CalcTemp."Wage Header No.");
        CalcTempTemp.SETRANGE("Employee No.", CalcTemp."Employee No.");

        IF CalcTempTemp.FINDLAST THEN
            NetWageNetto2 := CalcTempTemp."Net Wage Netto 2";
        CalcTemp.MODIFY;
    end;

    procedure WageFromHoursOld(var StartAmount: Decimal; BaseHourWage: Decimal; AmtDistrCoeff: Decimal)
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        ExperienceBase: Decimal;
        SickFund: Decimal;
        SickCompany: Decimal;
        COA: Record "Cause of Absence";
        WAmounts: Record "Wage Amounts";
        AbsenceEmpCOACT: Record "Employee Absence";
        COACT: Record "Cause of Absence";
        NettoAmountTBase: Decimal;
    begin

        NettoAmount := 0;
        ExperienceBase := 0;
        SickFund := 0;
        SickCompany := 0;

        IF Employee."Contact Center" THEN BEGIN
            COACT.RESET;
            COACT.SETFILTER("Added To Hour Pool", '%1', FALSE);
            IF COACT.FINDFIRST THEN
                REPEAT
                    AbsenceEmpCOACT.SETFILTER("Employee No.", Employee."No.");
                    AbsenceEmpCOACT.SETRANGE("From Date", StartDate, EndDate);
                    AbsenceEmpCOACT.SETFILTER("Old Wage Base", '%1', TRUE);
                    AbsenceEmpCOACT.SETFILTER("Cause of Absence Code", '%1', COACT.Code);
                    AbsenceEmpCOACT.CALCSUMS(Quantity);
                    CalcTemp."Individual Hour Pool" += AbsenceEmpCOACT.Quantity;
                UNTIL COACT.NEXT = 0;
            CalcTemp.MODIFY;
        END;

        COA.RESET;
        IF COA.FINDFIRST THEN
            REPEAT
                AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                AbsenceEmp.SETFILTER(Calculated, '%1', FALSE);
                AbsenceEmp.SETFILTER("Old Wage Base", '%1', TRUE);
                AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                AbsenceEmp.CALCSUMS(Quantity);
                IF NOT Employee."Contact Center" THEN
                    CalcTemp."Individual Hour Pool" += AbsenceEmp.Quantity;
                CalcTemp.MODIFY;
                WageSetup.GET;

                IF AbsenceEmp.Quantity <> 0 THEN BEGIN
                    IF COA."Sick Leave Paid By Company" THEN BEGIN
                        //ĐK    NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        if CalcTemp."Sick Leave Brutto" <> 0 then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end;

                        NettoAmount += NettoAmountT;
                        SickCompany += NettoAmountT;
                        //ĐK  ExperienceBase += NettoAmountT;

                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountTBase;

                        //  ExperienceBase += StartAmount * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;
                    END;

                    IF COA."Sick Leave" AND NOT COA."Sick Leave Paid By Company" THEN BEGIN
                        /*   IF AbsenceEmp.Quantity >= WageSetup."Maximum hours for sick wage" THEN
                               NettoAmountT := WageSetup."Canton Sick-Leave Amount" * WageSetup."Maximum hours for sick wage"
                           ELSE
                               NettoAmountT := AbsenceEmp.Quantity * (WageSetup."Canton Sick-Leave Amount");

                           IF AbsenceEmp.Quantity = Header."Hour Pool" THEN
                               NettoAmountT := WageSetup."Canton Sick-Leave Amount" * Header."Hour Pool";

   */

                        /*IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                            CalcTemp."Wage (Base)" := (WageSetup."Canton Sick-Leave Amount" * Header."Hour Pool") / (1 - AddTaxesPercentage / 100);
                            ;
                            CalcTemp.MODIFY;
                        END;*/
                        //ĐK       NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        if CalcTemp."Sick Leave Brutto" <> 0 then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;

                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end;

                        Class.RESET;
                        Class.SETCURRENTKEY("Valid From Amount");
                        Class.SETRANGE(Active, TRUE);
                        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                        Class.FINDFIRST;


                        WageSetup.Get();
                        if (WageSetup."Canton Amount" < NettoAmountT) and (CalcTemp.Canton = false) then
                            NettoAmountT := NettoAmountT - (WageSetup."Canton Amount") / ((1 - Class.Percentage / 100));
                        CantonAmount := (WageSetup."Canton Amount" / ((1 - Class.Percentage / 100))) / ((1 - AddTaxesPercentage / 100));
                        IF AbsenceEmp.Quantity = Header."Hour Pool" THEN BEGIN
                            CalcTemp."Wage (Base)" := CalcTemp."Wage (Base)" - CantonAmount;
                            CalcTemp.Canton := true;
                            CalcTemp.Modify();
                        end;

                        SickFund += NettoAmountT;
                        NettoAmount += NettoAmountT;
                        //ĐK ExperienceBase += NettoAmountT;
                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountTBase;
                        //DGGG  ExperienceBase += StartAmount * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;
                    END;

                    IF NOT (COA."Sick Leave" OR COA."Sick Leave Paid By Company" OR COA."Added To Hour Pool") THEN BEGIN
                        //ĐK      NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;

                        if (CalcTemp."Sick Leave Brutto" <> 0) and (COA."Sick Leave" = true) then begin
                            BaseHourWageSick := (CalcTemp."Sick Leave Brutto" / (1 / (1 - AddTaxesPercentage / 100))) / CalcTemp."Hour Pool";
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWageSick * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;

                        end
                        else begin
                            NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                            NettoAmountTBase := AbsenceEmp.Quantity * 1 * BaseHourWage * AmtDistrCoeff;
                        end;

                        NettoAmount += NettoAmountT;
                        //ĐK     ExperienceBase += NettoAmountT;

                        if COA."Calculate Experience" = true then
                            ExperienceBase += NettoAmountTBase;
                        //StartAmount * (AbsenceEmp.Quantity / CalcTemp."Hour Pool") * AmtDistrCoeff;

                    END;

                    IF COA."Added To Hour Pool" THEN BEGIN
                        NettoAmountT := AbsenceEmp.Quantity * COA.Coefficient * BaseHourWage * AmtDistrCoeff;
                        NettoAmount += NettoAmountT;
                    END;
                END;
            UNTIL COA.NEXT = 0;

        CalcTemp."Net Wage (Calculated Base)" := NettoAmount;
        //ne sada ExperienceBase := CalcTemp."Wage Base" * CalcTemp."Position Coefficient for Wage" * (1 - AddTaxesPercentage / 100);
        CalcTemp."Work Experience (Base)" := ExperienceBase;
        NettoAmount += ExperienceBase * (Employee."Work Experience Percentage" / 100);
        CalcTemp."Experience Total" += ExperienceBase * (Employee."Work Experience Percentage" / 100);
        //ĐK ne sada   CalcTemp."Experience Total" := (CalcTemp."Wage Base" * CalcTemp."Work Experience Percentage" * CalcTemp."Position Coefficient for Wage" / 100) * (1 - AddTaxesPercentage / 100);


        /*
        IF CalcTemp."Department Code"<>'D.2.3.' THEN
        CalcTemp."Work Experience (Base)" := ExperienceBase
        ELSE
        CalcTemp."Work Experience (Base)" := CalcTemp."Wage (Base)";
        IF CalcTemp."Department Code"<>'D.2.3.' THEN
         NettoAmount+=ExperienceBase*(Employee."Work Experience Percentage"/100)
        ELSE
          NettoAmount+=CalcTemp."Wage (Base)"*(Employee."Work Experience Percentage"/100)* (1-AddTaxesPercentage/100);
         IF CalcTemp."Department Code"<>'D.2.3.' THEN
        CalcTemp."Experience Total"+=ExperienceBase*(Employee."Work Experience Percentage"/100)
         ELSE
        CalcTemp."Experience Total"+=CalcTemp."Wage (Base)"*(Employee."Work Experience Percentage"/100)* (1-AddTaxesPercentage/100);
        */

        CalcTemp."Sick Leave-Company" += SickCompany;
        CalcTemp."Sick Fund Total" += SickFund;
        CalcTemp.MODIFY;


        CalcTemp."Net Wage" += NettoAmount;
        CalcTemp."Tax Basis" += NettoAmount;
        RoundIt(CalcTemp."Net Wage");
        CalcTemp.MODIFY;

    end;

    procedure WageFromBruttoIncentive(WithInsert: Boolean; CalculateReductions: Boolean; Dim1: Code[20]; Dim2: Code[20])
    var
        ATBasis: Decimal;
        ATPercent: Decimal;
        ATAmount: Decimal;
        ATAmountRS: Decimal;
        ATCode: Code[10];
        ATTotal: Decimal;
        ATTotalRS: Decimal;
        TaxAmount: Decimal;
        TaxBasis: Decimal;
        TaxTotal: Decimal;
        COA: Record "Cause of Absence";
        MealAQuantity: Integer;
        BaseAmountForBrutto: Decimal;
        LTDays: Decimal;
        ATempAlready: Record "Contribution Per Employee";
        ATempAlready2: Record "Contribution Per Employee";
    begin

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        ATEmpTemp.RESET;

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        CalcTemp.CALCFIELDS(Incentive);
                        ATBasis := CalcTemp.Incentive;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        IF ((CalcTemp."Contribution Category Code" = 'FBIHRS2') OR (CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                            IF ATCConRS.GET('RS', AddTaxes.Code) THEN
                                ATPercentRS := ATCConRS.Percentage / 100;
                        END;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');
                        ATAmountRS := ROUND(ATBasis * ATPercentRS, 0.00001, '=');
                        IF WithInsert THEN BEGIN
                            ATEmpTemp.INIT;
                            ATEmpTemp."Employee No." := Employee."No.";
                            ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                            ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                            ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                            ATEmpTemp."Contribution Code" := AddTaxes.Code;
                            RoundIt(ATAmount);
                            ATEmpTemp."Amount From Wage" := ATAmount;
                            ATEmpTemp."Reported Amount From Wage" := ATAmountRS;
                            ATEmpTemp."Amount Over Wage" := 0;
                            ATEmpTemp."Amount Over Neto" := 0;

                            ATEmpTemp."Global Dimension 1 Code" := Dim1;
                            ATEmpTemp."Global Dimension 2 Code" := Dim2;
                            ATEmpTemp.Basis := ATBasis;
                            ATEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
                            ATEmpTemp.Incentive := TRUE;
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmpTemp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                        ATTotalRS := ATTotalRS + ATAmountRS;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;

        CalcTemp."Contribution From Brutto" := ATTotal;
        IF (CalcTemp."Contribution Category Code" = 'FBIHRS2') OR (CalcTemp."Contribution Category Code" = 'BDPIORS') THEN BEGIN
            CalcTemp."Reported Amount From Brutto" := ATTotalRS;
            CalcTemp."Tax Basis (RS)" := CalcTemp.Brutto - CalcTemp."Reported Amount From Brutto";


            Class.RESET;
            Class.SETCURRENTKEY("Valid From Amount");
            Class.SETRANGE(Active, TRUE);
            Class.SETRANGE("Entity Code", CompInfo."Entity Code");
            Class.FINDFIRST;


            CalcTemp."Tax (RS)" := Class.Percentage * CalcTemp."Tax Basis (RS)";
            CalcTemp.MODIFY;
        END;




        Employee1.SETFILTER("No.", CalcTemp."Employee No.");
        IF Employee1.FINDFIRST THEN BEGIN
            CalcTemp."Municipality CIPS" := Employee1."Municipality Code CIPS";
        END;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Brutto", '%1', TRUE);
        AddTaxes.SETFILTER("Fixed Amount", '%1', FALSE);

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        ATBasis := CalcTemp.Brutto;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');
                        ATAmountRS := ROUND(ATBasis * ATPercentRS, 0.00001, '>');
                        IF WithInsert THEN BEGIN
                            ATEmpTemp.INIT;
                            ATEmpTemp."Employee No." := Employee."No.";
                            ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                            ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                            ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                            ATEmpTemp."Contribution Code" := AddTaxes.Code;
                            ATEmpTemp."Amount From Wage" := 0;
                            RoundIt(ATAmount);
                            ATEmpTemp."Amount Over Wage" := ATAmount;
                            ATEmpTemp."Amount Over Neto" := 0;
                            IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN
                                ATEmpTemp."Amount On Wage" := 0
                            ELSE
                                ATEmpTemp."Amount On Wage" := ATAmount;
                            ATEmpTemp."Reported Amount On Wage" := ATAmountRS;
                            ATEmpTemp.Basis := ATBasis;
                            ATEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
                            IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN ATEmpTemp.Special := TRUE;
                            IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN ATEmpTemp."Special Contribution Amount" := ATAmount;
                            ;
                            // ATEmpTemp."Reported Amount On Wage":= ATAmountRS;
                            ATEmpTemp."Global Dimension 1 Code" := Dim1;
                            ATEmpTemp."Global Dimension 2 Code" := Dim2;
                            ATEmpTemp.Incentive := TRUE;
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmpTemp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                        ATTotalRS := ATTotalRS + ATAmountRS;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;

        CalcTemp."Contribution Over Brutto" := ATTotal;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Brutto", '%1', TRUE);
        AddTaxes.SETFILTER("Fixed Amount", '%1', TRUE);

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN BEGIN
            IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                IF NOT ATCCon.Blocked THEN BEGIN
                    ATBasis := AddTaxes.Minimum;
                    EndDay := DATE2DMY(EndDate, 1);
                    ATBasis := ATBasis / EndDay;
                    ATPercent := ATCCon.Percentage / 100;
                    ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');

                    Absences.RESET;
                    Absences.SETFILTER("Employee No.", Employee."No.");
                    Absences.SETRANGE("From Date", StartDate, EndDate);
                    Absences.SETRANGE(Calculated, FALSE);
                    Absences.SETRANGE("RS Code", '00');
                    AbCount := Absences.COUNT;
                    ATBasis := ATBasis * AbCount;
                    ATAmount := ATAmount * AbCount;

                    IF WithInsert THEN BEGIN
                        ATEmpTemp.INIT;
                        ATEmpTemp."Employee No." := Employee."No.";
                        ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                        ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                        ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                        ATempAlready.Reset();
                        ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                        ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                        if ATempAlready.FindFirst() then begin
                            ATempAlready2.Reset();
                            ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            ATempAlready2.SetCurrentKey("Wage Calc No.");
                            ATempAlready2.Ascending;
                            if ATempAlready2.FindLast() then begin
                                ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                            end;
                        end;


                        ATEmpTemp."Contribution Code" := AddTaxes.Code;
                        ATEmpTemp."Amount From Wage" := 0;
                        RoundIt(ATAmount);
                        ATEmpTemp."Amount Over Wage" := ATAmount;
                        ATEmpTemp."Amount Over Neto" := 0;
                        IF ((Employee."Org Entity Code" = 'RS') AND NOT (Employee."Contribution Category Code" = 'FBIHRS')) THEN
                            ATEmpTemp."Amount On Wage" := 0
                        ELSE
                            ATEmpTemp."Amount On Wage" := ATAmount;
                        ATEmpTemp.Basis := ATBasis;
                        ATEmpTemp."Wage Calculation Entry No." := CalcTemp."No.";
                        ATEmpTemp."Global Dimension 1 Code" := Dim1;
                        ATEmpTemp."Global Dimension 2 Code" := Dim2;
                        ATEmpTemp.Incentive := TRUE;
                        IF Employee."Org Entity Code" = 'RS' THEN ATEmpTemp.Special := TRUE;
                        IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN

                            CompInfo.GET;
                            ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                        END
                        ELSE BEGIN
                            ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                        END;
                        ATEmpTemp.INSERT(TRUE);
                    END;
                    ATTotal := ATTotal + ATAmount;
                    IF ATEmpTemp.Special THEN ATEmpTemp."Special Contribution Amount" += ATAmount;
                END;
            END;
        END;

        CalcTemp."Contribution Over Brutto" += ATTotal;

        CalcTemp."Earnings Deduction" += CalcTemp."Contribution From Brutto";

        AddTaxCat.GET(CalcTemp."Contribution Category Code");

        //NK
        WageCalc.SETFILTER("Employee No.", '%1', Employee."No."); //  WageCalc.SETFILTER("Employee No.",'%1',CalcTemp."Employee No.");
        WageCalc.SETFILTER("Month Of Wage", '%1', CalcTemp."Month Of Wage");
        WageCalc.SETFILTER("Year of Wage", '%1', CalcTemp."Year Of Wage");
        IF WageCalc.FIND('-') THEN
            //  WageCalc.CALCSUMS("Tax Deductions");
            //CalcTemp."Tax Deductions":=Employee."Tax Deduction Amount";
            //MESSAGE(FORMAT(Employee."No."));
            IF Employee."Tax Deduction Amount" > WageCalc."Tax Deductions" THEN
                CalcTemp."Tax Deductions" := Employee."Tax Deduction Amount" - WageCalc."Tax Deductions"
            ELSE
                CalcTemp."Tax Deductions" := 0;
        CalcTemp.MODIFY;

        IF (CalcTemp."Net Wage" <= CalcTemp."Tax Deductions") and (CalcTemp."Contribution Category Code" <> 'RS') THEN BEGIN
            CalcTemp."Tax Basis" := 0;
            CalcTemp.Tax := 0;
            CalcTemp."Contribution Per City" := 0;
            //CalcTemp."Tax Deductions":= CalcTemp."Net Wage";
        END
        ELSE

            if (CalcTemp."Contribution Category Code" = 'RS') then begin
                CalcTemp."Tax Basis" := CalcTemp.Brutto - CalcTemp."Tax Deductions";
                if CalcTemp.Brutto < CalcTemp."Tax Deductions" then
                    CalcTemp."Tax Basis" := 0;
            end
            else begin

                CalcTemp."Tax Basis" := CalcTemp."Net Wage" - CalcTemp."Tax Deductions";
            end;

        Class.RESET;
        Class.SETCURRENTKEY("Valid From Amount");
        Class.SETRANGE(Active, TRUE);
        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
        Class.FINDFIRST;
        TaxTotal := 0;

        REPEAT
            TaxAmount := 0;
            IF (CalcTemp."Tax Basis" <= Class."Valid To Amount") AND (CalcTemp."Tax Basis" > Class."Valid From Amount") THEN
                TaxAmount := (CalcTemp."Tax Basis" - Class."Valid From Amount") * Class.Percentage / 100 *
                           AddTaxCat."Tax Payment Percentage" / 100

            ELSE
                IF CalcTemp."Tax Basis" > Class."Valid To Amount" THEN
                    TaxAmount := (Class."Valid To Amount" - Class."Valid From Amount")
                               * Class.Percentage / 100 * AddTaxCat."Tax Payment Percentage" / 100;
            IF WithInsert THEN
                RoundIt(TaxAmount);
            TaxTotal := TaxTotal + TaxAmount;

        /* IF WithInsert THEN BEGIN
          TaxEmpTemp."Wage Header No.":= CalcTemp."Wage Header No.";
          TaxEmpTemp."Entry No.":= CalcTemp."Entry No.";
          TaxEmpTemp."Wage Calculation No.":=CalcTemp."No.";
          TaxEmpTemp."Tax Code":=Class.Code;
          TaxEmpTemp."Employee No.":=CalcTemp."Employee No.";
          TaxEmpTemp."Contribution Category Code":=Employee."Contribution Category Code";
          TaxEmpTemp.Amount:= TaxAmount;
          CompInfo.GET;
          IF Employee."Entity Code CIPS"=Employee."Org Entity Code" THEN
            TaxEmpTemp."Tax Number":=Municipality."Tax Number"
          ELSE
          TaxEmpTemp."Tax Number":=Employee."Org Municipality";
          TaxEmpTemp."Canton Code" := Employee."County CIPS";

           IF ((Employee."Contribution Category Code"='FBIHRS')) THEN BEGIN
           IF Employee."Entity Code CIPS"='RS' THEN
            TaxEmpTemp."Tax Number":=Employee."Org Municipality"
           ELSE
             TaxEmpTemp."Tax Number":=Employee."Municipality Code CIPS";
              END;
          END;
          TaxEmpTemp."Wage Calculation Entry No.":=CalcTemp."No.";
          TaxEmpTemp.INSERT;*/

        UNTIL Class.NEXT = 0;

        CalcTemp.Tax := TaxTotal;

        CalcTemp."Earnings Deduction" += CalcTemp.Tax;

        CalcTemp."Net Wage After Tax" := ROUND((CalcTemp.Brutto - CalcTemp."Earnings Deduction"
                                         - CalcTemp."Indirect Wage Addition Amount" - CalcTemp."Minimal Netto Wage Difference"), 0.05, '=');

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Netto", '%1', TRUE);     //Zapravo je Over Netto
        ATTotal := 0;
        ATEmpTemp.RESET;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(CalcTemp."Contribution Category Code", AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        IF ((CalcTemp."Contribution Category Code" = 'BDPIOFBIH') OR (CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                            CalcTemp.CALCFIELDS("Regres Netto Tax Separate");
                            ATBasis := CalcTemp."Net Wage After Tax" - CalcTemp."Regres Netto Tax Separate";
                        END
                        ELSE BEGIN
                            ATBasis := CalcTemp."Net Wage After Tax";
                        END;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '=');

                        IF WithInsert THEN BEGIN
                            ATEmpTemp.INIT;
                            ATEmpTemp."Employee No." := Employee."No.";
                            ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                            ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                            ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                            ATEmpTemp."Contribution Code" := AddTaxes.Code;
                            RoundIt(ATAmount);
                            ATEmpTemp."Amount From Wage" := 0;
                            ATEmpTemp."Amount Over Wage" := 0;
                            ATEmpTemp."Amount Over Neto" := ATAmount;
                            ATEmpTemp."Amount On Wage" := 0;
                            ATEmpTemp.Basis := ATBasis;
                            ATEmpTemp."Global Dimension 1 Code" := Dim1;
                            ATEmpTemp."Global Dimension 2 Code" := Dim2;
                            ATEmpTemp.Special := TRUE;
                            ATEmpTemp.Incentive := TRUE;
                            IF ATEmpTemp.Special THEN ATEmpTemp."Special Contribution Amount" := ATAmount;
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmpTemp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;

                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;

        IF WithInsert THEN BEGIN
            IF Employee."Contribution Category Code" = 'RS' THEN BEGIN
                ATEmpTemp.INIT;
                ATEmpTemp."Employee No." := Employee."No.";
                ATEmpTemp."Wage Header No." := CalcTemp."Wage Header No.";
                ATEmpTemp."Entry No." := CalcTemp."Entry No.";
                ATEmpTemp."Wage Calc No." := CalcTemp."No.";

                ATempAlready.Reset();
                ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmpTemp."Wage Calc No.");
                ATempAlready.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                if ATempAlready.FindFirst() then begin
                    ATempAlready2.Reset();
                    ATempAlready2.SetFilter("Employee No.", '%1', ATEmpTemp."Employee No.");
                    ATempAlready2.SetCurrentKey("Wage Calc No.");
                    ATempAlready2.Ascending;
                    if ATempAlready2.FindLast() then begin
                        ATEmpTemp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                    end;
                end;


                ATEmpTemp."Contribution Category Code" := CalcTemp."Contribution Category Code";
                ATEmpTemp."Contribution Code" := 'P-VOD';
                RoundIt(ATAmount);
                ATEmpTemp."Amount From Wage" := 0;
                ATEmpTemp."Amount Over Wage" := 0;
                ATEmpTemp."Amount Over Neto" := 1;
                ATEmpTemp."Amount On Wage" := 0;
                ATEmpTemp.Basis := 0;
                ATEmpTemp."Global Dimension 1 Code" := Dim1;
                ATEmpTemp."Global Dimension 2 Code" := Dim2;
                ATEmpTemp.Special := TRUE;
                ATEmpTemp.Incentive := TRUE;

                IF ATEmpTemp.Special THEN ATEmpTemp."Special Contribution Amount" := 1;
                IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                    CompInfo.GET;
                    ATEmpTemp."Tax Number" := CompInfo."Municipality Code";
                END
                ELSE BEGIN
                    ATEmpTemp."Tax Number" := Employee."Municipality Code CIPS";
                END;
                ATEmpTemp.INSERT(TRUE);
            END;
            ATTotal := ATTotal + 1;

        END;

        CalcTemp."Contribution Over Netto" := ATTotal;


        CalcTemp."Final Net Wage" :=
        CalcTemp."Net Wage After Tax" +
        CalcTemp."Untaxable Wage";

        // IF CalculateReductions THEN
        CalcReductions;

        IF WageType."Wage Calculation Type" <> 3 THEN
            CalcTemp.Payment := CalcTemp."Net Wage" + CalcTemp."Untaxable Wage" - CalcTemp.Tax - CalcTemp."Wage Reduction";

        IF WithInsert THEN BEGIN
            IF CalcTemp.Payment <> 0 THEN
                CalcTemp.MODIFY
            ELSE
                DeleteCalcTemp;
        END;

    end;

    procedure AdditionsCalculation(var IDMonth: Integer; var IDYear: Integer; var WHNo: Code[20]; var CDate: Date)
    var
        NettoAmount: Decimal;
        NettoAmountT: Decimal;
        NettoBase: Decimal;
        ExperienceBase: Decimal;
        ExperienceBaseT: Decimal;
        WageAddition: Decimal;
        UntaxableWage: Decimal;
        BruttoBasis: Decimal;
        NetWage: Decimal;
        ConCat: Record "Contribution Category";
        TPE: Record "Tax Per Employee";
        CalcNo: Code[30];
        Employee: Record "Employee";
        TPE2: Record "Tax Per Employee";
        No: Code[30];
        EntryNo: Integer;
        WLE: Record "Wage Ledger Entry";
        WHO: Integer;
        AF: Codeunit "Absence Fill";
        ValueEntriesExist: Boolean;
        PostingGroup: Code[10];
        EmpDefDim: Record "Employee Default Dimension";
        AddTaxPE: Record "Contribution Per Employee";
        No2: Code[30];
        TaxAlready: Record "Tax Per Employee";
        TaxAlready2: Record "Tax Per Employee";
    begin
        WA.RESET;
        WA.SETRANGE("Month of Wage", IDMonth);
        WA.SETRANGE("Year of Wage", IDYear);
        WA.SETRANGE("Wage Header No.", '');
        WA.SETFILTER(Calculated, '%1', FALSE);

        IF WA.FINDFIRST THEN
            REPEAT
                WA.Calculated := TRUE;
                WA."Wage Header No." := WHNo;
                WA."Closing Date" := CDate;
                WA.MODIFY;
                IF WA.Taxable THEN BEGIN
                    TPE.SETRANGE("Wage Calculation No.");
                    IF TPE.FIND('+') THEN
                        CalcNo := INCSTR(TPE."Wage Calculation No.")
                    ELSE
                        CalcNo := '00000000';

                    No := '';
                    TPE.INIT;
                    TPE."Wage Header No." := WHNo;
                    TPE2.SETFILTER("Wage Header No.", '%1', WHNo);
                    IF TPE2.FIND('+') THEN
                        No := INCSTR(TPE2."Wage Calculation No.")
                    ELSE BEGIN
                        TPE2.SETCURRENTKEY("Wage Calculation No.");
                        IF TPE2.FIND('+') THEN
                            No := INCSTR(TPE2."Wage Calculation No.")
                        ELSE
                            No := '000000000';
                    END;
                    TPE."Wage Calculation No." := No;

                    TaxAlready.Reset();
                    TaxAlready.SetFilter("Wage Calculation No.", '%1', TPE."Wage Calculation No.");
                    if TaxAlready.FindFirst() then begin
                        TaxAlready2.Reset();
                        TaxAlready2.SetCurrentKey("Wage Calculation No.");
                        TaxAlready2.Ascending;
                        if TaxAlready2.FindLast() then begin
                            TPE."Wage Calculation No." := IncStr(TaxAlready2."Wage Calculation No.");
                        end;
                    end;

                    TPE."Employee No." := WA."Employee No.";
                    TPE."Tax Number" := 'FBIH';
                    TPE."Payment date" := CDate;
                    Employee.SETFILTER("No.", '%1', WA."Employee No.");
                    IF Employee.FIND('-') THEN BEGIN
                        TPE."Contribution Category Code" := Employee."Contribution Category Code";
                        CompInfo.GET;
                        IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                            /*TPE."Tax Number":=CompInfo."Municipality Code";
                            TPE."Canton Code" := CompInfo.County;*/
                            TPE."Tax Number" := Employee."Municipality Code CIPS";
                            TPE."Canton Code" := Employee."County CIPS";
                        END
                        ELSE BEGIN
                            TPE."Tax Number" := Employee."Municipality Code CIPS";
                            TPE."Canton Code" := Employee."County CIPS";
                        END;

                        EmpDefDim.SETFILTER("No.", '%1', WA."Employee No.");
                        IF WA.Taxable THEN BEGIN
                            No := '';
                            IF AddTaxPE.FIND('+') THEN
                                No := INCSTR(AddTaxPE."Wage Calc No.")
                            ELSE
                                No := '000000000';
                            IF EmpDefDim.FIND('-') THEN
                                WageFromBruttoAdditions(TRUE, FALSE, EmpDefDim."Dimension Value Code", '', Employee."Contribution Category Code", WA."Employee No.", WHNo, FORMAT(WA."Entry No."), No, WA."Calculated Amount Brutto", WA."Amount to Pay", CDate)
                            ELSE
                                WageFromBruttoAdditions(TRUE, FALSE, '', '', Employee."Contribution Category Code", WA."Employee No.", WHNo, FORMAT(WA."Entry No."), No, WA."Calculated Amount Brutto", WA."Amount to Pay", CDate);
                        END;
                        TPE."Wage Calculation Type" := 4;
                    END;
                    TPE.Amount := WA.Tax;
                    TPE.INSERT;
                END;
                IF WLE.FINDLAST THEN EntryNo := WLE."Entry No." + 1 ELSE EntryNo := 0;

                WLE.INIT;
                No2 := INCSTR(No);

                WLE."Entry No." := EntryNo;
                IF EVALUATE(WHO, WHNo) THEN
                    WLE."Wage Header Entry No." := WHO;
                WLE."Employee No." := WA."Employee No.";
                WLE."Document No." := WHNo;
                WLE.Description := '';

                WLE.Open := TRUE;
                EmpDefDim.SETFILTER("No.", '%1', WA."Employee No.");
                IF EmpDefDim.FIND('-') THEN
                    WLE."Global Dimension 1 Code" := EmpDefDim."Dimension Value Code";
                WLE."Document Date" := CDate;

                WLE."Posting Date" := AF.GetMonthRange(IDMonth, IDYear, FALSE);
                WLE."No. Series" := '';
                WLE."Month Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 2);
                WLE."Year Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                WLE."Month Of Wage" := IDMonth;
                WLE."Year Of Wage" := IDYear;
                WLE."Wage Calculation Type" := WLE."Wage Calculation Type"::Additions;
                WLE.INSERT;

                ValueEntriesExist := FALSE;
                PostingGroup := 'FBIH';

                Desc := COPYSTR(STRSUBSTNO('Porez'), 1, MAXSTRLEN(Desc));
                IF WA.Taxable THEN
                    InsertValueEntryAdditions(Desc, WVE."Entry Type"::Tax, WA.Tax, '',
                    ValueEntriesExist, WA."Tax Basis", WA."Employee No.", WHNo, WLE."Posting Date", WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account",
                    CDate, WA.Tax, 0);

                Desc := COPYSTR(STRSUBSTNO(WA."Wage Addition Type"), 1, MAXSTRLEN(Desc));
                IF WA.Taxable THEN
                    InsertValueEntryAdditions(Desc, WVE."Entry Type"::Taxable, WA."Amount to Pay", '', ValueEntriesExist, WA."Tax Basis",
                    WA."Employee No.", WHNo, WLE."Posting Date", WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, WA.Amount, WA.Brutto)
                ELSE
                    InsertValueEntryAdditions(Desc, WVE."Entry Type"::Untaxable, WA."Amount to Pay", '', ValueEntriesExist, WA."Tax Basis",
                    WA."Employee No.", WHNo, WLE."Posting Date", WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, WA.Amount, 0);


                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", WLE."Employee No.");
                ATTemp.SETFILTER("Wage Header No.", WHNo);
                ATTemp.SETRANGE("Payment Date", CDate);
                ATTemp.SETFILTER("Wage Calculation Entry No.", '%1', FORMAT(WA."Entry No."));
                ATTemp.SETFILTER("Amount From Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(ATax."Short Code"), 1, MAXSTRLEN(Desc));
                        IF ((WA."Contribution Category Code" = 'FBIHRS')) THEN BEGIN
                            WageSetup.GET;


                            IF ((ATax.Code = 'D-NEZAP-IZ')) THEN
                                InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Unemployment Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                                 WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Unemployment Federation" / 100), 0);

                            IF ((ATax.Code = 'D-ZDRAV-IZ')) THEN
                                InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Health Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                                 WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Health Federation" / 100), 0);

                            IF ((ATax.Code = 'D-PIO-NA') OR (ATax.Code = 'D-PIO-IZ')) THEN
                                InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                                         ATTemp."Amount From Wage", ATax.Code,
                                                         ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                                         WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, 0, 0)
                        END
                        ELSE BEGIN
                            InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                             ATTemp."Amount From Wage", ATax.Code,
                                             ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                             WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, ATTemp."Amount From Wage", 0)
                        END;
                    UNTIL ATTemp.NEXT = 0;
                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", WA."Employee No.");
                ATTemp.SETFILTER("Wage Header No.", WHNo);
                ATTemp.SETRANGE("Payment Date", CDate);
                ATTemp.SETFILTER("Wage Calculation Entry No.", '%1', FORMAT(WA."Entry No."));
                //ATTemp.SETRANGE("Global Dimension 1 Code", WageCalc."Global Dimension 1 Code");
                // ATTemp.SETRANGE("Global Dimension 2 Code", WageCalc."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", WageCalc."Shortcut Dimension 4 Code");

                //ATTemp.SETRANGE("Entry No.",WageCalc."Entry No.");
                /*ATTemp.SETFILTER("Amount Over Wage",'<>0');
                IF ATTemp.FINDFIRST THEN
                  REPEAT
                    ATax.GET(ATTemp."Contribution Code");
                    Desc:= COPYSTR(STRSUBSTNO(Txt005, ATax.Description, WLE."Employee No.", ''),1, MAXSTRLEN(Desc));
                    InsertValueEntryAdditions(Desc,WVE."Entry Type"::Contribution,
                                     ATTemp."Amount Over Wage",ATax.Code,
                                     ValueEntriesExist,ATTemp.Basis,WLE."Employee No.",WLE."Document No.",WLE."Posting Date",
                                     PostingGroup,WA."Wage Addition Type",WLE."Global Dimension 1 Code",WA."Use Apportionment Account")*/
                ATTemp.SETFILTER("Amount Over Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(ATax."Short Code"), 1, MAXSTRLEN(Desc));
                        IF ((WA."Contribution Category Code" = 'FBIHRS')) THEN BEGIN
                            WageSetup.GET;
                            IF ((ATax.Code = 'D-NEZAP-NA')) THEN
                                InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Unemployment Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                                 WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Unemployment Federation" / 100), 0);
                            IF ((ATax.Code = 'D-ZDRAV-NA')) THEN
                                InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Health Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                                 WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Health Federation" / 100), 0);
                            IF ((ATax.Code = 'D-PIO-NA')) THEN
                                InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                                        ATTemp."Amount Over Wage", ATax.Code,
                                                        ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                                        WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, ATTemp."Amount Over Wage", 0)

                        END
                        ELSE BEGIN
                            //NK2005  IF ((CalcTemp."Contribution Category Code"<>'FBIHRS') ) THEN
                            InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                             ATTemp."Amount Over Wage", ATax.Code,
                                             ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                             WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, ATTemp."Amount Over Wage", 0);
                        END;
                    UNTIL ATTemp.NEXT = 0;

                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", WA."Employee No.");
                ATTemp.SETFILTER("Wage Header No.", WHNo);
                ATTemp.SETRANGE("Payment Date", CDate);
                ATTemp.SETFILTER("Wage Calculation Entry No.", '%1', FORMAT(WA."Entry No."));
                //ATTemp.SETRANGE("Global Dimension 1 Code", WageCalc."Global Dimension 1 Code");
                //ATTemp.SETRANGE("Global Dimension 2 Code", WageCalc."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", WageCalc."Shortcut Dimension 4 Code");

                // ATTemp.SETRANGE("Entry No.",WageCalc."Entry No.");
                ATTemp.SETFILTER("Amount Over Neto", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT

                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(ATax."Short Code"), 1, MAXSTRLEN(Desc));
                        InsertValueEntryAdditions(Desc, WVE."Entry Type"::Contribution,
                                         ATTemp."Amount Over Neto", ATax.Code,
                                         ValueEntriesExist, ATTemp.Basis, WLE."Employee No.", WLE."Document No.", WLE."Posting Date",
                                         WA."Contribution Category Code", WA."Wage Addition Type", WLE."Global Dimension 1 Code", WA."Use Apportionment Account", CDate, ATTemp."Amount Over Neto", 0)
                    UNTIL ATTemp.NEXT = 0;
            UNTIL WA.NEXT = 0;

    end;

    procedure WageFromBruttoAdditions(WithInsert: Boolean; CalculateReductions: Boolean; Dim1: Code[20]; Dim2: Code[20]; ConCode: Code[10]; EmpNo: Code[10]; WHNo: Code[10]; EntryNo: Code[10]; No: Code[10]; ABrutto: Decimal; ANetto: Decimal; CDate: Date)
    var
        ATBasis: Decimal;
        ATPercent: Decimal;
        ATAmount: Decimal;
        ATAmountRS: Decimal;
        ATCode: Code[10];
        ATTotal: Decimal;
        ATTotalRS: Decimal;
        TaxAmount: Decimal;
        TaxBasis: Decimal;
        TaxTotal: Decimal;
        COA: Record "Cause of Absence";
        MealAQuantity: Integer;
        BaseAmountForBrutto: Decimal;
        LTDays: Decimal;
        ATempAlready: Record "Contribution Per Employee";
        ATempAlready2: Record "Contribution Per Employee";
    begin

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        ATEmp.RESET;

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(ConCode, AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        ATBasis := ABrutto;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > ABrutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < ABrutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        IF ((ConCode = 'FBIHRS') OR (ConCode = 'BDPIORS')) THEN BEGIN
                            IF ATCConRS.GET('RS', AddTaxes.Code) THEN
                                ATPercentRS := ATCConRS.Percentage / 100;
                        END;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '>');
                        ATAmountRS := ROUND(ATBasis * ATPercentRS, 0.00001, '>');
                        IF WithInsert THEN BEGIN
                            ATEmp.INIT;
                            ATEmp."Employee No." := EmpNo;
                            ATEmp."Wage Header No." := WHNo;
                            //NKATEmpTemp."Entry No.":=EntryNo;
                            ATEmp."Wage Calc No." := No;


                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmp."Contribution Category Code" := ConCode;
                            ATEmp."Contribution Code" := AddTaxes.Code;
                            RoundIt(ATAmount);
                            ATEmp."Amount From Wage" := ATAmount;
                            ATEmp."Reported Amount From Wage" := ATAmountRS;
                            ATEmp."Amount Over Wage" := 0;
                            ATEmp."Amount Over Neto" := 0;

                            ATEmp."Global Dimension 1 Code" := Dim1;
                            ATEmp."Global Dimension 2 Code" := Dim2;
                            ATEmp.Basis := ATBasis;
                            ATEmp."Wage Calculation Entry No." := EntryNo;
                            ATEmp."Wage Calculation Type" := 4;
                            ATEmp."Payment Date" := CDate;
                            Employee.GET(ATEmp."Employee No.");
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                        ATTotalRS := ATTotalRS + ATAmountRS;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;



        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Brutto", '%1', TRUE);
        AddTaxes.SETFILTER("Fixed Amount", '%1', FALSE);

        ATTotal := 0;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(ConCode, AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        ATBasis := ABrutto;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > ABrutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < ABrutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '>');
                        ATAmountRS := ROUND(ATBasis * ATPercentRS, 0.00001, '>');
                        IF WithInsert THEN BEGIN
                            ATEmp.INIT;
                            ATEmp."Employee No." := EmpNo;
                            ATEmp."Wage Header No." := WHNo;
                            //NK ATEmpTemp."Entry No.":=EntryNo;
                            ATEmp."Wage Calc No." := No;


                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmp."Contribution Category Code" := ConCode;
                            ATEmp."Contribution Code" := AddTaxes.Code;
                            ATEmp."Wage Calculation Entry No." := EntryNo;
                            ATEmp."Amount From Wage" := 0;
                            RoundIt(ATAmount);
                            ATEmp."Amount Over Wage" := ATAmount;
                            ATEmp."Amount Over Neto" := 0;
                            ATEmp."Amount On Wage" := ATAmount;
                            ATEmp."Reported Amount On Wage" := ATAmountRS;
                            ATEmp.Basis := ATBasis;
                            // ATEmp."Wage Calculation Entry No.":=CalcTemp."No.";
                            // ATEmpTemp."Reported Amount On Wage":= ATAmountRS;
                            ATEmp."Global Dimension 1 Code" := Dim1;
                            ATEmp."Global Dimension 2 Code" := Dim2;
                            ATEmp."Wage Calculation Type" := 4;
                            ATEmp."Payment Date" := CDate;
                            Employee.GET(ATEmp."Employee No.");
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN
                                ATEmp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                        ATTotalRS := ATTotalRS + ATAmountRS;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;



        AddTaxCat.GET(ConCode);


        Class.RESET;
        Class.SETCURRENTKEY("Valid From Amount");
        Class.SETRANGE(Active, TRUE);
        CompInfo.GET;
        Class.SETRANGE("Entity Code", CompInfo."Entity Code");
        Class.FINDFIRST;
        TaxTotal := 0;


        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Netto", '%1', TRUE);
        ATTotal := 0;
        ATEmpTemp.RESET;

        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(ConCode, AddTaxes.Code) THEN BEGIN
                    IF NOT ATCCon.Blocked THEN BEGIN
                        IF ((ConCode = 'BDPIOFBIH') OR (ConCode = 'BDPIORS')) THEN BEGIN

                            ATBasis := ANetto;
                        END
                        ELSE BEGIN
                            ATBasis := ANetto;
                        END;
                        IF (AddTaxes.Minimum > 0) AND (AddTaxes.Minimum > CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Minimum;
                        IF (AddTaxes.Maximum > 0) AND (AddTaxes.Maximum < CalcTemp.Brutto) THEN
                            ATBasis := AddTaxes.Maximum;
                        ATPercent := ATCCon.Percentage / 100;
                        ATAmount := ROUND(ATBasis * ATPercent, 0.00001, '>');

                        IF WithInsert THEN BEGIN
                            ATEmp.INIT;
                            ATEmp."Employee No." := EmpNo;
                            ATEmp."Wage Header No." := WHNo;
                            //ATEmpTemp."Entry No.":=CalcTemp."Entry No.";
                            ATEmp."Wage Calc No." := No;


                            ATempAlready.Reset();
                            ATempAlready.SetFilter("Wage Calc No.", '%1', ATEmp."Wage Calc No.");
                            ATempAlready.SetFilter("Employee No.", '%1', ATEmp."Employee No.");
                            if ATempAlready.FindFirst() then begin
                                ATempAlready2.Reset();
                                ATempAlready2.SetFilter("Employee No.", '%1', ATEmp."Employee No.");
                                ATempAlready2.SetCurrentKey("Wage Calc No.");
                                ATempAlready2.Ascending;
                                if ATempAlready2.FindLast() then begin
                                    ATEmp."Wage Calc No." := IncStr(ATempAlready2."Wage Calc No.");
                                end;
                            end;


                            ATEmp."Contribution Category Code" := ConCode;
                            ATEmp."Contribution Code" := AddTaxes.Code;
                            ATEmp."Wage Calculation Entry No." := EntryNo;
                            RoundIt(ATAmount);
                            ATEmp."Amount From Wage" := 0;
                            ATEmp."Amount Over Wage" := 0;
                            ATEmp."Amount Over Neto" := ATAmount;
                            ATEmp."Amount On Wage" := ATAmount;
                            ATEmp."Wage Calculation Type" := 4;
                            ATEmp.Basis := ATBasis;
                            ATEmp."Global Dimension 1 Code" := Dim1;
                            ATEmp."Global Dimension 2 Code" := Dim2;
                            ATEmp."Payment Date" := CDate;
                            Employee.GET(ATEmp."Employee No.");
                            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                                CompInfo.GET;
                                ATEmp."Tax Number" := CompInfo."Municipality Code";
                            END
                            ELSE BEGIN

                                ATEmp."Tax Number" := Employee."Municipality Code CIPS";
                            END;
                            ATEmp.INSERT(TRUE);
                        END;
                        ATTotal := ATTotal + ATAmount;
                    END;
                END;
            UNTIL AddTaxes.NEXT = 0;
    end;

    procedure InsertValueEntryAdditions(TextString: Text[50]; EntryType: Option Tax,"Contribution Per City","Net Wage","Additional Tax"," Sick Leave","Sick Leave-Fund",Reduction,Transport,VAT,"Meal to pay","Meal to refund",Untaxable,Use,Taxable,Regres; Amount: Decimal; "Contribution Code": Code[10]; var EntriesExist: Boolean; Basis: Decimal; EmpNo: Code[30]; DocNo: Code[30]; PDate: Date; PostingGroup: Code[20]; Type: Code[20]; Dimension: Code[20]; Apportionment: Boolean; DocumentDate: Date; Netto: Decimal; Brutto: Decimal)
    var
        ValueEntryNo: Integer;
        WLE: Record "Wage Ledger Entry";
        WageHeaderNo: Code[30];
        EntryNo: Integer;
        EmployeeCon: Record "Employee Contract Ledger";
    begin

        IF Amount = 0 THEN
            EXIT;
        ValueEntryNo := 100000000;

        IF WVE.FINDLAST THEN ValueEntryNo := WVE."Entry No." + 1 ELSE ValueEntryNo := 0;

        WVE.INIT;
        WVE."Entry No." := ValueEntryNo;
        WVE."Employee No." := EmpNo;
        EmployeeCon.Reset();
        EmployeeCon.SetFilter("Employee No.", '%1', empno);
        EmployeeCon.SetFilter("Starting Date", '<=%1', DocumentDate);
        EmployeeCon.SetCurrentKey("Starting Date");
        EmployeeCon.Ascending;
        if EmployeeCon.FindLast() then begin
            WVE.Sector := EmployeeCon."Sector Description";
            WVE."Department Category" := EmployeeCon."Department Cat. Description";
            WVE.Group := EmployeeCon."Group Description";

        end
        else begin
            WVE.Sector := '';
            WVE."Department Category" := '';
            WVE.Group := '';

        end;
        //Employee.GET(WLE."Employee No.");
        WVE."Document No." := DocNo;
        WVE."Wage Header Entry No." := EntryNo;
        WVE.Description := TextString;
        WVE."Wage Posting Group" := 'FBIH';
        WVE."Wage Ledger Entry No." := WLE."Entry No.";
        WVE."User ID" := USERID;
        WVE."Global Dimension 1 Code" := Dimension;
        WVE."Global Dimension 2 Code" := WLE."Global Dimension 2 Code";
        WVE."Shortcut Dimension 4 Code" := WLE."Shortcut Dimension 4 Code";
        WVE."Cost Amount (Actual)" := Amount;
        WVE."Document Date" := DocumentDate;
        WVE."Posting Date" := PDate;
        WVE."Wage Addition Type" := Type;
        WVE."Entry Type" := EntryType;
        WVE."Wage Calculation Type" := 4;
        WVE."Use Apportionment Account" := Apportionment;
        WVE."Contribution Type" := "Contribution Code";
        IF ATax.GET("Contribution Code") THEN BEGIN
            IF ATax."From Brutto" THEN
                WVE."AT From" := TRUE;
            IF ATax."Over Brutto" THEN
                WVE."AT From" := FALSE;
            IF ATax."Over Netto" THEN BEGIN
                WVE."AT From" := FALSE;
                WVE."AT From neto" := TRUE;
            END;
        END
        ELSE
            WVE."AT From" := FALSE;
        WVE."Post Code" := Employee."Post Code";
        WVE."Contribution Category Code" := PostingGroup;
        WVE.Basis := Basis;
        WVE."Contracted Work" := WLE."Contracted Work";
        WVE."Cost Amount (Netto)" := Netto;
        WVE."Cost Amount (Brutto)" := Brutto;

        if WVE."Entry Type" = WVE."Entry Type"::Tax then begin

            if Employee.get(WVE."Employee No.") then begin
                IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                    CompInfo.GET;
                    WVE."Tax Number" := CompInfo."Municipality Code";
                END
                ELSE BEGIN

                    WVE."Tax Number" := Employee."Municipality Code CIPS";
                END;
            end;
        end;
        WVE.INSERT;
        EntriesExist := TRUE;
    end;
}
