report 50066 "Delete Calculation by Employee"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
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

    trigger OnPreReport()
    begin

        TPE.SETFILTER("Wage Header No.", WageCalc."Wage Header No.");
        TPE.SETFILTER("Wage Calculation No.", WageCalc."No.");
        TPE.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF TPE.FINDFIRST THEN
            TPE.DELETE(TRUE);

        ATPE.SETFILTER("Wage Header No.", WageCalc."Wage Header No.");
        ATPE.SETFILTER("Wage Calc No.", WageCalc."No.");
        ATPE.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF ATPE.FINDFIRST THEN
            ATPE.DELETEALL;

        RPE.SETFILTER("Wage Header No.", WageCalc."Wage Header No.");
        RPE.SETFILTER("Wage Calculation Entry No.", WageCalc."No.");
        RPE.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF RPE.FINDFIRST THEN
            RPE.DELETEALL(TRUE);

        TH.SETRANGE("Year of Wage", WageCalc."Year of Wage");
        TH.SETRANGE("Month Of Wage", WageCalc."Month Of Wage");
        IF TH.FIND('-') THEN BEGIN
            TL.SETRANGE("Document No.", TH."No.");
            TL.SETRANGE("Employee No.", WageCalc."Employee No.");
            IF TL.FINDFIRST THEN
                REPEAT
                    TL.DELETE(TRUE)
                UNTIL TL.NEXT = 0;
            TL.RESET;
            TL.SETRANGE("Document No.", TH."No.");
            IF TL.ISEMPTY THEN
                TH.DELETE(TRUE);
        END;

        MH.SETRANGE("Year Of Wage", WageCalc."Year of Wage");
        MH.SETRANGE("Month Of Wage", WageCalc."Month Of Wage");
        IF MH.FIND('-') THEN BEGIN
            ML.SETRANGE("Document No.", MH."No.");
            ML.SETRANGE("Employee No.", WageCalc."Employee No.");
            IF ML.FINDFIRST THEN
                REPEAT
                    ML.DELETE(TRUE)
                UNTIL ML.NEXT = 0;
            ML.RESET;
            ML.SETRANGE("Document No.", MH."No.");
            IF ML.ISEMPTY THEN
                MH.DELETE(TRUE);
        END;

        WA.SETRANGE("Wage Header No.", WageCalc."Wage Header No.");
        WA.SETFILTER("Wage Calculation Entry No.", WageCalc."No.");
        WA.SETRANGE("Wage Header Entry No.", WageCalc."Entry No.");
        WA.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF WA.FINDFIRST THEN
            WA.DELETEALL;

        WLE.SETFILTER("Document No.", WageCalc."Wage Header No.");
        IF ((WageCalc."Wage Calculation Type" = 0) OR (WageCalc."Wage Calculation Type" = 4)) THEN
            WLE.SETFILTER("Wage Calculation Entry No.", WageCalc."No.");
        WLE.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF WLE.FINDFIRST THEN
            WLE.DELETEALL(TRUE);

        WVE.SETFILTER("Document No.", WageCalc."Wage Header No.");
        WVE.SETFILTER("Wage Calculation Entry No.", WageCalc."No.");
        WVE.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF WVE.FINDFIRST THEN
            WVE.DELETEALL(TRUE);

        EA.SETFILTER("Wage Calculation No.", WageCalc."No.");
        EA.SETFILTER("Employee No.", WageCalc."Employee No.");
        EA.SetFilter("Wage Header No.", WageCalc."Wage Header No.");
        IF EA.FIND('-') THEN
            REPEAT
                EA.Calculated := FALSE;
                EA."Wage Header No." := '';
                EA."Wage Calculation No." := '';
                EA.MODIFY;
            UNTIL EA.NEXT = 0;

        WC.SETFILTER("Wage Header No.", WageCalc."Wage Header No.");
        WC.SETFILTER("No.", WageCalc."No.");
        WC.SETRANGE("Employee No.", WageCalc."Employee No.");
        IF WC.FINDFIRST THEN
            WC.DELETEALL;

        IF ShowMsg THEN MESSAGE(Txt003, WageCalc."Employee No.");
    end;

    var
        Txt003: Label 'Calculation was succesfully deleted for Employee %1';
        Txt001: Label 'This calculation is not closed';
        Err01: Label 'You have to choose only one calculation!';
        TPE: Record "Tax Per Employee";
        WLE: Record "Wage Ledger Entry";
        WVE: Record "Wage Value Entry";
        MH: Record "Meal Header";
        ML: Record "Meal Line";
        WA: Record "Wage Addition";
        WC: Record "Wage Calculation";
        RPE: Record "Reduction per Wage";
        ATPE: Record "Contribution Per Employee";
        TH: Record "Transport Header";
        TL: Record "Transport Line";
        WageCalc: Record "Wage Calculation";
        ShowMsg: Boolean;
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        EA: Record "Employee Absence";

    procedure SETWC(var WCTemp: Record "Wage Calculation"; var ShowMessage: Boolean)
    begin
        WageCalc := WCTemp;
        ShowMsg := ShowMessage;
    end;
}

