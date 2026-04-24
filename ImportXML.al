xmlport 50044 "Import XML"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import XML';
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
                textelement(UsporedbaPrincip)
                {
                    MinOccurs = Zero;
                }
                textelement(RazlikaIznos)
                {
                    MinOccurs = Zero;
                }
                textelement(RazlikaOutOfRange)
                {
                    MinOccurs = Zero;
                }
                textelement(DateDiff)
                {
                    MinOccurs = Zero;
                }
                textelement(DatereviousF)
                {
                    MinOccurs = Zero;
                }
                textelement(RangeT)
                {
                    MinOccurs = Zero;
                }
                textelement(Option)
                {
                    MinOccurs = Zero;
                }
                textelement(MaxUsp)
                {
                    MinOccurs = Zero;
                }
                textelement(DiffRange1)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                var
                    CalJ: Record "Calculation Journal Line";
                    MobI: Integer;
                    NewDecimal: Decimal;
                    NewDecimalMax: Decimal;
                    DiffRange1Dec: Decimal;
                    DifA: Decimal;
                    DateD: Date;
                    DateP: Date;
                    RF: Decimal;
                begin

                    if Option = '1' then begin

                        "Calculation Journal Line".Reset();
                        "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                        "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                        "Calculation Journal Line".SetFilter("Measuring Point Code", '%1', SifraMM);
                        if "Calculation Journal Line".FindSet() then
                            repeat
                                if Evaluate(NewDecimal, UsporedbaPrincip) then
                                    "Calculation Journal Line"."New and Old value compare" := NewDecimal;

                                if Evaluate(NewDecimalMax, MaxUsp) then
                                    "Calculation Journal Line"."New and Old value compare Max" := NewDecimalMax;


                                if Evaluate(DifA, RazlikaIznos) then
                                    "Calculation Journal Line"."Difference Amount 1" := DifA;
                                if (RazlikaOutOfRange = 'TRUE') or (RazlikaOutOfRange = 'DA') or (RazlikaOutOfRange = 'Da') then
                                    "Calculation Journal Line"."Difference Out of range 1" := true
                                else
                                    "Calculation Journal Line"."Difference Out of range 1" := false;
                                if Evaluate(DateD, DateDiff) then
                                    "Calculation Journal Line"."Date Difference 1" := DateD;
                                if Evaluate(DateP, DatereviousF) then
                                    "Calculation Journal Line"."Date for previous Quantity" := DateP;
                                if Evaluate(RF, RangeT) then
                                    "Calculation Journal Line"."Range 1" := RF;


                                if Evaluate(DiffRange1Dec, DiffRange1) then
                                    "Calculation Journal Line"."Difference Range 1" := DiffRange1Dec
                                else
                                    "Calculation Journal Line"."Difference Range 1" := 0;
                                "Calculation Journal Line".Modify(true);
                            until "Calculation Journal Line".Next() = 0;


                    end;

                    if Option = '2' then begin

                        "Calculation Journal Line".Reset();
                        "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                        "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                        "Calculation Journal Line".SetFilter("Measuring Point Code", '%1', SifraMM);
                        if "Calculation Journal Line".FindSet() then
                            repeat
                                if Evaluate(NewDecimal, UsporedbaPrincip) then
                                    "Calculation Journal Line"."New and Old value compare" := NewDecimal;

                                if Evaluate(NewDecimalMax, MaxUsp) then
                                    "Calculation Journal Line"."New and Old value compare Max" := NewDecimalMax;
                                if Evaluate(DifA, RazlikaIznos) then
                                    "Calculation Journal Line"."Difference Amount 2" := DifA;
                                if (RazlikaOutOfRange = 'TRUE') or (RazlikaOutOfRange = 'DA') or (RazlikaOutOfRange = 'Da') then
                                    "Calculation Journal Line"."Difference Out of range 2" := true
                                else
                                    "Calculation Journal Line"."Difference Out of range 2" := false;
                                if Evaluate(DateD, DateDiff) then
                                    "Calculation Journal Line"."Date Difference 2" := DateD;
                                if Evaluate(DateP, DatereviousF) then
                                    "Calculation Journal Line"."Date for previous Quantity" := DateP;
                                if Evaluate(RF, RangeT) then
                                    "Calculation Journal Line"."Range 2" := RF;

                                if Evaluate(DiffRange1Dec, DiffRange1) then
                                    "Calculation Journal Line"."Difference Range 2" := DiffRange1Dec
                                else
                                    "Calculation Journal Line"."Difference Range 2" := 0;


                                "Calculation Journal Line".Modify(true);
                            until "Calculation Journal Line".Next() = 0;



                    end;

                    if Option = '3' then begin

                        "Calculation Journal Line".Reset();
                        "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                        "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                        "Calculation Journal Line".SetFilter("Measuring Point Code", '%1', SifraMM);
                        if "Calculation Journal Line".FindSet() then
                            repeat
                                if Evaluate(NewDecimal, UsporedbaPrincip) then
                                    "Calculation Journal Line"."New and Old value compare" := NewDecimal;
                                if Evaluate(NewDecimalMax, MaxUsp) then
                                    "Calculation Journal Line"."New and Old value compare Max" := NewDecimalMax;
                                if Evaluate(DifA, RazlikaIznos) then
                                    "Calculation Journal Line"."Difference Amount 3" := DifA;
                                if (RazlikaOutOfRange = 'TRUE') or (RazlikaOutOfRange = 'DA') or (RazlikaOutOfRange = 'Da') then
                                    "Calculation Journal Line"."Difference Out of range 3" := true
                                else
                                    "Calculation Journal Line"."Difference Out of range 3" := false;
                                if Evaluate(DateD, DateDiff) then
                                    "Calculation Journal Line"."Date Difference 3" := DateD;
                                if Evaluate(DateP, DatereviousF) then
                                    "Calculation Journal Line"."Date for previous Quantity" := DateP;
                                if Evaluate(RF, RangeT) then
                                    "Calculation Journal Line"."Range 3" := RF;

                                if Evaluate(DiffRange1Dec, DiffRange1) then
                                    "Calculation Journal Line"."Difference Range 3" := DiffRange1Dec
                                else
                                    "Calculation Journal Line"."Difference Range 3" := 0;

                                "Calculation Journal Line".Modify(true);
                            until "Calculation Journal Line".Next() = 0;
                    end;

                    if Option = '4' then begin

                        "Calculation Journal Line".Reset();
                        "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                        "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                        "Calculation Journal Line".SetFilter("Measuring Point Code", '%1', SifraMM);
                        if "Calculation Journal Line".FindSet() then
                            repeat
                                if Evaluate(NewDecimal, UsporedbaPrincip) then
                                    "Calculation Journal Line"."New and Old value compare" := NewDecimal;

                                if Evaluate(NewDecimalMax, MaxUsp) then
                                    "Calculation Journal Line"."New and Old value compare Max" := NewDecimalMax;
                                if Evaluate(DifA, RazlikaIznos) then
                                    "Calculation Journal Line"."Difference Amount 4" := DifA;
                                if (RazlikaOutOfRange = 'TRUE') or (RazlikaOutOfRange = 'DA') or (RazlikaOutOfRange = 'Da') then
                                    "Calculation Journal Line"."Difference Out of range 4" := true
                                else
                                    "Calculation Journal Line"."Difference Out of range 4" := false;
                                if Evaluate(DateD, DateDiff) then
                                    "Calculation Journal Line"."Date Difference 4" := DateD;
                                if Evaluate(DateP, DatereviousF) then
                                    "Calculation Journal Line"."Date for previous Quantity" := DateP;
                                if Evaluate(RF, RangeT) then
                                    "Calculation Journal Line"."Range 4" := RF;

                                if Evaluate(DiffRange1Dec, DiffRange1) then
                                    "Calculation Journal Line"."Difference Range 4" := DiffRange1Dec
                                else
                                    "Calculation Journal Line"."Difference Range 4" := 0;


                                "Calculation Journal Line".Modify(true);
                            until "Calculation Journal Line".Next() = 0;
                    end;

                    if Option = '5' then begin

                        "Calculation Journal Line".Reset();
                        "Calculation Journal Line".SetFilter(Code, '%1', SifraObracuna);
                        "Calculation Journal Line".SetFilter("Customer No.", '%1', SifraKupca);
                        "Calculation Journal Line".SetFilter("Measuring Point Code", '%1', SifraMM);
                        if "Calculation Journal Line".FindSet() then
                            repeat
                                if Evaluate(NewDecimal, UsporedbaPrincip) then
                                    "Calculation Journal Line"."New and Old value compare" := NewDecimal;

                                if Evaluate(NewDecimalMax, MaxUsp) then
                                    "Calculation Journal Line"."New and Old value compare Max" := NewDecimalMax;
                                if Evaluate(DifA, RazlikaIznos) then
                                    "Calculation Journal Line"."Difference Amount 5" := DifA;
                                if (RazlikaOutOfRange = 'TRUE') or (RazlikaOutOfRange = 'DA') or (RazlikaOutOfRange = 'Da') then
                                    "Calculation Journal Line"."Difference Out of range 5" := true
                                else
                                    "Calculation Journal Line"."Difference Out of range 5" := false;
                                if Evaluate(DateD, DateDiff) then
                                    "Calculation Journal Line"."Date Difference 5" := DateD;
                                if Evaluate(DateP, DatereviousF) then
                                    "Calculation Journal Line"."Date for previous Quantity" := DateP;
                                if Evaluate(RF, RangeT) then
                                    "Calculation Journal Line"."Range 5" := RF;
                                if Evaluate(DiffRange1Dec, DiffRange1) then
                                    "Calculation Journal Line"."Difference Range 5" := DiffRange1Dec
                                else
                                    "Calculation Journal Line"."Difference Range 5" := 0;

                                "Calculation Journal Line".Modify(true);
                            until "Calculation Journal Line".Next() = 0;
                    end;


                    //         FirstString := format(DataItem2.Code) + ';' + Format(DataItem2."Customer No.") + ';' + format(DataItem2."Measuring Point Code") + ';' + format("New and Old value compare") + ';' + format("Difference Amount 1") + ';' + format("Difference Out of range 1") +
                    //';' + format(DataItem2."Date Difference 1") + ';' +format(DataItem2."Date for previous Quantity") + ';' +format(DataItem2."Range 1");

                end;

            }
        }


    }

    trigger OnPreXmlPort()
    begin
    end;


    procedure SetParam2(SelectedInput: Option "Usporedba 1","Usporedba 2","Usporedba 3","Usporedba 4","Usporedba 5")
    begin
        Selected2 := SelectedInput;
    end;


    var

        Selected2: Option "Usporedba 1","Usporedba 2","Usporedba 3","Usporedba 4","Usporedba 5";

}

