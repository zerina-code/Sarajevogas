report 50166 "Create Billing JOB"
{
    DefaultLayout = RDLC;
    Caption = 'Posting Billing';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                VATDifference: Decimal;
                VATRealTotal: Decimal;
                CJL: Record "Calculation Journal Line";
                VATPostingTotal: decimal;
                VATPostingTotalRez: decimal;
                PdvDifferenceAdd: Boolean;
                CJLCalcDIf: Record "Calculation Journal Line";
            begin

                VATRealTotal := 0;
                VATDifference := 0;
                PdvDifferenceAdd := False;
                VatDiffUnesen := false;
                CJL.Reset();
                CJL.SetFilter("Document No. Posting", '%1', "Calculation Journal Line"."Document No. Posting");
                CJL.SetFilter(Code, '%1', "Calculation Journal Line"."Code");
                if cjl.FindFirst() then begin
                    cjl.CalcSums("GAS - VAT", "Maintenance VAT", "Subsidies VAT Amount");
                    VATRealTotal := cjl."GAS - VAT" + cjl."Maintenance VAT" + cjl."Subsidies VAT Amount";
                end;
                //ovo će biti stvarni vat


                VATPostingTotal := 0;
                CJL.Reset();
                CJL.SetFilter("Document No. Posting", '%1', "Calculation Journal Line"."Document No. Posting");
                CJL.SetFilter(Code, '%1', "Calculation Journal Line"."Code");
                if cjl.findset() then
                    repeat
                        VATPostingTotal += ((cjl.SM3 * cjl."Unit Price") * cjl."SM3 VAT Percentage" / 100) +
                        ((cjl."Basis maintenance") * cjl."Main. VAT Percentage" / 100)
until cjl.Next() = 0;

                VATPostingTotalRez := round(VATPostingTotal, 0.01, '=');

                if (abs(VATPostingTotalRez - VATRealTotal) >= 0.01) and (abs(VATPostingTotalRez - VATRealTotal) <= 0.05) then begin
                    VATDifference := VATRealTotal - round(VATPostingTotal, 0.01, '=');

                end;

                Brojac := 0;
                if VATDifference = 0 then
                    PdvDifferenceAdd := true;

                SalesSetup.get;

                Brojac += 10000;
                CalcSetup.Get();
                "No. Series" := '';

                CLog.Reset();
                CLog.SetFilter(Code, '%1', "Calculation Journal Line"."Customer No.");
                CLog.SetFilter(Description, '%1', "Calculation Journal Line"."Code" + '|' + "Calculation Journal Line".MM + '|' + "Calculation Journal Line"."Customer No." + '|' + "Calculation Journal Line".Gauge + '|' + format("Calculation Journal Line".Autoint));
                CLog.SetFilter(Billing_Code, '%1', "Calculation Journal Line".code);
                if not CLog.FindFirst() then begin
                    LinijeDruge := 0;
                    BrojAdd += 1;

                    KreiranoYes := false;

                    //provjeriti da li postoji to zaglavlje, ako ne postoji dodati
                    BrojMm += 1;

                    ServiceHeaderInitE.Reset();
                    ServiceHeaderInitE.SetFilter("No.", '%1', "Calculation Journal Line"."Document No. Posting");
                    if not ServiceHeaderInitE.FindFirst() then begin
                        ServiceLineBroj := 0;
                        ServiceHeaderInit.init;
                        ServiceHeaderInit."Document Type" := ServiceHeaderInit."Document Type"::Order;
                        ServiceHeaderInit."No." := "Calculation Journal Line"."Document No. Posting";
                        ServiceHeaderInit.Validate("Customer No.", "Calculation Journal Line"."Customer No.");
                        ServiceHeaderInit.validate("Posting Date", "Calculation Journal Line"."Calculation Date To");
                        ServiceHeaderInit.validate("VAT Date", "Calculation Journal Line"."Calculation Date To");
                        ServiceHeaderInit.validate("Document Date", "Calculation Journal Line"."Calculation Date To");
                        ServiceHeaderInit.validate("Request Type", ServiceHeaderInit."Request Type"::"Billing Invoice");
                        ServiceHeaderInit.validate("Due Date", calcdate('<+15D>', "Calculation Journal Line"."Calculation Date To"));
                        ServiceHeaderInit."Order Date" := ServiceHeaderInit."Posting Date";
                        ServiceHeaderInit."Order Time" := Time;
                        ServiceHeaderInit.validate("Order Date", ServiceHeaderInit."Posting Date");
                        ServiceHeaderInit."Posting No." := "Document No. Posting";



                        CustT.Reset();
                        if ("Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"KJKP Heating plant") or
                        ("Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Special Customer")
                          then
                            CustT.SetFilter("Bill Category", '%1', CustT."Bill Category"::"Large Economy")
                        else
                            CustT.SetFilter("Bill Category", '%1', "Calculation Journal Line"."Category Customer");
                        if CustT.FindFirst() then begin


                            ServiceHeaderInit.Validate("Bill Category", "Calculation Journal Line"."Category Customer");
                            ServiceHeaderInit.Validate("Bill type", CustT.Code);
                            "No. Series" := CustT."No. Series Bill";
                            ServiceHeaderInit."Posting No. Series" := CustT."Posting No. Series Bill";
                            ServiceHeaderInit."Shipping No. Series" := CustT."No. Series Bill";
                            ServiceHeaderInit."Shipping No." := ServiceHeaderInit."No.";
                        end;

                        ServiceHeaderInit.Validate("Order Time", Time);
                        ServiceHeaderInit.insert;
                        Commit();
                    end
                    else begin

                        //nađi mi zadnju liniju do kojeg broja je došla da bi moglo povećavati
                        SLine.reset;
                        SLine.SetFilter("Document No.", '%1', "Calculation Journal Line"."Document No. Posting");
                        SLine.SetFilter("Document Type", '%1', Sline."Document Type"::Order);
                        Sline.SetCurrentKey("Line No.");
                        Sline.Ascending;
                        if SLine.findlast then begin
                            ServiceLineBroj := SLine."Line No.";
                            //ovo je kao startna zadnja

                        end;
                    end;


                    CJLZamjeneMjeraca.reset;
                    CJLZamjeneMjeraca.CopyFilters(CJL);
                    CJLZamjeneMjeraca.SetFilter(total, '<>%1', 0);
                    CJLZamjeneMjeraca.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                    CJLZamjeneMjeraca.SetFilter("Document No. Posting", '%1', "Calculation Journal Line"."Document No. Posting");
                    if CJLZamjeneMjeraca.FindSet() then
                        repeat

                            //1 kupac može imati više MM 
                            LinijeDruge += 1;


                            ServiceItemLineE.reset;
                            ServiceItemLineE.SetFilter("Customer No.", '%1', CJLZamjeneMjeraca."Customer No.");
                            ServiceItemLineE.SetFilter("Service Item No. - Relation", '%1', CJLZamjeneMjeraca."Measuring Point Code");
                            ServiceItemLineE.SetFilter(Gauge, '%1', CJLZamjeneMjeraca.Gauge);
                            ServiceItemLineE.SetFilter("Document No.", '%1', CJLZamjeneMjeraca."Document No. Posting"); //ovo ako je zamjena, dodaj linije

                            if not ServiceItemLineE.FindFirst() then begin

                                ServiceLineBroj += 1000;
                                ServiceItemLine."Document Type" := ServiceItemLine."Document Type"::Order;
                                ServiceItemLine.Validate("Customer No.", CJLZamjeneMjeraca."Customer No.");
                                ServiceItemLine."Document No." := CJLZamjeneMjeraca."Document No. Posting";
                                ServiceItemLine."Line No." := ServiceLineBroj;

                                ServiceItemLine.Validate("Service Item No. - Relation", CJLZamjeneMjeraca."Measuring Point Code");
                                ServiceItemLine.Gauge := CJLZamjeneMjeraca.Gauge;
                                ServiceItemLine.RMS := CJLZamjeneMjeraca."Serial Number";

                                GaugeSerial.Reset();
                                GaugeSerial.SetFilter("Code", '%1', ServiceItemLine.Gauge);
                                if GaugeSerial.FindFirst() then begin
                                    ServiceItemLine.RMS := GaugeSerial."Inventar number";
                                    ServiceItemLine."Meter Manufacturer" := GaugeSerial."Meter Manufacturer";
                                    ServiceItemLine."Meter Manufacturer Desc" := GaugeSerial."Meter Manufacturer Desc";
                                    ServiceItemLine."Gauge Size" := GaugeSerial."Gauge Size";
                                    ServiceItemLine."Year of Production" := GaugeSerial."Year of Production";
                                    ServiceItemLine."DD calibration" := GaugeSerial."DD calibration";
                                end
                                else begin
                                    ServiceItemLine.RMS := '';
                                    ServiceItemLine."Meter Manufacturer" := '';
                                    ServiceItemLine."Meter Manufacturer Desc" := '';
                                    ServiceItemLine."Gauge Size" := '';
                                    ServiceItemLine."Year of Production" := 0;
                                    ServiceItemLine."DD calibration" := 0;


                                end;
                                ServiceItemLine.insert(false);

                                Commit();

                            end
                            else begin
                                SLine.reset;
                                SLine.SetFilter("Document No.", '%1', "Calculation Journal Line"."Document No. Posting");
                                SLine.SetFilter("Document Type", '%1', Sline."Document Type"::Order);
                                Sline.SetCurrentKey("Line No.");
                                Sline.Ascending;
                                if SLine.findlast then begin
                                    ServiceLineBroj := SLine."Line No."; //ako se ne dodaje, već uzima isti redni broj
                                    //ovo je kao startna zadnja

                                end;

                                ServiceItemLineF.reset;
                                ServiceItemLineF.SetFilter("Customer No.", '%1', CJLZamjeneMjeraca."Customer No.");
                                ServiceItemLineF.SetFilter("Service Item No. - Relation", '%1', CJLZamjeneMjeraca."Measuring Point Code");
                                ServiceItemLineF.SetFilter(Gauge, '%1', CJLZamjeneMjeraca.Gauge);
                                ServiceItemLineF.SetFilter("Document No.", '%1', CJLZamjeneMjeraca."Document No. Posting"); //ovo ako je zamjena, dodaj linije
                                if ServiceItemLineF.FindFirst() then begin
                                    ServiceLineBroj := ServiceItemLineF."Line No.";
                                end;


                            end;

                            if (CJLZamjeneMjeraca."Filter by Old RMS" = false) and (CJLZamjeneMjeraca.Unobvious = false) then begin

                                CJLZamjeneMjeracaSum.Reset();
                                CJLZamjeneMjeracaSum.SetFilter("Document No. Posting", '%1', CJLZamjeneMjeraca."Document No. Posting");
                                CJLZamjeneMjeracaSum.SetFilter("Customer No.", '%1', CJLZamjeneMjeraca."Customer No.");
                                CJLZamjeneMjeracaSum.SetFilter("Measuring Point Code", '%1', CJLZamjeneMjeraca."Measuring Point Code");
                                if CJLZamjeneMjeracaSum.FindFirst() then begin
                                    CJLZamjeneMjeracaSum.CalcSums(SM3, Total, "Basis maintenance", "GAS - VAT");

                                end;




                                CJLZamjeneMjeracaSumW.Reset();
                                CJLZamjeneMjeracaSumW.SetFilter("Document No. Posting", '%1', CJLZamjeneMjeraca."Document No. Posting");
                                CJLZamjeneMjeracaSumW.SetFilter("Customer No.", '%1', CJLZamjeneMjeraca."Customer No.");
                                if CJLZamjeneMjeracaSumW.FindFirst() then begin
                                    CJLZamjeneMjeracaSumW.CalcSums("War Calculation (LVT)");
                                end;




                                if CJLZamjeneMjeracaSum.SM3 > 0 then begin


                                    CalcSetup.get;

                                    ServiceLineNaplata.init;
                                    ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                                    ServiceLineNaplata."Document No." := CJLZamjeneMjeraca."Document No. Posting";
                                    ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                    BrojAdd += 1;
                                    ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;

                                    ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                    ServiceLineNaplata.Validate("Customer No.", CJLZamjeneMjeraca."Customer No.");
                                    ServiceLineNaplata.Gauge := CJLZamjeneMjeraca.Gauge;

                                    ServiceLineNaplata.validate(Type, ServiceLineNaplata.Type::Item);
                                    CalcSetup.get;
                                    ServiceLineNaplata.Validate("No.", CalcSetup."Item No. 2");
                                    ServiceLineNaplata.validate("Location Code", 'GLAVNO GAS');
                                    ServiceLineNaplata.Validate(Quantity, CJLZamjeneMjeracaSum.SM3);
                                    ServiceLineNaplata.validate("Unit Price", CJLZamjeneMjeraca."Sales Unit Price");

                                    ServiceLineNaplata."Unit Price" := CJLZamjeneMjeraca."Sales Unit Price";
                                    //ServiceLineNaplata.Amount := (ServiceLineNaplata."Unit Price" * ServiceLineNaplata.Quantity
                                    //ServiceLineNaplata.validate(Amount, round(ServiceLineNaplata.Amount, 0.01, '='));
                                    //ServiceLineNaplata.validate("Amount Including VAT", round(ServiceLineNaplata."Amount Including VAT", 0.01, '='));
                                    ServiceLineNaplata.Validate("VAT billing", CJLZamjeneMjeracaSum."GAS - VAT");
                                    ServiceLineNaplata.Validate("Total billing", CJLZamjeneMjeracaSum.Total);
                                    if ServiceLineNaplata."No." = 'GAS2' then
                                        ServiceLineNaplata.Validate("Posting Group", 'RACUNI');

                                    if VatDiffUnesen = false then begin
                                        CalcTOtalAmount := 0;
                                        CJLCalcDIf.Reset();
                                        CJLCalcDIf.setfilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                        CJLCalcDIf.SetFilter(Code, '%1', CJLZamjeneMjeracaSum.Code);
                                        if CJLCalcDIf.FindSet() then
                                            repeat
                                                CalcTOtalAmount += round(CJLCalcDIf.SM3 * CJLCalcDIf."Unit Price", 0.01, '=') + round(CJLCalcDIf."Basis maintenance" * 1, 0.01, '=');
                                            until CJLCalcDIf.Next() = 0;
                                        CalcVat := round(CalcTOtalAmount * CJLZamjeneMjeracaSum."SM3 VAT Percentage" / 100, 0.01, '>');



                                        ServiceLineNaplata.Validate("VAT Difference", ServiceLineNaplata."Total billing" - (CalcVat + CalcTOtalAmount));
                                        if not ((ServiceLineNaplata."VAT Difference" = 0.01) or
            (ServiceLineNaplata."VAT Difference" = 0) or
            (ServiceLineNaplata."VAT Difference" = -0.01)) then begin
                                            ServiceLineNaplata."VAT Difference" := 0;
                                        end;

                                        VatDiffUnesen := true;
                                    end;
                                    ServiceLineNaplata.Insert(false);
                                end;

                                if CJLZamjeneMjeracaSum."Basis maintenance" <> 0 then begin

                                    ServiceLineNaplata.init;
                                    ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                                    ServiceLineNaplata."Document No." := CJLZamjeneMjeraca."Document No. Posting";
                                    //ServiceLineBroj += 1000;

                                    ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                    BrojAdd += 1;
                                    ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;
                                    ServiceLineNaplata.Validate("Customer No.", CJLZamjeneMjeraca."Customer No.");

                                    ServiceLineNaplata.Validate(Type, ServiceLineNaplata.Type::Resource);
                                    ServiceLineNaplata.Gauge := CJLZamjeneMjeraca.Gauge;


                                    CalcSetup.get;
                                    ServiceLineNaplata.Validate("No.", CJLZamjeneMjeraca."Basis Resource Code");
                                    ServiceLineNaplata.Validate(Quantity, 1);
                                    ServiceLineNaplata.validate("Unit Price", CJLZamjeneMjeracaSum."Basis maintenance");
                                    ServiceLineNaplata.Validate("VAT billing", CJLZamjeneMjeracaSum."Maintenance VAT");
                                    ServiceLineNaplata.Validate("Total billing", CJLZamjeneMjeracaSum.Total);
                                    if VatDiffUnesen = false then begin
                                        CalcTOtalAmount := 0;
                                        CJLCalcDIf.Reset();
                                        CJLCalcDIf.setfilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                        CJLCalcDIf.SetFilter(Code, '%1', CJLZamjeneMjeracaSum.Code);
                                        if CJLCalcDIf.FindSet() then
                                            repeat
                                                CalcTOtalAmount += round(CJLCalcDIf.SM3 * CJLCalcDIf."Unit Price", 0.01, '=') + round(CJLCalcDIf."Basis maintenance" * 1, 0.01, '=');
                                            until CJLCalcDIf.Next() = 0;
                                        CalcVat := round(CalcTOtalAmount * CJLZamjeneMjeracaSum."SM3 VAT Percentage" / 100, 0.01, '>');



                                        ServiceLineNaplata.Validate("VAT Difference", ServiceLineNaplata."Total billing" - (CalcVat + CalcTOtalAmount));
                                        if not ((ServiceLineNaplata."VAT Difference" = 0.01) or
        (ServiceLineNaplata."VAT Difference" = 0) or
        (ServiceLineNaplata."VAT Difference" = -0.01)) then begin
                                            ServiceLineNaplata."VAT Difference" := 0;
                                        end;
                                        VatDiffUnesen := true;
                                    end;

                                    ServiceLineNaplata.Insert(false);

                                end;

                                if (CJLZamjeneMjeracaSumW."War Calculation (LVT)" <> 0) and (LinijeDruge = 1) then begin

                                    ServiceLineNaplata.init;
                                    ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                                    ServiceLineNaplata."Document No." := CJLZamjeneMjeraca."Document No. Posting";
                                    ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                    BrojAdd += 1;
                                    ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;
                                    ServiceLineNaplata.Validate("Customer No.", CJLZamjeneMjeraca."Customer No.");
                                    ServiceLineNaplata.Gauge := CJLZamjeneMjeraca.Gauge;


                                    ServiceLineNaplata.Validate(Type, ServiceLineNaplata.Type::Resource);
                                    CalcSetup.get;
                                    ServiceLineNaplata.Validate("No.", CJLZamjeneMjeraca."War Resource Code");
                                    ServiceLineNaplata.Validate(Quantity, 1);
                                    ServiceLineNaplata.validate("Unit Price", round(CJLZamjeneMjeracaSumW."War Calculation (LVT)", 0.01, '='));



                                    ServiceLineNaplata.Insert(false);
                                    LinijeDruge += 1;
                                end;

                                CLog.Reset();
                                CLog.SetFilter(Code, '%1', CJLZamjeneMjeracaSum."Customer No.");
                                CLog.SetFilter(Description, '%1', CJLZamjeneMjeracaSum."Code" + '|' + CJLZamjeneMjeracaSum.MM + '|' + CJLZamjeneMjeracaSum."Customer No." + '|' + CJLZamjeneMjeracaSum.Gauge + '|' + format(CJLZamjeneMjeracaSum.Autoint));
                                CLog.SetFilter(Billing_Code, '%1', CJLZamjeneMjeracaSum.Code);
                                if not CLog.FindFirst() then begin
                                    CLog.Init();
                                    CLog.Code := CJLZamjeneMjeracaSum."Customer No.";
                                    CLog.Description := CJLZamjeneMjeracaSum."Code" + '|' + CJLZamjeneMjeracaSum.MM + '|' + CJLZamjeneMjeracaSum."Customer No." + '|' + CJLZamjeneMjeracaSum.Gauge + '|' + format(CJLZamjeneMjeracaSum.Autoint);
                                    CLog.Purpose := 'KreirajRacune';
                                    CLog.Billing_Code := CJLZamjeneMjeracaSum.Code;
                                    CLog.Insert(false);
                                end;
                                Commit();

                            end;


                            if (CJLZamjeneMjeraca."Filter by Old RMS" = true) or (CJLZamjeneMjeraca.Unobvious = true) then begin

                                CJLZamjeneMjeracaSum.SM3 := 0;
                                CJLZamjeneMjeracaSum.Total := 0;
                                CJLZamjeneMjeracaSum."GAS - VAT" := 0;
                                CJLZamjeneMjeracaSum."Basis maintenance" := 0;


                                CJLZamjeneMjeracaSum.Reset();
                                CJLZamjeneMjeracaSum.SetFilter("Document No. Posting", '%1', CJLZamjeneMjeraca."Document No. Posting");
                                CJLZamjeneMjeracaSum.SetFilter("Customer No.", '%1', CJLZamjeneMjeraca."Customer No.");
                                CJLZamjeneMjeracaSum.SetFilter("Measuring Point Code", '%1', CJLZamjeneMjeraca."Measuring Point Code");
                                if CJLZamjeneMjeracaSum.findset() then
                                    repeat

                                        CLog.Reset();
                                        CLog.SetFilter(Code, '%1', CJLZamjeneMjeracaSum."Customer No.");
                                        CLog.SetFilter(Description, '%1', CJLZamjeneMjeracaSum."Code" + '|' + CJLZamjeneMjeracaSum.MM + '|' + CJLZamjeneMjeracaSum."Customer No." + '|' + CJLZamjeneMjeracaSum.Gauge + '|' + format(CJLZamjeneMjeracaSum.Autoint));
                                        CLog.SetFilter(Billing_Code, '%1', CJLZamjeneMjeracaSum."Code");
                                        if not CLog.FindFirst() then begin

                                            //kao dodajem sve što je zamjena, ali onda moram reći da je uneseno sve, pa će log na narednoj liniji samo to preskočiti
                                            CJLZamjeneMjeracaSumW.Reset();
                                            CJLZamjeneMjeracaSumW.SetFilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                            CJLZamjeneMjeracaSumW.SetFilter("Customer No.", '%1', CJLZamjeneMjeracaSum."Customer No.");
                                            if CJLZamjeneMjeracaSumW.FindFirst() then begin
                                                CJLZamjeneMjeracaSumW.CalcSums("War Calculation (LVT)");
                                            end;


                                            if CJLZamjeneMjeracaSum.SM3 > 0 then begin

                                                CalcSetup.get;


                                                ServiceLineNaplata.init;
                                                ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                                                ServiceLineNaplata."Document No." := CJLZamjeneMjeracaSum."Document No. Posting";
                                                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                                BrojAdd += 1;
                                                ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;

                                                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                                ServiceLineNaplata.Validate("Customer No.", CJLZamjeneMjeracaSum."Customer No.");


                                                ServiceLineNaplata.Gauge := CJLZamjeneMjeracaSum.Gauge;
                                                ServiceLineNaplata.validate(Type, ServiceLineNaplata.Type::Item);
                                                CalcSetup.get;
                                                ServiceLineNaplata.Validate("No.", CalcSetup."Item No. 2");
                                                ServiceLineNaplata.validate("Location Code", 'GLAVNO GAS');
                                                ServiceLineNaplata.Validate(Quantity, CJLZamjeneMjeracaSum.SM3);
                                                ServiceLineNaplata.validate("Unit Price", CJLZamjeneMjeracaSum."Sales Unit Price");

                                                ServiceLineNaplata."Unit Price" := CJLZamjeneMjeracaSum."Sales Unit Price";
                                                //  ServiceLineNaplata.Amount := round(ServiceLineNaplata."Unit Price" * ServiceLineNaplata.Quantity, 0.01, '=');
                                                ServiceLineNaplata.Validate("VAT billing", CJLZamjeneMjeracaSum."GAS - VAT");

                                                CJLZamjeneMjeracaSumTotalR.Reset();
                                                CJLZamjeneMjeracaSumTotalR.SetFilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                                if CJLZamjeneMjeracaSumTotalR.FindFirst() then begin
                                                    CJLZamjeneMjeracaSumTotalR.CalcSums(Total);
                                                    ServiceLineNaplata.Validate("Total billing", CJLZamjeneMjeracaSumTotalR.Total);
                                                end;

                                                // ServiceLineNaplata.validate(Amount, round(ServiceLineNaplata.Amount, 0.01, '='));
                                                // ServiceLineNaplata.validate("Amount Including VAT", round(ServiceLineNaplata."Amount Including VAT", 0.01, '='));
                                                if ServiceLineNaplata."No." = 'GAS2' then
                                                    ServiceLineNaplata.Validate("Posting Group", 'RACUNI');
                                                if VatDiffUnesen = false then begin
                                                    CalcTOtalAmount := 0;
                                                    CJLCalcDIf.Reset();
                                                    CJLCalcDIf.setfilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                                    CJLCalcDIf.SetFilter(Code, '%1', CJLZamjeneMjeracaSum.Code);
                                                    if CJLCalcDIf.FindSet() then
                                                        repeat
                                                            CalcTOtalAmount += round(CJLCalcDIf.SM3 * CJLCalcDIf."Unit Price", 0.01, '=') + round(CJLCalcDIf."Basis maintenance" * 1, 0.01, '=');
                                                        until CJLCalcDIf.Next() = 0;
                                                    CalcVat := round(CalcTOtalAmount * CJLZamjeneMjeracaSum."SM3 VAT Percentage" / 100, 0.01, '>');



                                                    ServiceLineNaplata.Validate("VAT Difference", ServiceLineNaplata."Total billing" - (CalcVat + CalcTOtalAmount));
                                                    if not ((ServiceLineNaplata."VAT Difference" = 0.01) or
       (ServiceLineNaplata."VAT Difference" = 0) or
       (ServiceLineNaplata."VAT Difference" = -0.01)) then begin
                                                        ServiceLineNaplata."VAT Difference" := 0;
                                                    end;
                                                    VatDiffUnesen := true;
                                                end;

                                                ServiceLineNaplata.Insert(false);

                                            end;





                                            if CJLZamjeneMjeracaSum."Basis maintenance" <> 0 then begin

                                                ServiceLineNaplata.init;
                                                ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                                                ServiceLineNaplata."Document No." := CJLZamjeneMjeracaSum."Document No. Posting";
                                                //ServiceLineBroj += 1000;

                                                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                                BrojAdd += 1;
                                                ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;
                                                ServiceLineNaplata.Validate("Customer No.", CJLZamjeneMjeracaSum."Customer No.");

                                                ServiceLineNaplata.Validate(Type, ServiceLineNaplata.Type::Resource);
                                                ServiceLineNaplata.Gauge := CJLZamjeneMjeracaSum.Gauge;


                                                CalcSetup.get;
                                                ServiceLineNaplata.Validate("No.", CJLZamjeneMjeracaSum."Basis Resource Code");
                                                ServiceLineNaplata.Validate(Quantity, 1);
                                                ServiceLineNaplata.validate("Unit Price", CJLZamjeneMjeracaSum."Basis maintenance");
                                                ServiceLineNaplata.validate("VAT billing", CJLZamjeneMjeracaSum."Maintenance VAT");


                                                CJLZamjeneMjeracaSumTotalR.Reset();
                                                CJLZamjeneMjeracaSumTotalR.SetFilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                                if CJLZamjeneMjeracaSumTotalR.FindFirst() then begin
                                                    CJLZamjeneMjeracaSumTotalR.CalcSums(Total);
                                                    ServiceLineNaplata.Validate("Total billing", CJLZamjeneMjeracaSumTotalR.Total);
                                                end;

                                                if VatDiffUnesen = false then begin
                                                    CalcTOtalAmount := 0;
                                                    CJLCalcDIf.Reset();
                                                    CJLCalcDIf.setfilter("Document No. Posting", '%1', CJLZamjeneMjeracaSum."Document No. Posting");
                                                    CJLCalcDIf.SetFilter(Code, '%1', CJLZamjeneMjeracaSum.Code);
                                                    if CJLCalcDIf.FindSet() then
                                                        repeat
                                                            CalcTOtalAmount += round(CJLCalcDIf.SM3 * CJLCalcDIf."Unit Price", 0.01, '=') + round(CJLCalcDIf."Basis maintenance" * 1, 0.01, '=');
                                                        until CJLCalcDIf.Next() = 0;
                                                    CalcVat := round(CalcTOtalAmount * CJLZamjeneMjeracaSum."SM3 VAT Percentage" / 100, 0.01, '>');



                                                    ServiceLineNaplata.Validate("VAT Difference", ServiceLineNaplata."Total billing" - (CalcVat + CalcTOtalAmount));
                                                    if not ((ServiceLineNaplata."VAT Difference" = 0.01) or
         (ServiceLineNaplata."VAT Difference" = 0) or
         (ServiceLineNaplata."VAT Difference" = -0.01)) then begin
                                                        ServiceLineNaplata."VAT Difference" := 0;
                                                    end;
                                                    VatDiffUnesen := true;
                                                end;
                                                ServiceLineNaplata.Insert(false);

                                            end;

                                            if (CJLZamjeneMjeracaSumW."War Calculation (LVT)" <> 0) and (LinijeDruge = 1) then begin

                                                ServiceLineNaplata.init;
                                                LinijeDruge += 1;
                                                ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                                                ServiceLineNaplata."Document No." := CJLZamjeneMjeracaSum."Document No. Posting";
                                                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                                                BrojAdd += 1;
                                                ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;
                                                ServiceLineNaplata.Validate("Customer No.", CJLZamjeneMjeracaSum."Customer No.");
                                                ServiceLineNaplata.Gauge := CJLZamjeneMjeracaSum.Gauge;


                                                ServiceLineNaplata.Validate(Type, ServiceLineNaplata.Type::Resource);
                                                CalcSetup.get;
                                                ServiceLineNaplata.Validate("No.", CJLZamjeneMjeracaSumW."War Resource Code");
                                                ServiceLineNaplata.Validate(Quantity, 1);
                                                ServiceLineNaplata.validate("Unit Price", round(CJLZamjeneMjeracaSumW."War Calculation (LVT)", 0.01, '='));


                                                ServiceLineNaplata.Insert(false);
                                            end;


                                        end;

                                        CLog.Reset();
                                        CLog.SetFilter(Code, '%1', CJLZamjeneMjeracaSum."Customer No.");
                                        CLog.SetFilter(Description, '%1', CJLZamjeneMjeracaSum."Code" + '|' + CJLZamjeneMjeracaSum.MM + '|' + CJLZamjeneMjeracaSum."Customer No." + '|' + CJLZamjeneMjeracaSum.Gauge + '|' + format(CJLZamjeneMjeracaSum.Autoint));
                                        CLog.SetFilter("Billing_Code", '%1', CJLZamjeneMjeracaSum.code);
                                        if not CLog.FindFirst() then begin
                                            CLog.Init();
                                            CLog.Code := CJLZamjeneMjeracaSum."Customer No.";
                                            CLog.Description := CJLZamjeneMjeracaSum."Code" + '|' + CJLZamjeneMjeracaSum.MM + '|' + CJLZamjeneMjeracaSum."Customer No." + '|' + CJLZamjeneMjeracaSum.Gauge + '|' + format(CJLZamjeneMjeracaSum.Autoint);
                                            CLog.Purpose := 'KreirajRacune';
                                            CLog.Billing_Code := CJLZamjeneMjeracaSum.Code;
                                            CLog.Insert(false);
                                        end;
                                        Commit();
                                    until CJLZamjeneMjeracaSum.Next() = 0;
                            end;

                        until CJLZamjeneMjeraca.Next() = 0;



                end;



            end;


        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin


    end;

    trigger OnPostReport()
    var

    begin







    end;

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin




    end;




    var
        CJL: Record "Calculation Journal Line";
        Customer: Record Customer;
        CustomerPrice: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        CLog: Record "CJL Logs";
        CJLZamjeneMjeracaSumTotalR: Record "Calculation Journal Line";

        SH: Record "Sales Header";
        SL: Record "Sales Line";
        CalcSetup: Record "Calculation Setup";
        SP: Record "Sales Price";
        Reso: Record Resource;
        WarDebt: Record "War Debt Setup";
        CJL2: Record "Calculation Journal Line";
        Brojac: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "No. Series": Code[20];
        CJLZamjeneMjeraca: record "Calculation Journal Line";
        ServiceHeaderInit: record "Service Header";
        ServiceItemLine: record "Service Item Line";
        ServiceLineBroj: integer;
        ServiceLineNaplata: Record "Service Line";
        DodajLinija: Integer;
        ServiceLineNaplataE: Record "Service Line";
        CustT: Record "Customer Templ.";
        Noseries: code[20];
        GaugeSerial: record Gauge;
        ServiceLineHow: Record "Service Line";
        BrojLinijaDOSadaUneseni: Integer;
        StartDaT: Time;
        CurrentDateT: Time;
        Progress: Dialog;
        BrojLinijaTreba: Integer;
        BrojMm: Integer;
        ServiceHeaderInitE: Record "Service Header";
        ServiceItemLineE: Record "Service Item Line";
        cjlGet: Record "Calculation Journal Line";
        SLine: Record "Service Item Line";
        KreiranoYes: Boolean;
        BrojAdd: Integer;
        CJLZamjeneMjeracaSum: Record "Calculation Journal Line";
        CJLZamjeneMjeracaSumW: Record "Calculation Journal Line";
        PrviPosebna: Boolean;
        LinijeDruge: Integer;
        ServiceItemLineF: Record "Service Item Line";
        CJLZamjeneMjeracaSumBasis: Record "Calculation Journal Line";
        Fori: Integer;
        CLog2: record "CJL Logs";
        VatDiffUnesen: Boolean;
        CalcVat: Decimal;
        CalcTOtalAmount: Decimal;


}

