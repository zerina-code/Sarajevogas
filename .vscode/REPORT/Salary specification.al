report 50040 "Salary specification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Specifikacija plata - Obrazac 2001.rdl';
    Caption = 'Salary specification - Form 2001';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            column(CompanyName; Name)
            {
            }
            column(CompanyAdress; Address)
            {
            }
            column(JIB; "Registration No.")
            {
            }
            column(Municipiality; MunName)
            {
            }
            column(Picture; Picture)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(pioiz; PIOIZ)
            {
            }
            column(dpioiz; DPIOIZ)
            {
            }
            column(zdraviz; ZDRAVIZ)
            {
            }
            column(dzdraviz; dzdraviz)
            {
            }
            column(nezapiz; NEZAPIZ)
            {
            }
            column(ukupno; Ukupno)
            {
            }
            column(ukupnoS; UkupnoS)
            {
            }
            column(Tax; Tax)
            {
            }
            column(piona; PIONA)
            {
            }
            column(dpiona; DPIONA)
            {
                IncludeCaption = false;
            }
            column(zdravna; ZDRAVNA)
            {
            }
            column(dzdravna; DZDRAVNA)
            {
            }
            column(nezapna; NEZAPNA)
            {
            }
            column(dnezapna; DNEZAPNA)
            {
            }
            column(dnezapiz; DNEZAPIZ)
            {
            }
            column(UkupnoNa; UkupnoNA)
            {
            }
            column(UkupnoSNa; UkupnoSNa)
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(PostOffice; PostOffice)
            {
            }
            column(SumE; SumE)
            {
            }
            column(DirectBrutto; DirectBrutto)
            {
            }
            column(IndirectBrutto; IndirectBrutto)
            {
            }
            column(ExactBrutto; ExactBrutto)
            {
            }
            column(IC; "Industrial Classification")
            {
            }
            column(IDMonth; IDMonth)
            {
            }
            column(IDYear; IDYear)
            {
            }
            column(IDMonthText; IDMonthText)
            {
            }
            column(IDYearText; IDYearText)
            {
            }

            trigger OnAfterGetRecord()
            begin
                WageCalc1.SETFILTER("No.", BrojObracuna);
                IF WageCalc1.FINDFIRST THEN BEGIN
                    Date := DMY2DATE(1, WageCalc1."Month Of Wage", WageCalc1."Year Of Wage");
                    t_UserPer.SETFILTER("User ID", USERID);
                    t_UserPer.FINDFIRST;
                    IF t_UserPer."Language ID" = 1050 THEN
                        EndDate := CALCDATE('SM', Date)
                    ELSE
                        EndDate := CALCDATE('CM', Date);
                    StartDate := Date;
                END;
                FOR i := 1 TO STRLEN("Registration No.") DO
                    IDbroj[i] := COPYSTR("Registration No.", i, 1);
                i := i + 1;

                PostCode.SETFILTER(PostCode.Code, "Post Code");
                IF PostCode.FIND('-') THEN
                    Mun.SETRANGE("Tax Number", "Municipality Code");
                Mun.SetFilter(type, '%1', Mun.Type::Regular);
                IF NOT Mun.FIND('-') THEN Mun.INIT;

                PostOffice := Mun.Name;

                IF STRLEN(FORMAT(IDMonth)) = 1 THEN BEGIN
                    Month[1] := '0';
                    Month[2] := COPYSTR(FORMAT(IDMonth), 1, 1);
                END
                ELSE BEGIN
                    Month[1] := COPYSTR(FORMAT(IDMonth), 1, 1);
                    Month[2] := COPYSTR(FORMAT(IDMonth), 2, 1);
                END;

                Year[1] := COPYSTR(FORMAT(IDYear), 1, 1);
                Year[2] := COPYSTR(FORMAT(IDYear), 2, 1);
                Year[3] := COPYSTR(FORMAT(IDYear), 3, 1);
                Year[4] := COPYSTR(FORMAT(IDYear), 4, 1);



                IF IDMonth = 12 THEN BEGIN
                    Dan[1] := COPYSTR(FORMAT(Datum), 1, 1);
                    Dan[2] := COPYSTR(FORMAT(Datum), 2, 1);
                END
                ELSE BEGIN
                    Dan[1] := COPYSTR(FORMAT(Datum - 1), 1, 1);
                    Dan[2] := COPYSTR(FORMAT(Datum - 1), 2, 1);
                END;


                ATCC.SETFILTER("Category Code", 'FBIH');

                ATCC.SETFILTER("Contribution Code", 'D-NEZAP-IZ');
                IF ATCC.FIND('-') THEN
                    EVALUATE(NEZAPIZ, FORMAT(ATCC.Percentage))
                ELSE
                    EVALUATE(NEZAPIZ, FORMAT(1, 5));

                ATCC.SETFILTER("Contribution Code", 'D-PIO-IZ');
                IF ATCC.FIND('-') THEN
                    EVALUATE(PIOIZ, FORMAT(ATCC.Percentage))
                ELSE
                    EVALUATE(PIOIZ, FORMAT(17, 0));

                ATCC.SETFILTER("Contribution Code", 'D-ZDRAV-IZ');
                IF ATCC.FIND('-') THEN
                    EVALUATE(ZDRAVIZ, FORMAT(ATCC.Percentage))
                ELSE
                    EVALUATE(PIOIZ, FORMAT(12, 50));

                Ukupno := (NEZAPIZ + PIOIZ + ZDRAVIZ);


                DNEZAPIZ := (Brutto * NEZAPIZ) / 100;
                DPIOIZ := (Brutto * PIOIZ) / 100;
                dzdraviz := (Brutto * ZDRAVIZ) / 100;

                UkupnoS := (DNEZAPIZ + DPIOIZ + dzdraviz);

                ATCC.SETFILTER("Category Code", 'FBIH');

                ATCC.SETFILTER("Contribution Code", 'D-NEZAP-NA');
                IF ATCC.FIND('-') THEN
                    EVALUATE(NEZAPNA, FORMAT(ATCC.Percentage))
                ELSE
                    EVALUATE(NEZAPNA, FORMAT(0, 50));

                ATCC.SETFILTER("Contribution Code", 'D-PIO-NA');
                IF ATCC.FIND('-') THEN
                    EVALUATE(PIONA, FORMAT(ATCC.Percentage))
                ELSE
                    EVALUATE(PIOIZ, FORMAT(6, 0));

                ATCC.SETFILTER("Contribution Code", 'D-ZDRAV-NA');
                IF ATCC.FIND('-') THEN
                    EVALUATE(ZDRAVNA, FORMAT(ATCC.Percentage))
                ELSE
                    EVALUATE(PIONA, FORMAT(4, 0));

                UkupnoNA := (NEZAPNA + PIONA + ZDRAVNA);

                DNEZAPNA := (Brutto * NEZAPNA) / 100;
                DPIONA := (Brutto * PIONA) / 100;
                DZDRAVNA := (Brutto * ZDRAVNA) / 100;

                UkupnoSNa := (DNEZAPNA + DPIONA + DZDRAVNA);
                DataItem1.CALCFIELDS(Picture);
                IF Mun.GET(DataItem1."Municipality Code", Mun.type::regular) THEN
                    MunName := Mun.Name
                ELSE
                    MunName := '';
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
                    }
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
                    }
                    field(PrintMinimal; PrintMinimal)
                    {
                        Visible = false;
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

        BEGIN
            IDMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
            IDYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);
            IDDay := DATE2DMY(CALCDATE('-1M', WORKDATE), 1);
        END;
    end;

    trigger OnPreReport()
    begin
        BEGIN
            WageHeader.SETRANGE("Month Of Wage", IDMonth);
            WageHeader.SETRANGE("Year Of Wage", IDYear);
            WageHeader.FIND('-');
            BrojObracuna := WageHeader."No.";

            WageSetup.GET;
            /*IF WageSetup."Leather-Textile Industry" THEN
             IF PrintMinimal = PrintMinimal::Minimal THEN MinimalWageMark := 'X';  */

            Mjesec := FORMAT(IDMonth + 1);
            Godina := IDYear;

            IF STRLEN(FORMAT(Mjesec)) < 2 THEN
                Mjesec := FORMAT('0') + Mjesec;

            IF IDMonth = 12 THEN
                EVALUATE(Datum, FORMAT('31.') + FORMAT('12.') + FORMAT(Godina))
            ELSE
                EVALUATE(Datum, FORMAT('01.') + FORMAT(Mjesec) + FORMAT(Godina));


            WageCalc.SETFILTER("Wage Header No.", BrojObracuna);
            //WageCalc.SETFILTER("Entity Code",'FBiH');

            /*IF WageSetup."Leather-Textile Industry" THEN
             CASE PrintMinimal OF
              PrintMinimal::Minimal:WageCalc.SETRANGE("Leather-Textile Minimal Wage",TRUE);
              PrintMinimal::NonMinimal:WageCalc.SETRANGE("Leather-Textile Minimal Wage",FALSE);
             END
            ELSE*/
            CASE PrintMinimal OF
                PrintMinimal::Minimal:
                    WageCalc.SETRANGE("Minimal Netto Wage", TRUE);
                PrintMinimal::Nonminimal:
                    WageCalc.SETRANGE("Minimal Netto Wage", FALSE);
            END;


            WageCalc.SETFILTER("Wage Calculation Type", '%1', 0);
            IF WageCalc.FIND('-') THEN
                REPEAT
                    Brutto := Brutto + WageCalc.Brutto;
                    ExactBrutto += WageCalc.Brutto;
                    //ExactBrutto += WageCalc."Net Wage" + WageCalc."Contribution From Brutto";
                    IndirectNetto := IndirectNetto + WageCalc."Indirect Wage Addition Amount";
                    Tax := Tax + WageCalc.Tax;


                    GetAddTaxesPercentage(AddTaxPerc);

                    IndirectBrutto := IndirectNetto / (1 - AddTaxPerc / 100);
                    //    DirectBrutto := ExactBrutto - IndirectBrutto;
                    DirectBrutto := Brutto;

                    WageCalc.SETRANGE("Wage Header No.", BrojObracuna);
                    SumE := WageCalc.COUNT;
                    IF IDMonth < 10 THEN
                        IDMonthText := '0' + FORMAT(IDMonth)
                    ELSE
                        IDMonthText := FORMAT(IDMonth);
                    IDYearText := FORMAT(IDYear);


                    //*******************************************Additions****************************************//
                    WVE.RESET;
                    WVE.SETFILTER("Document No.", BrojObracuna);
                    WVE.SETFILTER("Employee No.", WageCalc."Employee No.");
                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT


                            Brutto += WVE."Cost Amount (Brutto)";
                            ExactBrutto += WVE."Cost Amount (Brutto)";
                            GetAddTaxesPercentage(AddTaxPerc);
                        UNTIL WVE.NEXT = 0;
                    DirectBrutto := ExactBrutto - IndirectBrutto;


                    WVET.SETFILTER("Document No.", BrojObracuna);
                    WVET.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                    WVET.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVET.SETFILTER("Employee No.", WageCalc."Employee No.");
                    WVET.SETFILTER("Entry Type", '%1', WVE."Entry Type"::Tax);
                    IF WVET.FIND('-') THEN
                        REPEAT
                            Tax := Tax + WVET."Cost Amount (Netto)";
                            ;
                        UNTIL WVET.NEXT = 0;
                UNTIL WageCalc.NEXT = 0;
            //*******************************************Additions****************************************//


        end;

    end;

    var
        MunName: Text[50];
        WVE: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        t_UserPer: Record "User Personalization";
        Municipality: Record Municipality;
        Date: Date;
        WageCalc1: Record "Wage Header";
        StartDate: Date;
        EndDate: Date;
        IDYearText: Text[50];
        IDMonthText: Text[30];
        dzdraviz: Decimal;
        WageSetup: Record "Wage Setup";
        IDbroj: array[14] of Code[10];
        i: Integer;
        emp: Record Employee;
        SumaE: Integer;
        j: Integer;
        ATCC: Record "Contribution Category Conn.";
        NEZAPIZ: Decimal;
        IDMonth: Integer;
        IDDay: Integer;
        IDYear: Integer;
        WageHeader: Record "Wage Header";
        BrojObracuna: Code[30];
        WageCalc: Record "Wage Calculation";
        IndirectNetto: Decimal;
        IndirectBrutto: Decimal;
        DNEZAPIZ: Decimal;
        DirectBrutto: Decimal;
        SumE: Integer;
        PostCode: Record "Post Code";
        PostOffice: Text[30];
        Month: array[12] of Text[30];
        Year: array[4] of Text;
        PIOIZ: Decimal;
        ZDRAVIZ: Decimal;
        Ukupno: Decimal;
        DZDRAVIS: Decimal;
        DPIOIZ: Decimal;
        DNEZAPIS: Decimal;
        UkupnoS: Decimal;
        NEZAPNA: Decimal;
        ZDRAVNA: Decimal;
        PIONA: Decimal;
        DNEZAPNA: Decimal;
        DZDRAVNA: Decimal;
        DPIONA: Decimal;
        UkupnoNA: Decimal;
        UkupnoSNa: Decimal;
        Tax: Decimal;
        Datum: Date;
        Mjesec: Text[30];
        Godina: Integer;
        Dan: array[2] of Text[30];
        AddTaxPerc: Decimal;
        Mun: Record "Municipality";
        MinimalWageMArk: Text[1];
        ExactBrutto: Decimal;
        PrintMinimal: Option All,Minimal,Nonminimal;
        Brutto: Decimal;

    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    var
        AddTaxes: Record "Contribution";
        ATCCon: Record "Contribution Category Conn.";
    begin
        Percentage := 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        IF AddTaxes.FIND('-') THEN
            REPEAT
                IF ATCCon.GET('FBIH', AddTaxes.Code) THEN
                    Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;
}

