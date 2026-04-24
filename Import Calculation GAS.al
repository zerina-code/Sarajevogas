xmlport 50045 "Import XML GAS"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import XML GAS';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Calculation Journal Line"; "Calculation Journal Line")
            {
                AutoSave = false;
                MinOccurs = Zero;
                XmlName = 'Calculation_Journal_Line';
                UseTemporary = false;
                textelement(SifraObracuna)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraMM)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraMjeraca)
                {
                    MinOccurs = Zero;
                }
                textelement(CalorifcValue) { MinOccurs = Zero; }
                textelement(SM0T3)
                {
                    MinOccurs = Zero;
                }
                textelement(GA)
                {
                    MinOccurs = Zero;
                }
                textelement(GV)
                {
                    MinOccurs = Zero;
                }
                textelement(GP)
                {
                    MinOccurs = Zero;
                }
                textelement(GT)
                {
                    MinOccurs = Zero;
                }

                textelement(DateFrom)
                {
                    MinOccurs = Zero;
                }
                textelement(DateTO)
                {
                    MinOccurs = Zero;
                }
                textelement(Unit)
                {
                    MinOccurs = Zero;
                }
                textelement(UnitPurchase)
                {
                    MinOccurs = Zero;
                }
                textelement(UnitDistribution)
                {
                    MinOccurs = Zero;
                }
                textelement(SalesUnitP)
                {
                    MinOccurs = Zero;
                }
                textelement(BasisA)
                {
                    MinOccurs = Zero;
                }
                textelement(BasisC)
                {
                    MinOccurs = Zero;
                }
                textelement(MV)
                {
                    MinOccurs = Zero;
                }
                textelement(TotalBasis)
                {
                    MinOccurs = Zero;
                }
                textelement(WC)
                {
                    MinOccurs = Zero;
                }
                textelement(WCLVT)
                {
                    MinOccurs = Zero;
                }
                textelement(WCode)
                {
                    MinOccurs = Zero;
                }
                textelement(CCCode_V)
                {
                    MinOccurs = Zero;
                }
                textelement(Sub)
                {
                    MinOccurs = Zero;
                }
                textelement(SubA)
                {
                    MinOccurs = Zero;
                }

                textelement(STA)
                {
                    MinOccurs = Zero;
                }
                textelement(SVA)
                {
                    MinOccurs = Zero;
                }
                textelement(D1)
                {
                    MinOccurs = Zero;
                }
                textelement(D2)
                {
                    MinOccurs = Zero;
                }
                textelement(D3)
                {
                    MinOccurs = Zero;
                }
                textelement(D4)
                {
                    MinOccurs = Zero;
                }
                textelement(D5)
                {
                    MinOccurs = Zero;
                }
                textelement(D6)
                {
                    MinOccurs = Zero;
                }
                textelement(AutoInn)
                {
                    MinOccurs = Zero;
                }




                trigger OnAfterInsertRecord()
                var
                    CalJ: Record "Calculation Journal Line";
                    MobI: Integer;
                    NewDecimal: Decimal;
                    DifA: Decimal;
                    DateD: Date;
                    DateP: Date;
                    CaloricDecimal: Decimal;
                    RF: Decimal;
                    IntCus: Integer;
                begin


                    "Calculation Journal Line".Reset();
                    "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                    "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                    "Calculation Journal Line".SetFilter("Measuring Point Code", '%1', SifraMM);
                    "Calculation Journal Line".SetFilter(Gauge, '%1', SifraMjeraca);
                    "Calculation Journal Line".SetFilter(Autoint, AutoInn);
                    if "Calculation Journal Line".FindSet() then
                        repeat
                            if Evaluate(Sm3_decimal, SM0T3) then
                                "Calculation Journal Line".SM3 := Sm3_decimal
                            else
                                "Calculation Journal Line".SM3 := 0;

                            "Calculation Journal Line".Difference := "Calculation Journal Line"."New Value" - "Calculation Journal Line"."Old Value";

                            if Evaluate(CaloricDecimal, CalorifcValue)
                            then begin
                                "Calculation Journal Line"."Calorific power coefficient" := CaloricDecimal;
                                "Calculation Journal Line".KOEKAL := CaloricDecimal
                            end
                            else begin
                                "Calculation Journal Line"."Calorific power coefficient" := 0;
                                "Calculation Journal Line".KOEKAL := 0;
                            end;


                            if Evaluate(IntCus, "Calculation Journal Line"."Customer No.") then
                                "Calculation Journal Line"."Customer No. int" := IntCus
                            else
                                "Calculation Journal Line"."Customer No. int" := 0;



                            if Evaluate(GA_Dec, GA) then
                                "Calculation Journal Line"."GAS - amount" := GA_Dec
                            else
                                "Calculation Journal Line"."GAS - amount" := 0;

                            if Evaluate(GV_dec, GV) then
                                "Calculation Journal Line"."GAS - VAT" := GV_dec
                            else
                                "Calculation Journal Line"."GAS - VAT" := 0;

                            if Evaluate(GP_dec, GP) then
                                "Calculation Journal Line"."GAS - part" := GP_dec
                            else
                                "Calculation Journal Line"."GAS - part" := 0;

                            if Evaluate(GTot, GT) then
                                "Calculation Journal Line".Total := GTot
                            else
                                "Calculation Journal Line".Total := 0;



                            if Evaluate(CalcFrom, DateFrom) then
                                "Calculation Journal Line"."Calculation Date From" := CalcFrom
                            else
                                "Calculation Journal Line"."Calculation Date From" := 0D;
                            if Evaluate(CalcTo, DateTO) then
                                "Calculation Journal Line"."Calculation Date To" := CalcTo
                            else
                                "Calculation Journal Line"."Calculation Date To" := 0D;


                            if Evaluate(UP_decimal, Unit) then
                                "Calculation Journal Line"."Unit Price" := UP_decimal
                            else
                                "Calculation Journal Line"."Unit Price" := 0;

                            if Evaluate(UPurchase_decimal, UnitPurchase) then
                                "Calculation Journal Line"."Purchase Unit Price" := UPurchase_decimal
                            else
                                "Calculation Journal Line"."Purchase Unit Price" := 0;


                            if Evaluate(UpDistrib_decimal, UnitDistribution) then
                                "Calculation Journal Line"."Distribution Unit Price" := UpDistrib_decimal
                            else
                                "Calculation Journal Line"."Distribution Unit Price" := 0;

                            if Evaluate(UPSales_decimal, SalesUnitP) then
                                "Calculation Journal Line"."Sales Unit Price" := UPSales_decimal
                            else
                                "Calculation Journal Line"."Sales Unit Price" := 0;

                            if Evaluate(BM_decimal, BasisA) then
                                "Calculation Journal Line"."Basis maintenance" := BM_decimal
                            else
                                "Calculation Journal Line"."Basis maintenance" := 0;
                            "Calculation Journal Line"."Basis Resource Code" := BasisC;
                            if Evaluate(BVM_decimal, MV) then
                                "Calculation Journal Line"."Maintenance VAT" := BVM_decimal
                            else
                                "Calculation Journal Line"."Maintenance VAT" := 0;

                            if Evaluate(BVM_decimalTotal, TotalBasis) then
                                "Calculation Journal Line"."Maintenance - part" := BVM_decimalTotal
                            else
                                "Calculation Journal Line"."Maintenance - part" := 0;


                            if Evaluate(WAR_decimal, WC) then
                                "Calculation Journal Line"."War Calculation" := WAR_decimal
                            else
                                "Calculation Journal Line"."War Calculation" := 0;
                            if Evaluate(WAR_LVT_decimal, WCLVT)
                            then
                                "Calculation Journal Line"."War Calculation (LVT)" := WAR_LVT_decimal
                            else
                                "Calculation Journal Line"."War Calculation (LVT)" := 0;
                            "Calculation Journal Line"."War Resource Code" := WCode;
                            "Calculation Journal Line"."Currency Code" := CCCode_V;
                            if (Sub = 'TRUE') or (Sub = 'DA') then
                                "Calculation Journal Line".Subsidies := true
                            else
                                "Calculation Journal Line".Subsidies := false;
                            if Evaluate(SA_decimal, SubA) then
                                "Calculation Journal Line"."Subsidies Amount" := SA_decimal
                            else
                                "Calculation Journal Line"."Subsidies Amount" := 0;
                            if Evaluate(STA_decimal, STA) then
                                "Calculation Journal Line"."Subsidies Total Amount" := STA_decimal
                            else
                                "Calculation Journal Line"."Subsidies Total Amount" := 0;
                            if Evaluate(SVA_decimal, SVA) then
                                "Calculation Journal Line"."Subsidies VAT Amount" := SVA_decimal
                            else
                                "Calculation Journal Line"."Subsidies VAT Amount" := 0;

                            if Evaluate(D1Date, D1) then
                                "Calculation Journal Line"."Deminimis Act Date" := D1Date
                            else
                                "Calculation Journal Line"."Deminimis Act Date" := 0D;
                            "Calculation Journal Line"."Deminimis Act Name" := D2;
                            "Calculation Journal Line"."Deminimis Act Number" := D3;
                            "Calculation Journal Line"."Deminimis Legal act" := D4;
                            "Calculation Journal Line"."Deminimis Purpose" := D5;
                            "Calculation Journal Line"."Deminimis Remark" := D6;
                            "Calculation Journal Line".Difference := "Calculation Journal Line"."New Value" - "Calculation Journal Line"."Old Value";
                            "Calculation Journal Line".Modify();

                            CurrentDateT := time;
                            BrojMm += 1;
                            Progress.UPDATE(1, ROUND(BrojMm));
                            Progress.UPDATE(2, CurrentDateT);

                        until "Calculation Journal Line".Next() = 0;


                end;


            }
        }


    }

    trigger OnPreXmlPort()
    begin

        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;
        BrojMm := 0;

    end;




    var

        Sm3_decimal: Decimal;
        UP_decimal: Decimal;
        BrojMm: Decimal;

        BM_decimal: Decimal;
        WAR_decimal: Decimal;
        GA_Dec: Decimal;
        GV_dec: Decimal;
        GP_dec: Decimal;
        GTot: Decimal;
        BVM_decimal: Decimal;

        BVM_decimalTotal: Decimal;
        StartDaT: Time;
        Progress: Dialog;
        WAR_LVT_decimal: Decimal;
        CalcFrom: Date;
        D1Date: Date;
        CalcTo: Date;
        SA_decimal: Decimal;
        UPurchase_decimal: Decimal;

        STA_decimal: Decimal;
        CurrentDateT: Time;
        SVA_decimal: Decimal;
        UpDistrib_decimal: Decimal;
        UPSales_decimal: Decimal;

}

