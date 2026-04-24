report 50170 "Undo Create and Posting"
{
    DefaultLayout = RDLC;
    Caption = 'Undo Calculation';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {

            trigger OnAfterGetRecord()

            var
                CJLF: Record "Calculation Journal Line";
                SCRCreditMemo: Record "Service Header";
                CBill: Record "Customer Templ.";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                KeyCode: Text;

            begin

                //išla bih na opciju kopiraj koliko je račun bio, ima li odstupanje i po čemu i razliku bi fakturisala.
                CBill.Reset();
                CBill.SetFilter("Bill Category", '%1', "Calculation Journal Line"."Category Customer");
                if CBill.findfirst then begin

                    MonthText := Format("Calculation Journal Line"."Month Of GAS Calculation");
                    YearText := Format("Calculation Journal Line"."Year Of GAS Calculation");
                    KeyCode := Format("Calculation Journal Line"."Customer No.") + '_' + MonthText + '_' + YearText;

                    CustttTemp.Reset();
                    CustttTemp.SetFilter("Invoice Disc. Code", '%1', "Calculation Journal Line"."Customer No.");
                    CustttTemp.SetFilter(Description, '%1', MonthText);
                    CustttTemp.SetFilter("Territory Code", '%1', YearText);

                    if not CustttTemp.FindFirst() then begin

                        NextDocNo := NoSeriesMgt.GetNextNo(CBill."Undo Posting No. Series Bill", "Calculation Date To", true);
                        CustttTemp.Init();
                        CustttTemp.Code := KeyCode;
                        CustttTemp."Invoice Disc. Code" := "Calculation Journal Line"."Customer No.";
                        CustttTemp.Description := MonthText;
                        CustttTemp."Territory Code" := YearText;
                        CustttTemp."Contact Phone" := NextDocNo; // store generated doc no as contact phone temporarily
                        CustttTemp.Insert(true);
                        Docno := NextDocNo;
                    end else begin
                        Docno := CustttTemp."Contact Phone";
                    end;

                    ServiceHeaderInit.init;
                    ServiceLineBroj := 0;
                    ServiceHeaderInit."Document Type" := ServiceHeaderInit."Document Type"::"Credit Memo";
                    if "Calculation Journal Line"."Undo Document No." = '' then begin
                        NextDocNo := NoSeriesMgt.GetNextNo(CBill."Undo Posting No. Series Bill", "Calculation Date To", true);
                        if StrLen(Format(Date2DMY(("Calculation Journal Line"."Calculation Date To"), 3))) = 4 then
                            "Calculation Journal Line"."Undo Document No." := Docno + '/' + CopyStr(Format(Date2DMY("Calculation Journal Line"."Calculation Date To", 3)), 3, 2)
                        else
                            // fallback - use full year string
                            "Calculation Journal Line"."Undo Document No." := Docno + '/' + Format(Date2DMY("Calculation Journal Line"."Calculation Date To", 3));

                    end;
                    ServiceHeaderInit."No." := "Calculation Journal Line"."Undo Document No.";
                    ServiceHeaderInit.Validate("Customer No.", "Calculation Journal Line"."Customer No.");
                    ServiceHeaderInit.validate("Posting Date", "Calculation Journal Line"."Calculation Date To");
                    ServiceHeaderInit.validate("VAT Date", "Calculation Journal Line"."Calculation Date To");
                    ServiceHeaderInit.validate("Document Date", "Calculation Journal Line"."Calculation Date To");
                    ServiceHeaderInit.validate("Request Type", ServiceHeaderInit."Request Type"::"Billing Invoice");
                    ServiceHeaderInit.validate("Due Date", calcdate('<+15D>', "Calculation Journal Line"."Calculation Date To"));
                    ServiceHeaderInit."Order Time" := Time;

                    ServiceHeaderInit.Validate("Bill Category", "Calculation Journal Line"."Category Customer");
                    ServiceHeaderInit.Validate("Bill type", CBill.Code);
                    ServiceHeaderInit."No. Series" := CBill."Undo No. Series Bill";
                    ServiceHeaderInit."Posting No. Series" := CBill."Undo Posting No. Series Bill";
                    ServiceHeaderInit."Shipping No. Series" := CBill."Undo No. Series Bill";
                    ServiceHeaderInit."Shipping No." := ServiceHeaderInit."No.";

                end;

                ServiceHeaderInit.Validate("Order Time", Time);
                ServiceHeaderInit.insert;
                Commit();
                //uradila sam zaglavlje fakture - sada gledam kako da ga storniram i to samo količinski.

                //dodajem jedno ovo MM

                SLine.reset;
                SLine.SetFilter("Document No.", '%1', "Calculation Journal Line"."Undo Document No.");
                SLine.SetFilter("Document Type", '%1', Sline."Document Type"::"Credit Memo");
                Sline.SetCurrentKey("Line No.");
                Sline.Ascending;
                if SLine.findlast then begin
                    ServiceLineBroj := SLine."Line No.";
                    //ovo je kao startna zadnja

                end;

                //linije
                //dodaj MM ako ga nema
                ServiceItemLineE.reset;
                ServiceItemLineE.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                ServiceItemLineE.SetFilter("Service Item No. - Relation", '%1', "Calculation Journal Line"."Measuring Point Code");
                ServiceItemLineE.SetFilter(Gauge, '%1', "Calculation Journal Line".Gauge);
                ServiceItemLineE.SetFilter("Document No.", '%1', "Calculation Journal Line"."Undo Document No."); //ovo ako je zamjena, dodaj linije

                if not ServiceItemLineE.FindFirst() then begin

                    ServiceLineBroj += 1000;
                    ServiceItemLine."Document Type" := ServiceItemLine."Document Type"::"Credit Memo";
                    ServiceItemLine.Validate("Customer No.", "Calculation Journal Line"."Customer No.");
                    ServiceItemLine."Document No." := "Calculation Journal Line"."Undo Document No.";
                    ServiceItemLine."Line No." := ServiceLineBroj;

                    ServiceItemLine.Validate("Service Item No. - Relation", "Calculation Journal Line"."Measuring Point Code");
                    ServiceItemLine.Gauge := "Calculation Journal Line".Gauge;
                    ServiceItemLine.RMS := "Calculation Journal Line"."Serial Number";

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
                    //kraj
                end;
                // sada ako ima napalta i razlika da uradim storno

                CalcSetup.get;

                ServiceLineNaplata.init;
                ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::Order;
                ServiceLineNaplata."Document No." := "Calculation Journal Line"."Undo Document No.";
                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                BrojAdd += 1;
                ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;

                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                ServiceLineNaplata.Validate("Customer No.", "Calculation Journal Line"."Customer No.");
                ServiceLineNaplata.Gauge := "Calculation Journal Line".Gauge;

                ServiceLineNaplata.validate(Type, ServiceLineNaplata.Type::Item);
                CalcSetup.get;
                ServiceLineNaplata.Validate("No.", CalcSetup."Item No. 2");
                ServiceLineNaplata.validate("Location Code", 'GLAVNO GAS');
                GasF := 0;
                PostedServiceF.Reset();
                PostedServiceF.SetFilter("No.", '%1', "Calculation Journal Line"."Document No. Posting");
                PostedServiceF.SetFilter(Type, '%1', PostedServiceF.Type::Item);
                if PostedServiceF.FindSet() then
                    repeat
                        GasF += PostedServiceF.Quantity;
                    until PostedServiceF.Next() = 0;
                ServiceLineNaplata.Validate(Quantity, GasF - "Calculation Journal Line".SM3);
                ServiceLineNaplata.validate("Unit Price", "Calculation Journal Line"."Sales Unit Price");

                ServiceLineNaplata."Unit Price" := "Calculation Journal Line"."Sales Unit Price";
                //ServiceLineNaplata.Amount := (ServiceLineNaplata."Unit Price" * ServiceLineNaplata.Quantity
                //ServiceLineNaplata.validate(Amount, round(ServiceLineNaplata.Amount, 0.01, '='));
                //ServiceLineNaplata.validate("Amount Including VAT", round(ServiceLineNaplata."Amount Including VAT", 0.01, '='));
                if ServiceLineNaplata."No." = 'GAS2' then
                    ServiceLineNaplata.Validate("Posting Group", 'RACUNI');
                if ServiceLineNaplata.Quantity <> 0 then
                    ServiceLineNaplata.Insert(false);



                ServiceLineNaplata.init;
                ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::"Credit Memo";
                ServiceLineNaplata."Document No." := "Calculation Journal Line"."Undo Document No.";
                //ServiceLineBroj += 1000;

                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                BrojAdd += 1;
                ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;
                ServiceLineNaplata.Validate("Customer No.", "Calculation Journal Line"."Customer No.");

                ServiceLineNaplata.Validate(Type, ServiceLineNaplata.Type::Resource);
                ServiceLineNaplata.Gauge := "Calculation Journal Line".Gauge;


                CalcSetup.get;
                ServiceLineNaplata.Validate("No.", "Calculation Journal Line"."Basis Resource Code");
                ServiceLineNaplata.Validate(Quantity, 1);

                GasF := 0;
                PostedServiceF.Reset();
                PostedServiceF.SetFilter("No.", '%1', "Calculation Journal Line"."Document No. Posting");
                PostedServiceF.SetFilter(Type, '%1', PostedServiceF.Type::Resource);
                PostedServiceF.Validate("No.", "Calculation Journal Line"."Basis Resource Code");
                if PostedServiceF.FindSet() then
                    repeat
                        GasF += PostedServiceF.Quantity;
                    until PostedServiceF.Next() = 0;


                ServiceLineNaplata.validate("Unit Price", "Calculation Journal Line"."Basis maintenance" - GasF);
                ServiceLineNaplata.validate("VAT billing", "Calculation Journal Line"."Maintenance VAT");

                if ServiceLineNaplata."Unit Price" > 0 then
                    ServiceLineNaplata.Insert(false);

                //storno posebne takse 


                ServiceLineNaplata.init;
                ServiceLineNaplata."Document Type" := ServiceLineNaplata."Document Type"::"Credit Memo";
                ServiceLineNaplata."Document No." := "Calculation Journal Line"."Undo Document No.";
                //ServiceLineBroj += 1000;

                ServiceLineNaplata."Service Item Line No." := ServiceLineBroj;
                BrojAdd += 1;
                ServiceLineNaplata."Line No." := ServiceLineBroj + BrojAdd;
                ServiceLineNaplata.Validate("Customer No.", "Calculation Journal Line"."Customer No.");

                ServiceLineNaplata.Validate(Type, ServiceLineNaplata.Type::Resource);
                ServiceLineNaplata.Gauge := "Calculation Journal Line".Gauge;


                CalcSetup.get;
                ServiceLineNaplata.Validate("No.", "Calculation Journal Line"."War Resource Code");
                ServiceLineNaplata.Validate(Quantity, 1);

                GasF := 0;
                PostedServiceF.Reset();
                PostedServiceF.SetFilter("No.", '%1', "Calculation Journal Line"."Document No. Posting");
                PostedServiceF.SetFilter(Type, '%1', PostedServiceF.Type::Resource);
                PostedServiceF.Validate("No.", "Calculation Journal Line"."War Resource Code");
                if PostedServiceF.FindSet() then
                    repeat
                        GasF += PostedServiceF.Quantity;
                    until PostedServiceF.Next() = 0;


                ServiceLineNaplata.validate("Unit Price", "Calculation Journal Line"."War Calculation (LVT)" - GasF);

                if ServiceLineNaplata."Unit Price" > 0 then
                    ServiceLineNaplata.Insert(false);

                //kraj

                //ovo sve je ustvari storno avanse fakture

            end;

            //kraj


        }


    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CustttTemp.DeleteAll();

    end;

    procedure SetParam2(CJLCode: code[20])
    begin
        CJLInsertCode := CJLCode;
    end;


    var
        CJLInsertCode: code[20];
        CustttTemp: Record "Customer Templ." temporary;
        CJLInit: Record "Calculation Journal Line";
        ServiceHeaderInit: Record "Service Header";
        MonthText: Text;
        YearText: Text;
        NextDocNo: Text;
        SLine: Record "Service Item Line";
        PostedServiceF: Record "Service Invoice Line";
        Docno: Text;
        ServiceLineBroj: integer;
        ServiceItemLineE: Record "Service Item Line";
        ServiceItemLine: record "Service Item Line";
        GaugeSerial: record Gauge;
        ServiceLineNaplata: Record "Service Line";
        ServiceLineNaplataE: Record "Service Line";
        CalcSetup: Record "Calculation Setup";
        BrojAdd: Integer;
        GasF: Decimal;


}

