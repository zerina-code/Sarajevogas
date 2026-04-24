codeunit 50001 "Wage Precalculation"
{
    TableNo = "Wage Header";

    trigger OnRun()
    begin
    end;

    var
        CPE: Record "Contribution Per Employee";
        ECL: Record "Employee Contract Ledger";
        WADate: Record "Wage Amounts";
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        Emp: Record "Employee";
        WageHeader: Record "Wage Header";
        Employee: Record "Employee";
        WageCalc: Record "Wage Calculation";
        WageCalcTemp: Record "Wage Calculation Temp";
        WageSetup: Record "Wage Setup";
        Reductions: Record "Reduction";
        ReductionTemp: Record "Reduction per Wage Temp";
        ReductionReal: Record "Reduction per Wage";
        TransHeader: Record "Transport Header";
        MealHeader: Record "Meal Header";
        RedType: Record "Reduction types";
        TempEmployee: Record "Employee" temporary;
        AbsenceFill: Codeunit "Absence Fill";
        AbsenceEmp: Record "Employee Absence";
        EmpContr: Record "Employment Contract";
        WA: Record "Wage Addition";
        WAT: Record "Wage Addition Type";
        WageType: Record "Wage Type";
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        Txt004: Label 'No employees selected for this round of calculations!';
        Txt005: Label 'Transportation for this month was previously calculated. Do you wish to add to that calculation?';
        Txt006: Label 'Are you sure you wish to return to previous step?';
        Txt007: Label 'You must fill Employment contract code for employee %1';
        Txt008: Label 'There is no work day in last 12 months for employee %1';
        Err01: Label 'U kalendaru ne postoji %1';
        StartDate: Date;
        EndDate: Date;
        RedNo: Code[10];
        WageCalcNo: Code[10];
        TotalWageAmount: Decimal;
        NoOfMonths: Integer;
        LMHourValue: Decimal;
        EmpCoefficient: Decimal;
        AlreadyRun: Boolean;
        Err02: Label 'Radnik %1 je počeo sa radom nakon obračuna za ovaj mjesec.';
        Err03: Label 'Wage addition %1 is not defined properly';
        HourPool: Decimal;
        CompInfo: Record "Company Information";
        Errors: Record "Error";
        GlobalHasErrors: Boolean;
        InitMonth: Integer;
        InitYear: Integer;
        InitRec: Boolean;
        Err04: Label 'Polje %2 mora biti veće ili jednako polju %1';
        PostCode: Record "Post Code";
        Err05: Label 'Employee %1, %2 %3 has minimal wage but experience calculated!';
        WageH: Record "Wage Header";
        WageH2: Record "Wage Header";
        RecWageHeader: Record "Wage Header";
        RecWageHeader2: Record "Wage Header";
        WageCalcA: Codeunit "Wage Calculation";
        AbsenceFillEmp: Codeunit "Absence Fill";
        EndDateEmp: Date;
        StartDateEmp: Date;
        COA: Record "Cause of Absence";
        AbsenceEmpTotal: Record "Employee Absence";
        SickLeave: Decimal;
        ELD: Record "Employee Level Of Disability";

    procedure ClosedForm(var Header: Record "Wage Header")
    begin
        WageSetup.GET;
    end;

    procedure InitRecord(var RecWageHeader: Record "Wage Header")
    var
        CalcType: Integer;
        TypeOption: Label 'Normal,Fixed Add,Average Add,Average Coefficient Add;';
        MonthOption: Label 'Januar,Februar,Mart,April,Maj,Juni,Juli,August,Septembar,Oktobar,Novembar,Decembar';
        YearOption: Text[30];
        WHSelection: Text[30];
        WHList: Page "Wage Headers List";
    begin
        InitMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
        InitYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);

        WageSetup.GET;

        //Are there locked calcs in initial month, if yes move initial month to next
        InitRec := FALSE;
        REPEAT
            WageHeader.RESET;
            WageHeader.SETRANGE(Status, WageHeader.Status::Locked);
            WageHeader.SETRANGE("Month Of Wage", InitMonth);
            WageHeader.SETRANGE("Year Of Wage", InitYear);

            IF NOT WageHeader.FINDFIRST THEN
                InitRec := TRUE
            ELSE BEGIN
                InitMonth := InitMonth + 1;

                IF InitMonth > 12 THEN BEGIN
                    InitYear := InitYear + 1;
                    InitMonth := 1;
                END;
            END;
        UNTIL InitRec;

        WageHeader.RESET;
        RecWageHeader.INIT;
        CalcType := STRMENU(TypeOption);
        CASE CalcType OF
            0:
                EXIT;
            1:
                BEGIN

                    WageH.SETRANGE("Month Of Wage", InitMonth);
                    WageH.SETRANGE("Year Of Wage", InitYear);
                    WageH.SETRANGE(Status, WageH.Status::Open);
                    IF WageH.FIND('+') THEN
                        RecWageHeader."No." := WageH."No."
                    ELSE BEGIN
                        WageH2.SETFILTER("No.", '<>%1', '');
                        IF WageH2.FINDLAST THEN
                            RecWageHeader."No." := INCSTR(WageH2."No.")
                        ELSE
                            RecWageHeader."No." := '000000000';
                    END;


                END;
            2, 3, 4:
                BEGIN
                    WHSelection := '';
                    WHList.LOOKUPMODE(TRUE);
                    IF NOT (WHList.RUNMODAL = ACTION::LookupOK) THEN
                        EXIT
                    ELSE
                        WHSelection := WHList.GetSelectionFilter;

                    IF WHSelection = '' THEN
                        EXIT
                    ELSE BEGIN
                        WageHeader.RESET;
                        WageHeader.SETFILTER("No.", SELECTSTR(1, WHSelection));
                        WageHeader.SETFILTER("Entry No.", SELECTSTR(2, WHSelection));
                        IF NOT WageHeader.FINDFIRST THEN EXIT;
                        RecWageHeader."No." := WageHeader."No.";
                        InitMonth := WageHeader."Month Of Wage";
                        InitYear := WageHeader."Year Of Wage";

                        WageHeader.SETRANGE("Entry No.");
                        WageHeader.FIND('+');
                        RecWageHeader."Entry No." := WageHeader."Entry No." + 1;
                    END;
                END;
        END;


        RecWageHeader."Wage Calculation Type" := CalcType - 1;
        /*
        RecWageHeader."Average Yearly Hour Pool":=WageSetup."Average Yearly Hour Pool";
        RecWageHeader."Work Experience Basis":=WageSetup."Work Experience Basis";
        RecWageHeader.Status:= RecWageHeader.Status::Open;
        RecWageHeader."Month Of Wage":=InitMonth;
        RecWageHeader."Year Of Wage":=InitYear;
        RecWageHeader."Month of Calculation":=DATE2DMY(WORKDATE,2);
        RecWageHeader."Year of Calculation":=DATE2DMY(WORKDATE,3);
        RecWageHeader."Date Of Calculation":=WORKDATE;
        
        IF RecWageHeader."Wage Calculation Type" = RecWageHeader."Wage Calculation Type"::Normal THEN BEGIN
         RecWageHeader.Meal := TRUE;
         RecWageHeader.Taxable := TRUE;
         RecWageHeader.Transportation := TRUE;
         RecWageHeader.Reduction := TRUE;
        END;
        
        RecWageHeader."Hour Pool":=AbsenceFill.GetHourPool(InitMonth,InitYear,WageSetup."Hours in Day");
        RecWageHeader."User ID":=USERID;
        RecWageHeader."General Coefficient":=WageSetup."General Coefficient";
        RecWageHeader."Coefficient Increase":=WageSetup."Coefficient Increase";
        
        
        RecWageHeader."Monthly Minimum Wage":=WageSetup."Min. wage on state level"*RecWageHeader."Hour Pool";
        RecWageHeader2.SETRANGE("Month Of Wage",InitMonth);
        RecWageHeader2.SETRANGE("Year Of Wage",InitYear);
        //RecWageHeader2.SETRANGE(Status,RecWageHeader2.Status::Open);
        IF NOT RecWageHeader2.FIND('+') THEN
        // IF  RecWageHeader2.FIND('-') THEN
        
        RecWageHeader.INSERT
        ELSE
        RecWageHeader.MODIFY;
        
        ClosedForm(RecWageHeader);*/

    end;

    procedure CheckHasSetupErrors() HasError: Boolean
    var
        ErrCount: Integer;
        WageType: Record "Wage Type";
        Post: Record "Post Code";
        Municipality: Record "Municipality";
        AddTaxes: Record "Contribution";
        Taxes: Record "Tax Class";
        TxtAddTaxFrom: Label 'Additional taxes from wages were not defined!';
        TxtAddTAxOver: Label 'Additional taxes over wages were not defined!';
        TxtTax: Label 'Taxes were not defined!';
    begin
        HasError := FALSE;
        GlobalHasErrors := FALSE;
        /*
        WageHeader.TESTFIELD("Year of Calculation");
        WageHeader.TESTFIELD("Month of Calculation");
        WageHeader.TESTFIELD("Hour Pool");
        WageHeader.TESTFIELD("Date Of Calculation");
        WageHeader.TESTFIELD("Month Of Wage");
        WageHeader.TESTFIELD("Year Of Wage");
        WageHeader.TESTFIELD("Average Yearly Hour Pool"); */

        IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN BEGIN
            WageHeader."Average Add Period Start" := 0D;
            WageHeader."Average Add Period End" := 0D;
            WageHeader."Average Add Amount" := 0;
            WageHeader."Average Add Percentage" := 0;
        END
        ELSE BEGIN
            IF (WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::"Fixed Add") OR (WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::"Average Amount Add") THEN BEGIN
                WageHeader."Average Add Period Start" := 0D;
                WageHeader."Average Add Period End" := 0D;
                WageHeader."Average Add Amount" := 0;
                WageHeader."Average Add Percentage" := 0;
            END
            ELSE BEGIN
                WageHeader.TESTFIELD("Average Add Period Start");
                WageHeader.TESTFIELD("Average Add Period End");
                IF WageHeader."Average Add Period Start" > WageHeader."Average Add Period End" THEN
                    ERROR(Err04, WageHeader.FIELDCAPTION(WageHeader."Average Add Period End"),
                           WageHeader.FIELDCAPTION(WageHeader."Average Add Period Start"));
                IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::"Average Amount Add" THEN
                    WageHeader.TESTFIELD("Average Add Amount");
                IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::"Average Percentage Add" THEN
                    WageHeader.TESTFIELD("Average Add Percentage");
            END;
        END;

        Errors.RESET;
        Errors.DELETEALL;
        ErrCount := 0;
        Employee.RESET;
        Employee.SETFILTER("For Calculation", '%1', TRUE);

        WageSetup.FINDFIRST;
        CompInfo.GET;

        IF CompInfo."Entity Code" = '' THEN
            AddError(CompInfo.FIELDCAPTION("Entity Code"), CompInfo.TABLECAPTION, Employee."No.", 0, ErrCount, 0);

        IF Employee.FINDFIRST THEN
            REPEAT
                IF NOT WageType.GET(Employee."Wage Type") THEN
                    AddError(Employee.FIELDCAPTION("Wage Type"), WageType.TABLECAPTION, Employee."No.", 0, ErrCount, 0);

                /*IF (WageType."Wage Calculation Type" =
                  WageType."Wage Calculation Type"::Coefficient) THEN
                 AddError('Koeficijent',Employee.TABLECAPTION, Employee."No.",0,ErrCount);*/

                IF Employee."Post Code CIPS" = '' THEN
                    AddError(Employee.FIELDCAPTION("Post Code CIPS"), Employee.TABLECAPTION, Employee."No.", 0, ErrCount, 0);
                IF NOT Post.GET(Employee."Post Code CIPS", Employee."City CIPS") THEN
                    AddError(Employee.FIELDCAPTION("Post Code CIPS"), Post.TABLECAPTION, Employee."No.", 0, ErrCount, 0);
                IF Employee."County CIPS" = '' THEN
                    AddError(Employee.FIELDCAPTION(County), Employee.TABLECAPTION, Employee."No.", 0, ErrCount, 0);
                /*NK01: Since amount distribution based on dimension is in place, there is no need for this error
                IF Employee."Global Dimension 1 Code" = '' THEN
                  AddError(Employee.FIELDCAPTION("Global Dimension 1 Code"), Employee.TABLECAPTION, Employee."No.",0,ErrCount,0);
                */
                IF Employee."Wage Type" = '' THEN
                    AddError(Employee.FIELDCAPTION("Wage Type"), Employee.TABLECAPTION, Employee."No.", 0, ErrCount, 0);
                IF Employee."Contribution Category Code" = '' THEN
                    AddError(Employee.FIELDCAPTION("Contribution Category Code"), Employee.TABLECAPTION, Employee."No.", 0, ErrCount, 0);
                /*  IF Employee."Emplymt. Contract Code" = '' THEN
                   AddError(Employee.FIELDCAPTION("Emplymt. Contract Code"), Employee.TABLECAPTION, Employee."No.",0,ErrCount,0);

                 //IF Employee."Tax Deduction" = 0 THEN
                 //  AddError(Employee.FIELDCAPTION("Tax Deduction"),Employee.TABLECAPTION, Employee."No.",1,ErrCount);
                 //IF Employee."Bank Account No." = '' THEN
                 //  AddError(Employee.FIELDCAPTION("Bank Account No."),Employee.TABLECAPTION, Employee."No.",1,ErrCount);

                 IF Employee."Employee ID" = '' THEN
                   AddError(Employee.FIELDCAPTION("Employee ID"),Employee.TABLECAPTION, Employee."No.",0,ErrCount,0);*/

                IF NOT Municipality.GET(Employee."Municipality Code CIPS", Municipality.Type::Regular) THEN
                    AddError(Employee.FIELDCAPTION("Municipality Code CIPS"), Municipality.TABLECAPTION, Employee."No.", 0, ErrCount, 0);
                IF Municipality."Tax Number" = '' THEN
                    AddError('Opština:' + FORMAT(Municipality.FIELDCAPTION("Tax Number") + Municipality.Code),
                      Municipality.TABLECAPTION, Municipality.Code, 0, ErrCount, 0);



                AbsenceEmp.RESET;
                AbsenceEmpTotal.RESET;

                StartDateEmp := AbsenceFillEmp.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
                EndDateEmp := AbsenceFillEmp.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);
                SickLeave := 0;
                COA.SETFILTER("Calculation Type", '%1', 2);
                IF COA.FINDFIRST THEN
                    REPEAT
                        AbsenceEmp.SETFILTER("From Date", '%1', EndDateEmp);
                        AbsenceEmp.SETFILTER("Employee No.", '%1', Employee."No.");
                        AbsenceEmp.SETFILTER("Cause of Absence Code", '%1', COA.Code);



                        IF AbsenceEmp.FINDFIRST THEN BEGIN
                            IF ((Employee."Transport Amount" <> 0) AND (Employee."Transport Confirmed" = FALSE)) THEN BEGIN

                                AbsenceEmpTotal.SETFILTER("Employee No.", '%1', Employee."No.");
                                AbsenceEmpTotal.SETFILTER("From Date", '%1..%2', StartDateEmp, EndDateEmp);
                                AbsenceEmpTotal.SETFILTER("Cause of Absence Code", '%1', 'B*');
                                IF AbsenceEmpTotal.FINDFIRST THEN BEGIN
                                    AbsenceEmpTotal.CALCSUMS(Quantity);
                                    SickLeave += AbsenceEmpTotal.Quantity;

                                END;
                                AddError('Ukupno sati na bolovanju:' + ' ' + FORMAT(SickLeave), Employee."First Name" + ' ' + Employee."Last Name", AbsenceEmp."Employee No.", 0, ErrCount, Employee."Transport Amount");
                            END;
                        END;
                    UNTIL COA.NEXT = 0;
            UNTIL Employee.NEXT = 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        IF NOT AddTaxes.FINDFIRST THEN
            AddError(TxtAddTaxFrom, AddTaxes.TABLECAPTION, '', 0, ErrCount, 0);

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("Over Brutto", '%1', TRUE);
        IF NOT AddTaxes.FINDFIRST THEN
            AddError(TxtAddTAxOver, AddTaxes.TABLECAPTION, '', 0, ErrCount, 0);


        Taxes.RESET;
        Taxes.SETFILTER(Active, '%1', TRUE);
        IF NOT Taxes.FINDFIRST THEN
            AddError(TxtTax, Taxes.TABLECAPTION, '', 0, ErrCount, 0);

        HasError := GlobalHasErrors;

    end;

    procedure AddError(Desc: Text[250]; Tab: Text[250]; Val: Text[250]; Stat: Integer; var ErrorCount: Integer; Transport: Decimal)
    begin

        ErrorCount := ErrorCount + 1;
        WITH Errors DO BEGIN
            "No." := ErrorCount;
            Description := Desc;
            Table := Tab;
            Value := Val;
            IF Transport = 0 THEN
                Status := Stat
            ELSE
                Status := 2;
            "Transport Amount" := Transport;
            INSERT;
        END;

        IF Stat = 0 THEN
            GlobalHasErrors := TRUE;
    end;

    procedure CheckCritErrors()
    var
        Txt002: Label 'Critical errors were not corrected!';
    begin
        Errors.RESET;
        Errors.SETFILTER(Status, '%1', 0);
        IF Errors.FINDFIRST THEN
            ERROR(Txt002);
    end;

    procedure Reset()
    begin
        WageCalcTemp.RESET;
        WageCalcTemp.DELETEALL;
        ReductionTemp.RESET;
        ReductionTemp.DELETEALL;

        StartDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
        EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);

        WADate.SETFILTER("Application Date", '>=%1', StartDate);
        WADate.SETFILTER("Application Date", '>=%1', EndDate);
        IF WADate.FINDFIRST
            THEN
            REPEAT
                WADate.VALIDATE("Application Date", WADate."Application Date");
                WADate.MODIFY;
            UNTIL WADate.NEXT = 0;
        StartNewCalc;
    end;

    procedure RunPrecalculation(var Rec: Record "Wage Header"; var HasError: Boolean)
    begin
        WageHeader := Rec;

        IF CheckHasSetupErrors THEN BEGIN
            HasError := TRUE;
            EXIT;
        END;

        Reset;

        CalcHours;
        CalcMeal;
        CalcTransport;
        CalcSD;
        CalcIB;

        /*
        IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN
         CalculateNetto;
        
        IF WageHeader."Wage Calculation Type" <> WageHeader."Wage Calculation Type"::Normal THEN
         CalculateAdditionNetto;
        */

    end;

    procedure StartNewCalc()
    var
        CY: Integer;
        CM: Integer;
        CD: Integer;
        YoW: Integer;
        MoW: Integer;
        DoW: Integer;
        YoE: Integer;
        MoE: Integer;
        DoE: Integer;
        RealEmploymentDate: Date;
        TempWageDate: Date;
        ECT: Record "Employment Contract";
        ER: Record "Employee Relative";
        EmplDefDim: Record "Employee Default Dimension";
        GLSetup: Record "General Ledger Setup";
        increment: Integer;
        MonthDay: array[12] of Integer;
        COACT: Record "Cause of Absence";
        AbsenceCT: Record "Employee Absence";
        StartDate: Date;
        EndDate: Date;
        PosMenu: Record "Position Menu";
        WT: Record "Wage Type";
        ATempFLast: Record "Contribution Per Employee";
        LastNumber1: code[20];
        TaxPerEmployeeLast: Record "Tax Per Employee";
        LastNumber2: Code[20];

    begin
        WageCalcNo := '0000000000';
        WageCalc.RESET;
        /*IF WageCalc.FIND('+') THEN
         WageCalcNo := WageCalc."No.";*/
        CPE.RESET;
        CPE.SETCURRENTKEY("Wage Calc No.");
        IF CPE.FIND('+') THEN
            WageCalcNo := CPE."Wage Calc No.";

        ATempFLast.Reset();
        ATempFLast.SetCurrentKey("Wage Calc No.");
        ATempFLast.Ascending;
        if ATempFLast.FindLast() then begin
            LastNumber1 := ATempFLast."Wage Calc No.";
        end;
        if LastNumber1 <> '' then
            WageCalcNo := LastNumber1;





        IF WageHeader.Reduction THEN BEGIN
            RedNo := '0000000000';
            ReductionReal.RESET;
            IF ReductionReal.FIND('+') THEN
                RedNo := ReductionReal."No.";
        END;

        WageSetup.GET;
        Employee.RESET;

        //SD start
        //Employee.SETFILTER(Status,'%1',0);
        //SD end

        IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN
            Employee.SETRANGE("For Calculation", TRUE)
        ELSE
            Employee.SETRANGE("Calculate Wage Addition", TRUE);

        Window.OPEN('Otvaranje obračunskih linija\@1@@@@@@@@@@@@@@@@@@@@@  ::Radnici\');
        Window.UPDATE(1, 0);

        CurrRecNo := 0;
        TotalRecNo := Employee.COUNTAPPROX;

        TempWageDate := DMY2DATE(1, WageHeader."Month Of Wage", WageHeader."Year Of Wage");
        TempWageDate := CALCDATE('<+1M>', TempWageDate);
        TempWageDate := CALCDATE('<-1D>', TempWageDate);

        YoW := DATE2DMY(TempWageDate, 3);
        MoW := DATE2DMY(TempWageDate, 2);
        DoW := DATE2DMY(TempWageDate, 1);


        MonthDay[1] := 31;
        MonthDay[2] := -1;
        MonthDay[3] := 31;
        MonthDay[4] := 30;
        MonthDay[5] := 31;
        MonthDay[6] := 30;
        MonthDay[7] := 31;
        MonthDay[8] := 31;
        MonthDay[9] := 30;
        MonthDay[10] := 31;
        MonthDay[11] := 30;
        MonthDay[12] := 31;


        IF Employee.FINDFIRST THEN
            REPEAT
                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                /*ER.SETRANGE("Employee No.",Employee."No.");
                IF ER.FINDFIRST THEN REPEAT
                 IF NOT ((ER."VAT To" = 0D) OR (ER."VAT From" = 0D)) THEN BEGIN
                  IF (ER."VAT To" < StartDate) OR (ER."VAT From" > EndDate) THEN
                   ER.Status := ER.Status::Inactive;

                  IF (ER."VAT To" >= StartDate) AND (ER."VAT From" <= EndDate) THEN
                   ER.Status := ER.Status::Active;
                  ER.MODIFY;
                 END;
                UNTIL ER.NEXT = 0;*/
                UpdateTaxDeduct(Employee);
            UNTIL Employee.NEXT = 0;

        CurrRecNo := 0;
        Employee.SETFILTER("No.", '<>%1', '');
        Employee.SetFilter("For Calculation", '%1', true);
        IF Employee.FINDFIRST THEN
            REPEAT
                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                /*ER.SETRANGE("Employee No.",Employee."No.");
                IF ER.FINDFIRST THEN REPEAT
                 IF NOT ((ER."VAT To" = 0D) OR (ER."VAT From" = 0D)) THEN BEGIN
                  IF (ER."VAT To" < StartDate) OR (ER."VAT From" > EndDate) THEN
                   ER.VALIDATE(Status,ER.Status::Inactive);

                  IF (ER."VAT To" >= StartDate) AND (ER."VAT From" <= EndDate) THEN
                   ER.VALIDATE(Status,ER.Status::Active);
                  ER.MODIFY;
                 END;
                UNTIL ER.NEXT = 0;*/



                CY := 0;
                CM := 0;
                CD := 0;
                IF Employee."Employment Date" > CALCDATE('<+1M>',
                             DMY2DATE(1, WageHeader."Month Of Wage", WageHeader."Year Of Wage"))
                 THEN
                    ERROR(Err02, Employee."No.");

                IF Employee."Brought Years of Experience" <> 0 THEN
                    RealEmploymentDate := CALCDATE('<-' + FORMAT(Employee."Brought Years of Experience") + 'Y>', Employee."Employment Date")
                ELSE
                    RealEmploymentDate := Employee."Employment Date";

                IF Employee."Brought Months of Experience" <> 0 THEN
                    RealEmploymentDate := CALCDATE('<-' + FORMAT(Employee."Brought Months of Experience") + 'M>', RealEmploymentDate);

                IF Employee."Brought Days of Experience" <> 0 THEN
                    RealEmploymentDate := CALCDATE('<-' + FORMAT(Employee."Brought Days of Experience") + 'D>', RealEmploymentDate);


                YoE := DATE2DMY(RealEmploymentDate, 3);
                MoE := DATE2DMY(RealEmploymentDate, 2);
                DoE := DATE2DMY(RealEmploymentDate, 1);

                increment := 0;
                IF (DoE > DoW) THEN
                    IF MoE = 1 THEN
                        increment := 31 //Ispravak za Moe - 1 = 0
                    ELSE
                        increment := MonthDay[MoE - 1];
                IF increment = -1 THEN BEGIN
                    IF IsLeapYear(YoE) THEN
                        increment := 29
                    ELSE
                        increment := 28;
                END;

                IF (increment <> 0) THEN BEGIN
                    CD := (DoW + increment) - DoE;
                    increment := 1;
                END
                ELSE
                    CD := DoW - DoE;

                IF ((MoE + increment) > MoW) THEN BEGIN
                    CM := (MoW + 12) - (MoE + increment);
                    increment := 1;
                END
                ELSE BEGIN
                    CM := (MoW) - (MoE + increment);
                    increment := 0;
                END;

                CY := YoW - (YoE + increment);

                Employee.VALIDATE("Years of Experience", CY);
                Employee."Months of Experience" := CM;
                Employee."Days of Experience" := CD;


                Employee.MODIFY;
                WageSetup.GET;
                GLSetup.GET;


                WageCalcTemp.RESET;
                WageCalcTemp.INIT;

                EmplDefDim.SETRANGE("No.", Employee."No.");
                IF EmplDefDim.FINDFIRST THEN
                    REPEAT
                        WageCalcNo := INCSTR(WageCalcNo);
                        WageCalcTemp."No." := WageCalcNo;
                        WageCalcTemp."Wage Header No." := WageHeader."No.";
                        WageCalcTemp."Document Year" := DATE2DMY(WORKDATE, 3);
                        EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);

                        WageCalcTemp."Employee No." := Employee."No.";
                        WageCalcTemp."Employee Disability" := Employee."Disabled Person";
                        ECL.Reset();
                        ECL.SetFilter("Starting Date", '<=%1', EndDate);
                        ECL.SetFilter("Employee No.", '%1', Employee."No.");
                        ECL.SetCurrentKey("Starting Date");
                        ECL.Ascending;
                        if ECL.FindLast() then begin

                            WageCalcTemp."Position Coefficient for Wage" := ECL."Position Coefficient for Wage";
                            WageCalcTemp."Wage Base" := WageSetup."Wage Base";
                            PosMenu.Reset();
                            PosMenu.SetFilter("Org. Structure", '%1', ECL."Org. Structure");
                            PosMenu.SetFilter(Description, '%1', ECL."Position Description");
                            PosMenu.SetFilter("Department Code", '%1', ECL."Department Code");
                            if PosMenu.FindFirst() then
                                WageCalcTemp."Position Coefficient" := PosMenu."Position Coefficient Director"
                            else
                                WageCalcTemp."Position Coefficient" := 0;


                        end
                        else begin
                            WageCalcTemp."Position Coefficient for Wage" := 0;
                            WageCalcTemp."Wage Base" := WageSetup."Wage Base";
                            WageCalcTemp."Position Coefficient" := 0;

                        end;
                        WageCalcTemp."Average Salary FBIH" := 0;
                        WageCalcTemp."Average coefficient statute" := 0;

                        WT.Reset();
                        WT.SetFilter(Code, '%1', Employee."Wage Type");
                        if WT.FindFirst() then begin
                            if WT."Wage Calculation Type" = WT."Wage Calculation Type"::Netto2 then begin
                                WageSetup.Get();
                                //neto na ruke
                                WageCalcTemp."Average Salary FBIH" := WageSetup."Average Salary FBIH";
                                WageCalcTemp."Average coefficient statute" := WageSetup."Average coefficient statute";

                            end;

                        end;


                        WageCalcTemp."Month Of Calculation" := WageHeader."Month of Calculation";
                        WageCalcTemp."Year Of Calculation" := WageHeader."Year of Calculation";
                        WageCalcTemp."Entry No." := WageHeader."Entry No.";

                        if WageCalcTemp."Wage Calculation Type" = WageCalcTemp."Wage Calculation Type"::Additions then begin
                            //Đemina dodala
                            ATempFLast.Reset();
                            ATempFLast.SetFilter("Wage Header No.", '%1', WageHeader."No.");
                            ATempFLast.SetCurrentKey("Entry No.");
                            ATempFLast.Ascending;
                            if ATempFLast.FindLast() then begin
                                WageCalcTemp."Entry No." := ATempFLast."Entry No." + 1;
                            end;
                        end;


                        WageCalcTemp."Month Of Wage" := WageHeader."Month Of Wage";
                        WageCalcTemp."Year Of Wage" := WageHeader."Year Of Wage";

                        WageCalcTemp."Work Experience Percentage" := Employee."Work Experience Percentage";
                        WageCalcTemp."Post Code" := Employee."Post Code";
                        WageCalcTemp."Wage Type" := Employee."Wage Type";
                        ELD.RESET;
                        ELD.SETFILTER("Employee No.", '%1', WageCalcTemp."Employee No.");
                        IF ELD.FIND('-') THEN BEGIN
                            IF ((ELD."Level of Disability" = '60') OR (ELD."Level of Disability" = '70') OR (ELD."Level of Disability" = '80') OR (ELD."Level of Disability" = '90') OR (ELD."Level of Disability" = '100') OR (ELD.Code = '10')) THEN
                                WageCalcTemp.Invalid := Employee."Disabled Person";
                        END;
                        WageType.GET(Employee."Wage Type");
                        WageCalcTemp."User ID" := USERID;
                        WageCalcTemp.SGC := Employee."Statistics Group Code";
                        IF EmplDefDim."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
                            WageCalcTemp."Global Dimension 1 Code" := EmplDefDim."Dimension Value Code";
                        IF EmplDefDim."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                            WageCalcTemp."Global Dimension 2 Code" := EmplDefDim."Dimension Value Code";
                        // ECT.GET(Employee."Emplymt. Contract Code");
                        WageCalcTemp."Calculation Type" := ECT."Calculation Type";
                        //WageCalcTemp."Position Code" := Employee."Position Code";

                        WageCalcTemp."Contribution Category Code" := Employee."Contribution Category Code";
                        WageCalcTemp."Base Tax Deduction" := Employee."Tax Deduction Amount" * EmplDefDim."Amount Distribution Coeff.";
                        WageCalcTemp."Tax Deductions" := Employee."Tax Deduction Amount" * EmplDefDim."Amount Distribution Coeff.";
                        WageCalcTemp."Iznos poreske kartice" := Employee."Iznos poreske kartice" * EmplDefDim."Amount Distribution Coeff.";
                        WageCalcTemp."Iznos ličnog odbitka" := Employee."Iznos ličnog odbitka" * EmplDefDim."Amount Distribution Coeff.";

                        PostCode.GET(Employee."Post Code CIPS", Employee."City CIPS");
                        WageCalcTemp."Entity Code" := PostCode."Entity Code";

                        IF Employee."Hours In Day" <> WageSetup."Hours in Day" THEN
                            WageCalcTemp."Hour Pool" := AbsenceFill.GetHourPool(WageHeader."Month Of Wage", WageHeader."Year Of Wage", Employee."Hours In Day"
                          ) * EmplDefDim."Amount Distribution Coeff."
                        ELSE
                            WageCalcTemp."Hour Pool" := WageHeader."Hour Pool" * EmplDefDim."Amount Distribution Coeff.";
                        WageCalcTemp.INSERT;

                        Employee.CALCFIELDS("Department code");
                        IF ((Employee."Contact Center") OR (Employee."Hours In Day" < 8)) THEN BEGIN
                            WageCalcTemp."Hour Pool" := 0;
                            WageCalcTemp.MODIFY;
                            StartDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
                            EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);
                            COACT.RESET;
                            COACT.SETFILTER("Added To Hour Pool", '%1', FALSE);
                            IF COACT.FINDFIRST THEN
                                REPEAT
                                    AbsenceCT.SETFILTER("Employee No.", WageCalcTemp."Employee No.");
                                    AbsenceCT.SETFILTER("Cause of Absence Code", '%1', COACT.Code);
                                    AbsenceCT.SETFILTER("From Date", '%1..%2', StartDate, EndDate);
                                    AbsenceCT.CALCSUMS(Quantity);
                                    WageCalcTemp."Hour Pool" += AbsenceCT.Quantity;
                                    WageCalcTemp.MODIFY;
                                UNTIL COACT.NEXT = 0;

                        END;
                    UNTIL EmplDefDim.NEXT = 0;

            UNTIL Employee.NEXT = 0
        ELSE
            ERROR(Txt004);
        Window.CLOSE;

    end;

    procedure CalcHours()
    begin
        IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN BEGIN
            Window.OPEN('Obrada odsustava!');
            UpdateAbsences(Employee);
            Window.CLOSE;
        END;
    end;

    procedure CalcMeal()
    begin
        IF WageHeader.Meal THEN BEGIN
            MealHeader.SETFILTER("Month Of Wage", '%1', WageHeader."Month Of Wage");
            MealHeader.SETFILTER("Year Of Wage", '%1', WageHeader."Year Of Wage");
            MealHeader.SETFILTER(Status, '<>%1', 2);
            IF NOT MealHeader.FINDFIRST THEN BEGIN
                MealHeader.INIT;
                MealHeader."Year Of Wage" := WageHeader."Year Of Wage";
                MealHeader."Month Of Wage" := WageHeader."Month Of Wage";
                MealHeader.Status := 0;
                MealHeader."User ID" := USERID;
                MealHeader."Date Of Calculation" := WageHeader."Date Of Calculation";
                MealHeader.INSERT(TRUE);
            END
            ELSE BEGIN
                MealHeader."User ID" := USERID;
                MealHeader."Date Of Calculation" := WageHeader."Date Of Calculation";
                MealHeader.MODIFY;
            END;
            AbsenceFill.CalcMeal(MealHeader);
        END;
    end;

    procedure CalcTransport()
    begin
        IF WageHeader.Transportation THEN BEGIN
            TransHeader.SETFILTER("Month Of Wage", '%1', WageHeader."Month Of Wage");
            TransHeader.SETFILTER("Year of Wage", '%1', WageHeader."Year Of Wage");
            TransHeader.SETFILTER(Status, '<>%1', 2);
            IF NOT TransHeader.FINDFIRST THEN BEGIN
                TransHeader.INIT;
                TransHeader."Year of Wage" := WageHeader."Year Of Wage";
                TransHeader."Month Of Wage" := WageHeader."Month Of Wage";
                TransHeader.Status := 0;
                TransHeader."User ID" := USERID;
                TransHeader."Date Of Calculation" := WageHeader."Date Of Calculation";
                TransHeader.INSERT(TRUE);
            END
            ELSE BEGIN
                TransHeader."User ID" := USERID;
                TransHeader."Date Of Calculation" := WageHeader."Date Of Calculation";
                TransHeader.MODIFY;
            END;
            AbsenceFill.CalcTransport(TransHeader);
        END;
    end;

    procedure UpdateAbsences(var EmployeeRec: Record "Employee")
    begin
        //AbsenceFill.FillAbsence(WageHeader."Month Of Wage",WageHeader."Year Of Wage",EmployeeRec);
    end;

    procedure UpdateTaxDeduct(var Emp: Record "Employee")
    var
        ERRec: Record "Employee Relative";
        TaxDeduction: Decimal;
    begin

        IF NOT Emp."Tax Deduction" THEN
            Emp."Tax Deduction Amount" := 0
        ELSE BEGIN
            WageSetup.GET;

            ERRec.SETFILTER("Employee No.", Emp."No.");
            /*ERRec.SETRANGE(Status,ERRec.Status::Active);
            TaxDeduction := 0;
            IF ERRec.FINDFIRST THEN REPEAT
             TaxDeduction += (WageSetup."Base Tax Deduction"*ERRec."VAT Cof"*ERRec."Udio u izd")/100;
            UNTIL ERRec.NEXT=0;
            Emp."Tax Deduction":=WageSetup."Base Tax Deduction"+TaxDeduction; */
        END;
        Emp.MODIFY;

    end;

    procedure IsLeapYear(Year: Integer) LeapYear: Boolean
    var
        DivBy4: Boolean;
        DivBy100: Boolean;
        DivBy400: Boolean;
    begin
        LeapYear := FALSE;

        DivBy4 := ((Year MOD 4) = 0);
        DivBy100 := ((Year MOD 100) = 0);
        DivBy400 := ((Year MOD 400) = 0);

        IF DivBy4 AND NOT DivBy100 THEN
            LeapYear := TRUE;

        IF DivBy4 AND DivBy100 AND DivBy400 THEN
            LeapYear := TRUE;
    end;

    procedure RunAdditionsPrecalculation()
    begin
        /*WageHeader := Rec;
        
        IF CheckHasSetupErrors THEN BEGIN
         HasError := TRUE;
         EXIT;
        END;
        
        Reset;
        
        CalcHours;
        CalcMeal;
        CalcTransport;
        
        {
        IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN
         CalculateNetto;
        
        IF WageHeader."Wage Calculation Type" <> WageHeader."Wage Calculation Type"::Normal THEN
         CalculateAdditionNetto;
        }*/

    end;

    procedure RunPrecalculationAdditions(var Rec: Record "Wage Header"; var HasError: Boolean)
    begin
        WageHeader := Rec;

        IF CheckHasSetupErrors THEN BEGIN
            HasError := TRUE;
            EXIT;
        END;

        Reset;

        WageCalcA.AdditionsCalculation(Rec."Month Of Wage", Rec."Year Of Wage", Rec."No.", Rec."Date Of Calculation");

        /*
        IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN
         CalculateNetto;
        
        IF WageHeader."Wage Calculation Type" <> WageHeader."Wage Calculation Type"::Normal THEN
         CalculateAdditionNetto;
        */

    end;

    procedure CalcSD()
    begin

        //      AbsenceFill.CalcStimulationDestimulation(WageHeader);
    end;

    procedure CalcIB()
    begin

        //   AbsenceFill.CalcIncentiveBonus(WageHeader);
    end;
}

