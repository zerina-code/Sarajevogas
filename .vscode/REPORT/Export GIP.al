report 50038 "ExportGIP - 1022"
{
    PreviewMode = PrintLayout;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Employee)
        {
            RequestFilterFields = "No.";
            column(EmpNo; "No.")
            {
            }
            column(KopanijaNaziv; Comp.Name)
            {
            }
            column(KompanijaAdresa; Comp.Address)
            {
            }
            column(JIB; Comp."Registration No.")
            {
            }
            column(ZaposlenikIme; "First Name")
            {
            }
            column(ZaposlenikPrezime; "Last Name")
            {
            }
            column(ZaposlenikAdresa1; Address)
            {
            }
            column(ZaposlenikAdresa2; "Address 2")
            {
            }
            column(JMB; "Employee ID")
            {
            }
            column(IDYear; IDYear)
            {
            }
            dataitem(DataItem29; "Wage Calculation")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Payment Date")
                                    ORDER(Ascending);
                column(BrojRadnika; "Employee No.")
                {
                }
                column(WageNo; "No.")
                {
                }
                column(MjesecObracuna; Mjesec)
                {
                }
                column(GodinaObracuna; IDMonthText)
                {
                    AutoCalcField = true;
                }
                column(DirectBruto; TotalDirectBrutto)
                {
                }
                column(IndirectBruto; TotalIndirectBrutto)
                {
                }
                column(Bruto; TotalBruto)
                {
                }
                column(Neto; "Net Wage")
                {
                }
                column(TaxDeduction; TotalTaxDeduction)
                {
                }
                column(TaxBasis; TotalTaxBasis)
                {
                }
                column(Ttax; Tax)
                {
                }
                column(NetFinal; NetFinal)
                {
                }
                column(PayDate; "Payment Date")
                {
                }
                column(TotalIndirectNeto; TotalIndirectNetto)
                {
                }
                column(GodinaPorezna; "Year of Wage")
                {
                }
                column(GodinaObracuna1; "Year Of Calculation")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalPIO := 0;
                    TotalZOiz := 0;
                    TotalNezapIZ := 0;
                    TotalNezapU := 0;
                    TotalPioNa := 0;
                    TotalZOna := 0;
                    EMPL.SETFILTER("No.", '%1', "Employee No.");
                    IF EMPL.FIND('-') THEN
                        Zaposlenik := EMPL."First Name" + ' ' + EMPL."Last Name";
                    ZaposlenikJMBG := EMPL."Employee ID";
                    ZaposlenikOpcina := EMPL."Municipality Code";
                    Brojac += 1;

                    GetAddTaxesPercentage(AddTaxPerc);
                    InvTaxPerc1 := 0;
                    TaxClass1.RESET;
                    TaxClass1.SETFILTER(Active, '%1', TRUE);
                    TaxClass1.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass1.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass1.Percentage / 100;
                    IndirectBrutto := Use;///((1-AddTaxPerc/100)*InvTaxPerc1);
                    DirectBrutto := Brutto - IndirectBrutto;
                    IF IDMonthText <> '' THEN
                        IDMonthText += ' / ';

                    IDMonthText := FORMAT("Month Of Wage") + '/' + FORMAT("Year of Wage");

                    /*
                    //pojedinacni doprinosi
                    //CPE.SETRANGE("Wage Header No.","Wage Header"."No.");
                    CPE.SETRANGE("Wage Calc No.", DataItem29."No.");
                    CPE.SETRANGE("Employee No.", DataItem29."Employee No.");
                    
                          IF CPE.FIND('-') THEN REPEAT
                            CASE CPE."Contribution Code" OF
                              'D-NEZAP-IZ': TotalNezapIZ += CPE."Amount From Wage";
                              'D-PIO-IZ': TotalPIO += CPE."Amount From Wage";
                              'D-ZDRAV-IZ': TotalZOiz += CPE."Amount From Wage";
                              'D-NEZAP-NA': TotalNezapU += CPE."Amount Over Wage";
                              'D-PIO-NA': TotalPioNa += CPE."Amount Over Wage";
                              'D-ZDRAV-NA': TotalZOna += CPE."Amount Over Wage";
                            END;
                          UNTIL CPE.NEXT=0;
                    
                    */
                    NetFinal := (DataItem29."Net Wage" - DataItem29.Tax);
                    TotalBruto := DataItem29.Brutto;
                    TotalIndirectNetto := DataItem29."Indirect Wage Addition Amount";
                    TotalTax := DataItem29.Tax;
                    TotalIndirectBrutto := IndirectBrutto;
                    TotalDirectBrutto := DirectBrutto;
                    TotalTaxDeduction := DataItem29."Tax Deductions";
                    TotalTaxBasis := DataItem29."Tax Basis";
                    TotalNeto := DataItem29."Net Wage";
                    TotalNetFinal := NetFinal;
                    Mjesec := COPYSTR(FORMAT(DataItem29."Payment Date"), 4, 2);

                    ws.GET;
                    PersonalDedFact := DataItem29."Tax Deductions" / 300;

                    IF DirectBrutto <> 0 THEN BEGIN
                        WITH XmlWageCalc DO BEGIN
                            INIT;
                            //na
                            IndirectBrutto := 0;
                            XmlWageCalc.SETFILTER("Month Of Wage", '%1', DataItem29."Month Of Wage");
                            XmlWageCalc.SETFILTER("Year Of Wage", '%1', DataItem29."Year of Wage");
                            XmlWageCalc.SETFILTER("Employee No.", '%1', DataItem29."Employee No.");
                            IF XmlWageCalc.FINDFIRST THEN BEGIN
                                DataItem29.CALCFIELDS(Use);
                                Brutto += DataItem29.Brutto;
                                "Net Wage" += DataItem29."Net Wage";
                                "Tax Basis" += DataItem29."Tax Basis";
                                Tax += DataItem29.Tax;
                                "Tax Deductions" += DataItem29."Tax Deductions";
                                "Final Net Wage" += (DataItem29."Net Wage" - DataItem29.Tax);
                                // IndirectBrutto := DataItem29.Use;
                                "Indirect Wage Addition Amount" += DataItem29.Use;
                                "Hour Pool" := DataItem29."Hour Pool";
                                DataItem29.CALCFIELDS(Use);
                                Use := DataItem29.Use;
                                //pojedinacni doprinosi
                                CPE.SETRANGE("Wage Header No.", DataItem29."Wage Header No.");
                                // CPE.SETRANGE("Wage Calc No.", DataItem29."No.");
                                CPE.SETRANGE("Employee No.", DataItem29."Employee No.");
                                CPE.SETFILTER("Amount From Wage", '>%1', 0);
                                IF CPE.FIND('-') THEN
                                    REPEAT
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
                                    UNTIL CPE.NEXT = 0;

                                "PIO Amount From" += TotalPIO;
                                "ZO Amount From" += TotalZOiz;
                                "Unemployment Amount From" += TotalNezapIZ;
                                "PIO Amount On" += TotalPioNa;
                                "ZO Amount On" += TotalZOna;
                                "Unemployment Amount On" += TotalNezapU;
                                "Personal Deduction Factor" += PersonalDedFact;
                                MODIFY;

                            END
                            //na
                            ELSE BEGIN
                                DataItem29.CALCFIELDS(Use);
                                "No." := DataItem29."No.";
                                "Employee No." := DataItem29."Employee No.";
                                "Month Of Calculation" := DataItem29."Month Of Calculation";
                                "Year Of Calculation" := DataItem29."Year Of Calculation";
                                "Month Of Wage" := DataItem29."Month Of Wage";
                                "Year Of Wage" := DataItem29."Year of Wage";
                                //"Base Tax Deduction":=DataItem29."Tax Basis";
                                "Tax Deductions" := DataItem29."Tax Deductions";   //"Personal Deduction Amount"
                                Brutto := DataItem29.Brutto;
                                "Net Wage" := DataItem29."Net Wage";
                                "Tax Basis" := DataItem29."Tax Basis";
                                Tax := DataItem29.Tax;
                                "Final Net Wage" := (DataItem29."Net Wage" - DataItem29.Tax);
                                "Indirect Wage Addition Amount" := DataItem29.Use;
                                "Payment Date" := DataItem29."Payment Date";

                                "Hour Pool" := DataItem29."Hour Pool";
                                DataItem29.CALCFIELDS(Use);
                                Use := DataItem29.Use;
                                //pojedinacni doprinosi
                                CPE.SETRANGE("Wage Header No.", DataItem29."Wage Header No.");
                                //CPE.SETRANGE("Wage Calc No.", DataItem29."No.");
                                CPE.SETRANGE("Employee No.", DataItem29."Employee No.");
                                CPE.SETFILTER("Amount From Wage", '>%1', 0);
                                IF CPE.FIND('-') THEN
                                    REPEAT
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
                                    UNTIL CPE.NEXT = 0;

                                "PIO Amount From" := TotalPIO;
                                "ZO Amount From" := TotalZOiz;
                                "Unemployment Amount From" := TotalNezapIZ;
                                "PIO Amount On" := TotalPioNa;
                                "ZO Amount On" := TotalZOna;
                                "Unemployment Amount On" := TotalNezapU;
                                "Personal Deduction Factor" := PersonalDedFact;
                                "Sick Hour Pool" := SickHourPool;

                                INSERT(TRUE);

                            END;
                        END;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    IndirectBrutto := 0;
                    IndirectNetto := 0;
                    DirectBrutto := 0;
                    IndirectBrutto := 0;
                    Neto := 0;
                    NetFinal := 0;
                    IDMonthText := '';

                    SickHourPool := 0;
                    TotalNezapIZ := 0;
                    TotalPIO := 0;
                    TotalZOiz := 0;
                    TotalNezapU := 0;
                    TotalPioNa := 0;
                    TotalZOna := 0;

                    EVALUATE(Godina, FORMAT(IDYear));
                    StartDate := '1.1.' + Godina;
                    EndDate := '31.12.' + Godina;
                    EVALUATE(StartDated, StartDate);
                    EVALUATE(EndDated, EndDate);

                    //MESSAGE((FORMAT(StartDated))+','+FORMAT(EndDated));
                    //   SETFILTER("Payment Date",'%1..2', StartDated,EndDated);
                    DataItem29.SETCURRENTKEY("No.", "Payment Date");
                    DataItem29.SETRANGE("Payment Date", StartDated, EndDated);
                    DataItem29.SETFILTER("Contribution Category Code", '%1|%2', 'FBIHRS', 'FBIH');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalBruto := 0;
                TotalIndirectNetto := 0;
                TotalTax := 0;
                TotalIndirectBrutto := 0;
                TotalDirectBrutto := 0;
                TotalTaxDeduction := 0;
                TotalTaxBasis := 0;
                TotalNeto := 0;
                TotalNetFinal := 0;
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

    trigger OnInitReport()
    begin
        IDYear := DATE2DMY(CALCDATE('-2M', WORKDATE), 3);
        //IDDay:=DATE2DMY(CALCDATE('-2M',WORKDATE),1);
    end;

    trigger OnPostReport()
    begin
        /*  IF Comp.FIND('-') THEN
          IdentNo:=Comp."Registration No.";

          folder:='C:\PLATE_NAV\'+IdentNo+'_'+FORMAT(IDYear) +'.xml';  //mjesec i godina za koji se podnosi obrazac!!

          IF EXISTS(folder) THEN
            ERASE (folder);

          TestFile.CREATE(folder);
          TestFile.CREATEOUTSTREAM(TestStream);
          XMLPORT.EXPORT(50002,TestStream);
          TestFile.CLOSE;*/

    end;

    trigger OnPreReport()
    begin
        Comp.GET;
        Brojac := 0;

        XmlWageCalc.DELETEALL;
    end;

    var
        Comp: Record "Company Information";
        WageCalc: Record "Wage Calculation";
        Year: Text[30];
        JMB: Text[30];
        IDYear: Integer;
        Bruto: Decimal;
        TTax: Decimal;
        TaxDeduction: Decimal;
        TaxBasis: Decimal;
        IndirectNetto: Decimal;
        IndirectBrutto: Decimal;
        DirectBrutto: Decimal;
        AddTaxPerc: Decimal;
        AddTaxPerEmp: Record "Tax Per Employee";
        Neto: Decimal;
        NetFinal: Decimal;
        PayDate: Date;
        TotalBruto: Decimal;
        TotalIndirectNetto: Decimal;
        TotalTax: Decimal;
        TotalIndirectBrutto: Decimal;
        TotalDirectBrutto: Decimal;
        TotalTaxDeduction: Decimal;
        TotalTaxBasis: Decimal;
        TotalNeto: Decimal;
        TotalNetFinal: Decimal;
        PayMonth: Integer;
        IDMonthText: Text[30];
        Txt008: Label 'There is no work day in last 12 months for employee %1';
        WH: Record "Wage Header";
        InvTaxPerc1: Decimal;
        TaxClass1: Record "Tax Class";
        Mjesec: Text[10];
        Godina: Text;
        StartDate: Text;
        EndDate: Text;
        StartDated: Date;
        EndDated: Date;
        GodinaINT: Integer;
        Brojac: Integer;
        Zaposlenik: Text[30];
        ZaposlenikJMBG: Text[30];
        ZaposlenikOpcina: Text[30];
        SickHourPool: Decimal;
        CPE: Record "Contribution Per Employee";
        XmlWageCalc: Record "XML Wage Calculation";
        folder: Text[250];
        TestFile: File;
        TestStream: OutStream;
        IdentNo: Text[30];
        PersonalDedFact: Decimal;
        TotalNezapIZ: Decimal;
        TotalPIO: Decimal;
        TotalZOiz: Decimal;
        TotalNezapU: Decimal;
        TotalPioNa: Decimal;
        TotalZOna: Decimal;
        EMPL: Record Employee;
        ws: Record "Wage Setup";

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

    procedure SetYear(var Year: Integer) IDYear: Integer
    begin
    end;
}

