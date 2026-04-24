report 50093 "Temporary Contract Calculation"
{
    ProcessingOnly = true;
    Caption = 'Temporary Contract Calculation';

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            RequestFilterFields = "No.", "Wage Posting Group";

            trigger OnAfterGetRecord()
            var
                WageCalc2: Record "Wage Calculation";
                ContributionConn: Record "Contribution Category Conn.";
                Class: Record "Tax Class";
                Class2: Record "Tax Class";
                CompInfo: Record "Company Information";
                Procenti: Decimal;
                CPELast: Record "Contribution Per Employee";
                CPEEx: Record "Contribution Per Employee";
            begin

                DimValueCode := '';

                EmpDefDim.SETFILTER("No.", '%1', "No.");
                IF EmpDefDim.FIND('-') THEN
                    DimValueCode := EmpDefDim."Dimension Value Code";

                IF (("Temporary Contract Type" = 1) OR ("Temporary Contract Type" = 2)) THEN BEGIN

                    //ugovor o djelu
                    WageAmountTable.SETFILTER("Employee No.", "No.");
                    IF WageAmountTable.FINDFIRST THEN
                        EmpWage := WageAmountTable."Wage Amount";

                    //iznos bruto plate

                    No := '';

                    HourPool := 0;
                    IF "Temporary Contract Type" = 2 THEN
                        PriznatiRashodi := 0
                    ELSE
                        PriznatiRashodi := EmpWage * 0.2;


                    OsnovicaZaObracunDoprinosa := EmpWage - PriznatiRashodi;


                    //bruto iznos - oke

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*PIO*');
                    if ContributionConn.FindFirst() then
                        DoprinosPIO := OsnovicaZaObracunDoprinosa * (ContributionConn.Percentage / 100)
                    else
                        DoprinosPIO := 0;



                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*ZDR*');
                    if ContributionConn.FindFirst() then
                        DoprinosZaZdravstvenoOsiguranje := OsnovicaZaObracunDoprinosa * (ContributionConn.Percentage / 100)
                    else
                        DoprinosZaZdravstvenoOsiguranje := 0;


                    OsnovicaZaObracunPoreza := OsnovicaZaObracunDoprinosa - DoprinosZaZdravstvenoOsiguranje;
                    CompInfo.GET();
                    Class.RESET;
                    Class.SETCURRENTKEY("Valid From Amount");
                    // Class.SETRANGE(Active, TRUE);
                    Class.SETRANGE(Code, DataItem1."Contribution Category Code");

                    IF Class.FINDFIRST THEN
                        Procenti := Class.Percentage
                    ELSE
                        Procenti := 0;

                    if Procenti = 0 then begin

                        Class2.RESET;
                        Class2.SETCURRENTKEY("Valid From Amount");
                        Class2.SETRANGE(Active, TRUE);
                        Class2.SETRANGE("Entity Code", 'FBIH');
                        Class2.FINDFIRST;
                        Procenti := Class2.Percentage;

                    end;


                    PorezNaDohodak := OsnovicaZaObracunPoreza * (Procenti / 100);
                    //WageAmountNet := EmpWage / 1.12208;
                    IF strpos("Contribution Category Code", 'UOD 0%') <> 0 THEN
                        WageAmountNet := OsnovicaZaObracunDoprinosa - DoprinosZaZdravstvenoOsiguranje - PorezNaDohodak
                    ELSE
                        WageAmountNet := EmpWage - DoprinosZaZdravstvenoOsiguranje - PorezNaDohodak;


                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*NEP*');
                    if ContributionConn.FindFirst() then
                        Nesrece := WageAmountNet * (ContributionConn.Percentage / 100)
                    else
                        Nesrece := 0;

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*VOD*');
                    if ContributionConn.FindFirst() then
                        VodnaNaknada := WageAmountNet * (ContributionConn.Percentage / 100)
                    else
                        VodnaNaknada := 0;




                    OstaliTroskovi := DoprinosPIO + DoprinosZaZdravstvenoOsiguranje + PorezNaDohodak + Nesrece + VodnaNaknada;
                    UkupniTroskovi := WageAmountNet + OstaliTroskovi;




                    WageCalc2.SETFILTER("No.", '<>%1', '');
                    IF WageCalc2.FINDLAST THEN
                        No := INCSTR(WageCalc2."No.")
                    ELSE
                        No := '000000000';





                    WageCalc.INIT;
                    WageCalc."No." := (No);


                    WageCalc."Wage Header No." := WageHeaderNo;
                    WageCalc."Employee No." := "No.";

                    WageCalc."Document Year" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                    WageCalc."Year of Wage" := IDYear;
                    WageCalc."Month Of Wage" := IDMonth;
                    WageCalc."Year Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                    WageCalc."Month Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 2);
                    WageSetup.GET;
                    WageCalc."Hour Pool" := AF.GetHourPool(IDMonth, IDYear, 8);
                    //IF HourPool<>0 THEN
                    WageCalc."Employee Coefficient" := EmpWage / WageCalc."Hour Pool";
                    WageCalc.Brutto := EmpWage;
                    WageCalc."Wage (Base)" := EmpWage;
                    WageCalc."Contribution From Brutto" := DoprinosZaZdravstvenoOsiguranje;
                    WageCalc."Contribution Over Brutto" := DoprinosPIO;
                    WageCalc."Net Wage 2" := WageAmountNet;
                    WageCalc."Contribution Over Netto" := Nesrece + VodnaNaknada;
                    WageCalc."Net Wage" := WageAmountNet;
                    WageCalc."Net Wage After Tax" := WageAmountNet;
                    //WageCalc."Net Wage After Tax":=EmpWage-DoprinosZaZdravstvenoOsiguranje;
                    WageCalc."Final Net Wage" := WageAmountNet;
                    WageCalc.Payment := WageAmountNet;
                    WageCalc."Tax Basis" := OsnovicaZaObracunPoreza;
                    WageCalc.Tax := PorezNaDohodak;
                    WageCalc."Approved Expenditures" := PriznatiRashodi;
                    WageCalc."Wage Calculation Type" := 1;
                    WageCalc."Payment Date" := PDate;
                    WageCalc."User ID" := USERID;
                    WageCalc."Contribution Category Code" := "Contribution Category Code";
                    WageCalc."Global Dimension 1 Code" := DimValueCode;
                    WageCalc.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageCalc."Wage Header No.";
                    CPE."Wage Calc No." := No;

                    CPEEx.Reset();
                    CPEEx.SetFilter("Wage Calc No.", '%1', CPE."Wage Calc No.");
                    CPEEx.SetFilter("Employee No.", '%1', CPE."Employee No.");
                    if CPEEx.FindFirst() then begin
                        CPELast.Reset();
                        CPELast.SetCurrentKey("Wage Calc No.");
                        CPELast.Ascending;
                        if CPELast.FindLast() then begin
                            CPE."Wage Calc No." := INCSTR(CPELast."Wage Calc No.");
                            No := CPE."Wage Calc No.";
                        end;
                    end;


                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Employee No." := "No.";
                    CPE."Contribution Code" := 'D-PIO-NA';
                    CPE."Amount Over Wage" := DoprinosPIO;
                    CPE."Amount On Wage" := DoprinosPIO;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Payment Date" := PDate;
                    CPE."Wage Calculation Type" := 1;
                    CPE.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageCalc."Wage Header No.";
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    ;
                    CPE."Wage Calc No." := No;
                    CPE."Contribution Code" := 'D-ZDRAV-IZ';
                    CPE."Employee No." := "No.";
                    CPE."Amount From Wage" := DoprinosZaZdravstvenoOsiguranje;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Wage Calculation Type" := 1;
                    CPE."Payment Date" := PDate;
                    CPE.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageCalc."Wage Header No.";
                    CPE."Wage Calc No." := No;
                    CPE."Employee No." := "No.";
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Contribution Code" := 'P-ELNEP';
                    CPE."Amount Over Wage" := Nesrece;
                    CPE."Amount On Wage" := Nesrece;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Payment Date" := PDate;
                    CPE."Wage Calculation Type" := 1;

                    CPE.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageCalc."Wage Header No.";
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Wage Calc No." := No;
                    CPE."Contribution Code" := 'P-VOD';
                    CPE."Employee No." := "No.";
                    CPE."Amount Over Wage" := VodnaNaknada;
                    CPE."Amount On Wage" := VodnaNaknada;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Wage Calculation Type" := 1;
                    CPE."Payment Date" := PDate;
                    CPE.INSERT;

                END;

                IF "Temporary Contract Type" = 3 THEN BEGIN
                    WageAmountTable.SETFILTER("Employee No.", "No.");
                    IF WageAmountTable.FINDFIRST THEN
                        EmpWage := WageAmountTable."Wage Amount";

                    No := '';
                    //NKWageHeaderNo:='';
                    HourPool := 0;


                    OsnovicaZaObracunDoprinosa := EmpWage;
                    OsnovicaZaObracunPoreza := EmpWage;
                    CompInfo.GET();
                    Class.RESET;
                    Class.SETCURRENTKEY("Valid From Amount");
                    // Class.SETRANGE(Active, TRUE);
                    Class.SETRANGE(Code, DataItem1."Contribution Category Code");

                    IF Class.FINDFIRST THEN
                        Procenti := Class.Percentage
                    ELSE
                        Procenti := 0;

                    if Procenti = 0 then begin

                        Class2.RESET;
                        Class2.SETCURRENTKEY("Valid From Amount");
                        Class2.SETRANGE(Active, TRUE);
                        Class2.SETRANGE("Entity Code", 'FBIH');
                        Class2.FINDFIRST;
                        Procenti := Class2.Percentage;

                    end;

                    PorezNaDohodak := OsnovicaZaObracunPoreza * Procenti;
                    WageAmountNet := EmpWage - PorezNaDohodak;

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*NEP*');
                    if ContributionConn.FindFirst() then
                        Nesrece := WageAmountNet * (ContributionConn.Percentage / 100)
                    else
                        Nesrece := 0;

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*VOD*');
                    if ContributionConn.FindFirst() then
                        VodnaNaknada := WageAmountNet * (ContributionConn.Percentage / 100)
                    else
                        VodnaNaknada := 0;

                    //Đk 

                    WageCalc2.SETFILTER("No.", '<>%1', '');
                    IF WageCalc2.FINDLAST THEN
                        No := INCSTR(WageCalc2."No.")
                    ELSE
                        No := '000000000';


                    WageCalc.INIT;
                    WageCalc."No." := (No);


                    WageCalc."Wage Header No." := WageHeaderNo;
                    WageCalc."Employee No." := "No.";
                    //IF WageCalc.FINDLAST THEN No:=WageCalc."No.";
                    WageCalc.SETFILTER("Year of Wage", '%1', IDYear);
                    WageCalc.SETFILTER("Month Of Wage", '%1', IDMonth);
                    IF WageCalc.FIND('+') THEN BEGIN

                        WageHeaderNo := WageCalc."Wage Header No.";
                        HourPool := WageCalc."Hour Pool";
                    END;

                    WageCalc.INIT;
                    WageCalc."No." := INCSTR(No);
                    WageCalc."Wage Header No." := WageHeaderNo;
                    WageCalc."Employee No." := "No.";
                    WageCalc."Document Year" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                    WageCalc."Year of Wage" := IDYear;
                    WageCalc."Month Of Wage" := IDMonth;
                    WageCalc."Year Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                    WageCalc."Month Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 2);
                    WageCalc."Net Wage 2" := WageAmountNet - PorezNaDohodak;
                    WageCalc."Hour Pool" := HourPool;
                    //IF HourPool <>0 THEN
                    WageCalc."Employee Coefficient" := EmpWage / AF.GetHourPool(IDMonth, IDYear, 8);
                    ;
                    WageCalc.Brutto := EmpWage;
                    WageCalc."Wage (Base)" := EmpWage;
                    WageCalc."Net Wage" := WageAmountNet;
                    WageCalc."Net Wage After Tax" := EmpWage - PorezNaDohodak;
                    WageCalc."Final Net Wage" := WageAmountNet;
                    WageCalc."Net Wage Netto 2" := Nesrece + VodnaNaknada;
                    WageCalc.Payment := WageAmountNet;
                    WageCalc."Contribution Over Netto" := Nesrece + VodnaNaknada;
                    WageCalc."Tax Basis" := OsnovicaZaObracunPoreza;
                    WageCalc.Tax := PorezNaDohodak;
                    WageCalc."Wage Calculation Type" := 2;
                    WageCalc."Payment Date" := PDate;
                    WageCalc."User ID" := USERID;
                    WageCalc."Contribution Category Code" := "Contribution Category Code";
                    WageCalc."Global Dimension 1 Code" := DimValueCode;
                    WageCalc.INSERT;


                    CPE.INIT;
                    CPE."Wage Header No." := WageHeaderNo;
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Wage Calc No." := INCSTR(No);

                    CPEEx.Reset();
                    CPEEx.SetFilter("Wage Calc No.", '%1', CPE."Wage Calc No.");
                    CPEEx.SetFilter("Employee No.", '%1', CPE."Employee No.");
                    if CPEEx.FindFirst() then begin
                        CPELast.Reset();
                        CPELast.SetCurrentKey("Wage Calc No.");
                        CPELast.Ascending;
                        if CPELast.FindLast() then begin
                            CPE."Wage Calc No." := INCSTR(CPELast."Wage Calc No.");
                            No := CPe."Wage Calc No.";
                        end;
                    end;

                    CPE."Employee No." := "No.";
                    CPE."Contribution Code" := 'P-ELNEP';
                    CPE."Amount Over Wage" := Nesrece;
                    CPE."Amount On Wage" := Nesrece;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Wage Calculation Type" := 2;
                    CPE."Payment Date" := PDate;
                    CPE.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageHeaderNo;
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Wage Calc No." := INCSTR(No);
                    CPE."Contribution Code" := 'P-VOD';
                    CPE."Employee No." := "No.";
                    CPE."Amount Over Wage" := VodnaNaknada;
                    CPE."Amount On Wage" := VodnaNaknada;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Wage Calculation Type" := 2;
                    CPE."Payment Date" := PDate;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE.INSERT;

                END;


                IF "Temporary Contract Type" = 4 THEN BEGIN
                    WageAmountTable.SETFILTER("Employee No.", "No.");
                    IF WageAmountTable.FINDFIRST THEN
                        EmpWage := WageAmountTable."Wage Amount";

                    No := '';
                    WageHeaderNo := '';
                    HourPool := 0;

                    PriznatiRashodi := EmpWage * 0.3;
                    OsnovicaZaObracunDoprinosa := EmpWage - PriznatiRashodi;

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*PIO*');
                    if ContributionConn.FindFirst() then
                        DoprinosPIO := OsnovicaZaObracunDoprinosa * (ContributionConn.Percentage / 100)
                    else
                        DoprinosPIO := 0;


                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*ZDR*');
                    if ContributionConn.FindFirst() then
                        DoprinosZaZdravstvenoOsiguranje := OsnovicaZaObracunDoprinosa * (ContributionConn.Percentage / 100)
                    else
                        DoprinosZaZdravstvenoOsiguranje := 0;

                    OsnovicaZaObracunPoreza := OsnovicaZaObracunDoprinosa - DoprinosZaZdravstvenoOsiguranje;


                    CompInfo.GET();
                    Class.RESET;
                    Class.SETCURRENTKEY("Valid From Amount");
                    // Class.SETRANGE(Active, TRUE);
                    Class.SETRANGE(Code, DataItem1."Contribution Category Code");

                    IF Class.FINDFIRST THEN
                        Procenti := Class.Percentage
                    ELSE
                        Procenti := 0;

                    if Procenti = 0 then begin

                        Class2.RESET;
                        Class2.SETCURRENTKEY("Valid From Amount");
                        Class2.SETRANGE(Active, TRUE);
                        Class2.SETRANGE("Entity Code", 'FBIH');
                        Class2.FINDFIRST;
                        Procenti := Class2.Percentage;

                    end;
                    PorezNaDohodak := OsnovicaZaObracunPoreza * Procenti;

                    WageAmountNet := EmpWage / 1.12208;

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*NEP*');
                    if ContributionConn.FindFirst() then
                        Nesrece := ((EmpWage - DoprinosZaZdravstvenoOsiguranje - PorezNaDohodak)) * (ContributionConn.Percentage / 100)
                    else
                        Nesrece := 0;

                    ContributionConn.Reset();
                    ContributionConn.SetFilter("Category Code", '%1', DataItem1."Contribution Category Code");
                    ContributionConn.SetFilter("Contribution Code", '%1', '@*VOD*');
                    if ContributionConn.FindFirst() then
                        VodnaNaknada := ((EmpWage - DoprinosZaZdravstvenoOsiguranje - PorezNaDohodak)) * (ContributionConn.Percentage / 100)
                    else
                        VodnaNaknada := 0;

                    OstaliTroskovi := DoprinosPIO + DoprinosZaZdravstvenoOsiguranje + PorezNaDohodak + Nesrece + VodnaNaknada;
                    UkupniTroskovi := WageAmountNet + OstaliTroskovi;

                    IF WageCalc.FINDLAST THEN BEGIN
                        No := WageCalc."No.";
                        WageCalc.SETFILTER("Year of Wage", '%1', IDYear);
                        WageCalc.SETFILTER("Month Of Wage", '%1', IDMonth);
                        IF WageCalc.FIND('+') THEN BEGIN


                            WageHeaderNo := WageCalc."Wage Header No.";
                            HourPool := WageCalc."Hour Pool";
                        END;
                    END;

                    WageCalc.INIT;
                    WageCalc."No." := INCSTR(No);
                    WageCalc."Wage Header No." := WageHeaderNo;
                    WageCalc."Employee No." := "No.";
                    WageCalc."Document Year" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                    WageCalc."Year of Wage" := IDYear;
                    WageCalc."Month Of Wage" := IDMonth;
                    WageCalc."Year Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                    WageCalc."Month Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 2);

                    WageCalc."Hour Pool" := AF.GetHourPool(IDMonth, IDYear, 8);
                    ;
                    //IF HourPool<>0 THEN
                    WageCalc."Employee Coefficient" := EmpWage / WageCalc."Hour Pool";
                    WageCalc.Brutto := EmpWage;
                    WageCalc."Wage (Base)" := EmpWage;
                    //WageCalc."Contribution From Brutto":=DoprinosZaZdravstvenoOsiguranje+DoprinosPIO;
                    WageCalc."Contribution From Brutto" := DoprinosZaZdravstvenoOsiguranje;
                    WageCalc."Contribution Over Brutto" := DoprinosPIO;
                    //WageCalc."Contribution On Brutto":=DoprinosPIO;
                    WageCalc."Contribution Over Netto" := Nesrece + VodnaNaknada;
                    WageCalc."Net Wage 2" := EmpWage - DoprinosZaZdravstvenoOsiguranje;
                    WageCalc."Net Wage" := EmpWage - DoprinosZaZdravstvenoOsiguranje;
                    WageCalc."Net Wage After Tax" := EmpWage - DoprinosZaZdravstvenoOsiguranje - PorezNaDohodak;
                    WageCalc."Final Net Wage" := EmpWage - PorezNaDohodak - DoprinosZaZdravstvenoOsiguranje;
                    WageCalc.Payment := WageAmountNet;
                    WageCalc."Tax Basis" := OsnovicaZaObracunPoreza;
                    WageCalc.Tax := PorezNaDohodak;
                    WageCalc."Approved Expenditures" := PriznatiRashodi;
                    WageCalc."Wage Calculation Type" := 3;
                    WageCalc."User ID" := USERID;
                    WageCalc."Payment Date" := PDate;
                    WageCalc."Contribution Category Code" := "Contribution Category Code";
                    WageCalc."Global Dimension 1 Code" := DimValueCode;
                    WageCalc.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageHeaderNo;
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Wage Calc No." := INCSTR(No);

                    CPEEx.Reset();
                    CPEEx.SetFilter("Wage Calc No.", '%1', CPE."Wage Calc No.");
                    CPEEx.SetFilter("Employee No.", '%1', CPE."Employee No.");
                    if CPEEx.FindFirst() then begin
                        CPELast.Reset();
                        CPELast.SetCurrentKey("Wage Calc No.");
                        CPELast.Ascending;
                        if CPELast.FindLast() then begin
                            CPE."Wage Calc No." := INCSTR(CPELast."Wage Calc No.");
                            No := CPe."Wage Calc No.";
                        end;
                    end;

                    CPE."Employee No." := "No.";
                    CPE."Contribution Code" := 'D-PIO-NA';
                    CPE."Amount Over Wage" := DoprinosPIO;
                    CPE."Amount On Wage" := DoprinosPIO;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Wage Calculation Type" := 3;
                    CPE."Payment Date" := PDate;

                    CPE.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageHeaderNo;
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Wage Calc No." := INCSTR(No);
                    CPE."Contribution Code" := 'D-ZDRAV-IZ';
                    CPE."Employee No." := "No.";
                    CPE."Amount From Wage" := DoprinosZaZdravstvenoOsiguranje;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE."Wage Calculation Type" := 3;
                    CPE."Payment Date" := PDate;

                    CPE.INSERT;

                    CPE.INIT;
                    CPE."Wage Header No." := WageHeaderNo;
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Wage Calc No." := INCSTR(No);
                    CPE."Employee No." := "No.";
                    CPE."Contribution Code" := 'P-ELNEP';
                    CPE."Amount Over Wage" := Nesrece;
                    CPE."Amount On Wage" := Nesrece;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Wage Calculation Type" := 3;
                    CPE."Payment Date" := PDate;
                    CPE."Global Dimension 1 Code" := DimValueCode;
                    CPE.INSERT;

                    CPE.INIT;

                    CPE."Wage Header No." := WageHeaderNo;
                    CPE."Wage Calc No." := INCSTR(No);
                    CPE."Contribution Category Code" := WageCalc."Contribution Category Code";
                    CPE."Contribution Code" := 'P-VOD';
                    CPE."Employee No." := "No.";
                    CPE."Amount Over Wage" := VodnaNaknada;
                    CPE."Amount On Wage" := VodnaNaknada;
                    CPE.Basis := OsnovicaZaObracunPoreza;
                    CPE."Wage Calculation Type" := 3;
                    CPE."Payment Date" := PDate;
                    CPE."Global Dimension 1 Code" := DimValueCode;

                    CPE.INSERT;

                END;

                IF WLE.FINDLAST THEN EntryNo := WLE."Entry No." + 1 ELSE EntryNo := 0;

                WLE.INIT;
                No := INCSTR(No);

                WLE."Entry No." := EntryNo;
                IF EVALUATE(WHO, WageHeaderNo) THEN
                    WLE."Wage Header Entry No." := WHO;
                WLE."Employee No." := "No.";
                WLE."Document No." := WageHeaderNo;
                WLE.Description := '';

                WLE.Open := TRUE;
                /* WLE."Global Dimension 1 Code":=WageCalc."Global Dimension 1 Code";
                 WLE."Global Dimension 2 Code":=WageCalc."Global Dimension 2 Code";
                // WLE."Shortcut Dimension 4 Code":=WageCalc."Shortcut Dimension 4 Code";*/
                WLE."Document Date" := TODAY;

                WLE."Posting Date" := AF.GetMonthRange(IDMonth, IDYear, FALSE);
                WLE."No. Series" := '';
                WLE."Month Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 2);
                WLE."Year Of Calculation" := DATE2DMY(CALCDATE('-1M', TODAY), 3);
                WLE."Month Of Wage" := IDMonth;
                WLE."Year Of Wage" := IDYear;
                WLE."Global Dimension 1 Code" := DimValueCode;
                WLE.INSERT;

                ValueEntriesExist := FALSE;


                PostingGroup := "Wage Posting Group";
                /*Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Prirez', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc,WVE."Entry Type"::"Added Tax Per City",WageCalc."Added Tax Per City",'',
                ValueEntriesExist,0,WageCalc.Type);*/

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Porez', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::Tax, WageCalc.Tax, '',
                ValueEntriesExist, 0, WageCalc."Wage Calculation Type");

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Neto plaća', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", WageCalc."Net Wage", '', ValueEntriesExist, 0, WageCalc."Wage Calculation Type");


                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Topli Obrok za isplatu', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", WageCalc."Meal to pay", '', ValueEntriesExist, 0, WageCalc."Wage Calculation Type");


                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Topli Obrok za refundaciju', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::"Meal to refund", WageCalc."Meal to refund", '', ValueEntriesExist, 0, WageCalc."Wage Calculation Type");

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Prijevoz', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::Transport, WageCalc.Transport, '', ValueEntriesExist, 0, WageCalc."Wage Calculation Type");

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Bolovanje-poduzeće', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::"Sick Leave-Company", WageCalc."Sick Leave-Company", '',
                ValueEntriesExist, 0, WageCalc."Wage Calculation Type");

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Bolovanje-zavod', WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::"Sick Leave-Fund", WageCalc."Sick Leave-Fund", '', ValueEntriesExist, 0, WageCalc."Wage Calculation Type");

                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", WLE."Employee No.");
                ATTemp.SETFILTER("Wage Header No.", WageHeaderNo);
                ATTemp.SETFILTER("Wage Calc No.", WageCalc."No.");
                ATTemp.SETRANGE("Entry No.", WageCalc."Entry No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", WageCalc."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", WageCalc."Global Dimension 2 Code");
                //ATTemp.SETRANGE("Shortcut Dimension 4 Code", WageCalc."Shortcut Dimension 4 Code");

                ATTemp.SETFILTER("Amount From Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, ATax.Description, WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                        InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                         ATTemp."Amount From Wage", ATax.Code,
                                         ValueEntriesExist, ATTemp.Basis, WageCalc."Wage Calculation Type")
                    UNTIL ATTemp.NEXT = 0;
                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", "No.");
                ATTemp.SETFILTER("Wage Header No.", WageHeaderNo);

                ATTemp.SETFILTER("Wage Calc No.", WageCalc."No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", WageCalc."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", WageCalc."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", WageCalc."Shortcut Dimension 4 Code");

                ATTemp.SETRANGE("Entry No.", WageCalc."Entry No.");
                ATTemp.SETFILTER("Amount Over Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, ATax.Description, WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                        InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                         ATTemp."Amount Over Wage", ATax.Code,
                                         ValueEntriesExist, ATTemp.Basis, WageCalc."Wage Calculation Type")
                    UNTIL ATTemp.NEXT = 0;

                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", "No.");
                ATTemp.SETFILTER("Wage Header No.", WageHeaderNo);
                ATTemp.SETRANGE("Global Dimension 1 Code", WageCalc."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", WageCalc."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", WageCalc."Shortcut Dimension 4 Code");

                ATTemp.SETFILTER("Wage Calc No.", WageCalc."No.");
                ATTemp.SETRANGE("Entry No.", WageCalc."Entry No.");
                ATTemp.SETFILTER("Amount Over Neto", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT

                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, ATax.Description, WLE."Employee No.", "No."), 1, MAXSTRLEN(Desc));
                        InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                         ATTemp."Amount Over Neto", ATax.Code,
                                         ValueEntriesExist, ATTemp.Basis, WageCalc."Wage Calculation Type")
                    UNTIL ATTemp.NEXT = 0;

                /*IF TPE.FINDLAST THEN CalcNo:=INCSTR(TPE."Wage Calculation No.")
                ELSE  TPE."Wage Calculation No.":='0';
                
                        TPE.INIT;
                        //TPE."Entry No.":=EntryNo;
                        TPE."Wage Calculation No.":=CalcNo;
                
                        TPE."Wage Header No." := WageHeaderNo;
                        TPE."Employee No.":=  "No.";
                        TPE."Contribution Category Code":="Contribution Category Code";
                        TPE."Tax Number":="Municipality Code";
                        TPE."Canton Code":=County;
                        TPE.Amount:= PorezNaDohodak;
                        TPE.INSERT;   END;    */

                TPE.SETRANGE("Wage Calculation No.");
                IF TPE.FINDLAST THEN
                    CalcNo := INCSTR(TPE."Wage Calculation No.")
                ELSE
                    CalcNo := '00000000';


                TPE.INIT;
                TPE."Wage Header No." := WageCalc."Wage Header No.";
                TPE."Wage Calculation No." := WageCalc."No.";
                TPE."Employee No." := "No.";
                TPE."Contribution Category Code" := "Contribution Category Code";
                TPE."Tax Number" := "Municipality Code CIPS";
                TPE."Canton Code" := County;
                TPE.Amount := PorezNaDohodak;
                TPE."Wage Calculation Type" := WageCalc."Wage Calculation Type";
                TPE.INSERT;

            end;

            trigger OnPostDataItem()
            begin
                MESSAGE(Txt000);
            end;

            trigger OnPreDataItem()
            var
                GroupFIlteer: text;
            begin
                /*WC.SETFILTER("Month Of Wage",'%1',IDMonth);
                WC.SETFILTER("Year of Wage",'%1', IDYear);
                WC.SETFILTER("Wage Calculation Type",'%1|%2|%3', 1,2,3);
                    IF WC.FIND('-') THEN BEGIN
                    // ERROR(Txt011)  ;
                     CurrReport.BREAK;
                     END;   */
                EmpFilter := GETFILTER("No.");
                GroupFIlteer := GetFilter("Wage Posting Group");

                IF (EmpFilter = '') and (GroupFIlteer = '') THEN
                    ERROR('Niste odabrali zaposlenika za obračun');

                WageHeaderNo := '';

                WageSetup.GET;
                //RecWageHeader."No." := WageHeader."No.";
                WageH.SETFILTER("Year Of Wage", '%1', IDYear);
                WageH.SETFILTER("Month Of Wage", '%1', IDMonth);
                IF WageH.FIND('+') THEN
                    WH."No." := WageH."No."
                ELSE BEGIN
                    WageH2.SETFILTER("No.", '<>%1', '');
                    IF WageH2.FINDLAST THEN
                        WH."No." := INCSTR(WageH2."No.")
                    ELSE
                        WH."No." := '000000000';
                END;
                WageHeaderNo := WH."No.";

                wh2.SETRANGE("Entry No.");
                IF wh2.FIND('+') THEN
                    WH."Entry No." := wh2."Entry No." + 1
                ELSE
                    wh2."Entry No." := 0;

                WH."Average Yearly Hour Pool" := WageSetup."Average Yearly Hour Pool";
                WH."Work Experience Basis" := WageSetup."Work Experience Basis";
                WH.Status := WH.Status::Open;
                WH."Month Of Wage" := IDMonth;
                WH."Year Of Wage" := IDYear;
                WH."Month of Calculation" := DATE2DMY(WORKDATE, 2);
                WH."Year of Calculation" := DATE2DMY(WORKDATE, 3);
                WH."Date Of Calculation" := WORKDATE;

                WH."Hour Pool" := AF.GetHourPool(IDMonth, IDYear, 8);
                WH."User ID" := USERID;
                WH."General Coefficient" := WageSetup."General Coefficient";
                WH."Coefficient Increase" := WageSetup."Coefficient Increase";


                WH."Monthly Minimum Wage" := WageSetup."Min. wage on state level" * WH."Hour Pool";
                WageH.SETFILTER("Year Of Wage", '%1', IDYear);
                WageH.SETFILTER("Month Of Wage", '%1', IDMonth);
                IF NOT WageH.FIND('+') THEN
                    WH.INSERT;

                SETFILTER("Temporary Contract Type", '<>%1', 0);

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
                        Caption = 'Month';
                        ApplicationArea = all;
                    }
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
                        ApplicationArea = all;
                    }
                    field(PDate; PDate)
                    {
                        Caption = 'Payment Date';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }


        trigger OnOpenPage()
        begin
            IDMonth := DATE2DMY(CALCDATE('0D', TODAY), 2);
            IDYear := DATE2DMY(CALCDATE('0D', TODAY), 3);
        end;
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
        PDate := today;
    end;

    trigger OnPreReport()
    begin
        LineNo := 1000;
        //INT1.0 start
        UTemp.Reset();
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
    end;

    var
        WageH: Record "Wage Header";

        WageAllowed: Boolean;
        WageSetup: Record "Wage Setup";
        WC: Record "Wage Calculation";
        WH: Record "Wage Header";
        AF: Codeunit "Absence Fill";
        CalcNo: Code[30];
        TPE: Record "Tax Per Employee";
        DimValueCode: Code[30];
        EmpDefDim: Record "Employee Default Dimension";
        PostingGroup: Code[30];
        ATax: Record "Contribution";
        ValueEntryNo: Integer;
        ATTemp: Record "Contribution Per Employee";
        Desc: Text[500];
        ValueEntriesExist: Boolean;
        WHO: Integer;
        EntryNo: Integer;
        WageAmountTable: Record "Wage Amounts";
        PDate: date;
        HourPool: Integer;
        No: Code[30];
        WageHeaderNo: Code[30];
        EmpWage: Decimal;
        PriznatiRashodi: Decimal;
        OsnovicaZaObracunDoprinosa: Decimal;
        DoprinosZaZdravstvenoOsiguranje: Decimal;
        DoprinosPIO: Decimal;
        OsnovicaZaObracunPoreza: Decimal;
        PorezNaDohodak: Decimal;
        VodnaNaknada: Decimal;
        Nesrece: Decimal;
        OstaliTroskovi: Decimal;
        UkupniTroskovi: Decimal;
        WPG: Record "Wage Posting Groups";
        CPS: Record "Contribution Posting Setup";
        WageCalc: Record "Wage Calculation";
        GenJournalBatch: Record "Gen. Journal Batch";
        GnJrnLines: Record "Gen. Journal Line";
        NoSerMgmt: Codeunit NoSeriesExtented;
        UTemp: Record "User Setup";
        WageAmountNet: Decimal;
        IDMonth: Integer;
        IDYear: Integer;
        CPE: Record "Contribution Per Employee";
        LineNo: Integer;
        Txt000: Label 'Temporary service contracts are calculated.';
        WLE: Record "Wage Ledger Entry";
        WVE: Record "Wage Value Entry";
        Txt004: Label '4';
        Txt011: Label 'Calculatin for chosen period already exists!';
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
        WageH2: Record "Wage Header";
        wh2: Record "Wage Header";
        EmpFilter: Text;

    procedure InsertValueEntry(TextString: Text[50]; EntryType: Option Tax,"Contribution Per City","Net Wage","Additional Tax"," Sick Leave"; Amount: Decimal; "Contribution Code": Code[10]; var EntriesExist: Boolean; Basis: Decimal; type: Option Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions)
    begin
        IF Amount = 0 THEN
            EXIT;
        ValueEntryNo := 100000000;

        IF WVE.FINDLAST THEN ValueEntryNo := WVE."Entry No." + 1 ELSE ValueEntryNo := 0;

        WVE.INIT;
        WVE."Entry No." := ValueEntryNo;
        WVE."Employee No." := WLE."Employee No.";
        DataItem1.GET(WLE."Employee No.");
        WVE."Document No." := WageHeaderNo;
        WVE."Wage Header Entry No." := EntryNo;
        WVE.Description := TextString;
        WVE."Wage Posting Group" := PostingGroup;
        WVE."Wage Ledger Entry No." := WLE."Entry No.";
        WVE."User ID" := USERID;
        WVE."Global Dimension 1 Code" := WLE."Global Dimension 1 Code";
        WVE."Global Dimension 2 Code" := WLE."Global Dimension 2 Code";
        WVE."Shortcut Dimension 4 Code" := WLE."Shortcut Dimension 4 Code";
        WVE."Cost Amount (Actual)" := Amount;
        WVE."Document Date" := TODAY;
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
        WVE."Post Code" := DataItem1."Post Code";
        WVE."Wage Calculation Type" := type;
        WVE.Basis := Basis;
        WVE."Contracted Work" := WLE."Contracted Work";

        WVE.INSERT;
        EntriesExist := TRUE;
    end;
}

