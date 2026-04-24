report 50200 "Export Post MP"
{
    // //
    //ĐK WordLayout = './Transport print.docx';

    Caption = 'Export Post MP';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem2; "Calculation Journal Line")
        {


            trigger OnAfterGetRecord()
            var
                CalcSetup: Record "Calculation Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                Noseries: code[20];
                CustT: Record "Customer Templ.";
                CaccS: Record "Calculation Setup";
                DatItem: Record "Calculation Journal Line";
                DatItemUnique: Record "Calculation Journal Line";
                DatItemUniqueSm3Check: Record "Calculation Journal Line";
                ItemBasic: Record Item;
                BarKod: text[250];
                BrojacI: Integer;
                WC: Record "Calcuation Header";
                CJL: Record "Calculation Journal Line";
                BrojaV: Integer;
                BrojacPrethodni: Integer;
                ChGet2: Record "Calcuation Header";
                SaldoDio: Decimal;
                PretplDio: Decimal;
                NaredniSaldo: decimal;
                NaredniPretpl: Decimal;
                CL2: Record "Calculation Journal Line";
                brojext: text[250];
                Duzina: Integer;
                iii: Integer;
                iiBroj: Integer;
                BrojaCMM: Record "Calculation Journal Line";
                NumberMM: Integer;
                CJLLog: Record "CJL Logs";
                CHMonth: Record "Calcuation Header";
                CLAverage: record "Calculation Journal Line";
                SumSm3: Decimal;
                CountV: Integer;

            begin
                CountV := 0;



                BrojacRedova += 1;

                BrojaCMM.Reset();
                BrojaCMM.CopyFilters(DataItem2);
                BrojaCMM.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                BrojaCMM.SetFilter("Document No. Posting", '%1', DataItem2."Document No. Posting");
                //  BrojaCMM.SetFilter("New Gauge", '%1', false);
                if BrojaCMM.FindFirst() then
                    NumberMM := BrojaCMM.Count
                else
                    NumberMM := 0;


                Progress.UPDATE(1, ROUND(BrojacRedova));
                CompanyInf.get;
                CustTemporary.Reset();
                CustTemporary.SetFilter(Code, '%1', DataItem2."Customer No.");
                CustTemporary.SetFilter("Position ID", '%1', DataItem2."Document No. Posting");
                if not CustTemporary.FindFirst() then begin
                    CustTemporary.Init();
                    CustTemporary.Code := DataItem2."Customer No.";
                    CustTemporary."Position ID" := DataItem2."Document No. Posting";
                    CustTemporary.Insert();
                    Brojacc := 0;
                    BrojaccLinijeAdd := 0;
                    BrojaV := +1;



                    FirstString := '';
                    FirstString += 'H1';
                    FirstString += Separator;
                    FirstString += DataItem2."Street Name Customer 2";
                    if DataItem2."Street No. 2" <> '' then
                        FirstString += ' ' + DataItem2."Street No. 2";
                    if DataItem2."Street No.2 Text" <> '' then begin

                        if (DataItem2."Street No.2 Text" <> '') then
                            FirstString += ', ' + DataItem2."Street No.2 Text"
                        else
                            FirstString += ' ' + DataItem2."Street No.2 Text";
                    end;

                    FirstString += Separator;
                    FirstString += Replacestring_TName(DataItem2."Customer Name", ';', ',');
                    FirstString += Separator;

                    CustTemporary.Reset();
                    CustTemporary.SetFilter(Code, '<>%1', '');
                    if CustTemporary.FindFirst() then
                        BrojaV := CustTemporary.count;


                    brojext := '';

                    brojext := NoSeriesMgt.GetNextNo('RED_B', TODAY, true);

                    Duzina := StrLen(format(brojext));

                    if Duzina < 4 then begin
                        for iii := 1 to 4 - Duzina do begin

                            brojext := '0' + brojext;
                        end;

                    end;

                    FirstString += 'Rd. Br. ' + brojext;
                    FirstString += Separator;

                    FirstString += DataItem2."Address Customer";

                    if (DataItem2."Street No. Text" <> '') then begin
                        if ((DataItem2."Street No. Text") = 'BB') or ((DataItem2."Street No. Text") = 'bb') then begin
                            if (strpos(DataItem2."Address Customer", 'bb') <> 0) or (strpos(DataItem2."Address Customer", 'BB') <> 0) then begin

                            end
                            else begin
                                FirstString += ' ' + DataItem2."Street No. Text";
                            end;
                        end
                        else begin
                            FirstString += ' ' + DataItem2."Street No. Text";
                        end;


                    end;
                    FirstString += Separator;

                    FirstString += format(DataItem2."Customer Stroke 2") + '/' + format(DataItem2."Customer string 2");
                    FirstString += Separator;

                    FirstString += DataItem2."City Customer";
                    FirstString += Separator;

                    FirstString += DataItem2."VAT Registration No.";




                    FirstString += Separator;

                    FirstString += DataItem2."Registration No.";
                    FirstString += Separator;
                    FirstString += Separator;

                    FirstString += CompanyInf.Address + ', ' + CompanyInf.City;
                    FirstString += Separator;

                    //el: 033 445 120/ Fax: 033 445 525

                    FirstString += 'Tel: ' + CompanyInf."Purchase Phone No." + '/ Fax: ' + CompanyInf."Fax No.";
                    FirstString += Separator;

                    FirstString += '033 721 354,  033 721 346,  Fax: 033 568 123;033 592 095, 033 592 096, 061 487 787';

                    FirstString += Separator;

                    FirstString += DataItem2."Document No. Posting";
                    FirstString += Separator;

                    FirstString += format(DataItem2."Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                    FirstString += Separator;

                    /*
                    =FIelds!Post_Code_Customer_D_.value &" "& 
                     IIF(FIelds!Post_Code_Customer_D_.value="71000", 
                     UCase(Fields!City_Customer_D_.value) & " - " & UCase(REPLACE(Fields!Municipality_Name_Customer_2.Value,"- Sarajevo","")), UCase(REPLACE(Fields!Municipality_Name_Customer_2.Value,"- Sarajevo","")))*
                    */

                    FirstString += format('71000');
                    FirstString += ' ';
                    // if "Post Code Customer D." = '71000' then
                    //   FirstString += format(UpperCase("City Customer D.") + ' - ' + UpperCase(delchr("Municipality Name Customer 2", '=', '- Sarajevo')))
                    //else
                    FirstString += UpperCase('Sarajevo');


                    FirstString += Separator;
                    FirstString += format(DataItem2."Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                    FirstString += Separator;


                    FirstString += Format(DataItem2."Calculation Date From", 0, '<day,2>.<month,2>.<year4>') + ' - ' + format(DataItem2."Calculation Date To", 0, '<day,2>.<month,2>.<year4>');

                    FirstString += Separator;

                    FirstString += format('KP0101');
                    FirstString += Separator;


                    FirstString += format('Prirodni gas - potrošnja za ' + format(DataItem2."Month Of GAS Calculation") + '/' + format(DataItem2."Year Of GAS Calculation"));
                    FirstString += Separator;

                    FirstString += format('Sm3');
                    FirstString += Separator;



                    DatItem.Reset();
                    DatItem.CopyFilters(DataItem2);
                    DatItem.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    if DatItem.FindFirst() then begin
                        DatItem.CalcSums(sm3);
                        PriceZero := '';

                        if (ROUND(DatItem.SM3) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem.SM3))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem.SM3) MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        FirstString += Replacestring_T(format(DatItem.SM3), ',', '.') + PriceZero;
                        FirstString += Separator;
                    end
                    else begin

                        FirstString += format('0.00');
                        FirstString += Separator;
                    end;

                    PriceZero := '';



                    if StrLen(format(format(Replacestring_T(format(DataItem2."Unit Price"), ',', '.')))) < 5 then begin
                        for i := 1 to 5 - StrLen(format(format(Replacestring_T(format(DataItem2."Unit Price"), ',', '.'))))
                        do begin
                            PriceZero += '0';

                        end;
                        FirstString += format(Replacestring_T(format(DataItem2."Unit Price"), ',', '.') + PriceZero);

                    end
                    else begin
                        FirstString += format(Replacestring_T(format(DataItem2."Unit Price"), ',', '.'));
                    end;
                    FirstString += Separator;


                    DatItem.Reset();
                    DatItem.CopyFilters(DataItem2);
                    DatItem.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    if DatItem.FindFirst() then begin
                        DatItem.CalcSums("GAS - amount", "Basis maintenance", "GAS - VAT", "Maintenance VAT", Total, "War Calculation (LVT)", SM3);

                        PriceZero := '';

                        if (ROUND(DatItem."GAS - amount") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem."GAS - amount"))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem."GAS - amount") MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        FirstString += Replacestring_T(format(DatItem."GAS - amount"), ',', '.') + PriceZero;
                        FirstString += Separator;
                        FirstString += 'KP0405;Naknada za mjerno mjesto;;;;';
                        PriceZero := '';

                        if (ROUND(DatItem."Basis maintenance") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem."Basis maintenance"))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem."Basis maintenance") MOD 1 * 100) = 0 then
                            PriceZero := '.00';




                        FirstString += Replacestring_T(format(DatItem."Basis maintenance"), ',', '.') + PriceZero;
                        ;
                        FirstString += ';;Vrijednost bez PDV-a;;;;';

                        PriceZero := '';

                        if (ROUND(DatItem."GAS - amount" + DatItem."Basis maintenance") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem."GAS - amount" + DatItem."Basis maintenance"))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem."GAS - amount" + DatItem."Basis maintenance") MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        FirstString += Replacestring_T(format(DatItem."GAS - amount" + DatItem."Basis maintenance"), ',', '.') + PriceZero;
                        FirstString += ';;Iznos PDV-a (17 %);;;;';


                        PriceZero := '';

                        if (ROUND(DatItem."GAS - VAT" + DatItem."Maintenance VAT") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem."GAS - VAT" + DatItem."Maintenance VAT"))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem."GAS - VAT" + DatItem."Maintenance VAT") MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        FirstString += Replacestring_T(format(DatItem."GAS - VAT" + DatItem."Maintenance VAT"), ',', '.') + PriceZero;
                        FirstString += ';;Ukupno zaduženje sa PDV-om;;;;';


                        PriceZero := '';

                        if (ROUND(DatItem.Total) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem.Total))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem.Total) MOD 1 * 100) = 0 then
                            PriceZero := '.00';


                        FirstString += Replacestring_T(format(DatItem.Total), ',', '.') + PriceZero;
                        if DatItem."War Calculation (LVT)" <> 0 then
                            FirstString += ';;Posebna taksa '
                        else
                            FirstString += ';;';


                    end
                    else begin

                        FirstString += format('0.00');
                        FirstString += Separator;
                        FirstString += 'KP0405;Naknada za mjerno mjesto;;;;';
                        FirstString += format('0.00');
                        FirstString += Separator;
                        FirstString += Separator;
                        FirstString += ';;Vrijednost bez PDV-a;;;;';
                        FirstString += format('0.00');
                        FirstString += ';;Ukupno zaduženje sa PDV-om;;;;';
                        FirstString += format('0.00');
                        //ovdje posebna
                        FirstString += ';;';


                    end;


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


                    if DatItem."War Calculation (LVT)" <> 0 then
                        FirstString += Mjesec[1] + ' *'
                    else
                        FirstString += '';

                    if DatItem."War Calculation (LVT)" <> 0 then
                        FirstString += ';Sm3'
                    else
                        FirstString += ';';


                    FirstString += Separator;
                    PriceZero := '';

                    if (ROUND(DatItem.SM3) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format(DatItem.SM3))
                        do begin
                            PriceZero += '0';

                        end;
                    end;

                    if (ROUND(DatItem.SM3) MOD 1 * 100) = 0 then
                        PriceZero := '.00';


                    if DatItem."War Calculation (LVT)" <> 0 then
                        FirstString += Replacestring_T(format(DatItem.SM3), ',', '.') + PriceZero
                    else
                        FirstString += '';


                    FirstString += Separator;

                    PriceZero := '';

                    if DatItem."War Calculation (LVT)" <> 0 then begin
                        if (ROUND(DatItem."War Calculation (LVT)" / DatItem.SM3) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end else begin
                            for i := 1 to 2 - StrLen(format(DatItem."War Calculation (LVT)" / DatItem.SM3))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DatItem."War Calculation (LVT)" / DatItem.SM3) MOD 1 * 100) = 0 then
                            PriceZero := '.00';
                    end;

                    if DatItem."War Calculation (LVT)" <> 0 then begin

                        if DatItem.SM3 <> 0 then
                            FirstString += Replacestring_T(format(DatItem."War Calculation (LVT)" / DatItem.SM3), ',', '.') + PriceZero
                        else
                            FirstString += format('0.00');
                    end

                    else begin
                        FirstString += '';
                    end;

                    FirstString += Separator;




                    PriceZero := '';


                    if (ROUND(round(DatItem."War Calculation (LVT)", 0.01, '=')) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end else begin
                        for i := 1 to 2 - StrLen(format(round(DatItem."War Calculation (LVT)", 0.01, '=')))
                        do begin
                            PriceZero += '0';

                        end;
                    end;

                    if (ROUND(round(DatItem."War Calculation (LVT)", 0.01, '=')) MOD 1 * 100) = 0 then
                        PriceZero := '.00';


                    if DatItem."War Calculation (LVT)" <> 0 then
                        FirstString += Replacestring_T(format(round(DatItem."War Calculation (LVT)", 0.01, '=')), ',', '.') + PriceZero
                    else
                        FirstString += '';






                    FirstString += Separator;
                    FirstString += Separator;
                    if DatItem."War Calculation (LVT)" <> 0 then
                        FirstString += 'UKUPAN IZNOS RAČUNA;;;;'
                    else
                        FirstString += ';;;;';




                    PriceZero := '';


                    if ((ROUND(DatItem.Total + DatItem."War Calculation (LVT)", 0.01, '=')) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                    end
                    else begin
                        for i := 1 to 2 - StrLen(format(round(DatItem.Total + DatItem."War Calculation (LVT)", 0.01, '=')))
                        do begin
                            PriceZero += '0';

                        end;
                    end;

                    if (ROUND(round(DatItem.Total + DatItem."War Calculation (LVT)", 0.01, '=')) MOD 1 * 100) = 0 then
                        PriceZero := '.00';



                    if DatItem."War Calculation (LVT)" <> 0 then
                        FirstString += Replacestring_T(format(round(DatItem.Total + DatItem."War Calculation (LVT)", 0.01, '=')), ',', '.') + PriceZero
                    else
                        FirstString += '';




                    FirstString += ';(Slovima: KM ';
                    SlovimaRez := MyCU.NumberToWordsBilling(round(DatItem.Total + DatItem."War Calculation (LVT)", 0.01, '='), TRUE);


                    SlovimaRez := UpperCase(copystr(SlovimaRez, 1, 1)) + LowerCase(copystr(SlovimaRez, 2, StrLen(SlovimaRez)));
                    FirstString += SlovimaRez + ')';
                    SaldoPP := ';Saldo prije izdavanja računa;';
                    FirstString += Separator;

                    /*   if (round((DataItem2."Customer Balance"), 0.01, '=') = 0) and (round((DataItem2."Customer Prepayment"), 0.01, '=') = 0) then
                           FirstString += ';Saldo prije izdavanja računa;';
                       if (round(DataItem2."Customer Balance", 0.01, '=')) <> 0 then
                           FirstString += ';Saldo prije izdavanja računa (dugovanje);';

                       if (round(DataItem2."Customer Prepayment", 0.01, '=')) <> 0 then
                           FirstString += ';Saldo prije izdavanja računa (preplata);';*/



                    //samo dug
                    if ("Customer Balance" <> 0) then begin
                        //FirstString += 'Dugovanje ' + FORMAT("Customer Balance");


                        PriceZero := '';

                        decpart := FORMAT(ROUND("Customer Balance") MOD 1 * 100);

                        //djeminaovdje





                        if DataItem2."Customer Balance" <> 0 then begin

                            PriceZero := '';
                            if DataItem2."Customer Balance" <> 0 then begin
                                decpart := FORMAT(ROUND(DataItem2."Customer Balance") MOD 1 * 100);
                                if StrLen(format(ROUND(DataItem2."Customer Balance") MOD 1 * 100)) < 2 then begin

                                    if (ROUND(DataItem2."Customer Balance") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin

                                        for i := 1 to 2 - StrLen(format(ROUND(DataItem2."Customer Balance") MOD 1 * 100))
                                        do begin
                                            PriceZero += '0';
                                        end;
                                    end;
                                    if (ROUND(DataItem2."Customer Balance") MOD 1 * 100) = 0 then
                                        PriceZero := '.00';


                                end;
                            end;

                            FirstString += 'Saldo prije izdavanja računa (dugovanje)';
                            FirstString += Separator;

                            FirstString += format(Replacestring_T(format(DataItem2."Customer Balance"), ',', '.') + PriceZero) + '';
                            FirstString += Separator;
                        end;


                    end
                    else begin
                        if ("Customer Prepayment" <> 0) then begin
                            // FirstString += 'Preplata ' + FORMAT("Customer Prepayment");


                            if "Customer Prepayment" <> 0 then begin
                                PriceZero := '';
                                decpart := FORMAT(ROUND(DataItem2."Customer Prepayment") MOD 1 * 100);
                                if StrLen(FORMAT(ROUND(DataItem2."Customer Prepayment") MOD 1 * 100)) < 2 then begin
                                    if (ROUND(DataItem2."Customer Prepayment") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                                    end else begin
                                        for i := 1 to 2 - StrLen(FORMAT(ROUND(DataItem2."Customer Prepayment") MOD 1 * 100))
                                        do begin
                                            PriceZero += '0';
                                        end;
                                    end;
                                end;
                                if (ROUND(DataItem2."Customer Prepayment") MOD 1 * 100) = 0 then
                                    PriceZero := '.00';


                            end;



                            FirstString += 'Saldo prije izdavanja računa (preplata)';
                            FirstString += Separator;

                            FirstString += format(Replacestring_T(format(DataItem2."Customer Prepayment"), ',', '.') + PriceZero) + '';
                            FirstString += Separator;


                        end
                        else begin

                        end;
                    end;

                    if (DataItem2."Customer Balance" = 0) and (DataItem2."Customer Prepayment" = 0) then begin


                        FirstString += 'Saldo prije izdavanja računa';
                        FirstString += Separator;
                        FirstString += '0.00';
                        FirstString += Separator;

                    end;



                    PriceZero := '';

                    decpart := FORMAT(ROUND("Customer Balance") MOD 1 * 100);

                    //djeminaovdje



                    //


                    PriceZero := '';

                    if DataItem2."Customer Balance" <> 0 then begin
                        decpart := FORMAT(round((DataItem2."Customer Balance" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100);
                        if StrLen(format(round((DataItem2."Customer Balance" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100)) < 2 then begin

                            if (ROUND(round((DataItem2."Customer Balance" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=')) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                            end else begin
                                for i := 1 to 2 - StrLen(format(round((DataItem2."Customer Balance" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100))
                                do begin
                                    PriceZero += '0';
                                end;
                            end;
                            if (round((DataItem2."Customer Balance" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100) = 0 then
                                PriceZero := '.00';


                        end;

                        FirstString += format('Vaš saldo na dan ') + Format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>') + (' (dugovanje)');
                        FirstString += Separator;

                        FirstString += Replacestring_T(format(round((DataItem2."Customer Balance" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=')), ',', '.') + PriceZero;
                        FirstString += Separator;

                    end
                    else begin

                        //dodala

                        if (round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=') = 0) then begin
                            // FirstString += 'Preplata ' + FORMAT("Customer Prepayment");

                            FirstString += format('Vaš saldo na dan ') + Format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>');
                            FirstString += Separator;

                            FirstString += '0.00';
                            FirstString += Separator;

                        end
                        else begin
                            //
                            if (round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=') > 0) then begin
                                // FirstString += 'Preplata ' + FORMAT("Customer Prepayment");

                                decpart := FORMAT(round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100);
                                if StrLen(format(round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100)) < 2 then begin

                                    if (ROUND(round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=')) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                                    end else begin
                                        for i := 1 to 2 - StrLen(format(round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100))
                                        do begin
                                            PriceZero += '0';
                                        end;
                                    end;
                                    if (ROUND(round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=')) MOD 1 * 100) = 0 then
                                        PriceZero := '.00';


                                end;

                                FirstString += format('Vaš saldo na dan ') + Format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>') + (' (preplata)');
                                FirstString += Separator;

                                FirstString += Replacestring_T(format(round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=')), ',', '.') + PriceZero;
                                FirstString += Separator;

                            end
                            else begin

                                if (round((DataItem2."Customer Prepayment") - (DatItem.Total) - (DatItem."War Calculation (LVT)"), 0.01, '=') < 0)
                                and (round(DataItem2."Customer Prepayment", 0.01, '=') <> 0) then begin
                                    // FirstString += 'Preplata ' + FORMAT("Customer Prepayment");

                                    decpart := FORMAT(round((-DataItem2."Customer Prepayment" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100);
                                    if StrLen(format(round((-DataItem2."Customer Prepayment" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100)) < 2 then begin

                                        if (ROUND(round((-DataItem2."Customer Prepayment" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=')) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                                        end else begin
                                            for i := 1 to 2 - StrLen(format(round((-DataItem2."Customer Prepayment" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100))
                                            do begin
                                                PriceZero += '0';
                                            end;
                                        end;
                                        if (round((-DataItem2."Customer Prepayment" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100) = 0 then
                                            PriceZero := '.00';


                                    end;

                                    FirstString += format('Vaš saldo na dan ') + Format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>') + (' (dugovanje)');
                                    FirstString += Separator;

                                    FirstString += Replacestring_T(format(round((-DataItem2."Customer Prepayment" + DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=')), ',', '.') + PriceZero;
                                    FirstString += Separator;
                                end;
                            end;
                        end;

                    end;

                    if (round(DataItem2."Customer Prepayment", 0.01, '=') = 0) and ((round(DataItem2."Customer Balance", 0.01, '=') = 0)) then begin
                        decpart := FORMAT(round((DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100);
                        if StrLen(format(round((DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100)) < 2 then begin

                            if (ROUND(round((DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=')) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin
                            end else begin
                                for i := 1 to 2 - StrLen(format(round((DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100))
                                do begin
                                    PriceZero += '0';
                                end;
                            end;
                            if (round((DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=') MOD 1 * 100) = 0 then
                                PriceZero := '.00';


                        end;

                        FirstString += format('Vaš saldo na dan ') + Format("Calculation Date To", 0, '<day,2>.<month,2>.<year4>') + (' (dugovanje)');
                        FirstString += Separator;

                        FirstString += Replacestring_T(format(round((DatItem.Total + DatItem."War Calculation (LVT)"), 0.01, '=')), ',', '.') + PriceZero;
                        FirstString += Separator;
                    end;

                    CustomerNow.Reset();
                    CustomerNow.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    CustomerNow.SetFilter("Starting Date", '<=%1', DataItem2."Calculation Date To");
                    CustomerNow.SetCurrentKey("Starting Date");
                    CustomerNow.Ascending;
                    if CustomerNow.FindLast() then
                        FirstString += 'Na osnovu ugovora broj ' + CustomerNow.description + ' od ' +
                        Format(CustomerNow."Starting Date", 0, '<day,2>.<month,2>.<year4>') + ';'

                    else
                        FirstString += 'Na osnovu ugovora broj ' + ' ' + ' od ' + ';';

                    FirstString += 'Rok plaćanja: 15 dana od datuma izdavanja računa. Podsjećamo Vas da ste dužni da nas obavijestite o svim promjenama matičnih podataka.;Reklamacije/primjedbe na račun za ';
                    FirstString += 'isporučeni gas podnose se u roku od 8 dana, od datuma prijema računa.;Srednji kurs američkog dolara na dan ';

                    CER.Reset();
                    CER.SetFilter("Currency Code", '%1', DatItem."Currency Code");
                    //  CER.SetFilter("Starting Date", '<=%1', DatItem."Calculation Date To");
                    ChGet2.get(DatItem.Code);

                    if (ChGet2."Month Of GAS Calculation" = DatItem."Month Of GAS Calculation") and (ChGet2."Year Of GAS Calculation" = DatItem."Year Of GAS Calculation") then
                        CER.SetFilter("Starting Date", '<=%1', DatItem."Calculation Date To")
                    else
                        CER.SetFilter("Starting Date", '<=%1', DatItem."Reading Date To");


                    CER.SetCurrentKey("Starting Date");
                    CER.Ascending;

                    if CER.FindLast() then
                        FirstString += Format(CER."Starting Date", 0, '<day,2>.<month,2>.<year4>')
                    else
                        FirstString += '';

                    IntValue2 := ROUND(CER."Relational Exch. Rate Amount" * 5, 1, '<');

                    DecimalValueI := ((CER."Relational Exch. Rate Amount" * 5) MOD 1 * 100000);


                    IntValue := ROUND(DecimalValueI, 1, '<');
                    fORMATnUMBER := FORMAT(IntValue, 0);

                    DecimalRemoveChar := DELCHR(fORMATnUMBER, '=', DELCHR(fORMATnUMBER, '=', '1234567890')); //now, "b" contains only 4567045


                    DecimalRemoveCharRez := FORMAT(PADSTR('', 5 - strlen(format(DecimalRemoveChar)), '0')) + format(DecimalRemoveChar);

                    ///9,04555

                    BrojCharactera := format(IntValue2) + ',' + format(DecimalRemoveCharRez);
                    Charr := 39;

                    DatItemUnique.Reset();
                    DatItemUnique.CopyFilters(DataItem2);
                    DatItemUnique.SetFilter("Old Gauge", '%1', false);
                    DatItemUnique.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    if DatItemUnique.FindFirst() then
                        if (DatItem.SM3 <> 0) then begin
                            FirstString += '.godine.  1 ' + DatItem."Currency Code" + ' = ' +
                            format(CER."Relational Exch. Rate Amount") + ' KM   odnosno    5 ' +
                            format(DatItem."Currency Code") + '= ' +
                            BrojCharactera + ' KM         ' + BrojCharactera + ' KM /1000 ' +
                             'Sm3  odnosno    ' + format((DatItem."War Calculation (LVT)" / DatItem.SM3)) + ' KM / 1 Sm3;' + DatItem.Agreement + ';Za kašnjenje u plaćanju, možemo obračunati zakonom utvrđenu zateznu kamatu.;U slučaju neplaćanja, preduzeti će se zakonske mjere u cilju naplate potraživanja.;' +
                             'Za upoznavanje sa mjerama za racionalno i efikasno korištenje prirodnog gasa, kontakt informacijama organizacija koje mogu pružiti informacije o eventualnim mjerama za poboljšanje energijske efikasnosti kao i uticaju načina potrošnje energenta' +
                             ' na okoliš i održivi razvoj molimo da posjetite našu web stranicu www.sarajevogas.ba, u dijelu ' + format(Charr) + format(Charr) + 'Korisnici' + format(Charr) + format(Charr) + ' – ' + format(Charr) + format(Charr) + 'Energijska efikasnost i prirodni gas' + format(Charr) + format(Charr) + ' i „Prirodni gas i okoliš' + format(Charr) + format(Charr) + '.;U nastavku specifikacija obračuna utrošenog gasa i usluga po mjernom mjestu, sa naznačenim koeficijentom toplotne moći gasa (KH) za mjesec. ' +
                             'Ukupno: ' + format(DatItemUnique.count) + ';;;;' + format(DatItem."Customer No.");

                        end
                        else begin
                            DatItemUniqueSm3Check.Reset();
                            DatItemUniqueSm3Check.SetFilter(Code, '%1', DataItem2.Code);
                            DatItemUniqueSm3Check.SetFilter(SM3, '<>%1', 0);
                            DatItemUniqueSm3Check.SetFilter("War Calculation (LVT)", '<>%1', 0);
                            if DatItemUniqueSm3Check.FindFirst() then begin
                                // DecCalculate := format((DatItemUniqueSm3Check."War Calculation (LVT)" / DatItemUniqueSm3Check.SM3));
                                DecCalculateText := format((DatItemUniqueSm3Check."War Calculation (LVT)" / DatItemUniqueSm3Check.SM3));
                            end
                            else begin

                                Evaluate(DecCalculate, format(round(((CER."Relational Exch. Rate Amount" * 5) / 1000), 0.00001, '='), 0, '<Precision,5:5><Standard Format,0>'));
                                DecCalculate := round(DecCalculate, 0.000001);
                                DecCalculateText := format(DecCalculate);
                            end;


                            FirstString += '.godine.  1 ' + DatItem."Currency Code" + ' = ' +
                                    format(CER."Relational Exch. Rate Amount") + ' KM   odnosno    5 ' +
                                    format(DatItem."Currency Code") + '= ' +
                                    BrojCharactera + ' KM         ' +
                                     format(BrojCharactera) + ' KM /1000 ' +
                                     'Sm3  odnosno    ' + format(DecCalculateText) + ' KM / 1 Sm3;' + DatItem.Agreement + ';Za kašnjenje u plaćanju, možemo obračunati zakonom utvrđenu zateznu kamatu.;U slučaju neplaćanja, preduzeti će se zakonske mjere u cilju naplate potraživanja.;' +
                                     'Za upoznavanje sa mjerama za racionalno i efikasno korištenje prirodnog gasa, kontakt informacijama organizacija koje mogu pružiti informacije o eventualnim mjerama za poboljšanje energijske efikasnosti kao i uticaju načina potrošnje energenta' +
                                     ' na okoliš i održivi razvoj molimo da posjetite našu web stranicu www.sarajevogas.ba, u dijelu ' + format(Charr) + format(Charr) + 'Korisnici' + format(Charr) + format(Charr) + ' – ' + format(Charr) + format(Charr) + 'Energijska efikasnost i prirodni gas' + format(Charr) + format(Charr) + ' i „Prirodni gas i okoliš' + format(Charr) + format(Charr) + '.;U nastavku specifikacija obračuna utrošenog gasa i usluga po mjernom mjestu, sa naznačenim koeficijentom toplotne moći gasa (KH) za mjesec. ' +
                                     'Ukupno: ' + format(DatItemUnique.count) + ';;;;' + format(DatItem."Customer No.");
                        end;



                    //Rd. Br. 0001


                end;




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


                if FirstString <> '' then begin
                    OutStr.WRITETEXT(FirstString);

                    OutStr.WRITETEXT(); // This command is to move to next line
                end;
                FirstString := '';
                if DataItem2."New Gauge" = true then
                    Brojacc += 0
                else
                    Brojacc += 1;
                BrojaccLinijeAdd += 1;
                PriceZero := '';


                if StrLen(format(format(Replacestring_T(format(DataItem2."Calorific power coefficient"), ',', '.')))) < 10 then begin
                    for i := 1 to 10 - StrLen(format(format(Replacestring_T(format(DataItem2."Calorific power coefficient"), ',', '.'))))
                    do begin
                        PriceZero += '0';

                    end;
                end;


                DecPartint := DatItem."Basis maintenance" mod 1 * 100;
                if DecPartint = 0 then
                    AddIn := ',00'
                else
                    AddIn := '';

                PriceZeroCal := '';

                CalorficV := format(Replacestring_T(format("CALORIFIC POWER COEFFICIENT"), ',', '.'));
                if StrLen(CalorficV) < 10 then begin
                    for i := 1 to 10 - StrLen(CalorficV) do begin
                        PriceZeroCal += '0';
                    end;
                end;

                //
                PriceZero1 := '';


                if ((DataItem2."GAS - amount") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                end
                else begin
                    for i := 1 to 2 - StrLen(format(DataItem2."GAS - amount"))
                    do begin
                        PriceZero1 += '0';

                    end;
                end;

                if (ROUND(DataItem2."GAS - amount") MOD 1 * 100) = 0 then
                    PriceZero1 := '.00';
                //

                //
                PriceZero2 := '';


                if ((DataItem2."GAS - VAT") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                end
                else begin
                    for i := 1 to 2 - StrLen(format(DataItem2."GAS - VAT"))
                    do begin
                        PriceZero2 += '0';

                    end;
                end;

                if (ROUND(DataItem2."GAS - VAT") MOD 1 * 100) = 0 then
                    PriceZero2 := '.00';
                //

                PriceZero3 := '';


                if ((DataItem2."Basis maintenance") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                end
                else begin
                    for i := 1 to 2 - StrLen(format(DataItem2."Basis maintenance"))
                    do begin
                        PriceZero3 += '0';

                    end;
                end;

                if (ROUND(DataItem2."Basis maintenance") MOD 1 * 100) = 0 then
                    PriceZero3 := '.00';
                //

                //

                PriceZero4 := '';


                if ((DataItem2."Maintenance VAT") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                end
                else begin
                    for i := 1 to 2 - StrLen(format(DataItem2."Maintenance VAT"))
                    do begin
                        PriceZero4 += '0';

                    end;
                end;

                if (ROUND(DataItem2."Maintenance VAT") MOD 1 * 100) = 0 then
                    PriceZero4 := '.00';
                //


                PriceZero5 := '';


                if ((DataItem2."Maintenance - part") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                end
                else begin
                    for i := 1 to 2 - StrLen(format(DataItem2."Maintenance - part"))
                    do begin
                        PriceZero5 += '0';

                    end;
                end;

                if (ROUND(DataItem2."Maintenance - part") MOD 1 * 100) = 0 then
                    PriceZero5 := '.00';
                //

                PriceZero6 := '';


                if ((DataItem2.Total) MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                end
                else begin
                    for i := 1 to 2 - StrLen(format(DataItem2.Total))
                    do begin
                        PriceZero6 += '0';

                    end;
                end;

                if (ROUND(DataItem2.Total) MOD 1 * 100) = 0 then
                    PriceZero6 := '.00';
                //

                if (DataItem2."New Value" = 0) and (DataItem2."Source Data" = DataItem2."Source Data"::Unobvious) then
                    TextNewGauge := format('−')
                else
                    TextNewGauge := format(DataItem2."New Value");

                if (strpos(DataItem2."Address MM", 'BB') <> 0) or ((strpos(DataItem2."Address MM", 'BB') = 0)) then begin
                    if (strpos(DataItem2."Street No. Text MM", 'BB') <> 0) and (strpos(DataItem2."Street No. Text MM", 'bb') <> 0) then begin
                        DataItem2."Address MM" := delchr(DataItem2."Address MM", '=', DataItem2."Street No. Text MM");

                    end;
                end;

                if DataItem2."Street No. Text MM" <> ''
                then begin

                    FirstString += 'D1;' + formaT(Brojacc) + ';';
                    FirstString += format(DataItem2."Measuring Point Code") + ' ' +
                    Replacestring_TName(DataItem2."MM Description", ';', ',') + ';' + DataItem2."Address MM" + ', ' + DataItem2."Street No. Text MM" +
                    ';' + DataItem2."Gauge Size" + ' - ' + DataItem2."Serial Number" + ';' +
                    'Prosjek kategorije ' + DataItem2."EF Activity" + ': ' +
                    Format(DataItem2."Average Calculation") + ' Sm3;Vaša potrošnja za ' +
                    delchr(Mjesec[1], '=', FORMAT(DATE2DMY("Calculation Date To", 3))) + format("Year Of GAS Calculation" - 1)
                     + ': ' +
                    Replacestring_T(format(DataItem2."Last Year Calculation"), ',', '.') + ' Sm3;;Potrošnja: ('
                    + TextNewGauge + ' - ' + format(DataItem2."Old Value") + ')'
                    + ' * ' + Replacestring_T(format(DataItem2."Calorific power coefficient"), ',', '.') + PriceZeroCal + ' = ' +
                    Replacestring_T(format(DataItem2.SM3), ',', '.') + ' * ' + Replacestring_T(format(DataItem2."Unit Price"), ',', '.')
                     + ';' +
                     Replacestring_T(format(DataItem2."GAS - amount"), ',', '.') + PriceZero1 + ';Iznos PDV-a 17%;' +
                     Replacestring_T(format(DataItem2."GAS - VAT"), ',', '.') + PriceZero2 + ';Naknada za mjerno mjesto: ' +
                     Replacestring_T(format(DataItem2."Basis maintenance"), ',', '.') + PriceZero3 + ' + Iznos PDV-a 17 % (' +
                     Replacestring_T(format(DataItem2."Maintenance VAT"), ',', '.') + PriceZero4 + ');' +
                     Replacestring_T(format(DataItem2."Maintenance - part"), ',', '.') + PriceZero5 + ';UKUPNO ZADUŽENJE KM _ _ _ _ _;' +
                    Replacestring_T(format(DataItem2.Total), ',', '.') + PriceZero6;

                end
                else begin
                    FirstString += 'D1;' + formaT(Brojacc) + ';';
                    FirstString += format(DataItem2."Measuring Point Code") + ' ' +
                    Replacestring_TName(DataItem2."MM Description", ';', ',') + ';' + DataItem2."Address MM" + ',' +
                    ';' + DataItem2."Gauge Size" + ' - ' + DataItem2."Serial Number" + ';' +
                    'Prosjek kategorije ' + DataItem2."EF Activity" + ': ' +
                    Format(DataItem2."Average Calculation") + ' Sm3;Vaša potrošnja za ' +
                    delchr(Mjesec[1], '=', FORMAT(DATE2DMY("Calculation Date To", 3))) + format("Year Of GAS Calculation" - 1)
                     + ': ' +
                    Replacestring_T(format(DataItem2."Last Year Calculation"), ',', '.') + ' Sm3;;Potrošnja: ('
                    + TextNewGauge + ' - ' + format(DataItem2."Old Value") + ')'
                    + ' * ' + Replacestring_T(format(DataItem2."Calorific power coefficient"), ',', '.') + PriceZeroCal + ' = ' +
                     Replacestring_T(format(DataItem2.SM3), ',', '.') + ' * ' + Replacestring_T(format(DataItem2."Unit Price"), ',', '.')
                     + ';' +
                     Replacestring_T(format(DataItem2."GAS - amount"), ',', '.') + PriceZero1 + ';Iznos PDV-a 17%;' +
                     Replacestring_T(format(DataItem2."GAS - VAT"), ',', '.') + PriceZero2 + ';Naknada za mjerno mjesto: ' +
                     Replacestring_T(format(DataItem2."Basis maintenance"), ',', '.') + PriceZero3 + ' + Iznos PDV-a 17 % (' +
                     Replacestring_T(format(DataItem2."Maintenance VAT"), ',', '.') + PriceZero4 + ');' +
                     Replacestring_T(format(DataItem2."Maintenance - part"), ',', '.') + PriceZero5 + ';UKUPNO ZADUŽENJE KM _ _ _ _ _;' +
                    Replacestring_T(format(DataItem2.Total), ',', '.') + PriceZero6;

                end;

                if FirstString <> '' then begin
                    OutStr.WRITETEXT(FirstString);

                    OutStr.WRITETEXT(); // This command is to move to next line
                end;
                FirstString := '';



                //M1;BAJRIĆ SAFET VL.POSLOVNOG PROSTORA;KRANJČEVIĆEVA 7;15.04.2024;23.49;31.03.2024;Mart 2024.;
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


                if (DataItem2."Customer Balance" >= ReminderV) and (BrojaccLinijeAdd = NumberMM) and (DataItem2."Measuring point off" = false) then begin

                    RHeader.Reset();
                    RHeader.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                    RHeader.SetFilter(WH, '%1', DataItem2.Code);
                    if RHeader.FindFirst() then begin

                        FirstString := '';
                        //sada ispod dodajem opomenu
                        FirstString += 'M1';
                        FirstString += Separator;

                        FirstString += Replacestring_TName(DataItem2."Customer Name", ';', ',');
                        FirstString += Separator;
                        FirstString += DataItem2."Address 2";
                        //djemina ovdje adresa
                        if DataItem2."Street No.2 Text" <> '' then
                            FirstString += ', ' + DataItem2."Street No.2 Text";



                        if DataItem2."Floor Customer 2" <> '' then
                            FirstString += ', ' + DataItem2."Floor Customer 2";
                        FirstString += Separator;


                        FirstString += Format(CalcDate('<+15D>', DataItem2."Calculation Date To"), 0, '<day,2>.<month,2>.<year4>');
                        FirstString += Separator;

                        //
                        PriceZero := '';


                        if ((DataItem2."Customer Balance") MOD 1 * 100) in [1, 2, 3, 4, 5, 6, 7, 8, 9] then begin

                        end
                        else begin
                            for i := 1 to 2 - StrLen(format(DataItem2."Customer Balance"))
                            do begin
                                PriceZero += '0';

                            end;
                        end;

                        if (ROUND(DataItem2."Customer Balance") MOD 1 * 100) = 0 then
                            PriceZero := '.00';
                        //



                        FirstString += Replacestring_T(Format(DataItem2."Customer Balance"), ',', '.') + PriceZero;
                        FirstString += Separator;
                        FirstString += Format(CalcDate('<+0D>', DataItem2."Calculation Date To"), 0, '<day,2>.<month,2>.<year4>');
                        FirstString += Separator;
                        FirstString += Mjesec[1] + '.;';

                        //datum kreiranja opomene (provjeriti informaciju);
                        if FirstString <> '' then begin
                            OutStr.WRITETEXT(FirstString);

                            OutStr.WRITETEXT(); // This command is to move to next line
                        end;
                        FirstString += '';


                    end;

                end;










            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
                NoSeries: Record "No. Series Line";
            begin
                //   SetCurrentKey("Municipality Name Customer 2", "Street Name Customer 2", "Street No. int", "Street No.2 Text", "Apartment No. Customer 2");

                SetCurrentKey("Customer Stroke 2", "Customer string 2", "Municipality Name Customer 2", "Street Name Customer 2", "Street No.2 int", "Street No.2 Text", "Street No. Text Apartment", "Apartment No. Customer 2", "Customer No. int", "Calculation Date To", "Reading Date To");
                // SetCurrentKey("Municipality Name Customer 2", "Street Name Customer 2", "Street No.2 int", "Street No.2 Text", "Street No. Text Apartment", "Apartment No. Customer 2", "Customer No. int", "Calculation Date To");
                Ascending(true);
                Progress.OPEN('Startno vrijeme pokretanja izvještaja je ' + format(time) + '. Ukupan broj ažuriranja je ------ #1');
                Progress.UPDATE(1, 0);
                NoSeries.Reset();
                Commit();
                NoSeries.SetFilter("Series Code", '%1', 'RED_B');
                NoSeries.SetFilter("Last No. Used", '<>%1', '');
                if NoSeries.FindFirst() then begin
                    NoSeries."Last No. Used" := '';
                    NoSeries.Modify();
                    Commit();
                end;


            end;


        }
        /*   dataitem("Customer Ledger Entry"; "Customer Ledger Entry")
           {

               trigger OnAfterGetRecord()
               var
                   myInt: Integer;
               begin
                   FirstString := '';
                   FirstString += 'U1';
                   FirstString += Separator;
                   FirstString += "Customer No.";
                   FirstString += Separator;
                   FirstString += "Customer Name";
                   FirstString += Separator;
                   if FirstString <> '' then begin
                       OutStr.WRITETEXT(FirstString);

                       OutStr.WRITETEXT(); // This command is to move to next line
                   end;
                   FirstString += '';

               end;



           }*/

    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Charr := 9;
        Separator := ';';

        FileName := 'Ocitavanje.txt';
        TempBlob.CreateOutStream(OutStr, TextEncoding::Windows);
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
            );
        );
    );
           FirstString += 'Status očitanja';*/
        //  OutStr.WRITETEXT(FirstString);







        //   OutStr.WRITETEXT(); // This command is to move to next line

    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        TempBlob.CreateInStream(Instr, TextEncoding::Windows);
        DownloadFromStream(Instr, '', '', '', FileName);

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
        ReminderV: Decimal;

        FirstString: Text;
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        Content_M: Text;
        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        transaction1: text[100];
        transaction3: text[100];

        transaction3Name: text[100];

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
        Charr: Char;
        SlovimaRez: Text;
        MyCU: Codeunit TestSubsCu;
        Separator: text[250];
        PriceZero: text[250];
        RezValueE: Decimal;
        CompanyInf: Record "Company Information";
        i: Integer;
        banacc: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        Progress: Dialog;
        Rez: Decimal;
        Mjesec: array[12] of Text;
        decpart: Text;
        SaldoPP: Text;
        BrojacRandom: Integer;
        DecimalV2: text[250];
        decimalV2E: Decimal;
        DataItemUniqEmpty: Record "Calculation Journal Line";
        CustTemporary: Record Position temporary;

        CustomerNow: Record "Customer Ledger Entry";
        CER: Record "Currency Exchange Rate";
        Brojacc: Integer;
        BrojaccLinijeAdd: Integer;
        PowerText: text;
        BrojacRedova: Decimal;
        IntValue: Decimal;
        IntValue2: Decimal;
        DecimalValueI: Decimal;

        CalorficV: Text;
        PriceZeroCal: text;
        PriceZero1: text;
        PriceZero2: text;
        PriceZero3: text;
        DecimalRemoveChar: Text;
        PriceZero4: text;
        PriceZero5: text;
        PriceZero6: text;
        DecPartint: Integer;
        BrojCharactera: text;
        DecimalRemoveCharRez: Text;
        fORMATnUMBER: TEXT;
        AddIn: Text;
        RHeader: Record "Reminder Header";
        DecCalculate: Decimal;
        DecCalculateText: Text;
        TextNewGauge: Text;






}

