page 50178 "Calculation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Calculation Journal Line";
    Caption = 'Calculation List';
    CardPageId = "Calculation Journal Card";


    layout
    {
        area(Content)
        {

            group(Setup1)
            {
                caption = 'Setup 1';

                field(KOEKAL; KOEKAL) { ApplicationArea = all; }
                field("Month Of GAS Calculation"; "Month Of GAS Calculation") { ApplicationArea = all; }

                field("Year Of GAS Calculation"; "Year Of GAS Calculation") { ApplicationArea = all; }
                //     field("Calculation Date From"; "Calculation Date From") { ApplicationArea = all; }


                field("Reading Date From"; "Reading Date From") { }
                field("Reading Date To"; "Reading Date To") { }

                field("Calculation Date To"; "Calculation Date To") { ApplicationArea = all; }
                field(Rows; Rows) { ApplicationArea = all; Caption = 'Rows'; }
                field(Rows2; Rows2) { ApplicationArea = all; Caption = 'Rows2'; }
                field(Rows3; Rows3) { ApplicationArea = all; Caption = 'Rows3'; }
            }
            group(Setup2)
            {
                caption = 'Setup 2';
                Visible = false;
                field("Range 1"; "Range 1") { }
                field("Range 2"; "Range 2") { }
                field("Range 3"; "Range 3") { }
                field("Range 4"; "Range 4") { }
                field("Range 5"; "Range 5") { }
                field("Date for previous Quantity"; "Date for previous Quantity") { ApplicationArea = all; }

                field("Average Calculation"; "Average Calculation")
                {

                    trigger OnValidate()
                    var
                        myInt: Integer;
                        CJL: record "Calculation Journal line";
                    begin
                        CJL.reset;
                        CJL.setfilter("Code", '%1', rec.code);

                        //"Code", MM, "Customer No.", Gauge)
                        CJL.setfilter(gauge, '<>%1', Gauge);
                        if cjl.findset then
                            repeat
                                cjl."Average Calculation" := rec."Average Calculation";
                                cjl.modify;
                            until cjl.next = 0;


                    end;
                }
                field("Reason for Control"; "Reason for Control")
                {
                    DrillDownPageId = "Reason for Control";
                    LookupPageId = "Reason for Control";
                }


            }
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field("Customer No."; "Customer No.") { ApplicationArea = all; StyleExpr = RowStyle; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; StyleExpr = RowStyle; }
                field("Registration No."; "Registration No.") { }
                field("VAT Registration No."; "VAT Registration No.") { ApplicationArea = all; }
                field("Corrector Code"; "Corrector Code") { }
                field("EL Volume Description"; "EL Volume Description") { }
                field("Serial Number"; "Serial Number") { StyleExpr = RowStyle; }

                field("Gauge"; "Gauge") { ApplicationArea = all; StyleExpr = RowStyle; }
                field("Gauge Size"; "Gauge Size") { }
                field("Summer Zone"; "Summer Zone") { }
                field("Measuring Zone - summer"; "Measuring Zone - summer") { }

                field("Winter Zone"; "Winter Zone") { }
                field("Measuring Zone - winter"; "Measuring Zone - winter") { }

                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; StyleExpr = RowStyle; }
                field("MM Description"; "MM Description") { ApplicationArea = all; StyleExpr = RowStyle; }
                field("Status MM"; "Status MM") { }
                field("Measuring point off"; "Measuring point off") { }
                field("Measuring point off Date"; "Measuring point off Date") { }

                //ulice podaci da ih lijepo poredam

                field("Street Customer"; "Street Customer") { ApplicationArea = all; Editable = false; }
                field("Street Name Customer"; "Street Name Customer") { ApplicationArea = all; Editable = false; }
                field("Street No."; "Street No.") { ApplicationArea = all; }

                field("Street No. Text"; "Street No. Text") { ApplicationArea = all; Editable = false; }

                field("Address Customer"; "Address Customer") { ApplicationArea = all; Editable = false; }

                field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; Editable = false; }
                field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; Editable = false; }
                field("City Customer"; "City Customer") { ApplicationArea = all; Editable = false; }
                field("Post Code Customer"; "Post Code Customer") { ApplicationArea = all; Editable = false; }
                field("MZ Customer"; "MZ Customer") { ApplicationArea = all; Editable = false; }
                field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; Editable = false; }
                field("Home No. Customer"; "Home No. Customer") { ApplicationArea = all; Editable = false; }

                field("Floor Customer 2"; "Floor Customer 2") { ApplicationArea = all; Editable = false; }

                field("Apartment No. Customer 2"; "Apartment No. Customer 2") { ApplicationArea = all; Editable = false; }
                field("Customer Stroke"; "Customer Stroke") { ApplicationArea = all; Editable = false; }
                field("Customer string"; "Customer string") { ApplicationArea = all; Editable = false; }

                field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = false; }


                field("Street Customer 2"; "Street Customer 2") { ApplicationArea = all; Editable = false; }
                field("Street Name Customer 2"; "Street Name Customer 2") { ApplicationArea = all; Editable = false; }
                //
                field("Street No. 2"; "Street No. 2") { ApplicationArea = all; Editable = false; }

                field("Street No.2 Text"; "Street No.2 Text") { ApplicationArea = all; Editable = false; }


                field("Address 2"; "Address 2") { ApplicationArea = all; Editable = false; }


                field("Municipality Code Customer 2"; "Municipality Code Customer 2") { ApplicationArea = all; Editable = false; }

                field("Municipality Name Customer 2"; "Municipality Name Customer 2") { ApplicationArea = all; Editable = false; }


                field("City Customer D."; "City Customer D.") { ApplicationArea = all; Editable = false; }
                field("Post Code Customer D."; "Post Code Customer D.") { ApplicationArea = all; Editable = false; }
                field("MZ Customer 2"; "MZ Customer 2") { ApplicationArea = all; Editable = false; }
                field("MZ Name Customer 2"; "MZ Name Customer 2") { ApplicationArea = all; Editable = false; }

                field("Home No. Customer 2"; "Home No. Customer 2") { ApplicationArea = all; Editable = false; Visible = false; }

                field("Floor Customer"; "Floor Customer") { ApplicationArea = all; Editable = false; }

                field("Apartment No. Customer"; "Apartment No. Customer") { ApplicationArea = all; Editable = false; }
                field("Customer Stroke 2"; "Customer Stroke 2") { ApplicationArea = all; Editable = false; }
                field("Customer String 2"; "Customer String 2") { ApplicationArea = all; Editable = false; }
                field("Zone stroke 2"; "Zone stroke 2") { ApplicationArea = all; Editable = false; }

                field("Street MM"; "Street MM") { ApplicationArea = all; Editable = false; }
                field("Street Name MM"; "Street Name MM") { ApplicationArea = all; Editable = false; }
                field("Street No. int"; "Street No. int") { ApplicationArea = all; Editable = false; }

                field("Street No. Text MM"; "Street No. Text MM") { ApplicationArea = all; Editable = false; }

                field("Address MM"; "Address MM") { ApplicationArea = all; Editable = false; }

                field("Municipality Code MM"; "Municipality Code MM") { ApplicationArea = all; Editable = false; }

                field("Municipality Name MM"; "Municipality Name MM") { ApplicationArea = all; Editable = false; }
                field("City MM"; "City MM") { ApplicationArea = all; Editable = false; }

                field("Post Code MM"; "Post Code MM") { ApplicationArea = all; Editable = false; }
                field("MZ MM"; "MZ MM") { ApplicationArea = all; Editable = false; }
                field("MZ Name MM"; "MZ Name MM") { ApplicationArea = all; Editable = false; }

                field("Home No."; "Home No.") { ApplicationArea = all; Editable = false; }
                field(Floor; Floor) { ApplicationArea = all; Editable = false; }

                field("Apartment No."; "Apartment No.") { ApplicationArea = all; Editable = false; }

                field("Measuring Point Stroke"; "Measuring Point Stroke") { ApplicationArea = all; Editable = false; }

                field("Measuring Point String"; "Measuring Point String") { ApplicationArea = all; Editable = false; }

                field("Zone stroke MM"; "Zone stroke MM") { ApplicationArea = all; Editable = false; }




                field("Proceedings No."; "Proceedings No.") { }
                field("Proceedings No. Print"; "Proceedings No. Print") { }
                field("Proceedings Order"; "Proceedings Order") { }
                field("Method of calculation"; "Method of calculation") { }
                field("Remotely Type"; "Remotely Type") { ApplicationArea = all; }
                field("Reading Mode"; "Reading Mode") { ApplicationArea = all; }
                field("Mobile No."; "Mobile No.") { ApplicationArea = all; }
                field("Type of reading"; "Type of reading") { ApplicationArea = all; }
                field("Reading Time"; "Reading Time") { ApplicationArea = all; }
                field(Posting; Posting) { }
                field(Distribution; Distribution) { }
                field("Distribution - read"; "Distribution - read") { }
                field(Specification; Specification) { }
                field("Bill delivery"; "Bill delivery") { }
                field("RMS Maintenance"; "RMS Maintenance") { }
                field("Posting GAS"; "Posting GAS") { }

                /*
                 cjl.Posting := mm.Posting;
                        cjl.Distribution := mm.Distribution;
                        cjl."Distribution - read" := mm."Distribution - read";
                        cjl.Specification := mm.Specification;
                        cjl."Bill delivery" := mm."Bill delivery";
                        cjl."RMS Maintenance" := mm."RMS Maintenance";
                        cjl."Winter Zone" := mm."Winter Zone";
                        CJL."Remotely Type" := mm."Remotely Type";
                        cjl."Transit Zone" := mm."Transit Zone";
                        */

                field("Previous Date"; "Previous Date") { ApplicationArea = all; Editable = true; }
                FIELD("Previous Unobvious Month"; "Previous Unobvious Month") { }
                field(Unobvious; Unobvious) { }
                field("Previous Calculations"; "Previous Calculations")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        CL: Record "Calculation Journal Line";
                        clPage: page "Calculation Entries";
                    begin
                        CL.Reset();
                        CL.SetFilter("Measuring Point Code", '%1', "Measuring Point Code");
                        CL.SetFilter(Locked, '%1', true);
                        clPage.SetTableView(cl);
                        clPage.Run();

                    end;

                    trigger OnDrillDown()
                    var
                        CL: Record "Calculation Journal Line";
                        clPage: page "Calculation Entries";
                        myInt: Integer;
                    begin
                        CL.Reset();
                        CL.SetFilter("Measuring Point Code", '%1', "Measuring Point Code");
                        CL.SetFilter(Locked, '%1', true);
                        clPage.SetTableView(cl);
                        clPage.Run();

                    end;
                }
                field("Max Difference"; "Max Difference") { }

                field("Current Balance"; "Current Balance") { }
                field("Difference Balance"; "Difference Balance")
                {
                    Visible = false;
                    Style = Unfavorable;

                    StyleExpr = "Difference Balance";
                }
                field("Customer Balance"; "Customer Balance") { }
                field("Customer Prepayment"; "Customer Prepayment") { }
                field("Undo Calculation"; "Undo Calculation") { }
                field("Undo Document No."; "Undo Document No.") { }
                field("New and Old value compare"; "New and Old value compare") { }
                field("New and Old value compare Max"; "New and Old value compare Max") { }
                field("Date Difference 1"; "Date Difference 1") { }
                field("Difference Amount 1"; "Difference Amount 1")
                {
                    Style = Unfavorable;

                    StyleExpr = "Difference Out of range 1";

                }
                field("Difference Range 1"; "Difference Range 1") { }

                field("Date Difference 2"; "Date Difference 2") { }
                field("Difference Amount 2"; "Difference Amount 2")
                {
                    Style = Unfavorable;

                    StyleExpr = "Difference Out of range 2";

                }

                field("Difference Range 2"; "Difference Range 2")
                { }

                field("Date Difference 3"; "Date Difference 3")
                {


                }
                field("Difference Amount 3"; "Difference Amount 3")
                {
                    Style = Unfavorable;

                    StyleExpr = "Difference Out of range 3";
                }
                field("Difference Range 3"; "Difference Range 3") { }
                field("Date Difference 4"; "Date Difference 4") { }
                field("Difference Amount 4"; "Difference Amount 4")
                {
                    Style = Unfavorable;

                    StyleExpr = "Difference Out of range 4";
                }
                field("Difference Range 4"; "Difference Range 4") { }
                field("Date Difference 5"; "Date Difference 5") { }
                field("Difference Amount 5"; "Difference Amount 5")
                {
                    Style = Unfavorable;

                    StyleExpr = "Difference Out of range 5";
                }

                field("Difference Range 5"; "Difference Range 5") { }
                field("Pressure Date"; "Pressure Date") { }
                field("Adjusted Pressure"; "Adjusted Pressure") { }


                field("Temperature previous - gauge"; "Temperature previous - gauge") { }
                field("Temperature new- gauge"; "Temperature new- gauge") { }
                field("Temperature result- gauge"; "Temperature result- gauge") { }
                field("Pressure previous - gauge"; "Pressure previous - gauge") { }
                field("Pressure new- gauge"; "Pressure new- gauge") { }
                field("Pressure result- gauge"; "Pressure result- gauge") { }
                field("Old Value"; "Old Value") { ApplicationArea = all; }
                field("New Value"; "New Value") { ApplicationArea = all; }

                field(Difference; Difference) { ApplicationArea = all; }

                field("Correction previous - gauge"; "Correction previous - gauge") { }
                field("Correction new- gauge"; "Correction new- gauge") { }
                field("Correction result- gauge"; "Correction result- gauge") { }
                field("UnCorrection previous - gauge"; "UnCorrection previous - gauge") { }
                field("UnCorrection new- gauge"; "UnCorrection new- gauge") { }
                field("UnCorrection result- gauge"; "UnCorrection result- gauge") { }
                field("Temperature Correction"; "Temperature Correction") { }
                field("Pressure Correction"; "Pressure Correction") { }
                field("Scale factor"; "Scale factor") { }
                field("Calorific power coefficient"; "Calorific power coefficient") { }
                field("Compression coefficient"; "Compression coefficient") { }
                field("Atmospheric pressure"; "Atmospheric pressure") { }
                field("% reduction"; "% reduction") { }

                field(SM3; SM3)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;

                }

                field("Unit Price"; "Unit Price") { ApplicationArea = all; }
                field("GAS - amount"; "GAS - amount") { ApplicationArea = all; }
                field("GAS - VAT"; "GAS - VAT") { ApplicationArea = all; }
                field("GAS - part"; "GAS - part") { ApplicationArea = all; }
                field("Basis maintenance"; "Basis maintenance") { ApplicationArea = all; }
                field("Maintenance VAT"; "Maintenance VAT") { ApplicationArea = all; }
                field("Maintenance - part"; "Maintenance - part") { ApplicationArea = all; }
                field(Total; Total)
                {

                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;

                }
                field("Manualy War Value"; "Manualy War Value") { }
                field("Q. total Sum - War"; "Q. total Sum - War") { }
                field("War Calculation"; "War Calculation") { }
                field("Currency Code"; "Currency Code") { }
                field("War Calculation (LVT)"; "War Calculation (LVT)") { }
                field(Subsidies; Subsidies) { }
                field("Subsidies Amount"; "Subsidies Amount") { }
                field("Subsidies VAT Amount"; "Subsidies VAT Amount") { }
                field("Subsidies Total Amount"; "Subsidies Total Amount") { }
                field("Correct consumption "; "Correct consumption") { }
                field("Old Gauge"; "Old Gauge") { }
                field("New Gauge"; "New Gauge") { }
                field("Filter by Old RMS"; "Filter by Old RMS") { }
                field("RN Date"; "RN Date") { }
                field("RN Reading Value"; "RN Reading Value") { }

                field("Purchase Unit Price"; "Purchase Unit Price") { }
                field("Distribution Unit Price"; "Distribution Unit Price") { }
                field("Sales Unit Price"; "Sales Unit Price") { }
                field(Date; Date) { }
                field("Last Year Calculation"; "Last Year Calculation") { }
                field("Source Data"; "Source Data") { }
                field(USERID; USERID) { }
                //   field(Letters; Letters) { }
                field("E-mail Delivery"; "E-mail Delivery") { }
                field("E-Mail 2"; "E-Mail 2") { }

                field("E-mail Delivery Date"; "E-mail Delivery Date") { }
                field("E-mail Delivery Date to"; "E-mail Delivery Date to") { }
                field("Sent e-mail"; "Sent e-mail") { }
                field(Activity; Activity) { }
                field("EF Activity"; "EF Activity") { }
                field("Dwelling Type"; "Dwelling Type") { }

                field("EU Activity"; "EU Activity") { }
                field("Customer No. int"; "Customer No. int") { }
                field("Bill distribution percentage"; "Bill distribution percentage") { }

                field(Agreement2; Agreement) { Caption = 'Agreement'; }
                field("Document No. Posting"; "Document No. Posting") { }
                field("Winter Pecentage"; "Winter Pecentage") { }
                field("Summer Pecentage"; "Summer Pecentage") { }
                field("Category Customer"; "Category Customer") { }
                field("Category MM"; "Category MM") { }
                field("Reminder Terms Code"; "Reminder Terms Code") { }




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
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;


    trigger OnAction()
    var
        CJL: Record "Calculation Journal Line";
    begin
        //    CJL.Reset();
        //      CJL.CopyFilters(Rec);
        //        CJL.SetFilter("Reading Mode", '%1', CJL."Reading Mode"::"Reading List");
        Report.Run(50001, true, true, Rec);
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
        CJL: Record "Calculation Journal Line";
    begin
        CJL.Reset();
        CJL.CopyFilters(Rec);
        CJL.SetFilter("Reading Mode", '%1', CJL."Reading Mode"::"Reading List");
        Report.Run(50181, true, true, CJL);
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

        Report.Run(50009, true, true, Rec);
    end;


            }
            //50123
            action("Import VP")
            {

                Caption = 'Import VP or heating plant';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        report50123: xmlport "Import VP and KJKP xml";
    begin
        clear(report50123);
        //   Report.Run(50123, true, true);
        //  report50123.SetParam(true);
        report50123.SetParam2(rec.Code);
        report50123.Run();
    end;


            }
            action("Unknown date")
            {

                Caption = 'Unknown date';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        Unk: page "Unknown data";
        UnkR: Record "Unknown data";
    begin
        UnkR.Reset();
        UnkR.SetFilter(Code, '%1', rec.Code);
        Unk.SetTableView(UnkR);
        unk.Run();


    end;


            }

            action("Get previous Quantity2")
            {

                Caption = 'Get previous Quantity2';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        ExR: Report "Export Data";
    begin

        Report.run(50210, true, false, rec);
    end;
            }

            action("Ažuriraj saldo preraspodjela")
            {

                Caption = 'Ažuriraj saldo preraspodjela';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        ExR: Report "Export Data";
    begin

        Report.run(50168, true, false, rec);
    end;
            }

            action("GetDocumentNo.")
            {

                Caption = 'GetDocumentNo.';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;


    trigger OnAction()
    var
        CustT: Record "Customer Templ.";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Noseries: code[20];
        StartDaT: Time;
        CurrentDateT: Time;
        Progress: Dialog;
        BrojMm: Integer;
        Docno: text[20];
        US: Record "User Setup";
    begin

        if (rec."Category Customer" = rec."Category Customer"::"KJKP Heating plant") or
        (rec."Category Customer" = rec."Category Customer"::"Large Economy")
        or (rec."Category Customer" = rec."Category Customer"::"Special Customer")
        or (rec."Category Customer" = rec."Category Customer"::CNG)
        or (rec."Category Customer" = rec."Category Customer"::"Small Economy")
        then begin
            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            if US.FindFirst() then begin
                us.SortBilling := true;
                us.Modify();
                Commit();
            end;

        end
        else begin
            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            if US.FindFirst() then begin
                us.SortBilling := false;
                us.Modify();
                Commit();

            end;

        end;

        Report.run(Report::"Export Document No.", true, false, rec);
    end;
            }

            action("Average Calculation")
            {

                Caption = 'Average Calculation';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        CJLLog: Record "CJL Logs";
        CHMonth: Record "Calcuation Header";
        CLAverage: record "Calculation Journal Line";
        SumSm3: Decimal;
        CountV: Integer;
    begin
        if rec.FindSet() then
            repeat
                if Rec."Average Calculation" = 0 then begin

                    if Rec."Category Customer" = Rec."Category Customer"::Household then begin
                        CJLLog.Reset();
                        CJLLog.SetFilter(Billing_Code, '%1', Rec.Code);
                        CJLLog.SetFilter(Purpose, '%1', 'ProsjekK');
                        CJLLog.SetFilter(Description, '%1', format(Rec."Category Customer"));
                        if not CJLLog.FindFirst() then begin

                            SumSm3 := 0;
                            CLAverage.Reset();
                            CLAverage.SetFilter(Code, '%1', Rec.Code);
                            CLAverage.SetFilter(SM3, '<>%1', 0);
                            if CLAverage.FindFirst() then begin
                                CLAverage.CalcSums(SM3);
                                SumSm3 := CLAverage.SM3;
                            end;
                            //ovdje je sabrano svi kupci SM3

                            //eh ovdje bi trebala naći dinstinct po kupcu

                            CLAverage.Reset();
                            CLAverage.SetFilter(Code, '%1', Rec.Code);
                            CLAverage.SetFilter("Old Gauge", '%1', false);
                            CHMonth.Reset();
                            CHMonth.SetFilter(code, '%1', Rec.Code);
                            if CHMonth.FindFirst() then
                                CLAverage.SetFilter("Month Of GAS Calculation", '%1', CHMonth."Month Of GAS Calculation");
                            CLAverage.SetFilter("Year Of GAS Calculation", '%1', CHMonth."Year Of GAS Calculation");
                            CLAverage.SetFilter(Unobvious, '%1', false);
                            if CLAverage.FindFirst() then begin
                                CountV := CLAverage.count;
                            end;
                            if CountV <> 0 then
                                Rec."Average Calculation" := round(SumSm3 / CountV, 1, '=')
                            else
                                Rec."Average Calculation" := 0;
                            CJLLog.Init();
                            CJLLog.Billing_Code := Rec.Code;
                            CJLLog.Purpose := 'ProsjekK';
                            CJLLog.Description := Format((Rec."Category Customer"));
                            CJLLog.Amount := Rec."Average Calculation";
                            CJLLog.Insert();
                        end
                        else begin
                            CJLLog.Reset();
                            CJLLog.SetFilter(Billing_Code, '%1', Rec.Code);
                            CJLLog.SetFilter(Purpose, '%1', 'ProsjekK');
                            CJLLog.SetFilter(Description, '%1', format(Rec."Category Customer"));
                            if CJLLog.FindFirst() then begin
                                Rec."Average Calculation" := CJLLog.Amount;
                            end;

                        end;


                    end
                    else begin

                        //ovo su sada druge kategorije


                        CJLLog.Reset();
                        CJLLog.SetFilter(Billing_Code, '%1', Rec.Code);
                        CJLLog.SetFilter(Purpose, '%1', 'ProsjekK');
                        CJLLog.SetFilter(Description, '%1', Rec."EF Activity");
                        if not CJLLog.FindFirst() then begin

                            SumSm3 := 0;
                            CLAverage.Reset();
                            CLAverage.SetFilter(Code, '%1', Rec.Code);
                            CLAverage.SetFilter(SM3, '<>%1', 0);
                            CLAverage.SetFilter("EF Activity", '%1', Rec."EF Activity");
                            CLAverage.SetFilter("Customer No.", '<>%1', '200359');
                            CLAverage.SetFilter("Category Customer", '%1', Rec."Category Customer");
                            if CLAverage.FindFirst() then begin
                                CLAverage.CalcSums(SM3);
                                SumSm3 := CLAverage.SM3;
                            end;
                            //ovdje je sabrano svi kupci SM3

                            //eh ovdje bi trebala naći dinstinct po kupcu

                            CLAverage.Reset();
                            CLAverage.SetFilter(Code, '%1', Rec.Code);
                            CLAverage.SetFilter("Old Gauge", '%1', false);
                            CHMonth.Reset();
                            CHMonth.SetFilter(code, '%1', Rec.Code);
                            if CHMonth.FindFirst() then
                                CLAverage.SetFilter("Month Of GAS Calculation", '%1', CHMonth."Month Of GAS Calculation");
                            CLAverage.SetFilter("Year Of GAS Calculation", '%1', CHMonth."Year Of GAS Calculation");
                            CLAverage.SetFilter(Unobvious, '%1', false);
                            if CLAverage.FindFirst() then begin
                                CountV := CLAverage.count;
                            end;
                            if CountV <> 0 then
                                Rec."Average Calculation" := round(SumSm3 / CountV, 1, '=')
                            else
                                Rec."Average Calculation" := 0;
                            CJLLog.Init();
                            CJLLog.Billing_Code := Rec.Code;
                            CJLLog.Purpose := 'ProsjekK';
                            CJLLog.Description := Format((Rec."EF Activity"));
                            CJLLog.Amount := Rec."Average Calculation";
                            CJLLog.Insert();

                        end
                        else begin
                            CJLLog.Reset();
                            CJLLog.SetFilter(Billing_Code, '%1', Rec.Code);
                            CJLLog.SetFilter(Purpose, '%1', 'ProsjekK');
                            CJLLog.SetFilter(Description, '%1', format(Rec."EF Activity"));
                            if CJLLog.FindFirst() then begin
                                Rec."Average Calculation" := CJLLog.Amount;
                            end;

                        end;


                    end;

                end;
                rec.Modify();
            until Rec.Next() = 0;
    end;
            }

            action("Update correction gas")
            {

                Caption = 'Update correction gas';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        report50123: xmlport "Update correction gas";
    begin
        clear(report50123);
        //   Report.Run(50123, true, true);
        //  report50123.SetParam(true);
        report50123.Run();
    end;


            }

            action("Get previous Quantity")

            {

                Caption = 'Get previous Quantity';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;
                            Visible = false;

    trigger OnAction()
    var
        CJLine: record "Calculation Journal Line";
        CJLineExsist: record "Calculation Journal Line";
        DecimalV: Decimal;
        DecimalV2: text[250];
        DecimalV2E: Decimal;

        Prvi1: boolean;
        Prvi2: boolean;
        Prvi3: boolean;
        Prvi4: boolean;
        Prvi5: boolean;
        BrojMm: integer;

        CalcJ: Record "Calculation Journal Line";
        R1: Integer;
        R2: Integer;
        R3: Integer;
        R4: Integer;
        R5: Integer;
        DatePrevious: Date;
        StartDaT: Time;
        CurrentDateT: Time;
        Progress: Dialog;

    begin
        BrojMm := 0;
        prvi1 := false;
        prvi2 := false;
        prvi3 := false;
        prvi4 := False;
        prvi5 := false;
        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;
        BrojMm := 0;
        if rec.FindSet() then
            repeat
                BrojMm += 1;
                if BrojMm = 1 then
                    DatePrevious := "Date for previous Quantity";
                CalcJ.Reset();
                CalcJ.CopyFilters(Rec);
                CalcJ.SetFilter(code, '%1', rec.Code);

                CalcJ.SetFilter("Date Difference 1", '%1', DatePrevious);

                if CalcJ.FindFirst() then begin
                    Prvi1 := true;
                end;
                CalcJ.Reset();
                CalcJ.CopyFilters(Rec);
                CalcJ.SetFilter(code, '%1', rec.Code);

                CalcJ.SetFilter("Date Difference 2", '%1', DatePrevious);
                if CalcJ.FindFirst() then begin
                    Prvi2 := true;
                end;

                CalcJ.Reset();
                CalcJ.CopyFilters(Rec);
                CalcJ.SetFilter(code, '%1', rec.Code);
                CalcJ.SetFilter("Date Difference 3", '%1', DatePrevious);
                if CalcJ.FindFirst() then begin
                    Prvi3 := true;
                end;

                CalcJ.Reset();
                CalcJ.CopyFilters(Rec);
                CalcJ.SetFilter(code, '%1', rec.Code);
                CalcJ.SetFilter("Date Difference 4", '%1', DatePrevious);
                if CalcJ.FindFirst() then begin
                    Prvi4 := true;
                end;

                CalcJ.Reset();
                CalcJ.CopyFilters(Rec);
                CalcJ.SetFilter(code, '%1', rec.Code);
                CalcJ.SetFilter("Date Difference 5", '%1', DatePrevious);
                if CalcJ.FindFirst() then begin
                    Prvi5 := true;
                end;





                if BrojMm = 1 then begin

                    R1 := "Range 1";
                    R2 := "Range 2";
                    R3 := "Range 3";
                    R4 := "Range 4";
                    R5 := "Range 5";
                    DatePrevious := "Date for previous Quantity";

                    /*      CJLineExsist.Reset();
                          CJLineExsist.CopyFilters(Rec);
                          CJLineExsist.SetFilter("Difference Amount 1", '<>%1', 0);
                          CJLineExsist.setfilter(code, '%1', rec."Code");
                          if not CJLineExsist.FindFirst() then begin

                              prvi1 := true;

                          end;


                          CJLineExsist.Reset();
                          CJLineExsist.CopyFilters(Rec);
                          CJLineExsist.SetFilter("Difference Amount 2", '<>%1', 0);
                          CJLineExsist.setfilter(code, '%1', rec."Code");
                          if not CJLineExsist.FindFirst() then begin

                              prvi2 := true;

                          end;


                          CJLineExsist.Reset();
                          CJLineExsist.CopyFilters(Rec);
                          CJLineExsist.SetFilter("Difference Amount 3", '<>%1', 0);
                          CJLineExsist.setfilter(code, '%1', rec."Code");
                          if not CJLineExsist.FindFirst() then begin

                              prvi3 := true;

                          end;


                          CJLineExsist.Reset();
                          CJLineExsist.CopyFilters(Rec);
                          CJLineExsist.SetFilter("Difference Amount 4", '<>%1', 0);
                          CJLineExsist.setfilter(code, '%1', rec."Code");
                          if not CJLineExsist.FindFirst() then begin

                              prvi4 := true;

                          end;


                          CJLineExsist.Reset();
                          CJLineExsist.CopyFilters(Rec);
                          CJLineExsist.SetFilter("Difference Amount 5", '<>%1', 0);
                          CJLineExsist.setfilter(code, '%1', rec."Code");
                          if not CJLineExsist.FindFirst() then begin

                              prvi5 := true;

                          end;*/

                end;
                CJLine.Reset();
                CJLine.SetFilter(Code, '<>%1', rec.Code);
                CJLine.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                // CJLine.SetFilter(Gauge, '%1', rec.Gauge);
                CJLine.SetFilter("Customer No.", '%1', rec."Customer No.");
                if "Date for previous Quantity" = 0D then
                    CJLine.SetFilter("Calculation Date To", '%1..%2', DMY2Date(1, Date2DMY(DatePrevious, 2), Date2DMY(DatePrevious, 3)), DatePrevious)
                else
                    CJLine.SetFilter("Calculation Date To", '%1..%2', DMY2Date(1, Date2DMY("Date for previous Quantity", 2), Date2DMY("Date for previous Quantity", 3)), "Date for previous Quantity");
                CJLine.SetCurrentKey("Calculation Date To");
                CJLine.Ascending;
                if CJLine.FindLast() then begin



                    if Prvi1 then begin
                        //da uzmem razliku od prethodnog mjeseca uvećanu za 20 % (npr)
                        if "Range 1" = 0 then "Range 1" := R1;

                        DecimalV := ("Range 1" / 100 * CJLine.Difference + CJLine.Difference);
                        if CJLine.Difference <> 0 then
                            "New and Old value compare" := (rec.Difference / CJLine.Difference) * 100
                        else
                            "New and Old value compare" := 0;

                        if rec."Max Difference" <> 0 then
                            "New and Old value compare Max" := (rec.Difference / rec."Max Difference") * 100
                        else
                            "New and Old value compare Max" := 0;


                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                        if Evaluate(DecimalV2E, DecimalV2) then begin

                            if DecimalV2E > 50 then
                                validate("Difference Amount 1", Round(("Range 1" / 100 * CJLine.Difference + CJLine.Difference), 1, '>'))
                            else
                                validate("Difference Amount 1", Round(("Range 1" / 100 * CJLine.Difference + CJLine.Difference), 1, '<'));
                            if rec.Difference > rec."Difference Amount 1"
                            then
                                "Difference Out of range 1" := true
                            else
                                "Difference Out of range 1" := False;

                            if "Date for previous Quantity" <> 0D then
                                rec."Date Difference 1" := "Date for previous Quantity"
                            else
                                rec."Date Difference 1" := DatePrevious;
                            rec."Date for previous Quantity" := DatePrevious;
                            rec."Range 1" := R1;


                        end;






                        //popuni vrijednost prethodni

                    end
                    else begin

                        if Prvi2 then begin

                            if "Range 2" = 0 then "Range 2" := R2;
                            DecimalV := ("Range 2" / 100 * CJLine.Difference + CJLine.Difference);
                            DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                            if Evaluate(DecimalV2E, DecimalV2) then begin

                                if DecimalV2E > 50 then
                                    validate("Difference Amount 2", Round(("Range 2" / 100 * CJLine.Difference + CJLine.Difference), 1, '>'))
                                else
                                    validate("Difference Amount 2", Round(("Range 2" / 100 * CJLine.Difference + CJLine.Difference), 1, '<'));

                                if rec.Difference > rec."Difference Amount 2"
                                then
                                    "Difference Out of range 2" := true
                                else
                                    "Difference Out of range 2" := False;

                                // rec."Date Difference 2" := "Date for previous Quantity";
                                if "Date for previous Quantity" <> 0D then
                                    rec."Date Difference 2" := "Date for previous Quantity"
                                else
                                    rec."Date Difference 2" := DatePrevious;
                            end;

                        end
                        else begin


                            if Prvi3 then begin
                                if "Range 3" = 0 then "Range 3" := R3;
                                DecimalV := ("Range 3" / 100 * CJLine.Difference + CJLine.Difference);
                                DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                if Evaluate(DecimalV2E, DecimalV2) then begin


                                    if DecimalV2E > 50 then
                                        validate("Difference Amount 3", Round(("Range 3" / 100 * CJLine.Difference + CJLine.Difference), 1, '>'))
                                    else
                                        validate("Difference Amount 3", Round(("Range 3" / 100 * CJLine.Difference + CJLine.Difference), 1, '<'));

                                    if rec.Difference > rec."Difference Amount 3"
                                    then
                                        "Difference Out of range 3" := true
                                    else
                                        "Difference Out of range 3" := False;

                                    //   rec."Date Difference 3" := "Date for previous Quantity";
                                    if "Date for previous Quantity" <> 0D then
                                        rec."Date Difference 3" := "Date for previous Quantity"
                                    else
                                        rec."Date Difference 3" := DatePrevious;
                                end;
                            end
                            else begin

                                if Prvi4 then begin
                                    if "Range 4" = 0 then "Range 4" := R4;
                                    DecimalV := ("Range 4" / 100 * CJLine.Difference + CJLine.Difference);
                                    DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                    if Evaluate(DecimalV2E, DecimalV2) then begin


                                        //    Rec.validate("Difference Amount 4", DecimalV2E);

                                        if DecimalV2E > 50 then
                                            validate("Difference Amount 4", Round(("Range 4" / 100 * CJLine.Difference + CJLine.Difference), 1, '>'))
                                        else
                                            validate("Difference Amount 4", Round(("Range 4" / 100 * CJLine.Difference + CJLine.Difference), 1, '<'));

                                        if rec.Difference > rec."Difference Amount 4"
                                        then
                                            "Difference Out of range 4" := true
                                        else
                                            "Difference Out of range 4" := False;

                                        //    rec."Date Difference 4" := "Date for previous Quantity";
                                        if "Date for previous Quantity" <> 0D then
                                            rec."Date Difference 4" := "Date for previous Quantity"
                                        else
                                            rec."Date Difference 4" := DatePrevious;
                                    end;

                                end
                                else begin

                                    if Prvi5 then begin

                                        if "Range 5" = 0 then "Range 5" := R5;
                                        DecimalV := ("Range 5" / 100 * CJLine.Difference + CJLine.Difference);
                                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                        if Evaluate(DecimalV2E, DecimalV2) then begin



                                            Rec.validate("Difference Amount 5", DecimalV2E);
                                            if rec.Difference > rec."Difference Amount 5"
                                            then
                                                "Difference Out of range 5" := true
                                            else
                                                "Difference Out of range 5" := False;

                                            //   rec."Date Difference 5" := "Date for previous Quantity";
                                            if "Date for previous Quantity" <> 0D then
                                                rec."Date Difference 5" := "Date for previous Quantity"
                                            else
                                                rec."Date Difference 5" := DatePrevious;
                                        end;

                                    end
                                    else begin

                                        Error('Maksimalan broj datuma za usporedbu je napravljen!');

                                    end;

                                end;

                            end;
                        end;

                    end;

                    Rec.Modify();
                    Commit();

                end;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(BrojMm));
                Progress.UPDATE(2, CurrentDateT);
            until rec.Next() = 0;



    end;


            }
            action("Get DATA")
            {

                Caption = 'Get Data';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        Csetup: Record "Calculation Setup";
        ELV: Record "El. Volume Corr";
        CustC: Record Customer;
        CH: Record "Calcuation Header";
        NacinIzracunaPM: Boolean;
        Unb2: Record "Calculation Journal Line";
        CodeC: Integer;
        Unb: Record "Calculation Journal Line";

        MM: Record "Service Item";
        IHFacility: Record "Installation History";
        UnbMonth: Integer;
        StreetInt: Integer;
        BrojNeocitanihMjeseci: Integer;
        LastYeartF: Record "Calculation Journal Line";
        SalesPr: Record "Sales Price";
        iHC: Record "Installation History";
        CJLUnReadBefore: Record "Calculation Journal Line";
        CJLUnReadBefore2: Record "Calculation Journal Line";
        RezDecimal: Decimal;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        Gaug2: Record Gauge;
        GetF: Record Stroke;
        TestSubsCu: Codeunit TestSubsCu;
        StreetText: text[20];
        StreetInteger: integer;
        Stroke: Record Stroke;
        Even: Boolean;
        MMInt: Integer;
        ELVolumeCode: Record "El. Volume Corr";
        FloorInt: Integer;
        AparmentInt: Integer;
        SHMM: Record "Status History MM";
        IHreading: Record "Installation History";
        cu: Record Customer;
        MMStreetInt: Integer;

    begin
        if rec.FindSet() then
            repeat


                Csetup.get;
                CustC.get(rec."Customer No.");


                CH.Reset();
                CH.SetFilter(Code, '%1', rec.Code);
                ch.SetFilter(Status, '%1', CH.Status::Open);
                if ch.FindFirst() then begin
                    if rec."Calculation Date From" = 0D then
                        Rec."Calculation Date From" := ch."Calculation Date From";
                    if Rec."Calculation Date To" = 0D then
                        Rec."Calculation Date To" := ch."Calculation Date To";

                    if (ch."Month Of GAS Calculation" = rec."Month Of GAS Calculation")
                    and (ch."Year Of GAS Calculation" = rec."Year Of GAS Calculation") then
                        Rec."Calorific power coefficient" := Csetup."Calorific power coefficient";
                    Rec."Atmospheric pressure" := Csetup."Atmospheric pressure";
                    Rec."Scale factor" := Csetup."Scale factor";
                    Rec."Compression coefficient" := Csetup."Compression coefficient";

                    IF CU.Get(Rec."Customer No.") THEN BEGIN
                        cu.CalcFields("MZ Name Customer", "MZ Name Customer 2", "Street Name Customer", "Street Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2");
                        rec."Post Code Customer" := CU."Post Code";
                        rec.Agreement := cu.Agreement;

                        rec."Bill distribution percentage" := cu."Bill distribution percentage";
                        rec."E-Mail 2" := cu."E-Mail 2";
                        rec."E-Mail 2" := Replacestring_TName(rec."E-Mail 2", ';', 'ĐĐ');
                        rec."E-mail Delivery" := cu."E-mail Delivery";
                        rec."Address Customer" := cu.Address;
                        rec."Address 2" := cu."Address 2";
                        rec."Reminder Terms Code" := CU."Reminder Terms Code";
                        rec."E-mail Delivery Date" := cu."E-mail Delivery Date";
                        rec."E-mail Delivery Date to" := cu."E-mail Delivery Date to";
                        rec."Post Code Customer D." := CU."Post Code 2";
                        rec."City Customer" := CU.City;
                        rec."City Customer D." := CU."City 2";
                        rec."Customer string" := cu."Customer String";
                        rec."Customer String 2" := cu."Customer String 2";
                        rec."Customer Stroke" := cu."Customer Stroke";
                        rec."Customer Stroke 2" := cu."Customer Stroke 2";
                        rec."MZ Customer" := cu."MZ Customer";
                        rec."MZ Customer 2" := cu."MZ Customer 2";
                        rec."MZ Name Customer" := cu."MZ Name Customer";
                        rec."MZ Name Customer 2" := cu."MZ Name Customer 2";
                        rec."Floor Customer" := cu."Floor Customer";
                        rec."Floor Customer 2" := cu."Floor Customer 2";
                        rec."Street Customer" := cu."Street Customer";
                        rec."Home No. Customer 2" := cu."Home No. Customer 2";
                        rec."Street Customer 2" := cu."Street Customer 2";
                        rec."Street Name Customer" := cu."Street Name Customer";
                        rec."Street Name Customer 2" := cu."Street Name Customer 2";
                        rec."Municipality Code Customer" := cu."Municipality Code Customer";
                        rec."Municipality Code Customer 2" := cu."Municipality Code Customer 2";
                        rec."Municipality Name Customer" := cu."Municipality Name Customer";
                        rec."Municipality Name Customer 2" := cu."Municipality Name Customer 2";
                        rec."Street No." := cu."Street No.";
                        rec."Street No. 2" := cu."Street No. 2";
                        rec."Street No.2 Text" := cu."Street No.2 Text";
                        rec."Street No. Text" := cu."Street No. Text";
                        rec."Apartment No. Customer 2" := cu."Apartment No. Customer 2";
                        rec."Zone stroke" := cu."Zone stroke";
                        rec."Zone stroke 2" := cu."Zone stroke 2";
                        rec.Street := cu."Street Customer";
                        rec."Home No. Customer 2" := cu."Home No. Customer 2";


                    END;
                    MM.Reset();
                    MM.SetFilter("No.", '%1', Rec."Measuring Point Code");
                    mm.SetAutoCalcFields("Street Name MM", "Municipality Name MM", "MZ Name MM", "Street Name MM", "Municipality Name MM", "Status MM");
                    if mm.FindSet() then begin
                        rec."Adjusted Pressure" := mm."Adjusted Pressure";
                        rec."Pressure Date" := mm."Pressure Date";


                        //   mm.CalcFields("Street Name MM", "Municipality Name MM");

                        rec."Address MM" := mm.Address;
                        rec."Street MM" := mm.Street;
                        rec."Dwelling Type" := mm."Dwelling Type";



                        //  mm.CalcFields("MZ Name MM", "Street Name MM", "Municipality Name MM");

                        if Evaluate(MMStreetInt, MM."Street No.") then
                            rec."Street No. Int MM" := MMStreetInt
                        else
                            rec."Street No. Int MM" := 0;



                        if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                            rec."Street No. Text Apartment" := AparmentInt
                        else
                            rec."Street No. Text Apartment" := 0;









                        mm.CalcFields("Post Code");
                        rec."Post Code MM" := MM."Post Code";
                        mm.CalcFields(City);
                        rec."City MM" := MM."City MM";

                        mm.CalcFields("Status MM");
                        rec."Street No. Text MM" := mm."Street No. Text";
                        rec."Status MM" := mm."Status MM";
                        rec."Current Status MM" := mm."Status MM";
                        rec.Activity := mm.Activity;
                        rec."EF Activity" := mm."EF Activity";
                        rec."EU Activity" := mm."EU Activity";


                        rec."Measuring point off" := mm."Measuring point off";
                        rec."Measuring point off Date" := mm."Measuring point off Date";
                        rec."Street Name MM" := MM."Street Name MM";
                        if Evaluate(StreetInt, mm."Street No.") then begin
                            rec."Street No. int" := StreetInt;
                        end
                        else begin
                            rec."Street No. int" := 0;
                        end;


                        if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                            rec."Street No. Text Apartment" := AparmentInt
                        else
                            rec."Street No. Text Apartment" := 0;


                        if Evaluate(FloorInt, mm.Floor) then
                            rec."Street No. Text int" := FloorInt
                        else
                            rec."Street No. Text int" := 0;

                        rec.Floor := mm.Floor;
                        rec."Address MM" := mm."Address MM";
                        rec."Street MM" := mm.Street;
                        rec."Dwelling Type" := mm."Dwelling Type";
                        rec."Measuring Point string" := mm."Measuring Point string";
                        rec."Measuring Point Stroke" := mm."Measuring Point Stroke";
                        rec."Posting GAS" := mm."Posting GAS";
                        rec."Apartment No." := mm."Apartment No.";
                        rec."Municipality Code MM" := MM."Municipality Code MM";
                        rec."Municipality Name MM" := mm."Municipality Name MM";
                        rec."Zone stroke MM" := mm."Zone stroke";

                        rec."Summer Zone" := mm."Summer Zone";
                        if mm."Control Number" <> '' then
                            rec.Agreement := mm."Control Number";
                        rec."Winter Zone" := mm."Winter Zone";
                        rec."Measuring Zone - summer" := mm."Measuring Zone - summer";
                        rec."Measuring Zone - winter" := mm."Measuring Zone - winter";
                        rec."MM Description" := mm.Description + mm."Description 2";
                        rec."Reading Mode" := mm."Reading Mode";
                        rec."Mobile No." := mm."Mobile No.";
                        rec."Fictitious Code" := mm."Fictitious Code";


                        rec."Type of reading" := mm."Type of reading";
                        rec."Reading Time" := mm."Reading Time";
                        if rec."Reading Time" = rec."Reading Time"::"Per Year" then
                            rec."Source Data" := rec."Source Data"::"Per Year";

                        rec.Posting := mm.Posting;
                        rec.Distribution := mm.Distribution;
                        rec."Distribution - read" := mm."Distribution - read";
                        rec.Specification := mm.Specification;
                        rec."Bill delivery" := mm."Bill delivery";
                        rec."RMS Maintenance" := mm."RMS Maintenance";
                        rec."Winter Zone" := mm."Winter Zone";
                        rec."Remotely Type" := mm."Remotely Type";
                        rec."Transit Zone" := mm."Transit Zone";


                        //     rec."Municipality Code Customer" := mm."Municipality Code Customer";
                        //   rec."Municipality Name Customer" := mm."Municipality Name Customer";
                        //     rec."Street Customer" := mm."Street Customer";
                        //   rec."Street Name Customer" := mm."Street Name Customer";
                        rec."Floor Customer" := mm."Floor Customer";
                        rec."Apartment No. Customer" := mm."Apartment No. Customer";
                        rec."Home No. Customer" := mm."Home No. Customer";
                        rec."Home No." := mm."Home No.";
                        rec."Category Customer" := mm."Customer Category";
                        rec."Category MM" := mm."MM Category";
                        rec."Customer No." := mm."Customer No.";
                        rec."MZ Customer" := mm."MZ Customer";

                        if Evaluate(AparmentInt, mm."Apartment No.") then
                            rec."Street No. Text Apartment" := AparmentInt
                        else
                            rec."Street No. Text Apartment" := 0;


                        rec."MM Description" := mm.Description + mm."Description 2";
                        rec."Method of calculation" := mm."Method of calculation";
                        if (rec."Category MM" = rec."Category MM"::Household) or (rec."Category MM" = rec."Category MM"::"Small Economy") then
                            rec."Method of calculation" := rec."Method of calculation"::"1";
                        rec."MZ MM" := mm."MZ MM";
                        rec."MZ Name MM" := mm."MZ Name MM";
                        rec.Code := ch.Code;
                        rec."Month of Calculation" := ch."Month of Calculation";
                        rec."Year of Calculation" := ch."Year of Calculation";
                        rec."Month Of GAS Calculation" := ch."Month Of GAS Calculation";
                        rec."Year Of GAS Calculation" := ch."Year Of GAS Calculation";

                        CU.get(Rec."Customer No.");
                        cu.CalcFields("MZ Name Customer", "MZ Name Customer 2");
                        SalesPr.Reset();
                        SalesPr.SetFilter("Item No.", '%1', Csetup."Item No. 2");
                        SalesPr.SetFilter("Sales Code", '%1', cu."Customer Price Group");
                        SalesPr.SetFilter("Starting Date", '<=%1', rec."Reading Date To");
                        SalesPr.SetCurrentKey("Starting Date");
                        SalesPr.Ascending(False);
                        if SalesPr.findfirst() then begin
                            rec."Purchase Unit Price" := SalesPr."Purchase unit price";
                            rec."Distribution Unit Price" := SalesPr."Unit price of distribution";
                            rec."Sales Unit Price" := SalesPr."Unit Price";

                            rec."Unit Price" := SalesPr."Unit Price";
                        end
                        else begin

                            rec."Purchase Unit Price" := 0;
                            rec."Distribution Unit Price" := 0;
                            rec."Sales Unit Price" := 0;
                            rec."Unit Price" := 0;

                        end;
                        RezDecimal := 0;
                        rec."Customer Balance" := 0;
                        rec."Customer Prepayment" := 0;

                        CustomerLedgerEntry.Reset();
                        CustomerLedgerEntry.SetFilter("Customer No.", '%1', cu."No.");
                        CustomerLedgerEntry.SetFilter("Bill Type", '%1|%2|%3', '01', '02', '03');
                        CustomerLedgerEntry.SetFilter(Prepayment, '%1', false);
                        CustomerLedgerEntry.SetFilter(Open, '%1', true);

                        if CustomerLedgerEntry.FindSet() then
                            repeat
                                CustomerLedgerEntry.calcfields("Remaining Amt. (LCY)");

                                RezDecimal += CustomerLedgerEntry."Remaining Amt. (LCY)";


                            until CustomerLedgerEntry.Next() = 0;

                        if RezDecimal > 0 then
                            rec."Customer Balance" := RezDecimal
                        else
                            rec."Customer Prepayment" := abs(RezDecimal);
                        rec."Customer Name" := CU.Name + Cu."Name 2";
                        rec."Registration No." := CU."Registration No.";
                        rec."VAT Registration No." := CU."VAT Registration No.";
                        rec."Customer string" := cu."Customer String";
                        rec."Customer Stroke" := CU."Customer Stroke";
                        rec."MZ Customer" := CU."MZ Customer";
                        rec."Floor Customer" := CU."Floor Customer";
                        rec."Street Customer" := CU."Street Customer";
                        rec."Home No. Customer 2" := cu."Home No. Customer 2";
                        rec."Address Customer" := CU.Address;
                        rec."MZ Name Customer" := CU."MZ Name Customer";
                        rec."Category Customer" := CU."Customer Category";
                        rec."Home No. Customer" := CU."Home No. Customer";
                        rec."Address 2" := cu."Address 2";
                        rec."Reminder Terms Code" := CU."Reminder Terms Code";
                        rec."Street Customer 2" := cu."Street Customer 2";
                        cu.CalcFields("Street Name Customer 2", "Street Name Customer");
                        rec."Street Name Customer 2" := cu."Street Name Customer 2";


                        rec."Street Name Customer" := CU."Street Name Customer";
                        rec."Municipality Code Customer" := cu."Municipality Code Customer";
                        rec."Reminder Terms Code" := CU."Reminder Terms Code";
                        cu.CalcFields("Municipality Name Customer");
                        rec."Municipality Name Customer" := cu."Municipality Name Customer";



                    end;
                    Gaug2.Reset();
                    Gaug2.SetFilter(Code, '%1', Rec.Code);
                    Gaug2.SetLoadFields("Inventar number", "Gauge Size", Code);
                    if Gaug2.FindSet() then begin

                        rec."Serial Number" := Gaug2."Inventar number";
                        rec."Gauge Size" := Gaug2."Gauge Size";
                    end;

                    rec."Max Difference" := 0;

                    LastYeartF.Reset();
                    // LastYeartF.SetFilter("Customer No.", '%1', rec."Customer No.");
                    LastYeartF.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                    LastYeartF.SetFilter(Code, '<>%1', rec.Code);
                    LastYeartF.SetCurrentKey(SM3);
                    LastYeartF.Ascending(false);
                    if LastYeartF.FindFirst() then begin
                        rec."Max Difference" := LastYeartF.SM3;
                    end;


                    //GetMaxNewValueExceptCurrent
                    rec."Last Year Calculation" := 0;
                    LastYeartF.Reset();
                    //  LastYeartF.SetFilter("Customer No.", '%1', rec."Customer No.");
                    LastYeartF.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                    LastYeartF.SetFilter("Year Of GAS Calculation", '%1', Date2DMY(rec."Calculation Date To", 3) - 1);
                    LastYeartF.SetFilter("Month Of GAS Calculation", '%1', Date2DMY(rec."Calculation Date To", 2));
                    LastYeartF.SetCurrentKey("Reading Date To");
                    LastYeartF.Ascending(false);
                    if LastYeartF.FindSet() then begin
                        LastYeartF.CalcSums(sm3);
                        rec."Last Year Calculation" := LastYeartF.SM3;


                    end;




                    rec."EL Volume Code" := '';
                    rec."Corrector Code" := 0;
                    rec."EL Correctior Type" := '';
                    rec."EL Volume Description" := '';
                    rec."UnCorrection previous - gauge" := 0;
                    rec."Correction previous - gauge" := 0;
                    rec."UnCorrection new- gauge" := 0;
                    rec."Correction new- gauge" := 0;


                    if (rec."Old Gauge" = false) and (rec."New Gauge" = false) then begin

                        CJLUnReadBefore.Reset();
                        //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                        CJLUnReadBefore.SetFilter(Gauge, '%1', rec.Gauge);
                        CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                        CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                        CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                        CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                        CJLUnReadBefore.Ascending(False);
                        if CJLUnReadBefore.FindFirst()
                         then begin
                            rec."Old Value" := CJLUnReadBefore."New Value";

                        end
                        else begin
                            rec."Old Value" := 0;
                        end;

                        CJLUnReadBefore.Reset();
                        //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                        CJLUnReadBefore.SetFilter(Gauge, '%1', rec.Gauge);
                        CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                        CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                        //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                        CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                        CJLUnReadBefore.Ascending(false);
                        if CJLUnReadBefore.FindFirst()
                         then begin
                            //  rec."Old Value" := CJLUnReadBefore."Old Value";
                            rec."Previous Date" := CJLUnReadBefore."Reading Date To";
                            rec."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                            rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                            rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                            rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                            rec."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                            rec."Method of calculation" := CJLUnReadBefore."Method of calculation";

                            rec."Temperature new- gauge" := 0;
                            rec."New Value" := 0;
                            rec."Pressure new- gauge" := 0;
                            rec."Correction new- gauge" := 0;
                            rec."UnCorrection new- gauge" := 0;

                            if (rec."Category MM" = rec."Category MM"::Household) or (rec."Category MM" = rec."Category MM"::"Small Economy") then
                                rec."Method of calculation" := rec."Method of calculation"::"1";

                            if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                rec."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                rec."Old Value" := CJLUnReadBefore."Old Value";
                            end;
                            rec."Pressure Correction" := CJLUnReadBefore."Pressure Correction";
                            rec."Temperature Correction" := CJLUnReadBefore."Temperature Correction";

                        end
                        else begin


                            CJLUnReadBefore.Reset();
                            CJLUnReadBefore.SetFilter(Gauge, '%1', Rec.Code);
                            //  CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                            CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending(false);
                            if CJLUnReadBefore.FindFirst()
                             then begin
                                rec."Old Value" := CJLUnReadBefore."New Value";

                            end
                            else begin
                                rec."Old Value" := 0;
                            end;

                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            CJLUnReadBefore.SetFilter(gauge, '%1', rec.Gauge);
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                            //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending(false);
                            if CJLUnReadBefore.findfirst()
                             then begin
                                // rec."Old Value" := CJLUnReadBefore."Old Value";
                                rec."Previous Date" := CJLUnReadBefore."Reading Date To";
                                rec."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                rec."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                rec."Method of calculation" := CJLUnReadBefore."Method of calculation";
                                if (rec."Category MM" = rec."Category MM"::Household) or (rec."Category MM" = rec."Category MM"::"Small Economy") then
                                    rec."Method of calculation" := rec."Method of calculation"::"1";
                                if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                    rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                    rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                    rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                    rec."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                    rec."Old Value" := CJLUnReadBefore."Old Value";
                                end;

                                rec."Temperature new- gauge" := 0;
                                rec."New Value" := 0;
                                rec."Pressure new- gauge" := 0;
                                rec."Correction new- gauge" := 0;
                                rec."UnCorrection new- gauge" := 0;



                            end
                            else begin
                                rec."Previous Date" := 0D;
                                rec."Previous method of calculation" := rec."Previous method of calculation"::"1";
                                rec."Temperature previous - gauge" := 0;
                                rec."Pressure previous - gauge" := 0;
                                rec."UnCorrection previous - gauge" := 0;
                                rec."Correction previous - gauge" := 0;
                                rec."Method of calculation" := 0;
                            end;





                        end;
                    end;







                    if ((rec."New Gauge" = false) and (rec."Old Gauge" = false)) or (rec."New Gauge" = true) then begin

                        iHC.Reset();
                        iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                        iHC.SetFilter("Customer No.", '%1', rec."Customer No.");
                        iHC.SetFilter(Active, '%1', true);
                        ihc.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                        iHC.SetLoadFields(Code, "EL Volume Description");
                        if iHC.FindSet() then begin
                            if rec."New Gauge" = true then begin
                                rec."UnCorrection previous - gauge" := ihc."Unadjusted Volume";
                                rec."Correction previous - gauge" := ihc."Adjusted Volume";
                                rec."Pressure Correction" := ihc."Absolute Pressure Of Corrector";
                                rec."Temperature Correction" := ihc."Temperature Value";
                            end;


                            if (rec."Old Gauge" = false) and (rec."New Gauge" = false) then begin

                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter(Gauge, '%1', rec.Gauge);
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                                CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending(False);
                                if CJLUnReadBefore.FindFirst()
                                 then begin
                                    rec."Old Value" := CJLUnReadBefore."New Value";

                                end
                                else begin
                                    rec."Old Value" := 0;
                                end;

                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter(Gauge, '%1', rec.Gauge);
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                                //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending(false);
                                if CJLUnReadBefore.FindFirst()
                                 then begin
                                    //  rec."Old Value" := CJLUnReadBefore."Old Value";
                                    rec."Previous Date" := CJLUnReadBefore."Reading Date To";
                                    rec."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                    rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                    rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                    rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                    rec."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                    rec."Method of calculation" := CJLUnReadBefore."Method of calculation";

                                    rec."Temperature new- gauge" := 0;
                                    rec."New Value" := 0;
                                    rec."Pressure new- gauge" := 0;
                                    rec."Correction new- gauge" := 0;
                                    rec."UnCorrection new- gauge" := 0;

                                    if (rec."Category MM" = rec."Category MM"::Household) or (rec."Category MM" = rec."Category MM"::"Small Economy") then
                                        rec."Method of calculation" := rec."Method of calculation"::"1";

                                    if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                        rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                        rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                        rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                        rec."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                        rec."Old Value" := CJLUnReadBefore."Old Value";
                                    end;
                                    rec."Pressure Correction" := CJLUnReadBefore."Pressure Correction";
                                    rec."Temperature Correction" := CJLUnReadBefore."Temperature Correction";

                                end
                                else begin


                                    CJLUnReadBefore.Reset();
                                    CJLUnReadBefore.SetFilter(Gauge, '%1', Rec.Code);
                                    //  CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                                    CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                                    CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                                    CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                    CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                    CJLUnReadBefore.Ascending(false);
                                    if CJLUnReadBefore.FindFirst()
                                     then begin
                                        rec."Old Value" := CJLUnReadBefore."New Value";

                                    end
                                    else begin
                                        rec."Old Value" := 0;
                                    end;

                                    CJLUnReadBefore.Reset();
                                    //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                    CJLUnReadBefore.SetFilter(gauge, '%1', rec.Gauge);
                                    CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                                    CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                                    //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                    CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                    CJLUnReadBefore.Ascending(false);
                                    if CJLUnReadBefore.findfirst()
                                     then begin
                                        // rec."Old Value" := CJLUnReadBefore."Old Value";
                                        rec."Previous Date" := CJLUnReadBefore."Reading Date To";
                                        rec."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                        rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                        rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                        rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                        rec."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                        rec."Method of calculation" := CJLUnReadBefore."Method of calculation";
                                        if (rec."Category MM" = rec."Category MM"::Household) or (rec."Category MM" = rec."Category MM"::"Small Economy") then
                                            rec."Method of calculation" := rec."Method of calculation"::"1";
                                        if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                            rec."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                            rec."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                            rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                            rec."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                            rec."Old Value" := CJLUnReadBefore."Old Value";
                                        end;

                                        rec."Temperature new- gauge" := 0;
                                        rec."New Value" := 0;
                                        rec."Pressure new- gauge" := 0;
                                        rec."Correction new- gauge" := 0;
                                        rec."UnCorrection new- gauge" := 0;



                                    end
                                    else begin
                                        rec."Previous Date" := 0D;
                                        rec."Previous method of calculation" := rec."Previous method of calculation"::"1";
                                        rec."Temperature previous - gauge" := 0;
                                        rec."Pressure previous - gauge" := 0;
                                        rec."UnCorrection previous - gauge" := 0;
                                        rec."Correction previous - gauge" := 0;
                                        rec."Method of calculation" := 0;
                                    end;




                                end;
                            end;
                            rec."UnCorrection result- gauge" := rec."UnCorrection new- gauge" - rec."UnCorrection previous - gauge";
                            rec."Correction result- gauge" := rec."Correction new- gauge" - rec."Correction previous - gauge";



                            rec."EL Volume Code" := iHC.Code;
                            if Evaluate(CodeC, iHC.code) then
                                rec."Corrector Code" := CodeC
                            else
                                rec."Corrector Code" := 0;

                            rec."EL Volume Description" := iHC."Inventory Number";
                            ELV.Reset();
                            ELV.SetFilter(Code, '%1', iHC.Code);
                            if ELV.FindFirst() then begin
                                rec."EL Correctior Type" := elv.Model;
                                rec."EL Volume Description" := ELV."Serial Number";
                            end;

                            //novi mjerač /novi korektor kakav mu je aktivan ()


                        end;
                    end;


                    if rec."Old Gauge" = true then begin //treba mi stari korektor


                        iHC.Reset();
                        iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                        iHC.SetFilter("Customer No.", '%1', rec."Customer No.");
                        ihc.SetFilter("Dismantling date", '%1', rec."Reading Date To");

                        ihc.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");

                        iHC.SetLoadFields(Code, "EL Volume Description");

                        iHC.SetCurrentKey("Installation Date");
                        iHC.Ascending(False);
                        if iHC.findfirst() then begin

                            rec."EL Volume Code" := iHC.Code;

                            /*    rec."UnCorrection new- gauge" := ihc."Unadjusted Volume";
                                rec."Correction new- gauge" := ihc."Adjusted Volume";
                                rec."Temperature Correction" := ihc."Temperature Value";
                                rec."Pressure Correction" := ihc."Absolute Pressure Of Corrector";*/


                            IHFacility.Reset();
                            IHFacility.SetFilter(Type, '%1', IHFacility.Type::Corrector);
                            IHFacility.SetFilter("Date of consumption", '%1', rec."Reading Date To");
                            IHFacility.SetFilter(Code, '%1', ihc.Code);
                            if IHFacility.FindFirst() then begin
                                rec."UnCorrection new- gauge" := IHFacility."Unadjusted Volume";
                                rec."Correction new- gauge" := IHFacility."Adjusted Volume";
                                rec."Temperature Correction" := IHFacility."Temperature Value";
                                rec."Pressure Correction" := IHFacility."Absolute Pressure Of Corrector"
                            end
                            else begin
                                rec."UnCorrection new- gauge" := 0;
                                rec."Correction new- gauge" := 0;
                                rec."Temperature Correction" := 0;
                                rec."Pressure Correction" := 0;
                            end;


                            //before od mjerača
                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            CJLUnReadBefore.SetFilter(gauge, '%1', rec.Gauge);
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', rec."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', rec.Code);
                            CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending(false);
                            if CJLUnReadBefore.findfirst()
                             then begin
                                // rec."Old Value" := CJLUnReadBefore."Old Value";

                                rec."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                rec."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";

                            end
                            else begin

                                rec."UnCorrection previous - gauge" := 0;
                                rec."Correction previous - gauge" := 0;
                            end;


                            //kraj





                            rec."UnCorrection result- gauge" := rec."UnCorrection new- gauge" - rec."UnCorrection previous - gauge";
                            rec."Correction result- gauge" := rec."Correction new- gauge" - rec."Correction previous - gauge";

                            //sada bi trebala uzeti staru vrijednost po obračuna sa korektora


                            rec."EL Volume Code" := iHC.Code;
                            if Evaluate(CodeC, iHC.code) then
                                rec."Corrector Code" := CodeC
                            else
                                rec."Corrector Code" := 0;

                            rec."EL Volume Description" := iHC."Inventory Number";
                            ELV.Reset();
                            ELV.SetFilter(Code, '%1', iHC.Code);
                            if ELV.FindFirst() then begin
                                rec."EL Correctior Type" := elv.Model;
                                rec."EL Volume Description" := ELV."Serial Number";
                            end;
                        end;
                    end;
                    if (rec."New Gauge" = true) or (rec."Old Gauge" = true) then
                        rec."Filter by Old RMS" := true;
                    // if (rec."Previous Date" <> 0D) and (rec."Filter by Old RMS" = false) then
                    //   rec."Reading Date From" := rec."Previous Date";

                    //   if (rec."Calculation Date From" - rec."Reading Date From" > 10) and (rec."Filter by Old RMS" = false) then
                    //     rec."Reading Date From" := rec."Calculation Date From";




                    if rec."Reading Date From" <= CalcDate('<-5D>', ch."Calculation Date From")
                                     then
                        rec."Reading Date From" := ch."Calculation Date From";

                    if rec."Reading Date To" < ch."Calculation Date From" then
                        rec."Reading Date To" := ch."Calculation Date To";



                    if rec."Calculation Date From" <= CalcDate('<-5D>', ch."Calculation Date From")
                                      then
                        rec."Calculation Date From" := ch."Calculation Date From";


                    if rec."Calculation Date To" < ch."Calculation Date From" then
                        rec."Calculation Date To" := ch."Calculation Date To";


                    if (rec."Category MM" = rec."Category MM"::Household) or (rec."Category MM" = rec."Category MM"::"Small Economy") then
                        rec."Method of calculation" := rec."Method of calculation"::"1";



                    mm.get(rec."Measuring Point Code");
                    mm.CalcFields("Status MM");
                    UnbMonth := 0;
                    if NacinIzracunaPM = false then begin
                        Unb.Reset();
                        Unb.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                        Unb.SetFilter("Customer No.", '%1', rec."Customer No.");
                        Unb.SetFilter("Source Data", '<>%1', Unb."Source Data"::Unobvious);
                        Unb.SetFilter("Locked", '%1', true);
                        unb.SetFilter(Code, '<>%1', rec.Code);
                        // Unb.SetFilter("New Value", '<>%1', 0);
                        Unb.SetCurrentKey("Calculation Date To");
                        unb.Ascending(false);
                        if Unb.findfirst() then begin
                            //nađem prvi očitani
                            unb2.Reset();
                            Unb2.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                            Unb2.SetFilter("Customer No.", '%1', rec."Customer No.");
                            Unb2.SetFilter("Calculation Date To", '>%1', unb."Calculation Date To");
                            Unb2.SetFilter("Locked", '%1', true);
                            Unb2.SetFilter("New Gauge", '%1', false);
                            unb2.SetFilter(Code, '<>%1', rec.Code);
                            Unb2.SetCurrentKey("Calculation Date To");
                            if Unb2.FindFirst() then begin
                                UnbMonth := Unb2.Count;
                            end;
                        end;
                    end
                    else begin
                        //vraćam se na prethodni mjesec

                        Unb.Reset();
                        Unb.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                        Unb.SetFilter("Customer No.", '%1', rec."Customer No.");
                        Unb.SetFilter("Locked", '%1', true);
                        unb.SetFilter(Code, '<>%1', rec.Code);
                        unb.SetFilter("Previous Unobvious Month", '<>%1', 0);
                        Unb.SetCurrentKey("Calculation Date To");

                        unb.Ascending(false);
                        if Unb.findfirst() then begin
                            if (unb."Previous Unobvious Month" <> 0) and (unb."Source Data" = Unb."Source Data"::Unobvious) and (unb.Unobvious = false) then begin
                                UnbMonth := unb."Previous Unobvious Month" + 1;
                            end;
                        end;
                    end;
                    rec."Previous Unobvious Month" := UnbMonth;



                    if rec."New Gauge" = true then
                        rec."Previous Date" := rec."Reading Date From";

                    if rec."New Gauge" = true then
                        rec."Previous Unobvious Month" := 0;
                    //ovdje sam dodala end pa ćemo vidjeti
                end;
            until rec.Next() = 0;

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
        CalcSetup: Record "Calculation Setup";
        RP: Record "Resource Price";
        WarDebt: Record "War Debt Setup";
        CalcJ: Record "Calculation Journal Line";
        CER: Record "Currency Exchange Rate";
        CJL2: Record "Calculation Journal Line";
        Journal: Record "Calculation Journal Line";
        VPS: record "VAT Posting Setup";
        SP: Record "Sales Price";
        Resource: Record "Resource";
        CalSetup: Record "Calculation Setup";
        CU: Record customer;
        UnitP: Decimal;
        CustomerPrice: Record Customer;
        Subs: Boolean;
        VatPostingSetup: Record "VAT Posting Setup";
        DecimalV: Decimal;
        Reso: Record Resource;
        DecimalV2: text[250];
        DecimalV2E: Decimal;
        ch: Record "Calcuation Header";
        StartDaT: Time;
        CurrentDateT: Time;
        Progress: Dialog;
        BrojMm: Integer;
        TypeD: Record "Types Of Diseases";
        CustP: Record Customer;
        Perc: Decimal;
        PercMM: Decimal;
        CHWin: Record "Calcuation Header";
        MMPerc: Record "Service Item";
        CustInternal: Record Customer;
        compInfGet: Record "Company Information";
        IntCus: Integer;
        MMF: Record "Service Item";
        CalJournal: Record "Calculation Journal Line";

    begin

        compInfGet.get;
        compInfGet.CalcFields("Billing Signatory", "Billing Sign");

        CH.Reset();
        CH.SetFilter(Code, '%1', rec.Code);
        if ch.FindSet() then begin
            ch."Billing Signatory" := compInfGet."Billing Signatory";
            ch."Billing Signatory Emp" := compInfGet."Billing Signatory Emp";
            ch."Billing Sign" := compInfGet."Billing Sign";
            ch.Modify();
        end;

        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;
        BrojMm := 0;

        if Rec.FindSet() then
            repeat
                CalcSetup.get;

                if rec."Reading Date From" = 0D then
                    rec."Reading Date From" := ch."Calculation Date From";

                if rec."Reading Date To" = 0D then
                    rec."Reading Date To" := ch."Calculation Date To";

                if (ch."Month Of GAS Calculation" = rec."Month Of GAS Calculation")
                        and (ch."Year Of GAS Calculation" = rec."Year Of GAS Calculation") then begin
                    rec.KOEKAL := CalcSetup."Calorific power coefficient";
                    rec."Calorific power coefficient" := CalcSetup."Calorific power coefficient";
                end
                else begin
                    CalJournal.Reset();
                    CalJournal.SetFilter("Month Of GAS Calculation", '%1', rec."Month Of GAS Calculation");
                    CalJournal.SetFilter("Year Of GAS Calculation", '%1', rec."Year Of GAS Calculation");
                    CalJournal.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
                    CalJournal.SetFilter(Code, '<>%1', rec.Code);
                    if CalJournal.FindFirst() then begin
                        rec."Calorific power coefficient" := CalJournal."Calorific power coefficient";
                        rec.KOEKAL := CalJournal."Calorific power coefficient";

                    end
                    else begin
                        CalJournal.Reset();
                        CalJournal.SetFilter("Month Of GAS Calculation", '%1', rec."Month Of GAS Calculation");
                        CalJournal.SetFilter("Year Of GAS Calculation", '%1', rec."Year Of GAS Calculation");
                        if
                        CalJournal.FindFirst() then
                            rec."Calorific power coefficient" := CalJournal."Calorific power coefficient";
                        rec.KOEKAL := CalJournal."Calorific power coefficient";
                    end;

                end;
                CH.Reset();
                CH.SetFilter(Code, '%1', rec.Code);
                if ch.FindSet() then begin
                    if rec."Calculation Date From" = 0D then
                        rec."Calculation Date From" := ch."Calculation Date From";
                    if rec."Calculation Date To" = 0D then
                        rec."Calculation Date To" := ch."Calculation Date To";

                end;

                if Evaluate(IntCus, Rec."Customer No.") then
                    "Customer No. int" := IntCus
                else
                    "Customer No. int" := 0;


                CustP.Reset();
                CustP.SetFilter("No.", '%1', rec."Customer No.");
                if CustP.FindFirst() then
                    Perc := CustP."Bill distribution percentage";

                CHWin.reset;
                CHWin.setfilter(Code, '%1', Rec.code);
                if CHWin.findfirst then begin
                    MMPerc.Reset();
                    MMPerc.SetFilter("No.", '%1', Rec."Measuring Point Code");
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




                Difference := "New Value" - "Old Value";

                if "Method of calculation" = "Method of calculation"::"3" then begin
                    validate(SM3, round((("Correction new- gauge" - "Correction previous - gauge") * "Calorific power coefficient"), 0.01, '='));
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

                    if (rec."Category MM" = rec."Category MM"::"Large Economy") or (rec."Category MM" = rec."Category MM"::"KJKP Heating plant") then begin

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
                if (Perc <> 0) then
                    SM3 := Perc * SM3 / 100;


                if "Reading Date To" = 0D then
                    "Reading Date To" := "Calculation Date To";
                if "Reading Date From" = 0D then
                    "Reading Date From" := "Calculation Date From";
                //održavanje
                ch.get(Code);

                CustomerPrice.Reset;
                CustomerPrice.SetFilter("No.", '%1', "Customer No.");
                if CustomerPrice.FindFirst() then begin


                    SP.Reset();
                    sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                    sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                    sp.SetFilter("Starting Date", '<=%1', "Reading Date To");
                    sp.SetCurrentKey("Starting Date");
                    sp.Ascending;
                    if sp.FindLast() then begin
                        "Unit Price" := SP."Unit Price";
                        "Purchase Unit Price" := sp."Purchase unit price";
                        "Distribution Unit Price" := sp."Unit price of distribution";
                        "Sales Unit Price" := sp."Unit Price";

                        if (rec."Category MM" = rec."Category MM"::"Large Economy")
                        or (rec."Category MM" = rec."Category MM"::"KJKP Heating plant") then begin

                            if sp."Price not by Gauge" = true then begin

                            end
                            else begin

                                ///ĐEMINA
                                TypeD.Reset();
                                TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                                TypeD.SetFilter("Description", '%1', rec."Gauge Size");
                                if TypeD.FindFirst() then begin
                                    if rec."EL Volume Description" <> '' then
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

                            if (Perc <> 0) then
                                "Basis maintenance" := Perc * "Basis maintenance" / 100;





                            "Basis Resource Code" := Reso."No.";

                            if rec."Old Gauge" = true then begin
                                "Basis maintenance" := 0;
                                "Basis Resource Code" := '';
                            end;

                            if rec."Status MM" = rec."Status MM"::Terminated then begin
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

                //kraj
                Rec."Currency Code" := '';
                rec."War Resource Code" := '';

                WarDebt.Reset();
                WarDebt.SetFilter(Month, '%1', rec."Month Of GAS Calculation");
                WarDebt.SetFilter(Active, '%1', true);
                WarDebt.SetFilter("Customer Category", '%1', Rec."Category Customer");
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

                        if rec.SM3 < 0 then
                            rec.SM3 := 0;
                        if rec."Manualy War Value" = false then begin
                            if WarDebt.CBM <> 0 then
                                Rec."War Calculation" := Rec.SM3 * UnitP / WarDebt.CBM
                            else
                                Rec."War Calculation" := 0;
                        end;
                        rec."War Resource Code" := WarDebt.Resource;
                        Rec."Currency Code" := WarDebt."Currency Code";
                        if Rec."Currency Code" = '' then begin
                            Rec."War Calculation (LVT)" := Rec."War Calculation";
                        end
                        else begin
                            //naći currency

                            if rec."Manualy War Value" = false then begin
                                CER.Reset();
                                CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                                if (ch."Month Of GAS Calculation" = rec."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = rec."Year Of GAS Calculation") then
                                    CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To")
                                else
                                    CER.SetFilter("Starting Date", '<=%1', Rec."Reading Date To");
                                CER.SetCurrentKey("Starting Date");
                                CER.Ascending;
                                if CER.FindLast() then begin
                                    if rec.SM3 < 0 then
                                        rec.SM3 := 0;
                                    Rec."War Calculation (LVT)" := Rec.SM3 * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=');
                                    //((Rec.SM3 * UnitP / WarDebt.CBM) * CER."Relational Exch. Rate Amount");
                                    rec."War Resource Code" := WarDebt.Resource;
                                    //Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                end;
                            end;
                        end;



                    until WarDebt.Next() = 0;
                WarDebt.Reset();
                WarDebt.SetFilter(Month, '%1', Rec."Month Of GAS Calculation");
                WarDebt.SetFilter(Active, '%1', true);
                WarDebt.SetFilter("Customer Category", '%1', Rec."Category Customer");
                WarDebt.SetFilter(Totaling, '<>%1', '');
                if WarDebt.FindSet() then
                    repeat
                        CJL2.Reset();
                        // CJL2.SetFilter("Customer No.", '%1', CalcJ."Customer No.");
                        CJL2.SetFilter("Month Of GAS Calculation", WarDebt.Totaling);
                        //   CJL2.SetFilter(Code, '<>%1', rec.Code);
                        CJL2.SetFilter("Year Of GAS Calculation", '%1', Rec."Year Of GAS Calculation");
                        CJL2.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                        //     CJL2.SetFilter(Gauge, '%1', Rec.Gauge);
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
                        if rec.SM3 < 0 then
                            rec.SM3 := 0;
                        if CJL2.sm3 < 0 then
                            CJL2.sm3 := 0;

                        if rec."Manualy War Value" = false then begin

                            if WarDebt.CBM <> 0 then
                                Rec."War Calculation" := (CJL2.SM3) * UnitP / WarDebt.CBM
                            else
                                Rec."War Calculation" := 0;
                        end;
                        Rec."Currency Code" := WarDebt."Currency Code";
                        rec."War Resource Code" := WarDebt.Resource;
                        if Rec."Currency Code" = '' then begin
                            Rec."War Calculation (LVT)" := Rec."War Calculation";
                        end
                        else begin
                            //naći currency
                            if rec."Manualy War Value" = false then begin
                                CER.Reset();
                                CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                                //  CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");
                                if (ch."Month Of GAS Calculation" = rec."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = rec."Year Of GAS Calculation") then
                                    CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To")
                                else
                                    CER.SetFilter("Starting Date", '<=%1', Rec."Reading Date To");

                                CER.SetCurrentKey("Starting Date");
                                CER.Ascending;
                                if CER.FindLast() then begin
                                    if rec.SM3 < 0 then
                                        rec.SM3 := 0;

                                    if WarDebt.CBM <> 0 then
                                        rec."War Calculation (LVT)" :=
                                      //   ((Rec.SM3 * UnitP / WarDebt.CBM) * CER."Relational Exch. Rate Amount");
                                      (CJL2.SM3) * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=')
                                    else
                                        rec."War Calculation (LVT)" := 0;

                                    rec."War Resource Code" := WarDebt.Resource;
                                    //Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                end;

                            end;
                        end;
                    until WarDebt.Next() = 0;

                CustInternal.Reset();
                CustInternal.SetFilter("No.", '%1', rec."Customer No.");
                if CustInternal.FindFirst() then begin
                    if CustInternal."Internal Customer" = True then begin
                        rec."War Calculation" := 0;
                        rec."War Calculation (LVT)" := 0;
                        rec."War Resource Code" := '';
                    end;
                end;

                rec."Subsidies Amount" := 0;
                rec."Subsidies VAT Amount" := 0;
                rec."Subsidies VAT Amount" := 0;
                rec."Subsidies Total Amount" := 0;
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
                CustomerPrice.SetFilter("No.", '%1', rec."Customer No.");
                if CustomerPrice.FindFirst() then begin
                    if (CustomerPrice."Subsidies - has statement" = CustomerPrice."Subsidies - has statement"::Yes) and (CustomerPrice."Subsidies - YES/NO" = CustomerPrice."Subsidies - YES/NO"::Yes) and (Subs = true) then begin
                        Rec."Deminimis Act Date" := CalSetup."Deminimis Act Date";
                        Rec."Deminimis Act Name" := CalSetup."Deminimis Act Name";
                        Rec."Deminimis Act Number" := CalSetup."Deminimis Act Number";
                        Rec."Deminimis Legal act" := CalSetup."Deminimis Legal act";
                        Rec."Deminimis Purpose" := CalSetup."Deminimis Purpose";
                        Rec."Deminimis Remark" := CalSetup."Deminimis Remark";
                        Resource.Reset();
                        Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                        if Resource.FindFirst() then begin
                            VatPostingSetup.reset;
                            VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                            VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                            if VatPostingSetup.FindFirst() then begin
                                if rec.SM3 < 0 then
                                    rec.SM3 := 0;
                                rec."Subsidies Amount" := rec.SM3 * CalSetup.Subsidies;
                                rec."Subsidies VAT Amount" := 0;
                                rec."Subsidies VAT Amount" := "Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                rec."Subsidies Total Amount" := rec."Subsidies Amount" + rec."Subsidies VAT Amount";
                            end;
                        end;

                        rec.Subsidies := true;
                        if rec.SM3 < 0 then
                            rec.SM3 := 0;
                        rec."Subsidies Amount" := rec.SM3 * CalSetup.Subsidies;
                    end
                    else begin

                        Rec."Deminimis Act Date" := 0D;
                        rec."Subsidies Amount" := 0;
                        Rec."Deminimis Act Name" := '';
                        Rec."Deminimis Act Number" := '';
                        Rec."Deminimis Legal act" := '';
                        Rec."Deminimis Purpose" := '';
                        Rec."Deminimis Remark" := '';

                        rec."Subsidies VAT Amount" := 0;
                        rec."Subsidies Total Amount" := 0;
                        rec.Subsidies := false;


                    end;


                    if rec.Subsidies = true then begin

                        Resource.Reset();
                        Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                        if Resource.FindFirst() then begin
                            VatPostingSetup.reset;
                            VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                            VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                            if VatPostingSetup.FindFirst() then begin
                                rec."Subsidies VAT Amount" := "Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                rec."Subsidies Total Amount" := rec."Subsidies Amount" + rec."Subsidies VAT Amount";
                            end;
                        end;
                        if rec."Subsidies Amount" <> 0 then
                            //sad da izračun PDV
                            rec.Subsidies := true
                        else
                            rec.Subsidies := false;

                    end;
                end;
                //kraj
                if ("Category Customer" = "Category Customer"::"Small Economy") and ("Old Gauge" = false)
                and ("Filter by Old RMS" = false) then begin
                    "Reading Date From" := "Calculation Date From";
                    "Reading Date To" := "Calculation Date To";
                end;
                Rec.Modify(true);
                CurrentDateT := time;
                BrojMm += 1;
                Progress.UPDATE(1, ROUND(BrojMm));
                Progress.UPDATE(2, CurrentDateT);

            //ovdje dodati i za ratni dug

            until rec.Next() = 0;
    end;


            }
            action("Calculation V2")
            {

                Caption = 'Calculation V2';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        ExR: Report "Calculation GAS";
    begin

        Report.run(Report::"Calculation GAS", true, false, rec);
    end;

            }

            /* action("Calculate War amount")
             {
                 Caption = 'Calculate War amount';
                 Image = Process;
                 Promoted = true;
                 PromotedCategory = Report;
                 PromotedIsBig = true;
                 trigger OnAction()
                 var
                     myInt: Integer;
                     WarDebt: Record "War Debt Setup";
                     CalcJ: Record "Calculation Journal Line";
                     CER: Record "Currency Exchange Rate";
                     CJL2: Record "Calculation Journal Line";
                 begin
                     if Rec.FindSet() then
                         repeat
                             WarDebt.Reset();
                             WarDebt.SetFilter(Month, '%1', rec."Month Of GAS Calculation");
                             WarDebt.SetFilter(Active, '%1', true);
                             WarDebt.SetFilter("Customer Category", '%1', Rec."Category Customer");
                             WarDebt.SetFilter(Totaling, '%1', '');

                             if WarDebt.FindSet() then
                                 repeat
                                     if WarDebt.CBM <> 0 then
                                         Rec."War Calculation" := Round(Rec.SM3 * WarDebt.Amount / WarDebt.CBM, 0.01, '=')
                                     else
                                         Rec."War Calculation" := 0;
                                     Rec."Currency Code" := WarDebt."Currency Code";
                                     if Rec."Currency Code" = '' then begin
                                         Rec."War Calculation (LVT)" := Rec."War Calculation";
                                         Rec.Modify(true);
                                     end
                                     else begin
                                         //naći currency
                                         CER.Reset();
                                         CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                                         CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");
                                         CER.SetCurrentKey("Starting Date");
                                         CER.Ascending;
                                         if CER.FindLast() then begin
                                             Rec."War Calculation (LVT)" := Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                             Rec.Modify(true);
                                         end;

                                     end;

                                 until WarDebt.Next() = 0;
                             //za ove koji nemaju svaki mjesec

                             WarDebt.SetFilter(Month, '%1', Rec."Month Of GAS Calculation");
                             WarDebt.SetFilter(Active, '%1', true);
                             WarDebt.SetFilter("Customer Category", '%1', Rec."Category Customer");
                             WarDebt.SetFilter(Totaling, '<>%1', '');
                             if WarDebt.FindSet() then
                                 repeat
                                     CJL2.Reset();
                                     // CJL2.SetFilter("Customer No.", '%1', CalcJ."Customer No.");
                                     CJL2.SetFilter("Month Of GAS Calculation", WarDebt.Totaling);
                                     CJL2.SetFilter("Year Of GAS Calculation", '%1', Rec."Year Of GAS Calculation");
                                     CJL2.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                                     CJL2.SetFilter(Gauge, '%1', Rec.Gauge);
                                     if CJL2.FindFirst() then
                                         CJL2.CalcSums(CJL2.SM3);
                                     //ukupna količina

                                     if WarDebt.CBM <> 0 then
                                         Rec."War Calculation" := Round(CJL2.SM3 * WarDebt.Amount / WarDebt.CBM, 0.01, '=')
                                     else
                                         Rec."War Calculation" := 0;
                                     Rec."Currency Code" := WarDebt."Currency Code";
                                     if Rec."Currency Code" = '' then begin
                                         Rec."War Calculation (LVT)" := Rec."War Calculation";
                                         Rec.Modify(true);
                                     end
                                     else begin
                                         //naći currency
                                         CER.Reset();
                                         CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                                         CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");
                                         CER.SetCurrentKey("Starting Date");
                                         CER.Ascending;
                                         if CER.FindLast() then begin
                                             rec."War Calculation (LVT)" := Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                             Rec.Modify(true);
                                         end;

                                     end;
                                 until WarDebt.Next() = 0;

                         until Rec.Next() = 0;

                 end;

             }*/
            action("Unobvious Calculation")
            {

                Caption = 'Unobvious Calculation';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var

        DateR: Record Date;
        StartD: Date;
        DateF: Text;
        in_: Integer;
        LastD: Date;
        AbdF: Codeunit "Absence Fill";
        CJL2: Record "Calculation Journal Line";
        BrojIn: Integer;
        BrojDana: Integer;
        DanUOcitanju: Integer;
        MjeseciProcenat: Decimal;
        CalcS: Record "Calculation Setup";
        TrenutniP: Decimal;
        UProc: Decimal;
        CJLNew: Record "Calculation Journal Line";
        CurrB: Record customer;
        BalanceStart: Decimal;
        PrepaymentStart: Decimal;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        RezDecimal: Decimal;
        OldValue: Decimal;
        CalcMjesec: Decimal;
        A: Decimal;
        B: Decimal;
        C: Decimal;
        CalcSetup: Record "Calculation Setup";
        RP: Record "Resource Price";
        WarDebt: Record "War Debt Setup";
        CalcJ: Record "Calculation Journal Line";
        CER: Record "Currency Exchange Rate";

        Journal: Record "Calculation Journal Line";
        VPS: record "VAT Posting Setup";
        SP: Record "Sales Price";
        Resource: Record "Resource";
        CalSetup: Record "Calculation Setup";
        CU: Record customer;
        UnitP: Decimal;
        CustomerPrice: Record Customer;
        Subs: Boolean;
        VatPostingSetup: Record "VAT Posting Setup";
        DecimalV: Decimal;
        Reso: Record Resource;
        DecimalV2: text[250];
        DecimalV2E: Decimal;
        ch: Record "Calcuation Header";
        StartDaT: Time;
        CurrentDateT: Time;
        Progress: Dialog;
        BrojMm: Integer;
        TypeD: Record "Types Of Diseases";
        CJL2N: Record "Calculation Journal Line";
        NewSum: Decimal;
        AutoInR: Record "Calculation Journal Line";
        NewAutoin: Integer;
        Percc: Decimal;
        CustP: Record Customer;
        CJLTemp: Record "Calculation Journal Line" temporary;
        OldG: Boolean;
        BrojDanaPrevious: Integer;
        BrojDanaCorrect: Integer;
        FirstMonth: Date;
        LastMonth: Date;
        AbsFill: Codeunit "Absence Fill";
        CorrValue: Decimal;
        UpdateV: Decimal;
        PercMM: Decimal;
        CHWin: Record "Calcuation Header";
        MMPerc: Record "Service Item";
        MMF: Record "Service Item";
        CUstInternal: Record Customer;


    begin

        AutoInR.Reset();
        AutoInR.SetFilter(Code, '%1', rec.Code);
        AutoInR.SetCurrentKey(Autoint);
        OldG := false;
        AutoInR.Ascending;
        if AutoInR.FindLast() then
            NewAutoin := AutoInR.Autoint + 1
        else
            NewAutoin := 1;

        CalcS.get;
        if rec.FindSet() then
            repeat
                if rec."Previous Unobvious Month" > 11 then
                    rec."Previous Unobvious Month" := 11;
                if (rec."Previous Unobvious Month" <> 0) and (Unobvious = false) then begin
                    StartD := CalcDate(DateF, "Reading Date From");
                    BrojIn := 0;
                    BrojDanaPrevious := 0;
                    BrojDana := 0;
                    BrojDanaCorrect := 0;
                    BrojMm := 0;
                    PercMM := 0;
                    Percc := 0;
                    UpdateV := 1;
                    MjeseciProcenat := 0;
                    TrenutniP := 0;
                    UProc := 0;
                    NewSum := 0;
                    BalanceStart := 0;
                    PrepaymentStart := 0;
                    RezDecimal := 0;

                    CustP.Reset();
                    CustP.SetFilter("No.", '%1', rec."Customer No.");
                    if CustP.FindFirst() then begin
                        Percc := CustP."Bill distribution percentage";
                    end;
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

                    DateR.Reset();
                    DateR.SetFilter("Period Type", '%1', DateR."Period Type"::Date);
                    DateR.SetFilter("Period Start", '%1..%2', Rec."Reading Date From", Rec."Reading Date To");
                    if dateR.FindFirst() then
                        BrojDana := dateR.Count
                    else
                        BrojDana := 0;


                    DanUOcitanju := Date2DMY("Calculation Date To", 1);

                    if Date2DMY(Rec."Calculation Date To", 2) = 1 then
                        TrenutniP := CalcS."Distribution 1";

                    if Date2DMY(Rec."Calculation Date To", 2) = 2 then
                        TrenutniP := CalcS."Distribution 2";

                    if Date2DMY(Rec."Calculation Date To", 2) = 3 then
                        TrenutniP := CalcS."Distribution 3";

                    if Date2DMY(Rec."Calculation Date To", 2) = 4 then
                        TrenutniP := CalcS."Distribution 4";

                    if Date2DMY(Rec."Calculation Date To", 2) = 5 then
                        TrenutniP := CalcS."Distribution 5";

                    if Date2DMY(Rec."Calculation Date To", 2) = 6 then
                        TrenutniP := CalcS."Distribution 6";

                    if Date2DMY(Rec."Calculation Date To", 2) = 7 then
                        TrenutniP := CalcS."Distribution 7";

                    if Date2DMY(Rec."Calculation Date To", 2) = 8 then
                        TrenutniP := CalcS."Distribution 8";

                    if Date2DMY(Rec."Calculation Date To", 2) = 9 then
                        TrenutniP := CalcS."Distribution 9";

                    if Date2DMY(Rec."Calculation Date To", 2) = 10 then
                        TrenutniP := CalcS."Distribution 10";

                    if Date2DMY(Rec."Calculation Date To", 2) = 11 then
                        TrenutniP := CalcS."Distribution 11";

                    if Date2DMY(Rec."Calculation Date To", 2) = 12 then
                        TrenutniP := CalcS."Distribution 12";

                    CJLTemp.DeleteAll();
                    CJL2.Reset();
                    CJL2.SetFilter(Code, '<>%1', Rec.Code);
                    CJL2.SetFilter("Customer No.", '%1', rec."Customer No.");
                    CJL2.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                    CJL2.SetFilter(Locked, '%1', true);
                    //  CJL2.SetFilter(Gauge, '%1', rec.Gauge);
                    cjl2.SetCurrentKey("Calculation Date To");
                    cjl2.Ascending(false);
                    if cjl2.FindSet() then
                        repeat
                            OldG := cjl2."Old Gauge";
                            BrojIn += 1;
                            CJLTemp.Init();
                            CJLTemp.TransferFields(CJL2);
                            CJLTemp.Insert();

                            DateR.Reset();
                            DateR.SetFilter("Period Type", '%1', DateR."Period Type"::Date);
                            DateR.SetFilter("Period Start", '%1..%2', cjl2."Reading Date From", cjl2."Reading Date To");

                            if dateR.FindFirst() then
                                BrojDanaPrevious := dateR.Count - 1
                            else
                                BrojDanaPrevious := 0;


                            FirstMonth := AbsFill.GetMonthRange(CJL2."Month Of GAS Calculation", CJL2."Year Of GAS Calculation", true);
                            LastMonth := AbsFill.GetMonthRange(CJL2."Month Of GAS Calculation", CJL2."Year Of GAS Calculation", false);


                            DateR.Reset();
                            DateR.SetFilter("Period Type", '%1', DateR."Period Type"::Date);
                            DateR.SetFilter("Period Start", '%1..%2', FirstMonth, LastMonth);

                            if dateR.FindFirst() then
                                BrojDanaCorrect := dateR.Count
                            else
                                BrojDanaCorrect := 0;

                            if cjl2."Month Of GAS Calculation" = 2 then
                                BrojDanaCorrect := 28;


                            if BrojDanaPrevious <> 0 then
                                UpdateV := round(BrojDanaPrevious / BrojDanaCorrect, 0.0001, '=')
                            else
                                UpdateV := 1;


                            if Date2DMY(CJL2."Calculation Date To", 2) = 1 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 1", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 2 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 2", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 3 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 3", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 4 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 4", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 5 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 5", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 6 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 6", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 7 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 7", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 8 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 8", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 9 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 9", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 10 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 10", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 11 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 11", 0.01, '=');

                            if Date2DMY(CJL2."Calculation Date To", 2) = 12 then
                                MjeseciProcenat += round(UpdateV * CalcS."Distribution 12", 0.01, '=');





                        until (cjl2.Next() = 0) or (BrojIn = rec."Previous Unobvious Month")
                        or (OldG = true);

                    UProc := TrenutniP + MjeseciProcenat;

                    //

                    //kreiraj liniju u cjl.
                    BrojIn := 0;


                    CustomerLedgerEntry.Reset();
                    CustomerLedgerEntry.SetFilter("Customer No.", '%1', rec."Customer No.");
                    CustomerLedgerEntry.SetFilter("Bill Type", '%1|%2|%3', '01', '02', '03');
                    CustomerLedgerEntry.SetFilter(Prepayment, '%1', false);

                    if CustomerLedgerEntry.FindSet() then
                        repeat
                            CustomerLedgerEntry.calcfields("Amount (LCY)");

                            RezDecimal += CustomerLedgerEntry."Amount (LCY)";


                        until CustomerLedgerEntry.Next() = 0;

                    if RezDecimal > 0 then
                        BalanceStart := RezDecimal
                    else
                        PrepaymentStart := abs(RezDecimal);

                    //počela sam sa nekim saldom i sada izdajem račune
                    OldValue := rec."Old Value";
                    NewSum := 0;

                    CJLTemp.Reset();
                    CJLTemp.SetFilter(Code, '<>%1', Rec.Code);
                    CJLTemp.SetFilter("Customer No.", '%1', rec."Customer No.");
                    CJLTemp.SetFilter("Measuring Point Code", '%1', "Measuring Point Code");
                    CJLTemp.SetFilter(Locked, '%1', true);
                    //  CJLTemp.SetFilter(Gauge, '%1', rec.Gauge);
                    CJLTemp.SetCurrentKey("Calculation Date To");
                    CJLTemp.Ascending(true);
                    if CJLTemp.FindSet() then
                        repeat
                            BrojIn += 1;

                            CJLNew.Init();
                            CJLNew.TransferFields(rec);
                            CJLNew.Autoint := NewAutoin;
                            NewAutoin += 1;
                            CJLNew."Previous Unobvious Month" := 0;
                            CJLNew."Old Gauge" := false;
                            CJLNew."New Gauge" := false;
                            CJLNew."Proceedings No." := '';
                            CJLNew."Calculation Date From" := CJLTemp."Calculation Date From";
                            CJLNew."Calculation Date To" := CJLTemp."Calculation Date To";
                            CJLNew."Reading Date From" := CJLTemp."Reading Date From";
                            CJLNew."Reading Date To" := CJLTemp."Reading Date To";
                            //    CJLNew."Calculation Date To" := CJLTemp."Calculation Date To";
                            CJLNew."Year Of GAS Calculation" := CJLTemp."Year Of GAS Calculation";
                            CJLNew."Year of Calculation" := CJLTemp."Year of Calculation";
                            CJLNew."Month of Calculation" := CJLTemp."Month of Calculation";
                            CJLNew."Month Of GAS Calculation" := CJLTemp."Month Of GAS Calculation";

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 1 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 1", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 2 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 2", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 3 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 3", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 4 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 4", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 5 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 5", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 6 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 6", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 7 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 7", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 8 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 8", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 9 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 9", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 10 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 10", 0.01, '=');

                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 11 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 11", 0.01, '=');
                            if Date2DMY(CJLTemp."Calculation Date To", 2) = 12 then
                                CalcMjesec := round(UpdateV * CalcS."Distribution 12", 0.01, '=');


                            CJLNew.Validate("Old Value", OldValue);
                            CJLNew."Calorific power coefficient" := CJLTemp."Calorific power coefficient";
                            if UProc <> 0 then
                                CJLNew.Validate("New Value", OldValue + round((rec.Difference * CalcMjesec / UProc), 1, '='))
                            else
                                CJLNew.Validate("New Value", OldValue + 0);

                            CJLNew."Customer Balance" := BalanceStart;
                            CJLNew."Customer Prepayment" := PrepaymentStart;

                            NewSum += CJLNew.Difference;
                            //obračunaj gas
                            if CJLNew."Method of calculation" = CJLNew."Method of calculation"::"3" then begin
                                CJLNew.validate(SM3, round(((CJLNew."Correction new- gauge" - CJLNew."Correction previous - gauge") * CJLNew."Calorific power coefficient"), 0.01, '='));
                            end;


                            if CJLNew."Method of calculation" = CJLNew."Method of calculation"::"2" then begin
                                A := CJLNew."New Value" - CJLNew."Old Value";

                                //dodala

                                if PercMM <> 0 then begin

                                    DecimalV := (PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value");
                                    DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                    if Evaluate(DecimalV2E, DecimalV2) then begin
                                        if DecimalV2E > 50 then
                                            A := Round((PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value"), 1, '>')
                                        else
                                            A := Round((PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value"), 1, '<')

                                    end;


                                end;

                                //kraj



                                if CalcSetup."PS Constant" <> 0 then
                                    B := round(round((CJLNew."Pressure result- gauge" + CJLNew."Atmospheric pressure"), 0.0001, '=') / CalcSetup."PS Constant", 0.0001, '=')
                                else
                                    B := (round((CJLNew."Pressure result- gauge" + CJLNew."Atmospheric pressure"), 0.0001, '='));
                                c := round(CalcSetup."TS Constant" / (CalcSetup."Absolute zero" + (CJLNew."Temperature new- gauge" + CJLNew."Temperature previous - gauge") / 2) * CalcSetup.JEDKS, 0.0001, '=');

                                CJLNew.validate(SM3, round((A * B * C) * CJLNew."Calorific power coefficient", 0.01, '='));
                            end;
                            if CJLNew."Method of calculation" = CJLNew."Method of calculation"::"1" then begin

                                if CJLNew."Category MM" = CJLNew."Category MM"::"Large Economy" then begin

                                    if PercMM <> 0 then begin

                                        A := (PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value");


                                        DecimalV := (PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value");
                                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                        if Evaluate(DecimalV2E, DecimalV2) then begin
                                            if DecimalV2E > 50 then
                                                A := Round((PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value"), 1, '>')
                                            else
                                                A := Round((PercMM / 100) * (CJLNew."New Value" - CJLNew."Old Value"), 1, '<')



                                        end;

                                        validate(SM3, Round(A * "Calorific power coefficient", 0.01, '='));

                                    end
                                    else begin
                                        CJLNew.validate(SM3, Round((CJLNew."New Value" - CJLNew."Old Value") * CJLNew."Calorific power coefficient", 0.01, '='))
                                    end;
                                end
                                else begin

                                    DecimalV := (CJLNew."New Value" - CJLNew."Old Value") * CJLNew."Calorific power coefficient";
                                    DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                                    if Evaluate(DecimalV2E, DecimalV2) then begin
                                        if DecimalV2E > 50 then
                                            CJLNew.validate(SM3, Round((CJLNew."New Value" - CJLNew."Old Value") * CJLNew."Calorific power coefficient", 1, '>'))
                                        else
                                            validate(SM3, Round((CJLNew."New Value" - CJLNew."Old Value") * CJLNew."Calorific power coefficient", 1, '<'));

                                    end;
                                end;
                            end;
                            //zaokruživanje kada množim ovdje na 2 decimale

                            if Percc <> 0
                            then
                                SM3 := round((SM3 * (Percc / 100)), 0.01, '=');

                            //održavanje
                            ch.get(Code);

                            CustomerPrice.Reset;
                            CustomerPrice.SetFilter("No.", '%1', CJLNew."Customer No.");
                            if CustomerPrice.FindFirst() then begin
                                SP.Reset();
                                sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                                sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                                sp.SetFilter("Starting Date", '<=%1', CJlNew."Reading Date To");
                                sp.SetCurrentKey("Starting Date");
                                sp.Ascending;
                                if sp.FindLast() then begin
                                    CJLNew."Unit Price" := SP."Unit Price";

                                    if (CJLNew."Category MM" = CJLNew."Category MM"::"Large Economy")
                                    or (CJLNew."Category MM" = CJLNew."Category MM"::"KJKP Heating plant") then begin
                                        ///ĐEMINA

                                        if sp."Price not by Gauge" = true then begin
                                        end
                                        else begin
                                            TypeD.Reset();
                                            TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                                            TypeD.SetFilter("Description", '%1', CJLNew."Gauge Size");
                                            if TypeD.FindFirst() then begin
                                                if CJLNew."EL Volume Description" <> '' then
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
                                            CJLNew."Basis maintenance" := Reso."Unit Price"
                                        else
                                            CJLNew."Basis maintenance" := 0;



                                        CJLNew."Basis Resource Code" := Reso."No.";

                                        if CJLNew."Old Gauge" = true then begin
                                            CJLNew."Basis maintenance" := 0;
                                            CJLNew."Basis Resource Code" := '';
                                        end;

                                        if CJLNew."Status MM" = CJLNew."Status MM"::Terminated then begin
                                            CJLNew."Basis maintenance" := 0;
                                            CJLNew."Basis Resource Code" := '';
                                        end;


                                        CJLNew.Unobvious := true;

                                        if (CJLNew.Unobvious = true) and (CJLNew."Previous Unobvious Month" = 0) then begin
                                            if CJLNew."Bill distribution percentage" = 0 then begin

                                                CJLNew."Basis maintenance" := 0;
                                                CJLNew."Basis Resource Code" := ''
                                            end;
                                        end;

                                        if (CJLNew."Customer No.") = '200359' then begin
                                            CJLNew."Basis maintenance" := 0;
                                            CJLNew."Basis Resource Code" := '';
                                        end;



                                        VPS.Reset();
                                        vps.SetFilter("VAT Prod. Posting Group", '%1', Reso."VAT Prod. Posting Group");
                                        if CU.get(CJLNew."Customer No.") then
                                            VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
                                        if (VPS.FindFirst()) and (CH."Sales Invoice without VAT" = false) then begin
                                            CJLNew."Maintenance VAT" := round((CJLNew."Basis maintenance" * VPS."VAT %") / 100, 0.01, '=');
                                            CJLNew."Main. VAT Percentage" := VPS."VAT %";
                                        end

                                        else begin
                                            CJLNew."Maintenance VAT" := 0;
                                            CJLNew."Main. VAT Percentage" := 0;
                                        end;
                                        if ch."Sales invoice Without M" = true then begin
                                            CJLNew."Maintenance VAT" := 0;
                                            CJLNew."Main. VAT Percentage" := 0;
                                        end;

                                        MMF.Reset();
                                        MMF.SetFilter("No.", '%1', CJLnew."Measuring Point Code");
                                        if mmf.FindFirst() then begin
                                            if MMF."MM VAT Excluded" = true then
                                                CJLNew."Maintenance VAT" := 0;
                                        end;

                                        if cu."Cust VAT Excluded" = true then
                                            CJLNew."Maintenance VAT" := 0;

                                    end
                                    else begin
                                        CJLNew."Basis maintenance" := 0;
                                        CJLNew."Maintenance VAT" := 0;
                                    end;


                                end;
                            end;

                            //kraj
                            CJLNew."Currency Code" := '';
                            CJLNew."War Resource Code" := '';

                            WarDebt.Reset();
                            WarDebt.SetFilter(Month, '%1', CJLNew."Month Of GAS Calculation");
                            WarDebt.SetFilter(Active, '%1', true);
                            WarDebt.SetFilter("Customer Category", '%1', CJLNew."Category Customer");
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

                                    if CJLNew.SM3 < 0 then
                                        CJLNew.SM3 := 0;

                                    if CJLNew."Manualy War Value" = false then begin
                                        if WarDebt.CBM <> 0 then
                                            CJLNew."War Calculation" := CJLNew.SM3 * UnitP / WarDebt.CBM
                                        else
                                            CJLNew."War Calculation" := 0;
                                    end;
                                    CJLNew."War Resource Code" := WarDebt.Resource;
                                    CJLNew."Currency Code" := WarDebt."Currency Code";
                                    if CJLNew."Currency Code" = '' then begin
                                        CJLNew."War Calculation (LVT)" := CJLNew."War Calculation";
                                    end
                                    else begin
                                        //naći currency

                                        if CJLNew."Manualy War Value" = false then begin
                                            CER.Reset();
                                            CER.SetFilter("Currency Code", '%1', CJLNew."Currency Code");
                                            //  CER.SetFilter("Starting Date", '<=%1', CJLNew."Calculation Date To");

                                            if (ch."Month Of GAS Calculation" = CJLNew."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = CJLNew."Year Of GAS Calculation") then
                                                CER.SetFilter("Starting Date", '<=%1', CJLNew."Calculation Date To")
                                            else
                                                CER.SetFilter("Starting Date", '<=%1', CJLNew."Reading Date To");


                                            CER.SetCurrentKey("Starting Date");
                                            CER.Ascending;
                                            if CER.FindLast() then begin
                                                if CJLNew.SM3 < 0 then
                                                    CJLNew.SM3 := 0;
                                                //   CJLNew."War Calculation (LVT)" := ((CJLNew.SM3 * UnitP / WarDebt.CBM) * CER."Relational Exch. Rate Amount");
                                                CJLNew."War Calculation (LVT)" := CJLNew.SM3 * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=');

                                                CJLNew."War Resource Code" := WarDebt.Resource;
                                                //Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                            end;
                                        end;
                                    end;



                                until WarDebt.Next() = 0;
                            WarDebt.Reset();
                            WarDebt.SetFilter(Month, '%1', CJLNew."Month Of GAS Calculation");
                            WarDebt.SetFilter(Active, '%1', true);
                            WarDebt.SetFilter("Customer Category", '%1', CJLNew."Category Customer");
                            WarDebt.SetFilter(Totaling, '<>%1', '');
                            if WarDebt.FindSet() then
                                repeat
                                    CJL2N.Reset();
                                    // CJL2.SetFilter("Customer No.", '%1', CalcJ."Customer No.");
                                    CJL2N.SetFilter("Month Of GAS Calculation", WarDebt.Totaling);
                                    //    CJL2N.SetFilter(Code, '<>%1', CJLNew.Code);
                                    CJL2N.SetFilter("Year Of GAS Calculation", '%1', CJLNew."Year Of GAS Calculation");
                                    CJL2N.SetFilter("Measuring Point Code", '%1', CJLNew."Measuring Point Code");
                                    //   CJL2N.SetFilter(Gauge, '%1', CJLNew.Gauge);
                                    if CJL2N.FindFirst() then
                                        CJL2N.CalcSums(CJL2N.SM3);

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
                                    if CJLNew.SM3 < 0 then
                                        CJLNew.SM3 := 0;
                                    if CJL2N.sm3 < 0 then
                                        CJL2N.sm3 := 0;
                                    if CJLNew."Manualy War Value" = false then begin
                                        if WarDebt.CBM <> 0 then
                                            CJLNew."War Calculation" := (CJL2N.SM3) * UnitP / WarDebt.CBM
                                        else
                                            CJLNew."War Calculation" := 0;
                                    end;
                                    CJLNew."Currency Code" := WarDebt."Currency Code";
                                    CJLNew."War Resource Code" := WarDebt.Resource;
                                    if CJLNew."Currency Code" = '' then begin
                                        CJLNew."War Calculation (LVT)" := CJLNew."War Calculation";
                                    end
                                    else begin
                                        //naći currency

                                        if CJLNew."Manualy War Value" = false then begin
                                            CER.Reset();
                                            CER.SetFilter("Currency Code", '%1', CJLNew."Currency Code");
                                            //  CER.SetFilter("Starting Date", '<=%1', CJLNew."Calculation Date To");
                                            if (ch."Month Of GAS Calculation" = CJLNew."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = CJLNew."Year Of GAS Calculation") then
                                                CER.SetFilter("Starting Date", '<=%1', CJLNew."Calculation Date To")
                                            else
                                                CER.SetFilter("Starting Date", '<=%1', CJLNew."Reading Date To");

                                            CER.SetCurrentKey("Starting Date");
                                            CER.Ascending;
                                            if CER.FindLast() then begin
                                                if CJLNew.SM3 < 0 then
                                                    CJLNew.SM3 := 0;

                                                if WarDebt.CBM <> 0 then
                                                    CJLNew."War Calculation (LVT)" := (CJL2N.SM3) * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=')
                                                else
                                                    CJLNew."War Calculation (LVT)" := 0;
                                                CJLNew."War Resource Code" := WarDebt.Resource;
                                                //Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                            end;
                                        end;

                                    end;
                                until WarDebt.Next() = 0;

                            CustInternal.Reset();
                            CustInternal.SetFilter("No.", '%1', CJLNew."Customer No.");
                            if CustInternal.FindFirst() then begin
                                if CustInternal."Internal Customer" = True then begin
                                    CJLNew."War Calculation" := 0;
                                    CJLNew."War Calculation (LVT)" := 0;
                                    CJLNew."War Resource Code" := '';
                                end;
                            end;


                            CJLNew."Subsidies Amount" := 0;
                            CJLNew."Subsidies VAT Amount" := 0;
                            CJLNew."Subsidies VAT Amount" := 0;
                            CJLNew."Subsidies Total Amount" := 0;
                            //subvencija
                            CalSetup.get;
                            if (CalSetup."Subsidies Date from" <> 0D) and (CalSetup."Subsidies Date to" = 0D)
              and (CJLNew."Reading Date From" >= CalSetup."Subsidies Date from") then
                                Subs := true;

                            if (CalSetup."Subsidies Date from" <> 0D) and (CalSetup."Subsidies Date to" <> 0D)
                           and (CJLNew."Reading Date To" <= CalSetup."Subsidies Date to")
                           and (CJLNew."Reading Date From" >= CalSetup."Subsidies Date From") then
                                Subs := true;

                            CustomerPrice.Reset();
                            CustomerPrice.SetFilter("No.", '%1', CJLNew."Customer No.");
                            if CustomerPrice.FindFirst() then begin
                                if (CustomerPrice."Subsidies - has statement" = CustomerPrice."Subsidies - has statement"::Yes) and (CustomerPrice."Subsidies - YES/NO" = CustomerPrice."Subsidies - YES/NO"::Yes) and (Subs = true) then begin
                                    CJLNew."Deminimis Act Date" := CalSetup."Deminimis Act Date";
                                    CJLNew."Deminimis Act Name" := CalSetup."Deminimis Act Name";
                                    CJLNew."Deminimis Act Number" := CalSetup."Deminimis Act Number";
                                    CJLNew."Deminimis Legal act" := CalSetup."Deminimis Legal act";
                                    CJLNew."Deminimis Purpose" := CalSetup."Deminimis Purpose";
                                    CJLNew."Deminimis Remark" := CalSetup."Deminimis Remark";
                                    Resource.Reset();
                                    Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                                    if Resource.FindFirst() then begin
                                        VatPostingSetup.reset;
                                        VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                                        VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                                        if VatPostingSetup.FindFirst() then begin
                                            if CJLNew.SM3 < 0 then
                                                CJLNew.SM3 := 0;
                                            CJLNew."Subsidies Amount" := CJLNew.SM3 * CalSetup.Subsidies;
                                            CJLNew."Subsidies VAT Amount" := 0;
                                            CJLNew."Subsidies VAT Amount" := CJLNew."Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                            CJLNew."Subsidies Total Amount" := CJLNew."Subsidies Amount" + CJLNew."Subsidies VAT Amount";
                                        end;
                                    end;

                                    CJLNew.Subsidies := true;
                                    if CJLNew.SM3 < 0 then
                                        CJLNew.SM3 := 0;
                                    CJLNew."Subsidies Amount" := CJLNew.SM3 * CalSetup.Subsidies;
                                end
                                else begin

                                    CJLNew."Deminimis Act Date" := 0D;
                                    CJLNew."Subsidies Amount" := 0;
                                    CJLNew."Deminimis Act Name" := '';
                                    CJLNew."Deminimis Act Number" := '';
                                    CJLNew."Deminimis Legal act" := '';
                                    CJLNew."Deminimis Purpose" := '';
                                    CJLNew."Deminimis Remark" := '';

                                    CJLNew."Subsidies VAT Amount" := 0;
                                    CJLNew."Subsidies Total Amount" := 0;
                                    CJLNew.Subsidies := false;


                                end;


                                if CJLNew.Subsidies = true then begin

                                    Resource.Reset();
                                    Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                                    if Resource.FindFirst() then begin
                                        VatPostingSetup.reset;
                                        VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                                        VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                                        if VatPostingSetup.FindFirst() then begin
                                            CJLNew."Subsidies VAT Amount" := CJLNew."Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                            CJLNew."Subsidies Total Amount" := CJLNew."Subsidies Amount" + CJLNew."Subsidies VAT Amount";
                                        end;
                                    end;
                                    if CJLNew."Subsidies Amount" <> 0 then
                                        //sad da izračun PDV
                                        CJLNew.Subsidies := true
                                    else
                                        CJLNew.Subsidies := false;

                                end;
                            end;
                            //kraj gas


                            CJLNew.Unobvious := true;
                            CJLNew."Calculation Date To" := rec."Calculation Date To";
                            CJLNew.Insert();

                            OldValue := CJLNew."New Value";
                            if PrepaymentStart <> 0 then begin

                                if PrepaymentStart - CJLNew.Total > 0 then begin
                                    PrepaymentStart := PrepaymentStart - CJLNew.Total;




                                end
                                else begin

                                    PrepaymentStart := 0;
                                    BalanceStart := CJLNew.Total - PrepaymentStart;

                                end;


                            end
                            else begin
                                BalanceStart := BalanceStart + Total;

                            end;

                        until (CJLTemp.Next() = 0) or (BrojIn = rec."Previous Unobvious Month");

                    //da računam koliko bi trebalo u kojem mjesecu


                    if rec.Difference - NewSum <> 0 then begin
                        rec.validate("Old Value", "New Value" - (Difference - NewSum));

                        //obračun gas ponovo ovdjee
                        CalcSetup.get;
                        CH.Reset();
                        CH.SetFilter(Code, '%1', rec.Code);
                        if ch.FindSet() then begin
                            if Rec."Calculation Date From" = 0D then
                                rec."Calculation Date From" := ch."Calculation Date From";
                            if Rec."Calculation Date To" = 0D then
                                rec."Calculation Date To" := ch."Calculation Date To";
                        end;


                        if "Method of calculation" = "Method of calculation"::"3" then begin
                            validate(SM3, round((("Correction new- gauge" - "Correction previous - gauge") * "Calorific power coefficient"), 0.01, '='));
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

                            if (rec."Category MM" = rec."Category MM"::"Large Economy") or (rec."Category MM" = rec."Category MM"::"KJKP Heating plant") then begin


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

                        if Percc <> 0
                        then
                            SM3 := round((SM3 * (Percc / 100)), 0.01, '=');




                        //održavanje
                        ch.get(Code);

                        CustomerPrice.Reset;
                        CustomerPrice.SetFilter("No.", '%1', "Customer No.");
                        if CustomerPrice.FindFirst() then begin
                            SP.Reset();
                            sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                            sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                            sp.SetFilter("Starting Date", '<=%1', "Reading Date To");
                            sp.SetCurrentKey("Starting Date");
                            sp.Ascending;
                            if sp.FindLast() then begin
                                "Unit Price" := SP."Unit Price";

                                if (rec."Category MM" = rec."Category MM"::"Large Economy")
                                or (Rec."Category MM" = Rec."Category MM"::"KJKP Heating plant") then begin

                                    if sp."Price not by Gauge" = true then begin

                                    end
                                    else begin
                                        ///ĐEMINA
                                        TypeD.Reset();
                                        TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                                        TypeD.SetFilter("Description", '%1', rec."Gauge Size");
                                        if TypeD.FindFirst() then begin
                                            if rec."EL Volume Description" <> '' then
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

                                    if rec."Old Gauge" = true then begin
                                        "Basis maintenance" := 0;
                                        "Basis Resource Code" := '';
                                    end;
                                    if Rec."Status MM" = Rec."Status MM"::Terminated then begin
                                        Rec."Basis maintenance" := 0;
                                        Rec."Basis Resource Code" := '';
                                    end;

                                    if (Unobvious = true) and ("Previous Unobvious Month" = 0) then begin
                                        if "Bill distribution percentage" = 0 then begin
                                            "Basis maintenance" := 0;
                                            "Basis Resource Code" := '';
                                        end;
                                    end;
                                    if (Rec."Customer No.") = '200359' then begin
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

                        //kraj
                        Rec."Currency Code" := '';
                        rec."War Resource Code" := '';

                        WarDebt.Reset();
                        WarDebt.SetFilter(Month, '%1', rec."Month Of GAS Calculation");
                        WarDebt.SetFilter(Active, '%1', true);
                        WarDebt.SetFilter("Customer Category", '%1', Rec."Category Customer");
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

                                if rec.SM3 < 0 then
                                    rec.SM3 := 0;

                                if Rec."Manualy War Value" = false then begin
                                    if WarDebt.CBM <> 0 then
                                        Rec."War Calculation" := Rec.SM3 * UnitP / WarDebt.CBM
                                    else
                                        Rec."War Calculation" := 0;
                                end;
                                rec."War Resource Code" := WarDebt.Resource;
                                Rec."Currency Code" := WarDebt."Currency Code";
                                if Rec."Currency Code" = '' then begin
                                    Rec."War Calculation (LVT)" := Rec."War Calculation";
                                end
                                else begin
                                    //naći currency
                                    if Rec."Manualy War Value" = false then begin
                                        CER.Reset();
                                        CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                                        //  CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");

                                        if (ch."Month Of GAS Calculation" = Rec."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = Rec."Year Of GAS Calculation") then
                                            CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To")
                                        else
                                            CER.SetFilter("Starting Date", '<=%1', Rec."Reading Date To");


                                        CER.SetCurrentKey("Starting Date");
                                        CER.Ascending;
                                        if CER.FindLast() then begin
                                            if rec.SM3 < 0 then
                                                rec.SM3 := 0;
                                            Rec."War Calculation (LVT)" :=
                                            //((Rec.SM3 * UnitP / WarDebt.CBM) * CER."Relational Exch. Rate Amount");
                                            Rec.SM3 * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=');
                                            rec."War Resource Code" := WarDebt.Resource;
                                            //Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                        end;
                                    end;

                                end;

                            until WarDebt.Next() = 0;
                        WarDebt.Reset();
                        WarDebt.SetFilter(Month, '%1', Rec."Month Of GAS Calculation");
                        WarDebt.SetFilter(Active, '%1', true);
                        WarDebt.SetFilter("Customer Category", '%1', Rec."Category Customer");
                        WarDebt.SetFilter(Totaling, '<>%1', '');
                        if WarDebt.FindSet() then
                            repeat
                                CJL2.Reset();
                                // CJL2.SetFilter("Customer No.", '%1', CalcJ."Customer No.");
                                CJL2.SetFilter("Month Of GAS Calculation", WarDebt.Totaling);
                                //    CJL2.SetFilter(Code, '<>%1', rec.Code);
                                CJL2.SetFilter("Year Of GAS Calculation", '%1', Rec."Year Of GAS Calculation");
                                CJL2.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                                CJL2.SetFilter(Locked, '%1', true);
                                //  CJL2.SetFilter(Gauge, '%1', Rec.Gauge);
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
                                if rec.SM3 < 0 then
                                    rec.SM3 := 0;
                                if CJL2.sm3 < 0 then
                                    CJL2.sm3 := 0;
                                if Rec."Manualy War Value" = false then begin
                                    if WarDebt.CBM <> 0 then
                                        Rec."War Calculation" := (CJL2.SM3) * UnitP / WarDebt.CBM
                                    else
                                        Rec."War Calculation" := 0;
                                end;
                                Rec."Currency Code" := WarDebt."Currency Code";
                                rec."War Resource Code" := WarDebt.Resource;
                                if Rec."Currency Code" = '' then begin
                                    Rec."War Calculation (LVT)" := Rec."War Calculation";
                                end
                                else begin
                                    //naći currency
                                    if Rec."Manualy War Value" = false then begin
                                        CER.Reset();
                                        CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                                        //   CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");

                                        if (ch."Month Of GAS Calculation" = Rec."Month Of GAS Calculation") and (ch."Year Of GAS Calculation" = Rec."Year Of GAS Calculation") then
                                            CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To")
                                        else
                                            CER.SetFilter("Starting Date", '<=%1', Rec."Reading Date To");

                                        CER.SetCurrentKey("Starting Date");
                                        CER.Ascending;
                                        if CER.FindLast() then begin
                                            if rec.SM3 < 0 then
                                                rec.SM3 := 0;

                                            if WarDebt.CBM <> 0 then
                                                rec."War Calculation (LVT)" := (CJL2.SM3) * round(((UnitP * CER."Relational Exch. Rate Amount") / WarDebt.CBM), 0.000001, '=')

                                            else
                                                rec."War Calculation (LVT)" := 0;
                                            rec."War Resource Code" := WarDebt.Resource;
                                            //Rec."War Calculation" * CER."Relational Exch. Rate Amount";
                                        end;
                                    end;
                                end;
                            until WarDebt.Next() = 0;

                        CustInternal.Reset();
                        CustInternal.SetFilter("No.", '%1', rec."Customer No.");
                        if CustInternal.FindFirst() then begin
                            if CustInternal."Internal Customer" = True then begin
                                rec."War Calculation" := 0;
                                rec."War Calculation (LVT)" := 0;
                                rec."War Resource Code" := '';
                            end;
                        end;

                        rec."Subsidies Amount" := 0;
                        rec."Subsidies VAT Amount" := 0;
                        rec."Subsidies VAT Amount" := 0;
                        rec."Subsidies Total Amount" := 0;
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
                        CustomerPrice.SetFilter("No.", '%1', rec."Customer No.");
                        if CustomerPrice.FindFirst() then begin
                            if (CustomerPrice."Subsidies - has statement" = CustomerPrice."Subsidies - has statement"::Yes) and (CustomerPrice."Subsidies - YES/NO" = CustomerPrice."Subsidies - YES/NO"::Yes) and (Subs = true) then begin
                                Rec."Deminimis Act Date" := CalSetup."Deminimis Act Date";
                                Rec."Deminimis Act Name" := CalSetup."Deminimis Act Name";
                                Rec."Deminimis Act Number" := CalSetup."Deminimis Act Number";
                                Rec."Deminimis Legal act" := CalSetup."Deminimis Legal act";
                                Rec."Deminimis Purpose" := CalSetup."Deminimis Purpose";
                                Rec."Deminimis Remark" := CalSetup."Deminimis Remark";
                                Resource.Reset();
                                Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                                if Resource.FindFirst() then begin
                                    VatPostingSetup.reset;
                                    VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                                    VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                                    if VatPostingSetup.FindFirst() then begin
                                        if rec.SM3 < 0 then
                                            rec.SM3 := 0;
                                        rec."Subsidies Amount" := rec.SM3 * CalSetup.Subsidies;
                                        rec."Subsidies VAT Amount" := 0;
                                        rec."Subsidies VAT Amount" := "Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                        rec."Subsidies Total Amount" := rec."Subsidies Amount" + rec."Subsidies VAT Amount";
                                    end;
                                end;

                                rec.Subsidies := true;
                                if rec.SM3 < 0 then
                                    rec.SM3 := 0;
                                rec."Subsidies Amount" := rec.SM3 * CalSetup.Subsidies;
                            end
                            else begin

                                Rec."Deminimis Act Date" := 0D;
                                rec."Subsidies Amount" := 0;
                                Rec."Deminimis Act Name" := '';
                                Rec."Deminimis Act Number" := '';
                                Rec."Deminimis Legal act" := '';
                                Rec."Deminimis Purpose" := '';
                                Rec."Deminimis Remark" := '';

                                rec."Subsidies VAT Amount" := 0;
                                rec."Subsidies Total Amount" := 0;
                                rec.Subsidies := false;


                            end;


                            if rec.Subsidies = true then begin

                                Resource.Reset();
                                Resource.SetFilter("No.", '%1', CalSetup."Subsidies Resource");
                                if Resource.FindFirst() then begin
                                    VatPostingSetup.reset;
                                    VatPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', Resource."VAT Prod. Posting Group");
                                    VatPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', CustomerPrice."VAT Bus. Posting Group");
                                    if VatPostingSetup.FindFirst() then begin
                                        rec."Subsidies VAT Amount" := "Subsidies Amount" * VatPostingSetup."VAT %" / 100;
                                        rec."Subsidies Total Amount" := rec."Subsidies Amount" + rec."Subsidies VAT Amount";
                                    end;
                                end;
                                if rec."Subsidies Amount" <> 0 then
                                    //sad da izračun PDV
                                    rec.Subsidies := true
                                else
                                    rec.Subsidies := false;

                            end;
                        end;
                        //kraj
                        //kraj

                    end;



                end;
                Rec.Unobvious := true;
                rec.Modify();

            until rec.Next() = 0;


    end;
            }

            action("Agreement")
            {

                Caption = 'Agreement';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        CustA: Record Customer;
        CalcIn: Record "Calculation Journal Line";
        CalcInLast: Record "Calculation Journal Line";
        Id: Integer;
        CalcInNew: Record "Calculation Journal Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        RezDecimal: Decimal;

    begin

        CalcInLast.Reset();
        CalcInLast.SetCurrentKey(Autoint);
        if CalcInLast.FindLast() then
            Id := CalcInLast.Autoint + 1
        else
            id := 1;

        CustA.Reset();
        CustA.SetFilter("Agreement Customer No.", '<>%1', '');
        CustA.SetFilter("Customer Category", '%1', rec."Category Customer");
        if CustA.FindSet() then
            repeat
                CalcIn.Reset();
                CalcIn.SetFilter("Customer No.", '%1', CustA."Agreement Customer No.");
                CalcIn.SetFilter(Code, '%1', rec.Code);
                CalcIn.SetFilter(Locked, '%1', false);
                if CalcIn.FindSet() then
                    repeat

                        //pronađem nosioca

                        CalcInNew.Init();
                        CalcInNew.TransferFields(CalcIn);
                        CalcInNew.Autoint := Id;
                        CalcInNew."Customer No." := CustA."No.";
                        CalcInNew."Customer Balance" := 0;
                        RezDecimal := 0;
                        CalcInNew."Customer Prepayment" := 0;
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetFilter("Customer No.", '%1', CalcInNew."Customer No.");
                        CustLedgerEntry.SetFilter("Bill Type", '%1|%2|%3', '01', '02', '03');
                        CustLedgerEntry.SetFilter(Prepayment, '%1', false);
                        CustLedgerEntry.SetFilter(Open, '%1', true);
                        if CustLedgerEntry.FindSet() then
                            repeat
                                RezDecimal += CustLedgerEntry."Remaining Amt. (LCY)";

                            until CustLedgerEntry.Next() = 0;


                        if RezDecimal > 0 then
                            CalcInNew."Customer Balance" := RezDecimal
                        else
                            CalcInNew."Customer Prepayment" := abs(RezDecimal);

                        CalcInNew."Customer Name" := CustA.Name;
                        CalcInNew."VAT Registration No." := CustA."VAT Registration No.";
                        CalcInNew."Registration No." := CustA."Registration No.";
                        CalcInNew.Agreement := CustA.Agreement;
                        CalcInNew."Bill distribution percentage" := CustA."Bill distribution percentage";
                        CalcInNew."Customer string" := CustA."Customer String";
                        CalcInNew."Customer String 2" := CustA."Customer String 2";
                        CalcInNew."Customer Stroke" := CustA."Customer Stroke";
                        CalcInNew."Customer Stroke 2" := CustA."Customer Stroke 2";

                        CalcInNew."MZ Customer" := CustA."MZ Customer";
                        CalcInNew."E-Mail 2" := CustA."E-Mail 2";
                        CalcInNew."E-mail Delivery" := CustA."E-mail Delivery";
                        CalcInNew."E-mail Delivery Date" := CustA."E-mail Delivery Date";
                        CalcInNew."E-mail Delivery Date to" := CustA."E-mail Delivery Date to";
                        CalcInNew."MZ Customer 2" := CustA."MZ Customer 2";
                        CustA.CalcFields("Municipality Name Customer", "Municipality Name Customer 2", "MZ Name Customer", "MZ Name Customer 2", "Street Name Customer", "Street Name Customer 2");
                        CalcInNew."City Customer" := CustA.City;
                        CalcInNew."City Customer D." := CustA."City 2";
                        CalcInNew."Floor Customer" := CustA."Floor Customer";
                        CalcInNew."Floor Customer 2" := CustA."Floor Customer 2";
                        CalcInNew."Street Customer" := CustA."Street Customer";
                        CalcInNew."Street Customer 2" := CustA."Street Customer 2";
                        CalcInNew."Address Customer" := CustA.Address;
                        CalcInNew."Address 2" := CustA."Address 2";
                        CalcInNew."MZ Name Customer" := CustA."MZ Name Customer";
                        CalcInNew."MZ Name Customer 2" := CustA."MZ Customer 2";
                        CalcInNew."Home No. Customer" := CustA."Home No. Customer";
                        CalcInNew."Home No. Customer 2" := CustA."Home No. Customer 2";
                        CalcInNew."Post Code Customer" := CustA."Post Code";
                        CalcInNew."Post Code Customer D." := CustA."Post Code 2";
                        CalcInNew."Street Name Customer" := CustA."Street Name Customer";
                        CalcInNew."Street Customer 2" := CustA."Street Customer 2";
                        CalcInNew."Apartment No. Customer" := CustA."Apartment No. Customer";
                        CalcInNew."Apartment No. Customer 2" := CustA."Apartment No. Customer 2";
                        CalcInNew."Municipality Code Customer" := CustA."Municipality Code Customer";
                        CalcInNew."Municipality Code Customer 2" := CustA."Municipality Code Customer 2";
                        CalcInNew."Municipality Name Customer" := CustA."Municipality Name Customer";
                        CalcInNew."Municipality Name Customer 2" := CustA."Municipality Name Customer 2";

                        CalcInNew.Insert();
                        Id += 1;

                    until CalcIn.Next() = 0;

            until CustA.Next() = 0;


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
                Rec.USERID_ID := USERID;
                Rec.Modify();
            until Rec.Next() = 0;

    end;
            }
            action("Marked Return RN")
            {

                Caption = 'Marked Return RN';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
    begin
        if Rec.FindSet() then
            repeat
                if Rec."Return RN" = true then
                    Rec.Validate("Return RN", false)
                else
                    Rec.Validate("Return RN", true);
                Rec.USERID_ID := USERID;
                Rec.Modify();
            until Rec.Next() = 0;

    end;
            }

            action("Preview Print Sales Invoice")
            {
                Caption = 'Preview Print Sales Invoice';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
    begin
        Report.Run(50182, true, true, rec);
    end;
            }
            action("Recapitulation GAS")
            {
                Caption = 'Recapitulation GAS';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
    begin
        Report.Run(50183, true, true, rec);
    end;
            }

            //*"Export Post"*
            //
            action("Export post")
            {

                Caption = 'Export post';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;
    trigger OnAction()
    var
        myInt: Integer;
        CH: Record "Calcuation Header";
        CCHCode: Record "Calcuation Header";
        SifraObracuna: Text;
        CJlFilters: Record "Calculation Journal Line";
        // CUReport: codeunit CU_CalcJournalTempReport;

        ViewText: texT;
    begin
        if Rec."Category Customer" = Rec."Category Customer"::Household then begin

            // Ako CH.FindFirst = false
            Report.Run(50193, true, true, Rec);

        end else begin
            // Ako nije Household
            Report.Run(50200, true, true, Rec);
        end;
    end;

            }

            action("Create Sales Invoice")
            {

                Caption = 'Create Sales Invoice';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var

        CreateBillingJob: Report "Create Billing JOB";
        CLog: Record "CJL Logs";

    begin
        CLog.reset;
        CLog.SetFilter(Purpose, '%1', 'KreirajRacune');
        CLog.SetFilter("Billing_Code", '<>%1', Rec.Code);
        if CLog.FindFirst() then
            CLog.DeleteAll();

        Commit();
        //Report.Run(50166, true, true, Rec);
        Report.run(Report::"Create Billing JOB", true, false, rec);
    end;
            }
            //kreiraj opomene
            action("Create Reminders")
            {

                Caption = 'Create Reminders';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        Customer: Record Customer;
        CustomerSummaryAging: Report "CustomerSummaryAging Billing";
        US: record "User Setup";
        reminder: Record "Reminder Header";
    begin

        //   Customer.Reset();
        // Customer.setfilter("Customer Status", '%1', Customer."Customer Status"::Active);
        //       Commit();
        //     Clear(CustomerSummaryAging);
        us.reset;
        us.setfilter("User ID", '%1', userid);
        if us.findfirst then begin
            us."Calculation V" := rec.Code;
            us.modify;

        end;
        commit;

        // CustomerSummaryAging.SetParam(true, rec.Code, 'I');
        reminder.Reset();
        reminder.SetFilter(WH, '%1', rec.Code);
        if reminder.FindFirst() then
            reminder.DeleteAll();
        Commit();

        Report.Run(50211, true, true, Rec);
        Commit();
        commit;
        // CustomerSummaryAging.Run();
        commit;
        us.reset;
        us.setfilter("User ID", '%1', userid);
        if us.findfirst then begin
            us."Calculation V" := '';
            us.modify;

        end;
        //   Commit();

        //  Report.Run(50152, true, true, Customer);

    end;
            }

            action("Reminder List")
            {

                Caption = 'Reminder List';
                Image = Report;
                            Promoted = true;
                            PromotedCategory = Report;
                            PromotedIsBig = true;

    trigger OnAction()
    var
        RH: Record "Reminder Header";
        CustomerSummaryAging: Page "Reminder List";
    begin

        //   Customer.Reset();
        // Customer.setfilter("Customer Status", '%1', Customer."Customer Status"::Active);
        Commit();
        Clear(CustomerSummaryAging);
        RH.Reset();
        RH.SetFilter(wh, '%1', rec.Code);
        CustomerSummaryAging.SetTableView(rh);
        CustomerSummaryAging.Run();
        //Commit();

        //  Report.Run(50152, true, true, Customer);

    end;
            }


            /*  action("Create txt file - BHPOST")
              {

                  Caption = 'Create txt file - BHPOST';
                  Image = Report;
                  Promoted = true;
                  PromotedCategory = Report;
                  PromotedIsBig = true;

                  trigger OnAction()
                  var
                      Customer: Record Customer;
                      CustomerSummaryAging: Report CustomerSummaryAging;
                  begin

                      //   Customer.Reset();
                      // Customer.setfilter("Customer Status", '%1', Customer."Customer Status"::Active);
                      Commit();
                      Clear(CustomerSummaryAging);
                      CustomerSummaryAging.SetParam(true, rec.Code);
                      CustomerSummaryAging.Run();
                      Commit();

                      //  Report.Run(50152, true, true, Customer);

                  end;
              }
  */
            //kraj
            group(Control)
            {
                Caption = 'Control List';


                action("Negative Value")
                {
                    Caption = 'Create Control List for negative value';
                    Image = Report;
                                Promoted = true;
                                PromotedCategory = Report;
                                PromotedIsBig = true;
                                Visible = false;


    trigger OnAction()
    var
        ControlList: Record "Control list";
        ControlList2: Record "Control list";
        CListPage: Page "Control lists";
        BrojR: Integer;
    begin



        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', ControlList.Code);
        ControlList2.SetFilter("Control ID done", '%1', true);
        ControlList2.SetCurrentKey("Control Number");
        ControlList2.Ascending;
        if ControlList2.FindLast() then
            BrojR := ControlList2."Control Number"
        else
            BrojR := 0;


        Rec.Reset();
        Rec.SetFilter(SM3, '<%1', 0);
        if Rec.FindSet() then
            repeat
                ControlList.Init();
                ControlList.TransferFields(Rec);
                ControlList.USERID := USERID;

                ControlList."Control Number" := BrojR + 1;
                ControlList.Insert();
            until Rec.Next() = 0;

        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', Rec.Code);
        ControlList2.SetFilter(Locked, '%1', false);
        CListPage.SetTableView(ControlList2);
        CListPage.Run();

    end;
                }

                action("Zero Value")
                {
                    Caption = 'Create Control List for zero value';
                    Image = Report;
                                Promoted = true;
                                PromotedCategory = Report;
                                PromotedIsBig = true;
                                Visible = false;



    trigger OnAction()
    var
        ControlList: Record "Control list";
        ControlList2: Record "Control list";
        CListPage: Page "Control lists";
        BrojR: Integer;
    begin


        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', ControlList.Code);
        ControlList2.SetFilter("Control ID done", '%1', true);
        ControlList2.SetCurrentKey("Control Number");
        ControlList2.Ascending;
        if ControlList2.FindLast() then
            BrojR := ControlList2."Control Number"
        else
            BrojR := 0;


        Rec.Reset();
        Rec.SetFilter(SM3, '%1', 0);
        if Rec.FindSet() then
            repeat
                ControlList.Init();
                ControlList.TransferFields(Rec);
                ControlList.USERID := USERID;
                ControlList."Control Number" := BrojR + 1;
                ControlList.Insert();
            until Rec.Next() = 0;

        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', Rec.Code);
        ControlList2.SetFilter(Locked, '%1', false);
        CListPage.SetTableView(ControlList2);
        CListPage.Run();

    end;
                }

                action("Create Control List")
                {
                    Caption = 'Create Control List';
                    Image = Report;
                                Promoted = true;
                                PromotedCategory = Report;
                                PromotedIsBig = true;


    trigger OnAction()
    var
        ControlList: Record "Control list";
        ControlList2: Record "Control list";
        CListPage: Page "Control lists";
        BrojR: Integer;
        CV: Text;
        BrojM: Integer;
    begin

        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', ControlList.Code);
        ControlList2.SetFilter("Control ID done", '%1', true);
        ControlList2.SetCurrentKey("Control Number");
        ControlList2.Ascending;
        if ControlList2.FindLast() then
            BrojR := ControlList2."Control Number"
        else
            BrojR := 0;
        BrojM := 0;


        if Rec.FindSet() then
            repeat
                ControlList.Init();
                ControlList.TransferFields(Rec);
                ControlList.USERID := USERID;
                ControlList."Control Number" := BrojR + 1;
                if BrojM <> 1 then begin
                    if BrojM <> 1 then
                        ControlList."Reason for Control" := CV
                    else
                        ControlList."Reason for Control" := rec."Reason for Control";
                end;
                ControlList.Insert();
                BrojM += 1;
                if BrojM = 1 then begin
                    CV := rec."Reason for Control";
                end;
            until Rec.Next() = 0;

        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', Rec.Code);
        ControlList2.SetFilter(Locked, '%1', false);
        CListPage.SetTableView(ControlList2);
        CListPage.Run();

    end;
                }




                action("Control List")
                {
                    Caption = 'Control List';
                    Image = Report;
                                Promoted = true;
                                PromotedCategory = Report;
                                PromotedIsBig = true;


    trigger OnAction()
    var
        ControlList: Record "Control list";
        ControlList2: Record "Control list";
        CListPage: Page "Control lists";
    begin


        ControlList2.Reset();
        ControlList2.SetFilter(Code, '%1', Rec.Code);
        CListPage.SetTableView(ControlList2);
        CListPage.Run();

    end;
                }
                action(CreateRN)
                {
                    Caption = 'CreateRN';
                    Image = Report;
                                Promoted = true;
                                PromotedCategory = Report;
                                PromotedIsBig = true;


    trigger OnAction()
    var
        filter: text[250];
        GTemp: Record "Calculation Journal Line";

    begin
        Rec.FINDFIRST;
        filter := Rec.GETFILTERS;
        GTemp.Reset();
        GTemp.CopyFilters(Rec);
        Report.RunModal(Report::"Create Massive RN Billing", true, true, GTemp);
    end;
                }

                action(SentEMail)
                {
                    Caption = 'SentEMail';
                    Image = Report;
                                Promoted = true;
                                PromotedCategory = Report;
                                PromotedIsBig = true;


    trigger OnAction()
    var
        filter: text[250];
        GTemp: Record "Calculation Journal Line";

    begin
        Rec.FINDFIRST;
        filter := Rec.GETFILTERS;
        GTemp.Reset();
        GTemp.CopyFilters(Rec);
        GTemp.SetFilter("Sent e-mail", '%1', false);
        GTemp.SetFilter("E-Mail 2", '<>%1', '');
        Report.RunModal(Report::"Send Invoice via e-mail", true, true, GTemp);
    end;
                }

            }
        }

        //Kreiraj račune

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        US: Record "User Setup";
        Cjl: Record "Calculation Journal Line";
        WCHeadeR: Record "Calcuation Header";

    begin



        Rows := Rec.Count;
        Cjl.Reset();
        Cjl.CopyFilters(rec);
        if cjl.FindFirst() then
            cjl.CalcSums(Total);
        Rows2 := cjl.Total;

        Rows3 := 0;
        Cjl.Reset();
        Cjl.CopyFilters(rec);
        if cjl.FindFirst() then
            cjl.CalcSums("War Calculation (LVT)");
        Rows3 := cjl."War Calculation (LVT)";



        US.Reset();
        US.SetFilter("User ID", '%1', USERID);
        US.SetFilter("Entries or Calculation", '%1', false);
        if us.FindFirst() then begin

            FILTERGROUP(2);
            // set your filter here
            SetFilter(Locked, '%1', true);
            FILTERGROUP(0);
        end;

        SetRange("Date Filter", 0D, "Calculation Date To");

        WCHeadeR.Reset();
        WCHeadeR.SetFilter(cODE, '%1', rEC.Code);
        WCHeadeR.SetFilter("Summer or Winter Zone", '<>%1', WCHeadeR."Summer or Winter Zone"::" ");
        if WCHeadeR.FindFirst() then begin

            if WCHeadeR."Summer or Winter Zone" = WCHeadeR."Summer or Winter Zone"::Summer then
                SetCurrentKey("Measuring Zone - summer", "Measuring Zone - winter", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM")

            else
                SetCurrentKey("Measuring Zone - winter", "Measuring Zone - summer", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM");

        end
        else begin

            SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street Name MM", "Street No. Int", "Street No. Text MM", "Street No. Text int", "Street No. Text Apartment", "Customer No. int");

        END;

        if Rec."Undo Calculation" then
            RowStyle := 'Unfavorable'
        else
            RowStyle := '';
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        US: Record "User Setup";
        Cjl: Record "Calculation Journal Line";
        WCHeadeR: Record "Calcuation Header";
    begin

        if Rec."Undo Calculation" then
            RowStyle := 'Unfavorable'
        else
            RowStyle := '';

        Rows := Rec.Count;
        Cjl.Reset();
        Cjl.CopyFilters(rec);
        if cjl.FindFirst() then
            cjl.CalcSums(Total);
        Rows2 := cjl.Total;

        Rows3 := 0;

        Rows3 := 0;
        Cjl.Reset();
        Cjl.CopyFilters(rec);
        if cjl.FindFirst() then
            cjl.CalcSums("War Calculation (LVT)");
        Rows3 := cjl."War Calculation (LVT)";


        US.Reset();
        US.SetFilter("User ID", '%1', USERID);
        US.SetFilter("Entries or Calculation", '%1', false);
        if us.FindFirst() then begin

            FILTERGROUP(2);
            // set your filter here
            SetFilter(Locked, '%1', true);
            FILTERGROUP(0);
        end;

        WCHeadeR.Reset();
        WCHeadeR.SetFilter(cODE, '%1', rEC.Code);
        WCHeadeR.SetFilter("Summer or Winter Zone", '<>%1', WCHeadeR."Summer or Winter Zone"::" ");
        if WCHeadeR.FindFirst() then begin

            if WCHeadeR."Summer or Winter Zone" = WCHeadeR."Summer or Winter Zone"::Summer then
                SetCurrentKey("Measuring Zone - summer", "Measuring Zone - winter", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM")

            else
                SetCurrentKey("Measuring Zone - winter", "Measuring Zone - summer", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM");

        end
        else begin

            SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street Name MM", "Street No. Int", "Street No. Text MM", "Street No. Text int", "Street No. Text Apartment", "Customer No. int");
        END;

    end;

    trigger OnClosePage()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if Us.FindFirst() then begin
            us."Entries or Calculation" := true;
            us.Modify();
        end;

    end;

    local procedure GetRowStyle(): Text
    begin
        if Rec."Undo Calculation" = true then
            exit('Unfavorable');
        exit('');
    end;

    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;


    var
        myInt: Integer;
        RowStyle: text;
        Rows: Integer;

        //CJlTempFilters: Record "Calculation Journal Line" temporary;
        Rows2: Decimal;

        Rows3: Decimal;


        AC: Report "Aged Accounts Receivable";


}