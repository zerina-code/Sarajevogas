xmlport 50047 "Import XML Doc"
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
                textelement(DocumentNoF)
                {
                    MinOccurs = Zero;
                }
                textelement(Month)
                {
                    MinOccurs = Zero;
                }
                textelement(Year)
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
                    RF: Decimal;
                    IntCus: Integer;
                begin


                    "Calculation Journal Line".Reset();
                    "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                    "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                    if Evaluate(MonthInt, Month) then
                        "Calculation Journal Line".SetFilter("Month Of GAS Calculation", '%1', MonthInt);
                    if Evaluate(YearInt, Year) then
                        "Calculation Journal Line".SetFilter("Year Of GAS Calculation", '%1', YearInt);


                    if "Calculation Journal Line".FindSet() then
                        repeat
                            "Calculation Journal Line"."Document No. Posting" := DocumentNoF;
                            "Calculation Journal Line".Modify(false);


                            Broj2 += 1;
                            CurrentDateT := TIME;
                            Progress.UPDATE(1, Broj2);
                            Progress.UPDATE(2, CurrentDateT);

                        until "Calculation Journal Line".Next() = 0;


                end;


            }
        }


    }

    trigger OnPreXmlPort()
    begin

        Broj2 := 0;
        //  BigText := '';
        StartDaT := TIME;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + Format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
    end;




    var

        Sm3_decimal: Decimal;
        CurrentDateT: Time;
        UP_decimal: Decimal;
        Broj2: Integer;
        Progress: Dialog;
        StartDaT: Time;

        BM_decimal: Decimal;
        WAR_decimal: Decimal;
        GA_Dec: Decimal;
        GV_dec: Decimal;
        GP_dec: Decimal;
        GTot: Decimal;
        BVM_decimal: Decimal;
        WAR_LVT_decimal: Decimal;
        MonthInt: Integer;
        YearInt: Integer;
        CalcFrom: Date;
        D1Date: Date;
        CalcTo: Date;
        SA_decimal: Decimal;
        STA_decimal: Decimal;
        SVA_decimal: Decimal;


}

