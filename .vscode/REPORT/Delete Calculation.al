report 50062 "Delete Calculation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Delete Calculation.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {

            trigger OnAfterGetRecord()
            begin
                WageHeader.RESET;

                WageHeader.COPYFILTERS(DataItem1);
                //WageHeader.SETRANGE("Last Calculation In Month", TRUE);




                IF WageHeader.COUNT > 1 THEN ERROR(Txt001);
                IF WageHeader.FIND('+') THEN
                    CurrRecNo := 0;
                TotalRecNo := 12;



                // Reduction!
                /*IF WageHeader.Reduction THEN BEGIN
                
                 RedLine.SETRANGE("Wage Header No.",WageHeader."No.");
                IF Red.Line.FINDFIRST then
                 RedLine.DELETE;
                CurrRecNo += 1;*/


                TPE.SETFILTER("Wage Header No.", WageHeader."No.");
                TPE.SETRANGE("Entry No.", WageHeader."Entry No.");
                IF TPE.FINDFIRST THEN
                    TPE.DELETEALL;

                PaymentOrder.Reset();
                PaymentOrder.SetFilter("Wage Header No.", '%1', WageHeader."No.");
                PaymentOrder.SetFilter("Wage Calculation Type", '%1', PaymentOrder."Wage Calculation Type"::Regular);
                if PaymentOrder.FindFirst() then
                    PaymentOrder.DeleteAll();
                ATPE.SETFILTER("Wage Header No.", WageHeader."No.");
                ATPE.SETRANGE("Entry No.", WageHeader."Entry No.");
                ATPE.SetFilter("Wage Calculation Type", '%1', ATPE."Wage Calculation Type"::Regular);
                IF ATPE.FINDFIRST THEN
                    ATPE.DELETEALL;



                WC.SETFILTER("Wage Header No.", WageHeader."No.");
                WC.SETRANGE("Entry No.", WageHeader."Entry No.");
                WC.SetFilter("Wage Calculation Type", '%1', ATPE."Wage Calculation Type"::Regular);
                IF WC.FINDFIRST THEN
                    WC.DELETEALL;
                TH.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
                TH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");

                IF TH.FIND('-') THEN
                    TL.SETRANGE("Document No.", TH."No.");
                IF TL.FINDFIRST THEN
                    TL.DELETEALL;

                mh.SETRANGE("Year Of Wage", WageHeader."Year Of Wage");
                mh.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                IF mh.FIND('-') THEN
                    mh.DELETEALL;
                // ML.SETRANGE("Document No.",MH."No.");

                WA.Reset();
                //  WA.SETRANGE("Wage Header No.", WageHeader."No.");
                WA.SetFilter("Month of Wage", '%1', WageHeader."Month Of Wage");
                WA.SetFilter("Year of Wage", '%1', WageHeader."Year Of Wage");
                //ĐK  WA.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                Wa.SetFilter(Paid, '%1', false);
                IF WA.FindSet() then
                    repeat
                        WaSetup.Get();
                        if (WA."Wage Addition Type" = WaSetup."Meal Code FBIH") or
                        (WA."Wage Addition Type" = WaSetup."Meal Code FBiH Taxable") then begin
                            WA.Delete();
                        end
                        else begin



                            if WA.Locked = true then
                                WA.Locked := false;
                            if WA.Calculated = true then
                                WA.Calculated := false;
                            WA.Modify();
                        end;

                    until WA.Next() = 0;
                CurrRecNo += 1;
                WH.SETFILTER("No.", WageHeader."No.");
                //WageHeader.SETRANGE("Entry No.",WageHeader."Entry No.");




                IF WageHeader.Transportation THEN begin


                    tl.Reset();
                    tl.SetFilter("Document No.", '%1', WageHeader."No.");
                    if tl.FindFirst() then
                        TL.DELETEALL(TRUE);
                end;

                CurrRecNo += 1;

                IF WageHeader.Meal THEN begin
                    ml.Reset();
                    ml.SetFilter("Year Of Wage", '%1', WageHeader."Year Of Wage");
                    ml.SetFilter("Month Of Wage", '%1', WageHeader."Month Of Wage");
                    if ml.FindFirst() then
                        ML.DELETEALL(TRUE);
                end;
                CurrRecNo += 1;


                WA.MODIFYALL("Calculated Amount", 0);
                WA.MODIFYALL("Wage Header No.", '');
                WA.MODIFYALL("Wage Header Entry No.", 0);
                CurrRecNo += 1;

                WLE.SETFILTER("Document No.", WageHeader."No.");
                //WLE.SETRANGE("Wage Header Entry No.",WageHeader."Entry No.");
                WLE.SetFilter("Wage Calculation Type", '%1', WLE."Wage Calculation Type"::Regular);
                IF WLE.FINDFIRST THEN
                    WLE.DELETEALL(TRUE);


                WVE.SETFILTER("Document No.", WageHeader."No.");
                WVE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                WVE.SetFilter("Wage Calculation Type", '%1', WLE."Wage Calculation Type"::Regular);
                IF WVE.FINDFIRST THEN
                    WVE.DELETEALL(TRUE);

                /*
                IF WVE.FIND('-') THEN REPEAT
                 WLE.GET(WVE."Wage Ledger Entry No.");
                 WLE.MARK(TRUE);
                UNTIL WVE.NEXT = 0;  */

                CurrRecNo += 1;


                //  WLE.MARKEDONLY(TRUE);
                WLE.Reset();
                WLE.SetFilter("Document No.", '%1', WageHeader."No.");
                WLE.SetFilter("Wage Calculation Type", '%1', WLE."Wage Calculation Type"::Regular);
                if wle.FindFirst() then
                    WLE.DELETEALL(TRUE);
                /*
                WageHeader.Status := WageHeader.Status::"0";
                WageHeader.MODIFY;         */

                CurrRecNo += 1;


                tpe2.SETFILTER("Wage Header No.", ' ');
                tpe2.SETRANGE(Amount, 0);
                IF tpe2.FINDFIRST THEN
                    tpe2.DELETEALL;

                //WG

                StartDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", TRUE);
                EndDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", FALSE);

                EA.SETFILTER("From Date", '%1..%2', StartDate, EndDate);
                IF EA.FINDSET THEN
                    REPEAT
                        EA.Calculated := FALSE;
                        EA."Wage Header No." := '';
                        EA."Wage Calculation No." := '';
                        EA.MODIFY;
                    UNTIL EA.NEXT = 0;



                RPE.Reset();

                RPE.SETFILTER("Wage Header No.", WageHeader."No.");
                //   RPE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                if rpe.FindSet() then
                    repeat
                        rpe.Delete();

                        ReductionStatus.Reset();
                        ReductionStatus.SetFilter("Employee No.", '%1', RPE."Employee No.");
                        ReductionStatus.SetFilter("No.", '%1', rpe."Reduction No.");
                        if ReductionStatus.FindFirst() then begin
                            ReductionStatus.CalcFields("Paid Amount");
                            if ReductionStatus."Reduction Amount" - ReductionStatus."Opening balance" - ReductionStatus."Paid Amount" > 0
                            then begin
                                if ReductionStatus.Status = ReductionStatus.Status::Zatvoren then
                                    ReductionStatus.Status := ReductionStatus.Status::Otvoren;
                                ReductionStatus.Modify();
                            end;
                        end;



                    until RPE.Next() = 0;

                WH.Reset();
                WH.SetFilter("No.", '%1', DataItem1."No.");

                if WH.FindFirst() then BEGIN
                    wAGEvA.Reset();
                    wAGEvA.SetFilter("Document No.", '%1', DataItem1."No.");
                    wAGEvA.SetFilter("Wage Calculation Type", '<>%1', wAGEvA."Wage Calculation Type"::Regular);
                    IF NOT wAGEvA.FindFirst() THEN
                        WH.Delete(true);
                END;


                MESSAGE(Txt003);

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

    var
        WageHeader: Record "Wage Header";
        WaSetup: Record "Wage Setup";
        Txt003: Label 'Calculation was succesfully deleted';
        Txt001: Label 'This calculation is not closed';
        Err01: Label 'You have to choose only one calculation!';
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        wAGEvA: Record "Wage Value Entry";
        ReductionStatus: Record Reduction;
        RedLine: Record "Reduction per Wage";
        TPE: Record "Tax Per Employee";
        EMpF: code[20];
        WLE: Record "Wage Ledger Entry";
        WVE: Record "Wage Value Entry";
        ML: Record "Meal Header";
        WA: Record "Wage Addition";
        WC: Record "Wage Calculation";
        RPE: Record "Reduction per Wage";
        ATPE: Record "Contribution Per Employee";
        TH: Record "Transport Header";
        TL: Record "Transport Line";
        Window: Dialog;
        mh: Record "Meal Header";
        WH: Record "Wage Header";
        tpe2: Record "Tax Per Employee";
        AbsenceFill: Codeunit "Absence Fill";
        PaymentOrder: Record "Payment Order";
        StartDate: Date;
        EndDate: Date;
        EA: Record "Employee Absence";
        EMP: Record Employee;
}

