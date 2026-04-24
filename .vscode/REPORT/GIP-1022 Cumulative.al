report 50008 "GIP-1022 Cumulative "
{
    DefaultLayout = RDLC;
    RDLCLayout = './GIP-1022 Cumulative .rdlc';

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
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(sumZDR; sumZDR)
                {
                }
                column(sumNZ; sumNZ)
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

                trigger OnAfterGetRecord()
                begin
                    //Doprinosi za pio i zdravstvo SMstart
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;

                    t_ContrEmp.RESET;
                    CLEAR(t_ContrEmp);
                    t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                    //t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code",'%1|%2','D-PIO-IZ','D-PIO-NA');
                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1', 'D-PIO-IZ');
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumPIO += t_ContrEmp."Amount From Wage" + t_ContrEmp."Amount Over Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;
                    t_ContrEmp1.RESET;
                    CLEAR(t_ContrEmp1);

                    t_ContrEmp1.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp1.SETFILTER("Wage Header No.", "Wage Header No.");
                    //t_ContrEmp1.SETFILTER(t_ContrEmp1."Contribution Code",'%1|%2','D-ZDRAV-IZ','D-ZDRAV-NA');
                    t_ContrEmp1.SETFILTER(t_ContrEmp1."Contribution Code", '%1', 'D-ZDRAV-IZ');
                    IF t_ContrEmp1.FINDFIRST THEN BEGIN
                        REPEAT
                            sumZDR += t_ContrEmp1."Amount From Wage" + t_ContrEmp1."Amount Over Wage";
                        UNTIL t_ContrEmp1.NEXT = 0;
                    END;
                    t_ContrEmp2.RESET;
                    CLEAR(t_ContrEmp2);

                    t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                    // t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code",'%1|%2','D-NEZAP-IZ','D-NEZAP-NA');
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code", '%1', 'D-NEZAP-IZ');

                    IF t_ContrEmp2.FINDFIRST THEN BEGIN
                        REPEAT
                            sumNZ += t_ContrEmp2."Amount From Wage" + t_ContrEmp2."Amount Over Wage";
                        UNTIL t_ContrEmp2.NEXT = 0;
                    END;


                    BruttoAdd := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;
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


                    //*******************************************Additions****************************************//



                    GetAddTaxesPercentage(AddTaxPerc);
                    InvTaxPerc1 := 0;
                    TaxClass1.RESET;
                    TaxClass1.SETFILTER(Active, '%1', TRUE);
                    //TaxClass1.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass1.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass1.Percentage / 100;
                    IndirectBrutto := "Indirect Wage Addition Amount" / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                    DirectBrutto := Brutto - IndirectBrutto + BruttoAdd;
                    IF IDMonthText <> '' THEN
                        IDMonthText += ' / ';

                    IDMonthText := FORMAT("Month Of Wage") + '/' + FORMAT("Year of Wage");

                    NetFinal := ("Net Wage" - Tax) + (NettoAdd - TaxAdd);
                    TotalBruto := Brutto + BruttoAdd;
                    TotalIndirectNetto := "Indirect Wage Addition Amount";
                    TotalTax := Tax + TaxAdd;
                    TotalIndirectBrutto := IndirectBrutto;
                    TotalDirectBrutto := DirectBrutto;
                    TotalTaxDeduction := "Tax Deductions";
                    TotalTaxBasis := "Tax Basis" + TaxBasisAdd;
                    TotalNeto := "Net Wage" + NettoAdd;
                    TotalNetFinal := NetFinal;
                    Mjesec := COPYSTR(FORMAT("Payment Date"), 4, 2);
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


                    EVALUATE(Godina, FORMAT(IDYear));
                    StartDate := '1.1.' + Godina;
                    EndDate := '31.12.' + Godina;
                    EVALUATE(StartDated, StartDate);
                    EVALUATE(EndDated, EndDate);

                    //MESSAGE((FORMAT(StartDated))+','+FORMAT(EndDated));
                    //   SETFILTER("Payment Date",'%1..2', StartDated,EndDated);
                    SETRANGE("Payment Date", StartDated, EndDated);
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

            trigger OnPreDataItem()
            begin
                Comp.GET;
                WH.RESET;
                //SETFILTER("Wage Posting Group",'%1','FBiH');
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
    begin
        IDYear := DATE2DMY(CALCDATE('-2M', WORKDATE), 3);
        //IDDay:=DATE2DMY(CALCDATE('-2M',WORKDATE),1);
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
        sumNZ: Decimal;
        sumZDR: Decimal;
        sumPIO: Decimal;
        t_ContrEmp: Record "Contribution Per Employee";
        t_ContrEmp1: Record "Contribution Per Employee";
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

