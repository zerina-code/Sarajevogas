report 50203 "MIP - 1023 BDPIOFBIH"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MIP - 1023 BDPIOFBIH.rdlc';

    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {
            DataItemTableView = ORDER(Ascending);
            RequestFilterFields = "Year Of Wage", "Month Of Wage";
            column(KompanijaNaziv; CompInfo.Name)
            {
            }
            column(JIB; CompInfo."Registration No.")
            {
            }
            column(IC; CompInfo."Industrial Classification")
            {
            }
            column(MjesecPoreza; IDMonth)
            {
            }
            column(GodinaPoreza; IDYear)
            {
            }
            column(IDMonthText; IDMonthText)
            {
            }
            dataitem(DataItem4; "Wage Calculation")
            {
                DataItemLink = "Wage Header No." = FIELD("No.");
                RequestFilterFields = "Employee No.";
                column(sumPIO; sumPIO)
                {
                }
                column(sumZDR; sumZDR)
                {
                }
                column(sumNZ; sumNZ)
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
                column(BrojObracuna; "No.")
                {
                }
                column(BrojZaposlenikaWC; "Employee No.")
                {
                }
                column(MjesecPlateWC; "Month Of Wage")
                {
                }
                column(GodinaPlateWC; "Year of Wage")
                {
                }
                column(TaxDeduction; "Tax Deductions")
                {
                }
                column(TaxBasis; "Tax Basis" + TaxBasisAdd)
                {
                }
                column(Tax; Tax + TaxAdd)
                {
                }
                column(MjesecObracuna; "Payment Date")
                {
                }
                column(UnpaidHours; "Unpaid Absence Hours")
                {
                }
                column(Bruto; DirectBrutto)
                {
                }
                column(IndirectBruto; IndirectBrutto)
                {
                }
                column(DatuIsplate; "Payment Date")
                {
                }
                column(BrojRadnihSati; "Individual Hour Pool" + +SickHourPool)
                {
                }
                column(BrojZaposlenika; Employee."No.")
                {
                }
                column(JMB; Employee."Employee ID")
                {
                }
                column(Brojac; Brojac)
                {
                }
                column(Zaposlenik; Zaposlenik)
                {
                }
                column(ZaposlenikJMBG; ZaposlenikJMBG)
                {
                }
                column(ZaposlenikOpcina; ZaposlenikOpcina)
                {
                }
                column(SatiNaBolovanju; SickHourPool)
                {
                }
                column(DatumPOcetakBrisi; StartDateD)
                {
                }
                column(NezapIZ; TotalNezapIZ)
                {
                }
                column(Pom; Pom)
                {
                }
                column(PIOsa1; novaSuma)
                {
                }
                column(PomZdr; Pom_Zdravstvo)
                {
                }
                column(PIOsa2; suma1)
                {
                }
                column(SumZdrav; "sum zdr")
                {
                }
                column(PaymentDate; "Payment Date")
                {
                }
                column(DepartmentName; DepartmentName)
                {
                }
                column(DepartmentID; DepartmentID)
                {
                }
                column(DepartmentIC; DepartmentIC)
                {
                }

                trigger OnAfterGetRecord()
                var
                    wc: Record "Wage Calculation";
                    wc2: Record "Wage Calculation";
                begin
                    //Doprinosi za pio i zdravstvo SMstart
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;
                    sumZDRna := 0;
                    sumPIOna := 0;
                    sumNZna := 0;
                    suma1 := 0;
                    suma1NA := 0;
                    novaSuma := 0;

                    t_ContrEmp.RESET;
                    CLEAR(t_ContrEmp);
                    t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1|%2', 'D-PIO-IZ', 'D-PIO-NA');
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumPIO += t_ContrEmp."Amount From Wage";
                            sumPIOna += t_ContrEmp."Amount Over Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;

                    //NK01
                    wc.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');

                    IF wc.FINDFIRST THEN BEGIN
                        CPE1.RESET;
                        CLEAR(CPE1);
                        CPE1.SETFILTER("Employee No.", "Employee No.");
                        CPE1.SETFILTER("Wage Header No.", "Wage Header No.");
                        CPE1.SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
                        CPE1.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');
                        IF CPE1.FINDFIRST THEN BEGIN
                            REPEAT
                                Pom := 1;
                                novaSuma += CPE1."Amount From Wage";
                            //sumPIOna+=CPE1."Amount Over Wage"     ;
                            UNTIL CPE1.NEXT = 0;
                        END;
                    END;
                    wc.RESET;


                    wc2.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');

                    IF wc2.FINDFIRST THEN BEGIN
                        CPE2.RESET;
                        CLEAR(CPE2);
                        CPE2.SETFILTER("Employee No.", "Employee No.");
                        CPE2.SETFILTER("Wage Header No.", "Wage Header No.");
                        CPE2.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');
                        CPE2.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');

                        IF CPE2.FINDFIRST THEN BEGIN
                            REPEAT
                                Pom := 2;
                                suma1 += CPE2."Amount From Wage";
                            //sumPIOna+=CPE1."Amount Over Wage"     ;
                            UNTIL CPE2.NEXT = 0;
                        END;
                    END;
                    //NK01



                    t_ContrEmp1.RESET;
                    CLEAR(t_ContrEmp1);

                    t_ContrEmp1.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp1.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp1.SETFILTER(t_ContrEmp1."Contribution Code", '%1|%2', 'D-ZDRAV-IZ', 'D-ZDRAV-NA');
                    IF t_ContrEmp1.FINDFIRST THEN BEGIN
                        REPEAT
                            sumZDR += t_ContrEmp1."Amount From Wage";
                            sumZDRna += t_ContrEmp1."Amount Over Wage";

                        UNTIL t_ContrEmp1.NEXT = 0;
                    END;

                    t_ContrEmp2.RESET;
                    CLEAR(t_ContrEmp2);

                    t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code", '%1|%2', 'D-NEZAP-IZ', 'D-NEZAP-NA');
                    IF t_ContrEmp2.FINDFIRST THEN BEGIN
                        REPEAT
                            sumNZ += t_ContrEmp2."Amount From Wage";
                            sumNZna += t_ContrEmp2."Amount Over Wage";
                        UNTIL t_ContrEmp2.NEXT = 0;
                    END;

                    //zdravstvo
                    wc2.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
                    IF wc2.FINDFIRST THEN BEGIN
                        "Altervative Address".SETFILTER("Employee No.", "Employee No.");
                        //NKBC "Altervative Address".SETFILTER("Entity Code CIPS", '%1', 'BD');
                        IF "Altervative Address".FINDFIRST THEN BEGIN
                            REPEAT
                                Pom_Zdravstvo := 1;
                                CPE3.SETFILTER("Employee No.", FORMAT("Altervative Address".Code));
                                CPE3.SETFILTER("Wage Header No.", "Wage Header No.");
                                CPE3.SETFILTER(CPE3."Contribution Code", '%1', 'D-ZDRAV-IZ');
                                IF CPE3.FINDFIRST THEN
                                    REPEAT
                                        CPE3.CALCSUMS("Amount From Wage");
                                        "sum zdr" += CPE3."Amount From Wage";
                                    UNTIL CPE3.NEXT = 0;
                            // END;
                            UNTIL "Altervative Address".NEXT = 0;
                        END;
                    END;
                    wc2.RESET;

                    /////////////////////////////////////////////////////////

                    SETRANGE("Month Of Wage", IDMonth);
                    SETRANGE("Year of Wage", IDYear);
                    EMPL.SETFILTER("No.", '%1', "Employee No.");
                    IF EMPL.FIND('-') THEN
                        Zaposlenik := EMPL."First Name" + ' ' + EMPL."Last Name";
                    ZaposlenikJMBG := EMPL."Employee ID";
                    //ZaposlenikOpcina:=EMPL."Municipality Code";
                    ZaposlenikOpcina := EMPL."Municipality Code CIPS";
                    Brojac += 1;

                    BruttoAdd := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;
                    //*******************************************Additions****************************************//
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            BruttoAdd += WVE."Cost Amount (Brutto)";
                            NettoAdd += WVE."Cost Amount (Netto)";
                        UNTIL WVE.NEXT = 0;

                    WVET.SETFILTER("Document No.", "Wage Header No.");
                    WVET.SETFILTER("Employee No.", "Employee No.");
                    WVET.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVET.SETFILTER("Entry Type", '%1', WVET."Entry Type"::Tax);
                    IF WVET.FIND('-') THEN
                        REPEAT
                            TaxAdd := TaxAdd + WVET."Cost Amount (Netto)";
                            TaxBasisAdd += (WVET."Cost Amount (Netto)" / 0.1);
                        UNTIL WVET.NEXT = 0;


                    //*******************************************Additions****************************************//
                    GetAddTaxesPercentage(AddTaxPerc);
                    InvTaxPerc1 := 0;
                    TaxClass.RESET;
                    TaxClass.SETFILTER(Active, '%1', TRUE);
                    TaxClass.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass.Percentage / 100;
                    IndirectBrutto := "Indirect Wage Addition Amount" / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                    DirectBrutto := Brutto - IndirectBrutto + BruttoAdd;

                    //sati na bolovanju
                    EA.RESET;
                    SickHourPool := 0;
                    EA.SETFILTER("Employee No.", "Employee No.");
                    IF EA.FIND('-') THEN
                        StartDateD := DMY2DATE(1, IDMonth, IDYear);
                    EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));

                    EA.SETRANGE("From Date", StartDateD, EndDateD);
                    COA.SETRANGE("Sick Leave", TRUE);
                    COA.SETRANGE("No Report", FALSE);
                    IF COA.FIND('-') THEN
                        REPEAT
                            EA.SETRANGE("Cause of Absence Code", COA.Code);
                            EA.CALCSUMS(Quantity);
                            SickHourPool += EA.Quantity;
                        UNTIL COA.NEXT = 0;

                    //pojedinacni doprinosi
                    CPE.SETRANGE("Wage Header No.", "Wage Header No.");
                    // CPE.SETRANGE("Employee No.", "Wage Calculation"."Employee No.");
                    CPE.SETRANGE("Employee No.", "Employee No.");
                    //CPE.SETFILTER("Employee No.",'%1', "Wage Calculation"."Employee No.");

                    IF CPE.FIND('-') THEN// REPEAT
                        CASE CPE."Contribution Code" OF
                            'D-NEZAP-IZ':
                                TotalNezapIZ += CPE."Amount From Wage";
                            'D-PIO-IZ':
                                TotalPIO += CPE."Amount From Wage";
                            'D-ZDRAV-IZ':
                                TotalZOiz += CPE."Amount From Wage";
                            'D-NEZAP-NA':
                                TotalNezapU += CPE."Amount Over Wage";
                            'D-PIO-NA':
                                TotalPioNa += CPE."Amount Over Wage";
                            'D-ZDRAV-NA':
                                TotalZOna += CPE."Amount Over Wage";
                        END;
                    //  UNTIL CPE.NEXT=0;
                end;

                trigger OnPostDataItem()
                begin
                    sumPIOna := "sum zdr";
                end;

                trigger OnPreDataItem()
                begin
                    BEGIN
                        SETRANGE("Month Of Wage", IDMonth);
                        SETRANGE("Year of Wage", IDYear);
                    END;
                    SickHourPool := 0;
                    SETFILTER("Wage Calculation Type", '%1', 0);
                    SETFILTER("Contribution Category Code", '%1', 'BDPIOFBIH');
                end;
            }

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                // EMPL.GET;


                SETRANGE("Month Of Wage", IDMonth);
                SETRANGE("Year Of Wage", IDYear);
                IF IDMonth < 10 THEN
                    IDMonthText := '0' + FORMAT(IDMonth)
                ELSE
                    IDMonthText := FORMAT(IDMonth);
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
    begin
        BEGIN
            IDMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
            IDYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);

        END;
    end;

    trigger OnPostReport()
    begin

        //MESSAGE(FORMAT(sumPIOna));
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        PageNo := 0;
        Rbr := 0;
        Brojac := 0;

        //AddTax.DELETEALL;
        //"Wage Header".RESET;
        //"Wage Header".SETRANGE("Month Of Wage",IDMonth);
        //"Wage Header".SETRANGE("Year Of Wage",IDYear);
        //IF NOT "Wage Header".FIND('-') THEN ERROR('Ne postoji taj obračun plata');

        ORG.SETFILTER("Code", '%1', '802');
        IF ORG.FINDFIRST THEN BEGIN
            DepartmentName := ORG.Description;
            DepartmentID := ORG."ORG ID";
            DepartmentIC := ORG."Industrial Classification";
        END;

    end;

    var
        TaxBasisAdd: Decimal;
        TaxAdd: Decimal;
        BruttoAdd: Decimal;
        NettoAdd: Decimal;
        WVE: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        WVEC: Record "Wage Value Entry";
        t_ContrEmp2: Record "Contribution Per Employee";
        sumNZna: Decimal;
        sumZDRna: Decimal;
        sumPIOna: Decimal;
        sumNZ: Decimal;
        sumZDR: Decimal;
        sumPIO: Decimal;
        t_ContrEmp: Record "Contribution Per Employee";
        t_ContrEmp1: Record "Contribution Per Employee";
        TempCalc: Record "Wage Calculation";
        IDMonth: Integer;
        IDYear: Integer;
        IDMonthText: Text[10];
        Calc: Record "Wage Calculation";
        EmployeeFilter: Code[20];
        IsFirst: Boolean;
        Employee: Record "Employee";
        ATCatCon: Record "Contribution Category Conn.";
        ATCat: Record "Contribution Category";
        EmplOp: Code[10];
        EMPL: Record "Employee";
        TotalNezapIZ: Decimal;
        TotalPIO: Decimal;
        TotalZOiz: Decimal;
        TotalNezapU: Decimal;
        TotalTax: Decimal;
        opst: Code[10];
        TotalPioNa: Decimal;
        TotalZOna: Decimal;
        o: Integer;
        TaxClass: Record "Tax Class";
        Red: Record "Reduction";
        CompInfo: Record "Company Information";
        j: Integer;
        Post: Record "Post Code";
        StartDate: Text[30];
        jmbg: Code[14];
        mov: Integer;
        yov: Integer;
        iz: Decimal;
        name: Text[100];
        IDbroj: Code[1];
        TotalPages: Integer;
        Year: Text[30];
        m: Integer;
        Rbr: Integer;
        Mbroj: Code[10];
        CityPercent: Decimal;
        AF: Codeunit "Absence Fill";
        LineNo: Integer;
        EA: Record "Employee Absence";
        CodeArray: Code[10];
        TotalArray: Decimal;
        Found: Boolean;
        I: Integer;
        Description: Text[50];
        Quantity: Decimal;
        AbType: Record "Cause of Absence";
        Value: Decimal;
        HourWage: Decimal;
        //   ConfData: Record "Segmentation Data";
        Setup: Record "Wage Setup";
        CommissionAmont: Decimal;
        WageType: Record "Wage Type";
        TaxPercent: Decimal;
        //NKBC ESG: Record "Misc. Article Information (B)";
        ws: Record "Wage Setup";
        AddTaxPerc: Decimal;
        TotalHours: Decimal;
        TotalNeto: Decimal;
        TBasis: Decimal;
        RT: Record "Reduction types";
        RAmount: Text[30];
        MR: Decimal;
        COA: Record "Cause of Absence";
        COAValue: Decimal;
        EC: Record "Employment Contract";
        WH: Record "Wage Header";
        DoW: Text[150];
        LMHourValue: Decimal;
        SatnicaT: Decimal;
        WCForEC: Record "Wage Calculation";
        WCAdd: Record "Wage Calculation";
        WAAmount: Decimal;
        WAPerc: Decimal;
        TotalNonNetto: Decimal;
        MealHeder: Record "Meal Header";
        MealLine: Record "Meal Line";
        WorkDays: Integer;
        DimValue: Record "Dimension Value";
        ABCode: Code[10];
        WAJM: Text[10];
        WageTypeT: Text[30];
        ATPercentage: Decimal;
        PageNo: Integer;
        ATPercentage1: Decimal;
        From: Decimal;
        Over: Decimal;
        FromPerc: Decimal;
        OverPerc: Text[30];
        Lenght: Integer;
        EmplJmbg: Code[10];
        Month: Text[30];
        StartDateD: Date;
        EndDateD: Date;
        StartDateT: Text[2];
        EndDateT: Text[2];
        TodayT: Text[30];
        hours: Integer;
        bruto: Decimal;
        Txt008: Label '<Unazad godinu dana ne postoji mjesec za djelatnika %1>';
        Text001: Label 'Odgovornost lica koje je popunilo prijavu:';
        Text002: Label 'Izjavljujem da sam pregledao/la ovu prijavu i da su uneseni podaci,';
        Text003: Label 'po mom najboljem znanju i vjerovanju, vjerodostojni, tačni i potpuni.';
        Text004: Label 'Upoznat sam sa sankcijama propisanim Zakonom o poreznoj upravi FBIH i izjavljuje';
        Text005: Label 'da su svi podaci navedeni u ovoj prijavi tacni, potpuni i jasni te potvrđuje da su svi';
        Text006: Label 'porezi i doprinosi za ove zaposlenike ulaćeni.';
        Text007: Label '<U redu 11 u gornji odjeljak upisati vrstu prihoda, a u donji iznos uplaćenog poreza>';
        Text008: Label '<ili doprinosa na odgovarajuću vrstu prihoda. U slučaju da su vršene isplae i po drugim>';
        Text009: Label '<vidovima isplate (VI2, VI3 i VI4) to treba analitički prikazati u dodatnim listovima DL2, DL3 i DL4,>';
        Text010: Label '<a u sveukupne iznose uplaćenih poreza i doprinose koji se upisuje u red 11>';
        Text011: Label '<ubrojati i te iznose na odgovarajućim vrstama prihoda prema naredbi ministarstva finansija.>';
        Text003i: Label '<j>';
        Godina: Text[30];
        Brojac: Integer;
        Zaposlenik: Text[30];
        ZaposlenikJMBG: Text[30];
        ZaposlenikOpcina: Text[30];
        IndirectBrutto: Decimal;
        InvTaxPerc1: Decimal;
        DirectBrutto: Decimal;
        SickHourPool: Decimal;
        DopPio: Integer;
        CPE1: Record "Contribution Per Employee";
        Pom: Integer;
        CPE2: Record "Contribution Per Employee";
        suma1: Decimal;
        suma1NA: Decimal;
        CPE: Record "Contribution Per Employee";
        novaSuma: Decimal;
        "Altervative Address": Record "Alternative Address";
        Pom_Zdravstvo: Integer;
        wc2: Record "Wage Calculation";
        CPE3: Record "Contribution Per Employee";
        "sum zdr": Decimal;
        DepartmentName: Text[50];
        DepartmentID: Text[30];
        Department: Record "Department";
        DepartmentIC: Text;
        ORG: Record "ORG Dijelovi";

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

