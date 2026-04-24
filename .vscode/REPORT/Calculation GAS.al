report 50209 "Calculation GAS"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                CustP: Record Customer;
                Percc: Decimal;
                PercMM: Decimal;
                CHWin: Record "Calcuation Header";
                MMPerc: Record "Service Item";
                MMF: Record "Service Item";
                CustInternal: Record Customer;
                CalJournal: Record "Calculation Journal Line";
            begin


                CalcSetup.get;
                CustP.Reset();
                CustP.SetFilter("No.", '%1', "Calculation Journal Line"."Customer No.");
                if CustP.FindFirst() then
                    Percc := CustP."Bill distribution percentage";



                CHWin.reset;
                CHWin.setfilter(Code, '%1', "Calculation Journal Line".code);
                if CHWin.findfirst then begin
                    MMPerc.Reset();
                    MMPerc.SetFilter("No.", '%1', "Calculation Journal Line"."Measuring Point Code");
                    if MMPerc.FindFirst() then begin
                        if CHWin."Summer or Winter Zone" = CHWin."Summer or Winter Zone"::Summer then begin
                            PercMM := MMPerc."Summer Pecentage";
                            "Calculation Journal Line"."Summer Pecentage" := PercMM;
                        end;
                        if CHWin."Summer or Winter Zone" = CHWin."Summer or Winter Zone"::Winter then begin
                            PercMM := MMPerc."Winter Pecentage";
                            "Calculation Journal Line"."Winter Pecentage" := PercMM;

                        end;

                    end;


                end;


                FirstString := '';

                CalcSetup.get;
                CH.Reset();
                CH.SetFilter(Code, '%1', "Calculation Journal Line".Code);

                if ch.FindSet() then begin

                    if "Calculation Journal Line"."Calculation Date From" = 0D then
                        "Calculation Journal Line"."Calculation Date From" := ch."Calculation Date From";
                    if "Calculation Journal Line"."Calculation Date To" = 0D then
                        "Calculation Journal Line"."Calculation Date To" := ch."Calculation Date To";

                    if "Calculation Journal Line"."Reading Date From" = 0D then
                        "Calculation Journal Line"."Reading Date From" := ch."Calculation Date From";

                    if "Calculation Journal Line"."Reading Date To" = 0D then
                        "Calculation Journal Line"."Reading Date To" := ch."Calculation Date To";

                    if (ch."Month Of GAS Calculation" = "calculation journal line"."Month Of GAS Calculation")
                                and (ch."Year Of GAS Calculation" = "calculation journal line"."Year Of GAS Calculation") then begin
                        "calculation journal line".KOEKAL := CalcSetup."Calorific power coefficient";
                        "calculation journal line"."Calorific power coefficient" := CalcSetup."Calorific power coefficient";
                    end
                    else begin
                        CalJournal.Reset();
                        CalJournal.SetFilter("Month Of GAS Calculation", '%1', "calculation journal line"."Month Of GAS Calculation");
                        CalJournal.SetFilter("Year Of GAS Calculation", '%1', "calculation journal line"."Year Of GAS Calculation");
                        CalJournal.SetFilter("Measuring Point Code", '%1', "calculation journal line"."Measuring Point Code");
                        CalJournal.SetFilter(Code, '<>%1', "calculation journal line".Code);
                        if CalJournal.FindFirst() then begin
                            "calculation journal line"."Calorific power coefficient" := CalJournal."Calorific power coefficient";
                            "calculation journal line".KOEKAL := CalJournal."Calorific power coefficient";

                        end
                        else begin
                            CalJournal.Reset();
                            CalJournal.SetFilter("Month Of GAS Calculation", '%1', "calculation journal line"."Month Of GAS Calculation");
                            CalJournal.SetFilter("Year Of GAS Calculation", '%1', "calculation journal line"."Year Of GAS Calculation");
                            if
                            CalJournal.FindFirst() then
                                "calculation journal line"."Calorific power coefficient" := CalJournal."Calorific power coefficient";
                            "calculation journal line".KOEKAL := CalJournal."Calorific power coefficient";
                        end;

                    end;

                end;


                if "Method of calculation" = "Method of calculation"::"3" then begin
                    validate(SM3, round((("CorRection new- gauge" - "CorRection previous - gauge") * "Calorific power coefficient"), 0.01, '='));
                end;


                if "Method of calculation" = "Method of calculation"::"2" then begin
                    A := "New Value" - "Old Value";

                    if PercMM <> 0 then begin

                        DecimalV := (PercMM / 100) * ("New Value" - "Old Value");
                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                        if Evaluate(DecimalV2E, DecimalV2) then begin
                            if DecimalV2E > 50 then
                                A := Round((PercMM / 100) * ("New Value" - "Old Value"), 1, '>')
                            else
                                A := Round((PercMM / 100) * ("New Value" - "Old Value"), 1, '<')

                        end;


                    end;

                    if CalcSetup."PS Constant" <> 0 then
                        B := round(round(("Pressure result- gauge" + "Atmospheric pressure"), 0.0001, '=') / CalcSetup."PS Constant", 0.0001, '=')
                    else
                        B := round(("Pressure result- gauge" + "Atmospheric pressure"), 0.0001, '=');
                    c := round(CalcSetup."TS Constant" / (CalcSetup."Absolute zero" + ("Temperature new- gauge" + "Temperature previous - gauge") / 2) * CalcSetup.JEDKS, 0.0001, '=');

                    validate(SM3, round((A * B * C) * "Calorific power coefficient", 0.01, '='));
                end;
                if "Method of calculation" = "Method of calculation"::"1" then begin
                    if ("Category MM" = "Category MM"::"Large Economy") or ("Category MM" = "Category MM"::"KJKP Heating plant")

                     then begin

                        if PercMM <> 0 then begin

                            A := (PercMM / 100) * ("New Value" - "Old Value");


                            DecimalV := (PercMM / 100) * ("New Value" - "Old Value");
                            DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                            if Evaluate(DecimalV2E, DecimalV2) then begin
                                if DecimalV2E > 50 then
                                    A := Round((PercMM / 100) * ("New Value" - "Old Value"), 1, '>')
                                else
                                    A := Round((PercMM / 100) * ("New Value" - "Old Value"), 1, '<')



                            end;

                            validate(SM3, Round(A * "Calorific power coefficient", 0.01, '='));

                        end
                        else begin
                            validate(SM3, Round(("New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='));
                        end;

                    end
                    else begin

                        DecimalV := ("New Value" - "Old Value") * "Calorific power coefficient";
                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                        if Evaluate(DecimalV2E, DecimalV2) then begin
                            if DecimalV2E > 50 then
                                validate(SM3, Round(("New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='))
                            else
                                validate(SM3, Round(("New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='));

                        end;
                    end;
                end;
                //održavanje
                ch.get(Code);
                if Percc <> 0 then SM3 := Percc * SM3 / 100;



                CustomerPrice.Reset;
                CustomerPrice.SetFilter("No.", '%1', "Customer No.");
                if CustomerPrice.FindFirst() then begin
                    SP.Reset();
                    sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                    sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                    sp.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Reading Date To");
                    sp.SetCurrentKey("Starting Date");
                    sp.Ascending;
                    if sp.FindLast() then begin
                        "Unit Price" := SP."Unit Price";
                        "Purchase Unit Price" := sp."Purchase unit price";
                        "Distribution Unit Price" := sp."Unit price of distribution";
                        "Sales Unit Price" := sp."Unit Price";



                        if ("Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Large Economy")
                        or ("Calculation Journal Line"."Category MM" = "Calculation Journal Line"."Category MM"::"KJKP Heating plant") then begin


                            if sp."Price not by Gauge" = true then begin
                            end
                            else begin
                                ///ĐEMINA
                                TypeD.Reset();
                                TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                                TypeD.SetFilter("Description", '%1', "Calculation Journal Line"."Gauge Size");
                                if TypeD.FindFirst() then begin
                                    if "Calculation Journal Line"."EL Volume Description" <> '' then
                                        sp."Maintenance Resource No." := TypeD."Maintenance Resource No."
                                    else
                                        sp."Maintenance Resource No." := TypeD."Maintenance Resource without";
                                end;
                            end;

                        end;



                        Reso.Reset();
                        Reso.SetFilter("No.", '%1', SP."Maintenance Resource No.");
                        if Reso.FindFirst() then begin
                            if ch."Sales invoice Without M" = false then
                                "Basis maintenance" := Reso."Unit Price"
                            else
                                "Basis maintenance" := 0;

                            if (Percc <> 0) then
                                "Basis maintenance" := Percc * "Basis maintenance" / 100;



                            "Basis Resource Code" := Reso."No.";

                            if "Old Gauge" = true then begin
                                "Basis maintenance" := 0;
                                "Basis Resource Code" := '';
                            end;

                            if "Status MM" = "Status MM"::Terminated then begin
                                "Basis maintenance" := 0;
                                "Basis Resource Code" := '';
                            end;


                            if (Unobvious = true) and ("Previous Unobvious Month" = 0) then begin
                                if "Bill distribution percentage" = 0 then begin
                                    "Basis maintenance" := 0;
                                    "Basis Resource Code" := '';
                                end;
                            end;

                            if ("Customer No.") = '200359' then begin
                                "Basis maintenance" := 0;
                                "Basis Resource Code" := '';
                            end;


                            VPS.Reset();
                            vps.SetFilter("VAT Prod. Posting Group", '%1', Reso."VAT Prod. Posting Group");
                            if CU.get("Customer No.") then
                                VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
                            if (VPS.FindFirst()) and (CH."Sales Invoice without VAT" = false) then begin
                                "Maintenance VAT" := round(("Basis maintenance" * VPS."VAT %") / 100, 0.01, '=');
                                "Main. VAT Percentage" := VPS."VAT %";
                            end
                            else begin
                                "Maintenance VAT" := 0;
                                "Main. VAT Percentage" := 0;
                            end;


                            if ch."Sales invoice Without M" = true then begin
                                "Maintenance VAT" := 0;
                                "Main. VAT Percentage" := 0;
                            end;

                            MMF.Reset();
                            MMF.SetFilter("No.", '%1', "Measuring Point Code");
                            if mmf.FindFirst() then begin
                                if MMF."MM VAT Excluded" = true then
                                    "Maintenance VAT" := 0;
                            end;

                            if cu."Cust VAT Excluded" = true then
                                "Maintenance VAT" := 0;

                        end
                        else begin
                            "Basis maintenance" := 0;
                            "Maintenance VAT" := 0;
                        end;


                    end;
                end;

                "Maintenance - part" := "Basis maintenance" + "Maintenance VAT";

                //kraj
                "Calculation Journal Line"."Currency Code" := '';
                "Calculation Journal Line"."War Resource Code" := '';

                WarDebt.Reset();
                WarDebt.SetFilter(Month, '%1', "Calculation Journal Line"."Month Of GAS Calculation");
                WarDebt.SetFilter(Active, '%1', true);
                WarDebt.SetFilter("Customer Category", '%1', "Calculation Journal Line"."Category Customer");
                WarDebt.SetFilter(Totaling, '%1', '');

                if WarDebt.FindSet() then
                    repeat
                        Resource.Reset();
                        Resource.SetFilter("No.", '%1', WarDebt.Resource);
                        if Resource.FindFirst() then begin
                            rp.reset;
                            rp.SetFilter(Type, '%1', rp.Type::Resource);
                            rp.SetFilter(Code, '%1', WarDebt.Resource);
                            rp.SetFilter("Currency Code", '%1', WarDebt."Currency Code");
                            if rp.FindFirst() then
                                UnitP := rp."Unit Price";
                        end;


                        if "Calculation Journal Line".SM3 <> 0 then
                            "Calculation Journal Line".SM3 := 0;
                        if "Calculation Journal Line"."Manualy War Value" = false then begin
                            if WarDebt.CBM <> 0 then
                                "Calculation Journal Line"."War Calculation" := "Calculation Journal Line".SM3 * UnitP / WarDebt.CBM
                            else
                                "Calculation Journal Line"."War Calculation" := 0;
                        end;
                        "Calculation Journal Line"."War Resource Code" := WarDebt.Resource;
                        "Calculation Journal Line"."Currency Code" := WarDebt."Currency Code";
                        if "Calculation Journal Line"."Currency Code" = '' then begin
                            "Calculation Journal Line"."War Calculation (LVT)" := "Calculation Journal Line"."War Calculation";
                        end
                        else begin
                            //naći currency
                            if "Calculation Journal Line"."Manualy War Value" = false then begin
                                CER.Reset();
                                CER.SetFilter("Currency Code", '%1', "Calculation Journal Line"."Currency Code");
                                //   CER.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Calculation Date To");

                                if (ch."Month Of GAS Calculation" = "Calculation Journal Line"."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = "Calculation Journal Line"."Year Of GAS Calculation") then
                                    CER.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Calculation Date To")
                                else
                                    CER.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Reading Date To");


                                CER.SetCurrentKey("Starting Date");
                                CER.Ascending;
                                if CER.FindLast() then begin
                                    if "Calculation Journal Line".SM3 < 0 then
                                        "Calculation Journal Line".SM3 := 0;
                                    "Calculation Journal Line"."War Calculation (LVT)" :=
                                    //(("Calculation Journal Line".SM3 * UnitP / WarDebt.CBM) * CER."Relational Exch. Rate Amount");
                                    "Calculation Journal Line".SM3 * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=');

                                    "Calculation Journal Line"."War Resource Code" := WarDebt.Resource;
                                    //"Calculation Journal Line"."War Calculation" * CER."Relational Exch. Rate Amount";
                                end;
                            end;
                        end;


                    until WarDebt.Next() = 0;


                WarDebt.Reset();
                WarDebt.SetFilter(Month, '%1', "Calculation Journal Line"."Month Of GAS Calculation");
                WarDebt.SetFilter(Active, '%1', true);
                WarDebt.SetFilter("Customer Category", '%1', "Calculation Journal Line"."Category Customer");
                WarDebt.SetFilter(Totaling, '<>%1', '');
                if WarDebt.FindSet() then
                    repeat
                        CJL2.Reset();
                        // CJL2.SetFilter("Customer No.", '%1', CalcJ."Customer No.");
                        CJL2.SetFilter("Month Of GAS Calculation", WarDebt.Totaling);
                        //  CJL2.SetFilter(Code, '<>%1', "Calculation Journal Line".Code);
                        CJL2.SetFilter("Year Of GAS Calculation", '%1', "Calculation Journal Line"."Year Of GAS Calculation");
                        CJL2.SetFilter("Measuring Point Code", '%1', "Calculation Journal Line"."Measuring Point Code");
                        //   CJL2.SetFilter(Gauge, '%1', "Calculation Journal Line".Gauge);
                        if CJL2.FindFirst() then
                            CJL2.CalcSums(CJL2.SM3);

                        Resource.Reset();
                        Resource.SetFilter("No.", '%1', WarDebt.Resource);
                        if Resource.FindFirst() then begin
                            rp.reset;
                            rp.SetFilter(Type, '%1', rp.Type::Resource);
                            rp.SetFilter(Code, '%1', WarDebt.Resource);
                            rp.SetFilter("Currency Code", '%1', WarDebt."Currency Code");
                            if rp.FindFirst() then
                                UnitP := rp."Unit Price";
                        end;
                        //ukupna količina
                        if "Calculation Journal Line".SM3 < 0 then
                            "Calculation Journal Line".SM3 := 0;
                        if CJL2.sm3 < 0 then
                            CJL2.sm3 := 0;

                        if "Calculation Journal Line"."Manualy War Value" = false then begin
                            if WarDebt.CBM <> 0 then
                                "Calculation Journal Line"."War Calculation" := (CJL2.SM3) * UnitP / WarDebt.CBM
                            else
                                "Calculation Journal Line"."War Calculation" := 0;
                        end;
                        "Calculation Journal Line"."Currency Code" := WarDebt."Currency Code";
                        "Calculation Journal Line"."War Resource Code" := WarDebt.Resource;
                        if "Calculation Journal Line"."Currency Code" = '' then begin
                            "Calculation Journal Line"."War Calculation (LVT)" := "Calculation Journal Line"."War Calculation";
                        end
                        else begin
                            //naći currency
                            if "Calculation Journal Line"."Manualy War Value" = false then begin
                                CER.Reset();
                                CER.SetFilter("Currency Code", '%1', "Calculation Journal Line"."Currency Code");
                                //   CER.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Calculation Date To");

                                if (ch."Month Of GAS Calculation" = "Calculation Journal Line"."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = "Calculation Journal Line"."Year Of GAS Calculation") then
                                    CER.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Calculation Date To")
                                else
                                    CER.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Reading Date To");

                                CER.SetCurrentKey("Starting Date");
                                CER.Ascending;
                                if CER.FindLast() then begin
                                    if "Calculation Journal Line".SM3 < 0 then
                                        "Calculation Journal Line".SM3 := 0;

                                    if WarDebt.CBM <> 0 then
                                        "Calculation Journal Line"."War Calculation (LVT)" := (CJL2.SM3) * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=')
                                    else
                                        "Calculation Journal Line"."War Calculation (LVT)" := 0;

                                    "Calculation Journal Line"."War Resource Code" := WarDebt.Resource;
                                    //"Calculation Journal Line"."War Calculation" * CER."Relational Exch. Rate Amount";
                                end;

                            end;
                        end;
                    until WarDebt.Next() = 0;


                CustInternal.Reset();
                CustInternal.SetFilter("No.", '%1', "Calculation Journal Line"."Customer No.");
                if CustInternal.FindFirst() then begin
                    if CustInternal."Internal Customer" = True then begin
                        "Calculation Journal Line"."War Calculation" := 0;
                        "Calculation Journal Line"."War Calculation (LVT)" := 0;
                        "Calculation Journal Line"."War Resource Code" := '';
                    end;
                end;

                "Calculation Journal Line"."Subsidies Amount" := 0;
                "Calculation Journal Line"."Subsidies VAT Amount" := 0;
                "Calculation Journal Line"."Subsidies Total Amount" := 0;
                //subvencija
                CalSetup.get;
                if (CalSetup."Subsidies Date from" <> 0D) and (CalSetup."Subsidies Date to" = 0D)
  and ("Reading Date From" >= CalSetup."Subsidies Date from") then
                    Subs := true;

                if (CalSetup."Subsidies Date from" <> 0D) and (CalSetup."Subsidies Date to" <> 0D)
               and ("Reading Date To" <= CalSetup."Subsidies Date to")
               and ("Reading Date From" >= CalSetup."Subsidies Date From") then
                    Subs := true;

                CustomerPrice.Reset();
                CustomerPrice.SetFilter("No.", '%1', "Calculation Journal Line"."Customer No.");
                if CustomerPrice.FindFirst() then begin
                    if (CustomerPrice."Subsidies - has statement" = CustomerPrice."Subsidies - has statement"::Yes) and (CustomerPrice."Subsidies - YES/NO" = CustomerPrice."Subsidies - YES/NO"::Yes) and (Subs = true) then begin
                        "Calculation Journal Line"."Deminimis Act Date" := CalSetup."Deminimis Act Date";
                        "Calculation Journal Line"."Deminimis Act Name" := CalSetup."Deminimis Act Name";
                        "Calculation Journal Line"."Deminimis Act Number" := CalSetup."Deminimis Act Number";
                        "Calculation Journal Line"."Deminimis Legal act" := CalSetup."Deminimis Legal act";
                        "Calculation Journal Line"."Deminimis Purpose" := CalSetup."Deminimis Purpose";
                        "Calculation Journal Line"."Deminimis Remark" := CalSetup."Deminimis Remark";
                        Resource.Reset();
                        Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                        if Resource.FindFirst() then begin
                            VatPostingSetup.reset;
                            VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                            VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                            if VatPostingSetup.FindFirst() then begin
                                if "Calculation Journal Line".SM3 < 0 then
                                    "Calculation Journal Line".SM3 := 0;
                                "Calculation Journal Line"."Subsidies Amount" := "Calculation Journal Line".SM3 * CalSetup.Subsidies;
                                "Calculation Journal Line"."Subsidies VAT Amount" := 0;
                                "Calculation Journal Line"."Subsidies VAT Amount" := "Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                "Calculation Journal Line"."Subsidies Total Amount" := "Calculation Journal Line"."Subsidies Amount" + "Calculation Journal Line"."Subsidies VAT Amount";
                            end;
                        end;

                        "Calculation Journal Line".Subsidies := true;
                        if "Calculation Journal Line".SM3 < 0 then
                            "Calculation Journal Line".SM3 := 0;
                        "Calculation Journal Line"."Subsidies Amount" := "Calculation Journal Line".SM3 * CalSetup.Subsidies;
                    end
                    else begin

                        "Calculation Journal Line"."Deminimis Act Date" := 0D;
                        "Calculation Journal Line"."Subsidies Amount" := 0;
                        "Calculation Journal Line"."Deminimis Act Name" := '';
                        "Calculation Journal Line"."Deminimis Act Number" := '';
                        "Calculation Journal Line"."Deminimis Legal act" := '';
                        "Calculation Journal Line"."Deminimis Purpose" := '';
                        "Calculation Journal Line"."Deminimis Remark" := '';

                        "Calculation Journal Line"."Subsidies VAT Amount" := 0;
                        "Calculation Journal Line"."Subsidies Total Amount" := 0;
                        "Calculation Journal Line".Subsidies := false;


                    end;


                    if "Calculation Journal Line".Subsidies = true then begin

                        Resource.Reset();
                        Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                        if Resource.FindFirst() then begin
                            VatPostingSetup.reset;
                            VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                            VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                            if VatPostingSetup.FindFirst() then begin
                                "Calculation Journal Line"."Subsidies VAT Amount" := "Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                "Calculation Journal Line"."Subsidies Total Amount" := "Calculation Journal Line"."Subsidies Amount" + "Calculation Journal Line"."Subsidies VAT Amount";
                            end;
                        end;
                        if "Calculation Journal Line"."Subsidies Amount" <> 0 then
                            //sad da izračun PDV
                            "Calculation Journal Line".Subsidies := true
                        else
                            "Calculation Journal Line".Subsidies := false;

                    end;
                end;
                //kraj
                if "Calculation Journal Line"."Basis Resource Code" = '' then begin
                    BasisCodeText := ';' + ' ' + ';';

                end
                else begin
                    BasisCodeText := ';' + Format("Calculation Journal Line"."Basis Resource Code")
                 + ';';
                end;

                if "Calculation Journal Line"."War Resource Code" = '' then begin
                    WarCodeText := ' ;' + ' ' + ';'

                end
                else begin
                    WarCodeText := ';' + Format("Calculation Journal Line"."War Resource Code") + ';';
                end;
                if "Deminimis Act Date" = 0D then begin
                    D1 := '; ;';
                end
                else begin
                    d1 := ';' + Format("Calculation Journal Line"."Deminimis Act Date") + ';';
                end;

                if "Calculation Journal Line"."Deminimis Act Name" = '' then begin
                    D2 := ' ;';
                end
                else begin
                    d2 := Format("Calculation Journal Line"."Deminimis Act Name") + ';';
                end;

                if "Calculation Journal Line"."Deminimis Act Number" = '' then begin
                    D3 := ' ;';
                end
                else begin
                    d3 := Format("Calculation Journal Line"."Deminimis Act Number") + ';';
                end;

                if "Calculation Journal Line"."Deminimis Legal act" = '' then begin
                    D4 := ' ;';
                end
                else begin
                    d4 := Format("Calculation Journal Line"."Deminimis Legal act") + ';';
                end;

                if "Calculation Journal Line"."Deminimis Purpose" = '' then begin
                    D5 := ' ;';
                end
                else begin
                    d5 := Format("Calculation Journal Line"."Deminimis Purpose") + ';';
                end;

                if "Calculation Journal Line"."Deminimis Remark" = '' then begin
                    D6 := ' ';
                end
                else begin
                    d6 := Format("Calculation Journal Line"."Deminimis Remark");
                end;


                if "Calculation Journal Line"."Currency Code" = '' then begin
                    CCCode := ' ' + ';'

                end
                else begin
                    CCCode := Format("Calculation Journal Line"."Currency Code") + ';';
                end;




                //đemina dodala

                CalSetup.FindFirst();

                Item.Get(CalSetup."Item No.");
                ch.Get("Calculation Journal Line".Code);




                CustomerPrice.Reset;
                CustomerPrice.SetFilter("No.", '%1', "Calculation Journal Line"."Customer No.");
                if CustomerPrice.FindFirst() then begin
                    SP.Reset();
                    sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                    sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                    sp.SetFilter("Starting Date", '<=%1', "Calculation Journal Line"."Reading Date To");
                    sp.SetCurrentKey("Starting Date");
                    sp.Ascending;
                    if sp.FindLast() then begin
                        "Calculation Journal Line"."Unit Price" := SP."Unit Price";
                        "Calculation Journal Line"."Purchase Unit Price" := sp."Purchase unit price";
                        "Calculation Journal Line"."Distribution Unit Price" := sp."Unit price of distribution";
                        "Calculation Journal Line"."Sales Unit Price" := sp."Unit Price";



                        if ("Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Large Economy")
                        or ("Calculation Journal Line"."Category MM" = "Calculation Journal Line"."Category MM"::"KJKP Heating plant") then begin

                            if sp."Price not by Gauge" = true then begin

                            end
                            else begin
                                ///ĐEMINA
                                TypeD.Reset();
                                TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                                TypeD.SetFilter("Description", '%1', "Calculation Journal Line"."Gauge Size");
                                if TypeD.FindFirst() then begin
                                    if "Calculation Journal Line"."EL Volume Description" <> '' then
                                        sp."Maintenance Resource No." := TypeD."Maintenance Resource No."
                                    else
                                        sp."Maintenance Resource No." := TypeD."Maintenance Resource without";

                                end;
                            end;
                        end;

                        Reso.Reset();
                        Reso.SetFilter("No.", '%1', SP."Maintenance Resource No.");
                        if Reso.FindFirst() then begin
                            "Calculation Journal Line"."Basis maintenance" := Reso."Unit Price";

                            if "Calculation Journal Line"."Old Gauge" = true then begin
                                "Calculation Journal Line"."Basis maintenance" := 0;
                                "Calculation Journal Line"."Basis Resource Code" := '';
                            end;

                            if "Calculation Journal Line"."Status MM" = "Calculation Journal Line"."Status MM"::Terminated then begin
                                "Calculation Journal Line"."Basis maintenance" := 0;
                                "Calculation Journal Line"."Basis Resource Code" := '';
                            end;

                            if ("Calculation Journal Line"."Customer No.") = '200359' then begin
                                "Calculation Journal Line"."Basis maintenance" := 0;
                                "Calculation Journal Line"."Basis Resource Code" := '';
                            end;



                            if ("Calculation Journal Line".Unobvious = true) and ("Calculation Journal Line"."Previous Unobvious Month" = 0) then begin
                                if "Calculation Journal Line"."Bill distribution percentage" = 0 then begin
                                    "Calculation Journal Line"."Basis maintenance" := 0;
                                    "Calculation Journal Line"."Basis Resource Code" := '';
                                end;
                            end;


                            VPS.Reset();
                            vps.SetFilter("VAT Prod. Posting Group", '%1', Reso."VAT Prod. Posting Group");
                            if CU.get("Calculation Journal Line"."Customer No.") then
                                VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
                            if VPS.FindFirst() then begin

                                "Calculation Journal Line"."Maintenance VAT" := round(("Basis maintenance" * VPS."VAT %") / 100, 0.01, '=');
                                "Calculation Journal Line"."Main. VAT Percentage" := VPS."VAT %";
                            end

                            else begin
                                "Calculation Journal Line"."Main. VAT Percentage" := 0;
                            end;

                            if ch."Sales invoice Without M" = true then "Maintenance VAT" := 0;
                            if ch."Sales invoice Without M" = true then "Basis maintenance" := 0;
                            if ch."Sales invoice Without M" = true then "Main. VAT Percentage" := 0;
                            MMF.Reset();
                            MMF.SetFilter("No.", '%1', "Calculation Journal Line"."Measuring Point Code");
                            if mmf.FindFirst() then begin
                                if MMF."MM VAT Excluded" = true then
                                    "Calculation Journal Line"."Maintenance VAT" := 0;
                            end;

                            if cu."Cust VAT Excluded" = true then
                                "Calculation Journal Line"."Maintenance VAT" := 0;

                            "Calculation Journal Line"."Maintenance - part" := "Calculation Journal Line"."Maintenance VAT" + "Calculation Journal Line"."Basis maintenance";

                        end
                        else begin
                            "Calculation Journal Line"."Basis maintenance" := 0;
                            "Calculation Journal Line"."Maintenance VAT" := 0;
                            "Calculation Journal Line"."Maintenance - part" := "Calculation Journal Line"."Maintenance VAT" + "Calculation Journal Line"."Basis maintenance";
                        end;


                    end;

                end
                else begin
                    "Calculation Journal Line"."Unit Price" := 0;
                    "Calculation Journal Line"."Basis maintenance" := 0;

                end;
                "Calculation Journal Line"."Maintenance - part" := "Basis maintenance" + "Maintenance VAT";
                if ch."Sales invoice Without M" = true then
                    "Calculation Journal Line"."Maintenance - part" := 0;

                if "Calculation Journal Line".sm3 < 0 then
                    "Calculation Journal Line".SM3 := 0;

                "Calculation Journal Line"."GAS - amount" := round(("Calculation Journal Line"."Unit Price" * "Calculation Journal Line".sm3), 0.01, '=');


                VPS.Reset();
                vps.SetFilter("VAT Prod. Posting Group", '%1', Item."VAT Prod. Posting Group");
                if CU.get("Calculation Journal Line"."Customer No.") then
                    VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
                if VPS.FindFirst() then begin
                    "Calculation Journal Line"."GAS - VAT" := round((("Calculation Journal Line"."GAS - amount" * VPS."VAT %") / 100), 0.01, '=');
                    "Calculation Journal Line"."SM3 VAT Percentage" := VPS."VAT %";
                end
                else begin
                    "Calculation Journal Line"."GAS - VAT" := 0;
                    "Calculation Journal Line"."SM3 VAT Percentage" := 0;
                end;

                MMF.Reset();
                MMF.SetFilter("No.", '%1', "Calculation Journal Line"."Measuring Point Code");
                if MMF.FindFirst() then begin
                    if MMF."MM VAT Excluded" = true then begin
                        "Calculation Journal Line"."GAS - VAT" := 0;
                        "Calculation Journal Line"."SM3 VAT Percentage" := 0;
                    end;

                end;


                CustF.Reset();
                CustF.SetFilter("No.", '%1', "Calculation Journal Line"."Customer No.");
                if CustF.FindFirst() then begin
                    if CustF."Cust VAT Excluded" = true then
                        "Calculation Journal Line"."GAS - VAT" := 0;
                end;

                "Calculation Journal Line"."GAS - part" := "Calculation Journal Line"."GAS - VAT" + "Calculation Journal Line"."GAS - amount";
                "Calculation Journal Line".Total := "Calculation Journal Line"."GAS - part" + "Calculation Journal Line"."Maintenance - part";





                //kraj

                //ĐK NE    "Calculation Journal Line".Modify(true);
                FirstString := format("Calculation Journal Line".Code) + ';' + Format("Calculation Journal Line"."Customer No.") + ';' +
                format("Calculation Journal Line"."Measuring Point Code")
                 + ';' + format("Calculation Journal Line".Gauge)
                 + ';' + format("Calorific power coefficient")
                + ';' + Format("Calculation Journal Line".SM3)
                + ';' + Format("Calculation Journal Line"."GAS - amount")
                + ';' + Format("Calculation Journal Line"."GAS - VAT")
                 + ';' + Format("Calculation Journal Line"."GAS - part")
                 + ';' + Format("Calculation Journal Line"."Total")
                + ';' +
                Format("Calculation Journal Line"."Calculation Date From") + ';' + Format("Calculation Journal Line"."Calculation Date To")
                + ';' + format("Calculation Journal Line"."Unit Price") + ';' + format("Calculation Journal Line"."Purchase Unit Price") + ';' + format("Calculation Journal Line"."Distribution Unit Price") + ';' + format("Calculation Journal Line"."Sales Unit Price") + ';' + Format("Calculation Journal Line"."Basis maintenance") +
                BasisCodeText + Format("Calculation Journal Line"."Maintenance VAT") + ';' + format("Calculation Journal Line"."Maintenance - part") + ';' + Format("Calculation Journal Line"."War Calculation") + ';' + format("Calculation Journal Line"."War Calculation (LVT)") + WarCodeText + CCCode + Format(Subsidies) + ';'
                + Format("Subsidies Amount") + ';' + Format("Subsidies Total Amount") + ';' + Format("Subsidies VAT Amount")
                + D1 + D2 + D3 + D4 + D5 + D6 + ';' + format("Calculation Journal Line".Autoint);

                OutStreamObj.WRITETEXT(FirstString);
                OutStreamObj.WRITETEXT();
                Broj2 += 1;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(Broj2));
                Progress.UPDATE(2, CurrentDateT);

            end;

        }
    }


    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Company.get;

        FileName := 'AzuriranjePodaci2.txt';
        // TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        File1.CREATE(Company."Path for Documents" + 'AzuriranjePodaci2.txt', TEXTENCODING::UTF8);

        File1.CREATEOUTSTREAM(OutStreamObj);

        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;

    end;




    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Company.get;

        File1.CLOSE;
        //    TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
        //  DownloadFromStream(Instr, '', '', '', FileName);
        FileManagement.DownloadToFile(Company."Path for Documents" + 'AzuriranjePodaci2.txt', Company."Path for Documents" + 'AzuriranjePodaci2.txt');


        Commit();

        Filexml.OPEN(Company."Path for Documents" + 'AzuriranjePodaci2.txt');
        Filexml.CREATEINSTREAM(instreamobject);
        XMLPORT.IMPORT(50045, instreamobject);
        Commit();

    end;


    var
        myInt: Integer;
        A: Decimal;
        B: Decimal;
        C: Decimal;
        CalcSetup: Record "Calculation Setup";
        RP: Record "Resource Price";
        WarDebt: Record "War Debt Setup";
        CalcJ: Record "Calculation Journal Line";

        Company: Record "Company Information";
        FileManagement: Codeunit "File Management";
        DatePrevious: Date;
        Instr: InStream;
        OutStr: OutStream;
        CER: Record "Currency Exchange Rate";
        CJL2: Record "Calculation Journal Line";
        Journal: Record "Calculation Journal Line";
        BasisCodeText: Text;
        WarCodeText: Text;
        VPS: Record "VAT Posting Setup";
        SP: Record "Sales Price";
        Resource: Record "Resource";
        CalSetup: Record "Calculation Setup";
        CU: Record customer;
        UnitP: Decimal;
        CustomerPrice: Record Customer;
        Broj2: Integer;
        instreamobject: InStream;
        FileName: text;
        CCCode: text[250];
        OutStreamObj: OutStream;
        MMF: Record "Service Item";
        CustF: Record Customer;
        Progress: Dialog;
        Filexml: File;
        File1: File;
        StartDaT: Time;
        CurrentDateT: Time;
        Subs: Boolean;
        VatPostingSetup: Record "VAT Posting Setup";
        FirstString: Text;
        DecimalV: Decimal;
        Reso: Record Resource;
        DecimalV2: text[250];
        DecimalV2E: Decimal;
        ch: Record "Calcuation Header";
        D1: Text;
        D2: Text;
        D3: Text;
        D4: Text;
        D5: Text;
        D6: Text;
        Item: Record Item;
        TypeD: Record "Types Of Diseases";
}