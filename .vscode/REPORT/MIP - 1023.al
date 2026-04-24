report 50036 "MIP - 1023"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MIP - 1023.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {
            DataItemTableView = ORDER(Ascending);
            /*RequestFilterFields = "Year Of Wage", "Month Of Wage";*/
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
            column(DatumIsplate; "Payment Date")
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
                column(CFO; CFO)
                {
                }
                column(brutoTot; bruto)
                {
                }

                column(TaxDeduction; TaxDeduction)
                {
                }
                column(TaxTotal; TaxTotal)
                {
                }
                column(MjesecPlateWC; "Month Of Wage")
                {
                }
                column(GodinaPlateWC; "Year of Wage")
                {
                }

                column(TaxBasis; TaxBasis)
                {
                }
                column(Tax; Tax)
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
                column(BrojRadnihSati; "Hour Pool")
                {
                }
                column(Brojac; Brojac)
                {
                }
                column(RedniBroj; ReBr)
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
                column(VrstaIsplate; PaymentType)
                {

                }
                trigger OnPreDataItem()
                begin
                    // Sortiranje po prezimenu, zatim po imenu.
                    DataItem4.SetCurrentKey("Last Name", "First Name");
                    // Da dohvaća samo redovni rad, bez ugovora o djelu i slično!
                    DataItem4.SetRange("Wage Calculation Type", DataItem4."Wage Calculation Type"::Regular);
                end;

                trigger OnAfterGetRecord()
                var
                    WVE: Record "Wage Value Entry";
                    CPE: Record "Contribution Per Employee";
                    EA: Record "Employee Absence";
                    COA: Record "Cause of Absence";
                    EMPL: Record Employee;
                    PaymentTypeRecord: Record "Payment Type";
                    RadniSatiAdditionB: Decimal;
                    WageAdditionB: Record "Wage Addition";
                    RadniSatiAddition: Decimal;
                    WageAddition: Record "Wage Addition";
                    WageAdditionT: Record "Wage Addition Type";
                    TPE: Record "Tax Per Employee";
                    WC: Record "Wage Calculation";
                    WageSetup: Record "Wage Setup";
                    WageCalc: Record "Wage Calculation";
                    TaxClass: Record "Tax Class";
                    POR80: Integer;
                    BOL: Integer;
                    BOL42: Integer;
                    POR70: Integer;
                    InvTaxPerc1: Decimal;
                    TotalUse: Decimal;
                begin
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;
                    sumZDRna := 0;
                    sumPIOna := 0;
                    sumNZna := 0;
                    bruto := 0;
                    TaxDeduction := 0;
                    bruto := DataItem4.Brutto;
                    TaxDeduction := DataItem4."Tax Deductions";

                    // Dohvat doprinosa, IZ + NA
                    CPE.SETRANGE("Wage Header No.", "Wage Header No.");
                    CPE.SETRANGE("Employee No.", "Employee No.");

                    IF CPE.FIND('-') THEN
                        REPEAT
                            CASE CPE."Contribution Code" OF
                                'D-NEZAP-IZ', 'D-NEZAP-I2':
                                    sumNZ += CPE."Amount From Wage";
                                'D-PIO-IZ', 'D-PIO-IZ2':
                                    sumPIO += CPE."Amount From Wage";
                                'D-ZDRAV-IZ', 'D-ZDRAV-I2':
                                    sumZDR += CPE."Amount From Wage";
                                'D-NEZAP-NA', 'D-NEZAP-N2':
                                    sumNZna += CPE."Amount Over Wage";
                                'D-PIO-NA', 'D-PIO-NA2':
                                    sumPIOna += CPE."Amount Over Wage";
                                'D-ZDRAV-NA', 'D-ZDRAV-N2':
                                    sumZDRna += CPE."Amount Over Wage";
                            END;
                        UNTIL CPE.NEXT = 0;

                    DataItem4.SETRANGE("Month Of Wage", IDMonth);
                    DataItem4.SETRANGE("Year of Wage", IDYear);
                    EMPL.SETFILTER("No.", '%1', DataItem4."Employee No.");
                    IF EMPL.FIND('-') THEN BEGIN
                        Zaposlenik := EMPL."Last Name" + ' ' + EMPL."First Name";
                        ZaposlenikJMBG := EMPL."Employee ID";
                        IF EMPL."Contribution Category Code" = 'FBIHRS' THEN BEGIN
                            WageSetup.GET;
                            ZaposlenikOpcina := WageSetup."RS Municipality Code";
                        END
                        ELSE
                            ZaposlenikOpcina := EMPL."Municipality Code CIPS";
                    END;

                    Brojac := DataItem4."Employee No.";
                    ReBr += 1;

                    GetAddTaxesPercentage(AddTaxPerc);
                    InvTaxPerc1 := 0;
                    TaxClass.RESET;
                    TaxClass.SETFILTER(Active, '%1', TRUE);
                    TaxClass.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass.Percentage / 100;

                    IndirectBrutto := 0;
                    DirectBrutto := 0;
                    Tax := 0;
                    TaxBasis := 0;
                    CFO := 0;
                    TotalUse := 0;
                    Brutto := 0;

                    WC.SETRANGE("Month Of Wage", IDMonth);
                    WC.SETRANGE("Year of Wage", IDYear);
                    WC.SETFILTER("Employee No.", '%1', DataItem4."Employee No.");
                    IF WC.FIND('-') THEN
                        REPEAT
                            WC.CALCFIELDS(Use);
                            IndirectBrutto += WC.Use / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                            DirectBrutto += WC.Brutto - IndirectBrutto;
                            TaxBasis += WC."Tax Basis";
                            Tax += WC.Tax;
                            TotalUse += WC.Use;
                            Brutto += WC.Brutto;
                        UNTIL WC.NEXT = 0;

                    IndirectBruttoTotal := DataItem4."Indirect Wage Addition Amount" / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                    DirectBruttoTotal := DataItem4.Brutto - IndirectBrutto;
                    CFO := DataItem4."Contribution From Brutto";
                    TPE.SETFILTER("Wage Header No.", DataItem4."Wage Header No.");
                    TPE.SETFILTER("Wage Calculation No.", DataItem4."No.");
                    TPE.SETFILTER("Employee No.", '%1', DataItem4."Employee No.");

                    IF TPE.FIND('-') THEN
                        REPEAT
                            TaxTotal := TPE.Amount;
                        UNTIL TPE.NEXT = 0;

                    //*******************************************Additions****************************************//
                    // Koristićemo jedan rekord, WVE, pa samo restartovati filter po "Entry Type", u nastojanju da uklonimo suvišne varijable i dodatno ubrzamo izvještaj!

                    // Pronađi bruto u dodatnim primanjima, ako ga ima
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                    WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Additions);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            DirectBruttoTotal := DirectBruttoTotal + WVE."Cost Amount (Brutto)";
                            DirectBrutto := DirectBrutto + WVE."Cost Amount (Brutto)";
                            Brutto += WVE."Cost Amount (Brutto)";
                            bruto += WVE."Cost Amount (Brutto)";
                        UNTIL WVE.NEXT = 0;

                    // Dohvati porez u dodatnim primanjima, ako ga ima
                    WVE.SETFILTER("Entry Type", '%1', WVE."Entry Type"::Tax);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            Tax := Tax + WVE."Cost Amount (Netto)";
                            TaxBasis += (WVE."Cost Amount (Netto)" / 0.1);
                            TaxTotal += WVE."Cost Amount (Netto)";
                        UNTIL WVE.NEXT = 0;

                    // Dohvati doprinose u dodatnim primanjima, ako ih ima
                    WVE.SETFILTER("Entry Type", '%1', WVE."Entry Type"::Contribution);
                    WVE.SETFILTER("AT From", '%1', TRUE);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            CFO += WVE."Cost Amount (Netto)";
                            CASE WVE."Contribution Type" OF
                                'D-NEZAP-IZ', 'D-NEZAP-I2':
                                    sumNZ += WVE."Cost Amount (Netto)";
                                'D-PIO-IZ', 'D-PIO-IZ2':
                                    sumPIO += WVE."Cost Amount (Netto)";
                                'D-ZDRAV-IZ', 'D-ZDRAV-I2':
                                    sumZDR += WVE."Cost Amount (Netto)";
                                'D-NEZAP-NA', 'D-NEZAP-N2':
                                    sumNZna += WVE."Cost Amount (Netto)";
                                'D-PIO-NA', 'D-PIO-NA2':
                                    sumPIOna += WVE."Cost Amount (Netto)";
                                'D-ZDRAV-NA', 'D-ZDRAV-N2':
                                    sumZDRna += WVE."Cost Amount (Netto)";
                            END;
                        UNTIL WVE.NEXT = 0;

                    //*******************************************Additions****************************************//

                    //sati na bolovanju
                    SickHourPool := 0;
                    EA.SETFILTER("Employee No.", DataItem4."Employee No.");
                    EA.SETRANGE("From Date", StartDateD, EndDateD);
                    EA.SETRANGE("Cause of Absence Code", COA.Code);
                    IF EA.FIND('-') THEN BEGIN
                        COA.SETRANGE("Sick Leave", TRUE);
                        COA.SETRANGE("No Report", FALSE);
                        IF COA.FIND('-') THEN
                            REPEAT
                                EA.CALCSUMS(Quantity);
                                SickHourPool += EA.Quantity;
                            UNTIL COA.NEXT = 0;
                    END;

                    //vrsta isplate za koristi
                    WageCalc.RESET;
                    WageCalc.SETFILTER("Employee No.", DataItem4."Employee No.");
                    WageCalc.SETFILTER("Month Of Wage", '%1', DataItem4."Month Of Wage");
                    WageCalc.SETFILTER("Year of Wage", '%1', DataItem4."Year of Wage");
                    IF WageCalc.FINDFIRST THEN BEGIN
                        WageCalc.CALCFIELDS(Use);
                        IF WageCalc.Use <> 0 THEN BEGIN
                            PaymentTypeRecord.SETFILTER("Version Code", '%1', '2');
                            IF PaymentTypeRecord.FINDFIRST THEN
                                PaymentType := PaymentTypeRecord."Level Code";
                        END
                        ELSE
                            IF WageCalc.Use = 0 THEN BEGIN
                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                IF PaymentTypeRecord.FINDFIRST THEN
                                    PaymentType := PaymentTypeRecord."Level Code";

                                POR80 := 0;
                                EA.SETRANGE("Cause of Absence Code", 'POR-80');
                                IF EA.FIND('-') THEN BEGIN
                                    EA.CALCSUMS(Quantity);
                                    POR80 += EA.Quantity;
                                    IF ((POR80 < WageCalc."Hour Pool") AND (POR80 <> 0)) THEN BEGIN
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '9');
                                        IF PaymentTypeRecord.FINDFIRST THEN
                                            PaymentType := PaymentTypeRecord."Level Code";
                                    END;
                                END;

                                BOL := 0;
                                EA.SETRANGE("Cause of Absence Code", 'BOL-100');
                                IF EA.FIND('-') THEN BEGIN
                                    EA.CALCSUMS(Quantity);
                                    BOL += EA.Quantity;
                                    IF BOL <> 0 THEN BEGIN
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                                        IF PaymentTypeRecord.FINDFIRST THEN
                                            PaymentType := PaymentTypeRecord."Level Code";
                                    END;
                                END;

                                BOL42 := 0;
                                EA.SETRANGE("Cause of Absence Code", 'BOL-42');
                                IF EA.FIND('-') THEN BEGIN
                                    EA.CALCSUMS(Quantity);
                                    BOL42 := EA.Quantity;
                                    IF BOL42 <> 0 THEN BEGIN
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                                        IF PaymentTypeRecord.FINDFIRST THEN
                                            PaymentType := PaymentTypeRecord."Level Code";
                                    END;
                                END;

                                POR70 := 0;
                                EA.SETRANGE("Cause of Absence Code", 'POR-70');
                                IF EA.FIND('-') THEN BEGIN
                                    EA.CALCSUMS(Quantity);
                                    POR70 := EA.Quantity;
                                    IF POR70 <> 0 THEN BEGIN
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                        IF PaymentTypeRecord.FINDFIRST THEN
                                            PaymentType := PaymentTypeRecord."Level Code";
                                    END;
                                END;

                                IF PaymentType = 0 THEN PaymentType := 1;
                            END;
                    END;

                    RadniSati := 0;
                    WageAddition.RESET;
                    WageAdditionT.RESET;
                    RadniSatiAddition := 0;
                    WageAddition.SETFILTER("Employee No.", '%1', "Employee No.");
                    WageAddition.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    WageAddition.SETFILTER("No. Of Hours", '<>%1', 0);
                    WageAddition.SETFILTER(Meal, '%1', FALSE);
                    IF WageAddition.FINDFIRST THEN
                        REPEAT
                            WageAdditionT.SETFILTER(Code, '%1', WageAddition."Wage Addition Type");
                            IF WageAdditionT.FINDFIRST THEN BEGIN
                                IF WageAdditionT."Hour Pool MIP" THEN
                                    RadniSatiAddition += WageAddition."No. Of Hours";
                            END;

                        UNTIL WageAddition.NEXT = 0;
                    RadniSati := "Individual Hour Pool" - "Unpaid Absence Hours" + RadniSatiAddition;


                    WageAdditionB.RESET;
                    WageAdditionT.RESET;
                    RadniSatiAdditionB := 0;
                    WageAdditionB.SETFILTER("Employee No.", '%1', "Employee No.");
                    WageAdditionB.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    WageAdditionB.SETFILTER("No. Of Hours", '<>%1', 0);
                    WageAdditionB.SETFILTER(Meal, '%1', FALSE);
                    IF WageAdditionB.FINDFIRST THEN
                        REPEAT
                            WageAdditionT.SETFILTER(Code, '%1', WageAdditionB."Wage Addition Type");
                            IF WageAdditionT.FINDFIRST THEN BEGIN
                                IF WageAdditionT."Sick Leave MIP" THEN
                                    RadniSatiAdditionB += WageAdditionB."No. Of Hours";
                            END;
                        UNTIL WageAdditionB.NEXT = 0;
                    SickHourPool += RadniSatiAdditionB;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                DataItem1.SETRANGE("Month Of Wage", IDMonth);
                DataItem1.SETRANGE("Year Of Wage", IDYear);

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

        IDMonth := DATE2DMY(CALCDATE('-1M', WORKDATE), 2);
        IDYear := DATE2DMY(CALCDATE('-1M', WORKDATE), 3);
        StartDateD := DMY2DATE(1, IDMonth, IDYear);
        EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        Rebr := 0;
        Brojac := '';
    end;

    var
        ReBr: Integer;
        IDMonth: Integer;
        IDYear: Integer;
        IDMonthText: Text[10];
        CompInfo: Record "Company Information";
        AddTaxPerc: Decimal;
        Month: Text[30];
        StartDateD: Date;
        EndDateD: Date;
        RadniSati: Decimal;
        TaxTotal: Decimal;
        Tax: Decimal;
        TaxBasis: Decimal;
        IndirectBruttoTotal: Decimal;
        DirectBruttoTotal: Decimal;
        sumNZna: Decimal;
        sumZDRna: Decimal;
        sumPIOna: Decimal;
        sumNZ: Decimal;
        sumZDR: Decimal;
        sumPIO: Decimal;
        bruto: Decimal;
        CFO: Decimal;
        TaxDeduction: Decimal;
        Brutto: Decimal;
        Txt008: Label '<Unazad godinu dana ne postoji mjesec za djelatnika %1>';
        Text001: Label 'Odgovornost lica koje je popunilo prijavu:';
        Text002: Label 'Izjavljujem da sam pregledao/la ovu prijavu i da su uneseni podaci,';
        Text003: Label 'po mom najboljem znanju i vjerovanju, vjerodostojni, tačni i potpuni.';
        Text004: Label 'Upoznat sam sa sankcijama propisanim Zakonom o poreznoj upravi FBIH i izjavljuje';
        Text005: Label 'da su svi podaci navedeni u ovoj prijavi tacni, potpuni i jasni te potvrđuje da su svi';
        Text006: Label 'porezi i doprinosi za ove zaposlenike uplaćeni.';
        Text007: Label '<U redu 11 u gornji odjeljak upisati vrstu prihoda, a u donji iznos uplaćenog poreza>';
        Text008: Label '<ili doprinosa na odgovarajuću vrstu prihoda. U slučaju da su vršene isplae i po drugim>';
        Text009: Label '<vidovima isplate (VI2, VI3 i VI4) to treba analitički prikazati u dodatnim listovima DL2, DL3 i DL4,>';
        Text010: Label '<a u sveukupne iznose uplaćenih poreza i doprinose koji se upisuje u red 11>';
        Text011: Label '<ubrojati i te iznose na odgovarajućim vrstama prihoda prema naredbi ministarstva finansija.>';
        Text003i: Label '<j>';
        Brojac: Code[20];
        Zaposlenik: Text[30];
        ZaposlenikJMBG: Text[30];
        ZaposlenikOpcina: Text[30];
        IndirectBrutto: Decimal;
        DirectBrutto: Decimal;
        SickHourPool: Decimal;
        PaymentType: Integer;

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

