/*report 50026 "Reopen Calculation"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Unlock calculation
    // 
    // //Functionality:
    // //Reverses the Close Calculation report
    DefaultLayout = RDLC;
    RDLCLayout = './Reopen Calculation.rdl';


    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {

            trigger OnPreDataItem()
            begin
                //is the calc already locked?
                WageHeader.RESET;

                WageHeader.COPYFILTERS(DataItem1);
                //WageHeader.SETRANGE("Last Calculation In Month", TRUE);


                IF WageHeader.COUNT > 1 THEN ERROR(Err01);
                IF WageHeader.FIND('+') THEN
                    IF WageHeader.Status <> WageHeader.Status::Open THEN
                        ERROR(Txt001);

                CurrRecNo := 0;
                TotalRecNo := 12;

                Window.OPEN('Otvaranje plata :' + '#1#' + ' od ' + FORMAT(TotalRecNo));
                Window.UPDATE(1, 0);

                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                // Reduction!
                IF WageHeader.Reduction THEN BEGIN

                    RedLine.SETFILTER("Wage Header No.", WageHeader."No.");
                    RedLine.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                    RedLine.MODIFYALL(Locked, FALSE);

                    RedMain.RESET;
                    RedMain.RESET;
                    RedMain.SETRANGE(RedMain.Status, RedMain.Status::Zatvoren);
                    IF RedMain.FIND('-') THEN
                        REPEAT
                            RedLockFlag := TRUE;
                            IF RedType.GET(RedMain.Type) THEN
                                IF RedType.AmountWithoutLimit THEN
                                    RedLockFlag := FALSE;

                            IF RedLockFlag THEN BEGIN
                                RedMain.CALCFIELDS("No. of Installments paid", "Paid Amount");
                                IF ((RedMain."No. of Installments" > 0) AND (RedMain."No. of Installments paid" < RedMain."No. of Installments")) OR
                                   ((RedMain."Reduction Amount" > 0) AND (RedMain."Paid Amount" < RedMain."Reduction Amount")) THEN BEGIN
                                    RedMain.Status := RedMain.Status::Otvoren;
                                    RedMain.MODIFY;
                                END;
                            END;
                        UNTIL RedMain.NEXT = 0;
                    RedLine.DELETEALL(TRUE);
                END;
                WageSetup.GET;


                // Brisanja!
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                TPE.SETFILTER("Wage Header No.", WageHeader."No.");
                TPE.SETRANGE("Entry No.", WageHeader."Entry No.");

                ATPE.SETFILTER("Wage Header No.", WageHeader."No.");
                ATPE.SETRANGE("Entry No.", WageHeader."Entry No.");

                RPE.SETFILTER("Wage Header No.", WageHeader."No.");
                RPE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                WC.SETFILTER("Wage Header No.", WageHeader."No.");
                WC.SETRANGE("Entry No.", WageHeader."Entry No.");

                IF WageHeader.Transportation THEN BEGIN
                    TH.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
                    TH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                    TH.FIND('-');
                    TL.SETRANGE("Document No.", TH."No.");
                END;

                IF WageHeader.Meal THEN BEGIN
                    MH.SETRANGE("Year Of Wage", WageHeader."Year Of Wage");
                    MH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                    MH.FIND('-');
                    ML.SETRANGE("Document No.", MH."No.");
                END;

                WA.SETRANGE("Wage Header No.", WageHeader."No.");
                WA.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                TPE.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                ATPE.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                RPE.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                WC.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                IF WageHeader.Transportation THEN
                    TL.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                IF WageHeader.Transportation THEN
                    TL.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                IF WageHeader.Meal THEN
                    ML.DELETEALL(TRUE);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                WA.MODIFYALL("Calculated Amount", 0);
                WA.MODIFYALL("Wage Header No.", '');
                WA.MODIFYALL("Wage Header Entry No.", 0);
                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);


                WVE.SETFILTER("Document No.", WageHeader."No.");
                WVE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                IF WVE.FIND('-') THEN
                    REPEAT
                        WLE.GET(WVE."Wage Ledger Entry No.");
                        WLE.MARK(TRUE);
                    UNTIL WVE.NEXT = 0;

                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                WLE.MARKEDONLY(TRUE);
                WLE.DELETEALL(TRUE);

                WageHeader.Status := WageHeader.Status::Closed;
                WageHeader.MODIFY;

                CurrRecNo += 1;
                Window.UPDATE(1, CurrRecNo);

                Window.CLOSE;

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
        RedMain: Record "Reduction";
        RedLine: Record "Reduction per Wage";
        RedType: Record "Reduction Types";
        TPE: Record "Tax Per Employee";
        ATPE: Record "Contribution Per Employee";
        WLE: Record "Wage Ledger Entry";
        RPE: Record "Reduction per Wage";
        WC: Record "Wage Calculation";
        WVE: Record "Wage Value Entry";
        TH: Record "Transport Header";
        TL: Record "Transport Line";
        MH: Record "Meal Header";
        ML: Record "Meal Line";
        WA: Record "Wage Addition";
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        RedLockFlag: Boolean;
        WageSetup: Record "Wage Setup";
        WPClose: Codeunit "Wage Precalculation";
        Txt003: Label 'Calculation was succesfully unlocked.';
        Txt001: Label 'This calculation is not closed';
        Err01: Label 'You have to choose only one calculation!';
}

*/