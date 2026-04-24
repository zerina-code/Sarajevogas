xmlport 50001 "MIP 1023"
{
    Caption = 'MIP';
    DefaultNamespace = 'urn:PaketniUvozObrazaca_V1_0.xsd';
    Direction = Export;
    Encoding = UTF8;
    UseDefaultNamespace = true;

    schema
    {
        textelement("<paketniuvozobrasca>")
        {
            MaxOccurs = Once;
            TextType = BigText;
            XmlName = 'PaketniUvozObrazaca';
            Width = 45;

            tableelement(Table79; "Company Information")
            {
                MaxOccurs = Once;
                XmlName = 'PodaciOPoslodavcu';

                fieldelement(JIBPoslodavca; Table79."Registration No.") { }
                fieldelement(NazivPoslodavca; Table79.Name) { }

                textelement(BrojZahtjeva)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BrojZahtjeva := '1';
                    end;
                }

                textelement(DatumPodnosenja)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterGetRecord()
                begin
                    DatumPodnosenjaT := FORMAT(TODAY);
                    DatumPodnosenja := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);
                    DatumUpisa := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);

                    if EMPL.FIND('-') then
                        repeat
                            WC1.RESET;
                            WC1.SETRANGE("Employee No.", EMPL."No.");
                            WC1.SETRANGE("Month Of Wage", Month);
                            WC1.SETRANGE("Year of Wage", Year);
                            WC1.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                            WC1.SETRANGE("Wage Calculation Type", 0);
                            if WC1.FIND('-') then
                                counter += 1;
                        until EMPL.NEXT = 0;

                    BrojUposlenih := FORMAT(counter);

                    StartDateD := DMY2DATE(1, Month, Year);
                    EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));

                    JibJmb := Table79."Registration No.";
                    Naziv := Table79.Name;

                    PeriodOdT := FORMAT(StartDateD);
                    PeriodOd := '20' + COPYSTR(PeriodOdT, 7, 2) + '-' + COPYSTR(PeriodOdT, 4, 2) + '-' + COPYSTR(PeriodOdT, 1, 2);

                    PeriodDoT := FORMAT(EndDateD);
                    PeriodDo := '20' + COPYSTR(PeriodDoT, 7, 2) + '-' + COPYSTR(PeriodDoT, 4, 2) + '-' + COPYSTR(PeriodDoT, 1, 2);

                    SifraDjelatnosti := Table79."Industrial Classification";
                end;

                trigger OnPreXmlItem()
                begin
                    counter := 0;
                end;
            }

            textelement(Obrazac1023)
            {
                MaxOccurs = Once;

                textelement(Dio1)
                {
                    MaxOccurs = Once;
                    textelement(JibJmb) { }
                    textelement(Naziv) { }
                    textelement(DatumUpisa) { }
                    textelement(BrojUposlenih) { }
                    textelement(PeriodOd) { }
                    textelement(PeriodDo) { }
                    textelement(SifraDjelatnosti) { }
                }

                textelement(Dio2)
                {
                    MaxOccurs = Once;

                    tableelement(Table5200; Employee)
                    {
                        MaxOccurs = Unbounded;
                        MinOccurs = Once;
                        XmlName = 'PodaciOPrihodima';
                        // ispravljeno: canonical WHERE filter
                        SourceTableView = SORTING("No.") ORDER(Descending) WHERE("Contribution Category Code" = FILTER('FBIH' | 'FBIHRS'));

                        textelement(VrstaIsplate)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                WageCalc2.SETFILTER("Employee No.", WageCalc."Employee No.");
                                WageCalc2.SETFILTER("Month Of Wage", '%1', WageCalc."Month Of Wage");
                                WageCalc2.SETFILTER("Year of Wage", '%1', WageCalc."Year of Wage");
                                if WageCalc2.FINDFIRST then begin
                                    WageCalc2.CALCFIELDS(Use);
                                    if WageCalc2.Use <> 0 then begin
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '2');
                                        if PaymentTypeRecord.FINDFIRST then
                                            VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                    end else begin
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                        if PaymentTypeRecord.FINDFIRST then
                                            VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");

                                        POR80 := 0;
                                        EmpAbs.RESET;
                                        EmpAbs.SETFILTER("Employee No.", WageCalc."Employee No.");
                                        if EmpAbs.FIND('-') then begin
                                            StartDateD := DMY2DATE(1, Month, Year);
                                            EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                            EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                                            EmpAbs.SETRANGE("Cause of Absence Code", 'POR-80');
                                            EmpAbs.CALCSUMS(Quantity);
                                            POR80 += EmpAbs.Quantity;
                                            if ((POR80 < WageCalc."Hour Pool") and (POR80 <> 0)) then begin
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '3');
                                                if PaymentTypeRecord.FINDFIRST then
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            end;
                                        end;

                                        BOL := 0;
                                        EmpAbs1.RESET;
                                        EmpAbs1.SETFILTER("Employee No.", WageCalc."Employee No.");
                                        if EmpAbs1.FIND('-') then begin
                                            StartDateD := DMY2DATE(1, Month, Year);
                                            EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                            EmpAbs1.SETRANGE("From Date", StartDateD, EndDateD);
                                            EmpAbs1.SETRANGE("Cause of Absence Code", 'BOL-100');
                                            EmpAbs1.CALCSUMS(Quantity);
                                            BOL += EmpAbs1.Quantity;
                                            if BOL <> 0 then begin
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                                if PaymentTypeRecord.FINDFIRST then
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            end;
                                        end;

                                        BOL42 := 0;
                                        EmpAbs2.RESET;
                                        EmpAbs2.SETFILTER("Employee No.", WageCalc."Employee No.");
                                        if EmpAbs2.FIND('-') then begin
                                            StartDateD := DMY2DATE(1, Month, Year);
                                            EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                            EmpAbs2.SETRANGE("From Date", StartDateD, EndDateD);
                                            EmpAbs2.SETRANGE("Cause of Absence Code", 'BOL-42');
                                            EmpAbs2.CALCSUMS(Quantity);
                                            BOL42 := EmpAbs2.Quantity;
                                            if BOL42 <> 0 then begin
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                                                if PaymentTypeRecord.FINDFIRST then
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            end;
                                        end;

                                        POR70 := 0;
                                        EmpAbs3.RESET;
                                        EmpAbs3.SETFILTER("Employee No.", WageCalc."Employee No.");
                                        if EmpAbs3.FIND('-') then begin
                                            StartDateD := DMY2DATE(1, Month, Year);
                                            EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                            EmpAbs3.SETRANGE("From Date", StartDateD, EndDateD);
                                            EmpAbs3.SETRANGE("Cause of Absence Code", 'POR-70');
                                            EmpAbs3.CALCSUMS(Quantity);
                                            POR70 := EmpAbs3.Quantity;
                                            if POR70 <> 0 then begin
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '3');
                                                if PaymentTypeRecord.FINDFIRST then
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            end;
                                        end;

                                        BOL42100 := 0;
                                        EmpAbs4.RESET;
                                        EmpAbs4.SETFILTER("Employee No.", WageCalc."Employee No.");
                                        if EmpAbs4.FIND('-') then begin
                                            StartDateD := DMY2DATE(1, Month, Year);
                                            EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                            EmpAbs4.SETRANGE("From Date", StartDateD, EndDateD);
                                            EmpAbs4.SETRANGE("Cause of Absence Code", 'BOL-42-100');
                                            EmpAbs4.CALCSUMS(Quantity);
                                            BOL42100 := EmpAbs4.Quantity;
                                            if BOL42100 <> 0 then begin
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '5');
                                                if PaymentTypeRecord.FINDFIRST then
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            end;
                                        end;

                                        if VrstaIsplate = '0' then
                                            VrstaIsplate := '1';
                                    end;
                                end;
                            end;
                        }

                        textelement(Jmb) { }
                        textelement(ImePrezime) { MaxOccurs = Once; }
                        textelement(DatumIsplate) { }
                        textelement(RadniSati) { }

                        // >>> FIX: BEGIN..END u triggeru i Month/Year
                        textelement(RadniSatiBolovanje)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                SickHourPool := 0;

                                EA.SETFILTER("Employee No.", WageCalc."Employee No.");
                                if EA.FIND('-') then begin
                                    StartDateD := DMY2DATE(1, Month, Year);
                                    EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));

                                    EA.SETRANGE("From Date", StartDateD, EndDateD);
                                    COA.SETRANGE("Sick Leave", TRUE);
                                    COA.SETRANGE("No Report", FALSE);

                                    if COA.FIND('-') then
                                        repeat
                                            EA.SETRANGE("Cause of Absence Code", COA.Code);
                                            EA.CALCSUMS(Quantity);
                                            SickHourPool += EA.Quantity;
                                        until COA.NEXT = 0;
                                end;

                                RadniSatiBolovanje := FORMAT(SickHourPool, 0, '<Precision,2:2><Standard Format,2>');
                            end;
                        }
                        // <<< FIX

                        textelement(BrutoPlaca) { }
                        textelement(KoristiIDrugiOporeziviPrihodi) { }
                        textelement(UkupanPrihod) { }
                        textelement(IznosPIO) { }
                        textelement(IznosZO) { }
                        textelement(IznosNezaposlenost) { }
                        textelement(doprinosi) { XmlName = 'Doprinosi'; }
                        textelement(PrihodUmanjenZaDoprinose) { }
                        textelement(FaktorLicnogOdbitka) { }
                        textelement(IznosLicnogOdbitka) { }
                        textelement(OsnovicaPoreza) { }
                        textelement(IznosPoreza) { }
                        textelement(RadniSatiUT) { }
                        textelement(StepenUvecanja) { }
                        textelement(SifraRadnogMjestaUT) { }
                        textelement(DoprinosiPIOMIOzaUT) { }
                        textelement(BeneficiraniStaz) { }
                        textelement(OpcinaPrebivalista) { }

                        trigger OnAfterGetRecord()
                        begin
                            WC2.RESET;
                            WC2.SETRANGE("Month Of Wage", Month);
                            WC2.SETRANGE("Year of Wage", Year);
                            WC2.SETFILTER("Employee No.", Table5200."No.");
                            WC2.SETFILTER("Wage Calculation Type", '%1', 0);
                            if WC2.FINDFIRST then begin
                                ImePrezime := FORMAT(Table5200."First Name") + ' ' + FORMAT(Table5200."Last Name");
                                if Table5200."Contribution Category Code" = 'FBIHRS' then begin
                                    WageSetup.GET;
                                    OpcinaPrebivalista := WageSetup."RS Municipality Code";
                                end else
                                    OpcinaPrebivalista := Table5200."Municipality Code";

                                Jmb := Table5200."Employee ID";
                                StepenUvecanja := '0';
                            end else
                                currXMLport.SKIP;

                            WageCalc.SETRANGE("Month Of Wage", Month);
                            WageCalc.SETRANGE("Year of Wage", Year);
                            WageCalc.SETFILTER("Employee No.", Table5200."No.");
                            WageCalc.SETFILTER("Wage Calculation Type", '%1', 0);
                            WageCalc.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');

                            Bruto := 0;
                            Tax := 0;
                            TaxBasis := 0;
                            TaxDed := 0;
                            Net := 0;
                            IndirectBrutto := 0;
                            SickHourPool := 0;
                            TotalNezapIZ := 0;
                            TotalPIO := 0;
                            TotalZOiz := 0;
                            TotalNezapU := 0;
                            TotalPioNa := 0;
                            TotalZOna := 0;

                            EA.RESET;
                            EA.SETFILTER("Employee No.", Table5200."No.");
                            if EA.FIND('-') then begin
                                StartDateD := DMY2DATE(1, Month, Year);
                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                EA.SETRANGE("From Date", StartDateD, EndDateD);
                                COA.SETRANGE("Sick Leave", TRUE);
                                COA.SETRANGE("No Report", FALSE);
                                if COA.FIND('-') then
                                    repeat
                                        EA.SETRANGE("Cause of Absence Code", COA.Code);
                                        EA.CALCSUMS(Quantity);
                                        SickHourPool += EA.Quantity;
                                    until COA.NEXT = 0;
                            end;

                            RadniSatiBolovanje := FORMAT(SickHourPool, 0, '<Precision,2:2><Standard Format,2>');

                            GetAddTaxesPercentage(AddTaxPerc);
                            InvTaxPerc1 := 0;
                            TaxClass.RESET;
                            TaxClass.SETFILTER(Active, '%1', TRUE);
                            TaxClass.SETFILTER(Code, '%1', 'FBIH');
                            if TaxClass.FIND('-') then
                                InvTaxPerc1 := 1 - TaxClass.Percentage / 100;

                            if WageCalc.FINDFIRST then begin
                                WageCalc.CALCFIELDS(Use);
                                TaxDed := WageCalc."Tax Deductions";
                                COdbitak += WageCalc."Tax Deductions";

                                RadniSati := FORMAT(WageCalc."Individual Hour Pool" - WageCalc."Unpaid Absence Hours");

                                WageAdditionB.RESET;
                                WageAdditionT.RESET;
                                RadniSatiAdditionB := 0;
                                WageAdditionB.SETFILTER("Employee No.", '%1', WageCalc."Employee No.");
                                WageAdditionB.SETFILTER("Wage Header No.", '%1', WageCalc."Wage Header No.");
                                WageAdditionB.SETFILTER("No. Of Hours", '<>%1', 0);
                                WageAdditionB.SETFILTER(Meal, '%1', FALSE);
                                if WageAdditionB.FINDFIRST then
                                    repeat
                                        WageAdditionT.SETFILTER(Code, '%1', WageAdditionB."Wage Addition Type");
                                        if WageAdditionT.FINDFIRST then begin
                                            if WageAdditionT."Sick Leave MIP" then
                                                RadniSatiAdditionB += WageAdditionB."No. Of Hours";
                                        end;
                                    until WageAdditionB.NEXT = 0;

                                RadniSatiBolovanje := FORMAT(SickHourPool + RadniSatiAdditionB, 0, '<Precision,2:2><Standard Format,2>');

                                WageAddition.RESET;
                                WageAdditionT.RESET;
                                RadniSatiAddition := 0;
                                WageAddition.SETFILTER("Employee No.", '%1', WageCalc."Employee No.");
                                WageAddition.SETFILTER("Wage Header No.", '%1', WageCalc."Wage Header No.");
                                WageAddition.SETFILTER("No. Of Hours", '<>%1', 0);
                                WageAddition.SETFILTER(Meal, '%1', FALSE);
                                if WageAddition.FINDFIRST then
                                    repeat
                                        WageAdditionT.SETFILTER(Code, '%1', WageAddition."Wage Addition Type");
                                        if WageAdditionT.FINDFIRST then begin
                                            if WageAdditionT."Hour Pool MIP" then
                                                RadniSatiAddition += WageAddition."No. Of Hours";
                                        end;
                                    until WageAddition.NEXT = 0;

                                RadniSati := FORMAT(WageCalc."Individual Hour Pool" - WageCalc."Unpaid Absence Hours" + RadniSatiAddition);

                                repeat
                                    IndirectBrutto += WageCalc.Use; // /((1-AddTaxPerc/100)*InvTaxPerc1);
                                    DirectBrutto += WageCalc.Brutto - IndirectBrutto;
                                    TaxBasis += WageCalc."Tax Basis";
                                    Bruto += WageCalc.Brutto;
                                    Tax += WageCalc.Tax;
                                    Net += WageCalc."Net Wage";

                                    Bruttoadd := 0;
                                    NettoAdditions := 0;
                                    Taxadd := 0;
                                    TaxAddbasis := 0;

                                    // Additions
                                    WVE.SETFILTER("Document No.", WageCalc."Wage Header No.");
                                    WVE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                                    WVE.SETFILTER("Employee No.", WageCalc."Employee No.");
                                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                                    if WVE.FIND('-') then
                                        repeat
                                            Bruttoadd += WVE."Cost Amount (Brutto)";
                                            NettoAdditions += WVE."Cost Amount (Netto)";
                                        until WVE.NEXT = 0;

                                    WVET.SETFILTER("Document No.", WageCalc."Wage Header No.");
                                    WVET.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                                    WVET.SETFILTER("Employee No.", WageCalc."Employee No.");
                                    WVET.SETFILTER("Wage Calculation Type", '%1', 4);
                                    WVET.SETFILTER("Entry Type", '%1', WVE."Entry Type"::Tax);
                                    if WVET.FIND('-') then
                                        repeat
                                            Taxadd := WVET."Cost Amount (Actual)";
                                            TaxAddbasis := WVET."Cost Amount (Netto)" / 0.1;
                                        until WVET.NEXT = 0;

                                until WageCalc.NEXT = 0;

                                // post-aggregation
                                DatumIsplateT := FORMAT(WageCalc."Payment Date");
                                DatumIsplate := '20' + COPYSTR(DatumIsplateT, 7, 2) + '-' + COPYSTR(DatumIsplateT, 4, 2) + '-' + COPYSTR(DatumIsplateT, 1, 2);

                                RadniSati := decimale2(RadniSati);

                                DirectBrutto := Bruto - IndirectBrutto + Bruttoadd;
                                BrutoPlaca := FORMAT(ROUND(DirectBrutto, 0.01));
                                BrutoPlaca := decimale2(BrutoPlaca);

                                KoristiIDrugiOporeziviPrihodi := FORMAT(ROUND(IndirectBrutto, 0.01));
                                KoristiIDrugiOporeziviPrihodi := decimale2(KoristiIDrugiOporeziviPrihodi);

                                ZPrihod := ROUND(DirectBrutto, 0.01) + ROUND(IndirectBrutto, 0.01);
                                UkupanPrihod := FORMAT(ROUND(ZPrihod, 0.01), 0, '<Standard Format,2>');
                                UkupanPrihod := FORMAT(ROUND(ZPrihod, 0.01));
                                UkupanPrihod := decimale2(UkupanPrihod);
                                CPrihod += ZPrihod;

                                FaktorLicnogOdbitkaDecimal := TaxDed / 300;
                                FaktorLicnogOdbitka := FORMAT(ROUND(FaktorLicnogOdbitkaDecimal, 0.01), 0, '<Precision,3:3><Standard Format,2>');

                                ZOdbitak := 0;
                                ZOdbitak := TaxDed;
                                IznosLicnogOdbitka := FORMAT(ROUND(ZOdbitak, 0.01));
                                IznosLicnogOdbitka := decimale2(IznosLicnogOdbitka);

                                ConCatConn.RESET;
                                ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                                ConCatConn.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');
                                if ConCatConn.FINDFIRST then
                                    TotalPIO += ((WageCalc.Brutto + Bruttoadd) * ConCatConn.Percentage) / 100;

                                ConCatConn.RESET;
                                ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                                ConCatConn.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                                if ConCatConn.FINDFIRST then
                                    TotalZOiz += ((WageCalc.Brutto + Bruttoadd) * ConCatConn.Percentage) / 100;

                                ConCatConn.RESET;
                                ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                                ConCatConn.SETFILTER("Contribution Code", '%1', 'D-NEZAP-IZ');
                                if ConCatConn.FINDFIRST then
                                    TotalNezapIZ += ((WageCalc.Brutto + Bruttoadd) * ConCatConn.Percentage) / 100;

                                IznosPIO := FORMAT(ROUND(TotalPIO, 0.01));
                                IznosPIO := decimale2(IznosPIO);

                                IznosZO := FORMAT(ROUND(TotalZOiz, 0.01));
                                IznosZO := decimale2(IznosZO);

                                IznosNezaposlenost := FORMAT(ROUND(TotalNezapIZ, 0.01));
                                IznosNezaposlenost := decimale2(IznosNezaposlenost);

                                ZDoprinos := TotalPIO + TotalZOiz + TotalNezapIZ;
                                Doprinosi := FORMAT(ROUND(ZDoprinos, 0.01));
                                Doprinosi := decimale2(Doprinosi);
                                CDoprinos += ZDoprinos;

                                PrihodUmanjenZaDoprinose := FORMAT(ROUND(Net, 0.01) + ROUND(NettoAdditions, 0.01));
                                PrihodUmanjenZaDoprinose := decimale2(PrihodUmanjenZaDoprinose);

                                OsnovicaPoreza := FORMAT(ROUND(TaxBasis, 0.01) + ROUND(TaxAddbasis, 0.01));
                                OsnovicaPoreza := decimale2(OsnovicaPoreza);

                                IznosPoreza := FORMAT(ROUND(TaxAdd + Tax, 0.01));
                                IznosPoreza := decimale2(IznosPoreza);

                                // napomena: ostavljeno prema tvojoj verziji; ako želiš uključiti i osnovnu osnovicu: Porez1 += ROUND(TaxBasis*0.1,0.01) + ROUND(TaxAddbasis*0.1,0.01);
                                Porez1 += ROUND((TaxAdd + Tax), 0.01);

                                ConCatConn.RESET;
                                ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                                ConCatConn.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');
                                if ConCatConn.FINDFIRST then
                                    PIOOn += ((WageCalc.Brutto + Bruttoadd) * ConCatConn.Percentage) / 100;

                                ConCatConn.RESET;
                                ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                                ConCatConn.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-NA');
                                if ConCatConn.FINDFIRST then
                                    ZOOn += ((WageCalc.Brutto + Bruttoadd) * ConCatConn.Percentage) / 100;

                                ConCatConn.RESET;
                                ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                                ConCatConn.SETFILTER("Contribution Code", '%1', 'D-NEZAP-NA');
                                if ConCatConn.FINDFIRST then
                                    UnempOn += ((WageCalc.Brutto + Bruttoadd) * ConCatConn.Percentage) / 100;

                                RadniSatiUT := '0.00';
                                StepenUvecanja := '0';
                                SifraRadnogMjestaUT := '000000';
                                DoprinosiPIOMIOzaUT := '0.00';
                                BeneficiraniStaz := 'false';
                            end;
                        end;

                        trigger OnPreXmlItem()
                        begin
                            Table5200.SETCURRENTKEY("Last Name", "First Name");
                        end;
                    }
                }

                textelement(Dio3)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    textelement(PIO) { }
                    textelement(ZO) { }
                    textelement(OsiguranjeOdNezaposlenosti) { }
                    textelement(DodatniDoprinosiZO) { }
                    textelement(Prihod) { }
                    textelement(doprinosi1) { XmlName = 'Doprinosi'; }
                    textelement(LicniOdbici) { }
                    textelement(Porez) { }

                    trigger OnBeforePassVariable()
                    begin
                        PIO := FORMAT(ROUND(PIOOn, 0.01));
                        PIO := decimale2(PIO);

                        ZO := FORMAT(ROUND(ZOOn, 0.01));
                        ZO := decimale2(ZO);

                        OsiguranjeOdNezaposlenosti := FORMAT(ROUND(UnempOn, 0.01));
                        OsiguranjeOdNezaposlenosti := decimale2(OsiguranjeOdNezaposlenosti);

                        DodatniDoprinosiZO := '0.00';

                        Prihod := FORMAT(ROUND(CPrihod, 0.01));
                        Prihod := decimale2(Prihod);

                        Doprinosi1 := FORMAT(ROUND(CDoprinos, 0.01));
                        Doprinosi1 := decimale2(Doprinosi1);

                        LicniOdbici := FORMAT(ROUND(COdbitak, 0.01));
                        LicniOdbici := decimale2(LicniOdbici);

                        Porez := FORMAT(ROUND(Porez1, 0.01));
                        Porez := decimale2(Porez);
                    end;
                }

                tableelement("<company information2>"; "Company Information")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'Dio4IzjavaPoslodavca';

                    textelement(JibJmbPoslodavca) { }
                    textelement(DatumUnosa) { }
                    textelement(nazivposlodavca1) { XmlName = 'NazivPoslodavca'; }

                    trigger OnAfterGetRecord()
                    begin
                        JibJmbPoslodavca := Table79."Registration No.";
                        NazivPoslodavca1 := Table79.Name;
                        DatumUnosa := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);
                        Operacija := 'Prijava_od_strane_poreznog_obveznika';
                    end;
                }

                textelement(Dokument)
                {
                    MaxOccurs = Once;
                    textelement(Operacija) { }
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Mjesec; Month) { ApplicationArea = All; }
                field(Godina; Year) { ApplicationArea = All; }
            }
        }
        actions { }
    }

    trigger OnInitXmlPort()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if not WageAllowed then
            Error('Is not allowed');

        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
    end;

    trigger OnPreXmlPort()
    begin
        CompInfo.GET;
    end;

    var
        xwc: Record "XML Wage Calculation";
        EA: Record "Employee Absence";
        EMPL: Record Employee;
        TempCalc: Record "Tax Class";
        IDMonth: Integer;
        IDYear: Integer;
        IDMonthText: Text[10];
        TotalNezapIZ: Decimal;
        TotalPIO: Decimal;
        TotalZOiz: Decimal;
        TotalNezapU: Decimal;
        TotalTax: Decimal;
        TotalPioNa: Decimal;
        TotalZOna: Decimal;
        TaxClass: Record "Tax Class";
        CompInfo: Record "Company Information";
        AddTaxPerc: Decimal;
        COA: Record "Cause of Absence";
        StartDateD: Date;
        EndDateD: Date;
        StartDateT: Text[2];
        EndDateT: Text[2];
        Godina: Text[30];
        Brojac: Integer;
        IndirectBrutto: Decimal;
        InvTaxPerc1: Decimal;
        DirectBrutto: Decimal;
        SickHourPool: Decimal;
        CPE: Record "Contribution Per Employee";
        BrZapos: Integer;
        PeriodOdT: Text[30];
        PeriodDoT: Text[30];
        DatumIsplateT: Text[30];
        FaktorLicnogOdbitkaDecimal: Decimal;
        schemaLocation: Text[100];
        DatumPodnosenjaT: Text[30];
        counter: Integer;
        XMLWageCalc: Record "XML Wage Calculation";
        PIOOn: Decimal;
        ZOOn: Decimal;
        UnempOn: Decimal;
        ZDoprinos: Decimal;
        CDoprinos: Decimal;
        ZPrihod: Decimal;
        CPrihod: Decimal;
        COdbitak: Decimal;
        ZOdbitak: Decimal;
        Porez1: Decimal;
        Timestamp1: Date;
        Timestamp2: Date;
        ContributionPerEmployee: Record "Contribution Per Employee";
        ContributionPerEmployeeZdravstvo: Record "Contribution Per Employee";
        ContributionPerEmployeeNezaposlenost: Record "Contribution Per Employee";
        Month: Integer;
        Year: Integer;
        WC: Record "Wage Calculation";
        Tax: Decimal;
        TaxBasis: Decimal;
        Bruto: Decimal;
        TaxDed: Decimal;
        Net: Decimal;
        ConCatConn: Record "Contribution Category Conn.";
        WC2: Record "Wage Calculation";
        WC1: Record "Wage Calculation";
        WageCalc: Record "Wage Calculation";
        PaymentType: Integer;
        PaymentTypeRecord: Record "Payment Type";
        EmpAbs: Record "Employee Absence";
        POR80: Integer;
        BOL: Integer;
        EmpAbs1: Record "Employee Absence";
        BOL42: Integer;
        EmpAbs2: Record "Employee Absence";
        EmpAbs3: Record "Employee Absence";
        POR70: Integer;
        WageCalc2: Record "Wage Calculation";
        WageSetup: Record "Wage Setup";
        BOL42100: Integer;
        EmpAbs4: Record "Employee Absence";
        WageAdditionT: Record "Wage Addition Type";
        WageAddition: Record "Wage Addition";
        // FIX: usklađena imena varijabli da odgovaraju upotrebi u kodu
        RadniSatiAddition: Decimal;
        WageAdditionB: Record "Wage Addition";
        RadniSatiAdditionB: Decimal;
        WVE: Record "Wage Value Entry";
        WVEC: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        Bruttoadd: Decimal;
        NettoAdditions: Decimal;
        Taxadd: Decimal;
        TaxAddbasis: Decimal;
        CFO: Decimal;

    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    var
        AddTaxes: Record "Contribution";
        ATCCon: Record "Contribution Category Conn.";
    begin
        Percentage := 0;
        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        if AddTaxes.FIND('-') then
            repeat
                if ATCCon.GET('FBIH', AddTaxes.Code) then
                    Percentage += ATCCon.Percentage;
            until AddTaxes.NEXT = 0;
    end;

    procedure decimale2(opis: Text[30]) ukupno1: Text[30]
    var
        c1: Text[30];
        c2: Text[30];
        d: Integer;
    begin
        opis := DELCHR(opis, '=', '.');
        d := STRLEN(opis);

        if opis = '0' then
            ukupno1 := opis + '.00'
        else
            if STRPOS(opis, '.') = (d - 1) then begin
                c1 := COPYSTR(opis, 1, d - 1);
                c2 := COPYSTR(opis, d, 1);
                ukupno1 := c1 + '.' + c2 + '0';
            end else
                if STRPOS(opis, '.') = (d - 2) then begin
                    if STRPOS(opis, '.') <> 0 then begin
                        c1 := COPYSTR(opis, 1, d - 3);
                        c2 := COPYSTR(opis, d - 1, 2);
                        ukupno1 := c1 + '.' + c2;
                    end else
                        ukupno1 := opis + '.00'
                end else
                    if STRPOS(opis, ',') = (d - 1) then begin
                        c1 := COPYSTR(opis, 1, d - 2);
                        c2 := COPYSTR(opis, d, 1);
                        ukupno1 := c1 + '.' + c2 + '0';
                    end else
                        if STRPOS(opis, ',') = (d - 2) then begin
                            if STRPOS(opis, ',') <> 0 then begin
                                c1 := COPYSTR(opis, 1, d - 3);
                                c2 := COPYSTR(opis, d - 1, 2);
                                ukupno1 := c1 + '.' + c2;
                            end else
                                ukupno1 := opis + '.00';
                        end else
                            ukupno1 := opis + '.00';
    end;

    procedure decimale(description: Text[30]) ukupno: Text[30]
    var
        b1: Text[30];
        b2: Text[30];
    begin
        if STRLEN(description) = 1 then
            ukupno := description + '.000'
        else
            if STRLEN(description) = 3 then
                if STRPOS(description, ',') = 2 then begin
                    b1 := COPYSTR(description, 1, 1);
                    b2 := COPYSTR(description, 3, 1);
                    ukupno := b1 + '.' + b2 + '00';
                end else
                    if STRPOS(description, '.') = 2 then
                        ukupno := description + '00';
    end;
}
