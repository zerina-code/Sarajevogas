xmlport 50002 "GIP 1022"
{
    Caption = 'MIP';
    DefaultNamespace = 'urn:PaketniUvozObrazaca_V1_0.xsd';
    Direction = Export;
    Encoding = UTF8;
    UseDefaultNamespace = true;
    UseRequestPage = false;


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
                fieldelement(JIBPoslodavca; Table79."Registration No.")
                {
                }
                fieldelement(NazivPoslodavca; Table79.Name)
                {
                }
                textelement(BrojZahtjeva)
                {
                }
                textelement(DatumPodnosenja)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterGetRecord()
                begin
                    DatumPodnosenjaT := FORMAT(TODAY);
                    DatumPodnosenja := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);

                    CLEAR(XMLWageCalculationTemp);
                    XMLWageCalculationTemp.DELETEALL(TRUE);
                    XMLWageCalc2.SETFILTER("Employee No.", '<>%1', '');
                    IF XMLWageCalc2.FINDFIRST THEN
                        REPEAT
                            XMLWageCalculationTemp.SETFILTER("No.", '%1', XMLWageCalc2."Employee No.");
                            IF NOT XMLWageCalculationTemp.FINDFIRST THEN BEGIN
                                XMLWageCalculationTemp.INIT;
                                XMLWageCalculationTemp."No." := XMLWageCalc2."Employee No.";
                                XMLWageCalculationTemp.INSERT;
                            END;
                        UNTIL XMLWageCalc2.NEXT = 0;

                    XMLWageCalculationTemp.RESET;
                    XMLWageCalculationTemp.SETFILTER("No.", '<>%1', '');
                    IF XMLWageCalculationTemp.FINDFIRST THEN
                        REPEAT
                            br += 1;
                        UNTIL XMLWageCalculationTemp.NEXT = 0;


                    BrojZahtjeva := (FORMAT(br));

                    //BrojZahtjeva:='1';
                end;

                trigger OnPreXmlItem()
                begin
                    br := 0;
                end;
            }
            tableelement(Table5200; Employee)
            {
                MaxOccurs = Unbounded;
                MinOccurs = Zero;
                XmlName = 'Obrazac1022';
                SourceTableView = WHERE("Contribution Category Code" = FILTER('FBIH|FBIHRS'));
                textelement(Dio1PodaciOPoslodavcuIPoreznomObvezniku)
                {
                    textelement(JIBJMBPoslodavca)
                    {
                    }
                    textelement(Naziv)
                    {
                    }
                    textelement(AdresaSjedista)
                    {
                    }
                    fieldelement(JMBZaposlenika; Table5200."Employee ID")
                    {
                    }
                    textelement(ImeIPrezime)
                    {
                        MaxOccurs = Once;
                    }
                    textelement(AdresaPrebivalista)
                    {
                    }
                    textelement(PoreznaGodina)
                    {
                    }
                }
                textelement(Dio2PodaciOPrihodimaDoprinosimaIPorezu)
                {
                    tableelement(Table50056; "XML Wage Calculation")
                    {
                        //ĐK LinkFields = "Employee No."=FIELD("No.");
                        //ĐK LinkTable = "Employee";
                        LinkTableForceInsert = false;
                        XmlName = 'PodaciOPrihodimaDoprinosimaIPorezu';
                        textelement(Mjesec)
                        {
                        }
                        textelement(IsplataZaMjesecIGodinu)
                        {
                        }
                        textelement(VrstaIsplate)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                //VrstaIsplate:='1';
                                //IF "<XML Wage Calculation>"."Indirect Wage Addition Amount" <> 0 THEN
                                //VrstaIsplate:=  Text001 ELSE VrstaIsplate :=Text000;




                                IF Table50056.Use <> 0 THEN BEGIN
                                    PaymentTypeRecord.SETFILTER("Version Code", '%1', '2');
                                    IF PaymentTypeRecord.FINDFIRST THEN
                                        VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                END

                                ELSE
                                    IF Table50056.Use = 0 THEN BEGIN



                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                        IF PaymentTypeRecord.FINDFIRST THEN
                                            VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");

                                        POR80 := 0;
                                        EmpAbs.RESET;
                                        EmpAbs.SETFILTER("Employee No.", Table50056."Employee No.");
                                        IF EmpAbs.FIND('-') THEN BEGIN
                                            StartDatedT := DMY2DATE(1, Table50056."Month Of Wage", IDYear);
                                            EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                                            EmpAbs.SETRANGE("From Date", StartDatedT, EndDatedT);
                                            EmpAbs.SETRANGE("Cause of Absence Code", 'POR-80');
                                            EmpAbs.CALCSUMS(Quantity);
                                            POR80 += EmpAbs.Quantity;
                                            IF ((POR80 < Table50056."Hour Pool") AND (POR80 <> 0)) THEN BEGIN
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '3');
                                                IF PaymentTypeRecord.FINDFIRST THEN
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            END;
                                        END;

                                        BOL := 0;
                                        EmpAbs1.RESET;
                                        EmpAbs1.SETFILTER("Employee No.", Table50056."Employee No.");
                                        IF EmpAbs1.FIND('-') THEN BEGIN
                                            StartDatedT := DMY2DATE(1, Table50056."Month Of Wage", IDYear);
                                            EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                                            EmpAbs1.SETRANGE("From Date", StartDatedT, EndDatedT);
                                            EmpAbs1.SETRANGE("Cause of Absence Code", 'BOL-100');
                                            EmpAbs1.CALCSUMS(Quantity);
                                            BOL += EmpAbs1.Quantity;
                                            IF BOL <> 0 THEN BEGIN
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                                IF PaymentTypeRecord.FINDFIRST THEN
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            END;
                                        END;


                                        BOL42 := 0;
                                        EmpAbs2.RESET;
                                        EmpAbs2.SETFILTER("Employee No.", Table50056."Employee No.");
                                        IF EmpAbs2.FIND('-') THEN BEGIN
                                            StartDatedT := DMY2DATE(1, Table50056."Month Of Wage", IDYear);
                                            EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                                            EmpAbs2.SETRANGE("From Date", StartDatedT, EndDatedT);
                                            EmpAbs2.SETRANGE("Cause of Absence Code", 'BOL-42');
                                            EmpAbs2.CALCSUMS(Quantity);
                                            BOL42 := EmpAbs2.Quantity;
                                            IF BOL42 <> 0 THEN BEGIN
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                                                IF PaymentTypeRecord.FINDFIRST THEN
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            END;
                                        END;


                                        POR70 := 0;
                                        EmpAbs3.RESET;
                                        EmpAbs3.SETFILTER("Employee No.", Table50056."Employee No.");
                                        IF EmpAbs3.FIND('-') THEN BEGIN
                                            StartDatedT := DMY2DATE(1, Table50056."Month Of Wage", IDYear);
                                            EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                                            EmpAbs3.SETRANGE("From Date", StartDatedT, EndDatedT);
                                            EmpAbs3.SETRANGE("Cause of Absence Code", 'POR-70');
                                            EmpAbs3.CALCSUMS(Quantity);
                                            POR70 := EmpAbs3.Quantity;
                                            IF POR70 <> 0 THEN BEGIN
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '3');
                                                IF PaymentTypeRecord.FINDFIRST THEN
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            END;
                                        END;

                                        BOL42100 := 0;
                                        EmpAbs4.RESET;
                                        EmpAbs4.SETFILTER("Employee No.", Table50056."Employee No.");
                                        IF EmpAbs4.FIND('-') THEN BEGIN
                                            StartDatedT := DMY2DATE(1, Table50056."Month Of Wage", IDYear);
                                            EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                                            EmpAbs4.SETRANGE("From Date", StartDatedT, EndDatedT);
                                            EmpAbs4.SETRANGE("Cause of Absence Code", 'BOL-42-100');
                                            EmpAbs4.CALCSUMS(Quantity);
                                            BOL42100 := EmpAbs4.Quantity;
                                            IF BOL42100 <> 0 THEN BEGIN
                                                PaymentTypeRecord.SETFILTER("Version Code", '%1', '5');
                                                IF PaymentTypeRecord.FINDFIRST THEN
                                                    VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                            END;
                                        END;
                                    END;
                                IF VrstaIsplate = '0' THEN VrstaIsplate := '1';

                            end;
                        }
                        textelement(IznosPrihodaUNovcu)
                        {
                        }
                        textelement(IznosPrihodaUStvarimaUslugama)
                        {
                        }
                        textelement(BrutoPlaca)
                        {
                        }
                        textelement(IznosZaPenzijskoInvalidskoOsiguranje)
                        {
                        }
                        textelement(IznosZaZdravstvenoOsiguranje)
                        {
                        }
                        textelement(IznosZaOsiguranjeOdNezaposlenosti)
                        {
                        }
                        textelement(UkupniDoprinosi)
                        {
                        }
                        textelement(PlacaBezDoprinosa)
                        {
                        }
                        textelement(FaktorLicnihOdbitakaPremaPoreznojKartici)
                        {
                        }
                        textelement(IznosLicnogOdbitka)
                        {
                        }
                        textelement(OsnovicaPoreza)
                        {
                        }
                        textelement(IznosUplacenogPoreza)
                        {
                        }
                        textelement(NetoPlaca)
                        {
                        }
                        textelement(DatumUplate)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            MjesecT := FORMAT(Table50056."Payment Date");
                            Mjesec := COPYSTR(MjesecT, 4, 2);
                            CASE Mjesec OF
                                '01':
                                    Mjesec := '1';
                                '02':
                                    Mjesec := '2';
                                '03':
                                    Mjesec := '3';
                                '04':
                                    Mjesec := '4';
                                '05':
                                    Mjesec := '5';
                                '06':
                                    Mjesec := '6';
                                '07':
                                    Mjesec := '7';
                                '08':
                                    Mjesec := '8';
                                '09':
                                    Mjesec := '9';
                            END;

                            GodinaT := FORMAT(Table50056."Month Of Wage") + '/' + FORMAT(Table50056."Year Of Wage");
                            IsplataZaMjesecIGodinu := GodinaT;
                            DatumIsplateT := FORMAT(Table50056."Payment Date");
                            DatumUplate := '20' + COPYSTR(DatumIsplateT, 7, 2) + '-' + COPYSTR(DatumIsplateT, 4, 2) + '-' + COPYSTR(DatumIsplateT, 1, 2);

                            GetAddTaxesPercentage(AddTaxPerc);
                            InvTaxPerc1 := 0;
                            TaxClass.RESET;
                            TaxClass.SETFILTER(Active, '%1', TRUE);
                            TaxClass.SETFILTER(Code, '%1', 'FBIH');
                            IF TaxClass.FIND('-') THEN
                                InvTaxPerc1 := 1 - TaxClass.Percentage / 100;
                            IndirectBrutto := Table50056.Use;///((1-AddTaxPerc/100)*InvTaxPerc1);

                            DirectBrutto := Table50056.Brutto - IndirectBrutto;

                            TotalDirectBrutto += DirectBrutto;

                            Bruto := ROUND(DirectBrutto + Table50056.Use, 0.01);  //ROUND("XML Wage Calculation".Brutto,0.01);
                            BrutoPlaca := FORMAT(Bruto);
                            BrutoPlaca := decimale2(BrutoPlaca);
                            TotalBruto += Bruto;

                            ZPrihod := DirectBrutto;
                            IznosPrihodaUNovcu := FORMAT(ROUND(ZPrihod, 0.01));
                            IznosPrihodaUNovcu := decimale2(IznosPrihodaUNovcu);

                            IznosPrihodaUStvarimaUslugama := FORMAT(ROUND(IndirectBrutto, 0.01));
                            IznosPrihodaUStvarimaUslugama := decimale2(IznosPrihodaUStvarimaUslugama);
                            TotalIndirectBrutto += IndirectBrutto;

                            IznosZaPenzijskoInvalidskoOsiguranje := FORMAT(ROUND(Table50056."PIO Amount From", 0.01));
                            IznosZaPenzijskoInvalidskoOsiguranje := decimale2(IznosZaPenzijskoInvalidskoOsiguranje);
                            PIOOn += Table50056."PIO Amount From";

                            IznosZaZdravstvenoOsiguranje := FORMAT(ROUND(Table50056."ZO Amount From", 0.01));
                            IznosZaZdravstvenoOsiguranje := decimale2(IznosZaZdravstvenoOsiguranje);
                            ZOOn += Table50056."ZO Amount From";

                            IznosZaOsiguranjeOdNezaposlenosti := FORMAT(ROUND(Table50056."Unemployment Amount From", 0.01));
                            IznosZaOsiguranjeOdNezaposlenosti := decimale2(IznosZaOsiguranjeOdNezaposlenosti);
                            UnempOn += Table50056."Unemployment Amount From";

                            UkupniDop := ROUND(Table50056.Brutto * 31 / 100, 0.01);
                            UkupniDoprinosi := decimale2(FORMAT(UkupniDop));
                            TotalUkupniDop += UkupniDop;

                            // PlacaBezDoprinosa:=FORMAT(ROUND("XML Wage Calculation"."Net Wage",0.01));
                            // PlacaBezDoprinosa:=decimale2(PlacaBezDoprinosa);
                            PlacaBezDoprinosa := decimale2(FORMAT(ROUND(Bruto - UkupniDop, 0.01)));


                            //FaktorLicnihOdbitakaPremaPoreznojKartici:=FORMAT("XML Wage Calculation"."Tax Deductions"/300);
                            FaktorLicnihOdbitakaPremaPoreznojKartici := FORMAT(ROUND((Table50056."Tax Deductions" / 300), 0.01), 0, '<Precision,3:3><Standard Format,2>');
                            // FaktorLicnihOdbitakaPremaPoreznojKartici:=decimale2(FaktorLicnihOdbitakaPremaPoreznojKartici);

                            IznosLicnogOdbitka := FORMAT(ROUND(Table50056."Tax Deductions", 0.01));
                            IznosLicnogOdbitka := decimale2(IznosLicnogOdbitka);
                            TotalTaxDeduction += Table50056."Tax Deductions";

                            //OsnovicaPoreza :=FORMAT(ROUND("XML Wage Calculation"."Tax Basis",0.01));
                            // OsnovicaPoreza := decimale2(OsnovicaPoreza);
                            OsnovicaPoreza := decimale2(FORMAT(ROUND(ZPrihod, 0.01) - UkupniDop - ROUND(Table50056."Tax Deductions")));
                            TotalTaxBasis += (Table50056.Tax / 0.1);

                            // IznosUplacenogPoreza := FORMAT(ROUND("XML Wage Calculation".Tax,0.01));
                            //  IznosUplacenogPoreza:=decimale2(IznosUplacenogPoreza);
                            UplPorez := ROUND(Table50056.Tax);
                            IznosUplacenogPoreza := decimale2(FORMAT(ROUND(UplPorez, 0.01)));
                            TotalNeto += (ROUND(Bruto - UkupniDop - UplPorez, 0.01));
                            TotalTax += Table50056.Tax;

                            //NetoPlaca:=decimale2(FORMAT(ROUND("XML Wage Calculation"."Final Net Wage",0.01)));
                            NetoPlaca := decimale2(FORMAT(ROUND(Bruto - UkupniDop - UplPorez, 0.01)));
                            //NetoPlaca:=decimale2(NetoPlaca);
                            TotalNetFinal += (ROUND(Bruto - UkupniDop - UplPorez, 0.01));
                        end;

                        trigger OnPreXmlItem()
                        begin
                            PIOOn := 0;
                            ZOOn := 0;
                            UnempOn := 0;
                            UkupniDop := 0;
                            TotalUkupniDop := 0;
                        end;
                    }
                    textelement(Ukupno)
                    {
                        textelement(uiznosprihodaunovcu)
                        {
                            XmlName = 'IznosPrihodaUNovcu';
                        }
                        textelement(uiznosprihodaustvarimauslugama)
                        {
                            XmlName = 'IznosPrihodaUStvarimaUslugama';
                        }
                        textelement(ubrutoplaca)
                        {
                            XmlName = 'BrutoPlaca';
                        }
                        textelement(uiznoszapenzijskoinvalidskoos)
                        {
                            XmlName = 'IznosZaPenzijskoInvalidskoOsiguranje';
                        }
                        textelement(uiznoszazdravstvenoosiguranje)
                        {
                            XmlName = 'IznosZaZdravstvenoOsiguranje';
                        }
                        textelement(uiznoszaosiguranjeodnezaposl)
                        {
                            XmlName = 'IznosZaOsiguranjeOdNezaposlenosti';
                        }
                        textelement(uukupnidoprinosi)
                        {
                            XmlName = 'UkupniDoprinosi';
                        }
                        textelement(uplacabezdoprinosa)
                        {
                            XmlName = 'PlacaBezDoprinosa';
                        }
                        textelement(uiznoslicnogodbitka)
                        {
                            XmlName = 'IznosLicnogOdbitka';
                        }
                        textelement(uosnovicaporeza)
                        {
                            XmlName = 'OsnovicaPoreza';
                        }
                        textelement(uiznosuplacenogporeza)
                        {
                            XmlName = 'IznosUplacenogPoreza';
                        }
                        textelement(unetoplaca)
                        {
                            XmlName = 'NetoPlaca';
                        }

                        trigger OnBeforePassVariable()
                        begin
                            UIznosPrihodaUNovcu := FORMAT(ROUND(TotalDirectBrutto, 0.01));
                            UIznosPrihodaUNovcu := decimale2(UIznosPrihodaUNovcu);

                            UIznosPrihodaUStvarimaUslugama := FORMAT(ROUND(TotalIndirectBrutto, 0.01));
                            UIznosPrihodaUStvarimaUslugama := decimale2(UIznosPrihodaUStvarimaUslugama);

                            UBrutoPlaca := FORMAT(ROUND(TotalBruto, 0.01));
                            UBrutoPlaca := decimale2(UBrutoPlaca);

                            UIznosZaPenzijskoInvalidskoOs := FORMAT(ROUND(PIOOn, 0.01));
                            UIznosZaPenzijskoInvalidskoOs := decimale2(UIznosZaPenzijskoInvalidskoOs);

                            UIznosZaZdravstvenoOsiguranje := FORMAT(ROUND(ZOOn, 0.01));
                            UIznosZaZdravstvenoOsiguranje := decimale2(UIznosZaZdravstvenoOsiguranje);

                            UIznosZaOsiguranjeOdNezaposl := FORMAT(ROUND(UnempOn, 0.01));
                            UIznosZaOsiguranjeOdNezaposl := decimale2(UIznosZaOsiguranjeOdNezaposl);

                            UUkupniDoprinosi := FORMAT(ROUND(TotalUkupniDop, 0.01));
                            UUkupniDoprinosi := decimale2(UUkupniDoprinosi);

                            UPlacaBezDoprinosa := FORMAT(ROUND(TotalBruto - TotalUkupniDop, 0.01));
                            UPlacaBezDoprinosa := decimale2(UPlacaBezDoprinosa);

                            UIznosLicnogOdbitka := FORMAT(ROUND(TotalTaxDeduction, 0.01));
                            UIznosLicnogOdbitka := decimale2(UIznosLicnogOdbitka);

                            UOsnovicaPoreza := FORMAT(ROUND(TotalTaxBasis, 0.01));
                            UOsnovicaPoreza := decimale2(UOsnovicaPoreza);

                            UIznosUplacenogPoreza := FORMAT(ROUND(TotalTax, 0.01));
                            UIznosUplacenogPoreza := decimale2(UIznosUplacenogPoreza);

                            UNetoPlaca := FORMAT(ROUND(TotalBruto - TotalUkupniDop - TotalTax, 0.01));
                            UNetoPlaca := decimale2(UNetoPlaca);
                        end;
                    }
                }
                tableelement("<company information2>"; "Company Information")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'Dio3IzjavaPoslodavcaIsplatioca';
                    textelement(jmbjmbposlodavca1)
                    {
                        XmlName = 'JIBJMBPoslodavca';
                    }
                    textelement(DatumUnosa)
                    {
                    }
                    textelement(nazivposlodavca1)
                    {
                        XmlName = 'NazivPoslodavca';
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //
                        JMBJMBPoslodavca1 := "<company information2>"."Registration No.";
                        NazivPoslodavca1 := "<company information2>".Name;
                        DatumUnosa := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);
                        Operacija := 'Novi';
                    end;
                }
                textelement(Dokument)
                {
                    textelement(Operacija)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin




                    CLEAR(Table50056);
                    Table50056.SETRANGE("Employee No.", Table5200."No.");
                    IF NOT Table50056.FIND('-') THEN currXMLport.SKIP;

                    JIBJMBPoslodavca := "<company information2>"."Registration No.";
                    Naziv := "<company information2>".Name;
                    AdresaSjedista := "<company information2>".Address + ' ' + Table5200."Address 2";

                    PoreznaGodina := '20' + COPYSTR(FORMAT(Table50056."Payment Date"), 7, 2);
                    ImeIPrezime := Table5200."First Name" + ' ' + Table5200."Last Name";
                    //AdresaPrebivalista:=Employee.Address+' '+Employee."Address 2";
                    AdresaPrebivalista := Table5200.Address;

                    SickHourPool := 0;
                    TotalNezapIZ := 0;
                    TotalPIO := 0;
                    TotalZOiz := 0;
                    TotalNezapU := 0;
                    TotalPioNa := 0;
                    TotalZOna := 0;

                    TotalBruto := 0;
                    TotalTax := 0;
                    TotalIndirectBrutto := 0;
                    TotalDirectBrutto := 0;
                    TotalTaxDeduction := 0;
                    TotalTaxBasis := 0;
                    TotalNeto := 0;
                    TotalNetFinal := 0;
                end;

                trigger OnPreXmlItem()
                begin
                    Table5200.SETCURRENTKEY("Last Name", "First Name");
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Godina; IDYear)
                {
                }
            }
        }

        actions
        {
        }
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

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        IDYear := DATE2DMY(TODAY, 3);
    end;

    trigger OnPreXmlPort()
    begin
        CompInfo.GET;
        //IDYear:=XMLWageCalc."Year Of Wage";
        //IDYear:=2012;
        BEGIN
            R_ExportGIP.SetYear(IDYear);
            //   R_ExportGIP.RUN;
            REPORT.RUNMODAL(50038, FALSE);
        END;
    end;

    var
        R_ExportGIP: Report "ExportGIP - 1022";
        XMLWageTable: Record "XML Wage Calculation";
        EA: Record "Employee Absence";
        EMPL: Record "Employee";
        TempCalc: Record "Tax Class";
        IDMonth: Integer;
        IDYear: Integer;
        IDMonthText: Text[10];
        TotalNezapIZ: Decimal;
        Bruto: Decimal;
        TotalPIO: Decimal;
        TotalZOiz: Decimal;
        TotalNezapU: Decimal;
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
        GodinaT: Text;
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
        Datum: Integer;
        MjesecT: Text[30];
        TotalIndirectNetto: Decimal;
        TotalTax: Decimal;
        TotalIndirectBrutto: Decimal;
        TotalDirectBrutto: Decimal;
        TotalTaxDeduction: Decimal;
        TotalTaxBasis: Decimal;
        TotalNeto: Decimal;
        TotalNetFinal: Decimal;
        TotalBruto: Decimal;
        UkupniDop: Decimal;
        TotalUkupniDop: Decimal;
        UplPorez: Decimal;
        TotalUse: Decimal;
        PaymentType: Integer;
        PaymentTypeRecord: Record "Where-Used Line";
        EmpAbs: Record "Employee Absence";
        POR80: Integer;
        BOL: Integer;
        EmpAbs1: Record "Employee Absence";
        BOL42: Integer;
        EmpAbs2: Record "Employee Absence";
        EmpAbs3: Record "Employee Absence";
        POR70: Integer;
        StartDatedT: Date;
        EndDatedT: Date;
        BOL42100: Integer;
        EmpAbs4: Record "Employee Absence";
        XMLWageCalculationTemp: Record "XML Wage Calculation" temporary;
        XMLWageCalc2: Record "XML Wage Calculation";
        br: Integer;

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

    procedure decimale2(opis: Text[30]) ukupno1: Text[30]
    var
        c1: Text[30];
        c2: Text[30];
        d: Integer;
    begin
        opis := DELCHR(opis, '=', '.');
        d := STRLEN(opis);

        IF opis = '0' THEN
            ukupno1 := opis + '.00'
        ELSE
            IF STRPOS(opis, '.') = (d - 1) THEN BEGIN
                c1 := COPYSTR(opis, 1, d - 1);
                c2 := COPYSTR(opis, d, 1);
                ukupno1 := c1 + '.' + c2 + '0';
            END
            ELSE
                IF STRPOS(opis, '.') = (d - 2) THEN BEGIN
                    IF STRPOS(opis, '.') <> 0 THEN BEGIN
                        c1 := COPYSTR(opis, 1, d - 3);
                        c2 := COPYSTR(opis, d - 1, 2);
                        ukupno1 := c1 + '.' + c2;
                    END
                    ELSE
                        ukupno1 := opis + '.00'
                END
                ELSE
                    IF STRPOS(opis, ',') = (d - 1) THEN BEGIN
                        c1 := COPYSTR(opis, 1, d - 2);
                        c2 := COPYSTR(opis, d, 1);
                        ukupno1 := c1 + '.' + c2 + '0';
                    END
                    ELSE
                        IF STRPOS(opis, ',') = (d - 2) THEN BEGIN
                            IF STRPOS(opis, ',') <> 0 THEN BEGIN
                                c1 := COPYSTR(opis, 1, d - 3);
                                c2 := COPYSTR(opis, d - 1, 2);
                                ukupno1 := c1 + '.' + c2;
                            END
                            ELSE
                                ukupno1 := opis + '.00';
                        END
                        ELSE
                            ukupno1 := opis + '.00';
    end;

    procedure decimale(description: Text[30]) ukupno: Text[30]
    var
        b1: Text[30];
        b2: Text[30];
    begin
        IF STRLEN(description) = 1 THEN
            ukupno := description + '.000'
        ELSE
            IF STRLEN(description) = 3 THEN
                IF STRPOS(description, ',') = 2 THEN BEGIN
                    b1 := COPYSTR(description, 1, 1);
                    b2 := COPYSTR(description, 3, 1);
                    ukupno := b1 + '.' + b2 + '00';
                END
                ELSE
                    IF STRPOS(description, '.') = 2 THEN BEGIN
                        ukupno := description + '00';
                    END;
    end;
}

