page 50185 "Control lists"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Control list";
    Caption = 'Control List';


    layout
    {
        area(Content)
        {

            field(KOEKAL; KOEKAL) { ApplicationArea = all; }
            field("Month Of GAS Calculation"; "Month Of GAS Calculation") { ApplicationArea = all; Editable = false; }

            field("Year Of GAS Calculation"; "Year Of GAS Calculation") { ApplicationArea = all; Editable = false; }
            field("Calculation Date From"; "Calculation Date From") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Calculation Date To"; "Calculation Date To") { ApplicationArea = all; Editable = false; }
            field("Reading Date From"; "Reading Date From") { }
            field("Reading Date To"; "Reading Date To") { }
            field(Rows; Rows) { ApplicationArea = all; Caption = 'Rows'; }


            repeater("")
            {
                field("Control Number"; "Control Number") { }
                field(Code; Code) { ApplicationArea = all; }
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }

                field("Gauge"; "Gauge") { ApplicationArea = all; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                field("Status MM"; "Status MM") { }
                field("Measuring point off"; "Measuring point off") { }
                field("Measuring point off Date"; "Measuring point off Date") { }
                field("Address MM"; "Address MM") { ApplicationArea = all; }
                field("Address Customer"; "Address Customer") { ApplicationArea = all; }
                field("Proceedings No."; "Proceedings No.") { }
                field("Method of calculation"; "Method of calculation") { }
                field("Previous Date"; "Previous Date") { ApplicationArea = all; }



                field("Temperature previous - gauge"; "Temperature previous - gauge") { }
                field("Temperature new- gauge"; "Temperature new- gauge") { }

                field("Temperature result- gauge"; "Temperature result- gauge") { }
                field("Control Temperature new- gauge"; "Control Temperature new- gauge") { Style = Strong; }
                field("Control Temperature result- g."; "Control Temperature result- g.") { Style = Strong; }
                field("Pressure previous - gauge"; "Pressure previous - gauge") { }
                field("Pressure new- gauge"; "Pressure new- gauge") { }
                field("Pressure result- gauge"; "Pressure result- gauge") { }
                field("Control Pressure new- gauge"; "Control Pressure new- gauge") { Style = Strong; }
                field("Control Pressure result- gauge"; "Control Pressure result- gauge") { Style = Strong; }
                field("Old Value"; "Old Value") { ApplicationArea = all; }
                field("New Value"; "New Value") { ApplicationArea = all; }

                field(Difference; Difference) { ApplicationArea = all; }
                field("Control New Value"; "Control New Value") { Style = Strong; }
                field("Control Difference"; "Control Difference") { Style = Strong; }
                field(SM3; SM3) { ApplicationArea = all; }
                field("Control SM3"; "Control SM3") { Style = Strong; }
                field("Correction previous - gauge"; "Correction previous - gauge") { }
                field("Correction new- gauge"; "Correction new- gauge") { }
                field("Correction result- gauge"; "Correction result- gauge") { }
                field("Control Correction new- gauge"; "Control Correction new- gauge") { Style = Strong; }
                field("Control Correction result- g."; "Control Correction result- g.") { Style = Strong; }
                field("UnCorrection previous - gauge"; "UnCorrection previous - gauge") { }
                field("UnCorrection new- gauge"; "UnCorrection new- gauge") { }
                field("UnCorrection result- gauge"; "UnCorrection result- gauge") { }
                field("Control UnCorrection new- g."; "Control UnCorrection new- g.") { Style = Strong; }
                field("Control UnCorrection result- g"; "Control UnCorrection result- g") { Style = Strong; }
                field("Temperature Correction"; "Temperature Correction") { }
                field("Pressure Correction"; "Pressure Correction") { }
                field("Scale factor"; "Scale factor") { }
                field("Calorific power coefficient"; "Calorific power coefficient") { }
                field("Compression coefficient"; "Compression coefficient") { }
                field("Atmospheric pressure"; "Atmospheric pressure") { }
                field("% reduction"; "% reduction") { }

                field("Unit Price"; "Unit Price") { ApplicationArea = all; }
                field("GAS - amount"; "GAS - amount") { ApplicationArea = all; }
                field("GAS - VAT"; "GAS - VAT") { ApplicationArea = all; }
                field("GAS - part"; "GAS - part") { ApplicationArea = all; }
                field("Control GAS - amount"; "Control GAS - amount") { Style = Strong; }
                field("Control GAS - VAT"; "Control GAS - VAT") { Style = Strong; }
                field("Control GAS - part"; "Control GAS - part") { Style = Strong; }
                field("Basis maintenance"; "Basis maintenance") { ApplicationArea = all; }
                field("Maintenance VAT"; "Maintenance VAT") { ApplicationArea = all; }
                field("Maintenance - part"; "Maintenance - part") { ApplicationArea = all; }
                field(Total; Total) { ApplicationArea = all; }
                field("Control Total"; "Control Total") { Style = Strong; }

                field("Correct consumption "; "Correct consumption") { }
                field("Transfer to orginal"; "Transfer to Orginal") { }
                field("Control ID done"; "Control ID done") { }
                field("Source Data"; "Source Data") { }
                field("Reason for Control"; "Reason for Control") { }
                field(USERID; USERID) { }



            }

        }

    }
    actions

    {
        area(Reporting)
        {
            action("Proceedings")
            {

                Caption = 'Proceedings';
                Visible = False;

                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Report.Run(50223, true, true, Rec);
                end;


            }
            action("Reading List")
            {

                Caption = 'Reading List';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    CJL: Record "Control list";
                begin
                    CJL.Reset();
                    CJL.CopyFilters(Rec);
                    CJL.SetFilter("Reading Mode", '%1', CJL."Reading Mode"::"Reading List");
                    Report.Run(50026, true, true, CJL);
                end;


            }
            //Export VP or heating plant

            action("Export VP")
            {

                Caption = 'Export VP or heating plant';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Report.Run(50041, true, true, Rec);
                end;


            }
            action("Import VP")
            {

                Caption = 'Import VP or heating plant';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    report50123: xmlport "Import VP and KJKP xml Control";
                begin
                    clear(report50123);
                    //   Report.Run(50123, true, true);
                    //  report50123.SetParam(true);
                    report50123.SetParam2(rec.Code);
                    report50123.Run();
                end;


            }

            action("Calculation")
            {

                Caption = 'Calculation';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    A: Decimal;
                    B: Decimal;
                    C: Decimal;
                    A_C: Decimal;
                    B_C: Decimal;
                    C_C: Decimal;
                    DecimalV: Decimal;
                    CalcSetup: Record "Calculation Setup";
                    Journal: Record "Calculation Journal Line";

                    DecimalV2: text[250];
                    DecimalV2E: Decimal;
                    Percc: Decimal;
                    CustP: Record Customer;
                    PercMM: Decimal;
                    CHWin: Record "Calcuation Header";
                    MMPerc: Record "Service Item";
                begin
                    if Rec.FindSet() then
                        repeat
                            CalcSetup.get;
                            CustP.Reset();
                            CustP.SetFilter("No.", '%1', rec."Customer No.");
                            if CustP.FindFirst() then
                                Percc := CustP."Bill distribution percentage";

                            CHWin.reset;
                            CHWin.setfilter(Code, '%1', rec.code);
                            if CHWin.findfirst then begin
                                MMPerc.Reset();
                                MMPerc.SetFilter("No.", '%1', rec."Measuring Point Code");
                                if MMPerc.FindFirst() then begin

                                    if CHWin."Summer or Winter Zone" = CHWin."Summer or Winter Zone"::Summer then begin
                                        PercMM := MMPerc."Summer Pecentage";
                                        Validate("Summer Pecentage", PercMM);
                                    end;
                                    if CHWin."Summer or Winter Zone" = CHWin."Summer or Winter Zone"::Winter then begin
                                        PercMM := MMPerc."Winter Pecentage";
                                        Validate("Winter Pecentage", PercMM);

                                    end;

                                end;


                            end;



                            if "Method of calculation" = "Method of calculation"::"3" then begin
                                validate(SM3, round((("Correction new- gauge" - "Correction previous - gauge") * "Calorific power coefficient"), 0.01, '='));
                                validate("Control SM3", round((("Control Correction new- gauge" - "Correction previous - gauge") * "Calorific power coefficient"), 0.01, '='));

                            end;
                            if "Method of calculation" = "Method of calculation"::"2" then begin
                                A := "New Value" - "Old Value";
                                A_C := "Control New Value" - "Old Value";


                                //dodala

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


                                if PercMM <> 0 then begin

                                    DecimalV := (PercMM / 100) * ("Control New Value" - "Old Value");
                                    DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                    if Evaluate(DecimalV2E, DecimalV2) then begin
                                        if DecimalV2E > 50 then
                                            A_C := Round((PercMM / 100) * ("Control New Value" - "Old Value"), 1, '>')
                                        else
                                            A_C := Round((PercMM / 100) * ("Control New Value" - "Old Value"), 1, '<')

                                    end;


                                end;



                                //kraj


                                if CalcSetup."PS Constant" <> 0 then
                                    B := round(round(("Pressure result- gauge" + "Atmospheric pressure"), 0.0001, '=') / CalcSetup."PS Constant", 0.0001, '=')
                                else
                                    B := round(("Pressure result- gauge" + "Atmospheric pressure"), 0.0001, '=');

                                if CalcSetup."PS Constant" <> 0 then
                                    B_C := round(round(("Control Pressure result- gauge" + "Atmospheric pressure"), 0.0001, '=') / CalcSetup."PS Constant", 0.0001, '=')
                                else
                                    B_C := round(("Control Pressure result- gauge" + "Atmospheric pressure"), 0.0001, '=');



                                c := round(CalcSetup."TS Constant" / (CalcSetup."Absolute zero" + ("Temperature new- gauge" + "Temperature previous - gauge") / 2) * CalcSetup.JEDKS, 0.0001, '=');
                                c_c := round(CalcSetup."TS Constant" / (CalcSetup."Absolute zero" + ("Control Temperature new- gauge" + "Temperature previous - gauge") / 2) * CalcSetup.JEDKS, 0.0001, '=');

                                validate(SM3, round((A * B * C) * "Calorific power coefficient", 0.01, '='));
                                validate("Control SM3", round((A_C * B_C * C_C) * "Calorific power coefficient", 0.01, '='))
                            end;
                            if "Method of calculation" = "Method of calculation"::"1" then begin

                                if (rec."Category MM" = rec."Category MM"::"Large Economy") or (rec."Category MM" = rec."Category MM"::"KJKP Heating plant") then begin

                                    if PercMM <> 0 then begin

                                        A := (PercMM / 100) * ("New Value" - "Old Value");
                                        A_C := (PercMM / 100) * ("Control New Value" - "Old Value");

                                        DecimalV := (PercMM / 100) * ("New Value" - "Old Value");
                                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                        if Evaluate(DecimalV2E, DecimalV2) then begin
                                            if DecimalV2E > 50 then
                                                A := Round((PercMM / 100) * ("New Value" - "Old Value"), 1, '>')
                                            else
                                                A := Round((PercMM / 100) * ("New Value" - "Old Value"), 1, '<')



                                        end;

                                        validate(SM3, Round(A * "Calorific power coefficient", 0.01, '='));


                                        DecimalV := (PercMM / 100) * ("Control New Value" - "Old Value");
                                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                        if Evaluate(DecimalV2E, DecimalV2) then begin
                                            if DecimalV2E > 50 then
                                                A_C := Round((PercMM / 100) * ("Control New Value" - "Old Value"), 1, '>')
                                            else
                                                A_C := Round((PercMM / 100) * ("Control New Value" - "Old Value"), 1, '<')



                                        end;
                                        validate("Control SM3", Round((PercMM / 100) * ("Control New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='));

                                    end
                                    else begin

                                        validate(SM3, Round(("New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='));
                                        validate("Control SM3", Round(("Control New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='));
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

                                    DecimalV := ("Control New Value" - "Old Value") * "Calorific power coefficient";
                                    DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                    if Evaluate(DecimalV2E, DecimalV2) then begin
                                        if DecimalV2E > 50 then
                                            validate(SM3, Round(("Control New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='))
                                        else
                                            validate(SM3, Round(("Control New Value" - "Old Value") * "Calorific power coefficient", 0.01, '='));

                                    end;


                                    //  validate("Control SM3", Round(("Control New Value" - "Old Value") * "Calorific power coefficient", 1, '>'));


                                    //   validate(SM3, round(("New Value" - "Old Value") * "Calorific power coefficient", 1, '>'));
                                end;
                            end;

                            if Percc <> 0
                                      then
                                SM3 := round((SM3 * (Percc / 100)), 0.01, '=');




                            if Percc <> 0
                           then
                                "Control SM3" := round(("Control SM3" * (Percc / 100)), 0.01, '=');






                            Rec.Modify(true);

                        until rec.Next() = 0;
                end;


            }
            action("Marked Valid Date")
            {

                Caption = 'Marked Valid Date';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    if Rec.FindSet() then
                        repeat
                            if Rec."Correct consumption" = true then
                                Rec."Correct consumption" := false
                            else
                                Rec."Correct consumption" := true;
                            Rec.USERID := USERID;
                            Rec.Modify();
                        until Rec.Next() = 0;

                end;
            }
            action("Transfer to Orginal2")
            {

                Caption = 'Transfer to Orginal';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Calc: Record "Calculation Journal Line";
                begin
                    if Confirm('Da li te sigurni da želite izvrši prenos u očitačku listu?') then begin
                        if Rec.FindSet() then
                            repeat
                                Calc.Reset();
                                Calc.SetFilter(Gauge, '%1', Rec.Gauge);
                                Calc.SetFilter(Code, '%1', rec.Code);
                                Calc.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                                calc.SetFilter("Corrector Code", '%1', Rec."Corrector Code");
                                if Calc.FindFirst() then begin
                                    Calc.Validate("New Value", Rec."Control New Value");
                                    Calc.Validate("Pressure new- gauge", Rec."Control Pressure new- gauge");
                                    Calc.Validate("Temperature new- gauge", Rec."Control Temperature new- gauge");
                                    Calc.Validate("UnCorrection new- gauge", "Control UnCorrection new- g.");
                                    Calc.Validate("Correction new- gauge", "Control Correction new- gauge");
                                    Rec."USERID - to transfer" := USERID;
                                    rec."Transfer to Orginal" := true;
                                    Calc.Validate("Source Data", Calc."Source Data"::Control);
                                    rec.Modify();

                                    Calc.Modify();
                                end;



                            until Rec.Next() = 0;

                    end;
                end;
            }

            action("Create Sales Invoice")
            {

                Caption = 'Create Sales Invoice';
                Image = Report;
                Visible = false;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CJL: Record "Calculation Journal Line";
                    Customer: Record Customer;
                    CustomerPrice: Record Customer;
                    SalesSetup: Record "Sales & Receivables Setup";
                    C: Record Customer temporary;
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

                begin
                    Brojac := 0;
                    SalesSetup.get;
                    c.DeleteAll();
                    Brojac += 10000;
                    CalcSetup.Get();
                    "No. Series" := '';
                    CJL.reset;
                    CJL.SetFilter("Correct consumption", '%1', true);

                    CJL.SetFilter("Bill Created", '%1', false);
                    CJL.SetCurrentKey("Customer No.");

                    CJL.Ascending;
                    if CJL.FindSet() then
                        repeat
                            C.Reset();
                            C.setfilter("No.", '%1', CJL."Customer No.");
                            if not c.FindFirst() then begin

                                SH.Init();
                                SH."No." := '';
                                Commit();
                                SH."Document Type" := SH."Document Type"::Order;
                                NoSeriesMgt.InitSeries(SalesSetup."Order Nos.", '', cjl."Calculation Date To", SH."No.", "No. Series");
                                SH.Validate("Sell-to Customer No.", CJL."Customer No.");
                                SH.Validate("Posting Date", cjl."Calculation Date To");
                                SH.Validate("Document Date", CJL."Calculation Date To");
                                SH.Insert();
                                Commit();
                                CJL2.Reset();
                                CJL2.SetFilter("Customer No.", '%1', CJL."Customer No.");
                                CJL2.CalcSums(CJL2.SM3);
                                if cjl2.SM3 > 0 then begin
                                    SL.Init();
                                    SL."Line No." := Brojac;
                                    Brojac += 10000;


                                    SL."Document Type" := sh."Document Type";
                                    SL."Document No." := SH."No.";
                                    sl.Type := sl.Type::Item;
                                    SL.Validate("No.", CalcSetup."Item No.");
                                    sl.validate("Location Code", 'GLAVNO GAS');


                                    SL.validate(Quantity, round(CJL2.SM3, 0.001, '>'));

                                    sl.Insert();
                                end;
                                SL.Init();
                                SL."Line No." := Brojac;
                                Brojac += 10000;
                                SL."Document Type" := sh."Document Type";
                                SL."Document No." := SH."No.";
                                sl.Type := sl.Type::Resource;
                                CustomerPrice.Reset;
                                CustomerPrice.SetFilter("No.", '%1', cjl."Customer No.");
                                if CustomerPrice.FindFirst() then begin
                                    SP.Reset();
                                    sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                                    sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                                    sp.SetFilter("Starting Date", '<=%1', cjl."Reading Date To");
                                    sp.SetCurrentKey("Starting Date");
                                    sp.Ascending;
                                    if sp.FindLast() then
                                        SL.Validate("No.", SP."Maintenance Resource No.");
                                    SL.Validate(Quantity, 1);
                                    CJL2.Reset();
                                    CJL2.SetFilter("Customer No.", '%1', CJL."Customer No.");
                                    CJL2.CalcSums(CJL2."Basis maintenance");
                                    SL.Validate("Unit Price", CJL2."Basis maintenance");
                                end;


                                //Brojač
                                SL.Insert();
                                WarDebt.Reset();
                                WarDebt.SetFilter(Month, '%1', "Month Of GAS Calculation");
                                WarDebt.SetFilter(Active, '%1', true);
                                WarDebt.SetFilter("Customer Category", '%1', CJL."Category Customer");
                                WarDebt.SetFilter(Totaling, '%1', '');
                                if WarDebt.FindSet() then
                                    repeat
                                        CJL2.Reset();
                                        CJL2.SetFilter("Customer No.", '%1', CJL."Customer No.");
                                        CJL2.CalcSums(CJL2.SM3);
                                        if CJL2.SM3 > 0 then begin
                                            SL.Init();

                                            SL."Line No." := Brojac;
                                            Brojac += 10000;
                                            SL."Document No." := SH."No.";
                                            SL."Document Type" := sh."Document Type";
                                            sl.Type := sl.Type::Resource;
                                            sl.Validate("No.", WarDebt.Resource);

                                            sl.Validate(Quantity, round(CJL2.SM3, 0.001, '>'));
                                            Reso.Reset();
                                            Reso.SetFilter("No.", '%1', WarDebt.Resource);
                                            if Reso.FindFirst() then begin


                                            end;

                                            sl.Insert();
                                        end;
                                    until WarDebt.Next() = 0;

                                //totaling war debt

                                CJL2.Reset();
                                CJL2.SetFilter("Customer No.", '%1', CJL."Customer No.");
                                CJL2.SetFilter("Month Of GAS Calculation", WarDebt.Totaling);
                                CJL2.SetFilter("Year Of GAS Calculation", '%1', CJL."Year Of GAS Calculation");
                                CJL2.CalcSums(CJL2.SM3);
                                if CJL2.SM3 > 0 then begin
                                    WarDebt.Reset();
                                    WarDebt.SetFilter(Month, '%1', "Month Of GAS Calculation");
                                    WarDebt.SetFilter(Active, '%1', true);
                                    WarDebt.SetFilter("Customer Category", '%1', CJL."Category Customer");
                                    WarDebt.SetFilter(Totaling, '<>%1', '');
                                    if WarDebt.FindSet() then
                                        repeat
                                            SL.Init();
                                            SL."Line No." := Brojac;
                                            Brojac += 10000;
                                            SL."Document No." := SH."No.";
                                            SL."Document Type" := sh."Document Type";
                                            sl.Type := sl.Type::Resource;
                                            sl.Validate("No.", WarDebt.Resource);

                                            sl.Validate(Quantity, round(CJL2.SM3, 0.001, '>'));
                                            Reso.Reset();
                                            Reso.SetFilter("No.", '%1', WarDebt.Resource);
                                            if Reso.FindFirst() then begin


                                            end;

                                            sl.Insert();

                                        until WarDebt.Next() = 0;
                                end;

                                //kraj war debt




                                c.Init();
                                c."No." := cjl."Customer No.";
                                c.Insert();

                            end;
                            CJL."Bill Created" := true;
                            CJL.Locked := true;
                            cjl.Modify();



                        until CJL.Next() = 0;

                    Message('Računi su uspješno kreirane!');


                end;
            }
        }

        //Kreiraj račune

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        Rows := Rec.Count;


    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        US: Record "User Setup";

    begin
        Rows := Rec.Count;


    end;

    trigger OnClosePage()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin


    end;

    var
        myInt: Integer;
        Rows: Integer;
}