report 50039 "GIP-1022 "
{
    DefaultLayout = RDLC;
    RDLCLayout = './GIP-1022.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

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
                column(BrojRadnika; DataItem29."Employee No.")
                {
                }
                column(WageNo; DataItem29."No.")
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
                    //Doprinosi za pio i zdravstvo SMstart
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;

                    t_ContrEmp.RESET;
                    CLEAR(t_ContrEmp);
                    t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                    //  t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code",'%1|%2','D-PIO-IZ','D-PIO-NA');
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
                    // t_ContrEmp1.SETFILTER(t_ContrEmp1."Contribution Code",'%1|%2','D-ZDRAV-IZ','D-ZDRAV-NA');
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
                    //   t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code",'%1|%2','D-NEZAP-IZ','D-NEZAP-NA');
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code", '%1', 'D-NEZAP-IZ');
                    IF t_ContrEmp2.FINDFIRST THEN BEGIN
                        REPEAT
                            sumNZ += t_ContrEmp2."Amount From Wage" + t_ContrEmp2."Amount Over Wage";
                        UNTIL t_ContrEmp2.NEXT = 0;
                    END;


                    //SM end




                    GetAddTaxesPercentage(AddTaxPerc);
                    InvTaxPerc1 := 0;
                    TaxClass1.RESET;
                    TaxClass1.SETFILTER(Active, '%1', TRUE);
                    TaxClass1.SETFILTER(Code, '%1', 'FBIH');
                    IF TaxClass1.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass1.Percentage / 100;
                    IndirectBrutto := DataItem29."Indirect Wage Addition Amount" / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                    DirectBrutto := DataItem29.Brutto - IndirectBrutto;
                    IF IDMonthText <> '' THEN
                        IDMonthText += ' / ';

                    IDMonthText := FORMAT(DataItem29."Month Of Wage") + '/' + FORMAT(DataItem29."Year of Wage");

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
                    DataItem29.SETRANGE("Payment Date", StartDated, EndDated);
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
                SETFILTER("Wage Posting Group", '%1', 'FBiH');
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

