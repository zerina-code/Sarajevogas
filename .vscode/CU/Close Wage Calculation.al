codeunit 50004 "Close Wage Calculation"
{

    trigger OnRun()
    begin
    end;

    var
        WHeader: Record "Wage Header";
        CantonAmount: Decimal;
        AddTaxesPercentage: Decimal;
        WATax: Record "Wage Addition";
        Dijeljenje: decimal;
        IntegerValue: integer;
        RType: Code[10];
        BrojDana: integer;

        MunEntity: Record Municipality;
        //  OrgdijeloviRS: Record "Org Dijelovi";
        Orgdijelovi: Record "ORG Dijelovi";
        OrgJed: Record "ORG Dijelovi";
        //ĐK TCReport: Report "Employee Default Dimension";
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        CPE1: Record "Contribution Per Employee";
        TPE1: Record "Tax Per Employee";
        WVE1: Record "Wage Value Entry";
        DatumUplate: Date;
        RAmount: Decimal;

        BankNo: Integer;
        AdditionAmountForPaymentMeal: Decimal;
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        EA: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        WType: Integer;
        Tip: Integer;
        Sifra: Code[50];
        SOLIDAmount: Decimal;
        AmountOver: Decimal;
        TempAmountSpec: Decimal;
        AmountOverTemp: Decimal;
        TempAmountSpecTemp: Decimal;
        TempAmountSpecTemp2: Decimal;
        AmountOverRed: Decimal;
        Reduction: Record "Reduction per Wage";
        RedReal: Record "Reduction per Wage";
        RedTemp: Record "Reduction per Wage Temp";
        CalcReal: Record "Wage Calculation";
        CalcRealNeg: Record "Wage Calculation";
        CalcReal2: Record "Wage Calculation";
        CalcTemp: Record "Wage Calculation Temp";
        ATReal: Record "Contribution Per Employee";
        ATTemp: Record "Contribution Per Employee Temp";
        TaxReal: Record "Tax Per Employee";
        TaxTemp: Record "Tax Per Employee Temp";
        TransHeader: Record "Transport Header";
        TransLine: Record "Transport Line";
        TransLineTemp: Record "Transport Line Temp";
        MealHeader: Record "Meal Header";
        MealLine: Record "Meal Line";
        MealLineTemp: Record "Meal Line Temp";
        WVE: Record "Wage Value Entry";
        WLE: Record "Wage Ledger Entry";
        Employee: Record "Employee";
        ATax: Record "Contribution";
        RedMain: Record "Reduction";
        Rec: Record "Wage Header";
        Post: Record "Post Code";
        WageType: Record "Wage Type";
        RedMainFD: Record "Reduction";
        RedLineFD: Record "Reduction per Wage";
        RedType: Record "Reduction types";
        WageAddition: record "Wage Addition";
        AF: Codeunit "Absence Fill";
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        ValueEntryNo: Integer;
        LedgerEntryNo: Integer;
        PostingDate: Date;
        ValueEntriesExist: Boolean;
        Desc: Text[50];
        PostingGroup: Code[10];
        RedLockFlag: Boolean;
        ____VIRMANI: Integer;
        SvrhaDoznake1: Text[150];
        SvrhaDoznake2: Text[50];
        SvrhaDoznake3: Text[50];
        Primalac1: Text[50];
        Primalac2: Text[50];
        Primalac3: Text[50];

        BudgetOrg: Text[100];
        RacunPosiljaoca: Text[16];
        RacunPrimaoca: Text[20];
        Iznos: Decimal;
        BrojPoreznogObaveznika: Text[14];
        VrstaPrihoda: Text[6];
        Opstina: Text[6];
        PozivNaBroj: Text[10];
        PorezniPeriodOd: Date;
        PorezniPeriodDo: Date;
        CompanyInfo: Record "Company Information";
        BankAccount: Record "Bank Account";
        BankCode: Code[20];
        WHeaderNo: Code[20];
        WHeaderEntryNo: Integer;
        WPaymentType: Option " ",Wage,"Add. Tax",Tax,Reduction,Chamber;
        CompInfo: Record "Company Information";
        BankAccounts: Record "Bank Account";
        POrders: Record "Payment Order";
        WithConfirm: Boolean;
        Txt001: Label 'Are you sure you wish to close this calculation?';
        Txt002: Label 'Program code is not defined for wage type for employee %1!';
        Txt006: Label 'Are you sure you wish to return to previous step?';
        Txt003: Label 'Wage Calculation %1 from %2-%3 for %4';
        Txt004: Label '%1 for %2, W.C.%3';
        Txt005: Label 'Wage Calculation is now closed';
        NoTest: Code[10];
        Temp: Record "Wage Calculation";
        i: Integer;
        Contribution: Text[150];
        Txt0061: Label 'Payment orders are prepared.';
        Txt007: Label 'Closing wage (1/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt008: Label 'Closing wage (2/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt009: Label 'Closing wage (3/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt010: Label 'Closing wage (4/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt011: Label 'Closing wage (5/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt012: Label 'Closing wage (6/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt013: Label 'Closing wage (7/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt014: Label 'Calculatin for chosen period already exists!';
        Txt015: Label 'Payment orders are printed for this calculation!';
        Emp: Record "Employee";
        WC: Record "Wage Calculation Temp";
        RegresAmount: Decimal;
        WageAdditionTaxable: record "Wage Addition";
        OrgDio: Code[10];
        Department: Record "Department";
        //ĐK    POrdersbyBO: Record "Payment Order by Branch Office";
        M: Record "Municipality";
        BranchOfficeCode: Text;
        OD: Record "ORG Dijelovi";
        WA: record "Wage Addition";
        WageAdditionAmount: Decimal;
        Absence: Record "Employee Absence";
        AbCount: Integer;
        CodeArray: array[100] of Code[10];
        TotalArray: array[100] of Decimal;
        Found: Boolean;
        J: Integer;
        Description: Text[50];
        Quantity: Decimal;
        AbType: Record "Cause of Absence";
        Value: Decimal;
        HourWage: Decimal;
        Class: Record "Tax Class";
        Additions: Decimal;
        ConCat: Record "Contribution Category";
        AbsenceOld: Record "Employee Absence";
        AbCountOld: Integer;
        CodeArrayOld: array[100] of Code[10];
        TotalArrayOld: array[100] of Decimal;
        FoundOld: Boolean;
        JOld: Integer;
        DescriptionOld: Text[50];
        QuantityOld: Decimal;
        AbTypeOld: Record "Cause of Absence";
        ValueOld: Decimal;
        TempAmountSpec2: Decimal;
        FundAmountTemp: Decimal;
        FundAmount: Decimal;
        EmpT: Record "Employee";
        DescOld: Text[250];
        CauseOfAbs: Record "Cause of Absence";
        WVETemp: Record "Wage Value Entry" temporary;
        Absence2: Record "Employee Absence";
        EntryNew: Integer;
        Postoji: Boolean;
        ReductionsAmount: Decimal;
        TaxAmount: Decimal;
        Difference: Decimal;

    procedure ResetTables()
    begin
        RedReal.RESET;
        CalcReal.RESET;
        ATReal.RESET;
        TaxReal.RESET;
        TransHeader.RESET;
        TransLine.RESET;
        MealHeader.RESET;
        MealLine.RESET;
        CalcTemp.RESET;
        RedTemp.RESET;
        ATTemp.RESET;
        TaxTemp.RESET;
        TransLineTemp.RESET;
        MealLineTemp.RESET;
        WLE.RESET;
        WVE.RESET;
        Employee.RESET;
        WHeader.RESET;
    end;

    procedure FillLedger()
    var
        EmplDefDim: Record "Employee Default Dimension";
        GLSetup: Record "General Ledger Setup";
        Absences: Record "Employee Absence";
        COA: Record "Cause of Absence";
        WorkDays: array[31] of Boolean;
        WorkDaysNo: Integer;
        TotalSati: decimal;
        MealHours: Decimal;
        CTHours: Decimal;
        AddPart: decimal;

    begin
        IF ValueEntryNo = 0 THEN BEGIN
            WVE.LOCKTABLE;
            IF WVE.FIND('+') THEN
                ValueEntryNo := WVE."Entry No.";
        END;
        IF LedgerEntryNo = 0 THEN BEGIN
            WLE.LOCKTABLE;
            IF WLE.FIND('+') THEN
                LedgerEntryNo := WLE."Entry No.";
        END;
        IF PostingDate = 0D THEN
            PostingDate := AF.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", FALSE);


        CalcTemp.SETRANGE("Wage Header No.", Rec."No.");
        CalcTemp.SETRANGE("Entry No.", Rec."Entry No.");






        Window.OPEN('Obrada obračuna plata\@1@@@@@@@@@@@@@@@@@@@@@  ::Radnici\');
        Window.UPDATE(1, 0);

        CurrRecNo := 0;
        TotalRecNo := CalcTemp.COUNTAPPROX;

        IF CalcTemp.FINDFIRST THEN
            REPEAT
                AddPart := 0;
                IF NOT WHeader.GET(CalcTemp."Wage Header No.") THEN EXIT;
                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                /*WLE.SETFILTER("Document No.", Rec."No.");
                WLE.SETFILTER("Employee No.", CalcTemp."Employee No.");*/

                Employee.GET(CalcTemp."Employee No.");
                Post.GET(Employee."Post Code CIPS", Employee."City CIPS");

                PostingGroup := Employee."Wage Posting Group";

                //IF NOT WLE.FINDFIRST THEN
                BEGIN
                    LedgerEntryNo := LedgerEntryNo + 1;
                    Employee.TESTFIELD("Wage Posting Group");
                    Employee.TESTFIELD("Post Code CIPS");



                    WLE.INIT;
                    WLE."Entry No." := LedgerEntryNo;
                    WLE."Wage Header Entry No." := Rec."Entry No.";
                    WLE."Employee No." := CalcTemp."Employee No.";
                    WLE."Document No." := Rec."No.";
                    WLE.Description := COPYSTR(STRSUBSTNO(Txt003, Rec."No.", Rec."Month Of Wage", Rec."Year Of Wage",
                                         Employee."No."), 1, MAXSTRLEN(WLE.Description));
                    WLE.Open := TRUE;
                    WLE."Global Dimension 1 Code" := CalcTemp."Global Dimension 1 Code";
                    WLE."Global Dimension 2 Code" := CalcTemp."Global Dimension 2 Code";
                    // WLE."Shortcut Dimension 4 Code":=CalcTemp."Shortcut Dimension 4 Code";
                    WLE."Document Date" := Rec."Date Of Calculation";
                    WLE."Posting Date" := PostingDate;
                    WLE."No. Series" := '';
                    WLE."Month Of Calculation" := Rec."Month of Calculation";
                    WLE."Year Of Calculation" := Rec."Year of Calculation";
                    WLE."Month Of Wage" := Rec."Month Of Wage";
                    WLE."Year Of Wage" := Rec."Year Of Wage";



                    WageType.GET(Employee."Wage Type");
                    WLE."Wage Type" := WageType.Code;
                    WLE."Contracted Work" := WageType.Contract;

                    WLE.INSERT;
                END;


                ValueEntriesExist := FALSE;

                /****************************************Tax*******************************************************/


                Desc := COPYSTR(STRSUBSTNO('Porez'), 1, MAXSTRLEN(Desc));
                IF Rec."Wage Calculation Type" = 0 THEN BEGIN
                    IF ((CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::Tax, ROUND(CalcTemp.Tax, 0.00001, '='), '',
                            ValueEntriesExist, CalcTemp."Tax Basis", 0, ROUND(CalcTemp.Tax, 0.00001, '='), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                    ELSE
                        InsertValueEntry(Desc, WVE."Entry Type"::Tax, ROUND(CalcTemp.Tax, 0.00001, '='), '',
                        ValueEntriesExist, CalcTemp."Tax Basis", 0, ROUND(CalcTemp.Tax, 0.00001, '='), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");

                    /****************************************Netto by Absence*******************************************************/
                    Absence.RESET;
                    AbCount := 0;
                    Absence.SETRANGE("Employee No.", CalcTemp."Employee No.");
                    StartDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", TRUE);
                    EndDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", FALSE);
                    Absence.SETRANGE("From Date", StartDate, EndDate);
                    //Absence.SETRANGE("Wage Header No.", CalcTemp."Wage Header No.");
                    Absence.SETFILTER("Old Wage Base", '%1', FALSE);
                    Absence.SETFILTER("RS Code", '<>%1', '00');
                    IF Absence.FIND('-') THEN
                        REPEAT
                            Found := FALSE;
                            IF AbCount > 0 THEN
                                FOR J := 1 TO AbCount DO
                                    IF CodeArray[J] = Absence."Cause of Absence Code" THEN BEGIN
                                        TotalArray[J] := TotalArray[J] + Absence.Quantity;
                                        Found := TRUE;
                                    END;


                            IF NOT Found THEN BEGIN
                                AbCount := AbCount + 1;
                                CodeArray[AbCount] := Absence."Cause of Absence Code";
                                TotalArray[AbCount] := Absence.Quantity;
                            END;
                        UNTIL Absence.NEXT = 0;


                    IF AbCount > 0 THEN BEGIN
                        Value := 0;
                        FOR J := 1 TO AbCount DO BEGIN
                            AbType.GET(CodeArray[J]);
                            Value := Value + TotalArray[J] * AbType.Coefficient;
                            Quantity := TotalArray[J];


                            /****************************************Netto by Absence*******************************************************/
                            //NK    InsertValueEntry(Desc,WVE."Entry Type"::"Net Wage",CalcTemp."Net Wage After Tax",'',ValueEntriesExist,0);
                            CalcTemp.CALCFIELDS("Use Netto");
                            Class.RESET;
                            Class.SETCURRENTKEY("Valid From Amount");
                            Class.SETRANGE(Active, TRUE);
                            CompInfo.GET;
                            Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                            Class.FINDFIRST;
                            WageSetup.GET;
                            ConCat.SETFILTER(Code, '%1', CalcTemp."Contribution Category Code");
                            Desc := COPYSTR(STRSUBSTNO(AbType."Short Code"), 1, MAXSTRLEN(Desc));

                            IF ConCat.FINDFIRST THEN BEGIN
                                ConCat.CALCFIELDS("From Brutto");

                                IF AbType."Short Code" <> '423' THEN BEGIN

                                    if (AbType."Sick Leave" = true) then begin

                                        if (AbType."Sick Leave Paid By Company" = true) then begin
                                            IF ((CalcTemp.Status.AsInteger() = 3) OR (NOT (Employee."Contact Center") AND (CalcTemp."Individual Hour Pool" > CalcTemp."Hour Pool")) OR ((Employee."Employment Date" > StartDate))) THEN
                                                InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND(((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient)
                                                - ((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') - (CalcTemp.Tax * ROUND(((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool")
                                               * Quantity * AbType.Coefficient)
                                                - ((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') / CalcTemp."Sick Leave Brutto"), 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                                ROUND((ROUND((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity)
                                                - ((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity) * (ConCat."From Brutto" / 100)), 0.00001, '=') * AbType.Coefficient), 0.00001, '='),
                                                 ROUND(((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient)), 0.00001, '='), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                                            ELSE
                                                InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                               - ((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') -
                                              (CalcTemp.Tax * ROUND((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                               - ((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') / CalcTemp."Net Wage")
                                               , 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                               ROUND(ROUND((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                               - ((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '='), 0.00001, '='),
                                              ROUND(((((CalcTemp."Sick Leave Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)), 0.00001, '='), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                        end else begin
                                            //umanji za iznos od neto
                                            WageSetup.Get();
                                            CompInfo.get();
                                            Class.RESET;
                                            Class.SETCURRENTKEY("Valid From Amount");
                                            Class.SETRANGE(Active, TRUE);
                                            Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                                            Class.FINDFIRST;
                                            GetAddTaxesPercentage(AddTaxesPercentage);
                                            CantonAmount := (WageSetup."Canton Amount" / ((1 - Class.Percentage / 100))) * (1 / ((1 - AddTaxesPercentage / 100)));
                                            IF ((CalcTemp.Status.AsInteger() = 3) OR (NOT (Employee."Contact Center") AND (CalcTemp."Individual Hour Pool" > CalcTemp."Hour Pool")) OR ((Employee."Employment Date" > StartDate))) THEN
                                                InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND(((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient)
                                                - ((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') - (CalcTemp.Tax * ROUND(((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool")
                                               * Quantity * AbType.Coefficient)
                                                - ((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') / CalcTemp."Sick Leave Brutto" - CantonAmount), 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                                ROUND((ROUND((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity)
                                                - ((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity) * (ConCat."From Brutto" / 100)), 0.00001, '=') * AbType.Coefficient), 0.00001, '='),
                                                 ROUND(((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient)), 0.00001, '='), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                                            ELSE
                                                InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                               - ((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') -
                                              (CalcTemp.Tax * ROUND((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                               - ((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') / CalcTemp."Net Wage")
                                               , 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                               ROUND(ROUND((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                               - ((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '='), 0.00001, '='),
                                              ROUND(((((CalcTemp."Sick Leave Brutto" - CantonAmount + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)), 0.00001, '='), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");

                                        end;

                                    end
                                    else begin
                                        IF ((CalcTemp.Status.AsInteger() = 3) OR (NOT (Employee."Contact Center") AND (CalcTemp."Individual Hour Pool" > CalcTemp."Hour Pool")) OR ((Employee."Employment Date" > StartDate))) THEN
                                            InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND(((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient)
                                            - ((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') - (CalcTemp.Tax * ROUND(((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool")
                                           * Quantity * AbType.Coefficient)
                                            - ((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                            ROUND((ROUND((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity)
                                            - ((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity) * (ConCat."From Brutto" / 100)), 0.00001, '=') * AbType.Coefficient), 0.00001, '='),
                                             ROUND(((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * Quantity * AbType.Coefficient)), 0.00001, '='), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                                        ELSE
                                            InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                           - ((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') -
                                          (CalcTemp.Tax * ROUND((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                           - ((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') / CalcTemp."Net Wage")
                                           , 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                           ROUND(ROUND((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)
                                           - ((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '='), 0.00001, '='),
                                          ROUND(((((CalcTemp."Wage (Base)" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * Quantity * AbType.Coefficient)), 0.00001, '='), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                        // -ROUND((((CalcTemp."Wage (Base)"+CalcTemp."Unpaid Absence")/CalcTemp."Individual Hour Pool")*Quantity*AbType.Coefficient)*(ConCat."From Brutto"/100),0.00001,'='))/(1-ConCat."From Brutto"/100) ,0.00001,'='));}
                                        //END;
                                    end;
                                END

                                ELSE BEGIN

                                    InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", ROUND(ROUND((WageSetup."Canton Sick-Leave Amount" * Quantity), 0.00001, '=')
                                    - (CalcTemp.Tax * ROUND((WageSetup."Canton Sick-Leave Amount" * Quantity), 0.00001, '=') / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, Quantity,
                                   ROUND((WageSetup."Canton Sick-Leave Amount" * Quantity), 0.00001, '='),
                                  ROUND((WageSetup."Canton Sick-Leave Amount" * Quantity), 0.00001, '=') / (1 - ConCat."From Brutto" / 100), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                END;
                            END;
                        END;
                        J += 1;
                    END;

                    /****************************************************Netto Old***************************************************/
                    AbsenceOld.RESET;
                    AbCountOld := 0;
                    AbsenceOld.SETRANGE("Employee No.", CalcTemp."Employee No.");
                    StartDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", TRUE);
                    EndDate := AbsenceFill.GetMonthRange(CalcTemp."Month Of Wage", CalcTemp."Year Of Wage", FALSE);
                    AbsenceOld.SETRANGE("From Date", StartDate, EndDate);
                    AbsenceOld.SETFILTER("Old Wage Base", '%1', TRUE);
                    AbsenceOld.SETFILTER("RS Code", '<>%1', '00');
                    IF AbsenceOld.FIND('-') THEN
                        REPEAT
                            FoundOld := FALSE;
                            IF AbCountOld > 0 THEN
                                FOR JOld := 1 TO AbCountOld DO
                                    IF CodeArrayOld[JOld] = AbsenceOld."Cause of Absence Code" THEN BEGIN
                                        TotalArrayOld[JOld] := TotalArrayOld[JOld] + AbsenceOld.Quantity;
                                        FoundOld := TRUE;
                                    END;


                            IF NOT FoundOld THEN BEGIN
                                AbCountOld := AbCountOld + 1;
                                CodeArrayOld[AbCountOld] := AbsenceOld."Cause of Absence Code";
                                TotalArrayOld[AbCountOld] := AbsenceOld.Quantity;
                            END;
                        UNTIL AbsenceOld.NEXT = 0;

                    IF AbCountOld > 0 THEN BEGIN
                        ValueOld := 0;
                        FOR JOld := 1 TO AbCountOld DO BEGIN
                            AbTypeOld.GET(CodeArrayOld[JOld]);
                            ValueOld := ValueOld + TotalArrayOld[JOld] * AbTypeOld.Coefficient;
                            QuantityOld := TotalArrayOld[JOld];
                            DescOld := COPYSTR(STRSUBSTNO(AbTypeOld."Short Code"), 1, MAXSTRLEN(DescOld));


                            CalcTemp.CALCFIELDS("Use Netto");
                            Class.RESET;
                            Class.SETCURRENTKEY("Valid From Amount");
                            Class.SETRANGE(Active, TRUE);
                            CompInfo.GET;
                            Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                            Class.FINDFIRST;
                            WageSetup.GET;
                            ConCat.SETFILTER(Code, '%1', CalcTemp."Contribution Category Code");
                            IF ConCat.FINDFIRST THEN BEGIN
                                ConCat.CALCFIELDS("From Brutto");

                                IF AbTypeOld."Short Code" <> '423' THEN BEGIN
                                    IF ((CalcTemp.Status.AsInteger() = 3) OR (NOT (Employee."Contact Center") AND (CalcTemp."Individual Hour Pool" > CalcTemp."Hour Pool")) OR ((Employee."Employment Date" > StartDate))) THEN
                                        InsertValueEntry(DescOld, WVE."Entry Type"::"Net Wage", ROUND(ROUND(((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * QuantityOld * AbTypeOld.Coefficient)
                                        - ((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * QuantityOld * AbTypeOld.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') - (CalcTemp.Tax * ROUND(((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool")
                                        * QuantityOld * AbTypeOld.Coefficient)
                                        - ((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * QuantityOld * AbTypeOld.Coefficient) * (ConCat."From Brutto" / 100))), 0.00001, '=') / CalcTemp."Net Wage")
                                        , 0.00001, '='), '', ValueEntriesExist, 0, QuantityOld,
                                        ROUND((ROUND((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * QuantityOld * AbTypeOld.Coefficient)
                                        - ((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Hour Pool") * QuantityOld * AbTypeOld.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=')), 0.00001, '='),
                                         (ROUND((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient), 0.00001, '=')), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                                    ELSE
                                        InsertValueEntry(DescOld, WVE."Entry Type"::"Net Wage", ROUND(ROUND((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient)
                                       - ((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') - (CalcTemp.Tax * ROUND((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence")
                                       / CalcTemp."Individual Hour Pool")
                                       * QuantityOld * AbTypeOld.Coefficient)
                                       - ((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '=') / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, QuantityOld,
                                       ROUND(ROUND((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient)
                                       - ((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient) * (ConCat."From Brutto" / 100)), 0.00001, '='), 0.00001, '='),
                                      (ROUND((((CalcTemp."Old Brutto" + CalcTemp."Unpaid Absence") / CalcTemp."Individual Hour Pool") * QuantityOld * AbTypeOld.Coefficient), 0.00001, '=')), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                    //END;
                                END

                                ELSE BEGIN

                                    InsertValueEntry(DescOld, WVE."Entry Type"::"Net Wage", ROUND(ROUND((WageSetup."Canton Sick-Leave Amount" * QuantityOld), 0.00001, '=') - (CalcTemp.Tax * ROUND((WageSetup."Canton Sick-Leave Amount" * QuantityOld), 0.00001, '=') / CalcTemp."Net Wage"), 0.00001, '='),
                                    '', ValueEntriesExist, 0, QuantityOld,
                                   ROUND((WageSetup."Canton Sick-Leave Amount" * QuantityOld), 0.00001, '='),
                                  ROUND((WageSetup."Canton Sick-Leave Amount" * QuantityOld), 0.00001, '=') / (1 - ConCat."From Brutto" / 100), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                END;
                            END;
                        END;
                        JOld += 1;
                    END;
                END;
                /****************************************UnTaxable Meal*******************************************************/
                WageSetup.RESET;
                WageSetup.GET;
                IF Employee."Contribution Category Code" = 'FBIH' THEN
                    Desc := COPYSTR(STRSUBSTNO(WageSetup."Meal Code FBIH"), 1, MAXSTRLEN(Desc));
                IF Employee."Contribution Category Code" = 'FBIHRS' THEN
                    Desc := COPYSTR(STRSUBSTNO(WageSetup."Meal Code FBIH"), 1, MAXSTRLEN(Desc));
                IF Employee."Contribution Category Code" = 'BDPIOFBIH' THEN
                    Desc := COPYSTR(STRSUBSTNO(WageSetup."Meal Code BD Untaxable"), 1, MAXSTRLEN(Desc));
                IF Employee."Contribution Category Code" = 'BDPIORS' THEN
                    Desc := COPYSTR(STRSUBSTNO(WageSetup."Meal Code BD Untaxable"), 1, MAXSTRLEN(Desc));
                IF Employee."Contribution Category Code" = 'RS' THEN
                    Desc := COPYSTR(STRSUBSTNO(WageSetup."Meal Code RS"), 1, MAXSTRLEN(Desc));
                //Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Topli Obrok za isplatu', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));

                //NK ELSE
                //NK InsertValueEntry(Desc,WVE."Entry Type"::"Net Wage",CalcTemp."Meal to pay",'',ValueEntriesExist,0);

                Absences.RESET;
                Absences.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date", "To Date");
                Absences.SETFILTER("Employee No.", Employee."No.");
                Absences.SETFILTER("From Date", '>=%1', StartDate);
                Absences.SETFILTER("To Date", '<=%1', EndDate);
                CLEAR(WorkDays);

                //Full day meal:
                WorkDaysNo := 0;
                TotalSati := 0;
                CTHours := 0;
                MealHours := 0;

                COA.RESET;
                COA.SETRANGE("Meal Calculated", TRUE);
                IF COA.FINDFIRST THEN
                    REPEAT
                        Absences.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                        Absences.SETFILTER(Quantity, '>0');
                        IF Absences.FINDFIRST THEN
                            REPEAT
                                /* IF NOT WorkDays[DATE2DMY(Absences."From Date",1)] THEN BEGIN
                                  WorkDays[DATE2DMY(Absences."From Date",1)] := TRUE;
                                  WorkDaysNo += 1;
                                 END;*/


                                //           IF NOT WorkDays[DATE2DMY(Absences."From Date", 1)] THEN BEGIN
                                //            WorkDays[DATE2DMY(Absences."From Date", 1)] := TRUE;

                                //demka


                                TotalSati += Absences.quantity;

                                Dijeljenje := TotalSati / Employee."Hours in day";

                                IF EVALUATE(IntegerValue, FORMAT(Dijeljenje, 0, '<Integer,12><Filler Character,0>')) THEN
                                    BrojDana := IntegerValue;

                                if TotalSati - Employee."Hours in day" >= 0 then begin
                                    TotalSati := TotalSati - (BrojDana * Employee."Hours in day");


                                    IF (COA."Meal - Hours" = TRUE) AND (Absences.Quantity < 5) THEN
                                        WorkDaysNo += 0
                                    ELSE
                                        WorkDaysNo += BrojDana * 1;


                                end
                                else begin
                                    if TotalSati > 0 then begin
                                        AddPart := TotalSati;
                                    end;

                                end;
                                //      END;




                                CTHours += Absences.Quantity;
                            UNTIL Absences.NEXT = 0;
                    UNTIL COA.NEXT = 0;


                IF Employee."Contact Center" THEN
                    MealHours := CTHours
                ELSE
                    MealHours := AddPart + WorkDaysNo * Employee."Hours In Day";

                IF ((CalcTemp."Wage Calculation Type" <> 4) AND (WHeader."Wage Calculation Type" = WHeader."Wage Calculation Type"::Normal)) THEN BEGIN
                    IF ((CalcTemp."Contribution Category Code" <> 'FBIH') AND (CalcTemp."Contribution Category Code" <> 'BDPIOFBIH') AND (CalcTemp."Contribution Category Code" <> 'BDPIORS') AND (CalcTemp."Contribution Category Code" <> 'FBIHRS')) THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", ROUND(CalcTemp."Meal to pay" - (CalcTemp.Tax * CalcTemp."Meal to pay" / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, MealHours, CalcTemp."Meal to pay"
                        , CalcTemp."Brutto Meal", CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                    ELSE
                        InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", CalcTemp."Meal to pay", '', ValueEntriesExist, 0, MealHours, CalcTemp."Meal to pay"
                        , CalcTemp."Brutto Meal", CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                    /*Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Topli Obrok za refundaciju', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                    InsertValueEntry(Desc,WVE."Entry Type"::"Meal to refund",CalcTemp."Meal to refund",'',ValueEntriesExist,0,0);*/
                END;
                /****************************************Transport*******************************************************/
                WageSetup.RESET;
                WageSetup.GET;
                Desc := COPYSTR(STRSUBSTNO(WageSetup."Transport Code"), 1, MAXSTRLEN(Desc));
                //Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Prijevoz', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                IF ((CalcTemp."Wage Calculation Type" <> 4) AND (WHeader."Wage Calculation Type" = WHeader."Wage Calculation Type"::Normal)) THEN BEGIN
                    IF ((CalcTemp."Contribution Category Code" <> 'BDPIOFBIH2') AND (CalcTemp."Contribution Category Code" <> 'BDPIORS2')) THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::Transport, CalcTemp.Transport, '', ValueEntriesExist, 0, 0, CalcTemp.Transport, 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                END;
                /****************************************Work Experience*******************************************************/
                WageSetup.RESET;
                WageSetup.GET;
                ConCat.RESET;
                ConCat.SETFILTER(Code, '%1', CalcTemp."Contribution Category Code");
                IF ConCat.FINDFIRST THEN BEGIN
                    ConCat.CALCFIELDS("From Brutto");
                    Desc := COPYSTR(STRSUBSTNO(WageSetup."Work Experience Code"), 1, MAXSTRLEN(Desc));
                    IF ((CalcTemp."Wage Calculation Type" <> 4) AND (WHeader."Wage Calculation Type" = WHeader."Wage Calculation Type"::Normal)) THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::"Work Experience", ROUND(CalcTemp."Experience Total" - (CalcTemp.Tax * (CalcTemp."Experience Total" / CalcTemp."Net Wage")), 0.00001, '='), '', ValueEntriesExist, 0, 0,
                        ROUND(CalcTemp."Experience Total", 0.00001, '='), CalcTemp."Experience Total" / (1 - ConCat."From Brutto" / 100), CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                END;
                /****************************************Contribution*******************************************************/
                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", WLE."Employee No.");
                ATTemp.SETFILTER("Wage Header No.", Rec."No.");
                ATTemp.SETRANGE("Entry No.", Rec."Entry No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", CalcTemp."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", CalcTemp."Global Dimension 2 Code");
                //ATTemp.SETRANGE("Shortcut Dimension 4 Code", CalcTemp."Shortcut Dimension 4 Code");

                ATTemp.SETFILTER("Amount From Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(ATax."Short Code"), 1, MAXSTRLEN(Desc));
                        IF ((CalcTemp."Contribution Category Code" = 'FBIHRS2')) THEN BEGIN
                            WageSetup.GET;


                            IF ((ATax.Code = 'D-NEZAP-IZ')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Unemployment Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Unemployment Federation" / 100), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code"
                                                 , CalcTemp."Department Name");

                            IF ((ATax.Code = 'D-ZDRAV-IZ')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Health Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Health Federation" / 100), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code"
                                                 , CalcTemp."Department Name");

                            IF ((ATax.Code = 'D-PIO-NA') OR (ATax.Code = 'D-PIO-IZ')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                        ATTemp."Amount From Wage", ATax.Code,
                                                        ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Amount From Wage", 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                        END
                        ELSE BEGIN
                            InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                             ATTemp."Amount From Wage", ATax.Code,
                                             ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Amount From Wage", 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                        END;
                    UNTIL ATTemp.NEXT = 0;
                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", Employee."No.");
                ATTemp.SETFILTER("Wage Header No.", Rec."No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", CalcTemp."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", CalcTemp."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", CalcTemp."Shortcut Dimension 4 Code");

                ATTemp.SETRANGE("Entry No.", Rec."Entry No.");
                ATTemp.SETFILTER("Amount Over Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(ATax."Short Code"), 1, MAXSTRLEN(Desc));
                        IF ((CalcTemp."Contribution Category Code" = 'FBIHRS2')) THEN BEGIN
                            WageSetup.GET;
                            IF ((ATax.Code = 'D-NEZAP-NA')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Unemployment Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Unemployment Federation" / 100), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code"
                                                 , CalcTemp."Department Name");
                            IF ((ATax.Code = 'D-ZDRAV-NA')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Health Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Health Federation" / 100), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code"
                                                 , CalcTemp."Department Name");

                            IF ((ATax.Code = 'D-PIO-NA')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                        ATTemp."Amount Over Wage", ATax.Code,
                                                        ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Amount Over Wage", 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")

                        END
                        ELSE BEGIN
                            //NK2005  IF ((CalcTemp."Contribution Category Code"<>'FBIHRS') ) THEN
                            InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                             ATTemp."Amount Over Wage", ATax.Code,
                                             ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Amount Over Wage", 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                        END;
                    UNTIL ATTemp.NEXT = 0;

                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", Employee."No.");
                ATTemp.SETFILTER("Wage Header No.", Rec."No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", CalcTemp."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", CalcTemp."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", CalcTemp."Shortcut Dimension 4 Code");

                ATTemp.SETRANGE("Entry No.", Rec."Entry No.");
                ATTemp.SETFILTER("Amount Over Neto", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT

                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(ATax."Short Code"), 1, MAXSTRLEN(Desc));



                        //NK2005IF ((CalcTemp."Contribution Category Code"<>'FBIHRS')) THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                         ATTemp."Amount Over Neto", ATax.Code,
                                         ValueEntriesExist, ATTemp.Basis, 0, ATTemp."Amount Over Neto", 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                    UNTIL ATTemp.NEXT = 0;

                /****************************************Reduction*******************************************************/
                RedTemp.RESET;
                RedTemp.SETFILTER("Wage Header No.", Rec."No.");
                RedTemp.SETFILTER("Employee No.", CalcTemp."Employee No.");

                GLSetup.GET;

                EmplDefDim.RESET;
                EmplDefDim.SETRANGE("No.", Employee."No.");
                EmplDefDim.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
                EmplDefDim.SETRANGE("Dimension Value Code", CalcTemp."Global Dimension 1 Code");
                EmplDefDim.FINDFIRST;

                IF RedTemp.FINDFIRST THEN
                    REPEAT
                        RedMain.GET(RedTemp."Reduction No.");
                        // Desc:= COPYSTR(STRSUBSTNO(Txt004, RedMain.Description, WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                        Desc := COPYSTR(STRSUBSTNO(RedMain.Type), 1, MAXSTRLEN(Desc));
                        IF ((CalcTemp."Wage Calculation Type" <> 4) AND (WHeader."Wage Calculation Type" = WHeader."Wage Calculation Type"::Normal)) THEN BEGIN
                            InsertValueEntry(Desc, WVE."Entry Type"::Reduction, ROUND(RedTemp.Amount * EmplDefDim."Amount Distribution Coeff.", 0.00001, '=')
                                             , '', ValueEntriesExist, 0, 0, ROUND(RedTemp.Amount * EmplDefDim."Amount Distribution Coeff.", 0.00001, '='), 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                        END;
                    UNTIL RedTemp.NEXT = 0;

                WageAddition.RESET;
                WageAddition.SETRANGE("Wage Header No.", Rec."No.");
                WageAddition.SETRANGE("Wage Header Entry No.", Rec."Entry No.");
                WageAddition.SETRANGE("Employee No.", CalcTemp."Employee No.");
                WageAddition.SETRANGE(Calculated, FALSE);
                WageAddition.SETRANGE(Taxable, FALSE);
                IF WageAddition.FINDFIRST THEN
                    REPEAT
                        IF NOT WageAddition.Meal THEN
                            Desc := COPYSTR(STRSUBSTNO(WageAddition."Wage Addition Type"), 1, MAXSTRLEN(Desc))
                        ELSE
                            Desc := COPYSTR(STRSUBSTNO(WageAddition."Wage Addition Type"), 1, MAXSTRLEN(Desc));
                        IF NOT WageAddition.Meal THEN
                            InsertValueEntry(Desc, WVE."Entry Type"::Untaxable, WageAddition."Calculated Amount", '', ValueEntriesExist, 0, 0, WageAddition."Calculated Amount", 0, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                        ELSE
                            InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", WageAddition."Calculated Amount", '', ValueEntriesExist, 0, WageAddition."No. Of Hours", WageAddition."Calculated Amount", WageAddition."Calculated Amount Brutto"
                            , CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                    UNTIL WageAddition.NEXT = 0;

                /****************************************Wage Addition Taxable*******************************************************/
                WageAdditionTaxable.RESET;
                WageAdditionTaxable.SETRANGE("Wage Header No.", Rec."No.");
                WageAdditionTaxable.SETRANGE("Wage Header Entry No.", Rec."Entry No.");
                WageAdditionTaxable.SETRANGE("Employee No.", CalcTemp."Employee No.");
                //WageAdditionTaxable.SETRANGE(Use,FALSE);
                WageAdditionTaxable.SETRANGE(Calculated, FALSE);
                WageAdditionTaxable.SETRANGE(Taxable, TRUE);
                IF WageAdditionTaxable.FINDFIRST THEN
                    REPEAT
                        //  Desc:= COPYSTR(STRSUBSTNO(Txt004, WageAdditionTaxable."Wage Addition Type", WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                        Desc := COPYSTR(STRSUBSTNO(WageAdditionTaxable."Wage Addition Type"), 1, MAXSTRLEN(Desc));
                        IF Rec."Wage Calculation Type" = 0 THEN BEGIN
                            IF ((NOT WageAdditionTaxable.Regres) AND (NOT WageAdditionTaxable.Meal) AND (NOT WageAdditionTaxable.Use)) THEN BEGIN
                                InsertValueEntry(Desc, WVE."Entry Type"::Taxable, ROUND(WageAdditionTaxable."Calculated Amount" - (CalcTemp.Tax * WageAdditionTaxable."Calculated Amount" / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, WageAdditionTaxable."No. Of Hours",
                                ROUND(WageAdditionTaxable."Calculated Amount", 0.00001, '='), WageAdditionTaxable.Brutto, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                WageAdditionTaxable.Tax := WageAdditionTaxable.Amount - (WageAdditionTaxable."Calculated Amount" - (CalcTemp.Tax * WageAdditionTaxable."Calculated Amount" / CalcTemp."Net Wage"));
                                WageAdditionTaxable.MODIFY(TRUE);
                            END;
                        END
                        ELSE BEGIN
                            IF ((NOT WageAdditionTaxable.Regres) AND (NOT WageAdditionTaxable.Meal) AND (NOT WageAdditionTaxable.Use)) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Taxable, WageAdditionTaxable."Calculated Amount", '', ValueEntriesExist, 0, WageAdditionTaxable."No. Of Hours",
                                WageAdditionTaxable."Calculated Amount", WageAdditionTaxable.Brutto, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");


                        END;
                        IF Rec."Wage Calculation Type" = 0 THEN BEGIN
                            IF WageAdditionTaxable.Regres THEN BEGIN
                                InsertValueEntry(Desc, WVE."Entry Type"::Taxable, ROUND(WageAdditionTaxable.Amount - (CalcTemp.Tax * WageAdditionTaxable.Amount / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, 0,
                                ROUND(WageAdditionTaxable."Calculated Amount", 0.00001, '='), WageAdditionTaxable.Brutto
                                , CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");
                                CalcTemp.CALCFIELDS("Use Netto");
                                WageAdditionTaxable.Tax := WageAdditionTaxable.Amount - (WageAdditionTaxable.Amount - (CalcTemp.Tax * WageAdditionTaxable.Amount / CalcTemp."Net Wage"));
                                WageAdditionTaxable.MODIFY(TRUE);
                            END;
                        END;

                        IF Rec."Wage Calculation Type" = 0 THEN BEGIN
                            IF WageAdditionTaxable.Use THEN BEGIN
                                IF (WageAdditionTaxable.Amount - ((WageAdditionTaxable.Amount - (WageAdditionTaxable.Amount -
                               ((WageAdditionTaxable.Amount * CalcTemp."Tax Deductions") / CalcTemp."Net Wage")) * (Class.Percentage / 100)))) > 0 THEN
                                    InsertValueEntry(Desc, WVE."Entry Type"::Use, ROUND((WageAdditionTaxable.Amount - (WageAdditionTaxable.Amount -
                                ((WageAdditionTaxable.Amount * CalcTemp."Tax Deductions") / CalcTemp."Net Wage")) * (Class.Percentage / 100)), 0.00001, '='), '', ValueEntriesExist, 0, 0
                                , ROUND(WageAdditionTaxable."Calculated Amount", 0.00001, '='), WageAdditionTaxable.Brutto, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                                ELSE
                                    InsertValueEntry(Desc, WVE."Entry Type"::Use, ROUND(WageAdditionTaxable.Amount, 0.00001, '='), '', ValueEntriesExist, 0, 0
                                    , ROUND(WageAdditionTaxable."Calculated Amount", 0.00001, '='), WageAdditionTaxable.Brutto, CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");

                                IF (WageAdditionTaxable.Amount - ((WageAdditionTaxable.Amount - (WageAdditionTaxable.Amount -
                               ((WageAdditionTaxable.Amount * CalcTemp."Tax Deductions") / CalcTemp."Net Wage")) * (Class.Percentage / 100)))) > 0 THEN
                                    WageAdditionTaxable.Tax := (WageAdditionTaxable.Amount - ((WageAdditionTaxable.Amount - (WageAdditionTaxable.Amount -
                                  ((WageAdditionTaxable.Amount * CalcTemp."Tax Deductions") / CalcTemp."Net Wage")) * (Class.Percentage / 100))))
                                ELSE
                                    WageAdditionTaxable.Tax := 0;
                                WageAdditionTaxable.MODIFY(TRUE);
                            END;
                        END;
                        IF WageAdditionTaxable.Meal THEN BEGIN

                            Absences.RESET;
                            Absences.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date", "To Date");
                            Absences.SETFILTER("Employee No.", Employee."No.");
                            Absences.SETFILTER("From Date", '>=%1', StartDate);
                            Absences.SETFILTER("To Date", '<=%1', EndDate);
                            CLEAR(WorkDays);

                            //Full day meal:
                            WorkDaysNo := 0;
                            TotalSati := 0;
                            COA.RESET;
                            COA.SETRANGE("Meal Calculated", TRUE);
                            IF COA.FINDFIRST THEN
                                REPEAT
                                    Absences.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                    Absences.SETFILTER(Quantity, '>0');
                                    IF Absences.FINDFIRST THEN
                                        REPEAT
                                            //   IF NOT WorkDays[DATE2DMY(Absences."From Date", 1)] THEN BEGIN
                                            /*  WorkDays[DATE2DMY(Absences."From Date",1)] := TRUE;
                                              WorkDaysNo += 1;
                                             END;*/

                                            TotalSati += Absences.quantity;

                                            if TotalSati - Employee."Hours in day" >= 0 then begin
                                                TotalSati := TotalSati - Employee."Hours in day";

                                                //demka
                                                //   WorkDays[DATE2DMY(Absences."From Date", 1)] := TRUE;
                                                IF (COA."Meal - Hours" = TRUE) AND (Absences.Quantity < 5) THEN
                                                    WorkDaysNo += 0
                                                ELSE
                                                    WorkDaysNo += 1;
                                                // END;
                                            end;
                                        UNTIL Absences.NEXT = 0;

                                    if (TotalSati > 0) then begin
                                        Dijeljenje := TotalSati / (Employee."Hours in day");
                                        IF EVALUATE(IntegerValue, FORMAT(Dijeljenje, 0, '<Integer,12><Filler Character,0>')) THEN
                                            WorkDaysNo += IntegerValue;
                                    end;

                                    IF Employee."Contact Center" THEN
                                        MealHours := CTHours
                                    ELSE
                                        MealHours := WorkDaysNo * Employee."Hours In Day";
                                UNTIL COA.NEXT = 0;
                            IF WageAdditionTaxable."System Entry" THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", ROUND(WageAdditionTaxable.Amount - (CalcTemp.Tax * WageAdditionTaxable.Amount / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, 0,
                                ROUND(WageAdditionTaxable.Amount, 0.00001, '=')
                                , WageAdditionTaxable."Calculated Amount Brutto", CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name")
                            ELSE
                                InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", ROUND(WageAdditionTaxable.Amount - (CalcTemp.Tax * WageAdditionTaxable.Amount / CalcTemp."Net Wage"), 0.00001, '='), '', ValueEntriesExist, 0, WageAdditionTaxable."No. Of Hours",
                                ROUND(WageAdditionTaxable.Amount, 0.00001, '='),
                                WageAdditionTaxable."Calculated Amount Brutto", CalcTemp."Contribution Category Code", CalcTemp."Department Code", CalcTemp."Department Name");

                            WageAdditionTaxable.Tax := WageAdditionTaxable.Amount - (WageAdditionTaxable.Amount - (CalcTemp.Tax * WageAdditionTaxable.Amount / CalcTemp."Net Wage"));
                            WageAdditionTaxable.MODIFY(TRUE);
                        END;
                    UNTIL WageAdditionTaxable.NEXT = 0;
            /*
            WVE.RESET;
            WVE.SETRANGE("Wage Ledger Entry No.",WLE."Entry No.");
            IF WVE.ISEMPTY THEN
              BEGIN
                IF WLE."Entry No." = LedgerEntryNo THEN
                  LedgerEntryNo:=LedgerEntryNo - 1;
                WLE.DELETE;
              END;
             */
            UNTIL CalcTemp.NEXT = 0;
        Window.CLOSE;

    end;

    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    var
        AddTaxes: Record "Contribution";
        ATCCon: Record "Contribution Category Conn.";
    begin

        Percentage := 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);


        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET(Employee."Contribution Category Code", AddTaxes.Code) THEN
                    IF ATCCon."Calculated in Total Brutto" THEN
                        Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;

    procedure CloseCalc(Header: Record "Wage Header")
    var
        TransLineStatus: Boolean;
        TransTempStatus: Boolean;
        EndingDate: Date;
        AbsFill: Codeunit "Absence Fill";
        EU: Record Employee;
        WU: Record "Work Booklet";
        ECLU: Record "Employee Contract Ledger";
        TaxRealF: Record "Tax Per Employee";
        TaxRealFTemp: Record "Tax Per Employee Temp";
        TaxRealFLast: Record "Tax Per Employee";
        BrojacAdd: integer;
        Code1: code[20];
        ConvertBrojac: Integer;
        NoviBrojCode: code[20];
        i: integer;
        NoviBrojCodeFinal: code[20];
        FirstCodeAdd: code[20];
        Code2: code[20];
        Code1Int: Integer;
        Code2Int: Integer;
        CodeFinal: Integer;
    begin
        Rec := (Header);

        ResetTables();

        FillLedger();

        ResetTables();

        Window.OPEN(Txt007);
        Window.UPDATE(1, 0);

        CurrRecNo := 0;
        TotalRecNo := CalcTemp.COUNTAPPROX;
        Header.CALCFIELDS(Brutto);

        IF ((Header."Wage Calculation Type" = Header."Wage Calculation Type"::Normal) OR
           ((Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add") AND (Header.Brutto <> 0))) THEN BEGIN

            IF Temp.FINDLAST THEN
                NoTest := INCSTR(NoTest)
            ELSE
                NoTest := '1';

            IF CalcTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));


                    /*CalcReal2.SETRANGE("Month Of Wage",CalcTemp."Month Of Wage");
                    CalcReal2.SETRANGE("Year of Wage",CalcTemp."Year Of Wage");

                     IF NOT CalcReal2.FIND('+') THEN*/

                    CalcReal.TRANSFERFIELDS(CalcTemp, FALSE);



                    //CalcReal."No." := NoTest;
                    CalcReal."No." := CalcTemp."No.";
                    //CalcReal."No." := NoTest;
                    CalcReal."No." := CalcTemp."No.";
                    CalcReal."Wage Header No." := CalcTemp."Wage Header No.";
                    CalcReal."Wage Calculation Type" := CalcTemp."Wage Calculation Type";
                    //WG01
                    IF Employee.GET(CalcTemp."Employee No.") THEN BEGIN
                        Employee.CALCFIELDS("Contracted Work");
                        CalcReal."Employee No." := CalcTemp."Employee No.";
                        CalcReal."Contracted Work" := Employee."Contracted Work";
                        CalcReal."Meal to pay" := CalcTemp."Meal to pay";

                        CalcReal.INSERT;

                    END;
                UNTIL CalcTemp.NEXT = 0;

                StartDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", TRUE);
                EndDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", FALSE);


                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT

                        EA.SETFILTER("From Date", '%1..%2', StartDate, EndDate);
                        EA.SETFILTER(Calculated, '%1', FALSE);
                        EA.SETFILTER("Employee No.", Emp."No.");

                        IF EA.FIND('-') THEN
                            REPEAT
                            BEGIN
                                CalcTemp.RESET;
                                CalcTemp.SETFILTER("Employee No.", EA."Employee No.");
                                //CalcTemp.SETFILTER("Month Of Wage",'%1',DATE2DMY(EA."From Date",2));
                                //MESSAGE(FORMAT(CalcTemp."Employee No."));
                                //CalcTemp.SETFILTER("Year Of Wage",'%1',DATE2DMY(EA."From Date",3));
                                //MESSAGE(FORMAT(CalcTemp."Employee No."));
                                IF CalcTemp.FIND('-') THEN BEGIN
                                    EA."Wage Header No." := CalcTemp."Wage Header No.";
                                    EA."Wage Calculation No." := CalcTemp."No.";
                                    EA.Calculated := TRUE;
                                    EA.MODIFY;
                                END;
                            END;
                            UNTIL EA.NEXT = 0;
                    UNTIL Emp.NEXT = 0;
                CalcTemp.DELETEALL;
            END;

            IF ((Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add") AND (Header.Brutto = 0)) THEN
                CalcTemp.DELETEALL;

            //WGA01
            /*nk CalcRealNeg.SETRANGE("Month Of Wage",CalcReal."Month Of Wage");
            CalcRealNeg.SETRANGE("Year of Wage",CalcReal."Year of Wage");
            CalcRealNeg.SETRANGE("Employee No.",CalcReal."Employee No.");
            CalcRealNeg.SETFILTER(Payment,'<%1',0);
            IF CalcRealNeg.FIND('-')
            THEN ERROR('Postoje negativne isplate u obračunu!')
            ELSE BEGIN*/

            CalcReal2.SETRANGE("Month Of Wage", CalcReal."Month Of Wage");
            CalcReal2.SETRANGE("Year of Wage", CalcReal."Year of Wage");
            CalcReal2.SETRANGE("Employee No.", CalcReal."Employee No.");
            IF CalcReal2.FIND('-') THEN
                REPEAT

                    CalcTemp.TRANSFERFIELDS(CalcReal2, FALSE);
                UNTIL CalcReal2.NEXT = 0;

            Window.CLOSE;
            Window.OPEN(Txt008);
            Window.UPDATE(1, 0);

            CurrRecNo := 0;
            TotalRecNo := RedTemp.COUNTAPPROX;

            IF RedTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                    RedReal.TRANSFERFIELDS(RedTemp, FALSE);
                    RedReal."No." := RedTemp."No.";
                    RedReal.INSERT;
                UNTIL RedTemp.NEXT = 0;
                RedTemp.DELETEALL;
            END;
            Window.CLOSE;
            Window.OPEN(Txt009);
            Window.UPDATE(1, 0);

            CurrRecNo := 0;
            TotalRecNo := ATTemp.COUNTAPPROX;
            Code1int := 1;
            Code2Int := 1;

            TaxRealFLast.Reset;
            TaxRealFLast.SetCurrentKey("Wage Header No.", "Wage Calculation Entry No.");
            TaxRealFLast.ascending;
            if TaxRealFLast.findlast then begin

                //posljednii uvezeni broj

                Code1 := incstr(TaxRealFLast."Wage Calculation No.");
                Evaluate(code1int, Code1);

            end;

            TaxRealFTemp.Reset();
            TaxRealFTemp.SetCurrentKey("Wage Header No.", "Wage Calculation Entry No.");
            TaxRealFTemp.Ascending;
            if TaxRealFTemp.FindLast() then begin

                Code2 := incstr(TaxRealFTemp."Wage Calculation No.");
                Evaluate(Code2Int, Code2);

            end;

            if code1int > Code2Int
             then
                CodeFinal := code1int
            else
                CodeFinal := Code2Int;






            IF ATTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                    ATReal.TRANSFERFIELDS(ATTemp, FALSE);
                    ATReal."Employee No." := ATTemp."Employee No.";
                    //nk
                    ATReal."Wage Calc No." := ATTemp."Wage Calc No.";
                    ATReal."Wage Header No." := ATTemp."Wage Header No.";
                    ATReal."Contribution Code" := ATTemp."Contribution Code";
                    ATReal."Tax Number" := ATTemp."Tax Number";
                    ATReal.INSERT;
                UNTIL ATTemp.NEXT = 0;
                ATTemp.DELETEALL;
            END;
            Window.CLOSE;
            Window.OPEN(Txt010);
            Window.UPDATE(1, 0);

            CurrRecNo := 0;
            TotalRecNo := TaxTemp.COUNTAPPROX;
            BrojacAdd := 0;

            IF TaxTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                    TaxReal.TRANSFERFIELDS(TaxTemp, FALSE);
                    TaxRealF.Reset();
                    TaxRealF.SetFilter("Wage Calculation No.", '%1', TaxTemp."Wage Calculation No.");
                    if TaxRealF.FindFirst() then begin

                        TaxReal."Wage Calculation No." := TaxTemp."Wage Calculation No.";





                        BrojacAdd += 1;
                        NoviBrojCodeFinal := '';


                        if BrojacAdd >= 1 then begin


                            NoviBrojCode := format(CodeFinal + BrojacAdd);

                            if strlen(Format(NoviBrojCode)) <= 9 then begin
                                for i := 1 to 9 - strlen(Format(NoviBrojCode)) do begin
                                    NoviBrojCodeFinal += '0'
                                end;

                                NoviBrojCodeFinal += NoviBrojCode;
                            end;


                        end;

                    end

                    else begin
                        NoviBrojCodeFinal := TaxTemp."Wage Calculation No.";

                        TaxReal."Wage Calculation No." := TaxTemp."Wage Calculation No.";

                    end;


                    TaxReal."Wage Header No." := TaxTemp."Wage Header No.";
                    IF NoviBrojCodeFinal <> '' THEN
                        TaxReal."Wage Calculation No." := NoviBrojCodeFinal;
                    TaxReal."Contribution Category Code" := TaxTemp."Contribution Category Code";
                    TaxReal."Tax Code" := TaxTemp."Tax Code";
                    TaxReal."Employee No." := TaxTemp."Employee No.";
                    TaxReal.INSERT;
                UNTIL TaxTemp.NEXT = 0;
                TaxTemp.DELETEALL;
            END;
            Window.CLOSE;
            IF Header.Reduction THEN BEGIN

                RedMainFD.RESET;
                RedMainFD.SETRANGE(RedMainFD.Status, RedMainFD.Status::Otvoren);

                Window.OPEN(Txt011);
                Window.UPDATE(1, 0);

                CurrRecNo := 0;
                TotalRecNo := RedMainFD.COUNTAPPROX;

                IF RedMainFD.FINDFIRST THEN
                    REPEAT
                        CurrRecNo += 1;
                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                        RedLockFlag := TRUE;
                        IF RedType.GET(RedMainFD.Type) THEN
                            IF RedType.AmountWithoutLimit THEN
                                RedLockFlag := FALSE;

                        RedLineFD.RESET;
                        RedLineFD.SETFILTER("Reduction No.", RedMainFD."No.");
                        RedLineFD.SETFILTER("Wage Header No.", Header."No.");
                        RedLineFD.MODIFYALL(Locked, TRUE);

                        //ovo je obustava za izračun i status prikaza

                        IF RedLockFlag THEN BEGIN
                            RedMainFD.CALCFIELDS("No. of Installments paid", "Paid Amount");
                            IF ((((RedMainFD."No. of Installments" > 0) AND (RedMainFD."No. of Installments paid" >= RedMainFD."No. of Installments")) OR
                               ((RedMainFD."Reduction Amount" > 0) AND (RedMainFD."Paid Amount" >= RedMainFD."Reduction Amount"))) OR (RedMainFD."Remaining Due" = 0))
                               or ((RedMainFD."Reduction Amount" - RedMainFD."Opening balance" - RedMainFD."Paid Amount") < 0) THEN BEGIN
                                RedMainFD.Status := RedMainFD.Status::Zatvoren;
                                RedMainFD.MODIFY;
                            END;
                        END;
                    UNTIL RedMainFD.NEXT = 0;
                Window.CLOSE;
            END;

            IF Header.Transportation THEN BEGIN
                Window.OPEN(Txt012);
                Window.UPDATE(1, 0);

                TransHeader.RESET;
                TransHeader.SETFILTER("Year of Wage", '%1', Rec."Year Of Wage");
                TransHeader.SETFILTER("Month Of Wage", '%1', Rec."Month Of Wage");
                TransHeader.FINDFIRST;
                TransLineTemp.SETFILTER("Document No.", TransHeader."No.");

                CurrRecNo := 0;
                TotalRecNo := TransLineTemp.COUNTAPPROX;

                IF TransLineTemp.FINDFIRST THEN BEGIN
                    REPEAT
                        CurrRecNo += 1;
                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                        TransLine.SETFILTER("Document No.", TransHeader."No.");
                        TransLine.SETFILTER("Employee No.", TransLineTemp."Employee No.");
                        IF TransLine.FINDFIRST THEN BEGIN
                            TransLine.Amount := TransLine.Amount + TransLineTemp.Amount;
                            TransLine.MODIFY;
                        END
                        ELSE BEGIN
                            TransLine.TRANSFERFIELDS(TransLineTemp, FALSE);
                            TransLine."Line No." := TransLineTemp."Line No.";
                            TransLine."Document No." := TransLineTemp."Document No.";
                            TransLine.INSERT;
                        END;
                    UNTIL TransLineTemp.NEXT = 0;
                    TransLineTemp.DELETEALL;
                END;
                Window.CLOSE;
            END;

            IF Header.Reduction THEN BEGIN
                Window.OPEN(Txt013);
                Window.UPDATE(1, 0);

                MealHeader.RESET;
                MealHeader.SETFILTER("Year Of Wage", '%1', Rec."Year Of Wage");
                MealHeader.SETFILTER("Month Of Wage", '%1', Rec."Month Of Wage");
                MealHeader.FINDFIRST;
                MealLineTemp.SETFILTER("Document No.", MealHeader."No.");

                CurrRecNo := 0;
                TotalRecNo := MealLineTemp.COUNTAPPROX;

                IF MealLineTemp.FINDFIRST THEN BEGIN
                    REPEAT
                        CurrRecNo += 1;
                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                        MealLine.SETFILTER("Document No.", MealHeader."No.");
                        MealLine.SETFILTER("Employee No.", MealLineTemp."Employee No.");
                        IF MealLine.FINDFIRST THEN BEGIN
                            MealLine.Amount := MealLine.Amount + MealLineTemp.Amount;
                            MealLine.MODIFY;
                        END
                        ELSE BEGIN
                            MealLine.TRANSFERFIELDS(MealLineTemp, FALSE);
                            MealLine."Line No." := MealLineTemp."Line No.";
                            MealLine."Document No." := MealLineTemp."Document No.";
                            MealLine.INSERT;
                        END;
                    UNTIL MealLineTemp.NEXT = 0;
                    MealLineTemp.DELETEALL;
                END;
                Window.CLOSE;
            END;
            //WG

            StartDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", TRUE);
            EndDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", FALSE);



            /*IF EA.FIND('-') THEN REPEAT
            BEGIN
            EA."Wage Header No.":=CalcTemp."Wage Header No.";
            EA."Wage Calculation No.":=CalcTemp."No.";
            EA.Calculated:=TRUE;
            EA.MODIFY;
            END;

            UNTIL EA.NEXT=0; */


            //Header.Status:= 2;
            Header."Closing Date" := WORKDATE;
            Header."Posting Date" := PostingDate;
            Header."User ID" := USERID;
            Header.Timestamp_WH := CURRENTDATETIME;
            Header.MODIFY;

            //EmpT.SETFILTER("Transport Confirmed",'%1',TRUE);
            EmpT.SETFILTER("Transport Temp", '<>%1', 0);
            IF EmpT.FIND('-') THEN
                REPEAT
                    EmpT."Transport Confirmed" := FALSE;
                    EmpT."Transport Amount" := EmpT."Transport Temp";
                    EmpT."Transport Temp" := 0;
                    EmpT.MODIFY;
                UNTIL EmpT.NEXT = 0;
            Commit();

            R_BroughtExperience.RUN;
            R_WorkExperience.SetEndingDate(TODAY);
            R_WorkExperience.RUN;

            EndingDate := AbsFill.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", false);
            EU.Reset();
            EU.SetFilter("For Calculation", '%1', true);
            if EU.FindSet() then
                repeat
                    WU.Reset();
                    WU.SetFilter("Employee No.", '%1', EU."No.");
                    WU.SetFilter("Current Company", '%1', true);
                    WU.SetFilter("Hours change", '%1', false);
                    WU.SetFilter("Starting Date", '<=%1', EndingDate);
                    WU.SetCurrentKey("Starting Date");
                    WU.Ascending;
                    if WU.FindLast() then begin
                        if WU."Starting Date" <> EU."Employment Date" then
                            EU."Employment Date" := WU."Starting Date";

                        ECLU.Reset();
                        ECLU.SetFilter("Employee No.", '%1', EU."No.");
                        ECLU.SetFilter("Starting Date", '<=%1', EndingDate);
                        ECLU.SetCurrentKey("Starting Date");
                        ECLU.Ascending;
                        if ECLU.FindLast() then begin
                            if ECLU."Grounds for Term. Description" <> '' then
                                EU."Termination Date" := ECLU."Ending Date"
                            else
                                EU."Termination Date" := 0D;
                            EU.Modify();
                        end;

                    end;


                until EU.Next() = 0;

            COMMIT;
            /* TCReport.SetParam(DATE2DMY(TODAY,2),DATE2DMY(TODAY,3));
             TCReport.RUN;
             COMMIT;*/

            CauseOfAbs.RESET;
            CauseOfAbs.SETFILTER(Coefficient, '%1', 0);
            IF CauseOfAbs.FINDSET THEN
                REPEAT
                    WVETemp.DELETEALL;
                    WVE1.RESET;
                    WVE.RESET;
                    WVE.SETCURRENTKEY("Entry No.");
                    WVE.ASCENDING;
                    IF WVE.FINDLAST THEN
                        EntryNew := WVE."Entry No.";
                    Absence2.RESET;
                    Absence2.SETFILTER("Cause of Absence Code", '%1', CauseOfAbs.Code);
                    Absence2.SETFILTER("From Date", '%1..%2', StartDate, EndDate);
                    Absence2.SETCURRENTKEY("Employee No.");
                    IF Absence2.FINDSET THEN
                        REPEAT
                            EntryNew := EntryNew + 1;
                            WVETemp.RESET;
                            WVETemp.SETFILTER("Posting Date", '%1', PostingDate);
                            WVETemp.SETFILTER("Document No.", '%1', CalcTemp."Wage Header No.");
                            WVETemp.SETFILTER(Description, '%1', Absence2."Short Code");
                            WVETemp.SETFILTER("Wage Posting Group", '%1', PostingGroup);
                            WVETemp.SETFILTER("Document Date", '%1', Rec."Date Of Calculation");
                            WVETemp.SETFILTER("Employee No.", '%1', Absence2."Employee No.");
                            IF NOT WVETemp.FINDFIRST THEN BEGIN
                                Postoji := TRUE;
                                WVETemp.INIT;
                                WVETemp."Employee No." := Absence2."Employee No.";
                                WVETemp."Document No." := Rec."No.";
                                WVETemp."Entry No." := EntryNew;
                                WVETemp."Posting Date" := PostingDate;

                                //Dodati ovdje opis
                                WVETemp.Description := CauseOfAbs."Short Code";
                                WVETemp.Hours := Absence2.Quantity;
                                WVETemp."Wage Posting Group" := PostingGroup;
                                WVETemp."Document Date" := Rec."Date Of Calculation";
                                WVETemp."Wage Header Entry No." := Rec."Entry No.";
                                WVETemp."Wage Ledger Entry No." := WLE."Entry No.";
                                WVETemp."User ID" := USERID;
                                WVETemp."Global Dimension 1 Code" := WLE."Global Dimension 1 Code";
                                WVETemp."Global Dimension 2 Code" := WLE."Global Dimension 2 Code";
                                WVETemp."Shortcut Dimension 4 Code" := WLE."Shortcut Dimension 4 Code";
                                WVETemp."Wage Calculation Type" := WVETemp."Wage Calculation Type"::Regular;
                                WVETemp."Entry Type" := WVE."Entry Type"::"Net Wage";
                                WVETemp.INSERT;
                            END
                            ELSE BEGIN
                                WVETemp.RESET;
                                WVETemp.SETFILTER(Description, '%1', Absence2."Short Code");
                                WVETemp.SETFILTER("Employee No.", '%1', Absence2."Employee No.");
                                IF WVETemp.FINDFIRST THEN BEGIN
                                    WVETemp.Hours := WVETemp.Hours + Absence2.Quantity;
                                    WVETemp.MODIFY;
                                END;
                            END;
                        UNTIL Absence2.NEXT = 0;
                    WVE.RESET;
                    WVETemp.RESET;
                    IF WVETemp.FINDSET THEN
                        REPEAT
                            WVE.INIT;
                            WVE.TRANSFERFIELDS(WVETemp);
                            if WVETemp."Entry Type" = WVETemp."Entry Type"::Tax then begin
                                if Employee.get(WVETemp."Employee No.") then begin
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
                        UNTIL WVETemp.NEXT = 0;

                UNTIL CauseOfAbs.NEXT = 0;
            MESSAGE(Txt005);

        END;
        //END;

    end;

    procedure InsertValueEntry(TextString: Text[50]; EntryType: Option Tax,"Contribution Per City","Net Wage","Additional Tax"," Sick Leave"; Amount: Decimal; "Contribution Code": Code[10]; var EntriesExist: Boolean; Basis: Decimal; Hours: Decimal; Netto: Decimal; Brutto: Decimal; ContributionCode: Code[10]; DepartmentCode: Code[20]; DepartmentName: Text[100])
    var
        EmployeeCon: Record "Employee Contract Ledger";
    begin
        IF Amount = 0 THEN
            EXIT;
        ValueEntryNo := ValueEntryNo + 1;
        WVE.INIT;
        WVE."Entry No." := ValueEntryNo;
        WVE."Employee No." := WLE."Employee No.";
        Employee.GET(WLE."Employee No.");
        if EntryType = EntryType::Tax then begin
            IF Employee."Entity Code CIPS" = 'RS' THEN BEGIN
                CompInfo.GET;
                WVE."Tax Number" := CompInfo."Municipality Code";
            END
            ELSE BEGIN

                WVE."Tax Number" := Employee."Municipality Code CIPS";
            END;

        end;

        EmployeeCon.Reset();
        EmployeeCon.SetFilter("Employee No.", '%1', WLE."Employee No.");
        EmployeeCon.SetFilter("Starting Date", '<=%1', Rec."Date Of Calculation");
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
        WVE."Document No." := Rec."No.";
        WVE."Wage Header Entry No." := Rec."Entry No.";
        WVE.Description := TextString;

        WVE."Wage Posting Group" := PostingGroup;

        WVE."Wage Ledger Entry No." := WLE."Entry No.";
        WVE."User ID" := USERID;
        WVE."Global Dimension 1 Code" := WLE."Global Dimension 1 Code";
        WVE."Global Dimension 2 Code" := WLE."Global Dimension 2 Code";
        WVE."Shortcut Dimension 4 Code" := WLE."Shortcut Dimension 4 Code";
        WVE."Cost Amount (Actual)" := Amount;
        WVE."Cost Amount (Netto)" := Netto;
        WVE."Cost Amount (Brutto)" := Brutto;
        WVE."Document Date" := Rec."Date Of Calculation";
        WVE."Posting Date" := WLE."Posting Date";
        WVE."Entry Type" := EntryType;
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
        WVE."Post Code" := Employee."Post Code CIPS";
        IF WVE."Entry Type" = WVE."Entry Type"::Reduction THEN BEGIN
            WVE."Reduction No." := RedTemp."Reduction No.";
            WVE."Reduction Type" := RedTemp.Type;
        END;

        IF WVE."Entry Type" = WVE."Entry Type"::Untaxable THEN
            WVE."Wage Addition Type" := WageAddition."Wage Addition Type";

        IF WVE."Entry Type" = WVE."Entry Type"::Taxable THEN
            WVE."Wage Addition Type" := WageAdditionTaxable."Wage Addition Type";

        WVE.Basis := Basis;
        WVE."Contracted Work" := WLE."Contracted Work";
        WVE.Hours := Hours;
        WVE."Contribution Category Code" := ContributionCode;
        WVE."Department Code" := DepartmentCode;
        WVE."Department Name" := DepartmentName;
        WVE.INSERT;
        EntriesExist := TRUE;
    end;

    procedure POrdersInitValue(var WHeader: Record "Wage Header"; aWithConfirm: Boolean)
    var
        pOrder: Record "Payment Order";
    begin
        WithConfirm := aWithConfirm;
        CompInfo.GET;
        IF NOT (WHeader."Payment Orders printed") THEN BEGIN



            IF M.FINDFIRST THEN
                REPEAT
                    Department.RESET;
                    Department.SETFILTER(Amount, '<>%1', 0);
                    IF Department.FINDFIRST THEN
                        REPEAT
                            Department.Amount := 0;
                            Department.AmountHealth := 0;
                            Department.AmountTax := 0;
                            Department.MODIFY;
                        UNTIL Department.NEXT = 0;

                    Orgdijelovi.RESET;

                    IF Orgdijelovi.FINDFIRST THEN
                        REPEAT
                            Orgdijelovi."For Calculation" := 0;
                            Orgdijelovi."For Calculation 2" := 0;
                            Orgdijelovi."For Calculation 3" := 0;
                            Orgdijelovi."For Calculation 4" := 0;
                            Orgdijelovi."For Calculation 5" := 0;
                            Orgdijelovi."For Calculation 6" := 0;
                            Orgdijelovi."For Calculation 7" := 0;
                            Orgdijelovi."For Calculation FA" := 0;
                            Orgdijelovi."For Calculation FA 2" := 0;
                            Orgdijelovi."For Calculation FA 3" := 0;
                            Orgdijelovi."For Calculation 8" := 0;
                            Orgdijelovi."For Calculation 9" := 0;
                            Orgdijelovi."For Calculation 10" := 0;
                            Orgdijelovi."For Calculation 11" := 0;
                            Orgdijelovi."For Calculation 12" := 0;
                            Orgdijelovi."For Calculation 13" := 0;
                            Orgdijelovi."For Calculation 14" := 0;
                            Orgdijelovi."For Calculation 15" := 0;
                            Orgdijelovi."For Calculation 16" := 0;
                            Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT = 0;

                    M."For Calculation 3" := 0;
                    M."For Calculation 4" := 0;
                    M."For Calculation 5" := 0;
                    M."For Calculation 6" := 0;
                    M."For Calculation 7" := 0;
                    M."For Calculation FA" := 0;
                    M."For Calculation FA 2" := 0;
                    M."For Calculation FA 3" := 0;
                    M."For Calculation 8" := 0;
                    M."For Calculation 9" := 0;
                    M."For Calculation 10" := 0;
                    M."For Calculation 11" := 0;
                    M."For Calculation 12" := 0;
                    M."For Calculation 13" := 0;

                    M.MODIFY;
                UNTIL M.NEXT = 0;


            IF (CompInfo."Entity Code" <> 'RS') THEN BEGIN

                // OrgdijeloviRS.DELETEALL;
                PlatePoBankama(WHeader);
                Doprinosi(WHeader);
                DoprinosiBD(WHeader);
                DoprinosiBDRS(WHeader);
                //DoprinosiFBIHRS(WHeader);
                DoprinosiRS(WHeader);
                DoprinosiRSFBIH(WHeader);
                Porezi(WHeader);
                PoreziRS(WHeader);
                PoreziBD(WHeader);
                PoreziBDRS(WHeader);
                PoreziRSFBIH(WHeader);
                //PlatePoBankamaPoslovnice(WHeader);
                //DoprinosiPoslovnice(WHeader);
                //PoreziBD(WHeader);
                Obustave(WHeader);

            END
            ELSE BEGIN
                //  OrgdijeloviRS.DELETEALL;
                PlatePoBankamaRS(WHeader);
                DoprinosiRS(WHeader);
                DoprinosiRSFBIH(WHeader);
                DoprinosiBDRS(WHeader);
                PoreziRS(WHeader);
                PoreziRSFBIH(WHeader);
                PoreziBDRS(WHeader);
                Obustave(WHeader);
            END;
            Window.CLOSE;

            IF WHeader."Calc. Chamber Fee" THEN TrgovinskaKomora(WHeader);

            WHeader."Payment Orders printed" := TRUE;
            WHeader.MODIFY;
            MESSAGE(Txt0061);
            IF NOT WithConfirm THEN BEGIN
                pOrder.RESET;
                pOrder.SETRANGE("Wage Header No.", WHeader."No.");
                pOrder.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
                IF pOrder.FINDFIRST THEN BEGIN
                    COMMIT;
                    PAGE.RUNMODAL(PAGE::"Payment Orders", pOrder);
                END;
            END;
        END
        ELSE BEGIN
            ERROR(Txt015);
        END
    end;

    procedure MakePaymentOrder()
    var
        PayOrderNo: Integer;
        pOrder: Record "Payment Order";
    begin
        pOrder.InitPaymentOrder;
        i += 1;
        pOrder.InsertPaymentOrderValues1(
        SvrhaDoznake1,
        SvrhaDoznake2,
        SvrhaDoznake3,
        Primalac1,
        Primalac2,
        Primalac3,
        RacunPosiljaoca,
        RacunPrimaoca,
        Iznos, Contribution,
        Tip,
        Sifra,
        WType,
        OrgDio,
        DatumUplate
        , RType, BudgetOrg);

        pOrder.InsertPaymentOrderValues2(
        BrojPoreznogObaveznika,
        VrstaPrihoda,
        Opstina,
        PozivNaBroj,
        PorezniPeriodOd,
        PorezniPeriodDo,
        WHeaderNo,
        WHeaderEntryNo,
        WPaymentType,
        Contribution,
        Tip,
        Sifra,
        WType,
        OrgDio,
        DatumUplate
        , RType, BudgetOrg);
        PayOrderNo := pOrder.InsertPaymentOrder;
        COMMIT;
        pOrder.GET(PayOrderNo);
        IF WithConfirm THEN PAGE.RUNMODAL(PAGE::"Payment Orders", pOrder);
    end;

    procedure InitPaymentOrder()
    begin
        CLEAR(SvrhaDoznake1);
        CLEAR(SvrhaDoznake2);
        CLEAR(SvrhaDoznake3);
        CLEAR(Primalac1);
        CLEAR(Primalac2);
        CLEAR(Primalac3);
        CLEAR(RacunPosiljaoca);
        CLEAR(RacunPrimaoca);
        CLEAR(Iznos);
        CLEAR(BrojPoreznogObaveznika);
        CLEAR(VrstaPrihoda);
        CLEAR(Opstina);
        CLEAR(PozivNaBroj);
        CLEAR(PorezniPeriodOd);
        CLEAR(PorezniPeriodDo);
        CLEAR(WHeaderNo);
        CLEAR(WHeaderEntryNo);
        CLEAR(WPaymentType);
        CLEAR(Contribution);
        CLEAR(WType);
    end;

    procedure PlatePoBankama(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
        WVE: Record "Wage Value Entry";
        WVER: Record "Wage Value Entry";
        WVEP: Record "Wage Value Entry";
        WVED: Record "Wage Value Entry";
        WLED: Record "Wage Ledger Entry";
    begin


        Window.OPEN('Obrada naloga plaćanja\@1@@@@@@@@@@@@@@@@@@@@@  :: UPP\');
        Window.UPDATE(1, 0);

        CurrRecNo := 0;
        TotalRecNo := WC.COUNTAPPROX;

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        WC.SETRANGE("Wage Calculation Type", 0);
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);

        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                Emp.SETRANGE("For calculation", TRUE);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            WageAdditionAmount := 0;
                            Additions := 0;
                            ReductionsAmount := 0;
                            TaxAmount := 0;
                            Difference := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    IF WC.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            /*  WC.CALCFIELDS("Regres Netto Separate","Regres Netto With Wage","Use Netto",Incentive,"Regres Netto");
                                              IF ((WC."Contribution Category Code"='BDPIOFBIH') OR (WC."Contribution Category Code"='BDPIORS') OR (WC."Contribution Category Code"='RS'))
                                              THEN
                                              AmountForPayment += WC."Net Wage After Tax"-WC."Wage Reduction"-WC."Regres Netto Separate"+WC.Transport
                                              ELSE
                                              AmountForPayment +=WC."Net Wage After Tax"-WC."Wage Reduction"-WC."Regres Netto With Wage";


                                              IF ((WC."Contribution Category Code"<>'BDPIOFBIH5') AND (WC."Contribution Category Code"<>'BDPIORS5')) THEN BEGIN
                                              AdditionAmountForPayment += WC.Transport;
                                              AdditionAmountForPaymentMeal += WC."Meal to pay";
                                              END
                                              ELSE BEGIN
                                              AdditionAmountForPayment := 0;
                                              AdditionAmountForPaymentMeal :=0;
                                         END;
                                              WC.CALCFIELDS("Regres Netto","Regres Netto Separate");
                                              RegresAmount+=(WC."Regres Netto"-WC."Regres Netto Separate");
                                              WC.CALCFIELDS("Meal Correction");

                                            IF WC."Meal Correction"<>0 THEN
                                            AdditionAmountForPaymentMeal +=WC."Meal Correction";
                                              IF ((Emp."Org Entity Code"<>'RS') OR (Emp."Contribution Category Code"='FBIHRS') ) THEN
                                            Additions+=WC."Untaxable Wage"- WC."Meal to pay"-WC.Transport-WC."Meal Correction"
                                            ELSE
                                            Additions+=WC."Untaxable Wage";*/
                                            AmountForPayment := 0;
                                            AdditionAmountForPayment := 0;
                                            AdditionAmountForPaymentMeal := 0;
                                            RegresAmount := 0;
                                            WageAdditionAmount := 0;
                                            Additions := 0;
                                            ReductionsAmount := 0;
                                            TaxAmount := 0;
                                            Difference := 0;
                                            WVE.RESET;
                                            WVE.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                            WVE.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                            WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                                            WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Untaxable,
                                            WVE."Entry Type"::Taxable, WVE."Entry Type"::"Meal to pay", WVE."Entry Type"::Transport, WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience");
                                            IF WVE.FINDFIRST THEN
                                                REPEAT
                                                    AmountForPayment += WVE."Cost Amount (Actual)";
                                                UNTIL WVE.NEXT = 0;

                                            WVER.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                            WVER.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                            WVER.SETFILTER("Wage Calculation Type", '%1', WVER."Wage Calculation Type"::Regular);
                                            WVER.SETFILTER("Entry Type", '%1', WVER."Entry Type"::Reduction);
                                            IF WVER.FINDFIRST THEN
                                                REPEAT
                                                    ReductionsAmount += WVER."Cost Amount (Actual)";
                                                UNTIL WVER.NEXT = 0;

                                            WLED.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                                            WLED.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                            WLED.SETFILTER("Wage Calculation Type", '%1', WLED."Wage Calculation Type"::Regular);
                                            IF WLED.FINDFIRST THEN
                                                REPEAT
                                                    WLED.CALCFIELDS("Netto Taxable", Netto);
                                                    Difference := WLED."Netto Taxable" - WLED.Netto;
                                                UNTIL WLED.NEXT = 0;


                                        UNTIL WC.NEXT = 0;


                                    IF (AmountForPayment - ReductionsAmount) > 0 THEN BEGIN
                                        //Payment Order
                                        InitPaymentOrder;

                                        //Ovdje dodati broj partije
                                        if Emp."Party No." <> '' then
                                            SvrhaDoznake1 := emp."Party No."
                                        else
                                            SvrhaDoznake1 := 'Neto na račun';
                                        //SvrhaDoznake1 :=Emp."No.";
                                        SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                        IF Single THEN
                                            SvrhaDoznake3 := SingleEmp."Refer To Number"
                                        ELSE
                                            SvrhaDoznake3 := '';
                                        //NK
                                        SvrhaDoznake3 := Emp."No.";
                                        //Primalac2 := UPPERCASE(RBanks.Name);
                                        //Primalac3 := UPPERCASE(CompInfo.City);
                                        Primalac1 := '';
                                        Primalac2 := '';
                                        Primalac3 := '';

                                        RacunPosiljaoca := BankAccounts."Bank Account No.";
                                        RacunPrimaoca := RBankAccounts."Account No";
                                        //      IF WVE."Employee No."='989' THEN MESSAGE(FORMAT(AmountForPayment) +' '+FORMAT(ReductionsAmount)+' '+FORMAT(TaxAmount)) ;
                                        Iznos := AmountForPayment - ReductionsAmount + Difference;
                                        WHeaderNo := WHeader."No.";
                                        WHeaderEntryNo := WHeader."Entry No.";
                                        WPaymentType := WPaymentType::Wage;
                                        Contribution := 'PLAĆA';
                                        DatumUplate := WHeader."Payment Date";
                                        MakePaymentOrder;
                                        CurrRecNo += 1;
                                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                                    END;
                                //ĐK promijenila zbog virmana
                                UNTIL Emp.NEXT = 0;


                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;

    end;

    procedure PlatePoBankamaRS(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        MealForPayment: Decimal;
        TransportForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin
        Window.OPEN('Obrada naloga plaєanja\@1@@@@@@@@@@@@@@@@@@@@@  :: UPP\');
        Window.UPDATE(1, 0);

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        WC.SETRANGE("Entry No.", WHeader."Entry No.");

        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NK POrders.DELETEALL;
        IF RBanks.FIND('-') THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FIND('-') THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FIND('-') THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));

                            AmountForPayment := 0;
                            MealForPayment := 0;
                            TransportForPayment := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FIND('-') THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    IF WC.FIND('-') THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction";
                                            AdditionAmountForPayment += WC."Untaxable Wage";
                                            MealForPayment += WC."Meal to pay";
                                            TransportForPayment += WC.Transport;
                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PLAĆE';
                                Contribution := 'PLAĆA';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := Emp."No."
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");

                                Iznos := ROUND(AmountForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";

                                MakePaymentOrder;
                            END;

                            IF ((MealForPayment > 0) AND (CompInfo."Entity Code" <> 'RS')) THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA TOPL.OBROK';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(MealForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF TransportForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PREVOZ';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(TransportForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;


                            IF AdditionAmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PLAĆE - dodaci';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(AdditionAmountForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure Doprinosi(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        Municipality2: Record "Municipality";
        MunicipalityTemp2: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposlenif
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SETRANGE("From Brutto", TRUE);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        //AddTaxPE.SETRANGE("Contribution Category Code",'FBIH');
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", Basis);

                        //  TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount := AddTaxPE.Basis * 0.02;
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.00001, '=');
                            MunicipalityTemp.MODIFY;

                            IF NOT MunicipalityTemp2.GET(Emp."Municipality Code for salary", MunicipalityTemp2.Type::Regular) THEN BEGIN
                                Municipality2.GET(Emp."Municipality Code for salary", Municipality2.Type::Regular);
                                MunicipalityTemp2.INIT;
                                MunicipalityTemp2.TRANSFERFIELDS(Municipality2, TRUE);
                                MunicipalityTemp2.INSERT;
                            END;
                            MunicipalityTemp2."For Calculation FA" += ROUND(TempAmount * PFed / 100, 0.00001, '=');
                            MunicipalityTemp2.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001, '=');
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001, '=');
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            //MunicipalityTemp2.SETFILTER("For Calculation FA",'<>%1',0);
            //IF MunicipalityTemp2.FIND('-') THEN REPEAT
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            BudgetOrg := AddTaxPS."Budget organisation";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";


            CompanyInfo.GET;
            Opstina := CompanyInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            MunicipalityTemp2.CALCFIELDS("Entity Code");

            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            BudgetOrg := AddTaxPS."Budget Organisation";


            WType := 0;
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
            //  UNTIL MunicipalityTemp2.NEXT = 0;
        END;

        IF KAmount > 0 THEN BEGIN

            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'FBIH';
                    BudgetOrg := AddTaxPS."Budget Organisation";


                    WType := 0;

                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;
        /**************************************************Health*********************************************/
        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SETRANGE("From Brutto", TRUE);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        //AddTaxPE.SETFILTER("Contribution Category Code",'%1','FBIH');
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", Basis);
                        // TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount := AddTaxPE.Basis * 0.145;
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                            IF NOT MunicipalityTemp2.GET(Emp."Municipality Code for salary", MunicipalityTemp2.Type::Regular) THEN BEGIN
                                Municipality2.GET(Emp."Municipality Code for salary", Municipality2.Type::Regular);
                                MunicipalityTemp2.INIT;
                                MunicipalityTemp2.TRANSFERFIELDS(Municipality2, TRUE);
                                MunicipalityTemp2.INSERT;
                            END;
                            MunicipalityTemp2."For Calculation FA 2" += ROUND(TempAmount * PFed / 100, 0.00001, '=');
                            MunicipalityTemp2.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            // MunicipalityTemp2.SETFILTER("For Calculation FA 2",'<>%1',0);
            // IF MunicipalityTemp2.FIND('-') THEN REPEAT
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            MunicipalityTemp2.CALCFIELDS("Entity Code");
            Sifra := 'FBIH';
            WType := 0;
            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            CompanyInfo.GET;
            Opstina := CompanyInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            ;
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
            //UNTIL MunicipalityTemp2.NEXT=0;
        END;

        IF KAmount > 0 THEN BEGIN
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'FBIH';
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end

                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        /**************************************************PIO**********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SETRANGE("From Brutto", TRUE);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');

        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);

                Emp.RESET;
                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", Basis);
                        //   TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount := AddTaxPE."Basis" * 0.195;
                        FAmount += TempAmount;
                        IF NOT MunicipalityTemp2.GET(Emp."Municipality Code for salary", MunicipalityTemp2.Type::Regular) THEN BEGIN
                            Municipality2.GET(Emp."Municipality Code for salary", Municipality2.Type::Regular);
                            MunicipalityTemp2.INIT;
                            MunicipalityTemp2.TRANSFERFIELDS(Municipality2, TRUE);
                            MunicipalityTemp2.INSERT;
                        END;
                        MunicipalityTemp2."For Calculation FA 3" += ROUND(TempAmount, 0.00001, '=');
                        MunicipalityTemp2.MODIFY;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            MunicipalityTemp2.SETFILTER("For Calculation FA 3", '<>%1', 0);
            IF MunicipalityTemp2.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := AddTaxPS."Payment Receiver3";
                    Tip := 1;
                    MunicipalityTemp2.CALCFIELDS("Entity Code");
                    Sifra := MunicipalityTemp2."Entity Code";
                    WType := 0;

                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp2.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(MunicipalityTemp2."For Calculation FA 3", 0.00001);
                    ;
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Contribution := 'Doprinosi PIO';
                    MunicipalityTemp2.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                UNTIL MunicipalityTemp2.NEXT = 0;
        END;

        //Posebni porezi
        /*AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::Special);
        AddTax.SETRANGE(Code,'P-ELNEP');
        Canton.GET(CompInfo.County,CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Contribution Code",'P-ELNEP');
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        IF AddTax.FINDFIRST THEN REPEAT
        // AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
        
         FAmount := 0;
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Neto","Amount Over Wage");
          TempAmount := AddTaxPE."Amount Over Neto";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
         IF FAmount > 0 THEN BEGIN
          AddTaxPS.RESET;
          AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
          AddTaxPS.SETRANGE(Code,'FBIH');
          AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Special);
          AddTaxPS.SETRANGE("Add. Tax Code",'P-ELNEP');
          AddTaxPS.FINDFIRST;
          InitPaymentOrder;
          SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
          SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
          SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
          Primalac1 := AddTaxPS."Payment Receiver1";
          Primalac2 := AddTaxPS."Payment Receiver2";
          Primalac3 := Canton.Description;
         Tip:=0;
         Sifra:='FBIH';
          WType:=0;
          RacunPosiljaoca := BankAccounts."Bank Account No.";
          RacunPrimaoca := AddTaxPS."Payment Account";
          BrojPoreznogObaveznika := CompInfo."Registration No.";
          VrstaPrihoda := AddTaxPS."Revenue Type";
          Opstina :=Emp."Org Municipality" ;
          PorezniPeriodOd := StartDate;
          PorezniPeriodDo := EndDate;
          Iznos := ROUND(FAmount,0.00001);
          WHeaderNo := WHeader."No.";
          WHeaderEntryNo := WHeader."Entry No.";
          WPaymentType := WPaymentType::"Add. Tax";
          Contribution:='Posebni doprinosi '+AddTaxPS."Add. Tax Code";
        
          {PozivNaBroj := '00000000';
          IF WHeader."Month Of Wage" < 10 THEN
           PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
          ELSE
           PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
            PozivNaBroj :=AddTaxPS."Refer To Number";
                DatumUplate:=WHeader."Payment Date";
          MakePaymentOrder;
         END;
        UNTIL AddTax.NEXT = 0;*/

        /**************************************************P-VOD*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SETRANGE(Code, 'P-VOD');
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        TempAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NKN AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NKN AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Code", 'P-VOD');
        AddTaxPE.SETFILTER("Contribution Category Code", '<>%1', 'RS');
        IF AddTax.FINDFIRST THEN
            REPEAT

                Emp.RESET;
                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage", "Basis");
                        //TempAmount := AddTaxPE."Amount Over Neto";
                        TempAmount := AddTaxPE.Basis * 0.005;

                        //NK FAmount += TempAmount;

                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code for salary", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation 3" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        //NKN IF TempAmount > 0 THEN BEGIN
        MunicipalityTemp.SETFILTER("For Calculation 3", '<>%1', 0);
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                AddTaxPS.SETRANGE("Add. Tax Code", 'P-VOD');
                AddTaxPS.FINDFIRST;
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                //  Primalac3 := Canton.Description;
                Tip := 1;
                MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := MunicipalityTemp."Entity Code";
                WType := 0;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := CompInfo."Registration No.";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := MunicipalityTemp.Code;
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Iznos := ROUND(MunicipalityTemp."For Calculation 3", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                MunicipalityTemp.CALCFIELDS("Entity Code");
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                IF Iznos > 0 THEN
                    MakePaymentOrder;
            UNTIL MunicipalityTemp.NEXT = 0;



        /**************************************************P-ELNEP*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SETRANGE(Code, 'P-ELNEP');
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        TempAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NKN AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NKN AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Code", 'P-ELNEP');
        IF AddTax.FINDFIRST THEN
            REPEAT

                Emp.RESET;
                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage", "Basis");
                        //TempAmount := AddTaxPE."Amount Over Neto";
                        TempAmount := AddTaxPE.Basis * 0.005;
                        //NK FAmount += TempAmount;

                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code for salary", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation 4" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        //NKN IF TempAmount > 0 THEN BEGIN
        MunicipalityTemp.SETFILTER("For Calculation 4", '<>%1', 0);

        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                AddTaxPS.SETRANGE("Add. Tax Code", 'P-ELNEP');
                AddTaxPS.FINDFIRST;
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                //  Primalac3 := Canton.Description;
                Tip := 0;
                MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := MunicipalityTemp."Entity Code";
                WType := 0;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := CompInfo."Registration No.";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := MunicipalityTemp.Code;
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Iznos := ROUND(MunicipalityTemp."For Calculation 4", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunicipalityTemp.CALCFIELDS("Entity Code");
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                IF Iznos > 0 THEN
                    MakePaymentOrder;
            UNTIL MunicipalityTemp.NEXT = 0;


        /**************************************************P-FOND*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH' + 'n';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";

                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

        /**************************************************P-KOM*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Chamber);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Chamber);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH' + 'n';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        _______RS_________: Integer;
        RSAmount: Decimal;
        PIOAmount: Decimal;
        ZDRAmount: Decimal;
        DJZAmount: Decimal;
        NEZAmount: Decimal;
        Municipality: Record "ORG Dijelovi";
        MunicipalityTemp: Record "ORG Dijelovi";
        Municipality2: Record "ORG Dijelovi";
        MunicipalityTemp2: Record "ORG Dijelovi";
        Emp2: Record "Employee";
        AddTax2: Record "Contribution";
        AddTaxPE2: Record "Contribution Per Employee";
        Municipality3: Record "ORG Dijelovi";
        MunicipalityTemp3: Record "ORG Dijelovi";
        Emp3: Record "Employee";
        AddTax3: Record "Contribution";
        AddTaxPE3: Record "Contribution Per Employee";
        OrgDijelovi: Record "ORG Dijelovi";
        OrgDijeloviTemp: Record "ORG Dijelovi";
        OrgDijelovi2: Record "ORG Dijelovi";
        OrgDijeloviTemp2: Record "ORG Dijelovi";
        OrgDijelovi3: Record "ORG Dijelovi";
        OrgDijeloviTemp3: Record "ORG Dijelovi";
        AddTaxPEINV: Record "Contribution Per Employee";
        AddTaxPEKOM: Record "Contribution Per Employee";
        AmountKOM: Decimal;
        AmountKomTemp: Decimal;
        OrgDijelovi4: Record "ORG Dijelovi";
        OrgDijeloviTemp4: Record "ORG Dijelovi";
        Emp4: Record "Employee";
        AddTax4: Record "Contribution";
        AddTaxPE4: Record "Contribution Per Employee";
        OrgDijelovi5: Record "ORG Dijelovi";
        OrgDijeloviTemp5: Record "ORG Dijelovi";
        Emp5: Record "Employee";
    begin

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);






        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::RS);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        IF AddTax.FIND('-') THEN BEGIN
            //AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
            Emp.RESET;
            Emp.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp.SETFILTER("Entity Code CIPS", '%1', 'RS');
            Emp.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp.SETFILTER("For Calculation", '%1', TRUE);
            IF Emp.FIND('-') THEN
                REPEAT
                    AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                    AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    TempAmount := AddTaxPE."Amount From Wage";
                    //TempAmountSpecTemp := AddTaxPE."Amount Over Wage";
                    AmountOverTemp := AddTaxPE."Amount Over Wage";



                    IF ((TempAmount > 0) OR (AmountOverTemp > 0)) THEN BEGIN
                        //TempAmountSpec+=TempAmountSpecTemp;
                        AmountOver += AmountOverTemp;
                        OrgDijeloviTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                        OrgDijeloviTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                        OrgDijeloviTemp.SETFILTER(GF, '%1', Emp.GF);
                        IF NOT OrgDijeloviTemp.FINDFIRST THEN BEGIN
                            OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijelovi.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijelovi.SETFILTER(GF, '%1', Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                                OrgDijeloviTemp.INIT;
                                OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi, TRUE);
                                OrgDijeloviTemp.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp."For Calculation 5" += ROUND(TempAmount, 0.00001);
                        //  MunicipalityTemp."For Calculation 7" += ROUND(TempAmountSpecTemp,0.00001);
                        OrgDijeloviTemp.MODIFY;

                    END;
                UNTIL Emp.NEXT = 0;
        END;


        AddTax2.RESET;
        AddTax2.SETRANGE(Type, AddTax2.Type::RS);
        AddTaxPE2.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE2.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE2.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE2.SETRANGE("Contribution Code", 'P-RVI');
        IF AddTax2.FIND('-') THEN BEGIN
            Emp2.RESET;
            Emp2.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp2.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp2.SETFILTER("For Calculation", '%1', TRUE);
            IF Emp2.FIND('-') THEN
                REPEAT
                    AddTaxPE2.SETRANGE("Employee No.", Emp2."No.");
                    AddTaxPE2.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    TempAmountSpecTemp := AddTaxPE2."Amount Over Wage";
                    IF (TempAmountSpecTemp > 0) THEN BEGIN
                        TempAmountSpec += TempAmountSpecTemp;


                        OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '%1', Emp2."Municipality Code for salary");

                        OrgDijeloviTemp2.SETFILTER(Code, '%1', Emp2."Org Jed");
                        OrgDijeloviTemp2.SETFILTER(GF, '%1', Emp2.GF);
                        IF NOT OrgDijeloviTemp2.FINDFIRST THEN BEGIN
                            OrgDijelovi2.SETFILTER("Municipality Code for salary", '%1', Emp2."Municipality Code for salary");
                            OrgDijelovi2.SETFILTER(Code, '%1', Emp2."Org Jed");
                            OrgDijelovi2.SETFILTER(GF, '%1', Emp2.GF);
                            IF OrgDijelovi2.FINDSET THEN BEGIN
                                OrgDijeloviTemp2.INIT;
                                OrgDijeloviTemp2.TRANSFERFIELDS(OrgDijelovi2, TRUE);
                                OrgDijeloviTemp2.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp2."For Calculation 7" += ROUND(TempAmountSpecTemp, 0.00001);
                        OrgDijeloviTemp2.MODIFY;
                    END;

                UNTIL Emp2.NEXT = 0;
        END;



        AddTax3.RESET;
        AddTax3.SETRANGE(Type, AddTax3.Type::RS);
        AddTax3.SETRANGE(Code, 'P-FONDRS');
        AddTaxPE3.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE3.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE3.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE3.SETRANGE("Contribution Code", 'P-FONDRS');
        IF AddTax3.FIND('-') THEN BEGIN
            Emp3.RESET;
            Emp3.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp3.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp3.SETFILTER("For Calculation", '%1', TRUE);
            IF Emp3.FIND('-') THEN
                REPEAT
                    AddTaxPE3.SETRANGE("Employee No.", Emp3."No.");
                    AddTaxPE3.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    FundAmountTemp := AddTaxPE3."Amount Over Neto";
                    IF (FundAmountTemp > 0) THEN BEGIN
                        FundAmount += FundAmountTemp;



                        OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '%1', Emp3."Municipality Code for salary");
                        OrgDijeloviTemp3.SETFILTER(Code, '%1', Emp3."Org Jed");
                        OrgDijeloviTemp3.SETFILTER(GF, '%1', Emp3.GF);
                        IF NOT OrgDijeloviTemp3.FINDFIRST THEN BEGIN
                            OrgDijelovi3.SETFILTER("Municipality Code for salary", '%1', Emp3."Municipality Code for salary");

                            OrgDijelovi3.SETFILTER(Code, '%1', Emp3."Org Jed");
                            OrgDijelovi3.SETFILTER(GF, '%1', Emp3.GF);
                            IF OrgDijelovi3.FINDSET THEN BEGIN
                                OrgDijeloviTemp3.INIT;
                                OrgDijeloviTemp3.TRANSFERFIELDS(OrgDijelovi3, TRUE);
                                OrgDijeloviTemp3.INSERT;
                            END;
                            OrgDijeloviTemp3."For Calculation 13" += ROUND(FundAmountTemp, 0.00001);
                            OrgDijeloviTemp3.MODIFY;
                        END;
                    END;
                UNTIL Emp3.NEXT = 0;
        END;


        AddTax4.RESET;
        AddTax4.SETRANGE(Type, AddTax4.Type::RS);
        AddTaxPE4.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE4.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE4.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE4.SETRANGE("Contribution Code", 'P-VTK');
        IF AddTax4.FIND('-') THEN BEGIN
            Emp4.RESET;
            Emp4.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp4.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp4.SETFILTER("For Calculation", '%1', TRUE);
            IF Emp4.FIND('-') THEN
                REPEAT
                    AddTaxPE4.SETRANGE("Employee No.", Emp4."No.");
                    AddTaxPE4.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    AmountKomTemp := AddTaxPE4."Amount Over Wage";
                    IF (AmountKomTemp > 0) THEN BEGIN
                        AmountKOM += AmountKomTemp;


                        OrgDijeloviTemp4.SETFILTER("Municipality Code for salary", '%1', Emp4."Municipality Code for salary");
                        OrgDijeloviTemp4.SETFILTER(Code, '%1', Emp4."Org Jed");
                        OrgDijeloviTemp4.SETFILTER(GF, '%1', Emp4.GF);
                        IF NOT OrgDijeloviTemp4.FINDFIRST THEN BEGIN
                            OrgDijelovi4.SETFILTER("Municipality Code for salary", '%1', Emp4."Municipality Code for salary");
                            OrgDijelovi4.SETFILTER(Code, '%1', Emp4."Org Jed");
                            OrgDijelovi4.SETFILTER(GF, '%1', Emp4.GF);
                            IF OrgDijelovi4.FINDSET THEN BEGIN
                                OrgDijeloviTemp4.INIT;
                                OrgDijeloviTemp4.TRANSFERFIELDS(OrgDijelovi4, TRUE);
                                OrgDijeloviTemp4.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp4."For Calculation 14" += ROUND(AmountKomTemp, 0.00001);
                        OrgDijeloviTemp4.MODIFY;
                    END;

                UNTIL Emp4.NEXT = 0;
        END;


        //IF TempAmount > 0 THEN BEGIN
        OrgDijeloviTemp.SETFILTER("For Calculation 5", '<>%1', 0);
        OrgDijeloviTemp.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Munici);
                //NK AddTaxPS.SETRANGE(Code,MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                // AddTaxPS.SETFILTER("Add. Tax Code",'%1','');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";
                BudgetOrg := AddTaxPS."Budget organisation";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Sifra := 'RS';
                WType := 0;
                Tip := 1;
                Iznos := ROUND(OrgDijeloviTemp."For Calculation 5", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();


                    if (CompanyInfo.City = 'Banja Luka') then begin PozivNaBroj := AddTaxPS."Refer To Number"; end;
                end;
                Contribution := 'Doprinos';
                DatumUplate := WHeader."Payment Date";
                MakePaymentOrder;
            //END;

            UNTIL OrgDijeloviTemp.NEXT = 0;

        //IF TempAmountSpec > 0 THEN BEGIN
        OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp2.SETFILTER("For Calculation 7", '<>%1', 0);
        OrgDijeloviTemp2.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp2.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp2.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FIBHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'P-RVI');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp2."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp2."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviTemp2."For Calculation 7", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                WType := 0;
                Tip := 1;
                Sifra := 'RS';
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                Contribution := 'Poseban doprinos';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp2.NEXT = 0;

        OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp3.SETFILTER("For Calculation 13", '<>%1', 0);
        OrgDijeloviTemp3.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp3.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp3.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FIBHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'P-FONDRS');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp3."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp3."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviTemp3."For Calculation 13", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                WType := 0;
                Tip := 1;
                Sifra := 'RS';
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                Contribution := 'Poseban doprinos';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp3.NEXT = 0;



        OrgDijeloviTemp4.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp4.SETFILTER("For Calculation 14", '<>%1', 0);
        OrgDijeloviTemp4.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp4.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp4.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                AddTaxPS.SETRANGE(Code, 'RS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Chamber);
                // AddTaxPS.SETFILTER("Add. Tax Code",'%1','P-VTK');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp4."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp4."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviTemp4."For Calculation 14", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                WType := 0;
                Tip := 1;
                Sifra := 'RS';
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                Contribution := 'Poseban doprinos';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp4.NEXT = 0;
        //UNTIL MunicipalityTemp.NEXT=0;
        /*
        IF AmountOver > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
        
         AddTaxPS.SETFILTER("Add. Tax Code",'%1','D-INVALID');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(AmountOver+AmountOverRed,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
               DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;
        
        
        
        
        IF TempAmountSpec > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FIBHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETFILTER("Add. Tax Code",'%1','D-SOLID');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(TempAmountSpec,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
               DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;
        
        
        
        
        IF PIOAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETFILTER("Add. Tax Code",'%1','D-PIORS');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(PIOAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;
        
        IF NEZAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETFILTER("Add. Tax Code",'%1','D-ZAPO…-RS');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(NEZAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;
        //SOLID
        
        
        IF SOLIDAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETRANGE("Add. Tax Code",'%1','D-SOLID');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(SOLIDAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;
        //END solid
        
        IF DJZAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETRANGE("Add. Tax Code",'%1','DJEµ. ZA…T');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(DJZAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
               DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;
        
        IF CantonTemp.FIND('-') THEN REPEAT
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
         AddTaxPS.SETRANGE(Code,CantonTemp.Code);
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Health);
         AddTaxPS.FIND('-');
        
         InitPaymentOrder;
        
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := CantonTemp.Description;
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
         Sifra:=AddTaxPS.Code;
         Iznos := ROUND(CantonTemp."For Calculation",0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         {PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
           PozivNaBroj :=AddTaxPS."Refer To Number";
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;*/
        //UNTIL CantonTemp.NEXT = 0; END;

        /**************************************************P-VOD*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SETRANGE(Code, 'P-VOD');
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        TempAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NKN AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NKN AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Code", 'P-VOD');
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'RS');
        IF AddTax.FINDFIRST THEN
            REPEAT

                Emp5.RESET;
                IF Emp5.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp5."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        //NK FAmount += TempAmount;

                        IF TempAmount > 0 THEN BEGIN
                            /* IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary") THEN BEGIN
                             Municipality.GET(Emp."Municipality Code for salary");
                             MunicipalityTemp.INIT;
                             MunicipalityTemp.TRANSFERFIELDS(Municipality,TRUE);
                             MunicipalityTemp.INSERT;
                             END;

                            MunicipalityTemp."For Calculation 3" += ROUND(TempAmount,0.00001);
                            MunicipalityTemp.MODIFY;*/
                            OrgDijeloviTemp5.SETFILTER("Municipality Code for salary", '%1', Emp5."Municipality Code for salary");
                            OrgDijeloviTemp5.SETFILTER(Code, '%1', Emp5."Org Jed");
                            OrgDijeloviTemp5.SETFILTER(GF, '%1', Emp5.GF);
                            IF NOT OrgDijeloviTemp5.FINDFIRST THEN BEGIN
                                OrgDijelovi5.SETFILTER("Municipality Code for salary", '%1', Emp5."Municipality Code for salary");
                                OrgDijelovi5.SETFILTER(Code, '%1', Emp5."Org Jed");
                                OrgDijelovi5.SETFILTER(GF, '%1', Emp5.GF);
                                IF OrgDijelovi5.FINDSET THEN BEGIN
                                    OrgDijeloviTemp5.INIT;
                                    OrgDijeloviTemp5.TRANSFERFIELDS(OrgDijelovi5, TRUE);
                                    OrgDijeloviTemp5.INSERT;
                                END;
                            END;
                            OrgDijeloviTemp5."For Calculation 3" += ROUND(TempAmount, 0.00001);
                            OrgDijeloviTemp5.MODIFY;
                        END;
                        FAmount += ROUND(TempAmount, 0.00001);
                    UNTIL Emp5.NEXT = 0;

            UNTIL AddTax.NEXT = 0;

        //NKN IF TempAmount > 0 THEN BEGIN
        /*MunicipalityTemp.SETFILTER("For Calculation 3",'<>%1',0);
        IF MunicipalityTemp.FIND('-') THEN REPEAT*/

        OrgDijeloviTemp5.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp5.SETFILTER("For Calculation 3", '<>%1', 0);
        OrgDijeloviTemp5.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp5.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp5.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, OrgDijeloviTemp5."Municipality Code for salary");
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                AddTaxPS.SETRANGE("Add. Tax Code", 'P-VOD');
                AddTaxPS.FINDFIRST;
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                //  Primalac3 := Canton.Description;
                Tip := 1;
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := OrgDijeloviTemp5."Entity Code";
                WType := 0;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                //VOD BrojPoreznogObaveznika := CompInfo."Registration No.";
                BrojPoreznogObaveznika := OrgDijeloviTemp5."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp5."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Iznos := ROUND(OrgDijeloviTemp5."For Calculation 3", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                IF Iznos > 0 THEN
                    MakePaymentOrder;
            UNTIL OrgDijeloviTemp5.NEXT = 0;

    end;

    procedure Porezi(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //TaxPE.SETFILTER("Contribution Category Code",'%1|%2|%3','FBIH','FBIHRS','RS');
        TaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
        TaxPE.SETRANGE("Wage Calculation Type", 0);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> '00' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Tip := 2;
                    IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                        Sifra := 'FBIH'
                    ELSE
                        Sifra := TaxPE."Contribution Category Code";
                    Sifra := TaxPE."Contribution Category Code";
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    Mun.CALCFIELDS("Canton Code");
                    OrgJed.RESET;
                    OrgJed.SETFILTER("Municipality Code for salary", '%1', Mun."Tax Number");
                    IF OrgJed.FINDLAST THEN;
                    IF Mun."Tax Number" = '099' THEN
                        BrojPoreznogObaveznika := '4200344670106'
                    ELSE
                        IF Mun."Canton Code" = '00' THEN
                            BrojPoreznogObaveznika := '4200344670092'
                        ELSE
                            BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure Obustave(var WHeader: Record "Wage Header")
    var
        Reductions: Record "Reduction";
        RTypes: Record "Reduction types";
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        WageSetup: Record "Wage Setup";
        Amount: Decimal;
        IsSingle: Boolean;
        RPW: Record "Reduction per Wage";
        IsFirst: Boolean;
        Emp: Record "Employee";
        FirstReduction: Record "Reduction";
        SinglePaymentOrder: Boolean;
        CompInf: Record "Company Information";
    begin
        RPW.SETCURRENTKEY("Reduction No.", "Wage Header No.", Locked);
        RPW.SETRANGE("Wage Header No.", WHeader."No.");
        RPW.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Reduction);
        //NK POrders.DELETEALL;

        IF RBanks.FINDFIRST THEN
            REPEAT
                RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                IF RBankAccounts.FINDFIRST THEN
                    REPEAT
                        Reductions.SETRANGE(BankAccountCode, RBanks.Code);
                        // IF EVALUATE(BankNo,RBankAccounts."No.") THEN
                        Reductions.SETRANGE(BankAccountCodeNo, RBankAccounts."No.");
                        IF RTypes.FINDFIRST THEN
                            REPEAT
                                SinglePaymentOrder := RTypes."Separate Payment";
                                Reductions.SETRANGE(Type, RTypes.Code);

                                IF SinglePaymentOrder THEN BEGIN
                                    IF Reductions.FINDFIRST THEN
                                        REPEAT
                                            Amount := 0;
                                            RPW.SETRANGE("Reduction No.", Reductions."No.");
                                            RPW.SETFILTER(Type, '<>%1', 'P-FONDRS');
                                            IF RPW.FINDFIRST THEN
                                                REPEAT
                                                    Amount += RPW.Amount;
                                                UNTIL RPW.NEXT = 0;
                                            IF Amount > 0 THEN BEGIN
                                                InitPaymentOrder;

                                                IF Reductions.Type = 'KREDIT' THEN
                                                    SvrhaDoznake1 := Reductions."Party No." + ' Uplata rate kredita'
                                                ELSE
                                                    IF Reductions.Type = 'DONAC.' THEN
                                                        SvrhaDoznake1 := 'Uplata donacije'
                                                    ELSE
                                                        SvrhaDoznake1 := Reductions."Party No.";

                                                Emp.GET(Reductions."Employee No.");
                                                SvrhaDoznake2 := 'Za: ' + Emp."Last Name" + ' ' + Emp."First Name";
                                                /* IF Reductions.ContractNo <> '' THEN
                                                   SvrhaDoznake3 := Reductions.ContractNo
                                                 ELSE
                                                  SvrhaDoznake3 := RTypes.Description+' '+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';*/
                                                SvrhaDoznake3 := Reductions."Employee No.";
                                                Primalac1 := '';
                                                Primalac2 := RBanks.Name;
                                                Primalac3 := '';

                                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");


                                                Contribution := 'Obustava';
                                                Iznos := ROUND(Amount, 0.00001);

                                                WHeaderNo := WHeader."No.";
                                                WHeaderEntryNo := WHeader."Entry No.";
                                                WPaymentType := WPaymentType::Reduction;
                                                DatumUplate := WHeader."Payment Date";

                                                StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
                                                EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
                                                EndDate := CALCDATE('<+1M>', EndDate);
                                                EndDate := CALCDATE('<-1D>', EndDate);
                                                PorezniPeriodOd := StartDate;
                                                PorezniPeriodDo := EndDate;
                                                CompInfo.get;




                                                CompInf.get;
                                                if CompInf.City = 'Banja Luka' then begin
                                                    VrstaPrihoda := '712173';
                                                    BudgetOrg := '0000000';
                                                    PozivNaBroj := '0000000000';

                                                    BrojPoreznogObaveznika := CompInf."Registration No.";
                                                    RacunPrimaoca := FORMAT('5551000036647150');
                                                enD;
                                                RType := Reductions.Type;
                                                MakePaymentOrder;
                                            END;
                                        UNTIL Reductions.NEXT = 0;
                                END
                                ELSE BEGIN

                                    IsFirst := TRUE;
                                    IsSingle := TRUE;
                                    Amount := 0;
                                    IF Reductions.FINDFIRST THEN
                                        REPEAT
                                            RPW.SETRANGE("Reduction No.", Reductions."No.");
                                            IF RPW.FINDFIRST THEN
                                                REPEAT
                                                    IF IsFirst THEN
                                                        FirstReduction.GET(Reductions."No.");
                                                    IF NOT IsFirst THEN
                                                        IsSingle := FALSE;
                                                    IsFirst := FALSE;
                                                    Amount += RPW.Amount;
                                                UNTIL RPW.NEXT = 0;
                                        UNTIL Reductions.NEXT = 0;
                                    IF Amount > 0 THEN BEGIN
                                        InitPaymentOrder;

                                        /*nk IF Reductions.Type = 'KREDIT' THEN
                                           SvrhaDoznake1 := 'Uplata rate kredita'
                                         ELSE IF Reductions.Type = 'DONAC.' THEN
                                           SvrhaDoznake1 := 'Uplata donacije'
                                         ELSE
                                           SvrhaDoznake1 := 'Uplata';*/

                                        IF NOT IsSingle THEN BEGIN
                                            SvrhaDoznake2 := RBanks.Name;
                                            SvrhaDoznake3 := RTypes.Description;
                                        END
                                        ELSE BEGIN
                                            Emp.GET(FirstReduction."Employee No.");
                                            SvrhaDoznake2 := 'Za: ' + Emp."Last Name" + ' ' + Emp."First Name";
                                            CompInf.get;
                                            if CompInf.City = 'Banja Luka' then begin
                                                VrstaPrihoda := '712173';

                                            end;
                                            /* IF Reductions.ContractNo <> '' THEN
                                               SvrhaDoznake3 := FirstReduction.ContractNo
                                             ELSE
                                              SvrhaDoznake3 := RTypes.Description+' '+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';*/
                                        END;
                                        SvrhaDoznake3 := Reductions."Employee No.";
                                        CompInf.get;
                                        if CompInf.City = 'Banja Luka' then begin
                                            VrstaPrihoda := '712173';

                                        end;
                                        Primalac1 := '';
                                        Primalac2 := RBanks.Name;
                                        Primalac3 := '';

                                        RacunPosiljaoca := BankAccounts."Bank Account No.";
                                        RacunPrimaoca := FORMAT(RBankAccounts."Account No");

                                        Iznos := ROUND(Amount, 0.00001);
                                        WHeaderNo := WHeader."No.";
                                        WHeaderEntryNo := WHeader."Entry No.";
                                        WPaymentType := WPaymentType::Reduction;
                                        DatumUplate := WHeader."Payment Date";
                                        RType := Reductions.Type;
                                        MakePaymentOrder;
                                    END;
                                END;
                            UNTIL RTypes.NEXT = 0;
                    UNTIL RBankAccounts.NEXT = 0;
            UNTIL RBanks.NEXT = 0;

        WageSetup.GET;

    end;

    procedure TrgovinskaKomora(var WHeader: Record "Wage Header")
    var
        WageSetup: Record "Wage Setup";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        WageSetup.GET;
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Chamber);
        //NK POrders.DELETEALL;
    end;

    procedure DoprinosiTC(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        TempAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        // ĐK AddTaxPE.SETRANGE(Calculated, FALSE);
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
                        if AddTaxPE.FindFirst() then begin
                            AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                            TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        end
                        else begin

                            TempAmount := 0;
                        end;

                        FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 1;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();

            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;
                IF MunicipalityTemp."For Calculation 2" > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 1;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";

                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/

                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin

                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end

                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;

                END;
            //UNTIL CantonTemp.NEXT = 0;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        // đk AddTaxPE.SETRANGE(Calculated, FALSE);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", Basis);
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        //  TempAmount := AddTaxPE.Basis * 0.23;
                        FAmount += TempAmount;

                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 1;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK 2909AddTaxPE.SETRANGE("Add. Tax Code",'P-ELNEP');
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        //ĐK   AddTaxPE.SETRANGE(Calculated, FALSE);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;

                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);

                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 1;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;


                END;



            UNTIL AddTax.NEXT = 0;

    end;


    procedure DoprinosiTCRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := 0;
        PFed := 100;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);

        FAmount := 0;
        KAmount := 0;
        TempAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");

        AddTaxPE.SETRANGE("Wage Calculation Type", 1);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
                        if AddTaxPE.FindFirst() then begin
                            AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                            TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        end
                        else begin

                            TempAmount := 0;
                        end;

                        FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CompanyInfo.get();
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);

            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, CompanyInfo."Entity Code");
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 1;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end
            else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);

                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;
                IF MunicipalityTemp."For Calculation 2" > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 1;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";

                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;

                END;
            //UNTIL CantonTemp.NEXT = 0;
            UNTIL MunicipalityTemp.NEXT = 0;
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        if AddTax.findfirst then begin end;


        //PIO
        AddTaxPS.RESET;
        AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
        AddTaxPS.SETFILTER("Add. Tax Code", '%1', AddTax.Code);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);

        // đk AddTaxPE.SETRANGE(Calculated, FALSE);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";

                        FAmount += TempAmount;

                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);

            //Ovdje dodati uslov za zdravstvo
            AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-PIORS');
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 1;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK 2909AddTaxPE.SETRANGE("Add. Tax Code",'P-ELNEP');
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        //ĐK   AddTaxPE.SETRANGE(Calculated, FALSE);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;

                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, CompanyInfo."Entity Code");
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);

                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := CompanyInfo."Entity Code";
                    WType := 1;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;


                END;



            UNTIL AddTax.NEXT = 0;

    end;

    procedure PoreziTC(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
        CompInf: Record "Company Information";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETFILTER("Wage Calculation Type", '%1', 1);
        //ĐK  TaxPE.SETRANGE(Calculated, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.SETFILTER("Wage Calculation Type", '%1', 1);
                ;
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> 'REG1' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, CompInfo."Municipality Code");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 1;
                    Sifra := AddTaxPS.Code;
                    WType := 1;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";

                    if CompInfo."Entity Code" = 'RS' then
                        VrstaPrihoda := '711118';



                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    TaxPE.Calculated := TRUE;
                    TaxPE.MODIFY;
                END;
            UNTIL Mun.NEXT = 0;

    end;





    procedure DoprinosiTCNR(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;
        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
        //ĐK   AddTaxPE.SETRANGE(Calculated, FALSE);

        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        WageSetup.GET;
                        FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 2;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
             PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";

            MakePaymentOrder;
        END;

        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;

                IF KAmount > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := (MunicipalityTemp.Code);
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 2;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    //UNTIL CantonTemp.NEXT = 0;
                END;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
        //ĐK   AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 2;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/

            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");

        //ĐK   AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);

                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 2;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiTCAC(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;


        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        //ĐK    AddTaxPE.SETRANGE(Calculated, FALSE);

        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 3;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;


        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;
                IF KAmount > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 3;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            //UNTIL CantonTemp.NEXT = 0;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        //ĐK  AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 3;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
             PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");

        //NK1108AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        // đk AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);

                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 3;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiTCACRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;


        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := 0;
        PFed := 100;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::RS);
        AddTax.SetFilter(Active, '%1', true);

        FAmount := 0;
        KAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        //ĐK    AddTaxPE.SETRANGE(Calculated, FALSE);

        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += ROUND(TempAmount * 1 / 100, 0.00001);
                        KAmount += ROUND(TempAmount * 0 / 100, 0.00001);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code", Municipality.Type::regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTax.SETRANGE(Type, AddTax.Type::RS);
            AddTax.SetFilter(Active, '%1', true);

            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 3;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;


        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTax.SETRANGE(Type, AddTax.Type::RS);
                AddTax.SetFilter(Active, '%1', true);
                IF AddTaxPS.FINDFIRST THEN;
                IF KAmount > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 3;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            //UNTIL CantonTemp.NEXT = 0;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        //ĐK  AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTax.SETRANGE(Type, AddTax.Type::RS);
            AddTax.SetFilter(Active, '%1', true);
            AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-PIORS');
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 3;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type TC";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
             PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");

        //NK1108AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        // đk AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;

                    AddTax.SETRANGE(Type, AddTax.Type::Special);
                    AddTax.SETRANGE(Code, 'P-VOD');
                    AddTax.SetFilter(Active, '%1', true);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := CompanyInfo."Entity Code";
                    WType := 3;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure PoreziTCNR(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108 TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Wage Calculation Type", 2);
        //ĐK    TaxPE.SETRANGE(Calculated, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.SETRANGE("Wage Calculation Type", 2);

                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, Mun.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 2;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type TC";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    TaxPE.Calculated := TRUE;
                    TaxPE.MODIFY;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure PoreziTCAC(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK1108TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Wage Calculation Type", 3);
        //ĐK  TaxPE.SETRANGE(Calculated, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.SETRANGE("Wage Calculation Type", 3);

                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, Mun.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 3;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    TaxPE.Calculated := TRUE;
                    TaxPE.MODIFY;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure DoprinosiBD(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.type::Regular) THEN BEGIN

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //BD NK Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'BDFBIH';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 0;
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end
            else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            //NK MunicipalityTemp."For Calculation 2" += ROUND(TempAmount*PKan/100,0.00001);
                            //NK MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount, 0.00001);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 0;
            Tip := 1;
            Sifra := 'BDFBIH';

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //NK BD Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end
            else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := 'BDFBIH';
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := '068';
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

    end;

    procedure DoprinosiFBIHRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        TempAmount2: Decimal;
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIHRS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Reported Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount2 := AddTaxPE."Reported Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.00001);
                            //MunicipalityTemp."For Calculation" += ROUND(TempAmount2,0.00001);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.00001);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIHrs';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 0;
            BudgetOrg := AddTaxPS."Budget Organisation";

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            MunicipalityTemp.SETFILTER("Entity Code", '%1', 'RS');
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    Sifra := 'FBIHrs';
                    WType := 0;
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'FBIHRS');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Reported Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount2 := AddTaxPE."Reported Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            Sifra := 'FBIHRS';
            WType := 0;
            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";

            /* PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            MunicipalityTemp.SETFILTER("Entity Code", '%1', 'RS');
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := 'FBIHRS';
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS2');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := 'BDrs' + 'n';
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := '016';
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number RS";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;
        /*
        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::Special);
        Canton.GET(CompInfo.County,CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type",0);
        IF AddTax.FINDFIRST THEN REPEAT
         AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
         FAmount := 0;
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Neto","Amount Over Wage");
          TempAmount := AddTaxPE."Amount Over Neto";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
         IF FAmount > 0 THEN BEGIN
          AddTaxPS.RESET;
          AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
          AddTaxPS.SETRANGE(Code,'FBIH');
          AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Special);
          AddTaxPS.SETRANGE("Add. Tax Code",AddTax.Code);
          AddTaxPS.FINDFIRST;
          InitPaymentOrder;
          SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
          SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
          SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
          Primalac1 := AddTaxPS."Payment Receiver1";
          Primalac2 := AddTaxPS."Payment Receiver2";
          Primalac3 := Canton.Description;
         Tip:=0;
         Sifra:='FBIHnm';
          WType:=AddTxPE."Wage calculation Type";
          RacunPosiljaoca := BankAccounts."Bank Account No.";
          RacunPrimaoca := AddTaxPS."Payment Account";
          BrojPoreznogObaveznika := CompInfo."Registration No.";
          VrstaPrihoda := AddTaxPS."Revenue Type";
          Opstina := CompInfo."Municipality Code";
          PorezniPeriodOd := StartDate;
          PorezniPeriodDo := EndDate;
          Iznos := ROUND(FAmount,0.00001);
          WHeaderNo := WHeader."No.";
          WHeaderEntryNo := WHeader."Entry No.";
          WPaymentType := WPaymentType::"Add. Tax";
          Contribution:='Posebni doprinosi '+AddTaxPS."Add. Tax Code";
        
          PozivNaBroj := '00000000';
          IF WHeader."Month Of Wage" < 10 THEN
           PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
          ELSE
           PozivNaBroj += FORMAT(WHeader."Month Of Wage");
        
          MakePaymentOrder;
         END;
        UNTIL AddTax.NEXT = 0;*/

    end;

    procedure UOD(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");

                Emp.SETRANGE("Bank No.", RBanks.Code);
                Emp.SETFILTER("Temporary Contract Type", '%1|%2|%3', 1, 2, 3);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    wc.SetRange("Wage Header No.", WHeader."No.");
                                    //ĐK   WC.SETRANGE(Calculated, FALSE);
                                    IF WC.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction";
                                            AdditionAmountForPayment += WC.Transport;
                                            AdditionAmountForPaymentMeal += WC."Meal to pay";
                                            WC.CALCFIELDS("Regres Netto");
                                            RegresAmount += WC."Regres Netto";

                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA NAKNADE' + ' ' + Emp."First Name" + ' ' + Emp."Last Name";
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';

                                WType := 1;
                                Tip := 1;
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                SvrhaDoznake3 := Emp."No.";

                                Contribution := 'Ugovor o djelu';
                                DatumUplate := WHeader."Payment Date";
                                Sifra := CompInfo."Entity Code";
                                MakePaymentOrder;
                                WC.Calculated := TRUE;

                                WC.MODIFY;
                            END;




                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure PlatePoBankamaPoslovnice(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        WC.SETRANGE("Wage Calculation Type", 0);
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    IF WC.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;
                                            IF ((WC."Contribution Category Code" = 'FBIHRS') OR (WC."Contribution Category Code" = 'BDPIORS')) THEN
                                                AmountForPayment += WC."Tax Basis (RS)" - WC."Tax (RS)" - WC."Wage Reduction"
                                            ELSE
                                                AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction";

                                            AdditionAmountForPayment += WC.Transport;
                                            AdditionAmountForPaymentMeal += WC."Meal to pay";
                                            WC.CALCFIELDS("Regres Netto");
                                            RegresAmount += WC."Regres Netto";

                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;

                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //NK SvrhaDoznake1 := 'UPLATA PLAĆE'+' '+Emp."First Name"+' '+Emp."Last Name";
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'PLAĆA';
                                Emp.CALCFIELDS("Org Dio");
                                OrgDio := Emp."Org Dio";

                                MakePaymentOrder;

                            END;
                            IF AdditionAmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //SvrhaDoznake1 := 'UPLATA PREVOZA'+' '+Emp."First Name"+' '+Emp."Last Name";
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AdditionAmountForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'PREVOZ';
                                Emp.CALCFIELDS("Org Dio");
                                OrgDio := Emp."Org Dio";
                                MakePaymentOrder;
                            END;

                            IF AdditionAmountForPaymentMeal > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                // SvrhaDoznake1 := 'UPLATA TOPLOG OBROKA' +' '+Emp."First Name"+' '+Emp."Last Name";;
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AdditionAmountForPaymentMeal, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'TOPLI OBROK';
                                Emp.CALCFIELDS("Org Dio");
                                OrgDio := Emp."Org Dio";
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF RegresAmount > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //NK SvrhaDoznake1 := 'UPLATA PLAĆE'+' '+Emp."First Name"+' '+Emp."Last Name";
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(RegresAmount, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'REGRES';
                                Emp.CALCFIELDS("Org Dio");
                                OrgDio := Emp."Org Dio";
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;
                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure DoprinosiPoslovnice(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        Employee: Record "Employee";
    begin

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.00001);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.00001);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := AddTaxPE."Wage Calculation Type";
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := AddTaxPE."Wage Calculation Type";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'FBIH');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001);
                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            ;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                     PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2|%3', 'FBIH', 'FBIHRS', 'BDPIOFBIH');
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;


        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

        //Posebni porezi fond
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    /*NE  procedure DoprinosiP(var WHeader: Record "Wage Header"; var Mnc: Record "Municipality")
     var
         CantonTemp: Record "Canton" temporary;
         PKan: Decimal;
         PFed: Decimal;
         Canton: Record "Canton";
         Emp: Record "Employee";
         AddTax: Record "Contribution";
         AddTaxPE: Record "Contribution Per Employee";
         FAmount: Decimal;
         KAmount: Decimal;
         TempAmount: Decimal;
         AddTaxPS: Record "Contribution Payments Setup";
         StartDate: Date;
         EndDate: Date;
         Municipality: Record "Municipality";
         MunicipalityTemp: Record "Municipality";
         DepartmentTemp: Record "Department";
     begin
         CompInfo.GET;
         CompInfo.TESTFIELD("Bank No. 1");
         BankAccounts.GET(CompInfo."Bank No. 1");
         FAmount := 0;
         KAmount := 0;
         TempAmount := 0;

         POrdersbyBO.RESET;
         POrdersbyBO.SETRANGE("Wage Header No.", WHeader."No.");
         POrdersbyBO.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
         POrdersbyBO.SETRANGE("Wage Payment Type", POrdersbyBO."Wage Payment Type"::"Add. Tax");
         //NK POrders.DELETEALL;

         StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
         EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
         EndDate := CALCDATE('<+1M>', EndDate);
         EndDate := CALCDATE('<-1D>', EndDate);

         //Nezaposleni
         WageSetup.GET;
         WageSetup.TESTFIELD("Unemployment Federation");
         WageSetup.TESTFIELD("Unemployment Canton");
         PKan := WageSetup."Unemployment Canton";
         PFed := WageSetup."Unemployment Federation";


         AddTax.RESET;
         AddTax.SETRANGE(Type, AddTax.Type::Unemployment);


         AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                                "Contribution Code", "Employee No.");
         AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
         AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
         AddTaxPE.SETRANGE("Wage Calculation Type", 0);
         AddTaxPE.SETRANGE("Contribution Category Code", 'FBIH');


         IF AddTax.FINDFIRST THEN
             REPEAT
                 AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                 Emp.RESET;

                 Emp.SETFILTER("Municipality Code CIPS", Mnc.Code);
                 //Emp.SETFILTER("Municipality Code CIPS",'109');
                 IF Emp.FINDFIRST THEN
                     REPEAT
                         AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                         AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                         TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                         IF TempAmount > 0 THEN BEGIN
                             IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS",MunicipalityTemp.Type::Regular) THEN BEGIN
                                 Municipality.GET(Emp."Municipality Code CIPS",Municipality.Type::Regular);
                                 MunicipalityTemp.INIT;
                                 MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                 MunicipalityTemp.INSERT;
                             END;

                             Emp.CALCFIELDS("Org Dio");
                             //DepartmentTemp.SETFILTER("Department Type",'%1',DepartmentTemp."Department Type"::"Branch Office");  //zakomentarisanoo
                             //DepartmentTemp.SETFILTER(Municipality,'%1', Emp."Municipality Code CIPS");
                             DepartmentTemp.SETFILTER("ORG Dio", '%1', Emp."Org Dio");
                             //DepartmentTemp.SETFILTER(Municipality,'%1',MunicipalityTemp.Code);//department filtrira po id org dijela iz emp.org dio
                             //Emp.CALCFIELDS("Department code");
                             //DepartmentTemp.SETFILTER(Municipality,'%1', Emp."Municipality Code CIPS");

                             IF DepartmentTemp.FIND('-') THEN BEGIN
                                 DepartmentTemp.Amount += ROUND(TempAmount * PKan / 100, 0.00001);
                                 DepartmentTemp.MODIFY;
                             END;

                             MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.00001);
                             MunicipalityTemp.MODIFY;
                             FAmount += ROUND(DepartmentTemp.Amount * PFed / 100, 0.00001);
                             KAmount += ROUND(DepartmentTemp.Amount * PKan / 100, 0.00001);


                         END;
                     UNTIL Emp.NEXT = 0;
             UNTIL AddTax.NEXT = 0;

         IF FAmount > 0 THEN BEGIN
             AddTaxPS.RESET;
             AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
             AddTaxPS.SETRANGE(Code, 'FBIH');
             AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
             AddTaxPS.FINDFIRST;
             InitPaymentOrderbyBO;
             SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
             SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
             SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
             Primalac1 := AddTaxPS."Payment Receiver1";
             Primalac2 := AddTaxPS."Payment Receiver2";
             Primalac3 := AddTaxPS."Payment Receiver3";

             RacunPosiljaoca := BankAccounts."Bank Account No.";
             RacunPrimaoca := AddTaxPS."Payment Account";
             BrojPoreznogObaveznika := CompInfo."Registration No.";
             VrstaPrihoda := AddTaxPS."Revenue Type";
             Opstina := CompInfo."Municipality Code";
             PorezniPeriodOd := StartDate;
             PorezniPeriodDo := EndDate;
             Tip := 0;
             Sifra := 'FBIH';
             Iznos := ROUND(FAmount, 0.00001);
             WHeaderNo := WHeader."No.";
             WHeaderEntryNo := WHeader."Entry No.";
             WPaymentType := WPaymentType::"Add. Tax";
             Contribution := 'Doprinosi za nezaposlenost';
             BudgetOrg := AddTaxPS."Budget Organisation";
             WType := 0;
             IF WHeader."Month Of Wage" <= 9 THEN
                 PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
             ELSE
                 PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
             CompanyInfo.get();
             if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
             DatumUplate := WHeader."Payment Date";
             MakePaymentOrderbyBO;
         END;

         *******************************Nezaposlenost**************************************************
         IF KAmount > 0 THEN BEGIN
             IF MunicipalityTemp.FIND('-') THEN
                 REPEAT
                     //Department.SETFILTER("Department Type",'%1',Department."Department Type"::"Branch Office");   //zakomentarisanooo
                     Department.SETFILTER(Municipality, '%1', MunicipalityTemp.Code);
                     IF Department.FIND('-') THEN
                         REPEAT

                             AddTaxPS.RESET;
                             AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                             Department.CALCFIELDS(Municipality);
                             AddTaxPS.SETRANGE(Code, Department.Municipality);
                             AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                             IF AddTaxPS.FINDFIRST THEN;

                             InitPaymentOrderbyBO;

                             SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                             SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                             SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                             Primalac1 := AddTaxPS."Payment Receiver1";
                             Primalac2 := AddTaxPS."Payment Receiver2";
                             Primalac3 := 'Opština ' + Mnc.Name;//MunicipalityTemp.Name;     //zakomentarisano
                             RacunPosiljaoca := BankAccounts."Bank Account No.";
                             RacunPrimaoca := AddTaxPS."Payment Account";

                             OD.SETFILTER(Code, '%1', Department."ORG Dio");
                             IF OD.FINDFIRST THEN BrojPoreznogObaveznika := OD."Registration No.";  //CompInfo."Registration No."; //zakomentarisano

                             VrstaPrihoda := AddTaxPS."Revenue Type";
                             Opstina := Mnc.Code;             //COPYSTR(FORMAT(Department.Municipality),1,4);;  //zakomentarisano
                             BranchOfficeCode := Department."ORG Dio";

                             PorezniPeriodOd := StartDate;
                             PorezniPeriodDo := EndDate;
                             Iznos := ROUND(Department.Amount, 0.00001);
                             WHeaderNo := WHeader."No.";
                             WHeaderEntryNo := WHeader."Entry No.";
                             WPaymentType := WPaymentType::"Add. Tax";
                             Contribution := 'Doprinosi za nezaposlenost';
                             BudgetOrg := AddTaxPS."Budget Organisation";
                             Tip := 1;
                             Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                             WType := 0;
                             MunEntity.GET(Opstina);
                             MunEntity.CALCFIELDS("Entity Code");
                             if MunEntity."Entity Code" = 'FBIH' then begin
                                 IF WHeader."Month Of Wage" <= 9 THEN
                                     PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                                 ELSE
                                     PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                             end else begin
                                 CompanyInfo.get();
                                 if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                             end;
                             DatumUplate := WHeader."Payment Date";
                             IF Iznos > 0 THEN
                                 MakePaymentOrderbyBO;
                         UNTIL Department.NEXT = 0;
                 UNTIL MunicipalityTemp.NEXT = 0;
         END;



         *******************************Zdravstvo******************************************************

         WageSetup.GET;
         WageSetup.TESTFIELD("Health Federation");
         WageSetup.TESTFIELD("Health Canton");
         PKan := WageSetup."Health Canton";
         PFed := WageSetup."Health Federation";

         AddTax.RESET;
         AddTax.SETRANGE(Type, AddTax.Type::Health);


         AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                                "Contribution Code", "Employee No.");
         AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
         AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
         AddTaxPE.SETRANGE("Wage Calculation Type", 0);
         AddTaxPE.SETRANGE("Contribution Category Code", 'FBIH');


         IF AddTax.FINDFIRST THEN
             REPEAT
                 AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                 Emp.RESET;

                 Emp.SETFILTER("Municipality Code CIPS", Mnc.Code);
                 IF Emp.FINDFIRST THEN
                     REPEAT
                         AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                         AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                         TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                         IF TempAmount > 0 THEN BEGIN
                             IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS",MunicipalityTemp.Type::Regular) THEN BEGIN
                                 Municipality.GET(Emp."Municipality Code CIPS",Municipality.Type::Regular);
                                 MunicipalityTemp.INIT;
                                 MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                 MunicipalityTemp.INSERT;
                             END;

                             Emp.CALCFIELDS("Org Dio");
                             DepartmentTemp.SETFILTER("ORG Dio", '%1', Emp."Org Dio");
                             IF DepartmentTemp.FIND('-') THEN BEGIN
                                 DepartmentTemp.AmountHealth += ROUND(TempAmount * PKan / 100, 0.00001);
                                 DepartmentTemp.MODIFY;
                             END;

                             MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.00001);
                             MunicipalityTemp.MODIFY;
                             FAmount += ROUND(DepartmentTemp.AmountHealth * PFed / 100, 0.00001);
                             KAmount += ROUND(DepartmentTemp.AmountHealth * PKan / 100, 0.00001);
                         END;
                     UNTIL Emp.NEXT = 0;
             UNTIL AddTax.NEXT = 0;

         IF FAmount > 0 THEN BEGIN
             AddTaxPS.RESET;
             AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
             AddTaxPS.SETRANGE(Code, 'FBIH');
             AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
             AddTaxPS.FINDFIRST;
             InitPaymentOrderbyBO;
             SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
             SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
             SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
             Primalac1 := AddTaxPS."Payment Receiver1";
             Primalac2 := AddTaxPS."Payment Receiver2";
             Primalac3 := AddTaxPS."Payment Receiver3";

             RacunPosiljaoca := BankAccounts."Bank Account No.";
             RacunPrimaoca := AddTaxPS."Payment Account";
             BrojPoreznogObaveznika := CompInfo."Registration No.";
             VrstaPrihoda := AddTaxPS."Revenue Type";
             Opstina := CompInfo."Municipality Code";
             PorezniPeriodOd := StartDate;
             PorezniPeriodDo := EndDate;
             Tip := 0;
             Sifra := 'FBIH';
             Iznos := ROUND(FAmount, 0.00001);
             WHeaderNo := WHeader."No.";
             WHeaderEntryNo := WHeader."Entry No.";
             WPaymentType := WPaymentType::"Add. Tax";
             Contribution := 'Doprinosi za zdravstvo';
             BudgetOrg := AddTaxPS."Budget Organisation";
             WType := 0;
             IF WHeader."Month Of Wage" <= 9 THEN
                 PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
             ELSE
                 PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
             CompanyInfo.get();
             if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
             DatumUplate := WHeader."Payment Date";
             MakePaymentOrderbyBO;
         END;

         IF KAmount > 0 THEN BEGIN
             IF MunicipalityTemp.FIND('-') THEN
                 REPEAT
                     Department.SETFILTER(Municipality, '%1', MunicipalityTemp.Code);
                     IF Department.FIND('-') THEN
                         REPEAT

                             AddTaxPS.RESET;
                             AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                             Department.CALCFIELDS(Municipality);
                             AddTaxPS.SETRANGE(Code, Department.Municipality);
                             AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);

                             IF AddTaxPS.FINDFIRST THEN;

                             InitPaymentOrderbyBO;

                             SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                             SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                             SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                             Primalac1 := AddTaxPS."Payment Receiver1";
                             Primalac2 := AddTaxPS."Payment Receiver2";
                             Primalac3 := 'Opština ' + Mnc.Name;//MunicipalityTemp.Name;     //zakomentarisano
                             RacunPosiljaoca := BankAccounts."Bank Account No.";
                             RacunPrimaoca := AddTaxPS."Payment Account";

                             OD.SETFILTER(Code, '%1', Department."ORG Dio");
                             IF OD.FINDFIRST THEN BrojPoreznogObaveznika := OD."Registration No.";  //CompInfo."Registration No."; //zakomentarisano

                             VrstaPrihoda := AddTaxPS."Revenue Type";
                             Opstina := Mnc.Code;             //COPYSTR(FORMAT(Department.Municipality),1,4);;  //zakomentarisano
                             BranchOfficeCode := Department."ORG Dio";

                             PorezniPeriodOd := StartDate;
                             PorezniPeriodDo := EndDate;
                             Iznos := ROUND(Department.AmountHealth, 0.00001);
                             WHeaderNo := WHeader."No.";
                             WHeaderEntryNo := WHeader."Entry No.";
                             WPaymentType := WPaymentType::"Add. Tax";
                             Contribution := 'Doprinosi za zdravstvo';
                             BudgetOrg := AddTaxPS."Budget Organisation";
                             Tip := 1;
                             Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                             WType := 0;
                             MunEntity.GET(Opstina);
                             MunEntity.CALCFIELDS("Entity Code");
                             if MunEntity."Entity Code" = 'FBIH' then begin
                                 IF WHeader."Month Of Wage" <= 9 THEN
                                     PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                                 ELSE
                                     PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                             end
                             else begin
                                 CompanyInfo.get();
                                 if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                             end;
                             DatumUplate := WHeader."Payment Date";
                             IF Iznos > 0 THEN
                                 MakePaymentOrderbyBO;
                         UNTIL Department.NEXT = 0;
                 UNTIL MunicipalityTemp.NEXT = 0;
         END;

         *******************************Zdravstvo******************************************************
         //PIO
         AddTax.RESET;
         AddTax.SETRANGE(Type, AddTax.Type::PIO);
         FAmount := 0;
         AddTaxPE.RESET;
         AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                                "Contribution Code", "Employee No.");
         AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
         AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
         AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2|%3', 'FBIH', 'FBIHRS', 'BDPIOFBIH');
         AddTaxPE.SETRANGE("Wage Calculation Type", 0);

         IF AddTax.FINDFIRST THEN
             REPEAT
                 AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                 Emp.RESET;
                 IF Emp.FINDFIRST THEN
                     REPEAT
                         AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                         AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                         TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                         FAmount += TempAmount;
                     UNTIL Emp.NEXT = 0;
             UNTIL AddTax.NEXT = 0;

         IF FAmount > 0 THEN BEGIN
             AddTaxPS.RESET;
             AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
             AddTaxPS.SETRANGE(Code, 'FBIH');
             AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
             AddTaxPS.FINDFIRST;
             InitPaymentOrder;
             SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
             SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
             SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
             Primalac1 := AddTaxPS."Payment Receiver1";
             Primalac2 := AddTaxPS."Payment Receiver2";
             Primalac3 := AddTaxPS."Payment Receiver3";
             Tip := 1;
             Sifra := AddTaxPS.Code;
             WType := 0;

             RacunPosiljaoca := BankAccounts."Bank Account No.";
             RacunPrimaoca := AddTaxPS."Payment Account";
             BrojPoreznogObaveznika := CompInfo."Registration No.";
             VrstaPrihoda := AddTaxPS."Revenue Type";
             Opstina := CompInfo."Municipality Code";
             PorezniPeriodOd := StartDate;
             PorezniPeriodDo := EndDate;

             Iznos := ROUND(FAmount, 0.00001);
             WHeaderNo := WHeader."No.";
             WHeaderEntryNo := WHeader."Entry No.";
             WPaymentType := WPaymentType::"Add. Tax";
             Contribution := 'Doprinosi PIO';
             BudgetOrg := AddTaxPS."Budget Organisation";
             IF WHeader."Month Of Wage" <= 9 THEN
                 PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
             ELSE
                 PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
             CompanyInfo.get();
             if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
             DatumUplate := WHeader."Payment Date";
             MakePaymentOrderbyBO;
         END;

         //Posebni porezi
         AddTax.RESET;
         AddTax.SETRANGE(Type, AddTax.Type::Special);
         Canton.GET(CompInfo.County, CompInfo."Entity Code");
         FAmount := 0;
         AddTaxPE.RESET;
         AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                                "Contribution Code", "Employee No.");
         AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
         AddTaxPE.SETRANGE("Wage Calculation Type", 0);
         IF AddTax.FINDFIRST THEN
             REPEAT
                 AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                 FAmount := 0;
                 Emp.RESET;
                 IF Emp.FINDFIRST THEN
                     REPEAT
                         AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                         AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                         TempAmount := AddTaxPE."Amount Over Neto";
                         FAmount += TempAmount;
                     UNTIL Emp.NEXT = 0;
                 IF FAmount > 0 THEN BEGIN
                     AddTaxPS.RESET;
                     AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                     AddTaxPS.SETRANGE(Code, 'FBIH');
                     AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                     AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                     AddTaxPS.FINDFIRST;
                     InitPaymentOrder;
                     SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                     SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                     SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                     Primalac1 := AddTaxPS."Payment Receiver1";
                     Primalac2 := AddTaxPS."Payment Receiver2";
                     Primalac3 := Canton.Description;
                     Tip := 0;
                     Sifra := 'FBIH';
                     WType := 0;
                     RacunPosiljaoca := BankAccounts."Bank Account No.";
                     RacunPrimaoca := AddTaxPS."Payment Account";
                     BrojPoreznogObaveznika := CompInfo."Registration No.";
                     VrstaPrihoda := AddTaxPS."Revenue Type";
                     Opstina := CompInfo."Municipality Code";
                     PorezniPeriodOd := StartDate;
                     PorezniPeriodDo := EndDate;
                     Iznos := ROUND(FAmount, 0.00001);
                     WHeaderNo := WHeader."No.";
                     WHeaderEntryNo := WHeader."Entry No.";
                     WPaymentType := WPaymentType::"Add. Tax";
                     BudgetOrg := AddTaxPS."Budget Organisation";
                     Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                     IF WHeader."Month Of Wage" <= 9 THEN
                         PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                     ELSE
                         PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                     CompanyInfo.get();
                     if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                     DatumUplate := WHeader."Payment Date";
                     MakePaymentOrderbyBO;
                 END;
             UNTIL AddTax.NEXT = 0;

         //Posebni porezi fond
         AddTax.RESET;
         AddTax.SETRANGE(Type, AddTax.Type::Special);
         Canton.GET(CompInfo.County, CompInfo."Entity Code");
         FAmount := 0;
         AddTaxPE.RESET;
         AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                                "Contribution Code", "Employee No.");
         AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
         AddTaxPE.SETRANGE("Wage Calculation Type", 0);

         IF AddTax.FINDFIRST THEN
             REPEAT
                 AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                 FAmount := 0;


                 AddTaxPE.SETRANGE("Employee No.", '');
                 AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                 TempAmount := AddTaxPE."Amount Over Neto";
                 FAmount += TempAmount;

                 IF FAmount > 0 THEN BEGIN
                     AddTaxPS.RESET;
                     AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                     AddTaxPS.SETRANGE(Code, 'FBIH');
                     AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                     AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                     AddTaxPS.FINDFIRST;
                     InitPaymentOrder;
                     SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                     SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                     SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                     Primalac1 := AddTaxPS."Payment Receiver1";
                     Primalac2 := AddTaxPS."Payment Receiver2";
                     Primalac3 := Canton.Description;
                     Tip := 0;
                     Sifra := 'FBIH';
                     WType := 0;
                     RacunPosiljaoca := BankAccounts."Bank Account No.";
                     RacunPrimaoca := AddTaxPS."Payment Account";
                     BrojPoreznogObaveznika := CompInfo."Registration No.";
                     VrstaPrihoda := AddTaxPS."Revenue Type";
                     Opstina := CompInfo."Municipality Code";
                     PorezniPeriodOd := StartDate;
                     PorezniPeriodDo := EndDate;
                     Iznos := ROUND(FAmount, 0.00001);
                     WHeaderNo := WHeader."No.";
                     WHeaderEntryNo := WHeader."Entry No.";
                     WPaymentType := WPaymentType::"Add. Tax";
                     BudgetOrg := AddTaxPS."Budget Organisation";
                     Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                     IF WHeader."Month Of Wage" <= 9 THEN
                         PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                     ELSE
                         PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                     CompanyInfo.get();
                     if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                     DatumUplate := WHeader."Payment Date";
                     MakePaymentOrderbyBO;
                 END;
             UNTIL AddTax.NEXT = 0;

     end;
 kraj*/
    /*ĐK procedure MakePaymentOrderbyBO()
    var
        PayOrderNoBO: Integer;
        pOrder: Record "Payment Order by Branch Office";
    begin
        pOrder.InitPaymentOrder;
        i += 1;
        pOrder.InsertPaymentOrderValues1(
        SvrhaDoznake1,
        SvrhaDoznake2,
        SvrhaDoznake3,
        Primalac1,
        Primalac2,
        Primalac3,
        RacunPosiljaoca,
        RacunPrimaoca,
        Iznos, Contribution,
        Tip,
        Sifra,
        WType,
        OrgDio,
        BranchOfficeCode);

        pOrder.InsertPaymentOrderValues2(
        BrojPoreznogObaveznika,
        VrstaPrihoda,
        Opstina,
        PozivNaBroj,
        PorezniPeriodOd,
        PorezniPeriodDo,
        WHeaderNo,
        WHeaderEntryNo,
        WPaymentType,
        Contribution,
        Tip,
        Sifra,
        WType,
        OrgDio);
        PayOrderNoBO := pOrder.InsertPaymentOrder;
        COMMIT;
        pOrder.GET(PayOrderNoBO);
        IF WithConfirm THEN PAGE.RUNMODAL(PAGE::"Payment Orders", pOrder);
    end;*/

    procedure InitPaymentOrderbyBO()
    begin
        CLEAR(SvrhaDoznake1);
        CLEAR(SvrhaDoznake2);
        CLEAR(SvrhaDoznake3);
        CLEAR(Primalac1);
        CLEAR(Primalac2);
        CLEAR(Primalac3);
        CLEAR(RacunPosiljaoca);
        CLEAR(RacunPrimaoca);
        CLEAR(Iznos);
        CLEAR(BrojPoreznogObaveznika);
        CLEAR(VrstaPrihoda);
        CLEAR(Opstina);
        CLEAR(PozivNaBroj);
        CLEAR(PorezniPeriodOd);
        CLEAR(PorezniPeriodDo);
        CLEAR(WHeaderNo);
        CLEAR(WHeaderEntryNo);
        CLEAR(WPaymentType);
        CLEAR(Contribution);
        CLEAR(WType);
    end;

    /*ĐK  procedure PoreziP(var WHeader: Record "Wage Header"; var Mun: Record "Municipality")
     var
         TaxPE: Record "Tax Per Employee";
         FAmount: Decimal;
         Canton: Record "Canton";
         AddTaxPS: Record "Contribution Payments Setup";
         Emp: Record "Employee";
         DepartmentTemp: Record "Department";
     begin
         CompInfo.GET;
         CompInfo.TESTFIELD("Bank No. 1");
         BankAccounts.GET(CompInfo."Bank No. 1");
         FAmount := 0;
         POrders.RESET;
         POrders.SETRANGE("Wage Header No.", WHeader."No.");
         POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
         POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);

         StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
         EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
         EndDate := CALCDATE('<+1M>', EndDate);
         EndDate := CALCDATE('<-1D>', EndDate);

         TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
         TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
         //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
         TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
         IF TaxPE.FINDFIRST THEN
             REPEAT
                 Emp.RESET;
                 Emp.SETFILTER("No.", TaxPE."Employee No.");// Emp.SETFILTER("Municipality Code CIPS",Mun.Code);
                 IF Emp.FINDFIRST THEN BEGIN
                     //TaxPE.SETRANGE("Wage Header No.",WHeader."No.");
                     //TaxPE.SETRANGE("Employee No.",Emp."No.");
                     //IF TaxPE.FINDFIRST THEN BEGIN
                     Emp.CALCFIELDS("Org Dio");
                     DepartmentTemp.RESET;
                     DepartmentTemp.SETFILTER("ORG Dio", '%1', Emp."Org Dio");
                     IF DepartmentTemp.FIND('-') THEN BEGIN
                         DepartmentTemp.AmountTax += ROUND(TaxPE.Amount, 0.00001);
                         DepartmentTemp.MODIFY;
                     END;
                     //FAmount+=DepartmentTemp.AmountTax;

                 END;
             //UNTIL Emp.NEXT=0;
             UNTIL TaxPE.NEXT = 0;

         Department.RESET;
         // Department.CALCFIELDS(Municipality);
         // Department.SETFILTER(Municipality,'%1',Mun.Code);
         IF Department.FIND('-') THEN
             REPEAT
                 IF Department.AmountTax > 0 THEN BEGIN
                     AddTaxPS.RESET;
                     AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                     IF Mun."DP Code" <> 'REG1' THEN
                         AddTaxPS.SETRANGE(Code, Mun.Code)
                     ELSE BEGIN
                         CompInfo.GET;
                         AddTaxPS.SETRANGE(Code, CompInfo."Municipality Code");
                     END;
                     AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                     AddTaxPS.FINDFIRST;

                     InitPaymentOrder;
                     SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                     SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                     SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";  //'Opština '+Mun.Name;  //zakomentarisano
                     Primalac1 := AddTaxPS."Payment Receiver1";
                     Primalac2 := AddTaxPS."Payment Receiver2";
                     Primalac3 := 'Opština ' + Mun.Name;      // Primalac3 := Canton.Description; //zakomentarisano
                     Tip := 2;
                     Sifra := AddTaxPS.Code;
                     WType := 0;
                     RacunPosiljaoca := BankAccounts."Bank Account No.";
                     RacunPrimaoca := AddTaxPS."Payment Account";
                     OD.RESET;
                     OD.SETFILTER(Code, '%1', Department."ORG Dio");
                     IF OD.FINDFIRST THEN BrojPoreznogObaveznika := OD."Registration No.";  //CompInfo."Registration No."; //zakomentarisano
                     BranchOfficeCode := Department."ORG Dio";
                     VrstaPrihoda := AddTaxPS."Revenue Type";
                     Opstina := Mun."Tax Number";
                     PorezniPeriodOd := StartDate;
                     PorezniPeriodDo := EndDate;

                     Iznos := ROUND(Department.AmountTax, 0.00001);
                     WHeaderNo := WHeader."No.";
                     WHeaderEntryNo := WHeader."Entry No.";
                     WPaymentType := WPaymentType::"Add. Tax";
                     BudgetOrg := AddTaxPS."Budget Organisation";
                     Contribution := 'Porez';
                     MunEntity.GET(Opstina);
                     MunEntity.CALCFIELDS("Entity Code");
                     if MunEntity."Entity Code" = 'FBIH' then begin
                         IF WHeader."Month Of Wage" <= 9 THEN
                             PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                         ELSE
                             PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                     end
                     else begin
                         CompanyInfo.get();
                         if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                     end;
                     DatumUplate := WHeader."Payment Date";
                     MakePaymentOrderbyBO;
                 END;
             UNTIL Department.NEXT = 0;


     end;
 */
    procedure DodaciPoBankama(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WA.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WA.SETRANGE("Wage Header No.", WHeader."No.");
        WA.SETRANGE(Paid, FALSE);
        //WC.SETRANGE("Wage Calculation Type",0);
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WA.SETRANGE("Employee No.", Emp."No.");
                                    IF WA.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            AmountForPayment += round(WA."Amount to Pay", 0.01, '=');
                                            WA.Paid := TRUE;
                                            WA.MODIFY;


                                        UNTIL WA.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //Emp.get(SvrhaDoznake3);
                                //SvrhaDoznake1 := Emp."Party No.";
                                //djemina
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := copystr('UPLATA DODATAKA ZA ' + RBankAccounts."No." + ' ' + format(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.', 1, 50);
                                /*IF Single THEN
                                SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE*/
                                SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.00001);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'DODACI';
                                WType := 4;
                                DatumUplate := WHeader."Closing Date";
                                MakePaymentOrder;
                                WA.Paid := TRUE;
                                WA.MODIFY;
                            END;


                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;

    end;

    procedure DoprinosiDodaci(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        Municipality2: Record "Municipality";
        MunicipalityTemp2: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        //AddTaxPE.SETRANGE("Contribution Category Code",'FBIH');
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("Calculate Wage Addition", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.00001, '=');
                            MunicipalityTemp.MODIFY;

                            IF NOT MunicipalityTemp2.GET(Emp."Municipality Code for salary") THEN BEGIN
                                Municipality2.GET(Emp."Municipality Code for salary");
                                MunicipalityTemp2.INIT;
                                MunicipalityTemp2.TRANSFERFIELDS(Municipality2, TRUE);
                                MunicipalityTemp2.INSERT;
                            END;
                            MunicipalityTemp2."For Calculation FA" += ROUND(TempAmount * PFed / 100, 0.00001, '=');
                            MunicipalityTemp2.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001, '=');
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001, '=');
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            //MunicipalityTemp2.SETFILTER("For Calculation FA",'<>%1',0);
            //IF MunicipalityTemp2.FIND('-') THEN REPEAT
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            CompanyInfo.GET;
            Opstina := CompanyInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 1;
            MunicipalityTemp2.CALCFIELDS("Entity Code");

            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            BudgetOrg := AddTaxPS."Budget Organisation";
            WType := 4;
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
            //  UNTIL MunicipalityTemp2.NEXT = 0;
        END;

        IF KAmount > 0 THEN BEGIN
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'FBIH';

                    WType := 4;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;
        /**************************************************Health*********************************************/
        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        //AddTaxPE.SETFILTER("Contribution Category Code",'%1','FBIH');
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("Calculate Wage Addition", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.00001);
                            MunicipalityTemp.MODIFY;

                            IF NOT MunicipalityTemp2.GET(Emp."Municipality Code for salary") THEN BEGIN
                                Municipality2.GET(Emp."Municipality Code for salary");
                                MunicipalityTemp2.INIT;
                                MunicipalityTemp2.TRANSFERFIELDS(Municipality2, TRUE);
                                MunicipalityTemp2.INSERT;
                            END;
                            MunicipalityTemp2."For Calculation FA 2" += ROUND(TempAmount * PFed / 100, 0.00001, '=');
                            MunicipalityTemp2.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.00001);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.00001);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            // MunicipalityTemp2.SETFILTER("For Calculation FA 2",'<>%1',0);
            // IF MunicipalityTemp2.FIND('-') THEN REPEAT
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            MunicipalityTemp2.CALCFIELDS("Entity Code");
            Sifra := 'FBIH';
            WType := 4;
            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            CompanyInfo.GET;
            Opstina := CompanyInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            ;
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
            //UNTIL MunicipalityTemp2.NEXT=0;
        END;

        IF KAmount > 0 THEN BEGIN
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.00001);
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'FBIH';
                    WType := 4;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        /**************************************************PIO*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("Calculate Wage Addition", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                        IF NOT MunicipalityTemp2.GET(Emp."Municipality Code for salary") THEN BEGIN
                            Municipality2.GET(Emp."Municipality Code for salary");
                            MunicipalityTemp2.INIT;
                            MunicipalityTemp2.TRANSFERFIELDS(Municipality2, TRUE);
                            MunicipalityTemp2.INSERT;
                        END;
                        MunicipalityTemp2."For Calculation FA 3" += ROUND(TempAmount, 0.00001, '=');
                        MunicipalityTemp2.MODIFY;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            MunicipalityTemp2.SETFILTER("For Calculation FA 3", '<>%1', 0);
            IF MunicipalityTemp2.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := AddTaxPS."Payment Receiver3";
                    Tip := 1;
                    MunicipalityTemp2.CALCFIELDS("Entity Code");
                    Sifra := MunicipalityTemp2."Entity Code";
                    WType := 4;

                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp2.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(MunicipalityTemp2."For Calculation FA 3", 0.00001);
                    ;
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi PIO';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunicipalityTemp2.CALCFIELDS("Entity Code");
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    MakePaymentOrder;
                UNTIL MunicipalityTemp2.NEXT = 0;
        END;

        //Posebni porezi
        /*AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::Special);
        AddTax.SETRANGE(Code,'P-ELNEP');
        Canton.GET(CompInfo.County,CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Contribution Code",'P-ELNEP');
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        IF AddTax.FINDFIRST THEN REPEAT
        // AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
        
         FAmount := 0;
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Neto","Amount Over Wage");
          TempAmount := AddTaxPE."Amount Over Neto";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
         IF FAmount > 0 THEN BEGIN
          AddTaxPS.RESET;
          AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
          AddTaxPS.SETRANGE(Code,'FBIH');
          AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Special);
          AddTaxPS.SETRANGE("Add. Tax Code",'P-ELNEP');
          AddTaxPS.FINDFIRST;
          InitPaymentOrder;
          SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
          SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
          SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
          Primalac1 := AddTaxPS."Payment Receiver1";
          Primalac2 := AddTaxPS."Payment Receiver2";
          Primalac3 := Canton.Description;
         Tip:=0;
         Sifra:='FBIH';
          WType:=0;
          RacunPosiljaoca := BankAccounts."Bank Account No.";
          RacunPrimaoca := AddTaxPS."Payment Account";
          BrojPoreznogObaveznika := CompInfo."Registration No.";
          VrstaPrihoda := AddTaxPS."Revenue Type";
          Opstina :=Emp."Org Municipality" ;
          PorezniPeriodOd := StartDate;
          PorezniPeriodDo := EndDate;
          Iznos := ROUND(FAmount,0.00001);
          WHeaderNo := WHeader."No.";
          WHeaderEntryNo := WHeader."Entry No.";
          WPaymentType := WPaymentType::"Add. Tax";
          Contribution:='Posebni doprinosi '+AddTaxPS."Add. Tax Code";
        
          {PozivNaBroj := '00000000';
          IF WHeader."Month Of Wage" < 10 THEN
           PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
          ELSE
           PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
            PozivNaBroj :=AddTaxPS."Refer To Number";
                DatumUplate:=WHeader."Payment Date";
          MakePaymentOrder;
         END;
        UNTIL AddTax.NEXT = 0;*/

        /**************************************************P-VOD*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SETRANGE(Code, 'P-VOD');
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        TempAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NKN AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NKN AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETRANGE("Contribution Code", 'P-VOD');
        AddTaxPE.SETFILTER("Contribution Category Code", '<>%1', 'RS');
        IF AddTax.FINDFIRST THEN
            REPEAT

                Emp.RESET;
                Emp.SETFILTER("Calculate Wage Addition", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        //NK FAmount += TempAmount;

                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary") THEN BEGIN
                                Municipality.GET(Emp."Municipality Code for salary");
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation 3" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        //NKN IF TempAmount > 0 THEN BEGIN
        MunicipalityTemp.SETFILTER("For Calculation 3", '<>%1', 0);
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                AddTaxPS.SETRANGE("Add. Tax Code", 'P-VOD');
                AddTaxPS.FINDFIRST;
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                //  Primalac3 := Canton.Description;
                Tip := 1;
                MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := MunicipalityTemp."Entity Code";
                WType := 4;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := CompInfo."Registration No.";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := MunicipalityTemp.Code;
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Iznos := ROUND(MunicipalityTemp."For Calculation 3", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                MunicipalityTemp.CALCFIELDS("Entity Code");
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                IF Iznos > 0 THEN
                    MakePaymentOrder;
            UNTIL MunicipalityTemp.NEXT = 0;



        /**************************************************P-ELNEP*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        AddTax.SETRANGE(Code, 'P-ELNEP');
        FAmount := 0;
        TempAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NKN AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NKN AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETRANGE("Contribution Code", 'P-ELNEP');
        IF AddTax.FINDFIRST THEN
            REPEAT

                Emp.RESET;
                Emp.SETFILTER("Calculate Wage Addition", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        //NK FAmount += TempAmount;

                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary", MunicipalityTemp.Type::Regular) THEN BEGIN
                                Municipality.GET(Emp."Municipality Code for salary", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation 4" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        //NKN IF TempAmount > 0 THEN BEGIN
        MunicipalityTemp.SETFILTER("For Calculation 4", '<>%1', 0);
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                AddTaxPS.SETRANGE("Add. Tax Code", 'P-ELNEP');
                AddTaxPS.FINDFIRST;
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                //  Primalac3 := Canton.Description;
                Tip := 1;
                MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := MunicipalityTemp."Entity Code";
                WType := 4;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := CompInfo."Registration No.";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := MunicipalityTemp.Code;
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Iznos := ROUND(MunicipalityTemp."For Calculation 4", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                MunicipalityTemp.CALCFIELDS("Entity Code");
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                IF Iznos > 0 THEN
                    MakePaymentOrder;
            UNTIL MunicipalityTemp.NEXT = 0;


        /**************************************************P-FOND*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 1;
                    Sifra := 'FBIH';
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";

                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiDodaciBD(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //BD NK Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 1;
            Sifra := 'BDFBIH';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 4;
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            //NK MunicipalityTemp."For Calculation 2" += ROUND(TempAmount*PKan/100,0.00001);
                            //NK MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount, 0.00001);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 4;
            Tip := 1;
            Sifra := 'BDFBIH';

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //NK BD Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end
            else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := 'BDFBIH';
            WType := 4;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := '068';
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            IF WHeader."Month Of Wage" <= 9 THEN
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
            ELSE
                PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            CompanyInfo.get();
            if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
        END;

    end;

    procedure DoprinosiRSFBIH(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        TempAmountFBIH: Decimal;
        TempAmountFBIH2: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        _______RS_________: Integer;
        RSAmount: Decimal;
        PIOAmount: Decimal;
        ZDRAmount: Decimal;
        DJZAmount: Decimal;
        NEZAmount: Decimal;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        Municipality1: Record "Municipality";
        MunicipalityTemp1: Record "Municipality";
        Municipality2: Record "Municipality";
        MunicipalityTemp2: Record "Municipality";
        Municipality3: Record "Municipality";
        MunicipalityTemp3: Record "Municipality";
        OrgDijelovi: Record "Org Dijelovi" temporary;
        OrgDijeloviTemp: Record "Org Dijelovi" temporary;
        OrgDijelovi1: Record "ORG Dijelovi";
        OrgDijeloviTemp1: Record "ORG Dijelovi";
        OrgDijelovi2: Record "ORG Dijelovi";
        OrgDijeloviTemp2: Record "ORG Dijelovi";
        OrgDijelovi3: Record "Org Dijelovi" temporary;
        OrgDijeloviTemp3: Record "Org Dijelovi" temporary;
        OrgDijeloviTempU: Record "Org Dijelovi" temporary;
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);




        Reduction.SETFILTER(Type, '%1', 'FONSOLRS');
        Reduction.SETRANGE("Wage Header No.", WHeader."No.");
        //Reduction.SETFILTER("Employee No.",'%1',Emp."No.");
        Reduction.SETCURRENTKEY("Wage Header No.", Type);
        Reduction.CALCSUMS(Amount);
        AmountOverRed += Reduction.Amount;


        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::RS);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        SOLIDAmount := 0;
        TempAmountSpecTemp := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        IF AddTax.FIND('-') THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("Org Entity Code", '%1', 'RS');
                Emp.SETFILTER("Entity Code CIPS", '%1|%2', 'FBIH', 'BDRS');
                Emp.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
                IF Emp.FIND('-') THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                        TempAmount := AddTaxPE."Amount From Wage";
                        TempAmountSpecTemp := AddTaxPE."Amount Over Neto";
                        AmountOverTemp := AddTaxPE."Amount Over Wage";



                        IF ((TempAmount > 0) OR (TempAmountSpecTemp > 0) OR (AmountOverTemp > 0)) THEN BEGIN
                            /*  IF Emp."Org Entity Code" = 'RS' THEN BEGIN
                               RSAmount += TempAmount;

                               TempAmountSpec+=TempAmountSpecTemp;
                               AmountOver+=AmountOverTemp;

                           END;*/



                            IF ((Emp."Entity Code CIPS" = 'FBIH') OR (Emp."Entity Code CIPS" = 'BDRS')) THEN BEGIN
                                CASE AddTax.Code OF
                                    'DJEC-ZAST':
                                        BEGIN
                                            DJZAmount += TempAmount;
                                            OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                            OrgDijeloviTemp2.SETFILTER(Code, '%1', Emp."Org Jed");
                                            OrgDijeloviTemp2.SETFILTER(GF, '%1', Emp.GF);
                                            IF NOT OrgDijeloviTemp2.FINDFIRST THEN BEGIN
                                                OrgDijelovi2.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                                OrgDijelovi2.SETFILTER(Code, '%1', Emp."Org Jed");
                                                OrgDijelovi2.SETFILTER(GF, '%1', Emp.GF);
                                                IF OrgDijelovi2.FINDFIRST THEN BEGIN
                                                    OrgDijeloviTemp2.INIT;
                                                    OrgDijeloviTemp2.TRANSFERFIELDS(OrgDijelovi2, TRUE);
                                                    OrgDijeloviTemp2.INSERT;
                                                END;
                                            END;
                                            IF OrgDijeloviTemp2.FINDFIRST THEN BEGIN
                                                OrgDijeloviTemp2."For Calculation 9" += ROUND(TempAmount, 0.00001, '=');
                                                OrgDijeloviTemp2.MODIFY;
                                            END;
                                        END;
                                    'D-PIORS':
                                        BEGIN
                                            PIOAmount += TempAmount;
                                            /*IF NOT MunicipalityTemp1.GET(Emp."Municipality Code for salary") THEN BEGIN
                                             Municipality1.GET(Emp."Municipality Code for salary");
                                             MunicipalityTemp1.INIT;
                                             MunicipalityTemp1.TRANSFERFIELDS(Municipality1,TRUE);
                                             MunicipalityTemp1.INSERT;
                                             END;
                                             MunicipalityTemp1."For Calculation 8" += ROUND(TempAmount,0.00001,'=');
                                             MunicipalityTemp1.MODIFY;*/
                                            OrgDijeloviTemp1.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                            OrgDijeloviTemp1.SETFILTER(Code, '%1', Emp."Org Jed");
                                            OrgDijeloviTemp1.SETFILTER(GF, '%1', Emp.GF);
                                            IF NOT OrgDijeloviTemp1.FINDFIRST THEN BEGIN
                                                OrgDijelovi1.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                                OrgDijelovi1.SETFILTER(Code, '%1', Emp."Org Jed");
                                                OrgDijelovi1.SETFILTER(GF, '%1', Emp.GF);
                                                IF OrgDijelovi1.FINDFIRST THEN BEGIN
                                                    OrgDijeloviTemp1.INIT;
                                                    OrgDijeloviTemp1.TRANSFERFIELDS(OrgDijelovi1, TRUE);
                                                    OrgDijeloviTemp1.INSERT;
                                                END;
                                            END;
                                            IF OrgDijeloviTemp1.FINDFIRST THEN BEGIN
                                                OrgDijeloviTemp1."For Calculation 8" += ROUND(TempAmount, 0.00001, '=');
                                                OrgDijeloviTemp1.MODIFY;
                                            END;
                                        END;
                                    'D-ZDRAVRS':
                                        ZDRAmount += TempAmount;

                                    'D-ZAPOŠRS':
                                        NEZAmount += TempAmount;
                                    'P-RVI':
                                        SOLIDAmount += AmountOverTemp;
                                    'D-ZDRAV-IZ':
                                        BEGIN
                                            IF NOT CantonTemp.GET(Emp."County CIPS", Emp."Entity Code CIPS") THEN BEGIN
                                                Canton.GET(Emp."County CIPS", Emp."Entity Code CIPS");
                                                CantonTemp.INIT;
                                                CantonTemp.TRANSFERFIELDS(Canton, TRUE);
                                                CantonTemp.INSERT;

                                            END;
                                            CantonTemp."For Calculation" += TempAmount;
                                            CantonTemp.MODIFY;
                                        END;
                                END;
                            END;
                        END;

                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        /*NKRAIFF
        IF RSAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         //AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETFILTER("Add. Tax Code",'%1','');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(RSAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
        
          Sifra:='RS'+'n';
          IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
        
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;*/




        //IF PIOAmount > 0 THEN BEGIN
        /*MunicipalityTemp1.SETFILTER("For Calculation 8",'<>%1',0);
        IF MunicipalityTemp1.FIND('-') THEN REPEAT*/

        OrgDijeloviTemp1.SETFILTER("For Calculation 8", '<>%1', 0);
        OrgDijeloviTemp1.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp1.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp1.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp1.FIND('-') THEN
            REPEAT

                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FBIHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-PIORS');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";
                BudgetOrg := AddTaxPS."Budget Organisation";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := OrgDijeloviTemp1."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp1."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Sifra := 'RS';
                WType := 0;
                Tip := 1;
                Iznos := ROUND(OrgDijeloviTemp1."For Calculation 8", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                Contribution := 'Doprinosi PIO';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp1.NEXT = 0;

        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";

        /**************************************************Unemployment******************************************/
        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTaxPE.RESET;
        AddTax.SETRANGE(Code, 'D-ZAPOŠRS');
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'RS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", 'D-ZAPOŠRS');
                Emp.RESET;
                Emp.SETFILTER("Entity Code CIPS", '%1|%2', 'FBIH', 'BDRS');
                //Emp.SETFILTER("No.",'%1','1294');
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmountFBIH := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmountFBIH > 0 THEN BEGIN
                            /* IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary") THEN BEGIN
                              Municipality.GET(Emp."Municipality Code for salary");
                              MunicipalityTemp.INIT;
                              MunicipalityTemp.TRANSFERFIELDS(Municipality,TRUE);
                              MunicipalityTemp.INSERT;
                              END;


                             MunicipalityTemp."For Calculation 6" += ROUND(TempAmountFBIH,0.00001,'=');
                               MunicipalityTemp.MODIFY;*/
                            OrgDijeloviTempU.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijeloviTempU.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                            OrgDijeloviTempU.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijeloviTempU.SETFILTER(GF, '%1', Emp.GF);
                            IF NOT OrgDijeloviTempU.FINDFIRST THEN BEGIN
                                /*  OrgDijelovi.SETFILTER("Municipality Code for salary",'%1',Emp."Municipality Code for salary");
                                  OrgDijelovi.SETFILTER("Municipality Code CIPS",'%1',Emp."Municipality Code CIPS");
                                  OrgDijelovi.SETFILTER(Code,'%1',Emp."Org Jed");
                                  OrgDijelovi.SETFILTER(GF,'%1',Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                              OrgDijeloviTemp.INIT;
                              OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi,TRUE);
                              OrgDijeloviTemp.INSERT;
                              END
                              ELSE BEGIN*/
                                OrgDijeloviTempU.INIT;
                                OrgDijeloviTempU."Municipality Code for salary" := Emp."Municipality Code for salary";
                                OrgDijeloviTempU."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                                OrgDijeloviTempU.Code := Emp."Org Jed";
                                OrgDijeloviTempU.GF := Emp.GF;
                                OrgDijeloviTempU."For Calculation 6" += ROUND(TempAmountFBIH, 0.00001, '=');
                                OrgJed.RESET;
                                OrgJed.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                OrgJed.SETFILTER(Code, '%1', Emp."Org Jed");
                                OrgJed.SETFILTER(GF, '%1', Emp.GF);
                                IF OrgJed.FINDFIRST THEN begin
                                    OrgDijeloviTempU."JIB Contributes" := OrgJed."JIB Contributes";
                                    OrgdijeloviTempU."Entity Code" := OrgJed."Entity Code";
                                end;
                                OrgDijeloviTempU.INSERT(TRUE);

                            END ELSE BEGIN
                                OrgDijeloviTempU."For Calculation 6" += ROUND(TempAmountFBIH, 0.00001, '=');

                                OrgDijeloviTempU.MODIFY;
                            END;

                            FAmount += ROUND(TempAmountFBIH * PFed / 100, 0.00001, '=');

                            KAmount += ROUND(TempAmountFBIH, 0.00001, '=');
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;




        //UNTIL AddTax.NEXT = 0;
        /*
        IF FAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIH');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Unemployment);
         AddTaxPS.FINDFIRST;
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := '4200344670092';
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := Emp."Municipality Code CIPS";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
         Tip:=0;
         Sifra:='RS'+'n';
         Iznos := ROUND(FAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         Contribution:='Doprinosi za nezaposlenost';
         WType:=0;
        
        IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
             DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;*/
        //zaokr
        IF FAmount > 0 THEN BEGIN
            //MunicipalityTemp.SETFILTER("For Calculation 6",'<>%1',0);
            //IF MunicipalityTemp.FIND('-') THEN REPEAT
            OrgDijeloviTempU.SETFILTER("For Calculation 6", '<>%1', 0);
            OrgDijeloviTempU.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTempU.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTempU.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTempU.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTempU.FIND('-') THEN
                REPEAT

                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";

                    BrojPoreznogObaveznika := OrgDijeloviTempU."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := OrgDijeloviTempU."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTempU."For Calculation 6" * PFed / 100, 0.00001, '=');
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Tip := 1;
                    // MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 0;
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL OrgDijeloviTempU.NEXT = 0;
        END;

        IF KAmount > 0 THEN BEGIN
            //MunicipalityTemp.SETFILTER("For Calculation 6",'<>%1',0);
            //IF MunicipalityTemp.FIND('-') THEN REPEAT
            OrgDijeloviTempU.SETFILTER("For Calculation 6", '<>%1', 0);
            OrgDijeloviTempU.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTempU.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTempU.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTempU.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTempU.FIND('-') THEN
                REPEAT

                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, OrgDijeloviTempU."Municipality Code CIPS");
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";

                    BrojPoreznogObaveznika := OrgDijeloviTempU."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := OrgDijeloviTempU."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTempU."For Calculation 6" * PKan / 100, 0.00001, '=');
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Tip := 1;
                    // MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 0;
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL OrgDijeloviTempU.NEXT = 0;
        END;
        /***************************************Health*******************************************************/

        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";



        AddTax.RESET;
        AddTaxPE.RESET;
        AddTax.SETRANGE(Code, 'D-ZDRAVRS');
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'RS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", 'D-ZDRAVRS');
                Emp.RESET;
                Emp.SETFILTER("Entity Code CIPS", '%1|%2', 'FBIH', 'BDRS');
                //Emp.SETFILTER("No.",'%1','1294');
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmountFBIH2 := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmountFBIH2 > 0 THEN BEGIN
                            /*IF NOT MunicipalityTemp3.GET(Emp."Municipality Code CIPS") THEN BEGIN
                             Municipality3.GET(Emp."Municipality Code CIPS");
                             MunicipalityTemp3.INIT;
                             MunicipalityTemp3.TRANSFERFIELDS(Municipality3,TRUE);
                             MunicipalityTemp3.INSERT;
                             END;


                              MunicipalityTemp3."For Calculation 10" += ROUND(TempAmountFBIH2,0.00001,'=');
                              MunicipalityTemp3.MODIFY;*/
                            OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijeloviTemp3.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                            OrgDijeloviTemp3.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijeloviTemp3.SETFILTER(GF, '%1', Emp.GF);
                            IF NOT OrgDijeloviTemp3.FINDFIRST THEN BEGIN
                                /*  OrgDijelovi.SETFILTER("Municipality Code for salary",'%1',Emp."Municipality Code for salary");
                                  OrgDijelovi.SETFILTER("Municipality Code CIPS",'%1',Emp."Municipality Code CIPS");
                                  OrgDijelovi.SETFILTER(Code,'%1',Emp."Org Jed");
                                  OrgDijelovi.SETFILTER(GF,'%1',Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                              OrgDijeloviTemp.INIT;
                              OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi,TRUE);
                              OrgDijeloviTemp.INSERT;
                              END
                              ELSE BEGIN*/
                                OrgDijeloviTemp3.INIT;
                                OrgDijeloviTemp3."Municipality Code for salary" := Emp."Municipality Code for salary";
                                OrgDijeloviTemp3."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                                OrgDijeloviTemp3.Code := Emp."Org Jed";
                                OrgDijeloviTemp3.GF := Emp.GF;
                                OrgDijeloviTemp3."For Calculation 10" += ROUND(TempAmountFBIH2, 0.00001, '=');
                                OrgJed.RESET;
                                OrgJed.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                OrgJed.SETFILTER(Code, '%1', Emp."Org Jed");
                                OrgJed.SETFILTER(GF, '%1', Emp.GF);
                                IF OrgJed.FINDFIRST THEN begin
                                    OrgDijeloviTemp3."JIB Contributes" := OrgJed."JIB Contributes";
                                    OrgDijeloviTemp3."Entity Code" := OrgJed."Entity Code";
                                end;
                                OrgDijeloviTemp3.INSERT(TRUE);
                            END ELSE BEGIN
                                OrgDijeloviTemp3."For Calculation 10" += ROUND(TempAmountFBIH2, 0.00001, '=');
                                OrgDijeloviTemp3.MODIFY;
                            END;
                            FAmount += ROUND(TempAmountFBIH2 * PFed / 100, 0.00001, '=');

                            KAmount += ROUND(TempAmountFBIH2 * PKan / 100, 0.00001, '=');
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        /*NKRAIFF
        IF FAmount > 0 THEN BEGIN
         CLEAR(AddTaxPS);
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIH');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Health);
         AddTaxPS.FINDFIRST;
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
          WType:=AddTaxPE."Wage Calculation Type";
         Tip:=1;
         Sifra:=AddTaxPS.Code;
          WType:=0;
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := '4200344670092';
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := MunicipalityTemp.Code;
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
           MunicipalityTemp.CALCFIELDS("Entity Code");
          Sifra:=MunicipalityTemp."Entity Code"+'n';
         Iznos := ROUND(FAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         Contribution:='Doprinosi za zdravstvo';
        
          IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
               DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;*/
        //zaokr
        IF FAmount > 0 THEN BEGIN
            //MunicipalityTemp3.SETFILTER("For Calculation 10",'<>%1',0);
            //IF MunicipalityTemp3.FIND('-') THEN REPEAT
            OrgDijeloviTemp3.SETFILTER("For Calculation 10", '<>%1', 0);
            OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTemp3.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := OrgDijeloviTemp3."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := OrgDijeloviTemp3."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTemp3."For Calculation 10" * PFed / 100, 0.00001, '=');
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;

                UNTIL OrgDijeloviTemp3.NEXT = 0;
        END;

        IF KAmount > 0 THEN BEGIN
            //MunicipalityTemp3.SETFILTER("For Calculation 10",'<>%1',0);
            //IF MunicipalityTemp3.FIND('-') THEN REPEAT
            OrgDijeloviTemp3.SETFILTER("For Calculation 10", '<>%1', 0);
            OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTemp3.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;

                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    AddTaxPS.SETRANGE(Code, OrgDijeloviTemp3."Municipality Code CIPS");
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := OrgDijeloviTemp3."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := OrgDijeloviTemp3."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTemp3."For Calculation 10" * PKan / 100, 0.00001, '=');
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;

                UNTIL OrgDijeloviTemp3.NEXT = 0;
        END;

        /***************************************************RVI*************************************************/
        /*prebačeno u RS
        
        IF SOLIDAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
        // AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETRANGE("Add. Tax Code",'P-RVI');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := '4200344670092';
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := Emp."Org Municipality";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
            MunicipalityTemp.CALCFIELDS("Entity Code");
          Sifra:='RS';
         Iznos := ROUND(SOLIDAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
          IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
            DatumUplate:=WHeader."Payment Date";
             Contribution:='Poseban doprinos';
         MakePaymentOrder;
        END;*/

        /***************************************************DJZ*************************************************/
        //IF DJZAmount > 0 THEN BEGIN
        OrgDijeloviTemp2.SETFILTER("For Calculation 9", '<>%1', 0);
        OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp2.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp2.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp2.FIND('-') THEN
            REPEAT

                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FBIHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETRANGE("Add. Tax Code", 'DJEC-ZAST');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp2."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp2."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                //MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := 'RS';
                WType := 0;
                Tip := 1;
                Iznos := ROUND(OrgDijeloviTemp2."For Calculation 9", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                Contribution := 'Dječija zaštita';
                MakePaymentOrder;
            UNTIL OrgDijeloviTemp2.NEXT = 0;

        /*IF CantonTemp.FIND('-') THEN REPEAT
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
         AddTaxPS.SETRANGE(Code,CantonTemp.Code);
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Health);
         AddTaxPS.FIND('-');
        
         InitPaymentOrder;
        
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := CantonTemp.Description;
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
         Sifra:='RS'+'n';
         Iznos := ROUND(CantonTemp."For Calculation",0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
             IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        UNTIL CantonTemp.NEXT = 0;*/

    end;

    procedure DoprinosiBDRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //BD NK Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'BDRS';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 0;
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end
            else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            //NK MunicipalityTemp."For Calculation 2" += ROUND(TempAmount*PKan/100,0.00001);
                            //NK MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount, 0.00001);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 0;
            Tip := 1;
            Sifra := 'BDRS';

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //NK BD Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end
            else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := 'BDRS';
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := '016';
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number RS";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

    end;

    procedure PoreziBD(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Contribution Category Code", 'BDPIOFBIH');
        TaxPE.SETRANGE("Wage Calculation Type", 0);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> '00' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                        Sifra := 'FBIH'
                    ELSE
                        Sifra := TaxPE."Contribution Category Code";
                    Sifra := TaxPE."Contribution Category Code";
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    Mun.CALCFIELDS("Canton Code");
                    IF Mun."Tax Number" = '099' THEN
                        BrojPoreznogObaveznika := '4200344670106'
                    ELSE
                        IF Mun."Canton Code" = '00' THEN
                            BrojPoreznogObaveznika := '4200344670092'
                        ELSE
                            BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end
                    else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;
    end;

    procedure PoreziBDRS(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Contribution Category Code", 'BDPIORS');
        TaxPE.SETRANGE("Wage Calculation Type", 0);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> '00' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                        Sifra := 'FBIH'
                    ELSE
                        Sifra := TaxPE."Contribution Category Code";
                    Sifra := TaxPE."Contribution Category Code";
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    Mun.CALCFIELDS("Canton Code");
                    IF Mun."Tax Number" = '099' THEN
                        BrojPoreznogObaveznika := '4200344670106'
                    ELSE
                        IF Mun."Canton Code" = '00' THEN
                            BrojPoreznogObaveznika := '4200344670092'
                        ELSE
                            BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin

                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;
    end;

    procedure PoreziRS(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
        OrgDijeloviPTemp: Record "Org Dijelovi";
        OrgDijeloviP: Record "ORG Dijelovi";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETFILTER("Contribution Category Code", '%1', 'RS');
        TaxPE.SETRANGE("Wage Calculation Type", 0);
        TaxPE.SETFILTER("Canton Code", '%1', '00');
        //OrgDijeloviPTemp.RESET;

        /*IF Mun.FINDFIRST THEN REPEAT
         TaxPE.SETRANGE("Tax Number",Mun."Tax Number");
         TaxPE.CALCSUMS(Amount);
         FAmount := TaxPE.Amount;
         IF TaxPE.FINDFIRST THEN BEGIN
        IF TaxPE."Canton Code" = 'FBIHRS' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF TaxPE."Canton Code" = 'FBIH' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
           Canton.GET(TaxPE."Canton Code",'BD');
         END;*/
        IF TaxPE.FINDFIRST THEN
            REPEAT
                Emp.RESET;
                Emp.GET(TaxPE."Employee No.");
                /*OrgDijeloviPTemp.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                OrgDijeloviPTemp.SETFILTER(Code,'%1',TaxPE."Org Jed");
                  OrgDijeloviPTemp.SETFILTER(GF,'%1',TaxPE.GF);
                 IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN
                   OrgDijeloviP.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                   OrgDijeloviP.SETFILTER(Code,'%1',TaxPE."Org Jed");
                   OrgDijeloviP.SETFILTER(GF,'%1',TaxPE.GF);
                 IF OrgDijeloviP.FINDFIRST THEN BEGIN
                  OrgDijeloviPTemp.INIT;
                  OrgDijeloviPTemp.TRANSFERFIELDS(OrgDijeloviP,TRUE);
                  OrgDijeloviPTemp.INSERT;
                  END;
                  END;
                  OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount,0.00001);
                  OrgDijeloviPTemp.MODIFY;*/

                OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                OrgDijeloviPTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                OrgDijeloviPTemp.SETFILTER(GF, '%1', Emp.GF);
                IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN

                    OrgDijeloviPTemp.INIT;
                    OrgDijeloviPTemp."Municipality Code for salary" := Emp."Municipality Code for salary";
                    OrgDijeloviPTemp."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                    OrgDijeloviPTemp.Code := Emp."Org Jed";
                    OrgDijeloviPTemp.GF := Emp.GF;
                    OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount, 0.00001);
                    OrgDijeloviP.RESET;
                    OrgDijeloviP.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                    OrgDijeloviP.SETFILTER(Code, '%1', Emp."Org Jed");
                    OrgDijeloviP.SETFILTER(GF, '%1', Emp.GF);
                    IF OrgDijeloviP.FINDFIRST THEN begin
                        OrgDijeloviPTemp."JIB Contributes" := OrgDijeloviP."JIB Contributes";
                        OrgDijeloviPTemp."Entity Code" := OrgdijeloviP."Entity Code";
                    end;
                    OrgDijeloviPTemp.INSERT(TRUE);

                END
                ELSE BEGIN
                    OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount, 0.00001);

                    OrgDijeloviPTemp.MODIFY;
                END;
            UNTIL TaxPE.NEXT = 0;





        OrgDijeloviPTemp.SETFILTER("For Calculation 15", '<>%1', 0);
        OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(GF, '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviPTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, OrgDijeloviPTemp."Municipality Code for salary");
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                AddTaxPS.FINDFIRST;

                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                Mun.RESET;
                IF Mun.GET(OrgDijeloviPTemp."Municipality Code for salary") THEN
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := Canton.Description;
                Tip := 2;
                IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                    Sifra := 'FBIH'
                ELSE
                    Sifra := TaxPE."Contribution Category Code";
                Sifra := TaxPE."Contribution Category Code";
                WType := 0;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := OrgDijeloviPTemp."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";

                Opstina := OrgDijeloviPTemp."Municipality Code CIPS";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviPTemp."For Calculation 15", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                Contribution := 'Porez';
                BudgetOrg := AddTaxPS."Budget Organisation";

                /* PozivNaBroj := '00000000';
                 IF WHeader."Month Of Wage" < 10 THEN
                  PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                 ELSE
                  PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviPTemp.NEXT = 0;

    end;

    procedure DoprinosiDodaciBDRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);
                                MunicipalityTemp.INIT;
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                MunicipalityTemp.INSERT;
                            END;

                            MunicipalityTemp."For Calculation" += ROUND(TempAmount, 0.00001);
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.00001);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //BD NK Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'BDRS';
            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 4;
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code CIPS", MunicipalityTemp.Type::Regular) THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code CIPS", Municipality.Type::Regular);

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            //NK MunicipalityTemp."For Calculation 2" += ROUND(TempAmount*PKan/100,0.00001);
                            //NK MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount, 0.00001);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 4;
            Tip := 1;
            Sifra := 'BDRS';

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //NK BD Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            MunicipalityTemp.CALCFIELDS("Entity Code");
            MunEntity.GET(Opstina);
            MunEntity.CALCFIELDS("Entity Code");
            if MunEntity."Entity Code" = 'FBIH' then begin
                IF WHeader."Month Of Wage" <= 9 THEN
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                ELSE
                    PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
            end else begin
                CompanyInfo.get();
                if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
            end;
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := 'BDRS';
            WType := 4;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := '4200344670106';
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := '016';
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.00001);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            BudgetOrg := AddTaxPS."Budget Organisation";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number RS";
            DatumUplate := WHeader."Closing Date";
            MakePaymentOrder;
        END;

    end;

    procedure DoprinosiDodaciRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        _______RS_________: Integer;
        RSAmount: Decimal;
        PIOAmount: Decimal;
        ZDRAmount: Decimal;
        DJZAmount: Decimal;
        NEZAmount: Decimal;
        Municipality: Record "ORG Dijelovi";
        MunicipalityTemp: Record "ORG Dijelovi";
        Municipality2: Record "ORG Dijelovi";
        MunicipalityTemp2: Record "ORG Dijelovi";
        Emp2: Record "Employee";
        AddTax2: Record "Contribution";
        AddTaxPE2: Record "Contribution Per Employee";
        Municipality3: Record "ORG Dijelovi";
        MunicipalityTemp3: Record "ORG Dijelovi";
        Emp3: Record "Employee";
        AddTax3: Record "Contribution";
        AddTaxPE3: Record "Contribution Per Employee";
        OrgDijelovi: Record "ORG Dijelovi";
        OrgDijeloviTemp: Record "ORG Dijelovi";
        OrgDijelovi2: Record "ORG Dijelovi";
        OrgDijeloviTemp2: Record "ORG Dijelovi";
        OrgDijelovi3: Record "ORG Dijelovi";
        OrgDijeloviTemp3: Record "ORG Dijelovi";
        AddTaxPEINV: Record "Contribution Per Employee";
        AddTaxPEKOM: Record "Contribution Per Employee";
        AmountKOM: Decimal;
        AmountKomTemp: Decimal;
        OrgDijelovi4: Record "ORG Dijelovi";
        OrgDijeloviTemp4: Record "ORG Dijelovi";
        Emp4: Record "Employee";
        AddTax4: Record "Contribution";
        AddTaxPE4: Record "Contribution Per Employee";
        OrgDijelovi5: Record "ORG Dijelovi";
        OrgDijeloviTemp5: Record "ORG Dijelovi";
        Emp5: Record "Employee";
    begin

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);






        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::RS);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        IF AddTax.FIND('-') THEN BEGIN
            //AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
            Emp.RESET;
            Emp.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp.SETFILTER("Entity Code CIPS", '%1', 'RS');
            Emp.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp.SETFILTER("Calculate Wage Addition", '%1', TRUE);
            IF Emp.FIND('-') THEN
                REPEAT
                    AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                    AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    TempAmount := AddTaxPE."Amount From Wage";
                    //TempAmountSpecTemp := AddTaxPE."Amount Over Wage";
                    AmountOverTemp := AddTaxPE."Amount Over Wage";



                    IF ((TempAmount > 0) OR (AmountOverTemp > 0)) THEN BEGIN
                        //TempAmountSpec+=TempAmountSpecTemp;
                        AmountOver += AmountOverTemp;
                        OrgDijeloviTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                        OrgDijeloviTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                        OrgDijeloviTemp.SETFILTER(GF, '%1', Emp.GF);
                        IF NOT OrgDijeloviTemp.FINDFIRST THEN BEGIN
                            OrgDijelovi.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijelovi.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijelovi.SETFILTER(GF, '%1', Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                                OrgDijeloviTemp.INIT;
                                OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi, TRUE);
                                OrgDijeloviTemp.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp."For Calculation 5" += ROUND(TempAmount, 0.00001);
                        //  MunicipalityTemp."For Calculation 7" += ROUND(TempAmountSpecTemp,0.00001);
                        OrgDijeloviTemp.MODIFY;

                    END;
                UNTIL Emp.NEXT = 0;
        END;


        AddTax2.RESET;
        AddTax2.SETRANGE(Type, AddTax2.Type::RS);
        AddTaxPE2.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE2.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE2.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE2.SETRANGE(Paid, FALSE);
        AddTaxPE2.SETRANGE("Contribution Code", 'P-RVI');
        IF AddTax2.FIND('-') THEN BEGIN
            Emp2.RESET;
            Emp2.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp2.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp2.SETFILTER("Calculate Wage Addition", '%1', TRUE);
            IF Emp2.FIND('-') THEN
                REPEAT
                    AddTaxPE2.SETRANGE("Employee No.", Emp2."No.");
                    AddTaxPE2.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    TempAmountSpecTemp := AddTaxPE2."Amount Over Wage";
                    IF (TempAmountSpecTemp > 0) THEN BEGIN
                        TempAmountSpec += TempAmountSpecTemp;


                        OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '%1', Emp2."Municipality Code for salary");

                        OrgDijeloviTemp2.SETFILTER(Code, '%1', Emp2."Org Jed");
                        OrgDijeloviTemp2.SETFILTER(GF, '%1', Emp2.GF);
                        IF NOT OrgDijeloviTemp2.FINDFIRST THEN BEGIN
                            OrgDijelovi2.SETFILTER("Municipality Code for salary", '%1', Emp2."Municipality Code for salary");
                            OrgDijelovi2.SETFILTER(Code, '%1', Emp2."Org Jed");
                            OrgDijelovi2.SETFILTER(GF, '%1', Emp2.GF);
                            IF OrgDijelovi2.FINDSET THEN BEGIN
                                OrgDijeloviTemp2.INIT;
                                OrgDijeloviTemp2.TRANSFERFIELDS(OrgDijelovi2, TRUE);
                                OrgDijeloviTemp2.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp2."For Calculation 7" += ROUND(TempAmountSpecTemp, 0.00001);
                        OrgDijeloviTemp2.MODIFY;
                    END;

                UNTIL Emp2.NEXT = 0;
        END;



        AddTax3.RESET;
        AddTax3.SETRANGE(Type, AddTax3.Type::RS);
        AddTax3.SETRANGE(Code, 'P-FONDRS');
        AddTaxPE3.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE3.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE3.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE3.SETRANGE(Paid, FALSE);
        AddTaxPE3.SETRANGE("Contribution Code", 'P-FONDRS');
        IF AddTax3.FIND('-') THEN BEGIN
            Emp3.RESET;
            Emp3.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp3.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp3.SETFILTER("Calculate Wage Addition", '%1', TRUE);
            IF Emp3.FIND('-') THEN
                REPEAT
                    AddTaxPE3.SETRANGE("Employee No.", Emp3."No.");
                    AddTaxPE3.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    FundAmountTemp := AddTaxPE3."Amount Over Neto";
                    IF (FundAmountTemp > 0) THEN BEGIN
                        FundAmount += FundAmountTemp;



                        OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '%1', Emp3."Municipality Code for salary");
                        OrgDijeloviTemp3.SETFILTER(Code, '%1', Emp3."Org Jed");
                        OrgDijeloviTemp3.SETFILTER(GF, '%1', Emp3.GF);
                        IF NOT OrgDijeloviTemp3.FINDFIRST THEN BEGIN
                            OrgDijelovi3.SETFILTER("Municipality Code for salary", '%1', Emp3."Municipality Code for salary");

                            OrgDijelovi3.SETFILTER(Code, '%1', Emp3."Org Jed");
                            OrgDijelovi3.SETFILTER(GF, '%1', Emp3.GF);
                            IF OrgDijelovi3.FINDSET THEN BEGIN
                                OrgDijeloviTemp3.INIT;
                                OrgDijeloviTemp3.TRANSFERFIELDS(OrgDijelovi3, TRUE);
                                OrgDijeloviTemp3.INSERT;
                            END;
                            OrgDijeloviTemp3."For Calculation 13" += ROUND(FundAmountTemp, 0.00001);
                            OrgDijeloviTemp3.MODIFY;
                        END;
                    END;
                UNTIL Emp3.NEXT = 0;
        END;


        AddTax4.RESET;
        AddTax4.SETRANGE(Type, AddTax4.Type::RS);
        AddTaxPE4.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE4.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE4.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE4.SETRANGE(Paid, FALSE);
        AddTaxPE4.SETRANGE("Contribution Code", 'P-VTK');
        IF AddTax4.FIND('-') THEN BEGIN
            Emp4.RESET;
            Emp4.SETFILTER("Org Entity Code", '%1', 'RS');
            Emp4.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
            Emp4.SETFILTER("Calculate Wage Addition", '%1', TRUE);
            IF Emp4.FIND('-') THEN
                REPEAT
                    AddTaxPE4.SETRANGE("Employee No.", Emp4."No.");
                    AddTaxPE4.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                    AmountKomTemp := AddTaxPE4."Amount Over Wage";
                    IF (AmountKomTemp > 0) THEN BEGIN
                        AmountKOM += AmountKomTemp;


                        OrgDijeloviTemp4.SETFILTER("Municipality Code for salary", '%1', Emp4."Municipality Code for salary");
                        OrgDijeloviTemp4.SETFILTER(Code, '%1', Emp4."Org Jed");
                        OrgDijeloviTemp4.SETFILTER(GF, '%1', Emp4.GF);
                        IF NOT OrgDijeloviTemp4.FINDFIRST THEN BEGIN
                            OrgDijelovi4.SETFILTER("Municipality Code for salary", '%1', Emp4."Municipality Code for salary");
                            OrgDijelovi4.SETFILTER(Code, '%1', Emp4."Org Jed");
                            OrgDijelovi4.SETFILTER(GF, '%1', Emp4.GF);
                            IF OrgDijelovi4.FINDSET THEN BEGIN
                                OrgDijeloviTemp4.INIT;
                                OrgDijeloviTemp4.TRANSFERFIELDS(OrgDijelovi4, TRUE);
                                OrgDijeloviTemp4.INSERT;
                            END;
                        END;
                        OrgDijeloviTemp4."For Calculation 14" += ROUND(AmountKomTemp, 0.00001);
                        OrgDijeloviTemp4.MODIFY;
                    END;

                UNTIL Emp4.NEXT = 0;
        END;


        //IF TempAmount > 0 THEN BEGIN
        OrgDijeloviTemp.SETFILTER("For Calculation 5", '<>%1', 0);
        OrgDijeloviTemp.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Munici);
                //NK AddTaxPS.SETRANGE(Code,MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                // AddTaxPS.SETFILTER("Add. Tax Code",'%1','');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Sifra := 'RS';
                WType := 4;
                Tip := 1;
                BudgetOrg := AddTaxPS."Budget Organisation";
                Iznos := ROUND(OrgDijeloviTemp."For Calculation 5", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                Contribution := 'Doprinos';
                DatumUplate := WHeader."Closing Date";
                MakePaymentOrder;
            //END;

            UNTIL OrgDijeloviTemp.NEXT = 0;

        //IF TempAmountSpec > 0 THEN BEGIN
        OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp2.SETFILTER("For Calculation 7", '<>%1', 0);
        OrgDijeloviTemp2.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp2.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp2.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FIBHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'P-RVI');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp2."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp2."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviTemp2."For Calculation 7", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                WType := 4;
                Tip := 1;
                Sifra := 'RS';
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                Contribution := 'Poseban doprinos';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp2.NEXT = 0;

        OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp3.SETFILTER("For Calculation 13", '<>%1', 0);
        OrgDijeloviTemp3.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp3.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp3.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FIBHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'P-FONDRS');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp3."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp3."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviTemp3."For Calculation 13", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                WType := 4;
                Tip := 1;
                Sifra := 'RS';
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                Contribution := 'Poseban doprinos';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp3.NEXT = 0;



        OrgDijeloviTemp4.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp4.SETFILTER("For Calculation 14", '<>%1', 0);
        OrgDijeloviTemp4.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp4.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp4.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                AddTaxPS.SETRANGE(Code, 'RS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Chamber);
                // AddTaxPS.SETFILTER("Add. Tax Code",'%1','P-VTK');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp4."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";

                Opstina := OrgDijeloviTemp4."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviTemp4."For Calculation 14", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                WType := 4;
                Tip := 1;
                Sifra := 'RS';
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                Contribution := 'Poseban doprinos';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp4.NEXT = 0;
        //UNTIL MunicipalityTemp.NEXT=0;


        /**************************************************P-VOD*********************************************/
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        AddTax.SetFilter(Active, '%1', true);
        AddTax.SETRANGE(Code, 'P-VOD');
        FAmount := 0;
        TempAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NKN AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NKN AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETRANGE("Contribution Code", 'P-VOD');
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'RS');
        IF AddTax.FINDFIRST THEN
            REPEAT

                Emp5.RESET;
                IF Emp5.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp5."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        //NK FAmount += TempAmount;

                        IF TempAmount > 0 THEN BEGIN
                            /* IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary") THEN BEGIN
                             Municipality.GET(Emp."Municipality Code for salary");
                             MunicipalityTemp.INIT;
                             MunicipalityTemp.TRANSFERFIELDS(Municipality,TRUE);
                             MunicipalityTemp.INSERT;
                             END;

                            MunicipalityTemp."For Calculation 3" += ROUND(TempAmount,0.00001);
                            MunicipalityTemp.MODIFY;*/
                            OrgDijeloviTemp5.SETFILTER("Municipality Code for salary", '%1', Emp5."Municipality Code for salary");
                            OrgDijeloviTemp5.SETFILTER(Code, '%1', Emp5."Org Jed");
                            OrgDijeloviTemp5.SETFILTER(GF, '%1', Emp5.GF);
                            IF NOT OrgDijeloviTemp5.FINDFIRST THEN BEGIN
                                OrgDijelovi5.SETFILTER("Municipality Code for salary", '%1', Emp5."Municipality Code for salary");
                                OrgDijelovi5.SETFILTER(Code, '%1', Emp5."Org Jed");
                                OrgDijelovi5.SETFILTER(GF, '%1', Emp5.GF);
                                IF OrgDijelovi5.FINDSET THEN BEGIN
                                    OrgDijeloviTemp5.INIT;
                                    OrgDijeloviTemp5.TRANSFERFIELDS(OrgDijelovi5, TRUE);
                                    OrgDijeloviTemp5.INSERT;
                                END;
                            END;
                            OrgDijeloviTemp5."For Calculation 3" += ROUND(TempAmount, 0.00001);
                            OrgDijeloviTemp5.MODIFY;
                        END;
                        FAmount += ROUND(TempAmount, 0.00001);
                    UNTIL Emp5.NEXT = 0;

            UNTIL AddTax.NEXT = 0;

        //NKN IF TempAmount > 0 THEN BEGIN
        /*MunicipalityTemp.SETFILTER("For Calculation 3",'<>%1',0);
        IF MunicipalityTemp.FIND('-') THEN REPEAT*/

        OrgDijeloviTemp5.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp5.SETFILTER("For Calculation 3", '<>%1', 0);
        OrgDijeloviTemp5.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp5.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp5.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, OrgDijeloviTemp5."Municipality Code for salary");
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                AddTaxPS.SETRANGE("Add. Tax Code", 'P-VOD');
                AddTaxPS.FINDFIRST;
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                //  Primalac3 := Canton.Description;
                Tip := 1;
                // MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := OrgDijeloviTemp5."Entity Code";
                WType := 4;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := CompInfo."Registration No.";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp5."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Iznos := ROUND(OrgDijeloviTemp5."For Calculation 3", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                IF Iznos > 0 THEN
                    MakePaymentOrder;
            UNTIL OrgDijeloviTemp5.NEXT = 0;

    end;

    procedure DoprinosiDodaciRSFBIH(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        TempAmountFBIH: Decimal;
        TempAmountFBIH2: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        _______RS_________: Integer;
        RSAmount: Decimal;
        PIOAmount: Decimal;
        ZDRAmount: Decimal;
        DJZAmount: Decimal;
        NEZAmount: Decimal;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        Municipality1: Record "Municipality";
        MunicipalityTemp1: Record "Municipality";
        Municipality2: Record "Municipality";
        MunicipalityTemp2: Record "Municipality";
        Municipality3: Record "Municipality";
        MunicipalityTemp3: Record "Municipality";
        OrgDijelovi: Record "Org Dijelovi" temporary;
        OrgDijeloviTemp: Record "Org Dijelovi" temporary;
        OrgDijelovi1: Record "ORG Dijelovi";
        OrgDijeloviTemp1: Record "ORG Dijelovi";
        OrgDijelovi2: Record "ORG Dijelovi";
        OrgDijeloviTemp2: Record "ORG Dijelovi";
        OrgDijelovi3: Record "Org Dijelovi" temporary;
        OrgDijeloviTemp3: Record "Org Dijelovi" temporary;
        OrgDijeloviTempU: Record "Org Dijelovi" temporary;
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);




        Reduction.SETFILTER(Type, '%1', 'FONSOLRS');
        Reduction.SETRANGE("Wage Header No.", WHeader."No.");
        //Reduction.SETFILTER("Employee No.",'%1',Emp."No.");
        Reduction.SETCURRENTKEY("Wage Header No.", Type);
        Reduction.CALCSUMS(Amount);
        AmountOverRed += Reduction.Amount;


        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::RS);
        AddTax.SetFilter(Active, '%1', true);
        FAmount := 0;
        KAmount := 0;
        SOLIDAmount := 0;
        TempAmountSpecTemp := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");

        IF AddTax.FIND('-') THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                Emp.SETFILTER("Org Entity Code", '%1', 'RS');
                Emp.SETFILTER("Entity Code CIPS", '%1|%2', 'FBIH', 'BDRS');
                Emp.SETFILTER("Contribution Category Code", '<>%1', 'FBIHRS');
                IF Emp.FIND('-') THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                        TempAmount := AddTaxPE."Amount From Wage";
                        TempAmountSpecTemp := AddTaxPE."Amount Over Neto";
                        AmountOverTemp := AddTaxPE."Amount Over Wage";



                        IF ((TempAmount > 0) OR (TempAmountSpecTemp > 0) OR (AmountOverTemp > 0)) THEN BEGIN
                            /*  IF Emp."Org Entity Code" = 'RS' THEN BEGIN
                               RSAmount += TempAmount;

                               TempAmountSpec+=TempAmountSpecTemp;
                               AmountOver+=AmountOverTemp;

                           END;*/



                            IF ((Emp."Entity Code CIPS" = 'FBIH') OR (Emp."Entity Code CIPS" = 'BDRS')) THEN BEGIN
                                CASE AddTax.Code OF
                                    'DJEC-ZAST':
                                        BEGIN
                                            DJZAmount += TempAmount;
                                            OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                            OrgDijeloviTemp2.SETFILTER(Code, '%1', Emp."Org Jed");
                                            OrgDijeloviTemp2.SETFILTER(GF, '%1', Emp.GF);
                                            IF NOT OrgDijeloviTemp2.FINDFIRST THEN BEGIN
                                                OrgDijelovi2.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                                OrgDijelovi2.SETFILTER(Code, '%1', Emp."Org Jed");
                                                OrgDijelovi2.SETFILTER(GF, '%1', Emp.GF);
                                                IF OrgDijelovi2.FINDFIRST THEN BEGIN
                                                    OrgDijeloviTemp2.INIT;
                                                    OrgDijeloviTemp2.TRANSFERFIELDS(OrgDijelovi2, TRUE);
                                                    OrgDijeloviTemp2.INSERT;
                                                END;
                                            END;
                                            IF OrgDijeloviTemp2.FINDFIRST THEN BEGIN
                                                OrgDijeloviTemp2."For Calculation 9" += ROUND(TempAmount, 0.00001, '=');
                                                OrgDijeloviTemp2.MODIFY;
                                            END;
                                        END;
                                    'D-PIORS':
                                        BEGIN
                                            PIOAmount += TempAmount;
                                            /*IF NOT MunicipalityTemp1.GET(Emp."Municipality Code for salary") THEN BEGIN
                                             Municipality1.GET(Emp."Municipality Code for salary");
                                             MunicipalityTemp1.INIT;
                                             MunicipalityTemp1.TRANSFERFIELDS(Municipality1,TRUE);
                                             MunicipalityTemp1.INSERT;
                                             END;
                                             MunicipalityTemp1."For Calculation 8" += ROUND(TempAmount,0.00001,'=');
                                             MunicipalityTemp1.MODIFY;*/
                                            OrgDijeloviTemp1.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                            OrgDijeloviTemp1.SETFILTER(Code, '%1', Emp."Org Jed");
                                            OrgDijeloviTemp1.SETFILTER(GF, '%1', Emp.GF);
                                            IF NOT OrgDijeloviTemp1.FINDFIRST THEN BEGIN
                                                OrgDijelovi1.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                                OrgDijelovi1.SETFILTER(Code, '%1', Emp."Org Jed");
                                                OrgDijelovi1.SETFILTER(GF, '%1', Emp.GF);
                                                IF OrgDijelovi1.FINDFIRST THEN BEGIN
                                                    OrgDijeloviTemp1.INIT;
                                                    OrgDijeloviTemp1.TRANSFERFIELDS(OrgDijelovi1, TRUE);
                                                    OrgDijeloviTemp1.INSERT;
                                                END;
                                            END;
                                            IF OrgDijeloviTemp1.FINDFIRST THEN BEGIN
                                                OrgDijeloviTemp1."For Calculation 8" += ROUND(TempAmount, 0.00001, '=');
                                                OrgDijeloviTemp1.MODIFY;
                                            END;
                                        END;
                                    'D-ZDRAVRS':
                                        ZDRAmount += TempAmount;

                                    'D-ZAPOŠRS':
                                        NEZAmount += TempAmount;
                                    'P-RVI':
                                        SOLIDAmount += AmountOverTemp;
                                    'D-ZDRAV-IZ':
                                        BEGIN
                                            IF NOT CantonTemp.GET(Emp."County CIPS", Emp."Entity Code CIPS") THEN BEGIN
                                                Canton.GET(Emp."County CIPS", Emp."Entity Code CIPS");
                                                CantonTemp.INIT;
                                                CantonTemp.TRANSFERFIELDS(Canton, TRUE);
                                                CantonTemp.INSERT;

                                            END;
                                            CantonTemp."For Calculation" += TempAmount;
                                            CantonTemp.MODIFY;
                                        END;
                                END;
                            END;
                        END;

                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        /*NKRAIFF
        IF RSAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         //AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETFILTER("Add. Tax Code",'%1','');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(RSAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
        
          Sifra:='RS'+'n';
          IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
        
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;*/




        //IF PIOAmount > 0 THEN BEGIN
        /*MunicipalityTemp1.SETFILTER("For Calculation 8",'<>%1',0);
        IF MunicipalityTemp1.FIND('-') THEN REPEAT*/

        OrgDijeloviTemp1.SETFILTER("For Calculation 8", '<>%1', 0);
        OrgDijeloviTemp1.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp1.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp1.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp1.FIND('-') THEN
            REPEAT

                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FBIHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-PIORS');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := OrgDijeloviTemp1."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp1."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Sifra := 'RS';
                WType := 4;
                Tip := 1;
                Iznos := ROUND(OrgDijeloviTemp1."For Calculation 8", 0.00001);
                WHeaderNo := WHeader."No.";
                BudgetOrg := AddTaxPS."Budget Organisation";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                Contribution := 'Doprinosi PIO';
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviTemp1.NEXT = 0;

        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";

        /**************************************************Unemployment******************************************/
        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTaxPE.RESET;
        AddTax.SETRANGE(Code, 'D-ZAPOŠRS');
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETRANGE("Contribution Category Code", 'RS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", 'D-ZAPOŠRS');
                Emp.RESET;
                Emp.SETFILTER("Entity Code CIPS", '%1|%2', 'FBIH', 'BDRS');
                //Emp.SETFILTER("No.",'%1','1294');
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmountFBIH := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmountFBIH > 0 THEN BEGIN
                            /* IF NOT MunicipalityTemp.GET(Emp."Municipality Code for salary") THEN BEGIN
                              Municipality.GET(Emp."Municipality Code for salary");
                              MunicipalityTemp.INIT;
                              MunicipalityTemp.TRANSFERFIELDS(Municipality,TRUE);
                              MunicipalityTemp.INSERT;
                              END;


                             MunicipalityTemp."For Calculation 6" += ROUND(TempAmountFBIH,0.00001,'=');
                               MunicipalityTemp.MODIFY;*/
                            OrgDijeloviTempU.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijeloviTempU.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                            OrgDijeloviTempU.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijeloviTempU.SETFILTER(GF, '%1', Emp.GF);
                            IF NOT OrgDijeloviTempU.FINDFIRST THEN BEGIN
                                /*  OrgDijelovi.SETFILTER("Municipality Code for salary",'%1',Emp."Municipality Code for salary");
                                  OrgDijelovi.SETFILTER("Municipality Code CIPS",'%1',Emp."Municipality Code CIPS");
                                  OrgDijelovi.SETFILTER(Code,'%1',Emp."Org Jed");
                                  OrgDijelovi.SETFILTER(GF,'%1',Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                              OrgDijeloviTemp.INIT;
                              OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi,TRUE);
                              OrgDijeloviTemp.INSERT;
                              END
                              ELSE BEGIN*/
                                OrgDijeloviTempU.INIT;
                                OrgDijeloviTempU."Municipality Code for salary" := Emp."Municipality Code for salary";

                                OrgDijeloviTempU."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                                OrgDijeloviTempU.Code := Emp."Org Jed";
                                OrgDijeloviTempU.GF := Emp.GF;
                                OrgDijeloviTempU."For Calculation 6" += ROUND(TempAmountFBIH, 0.00001, '=');
                                OrgJed.RESET;
                                OrgJed.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                OrgJed.SETFILTER(Code, '%1', Emp."Org Jed");
                                OrgJed.SETFILTER(GF, '%1', Emp.GF);
                                IF OrgJed.FINDFIRST THEN begin
                                    OrgDijeloviTempU."JIB Contributes" := OrgJed."JIB Contributes";
                                    OrgDijeloviTempU."Entity Code" := OrgJed."Entity Code";
                                end;
                                OrgDijeloviTempU.INSERT(TRUE);

                            END ELSE BEGIN
                                OrgDijeloviTempU."For Calculation 6" += ROUND(TempAmountFBIH, 0.00001, '=');

                                OrgDijeloviTempU.MODIFY;
                            END;

                            FAmount += ROUND(TempAmountFBIH * PFed / 100, 0.00001, '=');

                            KAmount += ROUND(TempAmountFBIH * PKan / 100, 0.00001, '=');
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;




        //UNTIL AddTax.NEXT = 0;
        /*
        IF FAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIH');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Unemployment);
         AddTaxPS.FINDFIRST;
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := '4200344670092';
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := Emp."Municipality Code CIPS";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
         Tip:=0;
         Sifra:='RS'+'n';
         Iznos := ROUND(FAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         Contribution:='Doprinosi za nezaposlenost';
         WType:=0;
        
        IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
             DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;*/

        IF FAmount > 0 THEN BEGIN
            //MunicipalityTemp.SETFILTER("For Calculation 6",'<>%1',0);
            //IF MunicipalityTemp.FIND('-') THEN REPEAT
            OrgDijeloviTempU.SETFILTER("For Calculation 6", '<>%1', 0);
            OrgDijeloviTempU.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTempU.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTempU.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTempU.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTempU.FIND('-') THEN
                REPEAT

                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";

                    BrojPoreznogObaveznika := OrgDijeloviTempU."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := OrgDijeloviTempU."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTempU."For Calculation 6" * PFed / 100, 0.00001, '=');
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    // MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    WType := 4;
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL OrgDijeloviTempU.NEXT = 0;
        END;

        IF KAmount > 0 THEN BEGIN
            //MunicipalityTemp.SETFILTER("For Calculation 6",'<>%1',0);
            //IF MunicipalityTemp.FIND('-') THEN REPEAT
            OrgDijeloviTempU.SETFILTER("For Calculation 6", '<>%1', 0);
            OrgDijeloviTempU.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTempU.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTempU.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTempU.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTempU.FIND('-') THEN
                REPEAT

                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, OrgDijeloviTempU."Municipality Code CIPS");
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";

                    BrojPoreznogObaveznika := OrgDijeloviTempU."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := OrgDijeloviTempU."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTempU."For Calculation 6" * PKan / 100, 0.00001, '=');
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    // MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 4;
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                UNTIL OrgDijeloviTempU.NEXT = 0;
        END;

        /***************************************Health*******************************************************/

        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";



        AddTax.RESET;
        AddTaxPE.RESET;
        AddTax.SETRANGE(Code, 'D-ZDRAVRS');
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE(Paid, FALSE);
        AddTaxPE.SETRANGE("Contribution Category Code", 'RS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", 'D-ZDRAVRS');
                Emp.RESET;
                Emp.SETFILTER("Entity Code CIPS", '%1|%2', 'FBIH', 'BDRS');
                //Emp.SETFILTER("No.",'%1','1294');
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmountFBIH2 := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmountFBIH2 > 0 THEN BEGIN
                            /*IF NOT MunicipalityTemp3.GET(Emp."Municipality Code CIPS") THEN BEGIN
                             Municipality3.GET(Emp."Municipality Code CIPS");
                             MunicipalityTemp3.INIT;
                             MunicipalityTemp3.TRANSFERFIELDS(Municipality3,TRUE);
                             MunicipalityTemp3.INSERT;
                             END;


                              MunicipalityTemp3."For Calculation 10" += ROUND(TempAmountFBIH2,0.00001,'=');
                              MunicipalityTemp3.MODIFY;*/
                            OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                            OrgDijeloviTemp3.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                            OrgDijeloviTemp3.SETFILTER(Code, '%1', Emp."Org Jed");
                            OrgDijeloviTemp3.SETFILTER(GF, '%1', Emp.GF);
                            IF NOT OrgDijeloviTemp3.FINDFIRST THEN BEGIN
                                /*  OrgDijelovi.SETFILTER("Municipality Code for salary",'%1',Emp."Municipality Code for salary");
                                  OrgDijelovi.SETFILTER("Municipality Code CIPS",'%1',Emp."Municipality Code CIPS");
                                  OrgDijelovi.SETFILTER(Code,'%1',Emp."Org Jed");
                                  OrgDijelovi.SETFILTER(GF,'%1',Emp.GF);
                            IF OrgDijelovi.FINDFIRST THEN BEGIN
                              OrgDijeloviTemp.INIT;
                              OrgDijeloviTemp.TRANSFERFIELDS(OrgDijelovi,TRUE);
                              OrgDijeloviTemp.INSERT;
                              END
                              ELSE BEGIN*/
                                OrgDijeloviTemp3.INIT;
                                OrgDijeloviTemp3."Municipality Code for salary" := Emp."Municipality Code for salary";
                                OrgDijeloviTemp3."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                                OrgDijeloviTemp3.Code := Emp."Org Jed";
                                OrgDijeloviTemp3.GF := Emp.GF;
                                OrgDijeloviTemp3."For Calculation 10" += ROUND(TempAmountFBIH2, 0.00001, '=');
                                OrgJed.RESET;
                                OrgJed.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                                OrgJed.SETFILTER(Code, '%1', Emp."Org Jed");
                                OrgJed.SETFILTER(GF, '%1', Emp.GF);
                                IF OrgJed.FINDFIRST THEN begin
                                    OrgDijeloviTemp3."JIB Contributes" := OrgJed."JIB Contributes";
                                    OrgDijeloviTemp3."Entity Code" := OrgJed."Entity Code";
                                end;
                                OrgDijeloviTemp3.INSERT(TRUE);
                            END ELSE BEGIN
                                OrgDijeloviTemp3."For Calculation 10" += ROUND(TempAmountFBIH2, 0.00001, '=');
                                OrgDijeloviTemp3.MODIFY;
                            END;
                            FAmount += ROUND(TempAmountFBIH2 * PFed / 100, 0.00001, '=');

                            KAmount += ROUND(TempAmountFBIH2, 0.00001, '=');
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        /*NKRAIFF
        IF FAmount > 0 THEN BEGIN
         CLEAR(AddTaxPS);
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'FBIH');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Health);
         AddTaxPS.FINDFIRST;
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
          WType:=AddTaxPE."Wage Calculation Type";
         Tip:=1;
         Sifra:=AddTaxPS.Code;
          WType:=0;
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := '4200344670092';
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := MunicipalityTemp.Code;
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
           MunicipalityTemp.CALCFIELDS("Entity Code");
          Sifra:=MunicipalityTemp."Entity Code"+'n';
         Iznos := ROUND(FAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         Contribution:='Doprinosi za zdravstvo';
        
          IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
               DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        END;*/

        IF FAmount > 0 THEN BEGIN
            //MunicipalityTemp3.SETFILTER("For Calculation 10",'<>%1',0);
            //IF MunicipalityTemp3.FIND('-') THEN REPEAT
            OrgDijeloviTemp3.SETFILTER("For Calculation 10", '<>%1', 0);
            OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTemp3.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;

                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := OrgDijeloviTemp3."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := OrgDijeloviTemp3."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTemp3."For Calculation 10" * PFed / 100, 0.00001, '=');
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 4;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;

                UNTIL OrgDijeloviTemp3.NEXT = 0;
        END;


        IF KAmount > 0 THEN BEGIN
            //MunicipalityTemp3.SETFILTER("For Calculation 10",'<>%1',0);
            //IF MunicipalityTemp3.FIND('-') THEN REPEAT
            OrgDijeloviTemp3.SETFILTER("For Calculation 10", '<>%1', 0);
            OrgDijeloviTemp3.SETFILTER("Municipality Code for salary", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER("Municipality Code CIPS", '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(GF, '<>%1', '');
            OrgDijeloviTemp3.SETFILTER(Code, '<>%1|%1', '', '');
            IF OrgDijeloviTemp3.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;

                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    AddTaxPS.SETRANGE(Code, OrgDijeloviTemp3."Municipality Code CIPS");
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := OrgDijeloviTemp3."JIB Contributes";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := OrgDijeloviTemp3."Municipality Code CIPS";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.00001);
                    Iznos := ROUND(OrgDijeloviTemp3."For Calculation 10" * PKan / 100, 0.00001, '=');
                    Tip := 1;
                    MunicipalityTemp.CALCFIELDS("Entity Code");
                    Sifra := 'RS';
                    WType := 4;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;

                UNTIL OrgDijeloviTemp3.NEXT = 0;
        END;

        /***************************************************RVI*************************************************/
        /*prebačeno u RS
        
        IF SOLIDAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
        // AddTaxPS.SETRANGE(Code,'FBIHRS');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::RS);
         AddTaxPS.SETRANGE("Add. Tax Code",'P-RVI');
         AddTaxPS.FIND('-');
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3"+FORMAT(WHeader."Month Of Wage")+'. '+FORMAT(WHeader."Year Of Wage")+'.';
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := '4200344670092';
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := Emp."Org Municipality";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
            MunicipalityTemp.CALCFIELDS("Entity Code");
          Sifra:='RS';
         Iznos := ROUND(SOLIDAmount,0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
          IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
            DatumUplate:=WHeader."Payment Date";
             Contribution:='Poseban doprinos';
         MakePaymentOrder;
        END;*/

        /***************************************************DJZ*************************************************/
        //IF DJZAmount > 0 THEN BEGIN
        OrgDijeloviTemp2.SETFILTER("For Calculation 9", '<>%1', 0);
        OrgDijeloviTemp2.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviTemp2.SETFILTER(GF, '<>%1', '');
        OrgDijeloviTemp2.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviTemp2.FIND('-') THEN
            REPEAT

                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                //AddTaxPS.SETRANGE(Code,'FBIHRS');
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
                AddTaxPS.SETRANGE("Add. Tax Code", 'DJEC-ZAST');
                AddTaxPS.FIND('-');
                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := AddTaxPS."Payment Receiver3";

                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";

                BrojPoreznogObaveznika := OrgDijeloviTemp2."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := OrgDijeloviTemp2."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                //MunicipalityTemp.CALCFIELDS("Entity Code");
                Sifra := 'RS';
                WType := 4;
                Tip := 1;
                Iznos := ROUND(OrgDijeloviTemp2."For Calculation 9", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                BudgetOrg := AddTaxPS."Budget Organisation";
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                Contribution := 'Dječija zaštita';
                MakePaymentOrder;
            UNTIL OrgDijeloviTemp2.NEXT = 0;

        /*IF CantonTemp.FIND('-') THEN REPEAT
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
         AddTaxPS.SETRANGE(Code,CantonTemp.Code);
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Health);
         AddTaxPS.FIND('-');
        
         InitPaymentOrder;
        
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := CantonTemp.Description;
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
         Sifra:='RS'+'n';
         Iznos := ROUND(CantonTemp."For Calculation",0.00001);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
             IF WHeader."Month Of Wage"<=9 THEN
         PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,8)+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj :=COPYSTR(AddTaxPS."Refer To Number",1,7)+FORMAT(WHeader."Month Of Wage");
            DatumUplate:=WHeader."Payment Date";
         MakePaymentOrder;
        UNTIL CantonTemp.NEXT = 0;*/

    end;

    procedure PoreziDodaci(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //nerminak

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        TaxPE.SETRANGE(Paid, FALSE);
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //TaxPE.SETFILTER("Contribution Category Code",'%1|%2|%3','FBIH','FBIHRS','RS');
        TaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
        TaxPE.SETRANGE("Wage Calculation Type", 4);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> '00' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                        Sifra := 'FBIH'
                    ELSE
                        Sifra := TaxPE."Contribution Category Code";
                    Sifra := TaxPE."Contribution Category Code";
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    Mun.CALCFIELDS("Canton Code");
                    OrgJed.RESET;
                    OrgJed.SETFILTER("Municipality Code for salary", '%1', Mun."Tax Number");
                    IF OrgJed.FINDLAST THEN;
                    IF Mun."Tax Number" = '099' THEN
                        BrojPoreznogObaveznika := '4200344670106'
                    ELSE
                        IF Mun."Canton Code" = '00' THEN
                            BrojPoreznogObaveznika := '4200344670092'
                        ELSE
                            BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    BudgetOrg := AddTaxPS."Budget Organisation";

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure PoreziDodaciRS(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
        OrgDijeloviPTemp: Record "Org Dijelovi";
        OrgDijeloviP: Record "ORG Dijelovi";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETFILTER("Contribution Category Code", '%1', 'RS');
        TaxPE.SETRANGE("Wage Calculation Type", 4);
        TaxPE.SETRANGE(Paid, FALSE);
        TaxPE.SETFILTER("Canton Code", '%1', '00');
        //OrgDijeloviPTemp.RESET;

        /*IF Mun.FINDFIRST THEN REPEAT
         TaxPE.SETRANGE("Tax Number",Mun."Tax Number");
         TaxPE.CALCSUMS(Amount);
         FAmount := TaxPE.Amount;
         IF TaxPE.FINDFIRST THEN BEGIN
        IF TaxPE."Canton Code" = 'FBIHRS' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF TaxPE."Canton Code" = 'FBIH' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
           Canton.GET(TaxPE."Canton Code",'BD');
         END;*/
        IF TaxPE.FINDFIRST THEN
            REPEAT
                Emp.RESET;
                Emp.GET(TaxPE."Employee No.");
                /*OrgDijeloviPTemp.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                OrgDijeloviPTemp.SETFILTER(Code,'%1',TaxPE."Org Jed");
                  OrgDijeloviPTemp.SETFILTER(GF,'%1',TaxPE.GF);
                 IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN
                   OrgDijeloviP.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                   OrgDijeloviP.SETFILTER(Code,'%1',TaxPE."Org Jed");
                   OrgDijeloviP.SETFILTER(GF,'%1',TaxPE.GF);
                 IF OrgDijeloviP.FINDFIRST THEN BEGIN
                  OrgDijeloviPTemp.INIT;
                  OrgDijeloviPTemp.TRANSFERFIELDS(OrgDijeloviP,TRUE);
                  OrgDijeloviPTemp.INSERT;
                  END;
                  END;
                  OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount,0.00001);
                  OrgDijeloviPTemp.MODIFY;*/

                OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                OrgDijeloviPTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                OrgDijeloviPTemp.SETFILTER(GF, '%1', Emp.GF);
                IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN

                    OrgDijeloviPTemp.INIT;
                    OrgDijeloviPTemp."Municipality Code for salary" := Emp."Municipality Code for salary";
                    OrgDijeloviPTemp."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                    OrgDijeloviPTemp.Code := Emp."Org Jed";
                    OrgDijeloviPTemp.GF := Emp.GF;
                    OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount, 0.00001);
                    OrgDijeloviP.RESET;
                    OrgDijeloviP.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                    OrgDijeloviP.SETFILTER(Code, '%1', Emp."Org Jed");
                    OrgDijeloviP.SETFILTER(GF, '%1', Emp.GF);
                    IF OrgDijeloviP.FINDFIRST THEN begin
                        OrgDijeloviPTemp."JIB Contributes" := OrgDijeloviP."JIB Contributes";
                        OrgDijeloviPTemp."Entity Code" := OrgdijeloviP."Entity Code";
                    end;
                    OrgDijeloviPTemp.INSERT(TRUE);

                END
                ELSE BEGIN
                    OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount, 0.00001);

                    OrgDijeloviPTemp.MODIFY;
                END;
            UNTIL TaxPE.NEXT = 0;





        OrgDijeloviPTemp.SETFILTER("For Calculation 15", '<>%1', 0);
        OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(GF, '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviPTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, OrgDijeloviPTemp."Municipality Code for salary");
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                AddTaxPS.FINDFIRST;

                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                Mun.RESET;
                IF Mun.GET(OrgDijeloviPTemp."Municipality Code for salary") THEN
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := Canton.Description;
                Tip := 2;
                IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                    Sifra := 'FBIH'
                ELSE
                    Sifra := TaxPE."Contribution Category Code";
                Sifra := TaxPE."Contribution Category Code";
                WType := 4;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := OrgDijeloviPTemp."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";

                Opstina := OrgDijeloviPTemp."Municipality Code CIPS";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviPTemp."For Calculation 15", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                Contribution := 'Porez';
                BudgetOrg := AddTaxPS."Budget Organisation";

                /* PozivNaBroj := '00000000';
                 IF WHeader."Month Of Wage" < 10 THEN
                  PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                 ELSE
                  PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviPTemp.NEXT = 0;

    end;

    procedure PoreziDodaciBD(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Contribution Category Code", 'BDPIOFBIH');
        TaxPE.SETRANGE("Wage Calculation Type", 4);
        TaxPE.SETRANGE(Paid, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> '00' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                        Sifra := 'FBIH'
                    ELSE
                        Sifra := TaxPE."Contribution Category Code";
                    Sifra := TaxPE."Contribution Category Code";
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    Mun.CALCFIELDS("Canton Code");
                    IF Mun."Tax Number" = '099' THEN
                        BrojPoreznogObaveznika := '4200344670106'
                    ELSE
                        IF Mun."Canton Code" = '00' THEN
                            BrojPoreznogObaveznika := '4200344670092'
                        ELSE
                            BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Contribution := 'Porez';
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin
                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;
    end;

    procedure PoreziDodaciBDRS(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Contribution Category Code", 'BDPIORS');
        TaxPE.SETRANGE("Wage Calculation Type", 4);
        TaxPE.SETRANGE(Paid, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> '00' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                        Sifra := 'FBIH'
                    ELSE
                        Sifra := TaxPE."Contribution Category Code";
                    Sifra := TaxPE."Contribution Category Code";
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    Mun.CALCFIELDS("Canton Code");
                    IF Mun."Tax Number" = '099' THEN
                        BrojPoreznogObaveznika := '4200344670106'
                    ELSE
                        IF Mun."Canton Code" = '00' THEN
                            BrojPoreznogObaveznika := '4200344670092'
                        ELSE
                            BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.00001);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    BudgetOrg := AddTaxPS."Budget Organisation";
                    Contribution := 'Porez';
                    MunEntity.GET(Opstina);
                    MunEntity.CALCFIELDS("Entity Code");
                    if MunEntity."Entity Code" = 'FBIH' then begin

                        IF WHeader."Month Of Wage" <= 9 THEN
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                        ELSE
                            PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                    end else begin
                        CompanyInfo.get();
                        if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                    end;
                    DatumUplate := WHeader."Closing Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;
    end;

    procedure POrdersAdditionsInitValue(var WHeader: Record "Wage Header"; aWithConfirm: Boolean)
    var
        pOrder: Record "Payment Order";
        CPE: Record "Contribution Per Employee";
        TPE: Record "Tax Per Employee";
    begin
        WithConfirm := aWithConfirm;
        CompInfo.GET;
        IF NOT (WHeader."Payment Orders printed") THEN BEGIN
            IF CompInfo."Entity Code" <> 'RS' THEN BEGIN


                IF M.FINDFIRST THEN
                    REPEAT
                        Department.RESET;
                        Department.SETFILTER(Amount, '<>%1', 0);
                        IF Department.FINDFIRST THEN
                            REPEAT
                                Department.Amount := 0;
                                Department.AmountHealth := 0;
                                Department.AmountTax := 0;
                                Department.MODIFY;
                            UNTIL Department.NEXT = 0;

                        Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN
                            REPEAT
                                Orgdijelovi."For Calculation" := 0;
                                Orgdijelovi."For Calculation 2" := 0;
                                Orgdijelovi."For Calculation 3" := 0;
                                Orgdijelovi."For Calculation 4" := 0;
                                Orgdijelovi."For Calculation 5" := 0;
                                Orgdijelovi."For Calculation 6" := 0;
                                Orgdijelovi."For Calculation 7" := 0;
                                Orgdijelovi."For Calculation FA" := 0;
                                Orgdijelovi."For Calculation FA 2" := 0;
                                Orgdijelovi."For Calculation FA 3" := 0;
                                Orgdijelovi."For Calculation 8" := 0;
                                Orgdijelovi."For Calculation 9" := 0;
                                Orgdijelovi."For Calculation 10" := 0;
                                Orgdijelovi."For Calculation 11" := 0;
                                Orgdijelovi."For Calculation 12" := 0;
                                Orgdijelovi."For Calculation 13" := 0;
                                Orgdijelovi."For Calculation 14" := 0;
                                Orgdijelovi."For Calculation 15" := 0;
                                Orgdijelovi."For Calculation 16" := 0;
                                Orgdijelovi.MODIFY;
                            UNTIL Orgdijelovi.NEXT = 0;

                        M."For Calculation" := 0;
                        M."For Calculation 2" := 0;
                        M."For Calculation 3" := 0;
                        M."For Calculation 4" := 0;
                        M."For Calculation 5" := 0;
                        M."For Calculation 6" := 0;
                        M."For Calculation 7" := 0;
                        M."For Calculation FA" := 0;
                        M."For Calculation FA 2" := 0;
                        M."For Calculation FA 3" := 0;
                        M."For Calculation 8" := 0;
                        M."For Calculation 9" := 0;
                        M."For Calculation 10" := 0;
                        M."For Calculation 11" := 0;
                        M."For Calculation 12" := 0;
                        M."For Calculation 13" := 0;

                        M.MODIFY;
                    UNTIL M.NEXT = 0;


                //   OrgdijeloviRS.DELETEALL;
                DodaciPoBankama(WHeader);
                DoprinosiDodaci(WHeader);
                DoprinosiDodaciBD(WHeader);
                DoprinosiDodaciBDRS(WHeader);
                DoprinosiDodaciRS(WHeader);
                DoprinosiDodaciRSFBIH(WHeader);

                PoreziDodaciBDRS(WHeader);
                PoreziDodaci(WHeader);
                PoreziDodaciRS(WHeader);
                //   OrgdijeloviRS.DELETEALL;

                Orgdijelovi.RESET;

                IF Orgdijelovi.FINDFIRST THEN
                    REPEAT
                        Orgdijelovi."For Calculation" := 0;
                        Orgdijelovi."For Calculation 2" := 0;
                        Orgdijelovi."For Calculation 3" := 0;
                        Orgdijelovi."For Calculation 4" := 0;
                        Orgdijelovi."For Calculation 5" := 0;
                        Orgdijelovi."For Calculation 6" := 0;
                        Orgdijelovi."For Calculation 7" := 0;
                        Orgdijelovi."For Calculation FA" := 0;
                        Orgdijelovi."For Calculation FA 2" := 0;
                        Orgdijelovi."For Calculation FA 3" := 0;
                        Orgdijelovi."For Calculation 8" := 0;
                        Orgdijelovi."For Calculation 9" := 0;
                        Orgdijelovi."For Calculation 10" := 0;
                        Orgdijelovi."For Calculation 11" := 0;
                        Orgdijelovi."For Calculation 12" := 0;
                        Orgdijelovi."For Calculation 13" := 0;
                        Orgdijelovi."For Calculation 14" := 0;
                        Orgdijelovi."For Calculation 15" := 0;
                        Orgdijelovi."For Calculation 16" := 0;
                        Orgdijelovi.MODIFY;
                    UNTIL Orgdijelovi.NEXT = 0;

                PoreziDodaciRSFBIH(WHeader);
                PoreziDodaciBD(WHeader);

            END
            ELSE BEGIN

            END;
            CPE.Reset();
            CPE.SETFILTER("Wage Header No.", '%1', WHeader."No.");
            CPE.SETFILTER("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Additions);
            CPE.SETFILTER(Paid, '%1', false);
            IF CPE.FINDFIRST THEN
                REPEAT
                    CPE.Paid := TRUE;
                    CPE."Payment Date" := WHeader."Closing Date";
                    CPE.MODIFY;
                UNTIL CPE.NEXT = 0;
            TPE.reset;
            TPE.SETFILTER("Wage Header No.", '%1', WHeader."No.");
            TPE.SETFILTER("Wage Calculation Type", '%1', TPE."Wage Calculation Type"::Additions);
            TPE.SETFILTER(Paid, '%1', false);
            IF TPE.FINDFIRST THEN
                REPEAT
                    TPE.Paid := TRUE;
                    TPE."Payment Date" := WHeader."Closing Date";
                    TPE.MODIFY;
                UNTIL TPE.NEXT = 0;

            WHeader."Payment Orders printed" := TRUE;
            WHeader.MODIFY;
            MESSAGE(Txt0061);
            IF NOT WithConfirm THEN BEGIN
                pOrder.RESET;
                pOrder.SETRANGE("Wage Header No.", WHeader."No.");
                pOrder.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
                IF pOrder.FINDFIRST THEN BEGIN
                    COMMIT;
                    PAGE.RUNMODAL(PAGE::"Payment Orders", pOrder);
                END;
            END;
        END
        ELSE BEGIN
            ERROR(Txt015);
        END
    end;

    procedure PoreziRSFBIH(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
        OrgDijeloviPTemp: Record "Org Dijelovi";
        OrgDijeloviP: Record "ORG Dijelovi";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETFILTER("Contribution Category Code", '%1', 'RS');
        TaxPE.SETRANGE("Wage Calculation Type", 0);
        TaxPE.SETFILTER("Canton Code", '<>%1', '00');
        //OrgDijeloviPTemp.RESET;

        /*IF Mun.FINDFIRST THEN REPEAT
         TaxPE.SETRANGE("Tax Number",Mun."Tax Number");
         TaxPE.CALCSUMS(Amount);
         FAmount := TaxPE.Amount;
         IF TaxPE.FINDFIRST THEN BEGIN
        IF TaxPE."Canton Code" = 'FBIHRS' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF TaxPE."Canton Code" = 'FBIH' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
           Canton.GET(TaxPE."Canton Code",'BD');
         END;*/
        IF TaxPE.FINDFIRST THEN
            REPEAT
                Emp.RESET;
                Emp.GET(TaxPE."Employee No.");
                /*OrgDijeloviPTemp.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                OrgDijeloviPTemp.SETFILTER(Code,'%1',TaxPE."Org Jed");
                  OrgDijeloviPTemp.SETFILTER(GF,'%1',TaxPE.GF);
                 IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN
                   OrgDijeloviP.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                   OrgDijeloviP.SETFILTER(Code,'%1',TaxPE."Org Jed");
                   OrgDijeloviP.SETFILTER(GF,'%1',TaxPE.GF);
                 IF OrgDijeloviP.FINDFIRST THEN BEGIN
                  OrgDijeloviPTemp.INIT;
                  OrgDijeloviPTemp.TRANSFERFIELDS(OrgDijeloviP,TRUE);
                  OrgDijeloviPTemp.INSERT;
                  END;
                  END;
                  OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount,0.00001);
                  OrgDijeloviPTemp.MODIFY;*/

                OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                OrgDijeloviPTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                OrgDijeloviPTemp.SETFILTER(GF, '%1', Emp.GF);
                IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN

                    OrgDijeloviPTemp.INIT;
                    OrgDijeloviPTemp."Municipality Code for salary" := Emp."Municipality Code for salary";
                    OrgDijeloviPTemp."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                    OrgDijeloviPTemp.Code := Emp."Org Jed";
                    OrgDijeloviPTemp.GF := Emp.GF;
                    OrgDijeloviPTemp."For Calculation 16" += ROUND(TaxPE.Amount, 0.00001);
                    OrgDijeloviP.RESET;
                    OrgDijeloviP.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                    OrgDijeloviP.SETFILTER(Code, '%1', Emp."Org Jed");
                    OrgDijeloviP.SETFILTER(GF, '%1', Emp.GF);
                    IF OrgDijeloviP.FINDFIRST THEN begin
                        OrgDijeloviPTemp."JIB Contributes" := OrgDijeloviP."JIB Contributes";
                        OrgDijeloviPTemp."Entity Code" := OrgdijeloviP."Entity Code";
                    end;
                    OrgDijeloviPTemp.INSERT(TRUE);

                END
                ELSE BEGIN
                    OrgDijeloviPTemp."For Calculation 16" += ROUND(TaxPE.Amount, 0.00001);

                    OrgDijeloviPTemp.MODIFY;
                END;
            UNTIL TaxPE.NEXT = 0;





        OrgDijeloviPTemp.SETFILTER("For Calculation 16", '<>%1', 0);
        OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(GF, '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviPTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, OrgDijeloviPTemp."Municipality Code for salary");
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                AddTaxPS.FINDFIRST;

                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                Mun.RESET;
                IF Mun.GET(OrgDijeloviPTemp."Municipality Code for salary") THEN
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := Canton.Description;
                Tip := 2;
                IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                    Sifra := 'FBIH'
                ELSE
                    Sifra := TaxPE."Contribution Category Code";
                Sifra := TaxPE."Contribution Category Code";
                WType := 0;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := OrgDijeloviPTemp."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";

                Opstina := OrgDijeloviPTemp."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviPTemp."For Calculation 16", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                Contribution := 'Porez';
                BudgetOrg := AddTaxPS."Budget Organisation";

                /* PozivNaBroj := '00000000';
                 IF WHeader."Month Of Wage" < 10 THEN
                  PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                 ELSE
                  PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Payment Date";
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviPTemp.NEXT = 0;

    end;

    procedure PoreziDodaciRSFBIH(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
        OrgDijeloviPTemp: Record "Org Dijelovi";
        OrgDijeloviP: Record "ORG Dijelovi";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);


        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETFILTER("Contribution Category Code", '%1', 'RS');
        TaxPE.SETRANGE("Wage Calculation Type", 4);
        TaxPE.SETRANGE(Paid, FALSE);
        TaxPE.SETFILTER("Canton Code", '<>%1', '00');
        //OrgDijeloviPTemp.RESET;

        /*IF Mun.FINDFIRST THEN REPEAT
         TaxPE.SETRANGE("Tax Number",Mun."Tax Number");
         TaxPE.CALCSUMS(Amount);
         FAmount := TaxPE.Amount;
         IF TaxPE.FINDFIRST THEN BEGIN
        IF TaxPE."Canton Code" = 'FBIHRS' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF TaxPE."Canton Code" = 'FBIH' THEN
           Canton.GET(TaxPE."Canton Code",'FBIH');
          IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
           Canton.GET(TaxPE."Canton Code",'BD');
         END;*/
        IF TaxPE.FINDFIRST THEN
            REPEAT
                Emp.RESET;
                Emp.GET(TaxPE."Employee No.");
                /*OrgDijeloviPTemp.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                OrgDijeloviPTemp.SETFILTER(Code,'%1',TaxPE."Org Jed");
                  OrgDijeloviPTemp.SETFILTER(GF,'%1',TaxPE.GF);
                 IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN
                   OrgDijeloviP.SETFILTER("Municipality Code for salary",'%1',TaxPE."Tax Number");
                   OrgDijeloviP.SETFILTER(Code,'%1',TaxPE."Org Jed");
                   OrgDijeloviP.SETFILTER(GF,'%1',TaxPE.GF);
                 IF OrgDijeloviP.FINDFIRST THEN BEGIN
                  OrgDijeloviPTemp.INIT;
                  OrgDijeloviPTemp.TRANSFERFIELDS(OrgDijeloviP,TRUE);
                  OrgDijeloviPTemp.INSERT;
                  END;
                  END;
                  OrgDijeloviPTemp."For Calculation 15" += ROUND(TaxPE.Amount,0.00001);
                  OrgDijeloviPTemp.MODIFY;*/

                OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '%1', Emp."Municipality Code CIPS");
                OrgDijeloviPTemp.SETFILTER(Code, '%1', Emp."Org Jed");
                OrgDijeloviPTemp.SETFILTER(GF, '%1', Emp.GF);
                IF NOT OrgDijeloviPTemp.FINDFIRST THEN BEGIN

                    OrgDijeloviPTemp.INIT;
                    OrgDijeloviPTemp."Municipality Code for salary" := Emp."Municipality Code for salary";
                    OrgDijeloviPTemp."Municipality Code CIPS" := Emp."Municipality Code CIPS";
                    OrgDijeloviPTemp.Code := Emp."Org Jed";
                    OrgDijeloviPTemp.GF := Emp.GF;
                    OrgDijeloviPTemp."For Calculation 16" += ROUND(TaxPE.Amount, 0.00001);
                    OrgDijeloviP.RESET;
                    OrgDijeloviP.SETFILTER("Municipality Code for salary", '%1', Emp."Municipality Code for salary");
                    OrgDijeloviP.SETFILTER(Code, '%1', Emp."Org Jed");
                    OrgDijeloviP.SETFILTER(GF, '%1', Emp.GF);
                    IF OrgDijeloviP.FINDFIRST THEN begin
                        OrgDijeloviPTemp."JIB Contributes" := OrgDijeloviP."JIB Contributes";
                        OrgDijeloviPTemp."Entity Code" := OrgdijeloviP."Entity Code";
                    end;
                    OrgDijeloviPTemp.INSERT(TRUE);

                END
                ELSE BEGIN
                    OrgDijeloviPTemp."For Calculation 16" += ROUND(TaxPE.Amount, 0.00001);

                    OrgDijeloviPTemp.MODIFY;
                END;
            UNTIL TaxPE.NEXT = 0;





        OrgDijeloviPTemp.SETFILTER("For Calculation 16", '<>%1', 0);
        OrgDijeloviPTemp.SETFILTER("Municipality Code for salary", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER("Municipality Code CIPS", '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(GF, '<>%1', '');
        OrgDijeloviPTemp.SETFILTER(Code, '<>%1|%1', '', '');
        IF OrgDijeloviPTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                AddTaxPS.SETRANGE(Code, OrgDijeloviPTemp."Municipality Code for salary");
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                AddTaxPS.FINDFIRST;

                InitPaymentOrder;
                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                Mun.RESET;
                IF Mun.GET(OrgDijeloviPTemp."Municipality Code for salary") THEN
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := Canton.Description;
                Tip := 2;
                IF TaxPE."Contribution Category Code" = 'FBIHRS' THEN
                    Sifra := 'FBIH'
                ELSE
                    Sifra := TaxPE."Contribution Category Code";
                Sifra := TaxPE."Contribution Category Code";
                WType := 4;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := OrgDijeloviPTemp."JIB Contributes";
                VrstaPrihoda := AddTaxPS."Revenue Type";

                Opstina := OrgDijeloviPTemp."Municipality Code for salary";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;

                Iznos := ROUND(OrgDijeloviPTemp."For Calculation 16", 0.00001);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                Contribution := 'Porez';
                BudgetOrg := AddTaxPS."Budget Organisation";

                /* PozivNaBroj := '00000000';
                 IF WHeader."Month Of Wage" < 10 THEN
                  PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                 ELSE
                  PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                MunEntity.GET(Opstina);
                MunEntity.CALCFIELDS("Entity Code");
                if MunEntity."Entity Code" = 'FBIH' then begin
                    IF WHeader."Month Of Wage" <= 9 THEN
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage")
                    ELSE
                        PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 8) + FORMAT(WHeader."Month Of Wage");
                end
                else begin
                    CompanyInfo.get();
                    if (CompanyInfo.City = 'Banja Luka') and (strpos(Opstina, 'RS') = 0) then PozivNaBroj := COPYSTR(AddTaxPS."Refer To Number", 1, 9) + FORMAT(WHeader."Month Of Wage") else PozivNaBroj := AddTaxPS."Refer To Number";
                end;
                DatumUplate := WHeader."Closing Date";
                MakePaymentOrder;
            //END;
            UNTIL OrgDijeloviPTemp.NEXT = 0;

    end;
}

