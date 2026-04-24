report 50033 "GIP-1022 New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GIP-1022 New.rdl';

    dataset
    {
        dataitem(DataItem1; "Employee")
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
            column(City; Comp.City)
            {
            }
            column(PostCode; Comp."Post Code")
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
            column(AddressCIPS; "Address CIPS")
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
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(sumNZ; sumNZ)
                {
                }
                column(sumZDR; sumZDR)
                {
                }
                column(sumPIO; sumPIO)
                {
                }
                column(BrojRadnika; "Employee No.")
                {
                }
                column(WageNo; "No.")
                {
                }
                column(Use; Use)
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
                column(TotalIndirectBruto; TotalIndirectBrutto)
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
                column(Ttax; Tax + TaxAdd)
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
                column(Brutto; DirectBrutto)
                {
                }
                column(IndirectBrutto; IndirectBrutto)
                {
                }
                column(TotalBruttoSum; TotalBruttoSum + BruttoAddTotal)
                {
                }
                column(sumPIOTotal; sumPIOTotal)
                {
                }
                column(sumZDRAVTotal; sumZDRAV)
                {
                }
                column(sumNEZAPTotal; sumNEZAPTotal)
                {
                }
                column(ContributionTotal; ContributionTotal)
                {
                }
                column(Tax; TaxD)
                {
                }
                column(TaxB; TaxB)
                {
                }
                column(TaxT; TaxT)
                {
                }
                column(TaxTotal; TaxTotal)
                {
                }
                column(TotalNetFinal; TotalNetFinal)
                {
                }
                column(UseTotal; UseTotal)
                {
                }
                column(UsePerWage; UsePerWage)
                {
                }
                column(PaymentType; PaymentType)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Doprinosi za pio i zdravstvo sd01 start
                    TotalBruto := 0;
                    TotalDB := 0;
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;
                    IndirectBrutto := 0;
                    IndirectNetto := 0;
                    DirectBrutto := 0;
                    IndirectBrutto := 0;
                    Neto := 0;
                    NetFinal := 0;
                    TotalNeto := 0;
                    TotalIndirectNetto := 0;
                    TotalTax := 0;
                    TotalIndirectBrutto := 0;
                    TotalDirectBrutto := 0;
                    TotalTaxDeduction := 0;
                    TotalTaxBasis := 0;
                    TotalNetFinal := 0;
                    TaxB := 0;
                    TaxT := 0;
                    TaxD := 0;
                    TotalBruttoSum := 0;
                    UsePerWage := 0;
                    UseTotal := 0;
                    sumNEZAPTotal := 0;
                    sumPIOTotal := 0;
                    sumZDRAV := 0;
                    BruttoAddTotal := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;
                    t_ContrEmp.RESET;
                    CLEAR(t_ContrEmp);
                    t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                    //  t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code",'%1|%2','D-PIO-IZ','D-PIO-NA');
                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1', 'D-PIO-IZ');
                    t_ContrEmp.SETFILTER(t_ContrEmp."Amount From Wage", '>%1', 0);
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumPIO += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;
                    t_ContrEmp1.RESET;
                    CLEAR(t_ContrEmp1);

                    t_ContrEmp1.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp1.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp1.SETFILTER(t_ContrEmp1."Contribution Code", '%1', 'D-ZDRAV-IZ');
                    t_ContrEmp1.SETFILTER(t_ContrEmp1."Amount From Wage", '>%1', 0);
                    IF t_ContrEmp1.FINDFIRST THEN BEGIN
                        REPEAT
                            sumZDR += t_ContrEmp1."Amount From Wage" + t_ContrEmp1."Amount Over Wage";
                        UNTIL t_ContrEmp1.NEXT = 0;
                    END;

                    t_ContrEmp2.RESET;
                    CLEAR(t_ContrEmp2);

                    t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                    //   t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code",'%1|%2','D-NEZAP-IZ','D-NEZAP-NA');
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code", '%1', 'D-NEZAP-IZ');
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Amount From Wage", '>%1', 0);
                    IF t_ContrEmp2.FINDFIRST THEN BEGIN
                        REPEAT
                            sumNZ += t_ContrEmp2."Amount From Wage" + t_ContrEmp2."Amount Over Wage";
                        UNTIL t_ContrEmp2.NEXT = 0;
                    END;


                    //sd01 end end

                    //*******************************************Additions****************************************//
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            BruttoAdd += WVE."Cost Amount (Brutto)";
                            NettoAdd += WVE."Cost Amount (Netto)";
                        UNTIL WVE.NEXT = 0;

                    WVET.SETFILTER("Document No.", "Wage Header No.");
                    WVET.SETFILTER("Employee No.", "Employee No.");
                    WVET.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                    WVET.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVET.SETFILTER("Entry Type", '%1', WVET."Entry Type"::Tax);
                    IF WVET.FIND('-') THEN
                        REPEAT
                            TaxAdd := TaxAdd + WVET."Cost Amount (Netto)";
                            TaxBasisAdd += (WVET."Cost Amount (Netto)" / 0.1);
                        UNTIL WVET.NEXT = 0;


                    WVEC.SETFILTER("Employee No.", "Employee No.");
                    WVEC.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                    WVEC.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVEC.SETFILTER("Entry Type", '%1|%2', WVEC."Entry Type"::"Net Wage", WVEC."Entry Type"::Taxable);
                    IF WVEC.FIND('-') THEN
                        REPEAT
                            BruttoAddTotal += WVEC."Cost Amount (Brutto)";
                        UNTIL WVEC.NEXT = 0;

                    //*******************************************Additions****************************************//



                    GetAddTaxesPercentage(AddTaxPerc);
                    InvTaxPerc1 := 0;
                    TaxClass1.RESET;
                    TaxClass1.SETFILTER(Active, '%1', TRUE);
                    TaxClass1.SETFILTER(Code, '%1|%2', 'FBIHRS', 'FBIH');
                    IF TaxClass1.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass1.Percentage / 100;


                    WC.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    WC.SETFILTER("Employee No.", '%1', "Employee No.");
                    IF WC.FINDFIRST THEN BEGIN
                        REPEAT
                            IndirectBrutto += WC."Indirect Wage Addition Amount" / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                            DirectBrutto += WC.Brutto - IndirectBrutto + BruttoAdd;
                        UNTIL WC.NEXT = 0;
                    END;

                    WC1.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    WC1.SETFILTER("Employee No.", '%1', "Employee No.");
                    IF WC1.FINDFIRST THEN BEGIN
                        WC1.CALCSUMS(Brutto);
                        TotalDirectBrutto := WC1.Brutto + BruttoAdd;
                        WC1.CALCSUMS("Indirect Wage Addition Amount");
                        TotalIndirectBrutto := WC1."Indirect Wage Addition Amount";

                    END;

                    WC2.SETRANGE("Payment Date", StartDated, EndDated);
                    WC2.SETFILTER("Employee No.", '%1', "Employee No.");
                    IF WC2.FINDFIRST THEN BEGIN
                        REPEAT
                            CLEAR(t_ContrEmp);
                            t_ContrEmp.RESET;
                            t_ContrEmp.SETFILTER("Employee No.", WC2."Employee No.");
                            //t_ContrEmp.SETFILTER("Wage Calc No.",WC2."No.");
                            t_ContrEmp.SETFILTER("Wage Header No.", WC2."Wage Header No.");
                            t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1', 'D-PIO-IZ');
                            t_ContrEmp.SETFILTER(t_ContrEmp."Amount From Wage", '>%1', 0);
                            IF t_ContrEmp.FINDFIRST THEN BEGIN
                                REPEAT
                                    sumPIOTotal += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";
                                UNTIL t_ContrEmp.NEXT = 0;
                            END;
                            CLEAR(t_ContrEmp);
                            t_ContrEmp.RESET;
                            t_ContrEmp.SETFILTER("Employee No.", WC2."Employee No.");
                            // t_ContrEmp.SETFILTER("Wage Calc No.",WC2."No.");
                            t_ContrEmp.SETFILTER("Wage Header No.", WC2."Wage Header No.");
                            t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1', 'D-ZDRAV-IZ');
                            t_ContrEmp.SETFILTER(t_ContrEmp."Amount From Wage", '>%1', 0);
                            IF t_ContrEmp.FINDFIRST THEN BEGIN
                                REPEAT
                                    sumZDRAV += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";
                                UNTIL t_ContrEmp.NEXT = 0;
                            END;
                            CLEAR(t_ContrEmp);
                            t_ContrEmp.RESET;
                            t_ContrEmp.SETFILTER("Employee No.", WC2."Employee No.");
                            // t_ContrEmp.SETFILTER("Wage Calc No.",WC2."No.");
                            t_ContrEmp.SETFILTER("Wage Header No.", WC2."Wage Header No.");
                            t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1', 'D-NEZAP-IZ');
                            t_ContrEmp.SETFILTER(t_ContrEmp."Amount From Wage", '>%1', 0);
                            IF t_ContrEmp.FINDFIRST THEN BEGIN
                                REPEAT
                                    sumNEZAPTotal += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";
                                UNTIL t_ContrEmp.NEXT = 0;
                            END;
                            TaxB += WC2."Tax Basis" + TaxBasisAdd;
                            TaxT += WC2.Tax + TaxAdd;
                            WC2.CALCFIELDS(Use);
                            TotalBruttoSum += WC2.Brutto;
                            UseTotal += WC2.Use;
                        UNTIL WC2.NEXT = 0;
                    END;
                    ContributionTotal := sumPIOTotal + sumZDRAV + sumNEZAPTotal;

                    WC3.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    WC3.SETFILTER("Employee No.", '%1', "Employee No.");
                    IF WC3.FINDFIRST THEN BEGIN
                        REPEAT
                            TaxD += WC3."Tax Deductions";
                            NetFinal += WC3."Net Wage" - WC3.Tax;
                        UNTIL WC3.NEXT = 0;
                        WC3.CALCSUMS("Tax Deductions");
                        TotalTaxDeduction := WC3."Tax Deductions";
                        WC3.CALCSUMS("Tax Basis");
                        TotalTaxBasis := WC3."Tax Basis" + TaxBasisAdd;
                        WC3.CALCSUMS(Tax);
                        TaxTotal := WC3.Tax;
                        WC3.CALCSUMS("Net Wage");
                        TotalNetFinal := WC3."Net Wage" - WC3.Tax + (NettoAdd - TaxAdd);
                    END;

                    WC4.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    WC4.SETFILTER("Employee No.", '%1', "Employee No.");
                    IF WC4.FINDFIRST THEN BEGIN
                        REPEAT
                            WC4.CALCFIELDS(Use);
                            UsePerWage += WC4.Use;
                        UNTIL WC4.NEXT = 0;
                        // WC4.CALCFIELDS(Use);
                        // UseTotal:=WC4.Use;
                    END;

                    IF IDMonthText <> '' THEN
                        IDMonthText += ' / ';

                    IDMonthText := FORMAT("Month Of Wage") + '/' + FORMAT("Year of Wage");

                    //NetFinal := ("Wage Calculation"."Net Wage" - "Wage Calculation".Tax) ;
                    TotalTaxDeduction := "Tax Deductions";
                    TotalIndirectNetto := "Indirect Wage Addition Amount";
                    TotalTax := Tax + TaxAdd;
                    TotalNeto := "Net Wage" + NettoAdd;
                    // TotalNetFinal := NetFinal;
                    Mjesec := COPYSTR(FORMAT("Payment Date"), 4, 2);

                    CALCFIELDS(Use);
                    /*NKBC  IF Use <> 0 THEN BEGIN
                         PaymentTypeRecord.SETFILTER("Version Code", '%1', '2');
                         IF PaymentTypeRecord.FINDFIRST THEN
                             PaymentType := PaymentTypeRecord."Level Code";
                     END;



                     PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                     IF PaymentTypeRecord.FINDFIRST THEN
                         PaymentType := PaymentTypeRecord."Level Code";

                     POR80 := 0;
                     EmpAbs.RESET;
                     EmpAbs.SETFILTER("Employee No.", "Employee No.");
                     IF EmpAbs.FIND('-') THEN BEGIN
                         StartDatedT := DMY2DATE(1, "Month Of Wage", IDYear);
                         EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                         EmpAbs.SETRANGE("From Date", StartDatedT, EndDatedT);
                         EmpAbs.SETRANGE("Cause of Absence Code", 'POR-80');
                         EmpAbs.CALCSUMS(Quantity);
                         POR80 += EmpAbs.Quantity;
                         IF ((POR80 < "Hour Pool") AND (POR80 <> 0)) THEN BEGIN
                             PaymentTypeRecord.SETFILTER("Version Code", '%1', '9');
                             IF PaymentTypeRecord.FINDFIRST THEN
                                 PaymentType := PaymentTypeRecord."Level Code";
                         END;
                     END;

                     BOL := 0;
                     EmpAbs1.RESET;
                     EmpAbs1.SETFILTER("Employee No.", "Employee No.");
                     IF EmpAbs1.FIND('-') THEN BEGIN
                         StartDatedT := DMY2DATE(1, "Month Of Wage", IDYear);
                         EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                         EmpAbs1.SETRANGE("From Date", StartDatedT, EndDatedT);
                         EmpAbs1.SETRANGE("Cause of Absence Code", 'BOL-100');
                         EmpAbs1.CALCSUMS(Quantity);
                         BOL += EmpAbs1.Quantity;
                         IF BOL <> 0 THEN BEGIN
                             PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                             IF PaymentTypeRecord.FINDFIRST THEN
                                 PaymentType := PaymentTypeRecord."Level Code";
                         END;
                     END;


                     BOL42 := 0;
                     EmpAbs2.RESET;
                     EmpAbs2.SETFILTER("Employee No.", "Employee No.");
                     IF EmpAbs2.FIND('-') THEN BEGIN
                         StartDatedT := DMY2DATE(1, "Month Of Wage", IDYear);
                         EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                         EmpAbs2.SETRANGE("From Date", StartDatedT, EndDatedT);
                         EmpAbs2.SETRANGE("Cause of Absence Code", 'BOL-42');
                         EmpAbs2.CALCSUMS(Quantity);
                         BOL42 := EmpAbs2.Quantity;
                         IF BOL42 <> 0 THEN BEGIN
                             PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                             IF PaymentTypeRecord.FINDFIRST THEN
                                 PaymentType := PaymentTypeRecord."Level Code";
                         END;
                     END;


                     POR70 := 0;
                     EmpAbs3.RESET;
                     EmpAbs3.SETFILTER("Employee No.", WageCalc."Employee No.");
                     IF EmpAbs3.FIND('-') THEN BEGIN
                         StartDatedT := DMY2DATE(1, "Month Of Wage", IDYear);
                         EndDatedT := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDatedT));
                         EmpAbs3.SETRANGE("From Date", StartDatedT, EndDatedT);
                         EmpAbs3.SETRANGE("Cause of Absence Code", 'POR-70');
                         EmpAbs3.CALCSUMS(Quantity);
                         POR70 := EmpAbs3.Quantity;
                         IF POR70 <> 0 THEN BEGIN
                             PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                             IF PaymentTypeRecord.FINDFIRST THEN
                                 PaymentType := PaymentTypeRecord."Level Code";
                         END;
                     END; NKBC*/
                    IF PaymentType = 0 THEN PaymentType := 1;

                end;

                trigger OnPreDataItem()
                begin
                    IDMonthText := '';
                    EVALUATE(Godina, FORMAT(IDYear));
                    StartDate := '1.1.' + Godina;
                    EndDate := '31.12.' + Godina;
                    EVALUATE(StartDated, StartDate);
                    EVALUATE(EndDated, EndDate);

                    //MESSAGE((FORMAT(StartDated))+','+FORMAT(EndDated));
                    //   SETFILTER("Payment Date",'%1..2', StartDated,EndDated);
                    BruttoAdd := 0;
                    SETRANGE("Payment Date", StartDated, EndDated);
                    SETFILTER("Contribution Category Code", '%1|%2', 'FBIHRS', 'FBIH');
                end;
            }

            trigger OnPreDataItem()
            begin
                Comp.GET;
                WH.RESET;
                //SETFILTER("Wage Posting Group",'%1|%2','FBIHRS','FBIH');
                SETFILTER("Contribution Category Code", '%1|%2', 'FBIHRS', 'FBIH');
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

        IDYear := DATE2DMY(CALCDATE('-2M', WORKDATE), 3);
        //IDDay:=DATE2DMY(CALCDATE('-2M',WORKDATE),1);
    end;

    var
        BruttoAddTotal: Decimal;
        TaxBasisAdd: Decimal;
        TaxAdd: Decimal;
        BruttoAdd: Decimal;
        NettoAdd: Decimal;
        WVE: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        WVEC: Record "Wage Value Entry";
        t_ContrEmp1: Record "Contribution Per Employee";
        NewString: Text;
        sumZDR: Decimal;
        sumNZ: Decimal;
        t_ContrEmp2: Record "Contribution Per Employee";
        sumPIO: Decimal;
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
        t_ContrEmp: Record "Contribution Per Employee";
        WC: Record "Wage Calculation";
        WC1: Record "Wage Calculation";
        WC2: Record "Wage Calculation";
        TotalBruttoSum: Decimal;
        sumPIOTotal: Decimal;
        sumZDRAV: Decimal;
        sumNEZAPTotal: Decimal;
        ContributionTotal: Decimal;
        WC3: Record "Wage Calculation";
        TaxD: Decimal;
        TaxB: Decimal;
        TaxT: Decimal;
        TaxTotal: Decimal;
        WC4: Record "Wage Calculation";
        UseTotal: Decimal;
        UsePerWage: Decimal;
        TotalDB: Decimal;
        WC5: Record "Wage Calculation";
        PaymentType: Integer;
        //NKBC PaymentTypeRecord: Record "99000790";
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

