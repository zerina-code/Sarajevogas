/*report 50031 "GIP-1022 Brcko"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GIP-1022 Brcko.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; Employee)
        {
            RequestFilterFields = "No.";
            column(EmpNo; DataItem1."No.")
            {
            }
            column(KopanijaNaziv; ORG.Description)
            {
            }
            column(KompanijaAdresa; ORG.Address)
            {
            }
            column(JIB; Jibb)
            {
            }
            column(City; ORG.City)
            {
            }
            column(PostCode; ORG."Post Code")
            {
            }
            column(ZaposlenikIme; DataItem1."First Name")
            {
            }
            column(ZaposlenikPrezime; DataItem1."Last Name")
            {
            }
            column(ZaposlenikAdresa1; DataItem1.Address)
            {
            }
            column(ZaposlenikAdresa2; DataItem1."Address 2")
            {
            }
            column(JMB; DataItem1."Employee ID")
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
                column(Neto; DataItem29."Net Wage")
                {
                }
                column(TaxDeduction; TotalTaxDeduction)
                {
                }
                column(TaxBasis; TotalTaxBasis)
                {
                }
                column(Ttax; Ttax2)
                {
                }
                column(NetFinal; NetFinal)
                {
                }
                column(PayDate; DataItem29."Payment Date")
                {
                }
                column(TotalIndirectNeto; TotalIndirectNetto)
                {
                }
                column(GodinaPorezna; DataItem29."Year of Wage")
                {
                }
                column(GodinaObracuna1; DataItem29."Year Of Calculation")
                {
                }
                column(PaymentDate; DataItem29."Payment Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Doprinosi za pio i zdravstvo SMstart
                    DodaciPlus := 0;
                    Porezzzz := 0;
                    Porezzzz2 := 0;
                    Oporezivi := 0;
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
                    // TaxClass1.SETFILTER(Code, '%1|%2','BD','BDRS');
                    IF TaxClass1.FIND('-') THEN
                        InvTaxPerc1 := 1 - TaxClass1.Percentage / 100;
                    IndirectBrutto := DataItem29."Indirect Wage Addition Amount" / ((1 - AddTaxPerc / 100) * InvTaxPerc1);
                    DirectBrutto := DataItem29.Brutto - IndirectBrutto;
                    IF IDMonthText <> '' THEN
                        IDMonthText += ' / ';

                    IDMonthText := FORMAT(DataItem29."Month Of Wage") + '/' + FORMAT(DataItem29."Year of Wage");

                    NetFinal := (DataItem29."Net Wage" - DataItem29.Tax);
                    TotalBruto := DataItem29.Brutto;
                    Ttax2 := DataItem29.Tax;
                    TotalIndirectNetto := DataItem29."Indirect Wage Addition Amount";
                    TotalTax := DataItem29.Tax;
                    TotalIndirectBrutto := IndirectBrutto;
                    TotalDirectBrutto := DirectBrutto;
                    TotalTaxDeduction := DataItem29."Tax Deductions";
                    TotalTaxBasis := DataItem29."Tax Basis";
                    TotalNeto := DataItem29."Net Wage";
                    TotalNetFinal := NetFinal;
                    Mjesec := COPYSTR(FORMAT(DataItem29."Payment Date"), 4, 2);
                    IF DataItem29.Tax <> 0 THEN
                        PostotakPorez := DataItem29."Tax Basis" / DataItem29.Tax;

                    WageV.RESET;
                    WageV.SETFILTER("Wage Calculation Type", '%1', WageV."Wage Calculation Type"::Additions);
                    WageV.SETFILTER("Document No.", '%1', DataItem29."Wage Header No.");
                    WageV.SETFILTER("Employee No.", '%1', "Employee No.");
                    WageV.SETFILTER("Entry Type", '%1', WageV."Entry Type"::Tax);
                    IF WageV.FINDSET THEN
                        REPEAT
                            DodaciPlus := DodaciPlus + WageV."Cost Amount (Brutto)";
                            Porezzzz := Porezzzz + WageV."Cost Amount (Netto)";
                            Porezzzz2 := Porezzzz2 + WageV."Cost Amount (Netto)";
                        UNTIL WageV.NEXT = 0;
                    TotalDirectBrutto := DirectBrutto + DodaciPlus;
                    TotalBruto := TotalBruto + DodaciPlus;
                    TotalTaxBasis := TotalTaxBasis + Porezzzz * PostotakPorez;
                    Ttax2 := Ttax2 + Porezzzz2;

                    WageV.RESET;
                    WageV.SETFILTER("Wage Calculation Type", '%1', WageV."Wage Calculation Type"::Additions);
                    WageV.SETFILTER("Document No.", '%1', DataItem29."Wage Header No.");
                    WageV.SETFILTER("Employee No.", '%1', "Employee No.");
                    WageV.SETFILTER("Entry Type", '%1', WageV."Entry Type"::Taxable);
                    IF WageV.FINDSET THEN
                        REPEAT
                            Oporezivi := Oporezivi + WageV."Cost Amount (Netto)" - Porezzzz;
                        UNTIL WageV.NEXT = 0;
                    NetFinal := NetFinal + Oporezivi;
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
                    DataItem29.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');

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
                //SETFILTER("Wage Posting Group",'%1|%2','FBIHRS','FBIH');
                // SETFILTER("Contribution Category Code",'%1|%2','BD','BDRS');
                "DataItem1".SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
                ORG.RESET;
                ORG.SETFILTER("Entity Code", '%1', 'BD');
                IF ORG.FINDFIRST THEN
                    Jibb := ORG."JIB Contributes"
                ELSE
                    Jibb := '';
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
                        ApplicationArea = all;
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

    trigger OnPreReport()
    begin
        DodaciPlus := 0;
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
        Jibb: Text;
        ORG: Record "ORG Dijelovi";
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
        WageV: Record "Wage Value Entry";
        DodaciPlus: Decimal;
        PostotakPorez: Decimal;
        WageCalcc: Record "Wage Calculation";
        Porezzzz: Decimal;
        Ttax2: Decimal;
        Porezzzz2: Decimal;
        Oporezivi: Decimal;

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
                // IF ATCCon.GET('BD|BDRS', AddTaxes.Code) THEN
                IF ATCCon.GET('BD|BDRS', AddTaxes.Code) THEN
                    Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;
}

*/