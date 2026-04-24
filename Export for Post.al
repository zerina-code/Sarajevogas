report 50193 "Export Post"
{
    // //
    //ĐK WordLayout = './Transport print.docx';

    Caption = 'Export Post';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem2; "Calculation Journal Line")
        {
            UseTemporary = True;

            trigger OnAfterGetRecord()
            var
                CalcSetup: Record "Calculation Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;


                Noseries: code[20];
                CustT: Record "Customer Templ.";
                CaccS: Record "Calculation Setup";
                ItemBasic: Record Item;
                BarKod: text[250];
                BrojacI: Integer;
                WC: Record "Calcuation Header";
                CJL: Record "Calculation Journal Line";
                BrojacPrethodni: Integer;
                SaldoDio: Decimal;
                PretplDio: Decimal;
                CalorficV: Text;
                RelationF: text;
                NaredniSaldo: decimal;
                NaredniPretpl: Decimal;
                CL2: Record "Calculation Journal Line";
                EFDjelatnost: Record "MM Activity" temporary;
                EFDjelatnostRec: Record "MM Activity";
                AQ: Query "My Query";
                CountV: Integer;
                CLAverage: record "Calculation Journal Line";
                SumSm3: Decimal;
                DecConvert: Decimal;
                CJLLog: Record "CJL Logs";
                CHMonth: Record "Calcuation Header";
            //jednom se dodijeljuje i to je to, prilikom izvoza za poštara, po toj kategoriji

            begin
                BrojacRedova += 1;


                Progress.UPDATE(1, ROUND(BrojacRedova));



                CountV := 0;



                MjeraciZamjena := '';

                if MjeraciZamjena <> '' then begin

                    BrojacPrethodni := 0;
                    SaldoDio := "Customer Balance";
                    PretplDio := "Customer Prepayment";
                    FirstString := '';
                    //idem u prethodne mjesece koji nisu očitani

                    WC.Get(Code);

                    if wc."Include Quartaly" = true then begin

                        CJL.Reset();
                        CJL.SetFilter("Month Of GAS Calculation", '%1', wc."Calculate Month Q.");

                        CJL.setfilter("Customer No.", '%1', "Customer No.");
                        CJL.SetFilter("Year Of GAS Calculation", '%1', wc."Year Of GAS Calculation");
                        cjl.SetCurrentKey("Month Of GAS Calculation", "Year Of GAS Calculation");
                        cjl.Ascending;
                        if cjl.FindSet() then
                            repeat

                                CalcSum.Reset();
                                CalcSum.CopyFilters(cjl);
                                CalcSum.SetFilter("Customer No.", '%1', cjl."Customer No.");
                                CalcSum.SetFilter("Document No. Posting", '%1', cjl."Document No. Posting");
                                if CalcSum.FindFirst() then begin
                                    CalcSum.CalcSums("GAS - part", SM3, "Basis maintenance", "GAS - amount", "GAS - VAT", "Maintenance VAT", "War Calculation (LVT)", Difference);

                                    cjl.SM3 := CalcSum.SM3;
                                    cjl."Basis maintenance" := CalcSum."Basis maintenance";
                                    cjl."GAS - amount" := CalcSum."GAS - amount";
                                    cjl."War Calculation (LVT)" := CalcSum."War Calculation (LVT)";
                                    cjl."GAS - part" := CalcSum."GAS - part";
                                    cjl."GAS - VAT" := CalcSum."GAS - VAT";
                                    cjl."Maintenance VAT" := CalcSum."Maintenance VAT";
                                    cjl.Total := CalcSum.Total;

                                end;


                                BrojacPrethodni += 1;

                                //sad sve ovo ponovi, samo za prethodni obračun

                                if Date2DMY(CJL."Calculation Date To", 2) = 1 then
                                    Mjesec[1] := 'Januar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 2 then
                                    Mjesec[1] := 'Februar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 3 then
                                    Mjesec[1] := 'Mart' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 4 then
                                    Mjesec[1] := 'April' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 5 then
                                    Mjesec[1] := 'Maj' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 6 then
                                    Mjesec[1] := 'Juni' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 7 then
                                    Mjesec[1] := 'Juli' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 8 then
                                    Mjesec[1] := 'Avgust' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 9 then
                                    Mjesec[1] := 'Septembar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 10 then
                                    Mjesec[1] := 'Oktobar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 11 then
                                    Mjesec[1] := 'Novembar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));
                                if Date2DMY(CJL."Calculation Date To", 2) = 12 then
                                    Mjesec[1] := 'Decembar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3));

                                if Date2DMY(CJL."Calculation Date To", 2) = 1 then
                                    Mjesec_1[1] := 'Januar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 2 then
                                    Mjesec_1[1] := 'Februar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 3 then
                                    Mjesec_1[1] := 'Mart' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 4 then
                                    Mjesec_1[1] := 'April' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 5 then
                                    Mjesec_1[1] := 'Maj' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 6 then
                                    Mjesec_1[1] := 'Juni' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 7 then
                                    Mjesec_1[1] := 'Juli' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 8 then
                                    Mjesec_1[1] := 'Avgust' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 9 then
                                    Mjesec_1[1] := 'Septembar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 10 then
                                    Mjesec_1[1] := 'Oktobar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 11 then
                                    Mjesec_1[1] := 'Novembar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                if Date2DMY(CJL."Calculation Date To", 2) = 12 then
                                    Mjesec_1[1] := 'Decembar' + ' ' + FORMAT(DATE2DMY(CJL."Calculation Date To", 3) - 1);
                                FirstString := '';

                                if cjl."New Gauge" = true then
                                    CurrReport.Skip();
                                FirstString += 'H1';
                                FirstString += Separator;
                                //naziv kupca
                                FirstString += Replacestring_TName(CJL."Customer Name", ';', ',');
                                FirstString += Separator;

                                FirstString += CJL."Address MM";
                                if CJL."Street No. Text" <> '' then
                                    FirstString += '\' + CJL."Street No. Text";
                                if CJL.Floor <> '' then
                                    FirstString += '\' + CJL.Floor;
                                if cjl."Apartment No. Customer 2" <> '' then
                                    FirstString += '\' + CJL."Apartment No. Customer 2";
                                FirstString += Separator;

                                //MOŽDA   FirstString += CJL."Post Code MM" + ' ' + CJL."City MM";
                                CompanyInf.get;
                                FirstString += CompanyInf."Post Code" + ' ' + CompanyInf.City;
                                FirstString += Separator;


                                if CJL."Document No. Posting" = '' then begin
                                    CustT.Reset();
                                    CustT.SetFilter("Bill Category", '%1', CJL."Category Customer");
                                    if CustT.FindFirst() then begin

                                        NoSeriesMgt.InitSeries(CustT."Posting No. Series Bill", '', 0D, CJL."Document No. Posting", Noseries);
                                    end;
                                    FirstString += CJL."Document No. Posting";
                                    FirstString += Separator;
                                end
                                else begin
                                    FirstString += CJL."Document No. Posting";
                                    FirstString += Separator;

                                end;

                                FirstString += CJL."Customer No.";
                                FirstString += Separator;

                                MjeraciZamjena := '';
                                Brojaczamjena := 0;
                                CalcDuplicate.reset;
                                CalcDuplicate.CopyFilters(CJL);
                                CalcDuplicate.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                                CalcDuplicate.SetFilter(Code, '%1', cjl.Code);
                                CalcDuplicate.SetFilter("Customer No.", '%1', CJl."Customer No.");

                                CalcDuplicate.SetFilter("Document No. Posting", '%1', cjl."Document No. Posting");

                                CalcDuplicate.SetFilter("Document No. Posting", '%1', CJL."Document No. Posting");
                                CalcDuplicate.SetCurrentKey("Reading Date From");
                                CalcDuplicate.Ascending(true);
                                // CalcDuplicate.SetFilter("New Gauge", '%1', true);
                                if CalcDuplicate.FindSet then
                                    repeat
                                        Brojaczamjena += 1;
                                        MjeraciZamjena := CalcDuplicate."Serial Number" + '/';
                                        if CalcDuplicate."Old Gauge" = true then
                                            TextIzvora += 'Zamjena mjerača/'
                                        else
                                            TextIzvora += format(CJL."Source Data") + '/';

                                    until CalcDuplicate.Next() = 0;

                                if Brojaczamjena <= 1 then
                                    FirstString += CJL."Serial Number"
                                else
                                    FirstString += MjeraciZamjena;

                                FirstString += Separator;

                                FirstString += format(CJL."Customer Stroke 2") + '/' + format(CJL."Customer String 2");
                                FirstString += Separator;

                                if CJL."Source Data" = CJL."Source Data"::Unknown then
                                    CJL."Source Data" := CJL."Source Data"::Unobvious;

                                if cjl."Previous Unobvious Month" <> 0 then
                                    CJL."Source Data" := CJL."Source Data"::Manual;


                                if cjl.Unobvious = true then
                                    CJL."Source Data" := CJL."Source Data"::Manual;

                                if Brojaczamjena > 1 then
                                    FirstString += CopyStr(TextIzvora, 1, StrLen(TextIzvora) - 1)
                                else
                                    FirstString += Format(CJL."Source Data");
                                FirstString += Separator;


                                CompanyInf.get;
                                FirstString += Format(CompanyInf.City);
                                FirstString += Separator;

                                FirstString += Format(CJL."Reading Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format(CJL."Reading Date To", 0, '<day,2>.<month,2>.<year4>');

                                FirstString += Separator;
                                FirstString += format(CJL."Reading Date To", 0, '<day,2>.<month,2>.<year4>');

                                FirstString += Separator;
                                FirstString += format(CJL."Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                                PriceZero := '';
                                FirstString += Separator;
                                if StrLen(format(format(Replacestring_T(format(cjl."Purchase Unit Price"), ',', '.')))) < 5 then begin
                                    for i := 1 to 5 - StrLen(format(format(Replacestring_T(format(cjl."Purchase Unit Price"), ',', '.'))))
                                    do begin
                                        PriceZero += '0';
                                    end;
                                    FirstString += format(Replacestring_T(format(cjl."Purchase Unit Price"), ',', '.') + PriceZero) + ' KM';

                                end
                                else begin
                                    FirstString += format(Replacestring_T(format(cjl."Purchase Unit Price"), ',', '.')) + ' KM';
                                end;

                                FirstString += Separator;

                                PriceZero := '';

                                if StrLen(format(format(Replacestring_T(format(cjl."Distribution Unit Price"), ',', '.')))) < 5 then begin
                                    for i := 1 to 5 - StrLen(format(format(Replacestring_T(format(cjl."Distribution Unit Price"), ',', '.'))))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                    FirstString += format(Replacestring_T(format(cjl."Distribution Unit Price"), ',', '.') + PriceZero) + ' KM';

                                end
                                else begin
                                    FirstString += format(Replacestring_T(format(CJL."Distribution Unit Price"), ',', '.')) + ' KM';
                                end;

                                FirstString += Separator;

                                PriceZero := '';

                                if StrLen(format(format(Replacestring_T(format(cjl."Sales Unit Price"), ',', '.')))) < 5 then begin
                                    for i := 1 to 5 - StrLen(format(format(Replacestring_T(format(cjl."Sales Unit Price"), ',', '.'))))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                    FirstString += format(Replacestring_T(format(cjl."Sales Unit Price"), ',', '.') + PriceZero) + ' KM';

                                end
                                else begin
                                    FirstString += format(Replacestring_T(format(CJL."Sales Unit Price"), ',', '.')) + ' KM';
                                end;




                                //    FirstString += Separator;
                                //ovdje djemina dodati zamjene

                                NacinOcitanjaZamjena := '';
                                DatumOdMaxZamjena := 0D;
                                RazlikaZamjena := '';
                                NewZamjena := '';
                                OldZamjena := '';
                                DatumiSpojeniOd := '';
                                DatumiSpojenido := '';
                                DatumOdMinZamjena := 0D;
                                MjeraciZamjena := '';

                                NacinOcitanjaZamjena1 := '';
                                DatumOdMaxZamjena1 := 0D;
                                RazlikaZamjena1 := '';
                                NewZamjena1 := '';
                                OldZamjena1 := '';
                                DatumiSpojeniOd1 := '';
                                DatumiSpojenido1 := '';
                                DatumOdMinZamjena1 := 0D;
                                MjeraciZamjena1 := '';

                                CalcDuplicate.reset;
                                CalcDuplicate.CopyFilters(CJL);
                                CalcDuplicate.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                                CalcDuplicate.SetFilter(Code, '%1', cjl.Code);
                                CalcDuplicate.SetFilter("Customer No.", '%1', CJl."Customer No.");

                                CalcDuplicate.SetFilter("Document No. Posting", '%1', cjl."Document No. Posting");
                                Brojaczamjena := CalcDuplicate.Count;
                                if Brojaczamjena <= 1 then begin
                                    FirstString += Separator;
                                end
                                else begin
                                    if Brojaczamjena > 1 then begin
                                        CalcDuplicate.reset;
                                        CalcDuplicate.CopyFilters(CJL);
                                        CalcDuplicate.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                                        CalcDuplicate.SetFilter(Code, '%1', cjl.Code);
                                        CalcDuplicate.SetFilter("Customer No.", '%1', CJl."Customer No.");

                                        CalcDuplicate.SetFilter("Document No. Posting", '%1', cjl."Document No. Posting");

                                        CalcDuplicate.SetFilter("Document No. Posting", '%1', CJL."Document No. Posting");
                                        CalcDuplicate.setfilter("Old Gauge", '%1', true);
                                        CalcDuplicate.SetCurrentKey("Reading Date From");
                                        CalcDuplicate.Ascending(true);
                                        // CalcDuplicate.SetFilter("New Gauge", '%1', true);
                                        if CalcDuplicate.FindSet() then
                                            repeat


                                                if (CalcDuplicate."Old Gauge" = true) and (CalcDuplicate."Filter by Old RMS" = true) then begin
                                                    if StrPos(NacinOcitanjaZamjena, format(CalcDuplicate."Source Data")) = 0 then
                                                        NacinOcitanjaZamjena += format(CalcDuplicate."Source Data") + '/';

                                                    if StrPos(MjeraciZamjena, format(CalcDuplicate."Serial Number")) = 0 then
                                                        MjeraciZamjena += format(CalcDuplicate."Serial Number") + '/';

                                                    OldZamjena += format(CalcDuplicate."Old Value") + '';

                                                    if (CalcDuplicate."New Value" = 0) and ((CalcDuplicate."Source Data" = CalcDuplicate."Source Data"::Unobvious) or (CalcDuplicate."Source Data" = CalcDuplicate."Source Data"::Unknown)) then
                                                        NewZamjena += format('−')
                                                    else
                                                        NewZamjena += format(CalcDuplicate."New Value");

                                                    if CalcDuplicate.Difference < 0 then
                                                        RazlikaZamjena += format('−')
                                                    else
                                                        RazlikaZamjena += Format(CalcDuplicate.Difference);


                                                    if CalcDuplicate."Reading Date From" <> 0D then
                                                        DatumiSpojeniOd += copystr(format(format(CalcDuplicate."Reading Date From", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                                    else
                                                        DatumiSpojeniOd += '';

                                                    if CalcDuplicate."Reading Date To" <> 0D then
                                                        DatumiSpojeniDo += copystr(format(format(CalcDuplicate."Reading Date TO", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                                    else
                                                        DatumiSpojeniDo += '';

                                                end;

                                                //novi mjerač

                                                CalcDuplicate2.reset;
                                                CalcDuplicate2.copyfilters(CalcDuplicate);
                                                CalcDuplicate2.setfilter("New Gauge", '%1', true);
                                                if CalcDuplicate2.findfirst then begin
                                                    if (CalcDuplicate2."New Gauge" = true) and (CalcDuplicate2."Filter by Old RMS" = true) then begin

                                                        if StrPos(NacinOcitanjaZamjena1, format(CalcDuplicate2."Source Data")) = 0 then
                                                            NacinOcitanjaZamjena1 += format(CalcDuplicate2."Source Data") + '/';

                                                        if StrPos(MjeraciZamjena1, format(CalcDuplicate2."Serial Number")) = 0 then
                                                            MjeraciZamjena1 += format(CalcDuplicate2."Serial Number") + '/';

                                                        OldZamjena1 += format(CalcDuplicate2."Old Value") + '';

                                                        if (CalcDuplicate2."New Value" = 0) and ((CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unobvious) or (CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unknown))
                                                   then
                                                            NewZamjena1 += format('−')
                                                        else
                                                            NewZamjena1 += format(CalcDuplicate2."New Value");

                                                        if CalcDuplicate2.Difference < 0 then
                                                            RazlikaZamjena1 += format('−')
                                                        else
                                                            RazlikaZamjena1 += Format(CalcDuplicate2.Difference);


                                                        if CalcDuplicate2."Reading Date From" <> 0D then
                                                            DatumiSpojeniOd1 += copystr(format(format(CalcDuplicate2."Reading Date From", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                                        else
                                                            DatumiSpojeniOd1 += '';

                                                        if CalcDuplicate2."Reading Date To" <> 0D then
                                                            DatumiSpojeniDo1 += copystr(format(format(CalcDuplicate2."Reading Date TO", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                                        else
                                                            DatumiSpojeniDo1 += '';

                                                    end;
                                                    //end;
                                                    //kraj
                                                end;



                                            until CalcDuplicate.Next() = 0;






                                        if MjeraciZamjena <> '' then begin

                                            CalcDuplicate.reset;
                                            CalcDuplicate.CopyFilters(CJL);

                                            CalcDuplicate.SetFilter("Document No. Posting", '%1', CJL."Document No. Posting");
                                            CalcDuplicate.SetCurrentKey("Reading Date To");
                                            CalcDuplicate.Ascending(false);
                                            if CalcDuplicate.FindFirst() then
                                                DatumOdMaxZamjena := CalcDuplicate."Reading Date To";


                                            CalcDuplicate.reset;
                                            CalcDuplicate.CopyFilters(CJL);

                                            CalcDuplicate.SetFilter("Document No. Posting", '%1', CJL."Document No. Posting");
                                            CalcDuplicate.SetCurrentKey("Reading Date From");
                                            CalcDuplicate.Ascending(false);
                                            if CalcDuplicate.FindLast() then
                                                DatumOdMinZamjena := CalcDuplicate."Reading Date From";
                                        end;
                                    end;


                                    //kraj
                                end;

                                //
                                if (cjl."Old Gauge" = true) and (CJL."Filter by Old RMS" = true) then
                                    FirstString += format(DatumiSpojeniOd)
                                else
                                    FirstString += '';


                                FirstString += Separator;


                                if (cjl."Old Gauge" = true) and (CJL."Filter by Old RMS" = true) then
                                    FirstString += format(DatumiSpojeniOd1)
                                else
                                    FirstString += format(CJL."Reading Date From", 0, '<day,2>.<month,2>.<year4>');


                                FirstString += Separator;

                                CaccS.get;
                                ItemBasic.get(CaccS."Item No. 2");

                                FirstString += 'Sm3';//-- format(ItemBasic."Sales Unit of Measure");

                                FirstString += Separator;
                                if (cjl."Old Gauge" = true) and (CJL."Filter by Old RMS" = true) then begin
                                    FirstString += format(OldZamjena)
                                end
                                else begin
                                    FirstString += Separator;
                                    FirstString += format(CJL."Old Value");
                                end;

                                FirstString += Separator;

                                if (cjl."Old Gauge" = true) and (CJL."Filter by Old RMS" = true) then begin
                                    FirstString += format(DatumiSpojenido)

                                end
                                else begin
                                    FirstString += Separator;
                                    FirstString += format(CJL."Reading Date To", 0, '<day,2>.<month,2>.<year4>');
                                end;

                                FirstString += Separator;
                                FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");

                                FirstString += Separator;

                                if (cjl."Old Gauge" = true) and (CJL."Filter by Old RMS" = true) then begin
                                    FirstString += NewZamjena
                                end
                                else begin
                                    if CJL."New Value" = 0 then
                                        TextNewGauge := format('-')
                                    else
                                        TextNewGauge := format(CJL."New Value");
                                    FirstString += Separator;

                                    FirstString += format(TextNewGauge);
                                end;

                                FirstString += Separator;
                                FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");
                                FirstString += Separator;

                                /* if (cjl."Old Gauge" = true) and (CJL."Filter by Old RMS" = true) then begin
                                     FirstString += format(RazlikaZamjena);
                                 end
                                 else begin
                                     FirstString += Separator;
                                     if CJL.Difference < 0 then
                                         FirstString += format(0)
                                     else
                                         FirstString += Replacestring_T(format(Cjl.Difference), ',', '.');

                                 end;*/

                                SumDifference := 0;
                                CalcSum.Reset();
                                CalcSum.CopyFilters(CJL);
                                CalcSum.SetFilter("Customer No.", '%1', CJL."Customer No.");
                                CalcSum.SetFilter("Document No. Posting", '%1', CJL."Document No. Posting");
                                CalcSum.SetFilter(Difference, '>=%1', 0);
                                if CalcSum.FindSet() then begin
                                    CalcSum.CalcSums(Difference);
                                    SumDifference := CalcSum.Difference;
                                end;

                                FirstString += Replacestring_T(format(SumDifference), ',', '.');

                                FirstString += Separator;
                                SumDifference := 0;
                                CalcSum.Reset();
                                CalcSum.CopyFilters(CJL);
                                CalcSum.SetFilter("Customer No.", '%1', CJL."Customer No.");
                                CalcSum.SetFilter("Document No. Posting", '%1', CJL."Document No. Posting");
                                CalcSum.SetFilter(Difference, '>=%1', 0);
                                if CalcSum.FindSet() then begin
                                    CalcSum.CalcSums(Difference);
                                    SumDifference := CalcSum.Difference;
                                end;

                                FirstString += Replacestring_T(format(SumDifference), ',', '.');



                                FirstString += Separator;
                                //   FirstString += format(Replacestring_T(format(CJL."CALORIFIC POWER COEFFICIENT"), ',', '.'));
                                PriceZero := '';

                                CalorficV := format(Replacestring_T(format(CJL."CALORIFIC POWER COEFFICIENT"), ',', '.') + PriceZero);
                                if StrLen(CalorficV) < 8 then begin
                                    for i := 1 to 8 - StrLen(CalorficV) do begin
                                        PriceZero += '0';
                                    end;
                                end;

                                FirstString += CalorficV + PriceZero;


                                FirstString += Separator;

                                FirstString += format(Replacestring_T(format(CJL.SM3), ',', '.'));
                                FirstString += Separator;
                                FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");
                                FirstString += Separator;
                                FirstString += format(Replacestring_T(format(CJL.sm3), ',', '.'));
                                FirstString += Separator;
                                // FirstString += format(Replacestring_T(format(CJL."Sales Unit Price"), ',', '.'));

                                PriceZero := '';

                                if StrLen(format(format(Replacestring_T(format(cjl."Sales Unit Price"), ',', '.')))) < 5 then begin
                                    for i := 1 to 5 - StrLen(format(format(Replacestring_T(format(cjl."Sales Unit Price"), ',', '.'))))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                    FirstString += format(Replacestring_T(format(cjl."Sales Unit Price"), ',', '.') + PriceZero) + '';

                                end
                                else begin
                                    FirstString += format(Replacestring_T(format(CJL."Sales Unit Price"), ',', '.')) + '';
                                end;


                                PriceZero := '';

                                if (ROUND(CJL."GAS - amount") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                end else begin
                                    for i := 1 to 2 - StrLen(format(CJL."GAS - amount"))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                end;

                                if (ROUND(CJL."GAS - amount") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';


                                FirstString += Separator;
                                FirstString += format(Replacestring_T(format(CJL."GAS - amount"), ',', '.') + PriceZero);

                                FirstString += Separator;
                                if CJL."Basis maintenance" <> 0 then
                                    FirstString += format('komad')
                                else
                                    FirstString += format('komad');

                                FirstString += Separator;
                                CL2.Reset();
                                CL2.SetFilter("Customer No.", '%1', "Customer No.");
                                CL2.SetFilter(Code, '%1', "Code");
                                cl2.SetFilter("Basis maintenance", '<>%1', 0);
                                CL2.setfilter("Month Of GAS Calculation", '%1', "Month Of GAS Calculation");
                                CL2.setfilter("Year Of GAS Calculation", '%1', "Year Of GAS Calculation");
                                if cl2.FindFirst() then begin
                                    FirstString += format(format(cl2.count));
                                end
                                else begin
                                    FirstString += format('0');
                                end;


                                FirstString += Separator;
                                if CJL."Basis maintenance" <> 0 then
                                    FirstString += format(CJL."Basis maintenance", 0, '<Precision,2:2><Standard Format,2>')
                                else
                                    FirstString += format('0.00');

                                FirstString += Separator;
                                if CJL."Basis maintenance" <> 0 then
                                    FirstString += format(CJL."Basis maintenance", 0, '<Precision,2:2><Standard Format,2>')
                                else
                                    FirstString += format('0.00');




                                FirstString += Separator;



                                PriceZero := '';

                                if (ROUND(CJL."Maintenance VAT" + CJL."GAS - VAT") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                end else begin
                                    for i := 1 to 2 - StrLen(format(CJL."Maintenance VAT" + CJL."GAS - VAT"))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                end;

                                if (ROUND(CJL."Maintenance VAT" + CJL."GAS - VAT") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';



                                FirstString += format(Replacestring_T(format(CJL."GAS - VAT" + cjl."Maintenance VAT"), ',', '.') + PriceZero);

                                FirstString += Separator;


                                PriceZero := '';

                                if (ROUND(CJL."Maintenance VAT") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                end else begin
                                    for i := 1 to 2 - StrLen(format(CJL."Maintenance VAT"))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                end;

                                if (ROUND(CJL."Maintenance VAT") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';

                                FirstString += format(Replacestring_T(format(cjl."Maintenance VAT"), ',', '.') + PriceZero);

                                FirstString += Separator;
                                FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");
                                FirstString += Separator;
                                /*    if cjl."War Calculation (LVT)" = 0 then
                                        FirstString += '0.00'
                                    else*/



                                PriceZero := '';

                                if (ROUND(cjl."Q. total Sum - War") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                end else begin
                                    for i := 1 to 2 - StrLen(format(cjl."Q. total Sum - War"))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                end;

                                if (ROUND(cjl."Q. total Sum - War") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';

                                FirstString += format(Replacestring_T(format(cjl."Q. total Sum - War"), ',', '.') + PriceZero);


                                FirstString += Separator;

                                if CJL."War Calculation" <> 0 then begin
                                    //  FirstString += format(cjl."Currency Code");

                                    CER.Reset();
                                    CER.SetFilter("Currency Code", '%1', cjl."Currency Code");

                                    ChGet2.get(CJL.Code);

                                    if (ChGet2."Month Of GAS Calculation" = cjl."Month Of GAS Calculation") and (ChGet2."Year Of GAS Calculation" = cjl."Year Of GAS Calculation") then
                                        CER.SetFilter("Starting Date", '<=%1', cjl."Calculation Date To")
                                    else
                                        CER.SetFilter("Starting Date", '<=%1', cjl."Reading Date To");

                                    CER.SetCurrentKey("Starting Date");
                                    CER.Ascending;
                                    if CER.FindLast() then begin
                                        PriceZero := '';

                                        RelationF := format(Replacestring_T(format(CER."Relational Exch. Rate Amount"), ',', '.') + PriceZero);
                                        if StrLen(RelationF) < 9 then begin
                                            for i := 1 to 9 - StrLen(RelationF) do begin
                                                PriceZero += '0';
                                            end;
                                        end;

                                        FirstString += RelationF + PriceZero;
                                    end;

                                end
                                else begin
                                    FirstString += format('');
                                end;
                                FirstString += Separator;
                                //    FirstString += format(CJL."War Calculation (LVT)");


                                PriceZero := '';

                                if (ROUND(CJL."War Calculation (LVT)") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                end else begin
                                    for i := 1 to 2 - StrLen(format(round(CJL."War Calculation (LVT)", 0.01, '=')))
                                    do begin
                                        PriceZero += '0';

                                    end;
                                end;

                                if (ROUND(CJL."War Calculation (LVT)") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';

                                FirstString += format(Replacestring_T(format(round(CJL."War Calculation (LVT)", 0.01, '=')), ',', '.') + PriceZero);



                                FirstString += Separator;

                                PriceZero := '';

                                decpart := FORMAT(ROUND(cjl.Total) MOD 1 * 100);





                                if StrLen(decpart) < 2 then begin


                                    if (ROUND(cjl.Total) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                                    end
                                    else begin

                                        for i := 1 to 2 - StrLen(decpart)
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(cjl.Total) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';


                                    if cjl.Total = 0 then
                                        FirstString += '0.00'
                                    else
                                        FirstString += format(Replacestring_T(format(cjl.Total), ',', '.') + PriceZero);

                                end
                                else begin
                                    if cjl.Total = 0 then
                                        FirstString += '0.00'
                                    else
                                        FirstString += format(Replacestring_T(format(CJL.Total), ',', '.'));
                                end;


                                //FirstString += format(CJL.Total);

                                FirstString += Separator;



                                //   if (SaldoDio <> 0) or (PretplDio <> 0) then
                                FirstString += 'Uplate obuhvaćene do ' + FORMAT(CJL."Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                                // else
                                //   FirstString += '';
                                FirstString += Separator;





                                if (SaldoDio <> 0) then begin


                                    PriceZero := '';

                                    if SaldoDio <> 0 then begin
                                        decpart := FORMAT(ROUND(SaldoDio) MOD 1 * 100);
                                        if StrLen(format(SaldoDio)) < 2 then begin

                                            if (ROUND(SaldoDio) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                                            end

                                            else begin
                                                for i := 1 to 2 - StrLen(format(SaldoDio))
                                                do begin
                                                    PriceZero += '0';

                                                end;
                                            end;
                                        end;


                                        if (ROUND(SaldoDio) MOD 1 * 100) = 0 then
                                            PriceZero := '.00';

                                    end;

                                    FirstString += 'Dugovanje ' + format(Replacestring_T(format(SaldoDio), ',', '.') + PriceZero);

                                end
                                else begin

                                    if PretplDio <> 0 then begin
                                        PriceZero := '';
                                        decpart := FORMAT(ROUND(PretplDio) MOD 1 * 100);
                                        if StrLen(format(PretplDio)) < 2 then begin

                                            if (ROUND(PretplDio) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                                            end

                                            else begin
                                                for i := 1 to 2 - StrLen(format(PretplDio))
                                                do begin
                                                    PriceZero += '0';
                                                end;
                                            end;
                                            if (ROUND(PretplDio) MOD 1 * 100) = 0 then
                                                PriceZero := '.00';


                                        end;
                                    end;

                                    if (PretplDio <> 0) then
                                        FirstString += 'Preplata ' + format(Replacestring_T(format(PretplDio), ',', '.') + PriceZero)
                                    else
                                        FirstString += FORMAT('0.00');

                                end;

                                FirstString += Separator;





                                if (SaldoDio = 0) and (PretplDio = 0) then begin


                                    PriceZero := '';

                                    if (ROUND(RoundDecimal(CJL.Total)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(format(RoundDecimal(CJL.Total)))
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(RoundDecimal(CJL.Total)) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';

                                    FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(cjl.Total)), ',', '.') + PriceZero);
                                end
                                else begin


                                    if ((SaldoDio + Total) > 0) and (PretplDio = 0) then begin


                                        PriceZero := '';

                                        if (ROUND(RoundDecimal(SaldoDio + Total)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                        end else begin
                                            for i := 1 to 2 - StrLen(format(RoundDecimal(SaldoDio + Total)))
                                            do begin
                                                PriceZero += '0';

                                            end;
                                        end;

                                        if (ROUND(RoundDecimal(SaldoDio + Total)) MOD 1 * 100) = 0 then
                                            PriceZero := '.00';

                                        FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(SaldoDio + Total)), ',', '.') + PriceZero);
                                    end;

                                end;

                                if ((PretplDio - Total) > 0) then begin

                                    Rez := PretplDio - Total;


                                    PriceZero := '';

                                    if (ROUND(RoundDecimal(PretplDio - Total)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(format(RoundDecimal(PretplDio - Total)))
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(RoundDecimal(PretplDio - Total)) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';


                                    if rez > 0 then
                                        FirstString += 'Ukupna preplata ' + format(Replacestring_T((format(RoundDecimal(PretplDio - total))), ',', '.') + PriceZero)
                                    else
                                        FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(PretplDio - total)), ',', '.') + PriceZero);

                                end;

                                if ((PretplDio - Total) < 0) and (PretplDio > 0) then begin

                                    Rez := PretplDio - Total;


                                    PriceZero := '';

                                    if (ROUND(RoundDecimal(Total - PretplDio)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(format(RoundDecimal(Total - PretplDio)))
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(RoundDecimal(Total - PretplDio)) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';


                                    if rez > 0 then
                                        FirstString += 'Ukupna preplata ' + format(Replacestring_T((format(RoundDecimal(Total - PretplDio))), ',', '.') + PriceZero)
                                    else
                                        FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(Total - PretplDio)), ',', '.') + PriceZero);

                                end;






                                FirstString += Separator;

                                if (SaldoDio <= 1) and (PretplDio >= 0) then begin
                                    FirstString += 'Zahvaljujemo Vam se na uredno izmirenim obavezama.';

                                end;
                                if (SaldoDio > 1) then
                                    FirstString += 'Račun se smatra opomenom pred utuženje i prekid isporuke gasa.';

                                FirstString += Separator;

                                if (cjl."EF Activity" = '') and (cjl."Category Customer" = cjl."Category Customer"::Household)
                                then
                                    cjl."EF Activity" := 'Stambeni sektor';

                                if (cjl."Last Year Calculation" <> 0) then begin
                                    if cjl."Category Customer" = cjl."Category Customer"::Household then begin

                                        //ako je domaćinstvo

                                        DecimalV2 := format(Round(cjl."Last Year Calculation", 0.0001, '=') MOD 1 * 100);

                                        if Evaluate(DecimalV2E, DecimalV2) then begin

                                            if DecimalV2E > 50 then
                                                FirstString += 'Prosjek kategorije ' + cjl."EF Activity" + ' za ' + Mjesec[1] + ': ' + format(cjl."Average Calculation") +
                                                       ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format(round(cjl."Last Year Calculation", 1, '>')) + ' Sm3.'
                                            else
                                                FirstString += 'Prosjek kategorije ' + cjl."EF Activity" + ' ' + Mjesec[1] + ': ' + format(cjl."Average Calculation") +
                                                       ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format(round(cjl."Last Year Calculation", 1, '<')) + ' Sm3.'
                                        end;

                                        //kraj
                                    end
                                    else begin

                                        //ako nije domaćinstvo
                                        if (cjl."Last Year Calculation" = 0) and (cjl."Source Data" = cjl."Source Data"::Unobvious) or (cjl."Bill delivery" = CJl."Bill delivery"::Quarterly) then
                                            FirstString += ''
                                        else
                                            FirstString += 'Prosjek kategorije ' + cjl."EF Activity" + ' za ' + Mjesec[1] + ': ' + format(cjl."Average Calculation") +
                                            ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format(cjl."Last Year Calculation") + ' Sm3.';
                                    end;

                                end;



                                FirstString += Separator;
                                FirstString += 'Rok plaćanja: 15 dana od datuma izdavanja računa.';

                                FirstString += Separator;

                                BrojacSepparator := 0;
                                if cjl."Bill delivery" = cjl."Bill delivery"::Quarterly then begin
                                    FirstString += 'Računi za naknadu mjernog mjesta dostavljaju se kvartalno, u slučaju da se ne evidentira potrošnja prirodnog gasa.';
                                    FirstString += Separator;
                                    FirstString += 'Ukoliko želite mjesečnu dostavu računa za naknadu mjernog mjesta, molimo da nas obavijestite u pisanoj formi.';
                                    FirstString += Separator;
                                    BrojacSepparator += 2;
                                end
                                else begin
                                    // FirstString += Separator;
                                    // FirstString += Separator;
                                end;

                                if cjl.Unobvious = true then begin


                                    FirstString += 'S obzirom da nekoliko mjeseci nismo mogli očitati vaše mjerilo protoka gasa,';
                                    FirstString += Separator;
                                    BrojacSepparator += 1;

                                    FirstString += 'nakon izvršenog očitanja urađena je raspodjela potrošnje gasa po mjesecima.';
                                    FirstString += Separator;
                                    BrojacSepparator += 1;
                                end
                                else begin
                                    CharEnter := 10;
                                    if cjl."War Calculation (LVT)" <> 0 then begin

                                        if cjl."Calculation Date To" = 0D then begin
                                            CHGeer.Reset();
                                            CHGeer.SetFilter(Code, '%1', cjl.Code);
                                            if CHGeer.FindFirst() then
                                                CalcD := CHGeer."Calculation Date To"
                                        end
                                        else begin
                                            CalcD := cjl."Calculation Date To";
                                        end;

                                        WarSetup.Reset();
                                        WarSetup.SetFilter("Customer Category", '%1', cjl."Category Customer");
                                        WarSetup.SetFilter(Month, '%1', Date2DMY(cjl."Calculation Date To", 2));
                                        if WarSetup.findfirst then begin


                                            if WarSetup.Totaling = '1..4' then
                                                FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period janur - april ' + format(Date2DMY(cjl."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                                            if WarSetup.Totaling = '5..10' then
                                                FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period maj - oktobar ' + format(Date2DMY(cjl."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);




                                            if WarSetup.Totaling = '11..12' then
                                                FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period novembar - decembar ' + format(Date2DMY(cjl."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                                        end;
                                    end
                                    else begin

                                        FirstString += 'Podsjećamo Vas da ste dužni da nas obavijestite o svim promjenama matičnih podataka.';
                                    end;
                                    FirstString += Separator;
                                    BrojacSepparator += 1;
                                    FirstString += Separator;
                                    BrojacSepparator += 1;

                                end;

                                if cjl."Bill delivery" = cjl."Bill delivery"::Quarterly then begin
                                    FirstString += Separator;
                                    FirstString += Separator;
                                end;
                                // end;

                                if cjl."Source Data" = cjl."Source Data"::Unobvious then begin
                                    CharEnter := 10;
                                    if cjl."War Calculation (LVT)" <> 0 then begin

                                        if cjl."Calculation Date To" = 0D then begin
                                            CHGeer.Reset();
                                            CHGeer.SetFilter(Code, '%1', cjl.Code);
                                            if CHGeer.FindFirst() then
                                                CalcD := CHGeer."Calculation Date To"
                                        end
                                        else begin
                                            CalcD := cjl."Calculation Date To";
                                        end;

                                        WarSetup.Reset();
                                        WarSetup.SetFilter("Customer Category", '%1', cjl."Category Customer");
                                        WarSetup.SetFilter(Month, '%1', Date2DMY(cjl."Calculation Date To", 2));
                                        if WarSetup.findfirst then begin


                                            if WarSetup.Totaling = '1..4' then
                                                FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period janur - april ' + format(Date2DMY(cjl."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                                            if WarSetup.Totaling = '5..10' then
                                                FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period maj - oktobar ' + format(Date2DMY(cjl."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);




                                            if WarSetup.Totaling = '11..12' then
                                                FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period novembar - decembar ' + format(Date2DMY(cjl."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                                        end;
                                    end
                                    else begin

                                        FirstString += 'Podsjećamo Vas da ste dužni da nas obavijestite o svim promjenama matičnih podataka.';
                                    end;

                                    FirstString += Separator;
                                    FirstString += Separator;
                                end;


                                FirstString += '';
                                FirstString += Separator;

                                EclCustomer.Reset();
                                EclCustomer.SetFilter("Customer No.", '%1', cjl."Customer No.");
                                EclCustomer.SetFilter("Starting Date", '<=%1', cjl."Calculation Date To");
                                EclCustomer.SetCurrentKey("Starting Date");
                                EclCustomer.Ascending;
                                if EclCustomer.FindLast() then begin

                                    if (EclCustomer."Ending Date" = 0D) or (EclCustomer."Ending Date" >= cjl."Calculation Date To") then
                                        FirstString += ''
                                    else
                                        FirstString += 'Molimo da se obratite u jednu od naših poslovnica radi potpisivanja ugovora.';

                                end
                                else begin
                                    FirstString += 'Molimo da se obratite u jednu od naših poslovnica radi potpisivanja ugovora.';
                                end;

                                FirstString += Separator;


                                FirstString += Format(cjl."Reading Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format(cjl."Reading Date To", 0, '<day,2>.<month,2>.<year4>');

                                FirstString += Separator;

                                FirstString += cjl."Document No. Posting";
                                FirstString += Separator;

                                FirstString += cjl."Customer No." + ' ' + Replacestring_TName(CJL."Customer Name", ';', ',');
                                ;
                                FirstString += Separator;
                                FirstString += cjl."Address MM";
                                if cjl."Street No. Text" <> '' then
                                    FirstString += '\' + cjl."Street No. Text";
                                if cjl.Floor <> '' then
                                    FirstString += '\' + cjl.Floor;
                                FirstString += Separator;
                                FirstString += format(cjl."Calculation Date To", 0, '<day,2>.<month,2>.<year4>');


                                CompanyInfo.GET;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 1");
                                if banacc.FindFirst() then begin

                                    transaction1 := banacc."Bank Account No.";
                                    transaction1Name := banacc.Name;
                                end;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 2");
                                if banacc.FindFirst() then begin
                                    transaction2name := banacc.Name;
                                    transaction2 := banacc."Bank Account No.";
                                end;
                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 3");
                                if banacc.FindFirst() then begin
                                    transaction3Name := banacc.Name;
                                    transaction3 := banacc."Bank Account No.";
                                end;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 4");
                                if banacc.FindFirst() then begin
                                    transaction4Name := banacc.Name;
                                    transaction4 := banacc."Bank Account No.";
                                end;
                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 5");
                                if banacc.FindFirst() then begin

                                    transaction5Name := banacc.Name;
                                    transaction5 := banacc."Bank Account No.";
                                end;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 6");
                                if banacc.FindFirst() then begin

                                    transaction6Name := banacc.Name;
                                    transaction6 := banacc."Bank Account No.";
                                end;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 7");
                                if banacc.FindFirst() then begin

                                    transaction7Name := banacc.Name;
                                    transaction7 := banacc."Bank Account No.";
                                end;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 8");
                                if banacc.FindFirst() then begin

                                    transaction8Name := banacc.Name;
                                    transaction8 := banacc."Bank Account No.";
                                end;


                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 9");
                                if banacc.FindFirst() then begin

                                    transaction9Name := banacc.Name;
                                    transaction9 := banacc."Bank Account No.";
                                end;

                                banacc.Reset();
                                banacc.SetFilter("No.", CompanyInfo."Bank No. 10");
                                if banacc.FindFirst() then begin

                                    transaction10Name := banacc.Name;
                                    transaction10 := banacc."Bank Account No.";
                                end;
                                banacc.Reset();
                                banacc.SetFilter("No.", 'BANK13');
                                if banacc.FindFirst() then begin

                                    transaction11Name := banacc.Name;
                                    transaction11 := banacc."Bank Account No.";
                                end;

                                BrojacRandom += 1;

                                if BrojacRandom = 1 then begin
                                    FirstString += transaction1 + ' ' + transaction1Name;
                                end;
                                if BrojacRandom = 2 then begin
                                    FirstString += transaction2 + ' ' + transaction2Name;
                                end;

                                if BrojacRandom = 3 then begin
                                    FirstString += transaction3 + ' ' + transaction3Name;
                                end;

                                if BrojacRandom = 4 then begin
                                    FirstString += transaction4 + ' ' + transaction4Name;
                                end;
                                if BrojacRandom = 5 then begin
                                    FirstString += transaction5 + ' ' + transaction5Name;
                                end;
                                if BrojacRandom = 6 then begin
                                    FirstString += transaction6 + ' ' + transaction6Name;
                                end;
                                if BrojacRandom = 7 then begin
                                    FirstString += transaction7 + ' ' + transaction7Name;
                                end;
                                if BrojacRandom = 8 then begin
                                    FirstString += transaction8 + ' ' + transaction8Name;
                                end;
                                if BrojacRandom = 9 then begin
                                    FirstString += transaction9 + ' ' + transaction9Name;
                                end;
                                if BrojacRandom = 10 then begin
                                    FirstString += transaction10 + ' ' + transaction10Name;
                                end;
                                if BrojacRandom = 11 then begin
                                    FirstString += transaction11 + ' ' + transaction11Name;
                                end;
                                FirstString += Separator;

                                if BrojacRandom = 11 then
                                    BrojacRandom := 0;
                                FirstString += CompanyInfo."Name 2";
                                FirstString += Separator;

                                FirstString += CompanyInfo.Address;
                                FirstString += Separator;


                                FirstString += cjl."Post Code Customer D." + ' ' + UpperCase(cjl."Municipality Name Customer 2");
                                FirstString += Separator;
                                // if cjl."Document No. Posting" <> '' then
                                //   BarKod := cjl."Customer No." + copystr(cjl."Document No. Posting", 4, StrLen(cjl."Document No. Posting"));

                                barCodeZero := '';
                                barCodeRez := '';
                                BrojacI := 0;
                                barCode1 := cjl."Customer No.";
                                if cjl."Document No. Posting" <> '' then
                                    barCode2 := copystr(cjl."Document No. Posting", 4, StrLen(cjl."Document No. Posting"))
                                else
                                    barCode2 := '';
                                DUzinaUit := StrLen((cjl."Customer No."));

                                if StrLen((cjl."Customer No.")) < 6 then begin

                                    for BrojacI := 1 to 6 - strlen(cjl."Customer No.") do begin
                                        barCodeZero += '0';

                                    end;

                                end;

                                barCodeRez := barCodeZero + barCode1;
                                barCodeZero := '';
                                BrojacI := 0;
                                if StrLen(format(barCode2)) < 9 then begin

                                    for BrojacI := 1 to 9 - strlen(barCode2) do begin
                                        barCodeZero += '0';

                                    end;

                                end;


                                barCodeRez += barCodeZero + barCode2;


                                FirstString += '*' + barCodeRez + '*';
                                FirstString += Separator;


                                FirstString += '*' + cjl."Document No. Posting" + '*';
                                FirstString += Separator;

                                "VećUbaceno" := False;
                                if (SaldoDio = 0) and (PretplDio = 0) then begin


                                    PriceZero := '';

                                    if (ROUND(CJL.Total) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(format(CJL.Total))
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(RoundDecimal(CJL.Total)) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';

                                    if cjl.Total = 0 then begin
                                        FirstString += '';
                                    end

                                    else begin
                                        FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(cjl.Total)), ',', '.') + PriceZero) + ' KM';
                                        "VećUbaceno" := true;
                                    end;
                                end
                                else begin
                                    if (SaldoDio <> 0) and (PretplDio = 0) then begin

                                        PriceZero := '';

                                        if (ROUND(SaldoDio + Total) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                        end else begin
                                            for i := 1 to 2 - StrLen(format(SaldoDio + Total))
                                            do begin
                                                PriceZero += '0';

                                            end;
                                        end;

                                        if (ROUND(RoundDecimal(SaldoDio + Total)) MOD 1 * 100) = 0 then
                                            PriceZero := '.00';
                                        if "VećUbaceno" = False then begin
                                            FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(SaldoDio + Total)), ',', '.') + PriceZero) + ' KM';
                                            "VećUbaceno" := true;
                                        end;
                                    end;

                                end;

                                if (PretplDio <> 0) and ((PretplDio - Total) > 0) then begin

                                    Rez := PretplDio - Total;


                                    PriceZero := '';

                                    if (ROUND(RoundDecimal(PretplDio - Total)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(format(RoundDecimal(PretplDio - Total)))
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(RoundDecimal(PretplDio - Total)) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';
                                    if "VećUbaceno" = False then begin
                                        if rez > 0 then begin
                                            FirstString += '';
                                        end
                                        else begin
                                            FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(PretplDio - total)), ',', '.') + PriceZero) + ' KM';
                                            VećUbaceno := true;
                                        end;
                                    end;
                                end;

                                if (PretplDio <> 0) and ((PretplDio - Total) < 0) then begin

                                    Rez := PretplDio - Total;


                                    PriceZero := '';

                                    if (ROUND(RoundDecimal(Total - PretplDio)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(format(RoundDecimal(Total - PretplDio)))
                                        do begin
                                            PriceZero += '0';

                                        end;
                                    end;

                                    if (ROUND(RoundDecimal(Total - PretplDio)) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';
                                    if "VećUbaceno" = False then begin
                                        if rez > 0 then begin
                                            FirstString += '';
                                        end
                                        else begin
                                            FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(Total - PretplDio)), ',', '.') + PriceZero) + ' KM';
                                            VećUbaceno := true;
                                        end;
                                    end;
                                end;


                                FirstString += Separator;


                                /*   if (SaldoDio <> 0) then begin
                                       FirstString += 'Ukupan dug ' + format(Replacestring_T(format(SaldoDio + Total), ',', '.')) + ' KM';
                                   end
                                   else begin
                                       FirstString := '';
                                   end;
                                   FirstString += Separator;*/


                                FirstString += cjl."Address 2" + '.';
                                if cjl."Street No.2 Text" <> '' then
                                    FirstString += ' ' + cjl."Street No.2 Text";

                                FirstString += Separator;







                                ///transakcijski rač




                                OutStr.WRITETEXT(FirstString);

                                OutStr.WRITETEXT(); // This command is to move to next line

                                FirstString := '';

                                SaldoDio += Total;


                                if PretplDio - Total > 0 then begin

                                    cjl."Customer Balance" := 0;
                                    cjl."Customer Prepayment" := PretplDio - Total;

                                end
                                else begin

                                    cjl."Customer Prepayment" := 0;
                                    if PretplDio > 0 then begin
                                        CJL."Customer Balance" := (total - PretplDio) + SaldoDio;

                                    end
                                    else begin

                                        CJL."Customer Balance" := SaldoDio + PretplDio;
                                    end;
                                end;

                                //provjeriti šta ako je bila pretplata
                                cjl.modify;

                            //kraj


                            until cjl.Next() = 0;




                    end;
                end
                else begin



                    //ovdje mjesec

                    if Date2DMY("Calculation Date To", 2) = 1 then
                        Mjesec[1] := 'Januar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 2 then
                        Mjesec[1] := 'Februar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 3 then
                        Mjesec[1] := 'Mart' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 4 then
                        Mjesec[1] := 'April' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 5 then
                        Mjesec[1] := 'Maj' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 6 then
                        Mjesec[1] := 'Juni' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 7 then
                        Mjesec[1] := 'Juli' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 8 then
                        Mjesec[1] := 'Avgust' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 9 then
                        Mjesec[1] := 'Septembar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 10 then
                        Mjesec[1] := 'Oktobar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 11 then
                        Mjesec[1] := 'Novembar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));
                    if Date2DMY("Calculation Date To", 2) = 12 then
                        Mjesec[1] := 'Decembar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3));


                    if Date2DMY("Calculation Date To", 2) = 1 then
                        Mjesec_1[1] := 'Januar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 2 then
                        Mjesec_1[1] := 'Februar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 3 then
                        Mjesec_1[1] := 'Mart' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 4 then
                        Mjesec_1[1] := 'April' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 5 then
                        Mjesec_1[1] := 'Maj' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 6 then
                        Mjesec_1[1] := 'Juni' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 7 then
                        Mjesec_1[1] := 'Juli' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 8 then
                        Mjesec_1[1] := 'Avgust' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 9 then
                        Mjesec_1[1] := 'Septembar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 10 then
                        Mjesec_1[1] := 'Oktobar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 11 then
                        Mjesec_1[1] := 'Novembar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);
                    if Date2DMY("Calculation Date To", 2) = 12 then
                        Mjesec_1[1] := 'Decembar' + ' ' + FORMAT(DATE2DMY("Calculation Date To", 3) - 1);

                    FirstString := '';
                    if "New Gauge" = true then
                        CurrReport.Skip();
                    FirstString += 'H1';
                    FirstString += Separator;
                    //naziv kupca
                    FirstString += Replacestring_TName("Customer Name", ';', ',');
                    ;
                    FirstString += Separator;

                    CalcSum.Reset();
                    CalcSum.CopyFilters(cjl);
                    CalcSum.SetFilter("Customer No.", '%1', "Customer No.");
                    CalcSum.SetFilter("Document No. Posting", '%1', "Document No. Posting");
                    if CalcSum.FindFirst() then begin
                        CalcSum.CalcSums("GAS - part", SM3, "Basis maintenance", "GAS - amount", "GAS - VAT", "Maintenance VAT", "War Calculation (LVT)", Difference, Total);

                        SM3 := CalcSum.SM3;
                        "Basis maintenance" := CalcSum."Basis maintenance";
                        "GAS - amount" := CalcSum."GAS - amount";
                        "War Calculation (LVT)" := CalcSum."War Calculation (LVT)";
                        "GAS - part" := CalcSum."GAS - part";
                        "GAS - VAT" := CalcSum."GAS - VAT";
                        "Maintenance VAT" := CalcSum."Maintenance VAT";
                        Total := CalcSum.total;

                    end;


                    FirstString += "Address MM";
                    if "Street No. Text" <> '' then
                        FirstString += '\' + "Street No. Text";
                    if Floor <> '' then
                        FirstString += '\' + Floor;

                    if "Apartment No. Customer" <> '' then
                        FirstString += '\' + "Apartment No. Customer";
                    FirstString += Separator;

                    //  FirstString += "Post Code MM" + ' ' + "City MM";
                    CompanyInf.get;
                    FirstString += CompanyInf."Post Code" + ' ' + CompanyInf.City;
                    FirstString += Separator;


                    if "Document No. Posting" = '' then begin
                        CustT.Reset();
                        CustT.SetFilter("Bill Category", '%1', "Category Customer");
                        if CustT.FindFirst() then begin

                            NoSeriesMgt.InitSeries(CustT."Posting No. Series Bill", '', 0D, "Document No. Posting", Noseries);
                            DataItem2.modify;
                        end;
                        FirstString += "Document No. Posting";
                        FirstString += Separator;
                    end
                    else begin
                        FirstString += "Document No. Posting";
                        FirstString += Separator;

                    end;

                    FirstString += "Customer No.";
                    FirstString += Separator;

                    Brojaczamjena := 0;
                    MjeraciZamjena := '';
                    MjeraciZamjena1 := '';

                    TextIzvora := '';
                    CalcDuplicate.reset;
                    CalcDuplicate.CopyFilters(DataItem2);
                    CalcDuplicate.SetFilter("Measuring Point Code", '%1', DataItem2."Measuring Point Code");
                    CalcDuplicate.SetFilter(Code, '%1', DataItem2.Code);
                    CalcDuplicate.SetFilter("Customer No.", '%1', DataItem2."Customer No.");

                    CalcDuplicate.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                    CalcDuplicate.SetCurrentKey("Reading Date From");
                    CalcDuplicate.Ascending(true);
                    // CalcDuplicate.SetFilter("New Gauge", '%1', true);
                    if CalcDuplicate.FindSet then
                        repeat
                            Brojaczamjena += 1;
                            MjeraciZamjena += CalcDuplicate."Serial Number" + '/';
                            if CalcDuplicate."Old Gauge" = true then
                                TextIzvora += 'Zamjena mjerača/'
                            else
                                TextIzvora += format(CalcDuplicate."Source Data");
                        until CalcDuplicate.Next() = 0;
                    if Brojaczamjena > 1 then begin MjeraciZamjena := CopyStr(MjeraciZamjena, 1, strlen(MjeraciZamjena) - 1) end;

                    if Brojaczamjena <= 1 then
                        FirstString += "Serial Number"
                    else
                        FirstString += MjeraciZamjena;


                    //FirstString += "Serial Number";
                    FirstString += Separator;

                    FirstString += format("Customer Stroke 2") + '/' + format("Customer string 2");
                    FirstString += Separator;

                    if "Source Data" = "Source Data"::Unknown then
                        "Source Data" := "Source Data"::Unobvious;
                    if Brojaczamjena > 1 then
                        FirstString += CopyStr(TextIzvora, 1, StrLen(TextIzvora))
                    else
                        FirstString += Format("Source Data");
                    FirstString += Separator;


                    CompanyInf.get;
                    FirstString += Format(CompanyInf.City);
                    FirstString += Separator;
                    if "Filter by Old RMS" = true then
                        FirstString += Format("Calculation Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>')

                    else
                        FirstString += Format("Reading Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format("Reading Date To", 0, '<day,2>.<month,2>.<year4>');



                    FirstString += Separator;
                    if "Filter by Old RMS" = true
                    then
                        FirstString += format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>')

                    else
                        FirstString += format("Reading Date To", 0, '<day,2>.<month,2>.<year4>');

                    FirstString += Separator;
                    FirstString += format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>');

                    FirstString += Separator;
                    //      FirstString += format(Replacestring_T(format("Purchase Unit Price"), ',', '.')) + ' KM';

                    PriceZero := '';

                    if StrLen(format(format(Replacestring_T(format("Purchase Unit Price"), ',', '.')))) < 5 then begin
                        for i := 1 to 5 - StrLen(format(format(Replacestring_T(format("Purchase Unit Price"), ',', '.'))))
                        do begin
                            PriceZero += '0';

                        end;
                        FirstString += format(Replacestring_T(format("Purchase Unit Price"), ',', '.') + PriceZero) + ' KM';

                    end
                    else begin
                        FirstString += format(Replacestring_T(format("Purchase Unit Price"), ',', '.')) + ' KM';
                    end;


                    FirstString += Separator;
                    // FirstString += format(Replacestring_T(format("Distribution Unit Price"), ',', '.')) + ' KM';

                    PriceZero := '';

                    if StrLen(format(format(Replacestring_T(format("Distribution Unit Price"), ',', '.')))) < 5 then begin
                        for i := 1 to 5 - StrLen(format(format(Replacestring_T(format("Distribution Unit Price"), ',', '.'))))
                        do begin
                            PriceZero += '0';

                        end;
                        FirstString += format(Replacestring_T(format("Distribution Unit Price"), ',', '.') + PriceZero) + ' KM';

                    end
                    else begin
                        FirstString += format(Replacestring_T(format("Distribution Unit Price"), ',', '.')) + ' KM';
                    end;


                    FirstString += Separator;

                    //  FirstString += format(Replacestring_T(format("Sales Unit Price"), ',', '.')) + ' KM';
                    PriceZero := '';

                    if StrLen(format(format(Replacestring_T(format("Sales Unit Price"), ',', '.')))) < 5 then begin
                        for i := 1 to 5 - StrLen(format(format(Replacestring_T(format("Sales Unit Price"), ',', '.'))))
                        do begin
                            PriceZero += '0';

                        end;
                        FirstString += format(Replacestring_T(format("Sales Unit Price"), ',', '.') + PriceZero) + ' KM';

                    end
                    else begin
                        FirstString += format(Replacestring_T(format("Sales Unit Price"), ',', '.')) + ' KM';
                    end;


                    FirstString += Separator;

                    //djemina ovdje dodati nove zamjene

                    NacinOcitanjaZamjena := '';
                    DatumOdMaxZamjena := 0D;
                    RazlikaZamjena := '';
                    NewZamjena := '';
                    OldZamjena := '';
                    DatumiSpojeniOd := '';
                    DatumiSpojenido := '';
                    DatumOdMinZamjena := 0D;
                    MjeraciZamjena := '';

                    NacinOcitanjaZamjena1 := '';
                    DatumOdMaxZamjena1 := 0D;
                    RazlikaZamjena1 := '';
                    NewZamjena1 := '';
                    OldZamjena1 := '';
                    DatumiSpojeniOd1 := '';
                    DatumiSpojenido1 := '';
                    DatumOdMinZamjena1 := 0D;
                    MjeraciZamjena1 := '';

                    CalcDuplicate.reset;
                    CalcDuplicate.CopyFilters(DataItem2);
                    CalcDuplicate.SetFilter("Measuring Point Code", '%1', DataItem2."Measuring Point Code");
                    CalcDuplicate.SetFilter(Code, '%1', Code);
                    CalcDuplicate.SetFilter("Customer No.", '%1', "Customer No.");

                    CalcDuplicate.SetFilter("Document No. Posting", '%1', "Document No. Posting");
                    Brojaczamjena := CalcDuplicate.Count;
                    if Brojaczamjena <= 1 then begin

                        //  FirstString += Separator;

                    end
                    else begin

                        if Brojaczamjena > 1 then begin



                            CalcDuplicate.reset;
                            CalcDuplicate.CopyFilters(DataItem2);
                            CalcDuplicate.SetFilter("Measuring Point Code", '%1', "Measuring Point Code");
                            CalcDuplicate.SetFilter(Code, '%1', Code);
                            CalcDuplicate.SetFilter("Customer No.", '%1', "Customer No.");

                            CalcDuplicate.SetFilter("Document No. Posting", '%1', "Document No. Posting");

                            CalcDuplicate.SetFilter("Document No. Posting", '%1', "Document No. Posting");
                            CalcDuplicate.setfilter("Old Gauge", '%1', true);
                            CalcDuplicate.SetCurrentKey("Reading Date From");
                            CalcDuplicate.Ascending(true);
                            // CalcDuplicate.SetFilter("New Gauge", '%1', true);
                            if CalcDuplicate.FindSet() then
                                repeat


                                    if (CalcDuplicate."Old Gauge" = true) and (CalcDuplicate."Filter by Old RMS" = true) then begin
                                        if StrPos(NacinOcitanjaZamjena, format(CalcDuplicate."Source Data")) = 0 then
                                            NacinOcitanjaZamjena += format(CalcDuplicate."Source Data") + '/';

                                        if StrPos(MjeraciZamjena, format(CalcDuplicate."Serial Number")) = 0 then
                                            MjeraciZamjena += format(CalcDuplicate."Serial Number") + '/';

                                        OldZamjena += format(CalcDuplicate."Old Value") + '';

                                        if (CalcDuplicate."New Value" = 0) and ((CalcDuplicate."Source Data" = CalcDuplicate."Source Data"::Unobvious) or (CalcDuplicate."Source Data" = CalcDuplicate."Source Data"::Unknown)) then
                                            NewZamjena += format('−')
                                        else
                                            NewZamjena += format(CalcDuplicate."New Value");

                                        if CalcDuplicate.Difference < 0 then
                                            RazlikaZamjena += format('−')
                                        else
                                            RazlikaZamjena += Format(CalcDuplicate.Difference);


                                        if CalcDuplicate."Reading Date From" <> 0D then
                                            DatumiSpojeniOd += copystr(format(format(CalcDuplicate."Reading Date From", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                        else
                                            DatumiSpojeniOd += '';

                                        if CalcDuplicate."Reading Date To" <> 0D then
                                            DatumiSpojeniDo += copystr(format(format(CalcDuplicate."Reading Date TO", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                        else
                                            DatumiSpojeniDo += '';

                                    end;


                                    CalcDuplicate2.reset;
                                    CalcDuplicate2.copyfilters(CalcDuplicate);
                                    CalcDuplicate2.setfilter("Old Gauge", '%1', false);
                                    CalcDuplicate2.setfilter("New Gauge", '%1', true);
                                    if CalcDuplicate2.findfirst then begin
                                        if (CalcDuplicate2."New Gauge" = true) and (CalcDuplicate2."Filter by Old RMS" = true) then begin

                                            if StrPos(NacinOcitanjaZamjena1, format(CalcDuplicate2."Source Data")) = 0 then
                                                NacinOcitanjaZamjena1 += format(CalcDuplicate2."Source Data") + '/';

                                            if StrPos(MjeraciZamjena1, format(CalcDuplicate2."Serial Number")) = 0 then
                                                MjeraciZamjena1 += format(CalcDuplicate2."Serial Number") + '/';

                                            OldZamjena1 += format(CalcDuplicate2."Old Value") + '';

                                            if (CalcDuplicate2."New Value" = 0) and ((CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unobvious) or (CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unknown))
                                       then
                                                NewZamjena1 += format('−')
                                            else
                                                NewZamjena1 += format(CalcDuplicate2."New Value");

                                            if CalcDuplicate2.Difference < 0 then
                                                RazlikaZamjena1 += format('−')
                                            else
                                                RazlikaZamjena1 += Format(CalcDuplicate2.Difference);


                                            if CalcDuplicate2."Reading Date From" <> 0D then
                                                DatumiSpojeniOd1 += copystr(format(format(CalcDuplicate2."Reading Date From", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                            else
                                                DatumiSpojeniOd1 += '';

                                            if CalcDuplicate2."Reading Date To" <> 0D then
                                                DatumiSpojeniDo1 += copystr(format(format(CalcDuplicate2."Reading Date TO", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + ''
                                            else
                                                DatumiSpojeniDo1 += '';

                                        end;
                                        //end;
                                    end;


                                until CalcDuplicate.Next() = 0;





                            //kraj

                            if MjeraciZamjena <> '' then begin

                                CalcDuplicate.reset;
                                CalcDuplicate.CopyFilters(DataItem2);

                                CalcDuplicate.SetFilter("Document No. Posting", '%1', "Document No. Posting");
                                CalcDuplicate.SetCurrentKey("Reading Date To");
                                CalcDuplicate.Ascending(false);
                                if CalcDuplicate.FindFirst() then
                                    DatumOdMaxZamjena := CalcDuplicate."Reading Date To";


                                CalcDuplicate.reset;
                                CalcDuplicate.CopyFilters(DataItem2);

                                CalcDuplicate.SetFilter("Document No. Posting", '%1', "Document No. Posting");
                                CalcDuplicate.SetCurrentKey("Reading Date From");
                                CalcDuplicate.Ascending(false);
                                if CalcDuplicate.FindLast() then
                                    DatumOdMinZamjena := CalcDuplicate."Reading Date From";
                            end;
                        end;

                    end;

                    //kraj

                    if ("Old Gauge" = true) and ("Filter by Old RMS" = true) then begin
                        FirstString += format(DatumiSpojeniOd);
                        FirstString += Separator;
                        FirstString += format(DatumiSpojeniOd1);//FirstString += Separator; 
                    end
                    else begin
                        FirstString += Separator;
                        FirstString += format("Reading Date From", 0, '<day,2>.<month,2>.<year4>');
                    end;

                    FirstString += Separator;
                    CaccS.get;
                    ItemBasic.get(CaccS."Item No. 2");
                    FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");

                    FirstString += Separator;
                    if "Filter by Old RMS" = false then
                        FirstString += Separator;

                    if ("Old Gauge" = true) and ("Filter by Old RMS" = true) then begin
                        FirstString += format(OldZamjena);
                        FirstString += Separator;
                        FirstString += format(OldZamjena1);
                    end
                    else begin
                        FirstString += format("Old Value");
                    end;

                    FirstString += Separator;

                    if ("Old Gauge" = true) and ("Filter by Old RMS" = true) then begin
                        FirstString += format(DatumiSpojenido);
                        FirstString += Separator;
                        FirstString += format(DatumiSpojenido1);

                    end else begin
                        FirstString += Separator;

                        FirstString += format("Reading Date To", 0, '<day,2>.<month,2>.<year4>');
                    end;
                    FirstString += Separator;
                    FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");

                    FirstString += Separator;

                    if ("Old Gauge" = true) and ("Filter by Old RMS" = true) then begin
                        FirstString += NewZamjena;
                        FirstString += Separator;
                        FirstString += NewZamjena1;
                    end
                    else begin
                        if ("New Value" = 0) and (("Source Data" = "Source Data"::Unobvious) or ("Source Data" = "Source Data"::Unknown)) then
                            TextNewGauge := format('-')
                        else
                            TextNewGauge := format("New Value");

                        FirstString += Separator;
                        FirstString += format(TextNewGauge);
                    end;

                    FirstString += Separator;
                    FirstString += 'Sm3';// format(ItemBasic."Sales Unit of Measure");
                    FirstString += Separator;

                    /*   if ("Old Gauge" = true) and ("Filter by Old RMS" = true) then begin
                           FirstString += RazlikaZamjena1
                       end
                       else begin
                           FirstString += Separator;
                           if Difference < 0 then
                               FirstString += format(0)
                           else
                               FirstString += Replacestring_T(format(Difference), ',', '.');

                       end;*/

                    SumDifference := 0;
                    CalcSum.Reset();
                    CalcSum.CopyFilters(DataItem2);
                    CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                    CalcSum.SetFilter(Difference, '>=%1', 0);
                    CalcSum.SetFilter("Old Gauge", '%1', true);
                    if CalcSum.FindSet() then begin
                        CalcSum.CalcSums(Difference);
                        SumDifference := CalcSum.Difference;
                    end;

                    if "Filter by Old RMS" = false
                     then begin
                        FirstString += '';
                    end

                    else begin
                        if SumDifference = 0 then
                            FirstString += '0'
                        else
                            FirstString += format(SumDifference);//ovdje djemina dodaj da je 0.00 
                    end;
                    FirstString += Separator;



                    if "Filter by Old RMS" = false then begin
                        SumDifference := 0;
                        CalcSum.Reset();
                        CalcSum.CopyFilters(DataItem2);
                        CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                        CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                        CalcSum.SetFilter(Difference, '>=%1', 0);
                        CalcSum.SetFilter("New Gauge", '%1', false);
                        if CalcSum.FindSet() then begin
                            CalcSum.CalcSums(Difference);
                            SumDifference := CalcSum.Difference;
                        end;
                        IF (SumDifference <= 0) and (("Source Data" = "Source Data"::Unobvious) or ("Source Data" = "Source Data"::Unknown)) then
                            FirstString += '-' else
                            FirstString += Replacestring_T(format(SumDifference), ',', '.');
                        FirstString += Separator;

                        SumDifference := 0;
                        CalcSum.Reset();
                        CalcSum.CopyFilters(DataItem2);
                        CalcSum.SetFilter("Old Gauge", '%1|%2', true, false);
                        CalcSum.SetFilter("New Gauge", '%1|%2', true, false);
                        CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                        CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                        CalcSum.SetFilter(Difference, '>=%1', 0);//CalcSum.SetFilter("New Gauge",'%1',true);
                        if CalcSum.FindSet() then begin
                            CalcSum.CalcSums(Difference);
                            SumDifference := CalcSum.Difference;
                        end;
                        IF (SumDifference <= 0) and (("Source Data" = "Source Data"::Unobvious) or ("Source Data" = CalcSum."Source Data"::Unknown)) then
                            FirstString += '-'
                        else
                            FirstString += Replacestring_T(format(SumDifference), ',', '.');
                        FirstString += Separator;

                    end;
                    if "Filter by Old RMS" = true then begin
                        SumDifference := 0;
                        CalcSum.Reset();
                        CalcSum.CopyFilters(DataItem2);
                        CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                        CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                        CalcSum.SetFilter(Difference, '>=%1', 0);
                        //   CalcSum.setfilter("Old Gauge", '%1', true);
                        CalcSum.setfilter("New Gauge", '%1', true);
                        if CalcSum.FindSet() then begin
                            CalcSum.CalcSums(Difference);
                            SumDifference := CalcSum.Difference;
                        end;

                        CalcSum.Reset();
                        CalcSum.CopyFilters(DataItem2);
                        CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                        CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                        CalcSum.setfilter("New Gauge", '%1', true);
                        if CalcSum.FindSet() then begin
                        end;

                        if (SumDifference <= 0) and ((CalcSum."Source Data" = CalcSum."Source Data"::Unobvious) or (CalcSum."Source Data" = CalcSum."Source Data"::Unknown)) then begin
                            FirstString += '-'
                        end
                        else begin
                            if SumDifference = 0 then
                                FirstString += '0'
                            else
                                FirstString += format(SumDifference);//ovdje djemina dodaj ako je 0
                        end;
                        FirstString += Separator;


                        CalcSum.Reset();
                        CalcSum.CopyFilters(DataItem2);
                        CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                        CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                        CalcSum.SetFilter("Old Gauge", '%1|%2', true, false);
                        CalcSum.SetFilter("New Gauge", '%1|%2', true, false);
                        CalcSum.SetFilter(Difference, '>=%1', 0);//CalcSum.SetFilter("New Gauge",'%1',true);
                        if CalcSum.FindSet() then begin
                            CalcSum.CalcSums(Difference);
                            SumDifference := CalcSum.Difference;
                        end;

                        if SumDifference = 0 then
                            FirstString += '0'
                        else
                            FirstString += format(SumDifference);//ovdje DJemina dodaj ako je 0
                        FirstString += Separator;
                    end;
                    //  FirstString += format(Replacestring_T(format("CALORIFIC POWER COEFFICIENT"), ',', '.'));
                    PriceZero := '';

                    PriceZero := '';

                    CalorficV := format(Replacestring_T(format("CALORIFIC POWER COEFFICIENT"), ',', '.') + PriceZero);
                    if StrLen(CalorficV) < 8 then begin
                        for i := 1 to 8 - StrLen(CalorficV) do begin
                            PriceZero += '0';
                        end;
                    end;

                    FirstString += CalorficV + PriceZero;

                    FirstString += Separator;

                    SumSm3 := 0;
                    SumMain := 0;
                    SumMainCount := 0;
                    SumGAS___amount := 0;
                    SUmTotal_without_VAT := 0;
                    SUmTotalVat := 0;
                    SumWar_Calculation__LVT_ := 0;
                    Difference := 0;
                    SumDifference := 0;


                    CalcSum.Reset();
                    CalcSum.CopyFilters(DataItem2);
                    CalcSum.SetFilter("Old Gauge", '%1|%2', true, false);
                    CalcSum.SetFilter("New Gauge", '%1|%2', true, false);
                    CalcSum.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    CalcSum.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                    if CalcSum.FindFirst() then begin
                        CalcSum.CalcSums("GAS - part", SM3, "Basis maintenance", "GAS - amount", "GAS - VAT", "Maintenance VAT", "War Calculation (LVT)", Difference);

                        SumSm3 := CalcSum.SM3;
                        SumMain := CalcSum."Basis maintenance";
                        SumGAS___amount := CalcSum."GAS - amount";
                        SUmTotal_without_VAT := CalcSum."GAS - amount" + CalcSum."Basis maintenance";
                        SUmTotalVat := CalcSum."GAS - VAT" + CalcSum."Maintenance VAT";
                        SumWar_Calculation__LVT_ := CalcSum."War Calculation (LVT)";
                        SUmGasPart := CalcSum."GAS - part";
                        SumGasVat := CalcSum."GAS - VAT";
                        SumMainVat := CalcSum."Maintenance VAT";

                    end;

                    if SumSm3 = 0 then FirstString += '0.00' else FirstString += format(Replacestring_T(format(SumSm3), ',', '.')); //djemina ovdje dodati nulu
                    FirstString += Separator;
                    FirstString += 'Sm3';// format(ItemBasic."Sales Unit of Measure");
                    FirstString += Separator;
                    if SumSm3 = 0 then FirstString += '0.00' else FirstString += format(Replacestring_T(format(SumSm3), ',', '.'));//djemina ovdje dodati nulu
                    FirstString += Separator;
                    //   FirstString += format(Replacestring_T(format("Sales Unit Price"), ',', '.'));

                    PriceZero := '';

                    if StrLen(format(format(Replacestring_T(format("Sales Unit Price"), ',', '.')))) < 5 then begin
                        for i := 1 to 5 - StrLen(format(format(Replacestring_T(format("Sales Unit Price"), ',', '.'))))
                        do begin
                            PriceZero += '0';

                        end;
                        FirstString += format(Replacestring_T(format("Sales Unit Price"), ',', '.') + PriceZero) + '';

                    end
                    else begin
                        FirstString += format(Replacestring_T(format("Sales Unit Price"), ',', '.')) + '';
                    end;

                    FirstString += Separator;


                    PriceZero := '';

                    if (ROUND(SumGAS___amount) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format(SumGAS___amount))
                        do begin
                            PriceZero += '0';

                        end;
                    end;
                    if (ROUND(SumGAS___amount) MOD 1 * 100) = 0 then
                        PriceZero := '.00';


                    FirstString += format(Replacestring_T(format(SumGAS___amount), ',', '.') + PriceZero);

                    FirstString += Separator;
                    if SumMain <> 0 then
                        FirstString += format('komad')
                    else
                        FirstString += format('komad');

                    FirstString += Separator;
                    CL2.Reset();
                    CL2.SetFilter("Customer No.", '%1', "Customer No.");
                    CL2.SetFilter(Code, '%1', "Code");
                    cl2.SetFilter("Basis maintenance", '<>%1', 0);
                    CL2.setfilter("Month Of GAS Calculation", '%1', "Month Of GAS Calculation");
                    CL2.setfilter("Year Of GAS Calculation", '%1', "Year Of GAS Calculation");
                    if cl2.FindFirst() then begin
                        FirstString += format(format(cl2.count));
                    end
                    else begin
                        FirstString += format('0');
                    end;

                    FirstString += Separator;
                    if SumMain <> 0 then
                        FirstString += format('3.40', 0, '<Precision,2:2><Standard Format,2>')
                    else
                        FirstString += format('0.00');

                    FirstString += Separator;
                    if SumMain <> 0 then
                        FirstString += format(SumMain, 0, '<Precision,2:2><Standard Format,2>')
                    else
                        FirstString += format('0.00');



                    FirstString += Separator;


                    PriceZero := '';

                    if (ROUND(SumGAS___amount + SumMain) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format(SumGAS___amount + SumMain))
                        do begin
                            PriceZero += '0';
                        end;
                    end;

                    if (ROUND(SumGAS___amount + SumMain) MOD 1 * 100) = 0 then
                        PriceZero := '.00';



                    FirstString += format(Replacestring_T(format(SumGAS___amount + SumMain), ',', '.') + PriceZero);

                    FirstString += Separator;
                    PriceZero := '';

                    if (ROUND(SumMainVat + SumGasVat) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format(SumMainVat + SumGasVat))
                        do begin
                            PriceZero += '0';

                        end;
                    end;

                    if (ROUND(SumMainVat + SumGasVat) MOD 1 * 100) = 0 then
                        PriceZero := '.00';



                    FirstString += format(Replacestring_T(format(SumMainVat + SumGasVat), ',', '.') + PriceZero);

                    FirstString += Separator;
                    FirstString += 'Sm3';//format(ItemBasic."Sales Unit of Measure");
                    FirstString += Separator;

                    PriceZero := '';

                    if (ROUND("Q. total Sum - War") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format("Q. total Sum - War"))
                        do begin
                            PriceZero += '0';

                        end;
                    end;

                    if (ROUND("Q. total Sum - War") MOD 1 * 100) = 0 then
                        PriceZero := '.00';

                    FirstString += format(Replacestring_T(format("Q. total Sum - War"), ',', '.') + PriceZero);


                    FirstString += Separator;


                    if SumWar_Calculation__LVT_ <> 0 then begin
                        //FirstString += format("Currency Code")

                        CER.Reset();
                        CER.SetFilter("Currency Code", '%1', "Currency Code");

                        ChGet2.get(DataItem2.Code);

                        if (ChGet2."Month Of GAS Calculation" = "Month Of GAS Calculation") and (ChGet2."Year Of GAS Calculation" = "Year Of GAS Calculation") then
                            CER.SetFilter("Starting Date", '<=%1', "Calculation Date To")
                        else
                            CER.SetFilter("Starting Date", '<=%1', "Reading Date To");

                        CER.SetCurrentKey("Starting Date");
                        CER.Ascending;
                        if CER.FindLast() then begin
                            PriceZero := '';

                            RelationF := format(Replacestring_T(format(CER."Relational Exch. Rate Amount"), ',', '.') + PriceZero);
                            if StrLen(RelationF) < 9 then begin
                                for i := 1 to 9 - StrLen(RelationF) do begin
                                    PriceZero += '0';
                                end;
                            end;

                            FirstString += RelationF + PriceZero;
                        end;
                    end

                    else begin
                        FirstString += format('');
                    end;
                    FirstString += Separator;
                    // FirstString += format(Replacestring_T(format("War Calculation (LVT)"), ',', '.'));

                    PriceZero := '';
                    decpart := FORMAT(ROUND(SumWar_Calculation__LVT_) MOD 1 * 100);


                    PriceZero := '';

                    if (ROUND(SumWar_Calculation__LVT_) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format(SumWar_Calculation__LVT_))
                        do begin
                            PriceZero += '0';

                        end;
                    end;

                    if (ROUND(SumWar_Calculation__LVT_) MOD 1 * 100) = 0 then
                        PriceZero := '.00';


                    FirstString += format(Replacestring_T(format(round(SumWar_Calculation__LVT_, 0.01, '=')), ',', '.') + PriceZero);



                    FirstString += Separator;

                    //  FirstString += format(Total);
                    PriceZero := '';

                    decpart := FORMAT(ROUND(SUmTotal_without_VAT + SUmTotalVat) MOD 1 * 100);


                    if StrLen(decpart) < 2 then begin
                        if (ROUND(SUmTotal_without_VAT + SUmTotalVat) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                        end
                        else begin
                            for i := 1 to 2 - StrLen(format(SUmTotal_without_VAT + SUmTotalVat))
                            do begin
                                PriceZero += '0';
                            end;
                        end;

                        if (ROUND(SUmTotal_without_VAT + SUmTotalVat) MOD 1 * 100) = 0 then
                            PriceZero := '.00';



                        if SUmTotal_without_VAT + SUmTotalVat = 0 then
                            FirstString += '0.00'
                        else
                            FirstString += format(Replacestring_T(format(SUmTotal_without_VAT + SUmTotalVat), ',', '.') + PriceZero);

                    end
                    else begin
                        if (SUmTotal_without_VAT + SUmTotalVat) = 0 then
                            FirstString += '0.00'
                        else
                            FirstString += format(Replacestring_T(format(SUmTotal_without_VAT + SUmTotalVat), ',', '.'));
                    end;

                    FirstString += Separator;

                    //  if ("Customer Balance" <> 0) or ("Customer Prepayment" <> 0) then
                    FirstString += 'Uplate obuhvaćene do ' + FORMAT("Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                    //     else
                    //       FirstString += '';
                    FirstString += Separator;

                    if ("Customer Balance" <> 0) then begin
                        //FirstString += 'Dugovanje ' + FORMAT("Customer Balance");


                        PriceZero := '';

                        decpart := FORMAT(ROUND("Customer Balance") MOD 1 * 100);

                        //djeminaovdje





                        if "Customer Balance" <> 0 then begin

                            PriceZero := '';
                            if "Customer Balance" <> 0 then begin
                                decpart := FORMAT(ROUND("Customer Balance") MOD 1 * 100);
                                if StrLen(format(ROUND("Customer Balance") MOD 1 * 100)) < 2 then begin

                                    if (ROUND("Customer Balance") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                                    end else begin
                                        for i := 1 to 2 - StrLen(format(ROUND("Customer Balance") MOD 1 * 100))
                                        do begin
                                            PriceZero += '0';
                                        end;
                                    end;
                                    if (ROUND("Customer Balance") MOD 1 * 100) = 0 then
                                        PriceZero := '.00';


                                end;
                            end;

                            FirstString += 'Dugovanje ' + format(Replacestring_T(format("Customer Balance"), ',', '.') + PriceZero) + '';
                        end;


                    end
                    else begin
                        if ("Customer Prepayment" <> 0) then begin
                            // FirstString += 'Preplata ' + FORMAT("Customer Prepayment");


                            if "Customer Prepayment" <> 0 then begin
                                PriceZero := '';
                                decpart := FORMAT(ROUND("Customer Prepayment") MOD 1 * 100);
                                if StrLen(FORMAT(ROUND("Customer Prepayment") MOD 1 * 100)) < 2 then begin
                                    if (ROUND("Customer Prepayment") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(FORMAT(ROUND("Customer Prepayment") MOD 1 * 100))
                                        do begin
                                            PriceZero += '0';
                                        end;
                                    end;
                                end;
                                if (ROUND("Customer Prepayment") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';


                            end;



                            FirstString += 'Preplata ' + format(Replacestring_T(format("Customer Prepayment"), ',', '.') + PriceZero) + '';



                        end
                        else begin
                            FirstString += ' 0.00';
                        end;
                    end;

                    FirstString += Separator;





                    if ("Customer Balance" = 0) and ("Customer Prepayment" = 0) then begin

                        PriceZero := '';
                        decpart := FORMAT(ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100);
                        if StrLen(FORMAT(ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100)) < 2 then begin
                            if (ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                            end else begin
                                for i := 1 to 2 - StrLen(FORMAT(ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100))
                                do begin
                                    PriceZero += '0';
                                end;
                            end;
                        end;
                        if (ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)), ',', '.') + PriceZero);


                    end
                    else begin
                        if ("Customer Balance" <> 0) then begin
                            PriceZero := '';
                            decpart := FORMAT(ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100);
                            if StrLen(FORMAT(ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100)) < 2 then begin
                                if (ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                end else begin
                                    for i := 1 to 2 - StrLen(FORMAT(ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100))
                                    do begin
                                        PriceZero += '0';
                                    end;
                                end;
                            end;
                            if (ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) = 0 then
                                PriceZero := '.00';

                            FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal("Customer Balance" + Total)), ',', '.') + PriceZero);
                        end;

                    end;

                    if ("Customer Prepayment" <> 0) and (("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)) > 0) then begin

                        PriceZero := '';
                        decpart := FORMAT(ROUND(RoundDecimal("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat))) MOD 1 * 100);
                        if StrLen(FORMAT(ROUND(RoundDecimal("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat))) MOD 1 * 100)) < 2 then begin
                            if (ROUND(RoundDecimal("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat))) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                            end else begin
                                for i := 1 to 2 - StrLen(FORMAT(ROUND(RoundDecimal("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat))) MOD 1 * 100))
                                do begin
                                    PriceZero += '0';
                                end;
                            end;
                        end;
                        if (ROUND(RoundDecimal("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat))) MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        Rez := "Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat);
                        if rez > 0 then
                            FirstString += 'Ukupna preplata ' + format(Replacestring_T(format(RoundDecimal("Customer Prepayment" - total)), ',', '.') + PriceZero)
                        else
                            FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(abs("Customer Prepayment" - Total))), ',', '.') + PriceZero);

                    end;

                    if ("Customer Prepayment" <> 0) and (("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)) < 0) then begin

                        PriceZero := '';
                        decpart := FORMAT(ROUND(RoundDecimal((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment")) MOD 1 * 100);
                        if StrLen(FORMAT(ROUND(RoundDecimal((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment")) MOD 1 * 100)) < 2 then begin
                            if (ROUND(RoundDecimal((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment")) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                            end else begin
                                for i := 1 to 2 - StrLen(FORMAT(ROUND(RoundDecimal((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment")) MOD 1 * 100))
                                do begin
                                    PriceZero += '0';
                                end;
                            end;
                        end;
                        if (ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat - "Customer Prepayment")) MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        Rez := "Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat);
                        if rez > 0 then
                            FirstString += 'Ukupna preplata ' + format(Replacestring_T(format(RoundDecimal((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment")), ',', '.') + PriceZero)
                        else
                            FirstString += 'Ukupan dug ' + format(Replacestring_T(format(RoundDecimal(abs((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment"))), ',', '.') + PriceZero);

                    end;

                    FirstString += Separator;

                    if ("Customer Balance" <= 1) and ("Customer Prepayment" >= 0) then begin
                        FirstString += 'Zahvaljujemo Vam se na uredno izmirenim obavezama.';

                    end;

                    if ("Customer Balance" > 1) then
                        FirstString += 'Račun se smatra opomenom pred utuženje i prekid isporuke gasa.';



                    FirstString += Separator;

                    if ("Average Calculation" <> 0) then begin
                        /*   FirstString += 'Prosjek kategorije Stambeni sektor za Juni 2023:' + format("Average Calculation") +
                           ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format("Last Year Calculation") + 'Sm3.';*/
                        if "Category Customer" = "Category Customer"::Household then begin

                            //ako je domaćinstvo

                            DecimalV2 := format(Round("Last Year Calculation", 0.0001, '=') MOD 1 * 100);

                            if Evaluate(DecimalV2E, DecimalV2) then begin

                                if DecimalV2E > 50 then
                                    FirstString += 'Prosjek kategorije ' + "EF Activity" + ' za ' + Mjesec[1] + ': ' + format("Average Calculation") +
                                           ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format(round("Last Year Calculation", 1, '>')) + ' Sm3.'
                                else
                                    FirstString += 'Prosjek kategorije ' + "EF Activity" + ' za ' + Mjesec[1] + ': ' + format("Average Calculation") +
                                           ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format(round("Last Year Calculation", 1, '<')) + ' Sm3.'
                            end;

                            //kraj
                        end
                        else begin
                            if ("Last Year Calculation" = 0) and ("Source Data" = "Source Data"::Unobvious) then
                                FirstString += ''
                            else


                                //ako nije domaćinstvo
                                FirstString += 'Prosjek kategorije ' + "EF Activity" + ' za ' + Mjesec[1] + ': ' + format("Average Calculation") +
                            ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format("Last Year Calculation") + ' Sm3.';
                        end;

                    end
                    else begin
                        if ("Source Data" = "Source Data"::Unobvious) or ("Bill delivery" = "Bill delivery"::"Quarterly") then
                            FirstString += '';

                        /*   FirstString += 'Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format("Last Year Calculation") + ' Sm3.' else
                           FirstString += 'Prosjek kategorije ' + "EF Activity" + ' za ' + Mjesec[1] + ': ' + format("Average Calculation") +
                           ' Sm3.  Vaša potrošnja za ' + Mjesec_1[1] + ': ' + format("Last Year Calculation") + ' Sm3.';*/

                    end;



                    FirstString += Separator;
                    FirstString += 'Rok plaćanja: 15 dana od datuma izdavanja računa.';

                    FirstString += Separator;

                    if "Bill delivery" = "Bill delivery"::Quarterly then begin
                        FirstString += 'Računi za naknadu mjernog mjesta dostavljaju se kvartalno, u slučaju da se ne evidentira potrošnja prirodnog gasa.';
                        FirstString += Separator;
                        FirstString += 'Ukoliko želite mjesečnu dostavu računa za naknadu mjernog mjesta, molimo da nas obavijestite u pisanoj formi.';
                        FirstString += Separator;
                    end
                    else begin
                        // FirstString += Separator;
                        //FirstString += Separator;
                    end;



                    if Unobvious = true then begin

                        FirstString += 'S obzirom da nekoliko mjeseci nismo mogli očitati vaše mjerilo protoka gasa,';
                        FirstString += Separator;

                        FirstString += 'nakon izvršenog očitanja urađena je raspodjela potrošnje gasa po mjesecima.';
                        FirstString += Separator;
                    end
                    else begin
                        CharEnter := 10;
                        if "War Calculation (LVT)" <> 0 then begin


                            if "Calculation Date To" = 0D then begin
                                CHGeer.Reset();
                                CHGeer.SetFilter(Code, '%1', Code);
                                if CHGeer.FindFirst() then
                                    CalcD := "Calculation Date To"
                            end
                            else begin
                                CalcD := "Calculation Date To";
                            end;


                            WarSetup.Reset();
                            WarSetup.SetFilter("Customer Category", '%1', "Category Customer");
                            WarSetup.SetFilter(Month, '%1', Date2DMY("Calculation Date To", 2));
                            if WarSetup.findfirst then begin


                                if WarSetup.Totaling = '1..4' then
                                    FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period janur - april ' + format(Date2DMY("Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                                if WarSetup.Totaling = '5..10' then
                                    FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period maj - oktobar ' + format(Date2DMY("Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);




                                if WarSetup.Totaling = '11..12' then
                                    FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period novembar - decembar ' + format(Date2DMY("Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                            end;
                        end
                        else begin

                            FirstString += 'Podsjećamo Vas da ste dužni da nas obavijestite o svim promjenama matičnih podataka.';
                        end;
                        FirstString += Separator;
                        FirstString += Separator;

                    end;

                    if ("Bill delivery" <> "Bill delivery"::Quarterly) and (Unobvious = false) then begin
                        FirstString += Separator;
                        FirstString += Separator;
                    enD;
                    if ("Bill delivery" <> "Bill delivery"::Quarterly) and (Unobvious = true) then begin
                        CharEnter := 10;
                        if "War Calculation (LVT)" <> 0 then begin


                            if "Calculation Date To" = 0D then begin
                                CHGeer.Reset();
                                CHGeer.SetFilter(Code, '%1', Code);
                                if CHGeer.FindFirst() then
                                    CalcD := CHGeer."Calculation Date To"
                            end
                            else begin
                                CalcD := "Calculation Date To";
                            end;


                            WarSetup.Reset();
                            WarSetup.SetFilter("Customer Category", '%1', "Category Customer");
                            WarSetup.SetFilter(Month, '%1', Date2DMY("Calculation Date To", 2));
                            if WarSetup.findfirst then begin


                                if WarSetup.Totaling = '1..4' then
                                    FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period janur - april ' + format(Date2DMY("Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                                if WarSetup.Totaling = '5..10' then
                                    FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period maj - oktobar ' + format(Date2DMY("Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);




                                if WarSetup.Totaling = '11..12' then
                                    FirstString += 'Taksa je obračunata na osnovu utrošenih količina za period novembar - decembar ' + format(Date2DMY("Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                            end;
                        end
                        else begin

                            FirstString += 'Podsjećamo Vas da ste dužni da nas obavijestite o svim promjenama matičnih podataka.';
                        end;
                        FirstString += Separator;
                        FirstString += Separator;
                    enD;



                    //'Za dodatna pojašnjenja možete nas kontaktirati: podrskakorisnicima@sarajevogas.ba ili na broj: 033 255 284.';

                    //   end;
                    FirstString += '';
                    FirstString += Separator;
                    EclCustomer.Reset();
                    EclCustomer.SetFilter("Customer No.", '%1', "Customer No.");
                    EclCustomer.SetFilter("Starting Date", '<=%1', "Calculation Date To");
                    EclCustomer.SetCurrentKey("Starting Date");
                    EclCustomer.Ascending;
                    if EclCustomer.FindLast() then begin


                        if (EclCustomer."Ending Date" = 0D) or (EclCustomer."Ending Date" >= "Calculation Date To") then
                            FirstString += ''
                        else
                            FirstString += 'Molimo da se obratite u jednu od naših poslovnica radi potpisivanja ugovora.';

                    end
                    else begin
                        FirstString += 'Molimo da se obratite u jednu od naših poslovnica radi potpisivanja ugovora.';
                    end;
                    FirstString += Separator;


                    if MjeraciZamjena <> '' then begin
                        FirstString += Format("Calculation Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>');

                    end
                    else begin
                        FirstString += Format("Reading Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format("Reading Date To", 0, '<day,2>.<month,2>.<year4>');

                    end;

                    FirstString += Separator;

                    FirstString += "Document No. Posting";
                    FirstString += Separator;

                    FirstString += "Customer No." + ' ' + Replacestring_TName("Customer Name", ';', ',');

                    FirstString += Separator;
                    FirstString += "Address MM";
                    if "Street No. Text" <> '' then
                        FirstString += '\' + "Street No. Text";
                    if Floor <> '' then
                        FirstString += '\' + Floor;

                    if "Apartment No." <> '' then
                        FirstString += '\' + "Apartment No.";

                    FirstString += Separator;
                    FirstString += format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                    FirstString += Separator;


                    CompanyInfo.GET;
                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 1");
                    if banacc.FindFirst() then begin

                        transaction1 := banacc."Bank Account No.";
                        transaction1Name := banacc.Name;
                    end;

                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 2");
                    if banacc.FindFirst() then begin
                        transaction2name := banacc.Name;
                        transaction2 := banacc."Bank Account No.";
                    end;
                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 3");
                    if banacc.FindFirst() then begin
                        transaction3Name := banacc.Name;
                        transaction3 := banacc."Bank Account No.";
                    end;

                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 4");
                    if banacc.FindFirst() then begin
                        transaction4Name := banacc.Name;
                        transaction4 := banacc."Bank Account No.";
                    end;
                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 5");
                    if banacc.FindFirst() then begin

                        transaction5Name := banacc.Name;
                        transaction5 := banacc."Bank Account No.";
                    end;

                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 6");
                    if banacc.FindFirst() then begin

                        transaction6Name := banacc.Name;
                        transaction6 := banacc."Bank Account No.";
                    end;

                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 7");
                    if banacc.FindFirst() then begin

                        transaction7Name := banacc.Name;
                        transaction7 := banacc."Bank Account No.";
                    end;

                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 8");
                    if banacc.FindFirst() then begin

                        transaction8Name := banacc.Name;
                        transaction8 := banacc."Bank Account No.";
                    end;


                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 9");
                    if banacc.FindFirst() then begin

                        transaction9Name := banacc.Name;
                        transaction9 := banacc."Bank Account No.";
                    end;

                    banacc.Reset();
                    banacc.SetFilter("No.", CompanyInfo."Bank No. 10");
                    if banacc.FindFirst() then begin

                        transaction10Name := banacc.Name;
                        transaction10 := banacc."Bank Account No.";
                    end;
                    banacc.Reset();
                    banacc.SetFilter("No.", 'BANK13');
                    if banacc.FindFirst() then begin

                        transaction11Name := banacc.Name;
                        transaction11 := banacc."Bank Account No.";
                    end;

                    BrojacRandom += 1;

                    if BrojacRandom = 1 then begin
                        FirstString += transaction1 + ' ' + transaction1Name;
                    end;
                    if BrojacRandom = 2 then begin
                        FirstString += transaction2 + ' ' + transaction2Name;
                    end;

                    if BrojacRandom = 3 then begin
                        FirstString += transaction3 + ' ' + transaction3Name;
                    end;

                    if BrojacRandom = 4 then begin
                        FirstString += transaction4 + ' ' + transaction4Name;
                    end;
                    if BrojacRandom = 5 then begin
                        FirstString += transaction5 + ' ' + transaction5Name;
                    end;
                    if BrojacRandom = 6 then begin
                        FirstString += transaction6 + ' ' + transaction6Name;
                    end;
                    if BrojacRandom = 7 then begin
                        FirstString += transaction7 + ' ' + transaction7Name;
                    end;
                    if BrojacRandom = 8 then begin
                        FirstString += transaction8 + ' ' + transaction8Name;
                    end;
                    if BrojacRandom = 9 then begin
                        FirstString += transaction9 + ' ' + transaction9Name;
                    end;
                    if BrojacRandom = 10 then begin
                        FirstString += transaction10 + ' ' + transaction10Name;
                    end;
                    if BrojacRandom = 11 then begin
                        FirstString += transaction11 + ' ' + transaction11Name;
                    end;
                    FirstString += Separator;

                    if BrojacRandom = 11 then
                        BrojacRandom := 0;

                    FirstString += CompanyInfo."Name 2";
                    FirstString += Separator;

                    FirstString += CompanyInfo.Address;
                    FirstString += Separator;

                    if "Post Code Customer D." = '71000' then begin
                        FirstString += "Post Code Customer D." + ' ' + "City Customer D." + ' - ' + UpperCase(Replacestring_TName("Municipality Name Customer 2", '- Sarajevo', ''))
                    end
                    else begin

                        FirstString += "Post Code Customer D." + ' ' + UpperCase(Replacestring_TName("Municipality Name Customer 2", '- Sarajevo', ''));
                    end;
                    FirstString += Separator;


                    barCodeRez := '';
                    barCodeZero := '';
                    BrojacI := 0;

                    barCode1 := "Customer No.";
                    barCode2 := copystr("Document No. Posting", 4, StrLen("Document No. Posting"));
                    DUzinaUit := StrLen(("Customer No."));

                    if StrLen(("Customer No.")) < 6 then begin

                        for BrojacI := 1 to 6 - strlen("Customer No.") do begin
                            barCodeZero += '0';

                        end;

                    end;
                    BrojacI := 0;
                    barCodeRez := barCodeZero + barCode1;

                    barCodeZero := '';
                    if StrLen(format(barCode2)) < 9 then begin

                        for BrojacI := 1 to 9 - strlen(barCode2) do begin
                            barCodeZero += '0';

                        end;

                    end;



                    barCodeRez += barCodeZero + barCode2;

                    FirstString += '*' + barCodeRez + '*';
                    FirstString += Separator;


                    FirstString += '*' + "Document No. Posting" + '*';
                    FirstString += Separator;

                    /*    if ("Customer Balance" <> 0) then begin
                            FirstString += 'Ukupan dug ' + format(Replacestring_T(format("Customer Balance" + total), ',', '.'));
                        end
                        else begin
                            FirstString += '';
                        end;
                        FirstString += Separator;*/

                    VećUbaceno := false;
                    if ("Customer Balance" = 0) and ("Customer Prepayment" = 0) then begin

                        PriceZero := '';

                        if (ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) = 0 then
                            PriceZero := '.00';

                        if (SUmTotal_without_VAT + SUmTotalVat) = 0 then begin
                            FirstString += '';
                        end
                        else begin
                            FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(SUmTotal_without_VAT + SUmTotalVat)), ',', '.') + PriceZero) + ' KM';
                            VećUbaceno := true;
                        end;
                    end
                    else begin
                        if ("Customer Balance" <> 0) and ("Customer Prepayment" = 0) then begin


                            PriceZero := '';

                            if (ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                            end else begin
                                for i := 1 to 2 - StrLen(format(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)))
                                do begin
                                    PriceZero += '0';

                                end;
                            end;

                            if (ROUND(RoundDecimal("Customer Balance" + SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) = 0 then
                                PriceZero := '.00';
                            if "VećUbaceno" = False then begin
                                FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal("Customer Balance" + (SUmTotal_without_VAT + SUmTotalVat))), ',', '.') + PriceZero) + ' KM';

                                VećUbaceno := true;
                            end;
                        end;

                    end;

                    if ("Customer Prepayment" <> 0) and (("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)) < 0) then begin

                        Rez := "Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat);


                        PriceZero := '';

                        if (ROUND("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment"))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(RoundDecimal((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment")) MOD 1 * 100) = 0 then
                            PriceZero := '.00';
                        if "VećUbaceno" = False then begin
                            if rez > 0 then begin
                                FirstString += '';
                            end
                            else begin
                                FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(abs((SUmTotal_without_VAT + SUmTotalVat) - "Customer Prepayment"))), ',', '.') + PriceZero) + ' KM';
                                VećUbaceno := true;
                            end;
                        end;
                    end;

                    if ("Customer Prepayment" <> 0) and (("Customer Prepayment" - SUmTotal_without_VAT + SUmTotalVat) > 0) then begin

                        Rez := "Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat);


                        PriceZero := '';

                        if (ROUND("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(RoundDecimal("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat))) MOD 1 * 100) = 0 then
                            PriceZero := '.00';
                        if "VećUbaceno" = False then begin
                            if rez > 0 then begin
                                FirstString += '';
                            end
                            else begin
                                FirstString += 'Ukupan dug: ' + format(Replacestring_T(format(RoundDecimal(abs("Customer Prepayment" - (SUmTotal_without_VAT + SUmTotalVat)))), ',', '.') + PriceZero) + ' KM';
                                VećUbaceno := True;
                            end;
                        end;
                    end;


                    FirstString += Separator;


                    FirstString += "Address 2" + '.';
                    if "Street No.2 Text" <> '' then
                        FirstString += ' ' + "Street No.2 Text";


                    /*    FirstString += "Address MM" + '.';
                        if "Street No. Text" <> '' then
                            FirstString += ' ' + "Street No. Text";*/

                    FirstString += Separator;

                    FirstString += Separator;

                    FirstString += Separator;





                    ///transakcijski računi




























                    OutStr.WRITETEXT(FirstString);

                    OutStr.WRITETEXT(); // This command is to move to next line

                    FirstString := '';
                    CalcSetup.get;
                    if DataItem2."Category Customer" = DataItem2."Category Customer"::Household then
                        ReminderV := CalcSetup."Reminder amount";
                    if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then
                        ReminderV := CalcSetup."Reminder amount VP";
                    if DataItem2."Category Customer" = DataItem2."Category Customer"::"Small Economy" then
                        ReminderV := CalcSetup."Reminder amount MP";
                    if DataItem2."Category Customer" = DataItem2."Category Customer"::"KJKP Heating plant" then
                        ReminderV := CalcSetup."Reminder amount KJKP";
                    if DataItem2."Category Customer" = DataItem2."Category Customer"::"Special Customer" then
                        ReminderV := CalcSetup."Reminder amount SP";
                    if DataItem2."Category Customer" = DataItem2."Category Customer"::CNG then
                        ReminderV := CalcSetup."Reminder amount CNG";


                    if (DataItem2."Customer Balance" >= ReminderV)
                    and ("Measuring point off" = false)
                    then begin

                        RHeader.Reset();
                        RHeader.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                        RHeader.SetFilter(WH, '%1', DataItem2.Code);
                        if RHeader.FindFirst() then begin
                            FirstString := '';
                            //sada ispod dodajem opomenu
                            FirstString += 'M1';
                            FirstString += Separator;
                            FirstString += "Customer No.";
                            FirstString += Separator;

                            FirstString += Replacestring_TName("Customer Name", ';', ',');
                            ;
                            FirstString += Separator;
                            FirstString += "Address MM";
                            if "Street No. Text" <> '' then
                                FirstString += '\' + "Street No. Text";
                            if Floor <> '' then
                                FirstString += '\' + Floor;

                            if "Apartment No." <> '' then
                                FirstString += '\' + "Apartment No.";

                            FirstString += Separator;
                            FirstString += "Post Code MM" + ' - ' + "City MM";
                            //datum kreiranja opomene (provjeriti informaciju);
                            FirstString += Separator;

                            FirstString += Format(CalcDate('<+15D>', DataItem2."Calculation Date To"));
                            FirstString += Separator;
                            FirstString += Format(DataItem2."Customer Balance");
                            FirstString += Separator;

                            barCodeRez := '';
                            barCodeZero := '';
                            BrojacI := 0;
                            barCode1 := DataItem2."Customer No.";
                            if DataItem2."Document No. Posting" <> '' then
                                barCode2 := copystr(DataItem2."Document No. Posting", 4, StrLen(DataItem2."Document No. Posting"))
                            else
                                barCode2 := '';

                            DUzinaUit := StrLen((DataItem2."Customer No."));
                            if StrLen((DataItem2."Customer No.")) < 6 then begin

                                for BrojacI := 1 to 6 - strlen(DataItem2."Customer No.") do begin
                                    barCodeZero += '0';

                                end;

                            end;
                            barCodeRez := barCodeZero + barCode1;
                            barCodeZero := '';
                            BrojacI := 0;

                            if StrLen(format(barCode2)) < 9 then begin

                                for BrojacI := 1 to 9 - strlen(barCode2) do begin
                                    barCodeZero += '0';

                                end;

                            end;
                            barCodeRez += barCodeZero + barCode2;


                            FirstString += '*' + barCodeRez + '*';
                            FirstString += Separator;


                            FirstString += '*' + "Document No. Posting" + '*';
                            FirstString += Separator;

                            FirstString += "Document No. Posting";
                            FirstString += Separator;


                            if BrojacRandom = 0 then BrojacRandom := 10;

                            if BrojacRandom = 1 then begin
                                FirstString += transaction1 + ' ' + transaction1Name;
                            end;
                            if BrojacRandom = 2 then begin
                                FirstString += transaction2 + ' ' + transaction2Name;
                            end;

                            if BrojacRandom = 3 then begin
                                FirstString += transaction3 + ' ' + transaction3Name;
                            end;

                            if BrojacRandom = 4 then begin
                                FirstString += transaction4 + ' ' + transaction4Name;
                            end;
                            if BrojacRandom = 5 then begin
                                FirstString += transaction5 + ' ' + transaction5Name;
                            end;
                            if BrojacRandom = 6 then begin
                                FirstString += transaction6 + ' ' + transaction6Name;
                            end;
                            if BrojacRandom = 7 then begin
                                FirstString += transaction7 + ' ' + transaction7Name;
                            end;
                            if BrojacRandom = 8 then begin
                                FirstString += transaction8 + ' ' + transaction8Name;
                            end;
                            if BrojacRandom = 9 then begin
                                FirstString += transaction9 + ' ' + transaction9Name;
                            end;
                            if BrojacRandom = 10 then begin
                                FirstString += transaction10 + ' ' + transaction10Name;
                            end;
                            if BrojacRandom = 11 then begin
                                FirstString += transaction11 + ' ' + transaction11Name;
                            end;
                            FirstString += Separator;

                            if BrojacRandom = 11 then BrojacRandom := 0;



                            FirstString += Format(CalcDate('<+0D>', DataItem2."Calculation Date To"));
                            FirstString += Separator;
                            FirstString += Mjesec[1] + ' ' + Format("Year Of GAS Calculation") + '.;';

                            OutStr.WRITETEXT(FirstString);

                            OutStr.WRITETEXT(); // This command is to move to next line

                            FirstString += '';
                        end;




                    end;






                end;



            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;

                CalcFind: Record "Calculation Journal Line";
                SifraObracuna: text;
                CH: record "Calcuation Header";
                CJLOrg: record "Calculation Journal Line";
                CJLOrg1: record "Calculation Journal Line";
                CCHCode: record "Calcuation Header";
            begin

                SifraObracuna := '';

                CH.Reset();
                CH.SetFilter("Include Quartaly", '%1', true);
                CH.SetFilter(Code, '%1', DataItem2.GetFilter(Code));

                if CH.FindFirst() then begin
                    // Logika za CCHCode
                    // Logika za CCHCode
                    CCHCode.Reset();
                    CCHCode.SetFilter("Year Of GAS Calculation", '%1', CH."Year Of GAS Calculation");
                    CCHCode.SetFilter("Month Of GAS Calculation", '%1|%2', CH."Month Of GAS Calculation" - 1, CH."Month Of GAS Calculation" - 2);
                    CCHCode.SetFilter("Category Calculation", '%1', CH."Category Calculation");
                    repeat
                        if CCHCode."Code" <> '' then
                            SifraObracuna += CCHCode."Code" + '|';

                    until CCHCode.Next() = 0;

                    if StrLen(SifraObracuna) > 2 then
                        SifraObracuna := CopyStr(SifraObracuna, 1, StrLen(SifraObracuna) - 1);

                    CJLOrg.reset;
                    CJLOrg.CopyFilters(DataItem2);
                    CJLOrg.SetFilter("Code", DataItem2.GetFilter(Code));
                    CJLOrg.SetFilter("Reading Time", '%1|%2',
                        ("Reading Time"::"Per Month"),
                        ("Reading Time"::Extraordinary));

                    DataItem2.DeleteAll();
                    if CJLOrg.FindSet() then
                        repeat


                            CJLOrg1.Reset();
                            CJLOrg1.SetFilter("Customer No.", '%1', CJLOrg."Customer No.");
                            CJLOrg1.SetFilter("Code", SifraObracuna);
                            CJLOrg1.SetFilter(Locked, '%1|%2', true, false);
                            CJLOrg1.SetFilter("Bill Created", '%1|%2', true, false);
                            CJLOrg1.SetFilter("Reading Time", '%1',
                                ("Reading Time"::Extraordinary));
                            CJLOrg1.SetCurrentKey("Reading Date To");
                            CJLOrg1.Ascending;

                            if CJLOrg1.FindSet() then
                                repeat

                                    DataItem2.Init();
                                    // "Code", MM, "Customer No.", Gauge, Autoint)
                                    DataItem2.TransferFields(CJLOrg1);
                                    if not DataItem2.get(CJLOrg1.Code, CJLOrg1.MM, CJLOrg1."Customer No.", CJLOrg1.Gauge, CJLOrg1.Autoint) then DataItem2.Insert(false);
                                until CJLOrg1.Next() = 0;

                            DataItem2.Init();
                            DataItem2.TransferFields(CJLOrg);
                            DataItem2.Insert(false);

                        until CJLOrg.Next() = 0;
                    DataItem2.Reset();

                end
                else begin
                    CJLOrg.reset;
                    CJLOrg.CopyFilters(DataItem2);
                    DataItem2.DeleteAll();
                    if CJLOrg.FindSet() then
                        repeat


                            DataItem2.Init();
                            DataItem2.TransferFields(CJLOrg);
                            DataItem2.Insert(false);

                        until CJLOrg.Next() = 0;
                    DataItem2.Reset();
                end;


                DataItem2.reset;
                SetCurrentKey("Customer Stroke 2", "Customer string 2", "Municipality Name Customer 2", "Street Name Customer 2", "Street No.2 int", "Street No.2 Text", "Street No. Text Apartment", "Apartment No. Customer 2", "Customer No. int", "Calculation Date To", "Reading Date To");

                Ascending;

                Progress.OPEN('Startno vrijeme pokretanja izvještaja je ' + format(time) + '. Ukupan broj ažuriranja je ------ #1');
                Progress.UPDATE(1, 0);


            end;


        }
        dataitem("Customer Ledger Entry"; "Customer Ledger Entry")

        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                EFDjelatnost: Record "MM Activity" temporary;
                EFDjelatnostRec: Record "MM Activity";
                AQ: Query "My Query";
            begin

                FirstString := '';
                FirstString += 'U1';
                FirstString += Separator;
                FirstString += "Customer No.";
                FirstString += Separator;
                FirstString += Replacestring_TName("Customer Name", ';', ',');
                ;
                FirstString += Separator;
                OutStr.WRITETEXT(FirstString);

                OutStr.WRITETEXT(); // This command is to move to next line

                FirstString += '';



            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                SetFilter(Active, '%1', true);

            end;



        }

    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Charr := 9;
        Separator := ';';

        FileName := 'Ocitavanje.txt';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        FirstString := '';
        /*  FirstString += 'ZapisnikBroj';
          FirstString += format(Charr);
          FirstString += 'Šifra Kupac';
          FirstString += format(Charr);
          FirstString += 'Hod Kupac';
          FirstString += format(Charr);
          FirstString += 'Šifra Potrošno';
          FirstString += format(Charr);
          FirstString += 'Potrošno mjesto';
          FirstString += format(Charr);
          FirstString += 'Adresa';
          FirstString += format(Charr);
          FirstString += 'Mjesna zajednica / Zona';
          FirstString += format(Charr);
          FirstString += 'Općina';
          FirstString += format(Charr);
          FirstString += 'Hod';
          FirstString += format(Charr);
          FirstString += 'Niz Broj';
          FirstString += format(Charr);
          FirstString += 'MjeračTip';
          FirstString += format(Charr);
          FirstString += 'MjeračBroj';
          FirstString += format(Charr);
          FirstString += 'MjeračRanijeStanje';
          FirstString += format(Charr);
          FirstString += 'MjeračRanijiDatum';
          FirstString += format(Charr);
          FirstString += 'MjeračTemperatura';
          FirstString += format(Charr);
          FirstString += 'MjeračPritisak';
          FirstString += format(Charr);
          FirstString += 'KorektorBroj';
          FirstString += format(Charr);
          FirstString += 'KorektorTip';
          FirstString += format(Charr);
          FirstString += 'KorektorRanijeStanje';
          FirstString += format(Charr);
          FirstString += 'KorigovanoRanijeStanje';
          FirstString += format(Charr);
          FirstString += 'VrstaOcitanja';
          /* FirstString += 'Datum';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Vrijeme';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Novo stanje mjerača';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Datum fiksnog očitanja';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Fiksno očitanje';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Novo stanje korektora';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Novo korigovano stanje';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Temperatura mjerača';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Pritisak mjerača';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Temperatura korektora';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Pritisak korektora';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Očitavač';
           OutStr.WRITETEXT(FirstString);
           FirstString += 'Status očitanja';*/
        //    OutStr.WRITETEXT(FirstString);







        //   OutStr.WRITETEXT(); // This command is to move to next line

    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
        DownloadFromStream(Instr, '', '', '', FileName);

    end;


    procedure RoundDecimal(InputAmount: Decimal) PrintAmout: Decimal
    var
        DecimalPart: Text;
        DecimalPart2: Text;
        DecimalPArt2Int: Integer;
        RoundValue: Integer;
        PrintAmountText: Text;
        DecimalPart2Start: text;
    begin
        //80.30
        //80.03
        //80.3


        RoundValue := 0;

        DecimalPart := format(Round(InputAmount, 0.01, '=') MOD 1 * 100);//ostatak brojeva decimale

        if (StrLen(DecimalPart) = 1) and ((Round(InputAmount, 0.01, '=') MOD 1 * 100) <> 0) then
            DecimalPart := '0' + DecimalPart;
        //ovaj dio je npr. 05



        //zadnji broj uzima

        if StrLen(DecimalPart) >= 2 then
            DecimalPart2 := CopyStr(DecimalPart, 2, 1)
        else
            DecimalPart2 := '0';


        if
        (Round(InputAmount, 0.01, '=') MOD 1 * 100) = 0 then begin
            PrintAmout := InputAmount;
        end
        else begin


            //ovo mi je kao druga cifra zaokruženo na dvije decimale
            if DecimalPart2 = '0' then
                RoundValue := 0;


            if Evaluate(DecimalPArt2Int, DecimalPart2) then begin
                if DecimalPArt2Int in [1, 2] then
                    RoundValue := 0;

                if DecimalPArt2Int in [3, 4] then
                    RoundValue := 5;

                if DecimalPArt2Int in [5, 6, 7] then
                    RoundValue := 5;

                if DecimalPArt2Int in [8, 9] then
                    RoundValue := 10;




                //    if DecimalPArt2Int in [0] then
                //      RoundValue := 0;

                if DecimalPArt2Int = 8 then
                    PrintAmountText := format(InputAmount + 0.02);

                if DecimalPArt2Int = 9 then
                    PrintAmountText := format(InputAmount + 0.01);


                if DecimalPArt2Int in [8, 9] then begin


                end
                else begin

                    if DecimalPart2 <> '0' then begin
                        if StrLen(format(InputAmount)) >= 2 then
                            PrintAmountText := CopyStr(format(InputAmount), 1, StrLen(format(InputAmount)) - 1) + format(RoundValue)
                        else
                            PrintAmountText := PrintAmountText + format(RoundValue);
                    end
                    else begin
                        PrintAmountText := format(InputAmount) + format(RoundValue);
                    end;
                end;


                if Evaluate(PrintAmout, PrintAmountText)
                then begin
                    PrintAmout := PrintAmout;

                end
                else begin
                    PrintAmout := InputAmount;
                end;

            end
            else begin
                //ako je 0
                PrintAmout := InputAmount;
            end;


        end;
    end;


    /* procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
     begin
         WHILE STRPOS(String, FindWhat) > 0 DO
             String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
         NewString := String;
     end;*/

    procedure RemoveWord(var Txt: Text; WordToRemove: Text)
    var
        Pos: Integer;
    begin
        Pos := StrPos(Txt, WordToRemove);
        if Pos > 0 then
            Txt := DelStr(Txt, Pos, StrLen(WordToRemove));
    end;

    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        ValueD: Integer;
        StrIn: Integer;
    begin
        if FindWhat = ',' then begin
            String := Replacestring_TTacka(format(String), '.', 'LLL');
        end;
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));

        if FindWhat = ',' then begin
            String := Replacestring_TTacka(format(String), 'LLL', ',');
        end;

        NewString := String;

        if strpos(NewString, '.') <> 0 then begin
            ValueD := strlen(copystr(NewString, strpos(NewString, '.') + 1, StrLen(NewString)));
            StrIn := strpos(NewString, '.');

            if strlen(copystr(NewString, strpos(NewString, '.') + 1, StrLen(NewString))) = 1 then
                NewString += '0';

        end;

    end;

    procedure Replacestring_TTacka(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    var

        Brojac: Integer;
        CHGeer: Record "Calcuation Header";
        ChGet2: Record "Calculation Journal Line";
        CER: Record "Currency Exchange Rate";
        DUzinaUit: integer;
        CalcDuplicate2: record "Calculation Journal Line";
        SumDifference: decimal;

        EclCustomer: Record "Customer Ledger Entry";

        FirstString: Text;
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        ReminderV: Decimal;
        Content_M: Text;
        transaction7Name: text[100];
        transaction7: Text[100];
        Progress: Dialog;
        transaction1Name: text[100];
        transaction2: text[100];
        transaction1: text[100];
        transaction3: text[100];
        CalcSum: Record "Calculation Journal Line";

        transaction3Name: text[100];
        CalcDuplicate: Record "Calculation Journal Line";

        transaction2Name: text[100];
        transaction4Name: text[100];
        transaction4: Text[100];
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];


        transaction8Name: TEXT[100];
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];
        transaction10: TEXT[100];
        transaction11Name: TEXT[100];
        transaction11: TEXT[100];
        Charr: Char;
        VećUbaceno: Boolean;
        Separator: text[250];
        PriceZero: text[250];
        CompanyInf: Record "Company Information";
        i: Integer;
        banacc: Record "Bank Account";
        CompanyInfo: Record "Company Information";

        CustomerNow: Record "Customer Ledger Entry";
        Rez: Decimal;
        DecimalF: Text;
        Mjesec: array[12] of Text;
        Mjesec_1: array[12] of Text;
        barCode1: text;
        barCode2: text;
        barCodeRez: text;
        barCodeZero: text;
        BrojacRandom: Integer;
        DecimalV2: text[250];
        decimalV2E: Decimal;
        NacinOcitanjaZamjena: Text;
        OldZamjena: text;
        RazlikaZamjena: text;
        NewZamjena: Text;
        TextIzvora: texT;
        DatumiSpojeniOd: Text;
        DatumiSpojenido: Text;
        MjeraciZamjena: text;

        NacinOcitanjaZamjena1: Text;
        OldZamjena1: text;
        RazlikaZamjena1: text;
        NewZamjena1: Text;
        DatumiSpojeniOd1: Text;
        DatumiSpojenido1: Text;
        CalcD: Date;
        MjeraciZamjena1: text;


        BrojacRedova: Decimal;
        DatumOdMaxZamjena: Date;
        decpart: Text;

        DatumOdMinZamjena: date;
        SUmGasPart: Decimal;
        SumGasVat: Decimal;
        SumMainVat: Decimal;

        DatumOdMaxZamjena1: Date;
        DatumOdMinZamjena1: date;
        TextNewGauge: Text;
        Brojaczamjena: Integer;
        CharEnter: char;
        RHeader: Record "Reminder Header"
        ;
        BrojacSepparator: Integer;

        SumMain: Decimal;
        SumMainCount: Integer;
        SumGAS___amount: Decimal;
        SUmTotal_without_VAT: Decimal;
        SUmTotalVat: Decimal;
        SumWar_Calculation__LVT_: Decimal;
        WarSetup: Record "War Debt Setup";






}

