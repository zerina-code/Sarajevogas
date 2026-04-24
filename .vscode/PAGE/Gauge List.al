page 50179 "Gauge List"
{
    PageType = List;
    ApplicationArea = All;
    CardPageId = Gauges;
    UsageCategory = Administration;
    SourceTable = Gauge;
    Caption = 'Gauge';


    layout
    {
        area(Content)
        {
            repeater("")
            {

                field("Gauge Category"; "Gauge Category") { ApplicationArea = all; }

                field(Code; Code) { ApplicationArea = all; }
                field("Inventar number"; "Inventar number") { ApplicationArea = all; }
                field("Meter Manufacturer"; "Meter Manufacturer") { ApplicationArea = all; }
                field("Meter Manufacturer Desc"; "Meter Manufacturer Desc") { }
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field("Customer Status"; "Customer Status") { ApplicationArea = all; }

                field("Customer E-mail"; "Customer E-mail") { ApplicationArea = all; }
                field("Measuring Point"; "Measuring Point") { ApplicationArea = all; }
                field("Address MM"; "Address MM") { ApplicationArea = all; }
                field("Tax Liable"; "Tax Liable") { ApplicationArea = all; }
                field(Tr; Tr) { ApplicationArea = all; }
                field("Year of Production"; "Year of Production") { ApplicationArea = all; }
                field("DD calibration"; "DD calibration") { ApplicationArea = all; }
                field("Meter type"; "Meter type") { ApplicationArea = all; }
                field("Gauge Type"; "Gauge Type") { ApplicationArea = all; }
                field("Gauge Size"; "Gauge Size") { ApplicationArea = all; }
                field("Flow direction"; "Flow direction") { ApplicationArea = all; }
                field("Type of Connection"; "Type of Connection") { ApplicationArea = all; }
                field("VU installation"; "VU installation") { ApplicationArea = all; }
                field("HV Installation"; "HV Installation") { ApplicationArea = all; }
                field("Installation length"; "Installation length") { ApplicationArea = all; }
                field(Weight; Weight) { ApplicationArea = all; }
                field(Model; Model) { ApplicationArea = all; }
                field(No; No) { ApplicationArea = all; }
                field(Pmax; Pmax) { ApplicationArea = all; }
                field(Qmin; Qmin) { ApplicationArea = all; }
                field(Qmax; Qmax) { ApplicationArea = all; }
                field(Pul; Pul) { ApplicationArea = all; }
                field(Piz; Piz) { ApplicationArea = all; }
                field(Tmin; Tmin) { ApplicationArea = all; }
                field(Tmax; Tmax) { ApplicationArea = all; }
                field(Destroyed; Destroyed) { }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportGauge)
            {
                ApplicationArea = all;
                Caption = 'Import Gauge';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportGaugue: XmlPort "Import Gauge";

                begin
                    ImportGaugue.RUN;
                end;
            }
            action(ImportGauge2)
            {
                ApplicationArea = all;
                Caption = 'Import Gauge v2';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportGaugue: XmlPort "Import Gauge verzija2";

                begin
                    ImportGaugue.RUN;
                end;
            }
        }
    }
    procedure GetF(DocumentNO: code[20]) Source: Text
    var
        CustomerPrice: Record Customer;
        SP: Record "Sales Price";
        Reso: Record Resource;
        VPS: record "VAT Posting Setup";
        CU: Record Customer;
        CalSetup: Record "Calculation Setup";
        Item: Record item;
        CJLDel: Record "Calculation Journal Line";
        CH: Record "Calcuation Header";
        CAlJournal2: Record "Calculation Journal Line";
        Subs: Boolean;
        InstallH: Record "Installation History";
        Gaug2: Record Gauge;
        iHC: Record "Installation History";
        CSetup: Record "Calculation Setup";
        MMInt: Integer;
        TypeD: Record "Types Of Diseases";
        AparmentInt: Integer;
        FloorInt: Integer;




    begin
        Source := GETFILTERS;
        CalSetup.FindFirst();
        Item.Get(CalSetup."Item No.");
        Subs := false;


        Gauge2.Reset();
        Gauge2.CopyFilters(Rec);
        if Gauge2.FindSet() then
            repeat
                CH.get(DocumentNO);

                CJLDel.Reset();
                CJLDel.SetFilter(Gauge, '%1', Gauge2.Code);
                CJLDel.SetFilter(Code, '%1', DocumentNO);
                if CJLDel.FindFirst() then begin
                end
                else begin

                    CJL.Init();

                    Csetup.get;

                    cjl."Calorific power coefficient" := Csetup."Calorific power coefficient";
                    CJL."Atmospheric pressure" := Csetup."Atmospheric pressure";
                    CJL."Scale factor" := Csetup."Scale factor";
                    CJL."Compression coefficient" := Csetup."Compression coefficient";

                    CJL."Deminimis Act Date" := 0D;
                    CJL."Deminimis Act Name" := '';
                    CJL."Deminimis Act Number" := '';
                    CJL."Deminimis Legal act" := '';
                    CJL."Gauge Size" := Gauge2."Gauge Size";
                    CJL."Deminimis Purpose" := '';
                    CJL."Deminimis Remark" := '';
                    CJL.Gauge := Gauge2.Code;
                    cjl."Customer Name" := Gauge2."Customer Name";
                    CJL."Method of calculation" := Gauge2."Method of calculation";
                    cjl."Scale factor" := CalSetup."Scale factor";
                    cjl."Atmospheric pressure" := CalSetup."Atmospheric pressure";
                    CJL."Compression coefficient" := CalSetup."Compression coefficient";
                    CJl."Calorific power coefficient" := CalSetup."Calorific power coefficient";
                    CJL."% reduction" := CalSetup."% reduction";
                    CU.get(Gauge2."Customer No.");
                    CJL."VAT Registration No." := CU."VAT Registration No.";
                    CJL."Registration No." := CU."Registration No.";
                    CJL."Customer string" := CU."Customer String";
                    CJl."Customer Stroke" := CU."Customer Stroke";
                    CJL."Street No." := cu."Street No.";
                    CJL."Street No. Text" := Cu."Street No. Text";
                    cjl."Customer Name" := cu.Name + cu."Name 2";


                    if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                        cjl."Street No. Text Apartment" := AparmentInt
                    else
                        cjl."Street No. Text Apartment" := 0;


                    if Evaluate(FloorInt, CU."Floor Customer") then
                        cjl."Street No. Text int" := AparmentInt
                    else
                        cjl."Street No. Text int" := 0;






                    CJL."Measuring Point Code" := Gauge2."Measuring Point";
                    MM.Reset();
                    MM.SetFilter("No.", '%1', Gauge2."Measuring Point");
                    if mm.FindFirst() then begin
                        mm.CalcFields("Street Name MM", "Municipality Name MM");

                        CJL."Address MM" := mm."Address MM";
                        CJL."MM Description" := mm.Description + mm."Description 2";
                        //  CJL.Street := MM.Street;
                        if Evaluate(MMInt, MM."Street No.") then
                            cjl."Street No. Int MM" := MMInt
                        else
                            cjl."Street No. Int MM" := 0;

                        cjl."Street Name MM" := MM."Street Name MM";
                        CJL."Remotely Type" := mm."Remotely Type";
                        cjl.Floor := mm.Floor;
                        CJL."Apartment No." := mm."Apartment No.";
                        cjl."Municipality Code MM" := MM."Municipality Code MM";
                        CJL."Municipality Name MM" := mm."Municipality Name MM";
                        cjl."MM Description" := mm.Description + mm."Description 2";
                        cjl."Remotely Type" := mm."Remotely Type";
                        cjl."Reading Mode" := mm."Reading Mode";
                        cjl."Summer Zone" := mm."Summer Zone";
                        cjl."Winter Zone" := mm."Winter Zone";
                        cjl."Transit Zone" := mm."Transit Zone";
                        CJL."Municipality Code Customer" := CU."Municipality Code Customer";
                        cjl."Municipality Name Customer" := CU."Municipality Name Customer";
                        cjl."Street Customer" := CU."Street No.";
                        CJL."Street Name Customer" := CU."Street Name Customer";
                        cjl."Floor Customer" := CU."Floor Customer";
                        cjl."Apartment No. Customer" := CU."Apartment No. Customer";
                        cjl."Home No. Customer" := CU."Home No. Customer";
                        cjl."Home No." := mm."Home No.";
                        cjl."Category Customer" := CU."Customer Category";
                        cjl."Customer No." := mm."Customer No.";
                        cjl."Reading Mode" := mm."Reading Mode";
                        CJL."Mobile No." := mm."Mobile No.";
                        cjl."MZ Customer" := mm."MZ Customer";
                        mm.CalcFields("MZ Name MM");
                        CU.CalcFields("MZ Name Customer");
                        cjl."MZ Name Customer" := CU."MZ Name Customer";
                        CJL."MM Description" := mm.Description + mm."Description 2";
                        cjl."MZ MM" := mm."MZ MM";
                        cjl."MZ Name MM" := mm."MZ Name MM";
                        cjl."Address Customer" := CU.Address;
                        CJL."Customer string" := CU."Customer String";
                        cjl."Customer Stroke" := CU."Customer Stroke";
                        CJL.Floor := MM.Floor;
                        CJL."Apartment No." := MM."Apartment No.";

                        iHC.Reset();
                        iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                        iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                        iHC.SetFilter(Active, '%1', true);


                        CH.Reset();
                        CH.SetFilter(Code, '%1', DocumentNO);
                        if ch.findfirst then begin
                            CJL."Month of Calculation" := ch."Month of Calculation";
                            cjl."Year of Calculation" := CH."Year of Calculation";
                            CJL."Year Of GAS Calculation" := CH."Year Of GAS Calculation";
                            CJL."Month Of GAS Calculation" := CH."Month Of GAS Calculation";
                            if cjl."Calculation Date From" = 0D then
                                CJL."Calculation Date From" := CH."Calculation Date From";
                            if cjl."Calculation Date To" = 0D then
                                cjl."Calculation Date To" := ch."Calculation Date To";

                            CJL.Code := DocumentNO;


                        end;

                        cjl."Basis Resource Code" := '';
                        CustomerPrice.Reset;
                        CustomerPrice.SetFilter("No.", '%1', Gauge2."Customer No.");
                        if CustomerPrice.FindFirst() then begin
                            SP.Reset();
                            sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
                            sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
                            Sp.SetFilter("Starting Date", '<=%1', cjl."Reading Date To");
                            Sp.SetCurrentKey("Starting Date");
                            sp.Ascending;
                            if sp.FindLast() then begin
                                cjl."Unit Price" := SP."Unit Price";
                                cjl."Sales Unit Price" := sp."Unit Price";
                                cjl."Purchase Unit Price" := sp."Purchase unit price";
                                cjl."Distribution Unit Price" := sp."Unit price of distribution";

                                if cjl."Category Customer" = cjl."Category Customer"::"Large Economy" then begin

                                    Gaug2.Reset();
                                    Gaug2.SetFilter(Code, '%1', Gauge2.Code);
                                    if Gaug2.FindFirst() then
                                        cjl."Serial Number" := Gaug2."Inventar number";

                                    iHC.Reset();
                                    iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                                    iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                                    iHC.SetFilter(Active, '%1', true);
                                    if iHC.FindFirst() then begin
                                        cjl."EL Volume Code" := iHC.Code;
                                        CJl."EL Volume Description" := iHC."EL Volume Description";
                                    end;

                                    if sp."Price not by Gauge" = true then begin
                                    end
                                    else begin

                                        ///ĐEMINA
                                        TypeD.Reset();
                                        TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                                        TypeD.SetFilter("Description", '%1', rec."Gauge Size");
                                        if TypeD.FindFirst() then begin
                                            if cjl."EL Volume Description" <> '' then
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
                                        CJL."Basis maintenance" := Reso."Unit Price"
                                    else
                                        cjl."Basis maintenance" := 0;
                                    cjl."Basis Resource Code" := Reso."No.";

                                    if cjl."Old Gauge" = true then begin
                                        cjl."Basis maintenance" := 0;
                                        cjl."Basis Resource Code" := '';
                                    end;
                                    if cjl."Status MM" = cjl."Status MM"::Terminated then begin
                                        cjl."Basis maintenance" := 0;
                                        cjl."Basis Resource Code" := '';
                                    end;



                                    if (cjl.Unobvious = true) and (cjl."Previous Unobvious Month" = 0) then begin
                                        if cjl."Bill distribution percentage" = 0 then begin
                                            cjl."Basis maintenance" := 0;
                                            cjl."Basis Resource Code" := '';
                                        end;

                                    end;

                                    if (cjl."Customer No.") = '200359' then begin
                                        cjl."Basis maintenance" := 0;
                                        cjl."Basis Resource Code" := '';
                                    end;

                                    VPS.Reset();
                                    vps.SetFilter("VAT Prod. Posting Group", '%1', Reso."VAT Prod. Posting Group");
                                    if CU.get(Gauge2."Customer No.") then
                                        VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
                                    if (VPS.FindFirst()) and (CH."Sales Invoice without VAT" = false) then begin
                                        CJL."Maintenance VAT" := round((CJL."Basis maintenance" * VPS."VAT %") / 100, 0.01, '=');

                                        CJL."Main. VAT Percentage" := VPS."VAT %";
                                    end
                                    else begin
                                        CJL."Maintenance VAT" := 0;
                                        CJL."Main. VAT Percentage" := 0;

                                    end;

                                    if ch."Sales invoice Without M" = true then begin
                                        CJL."Main. VAT Percentage" := 0;
                                        CJL."Maintenance VAT" := 0;
                                    end;

                                    if MM."MM VAT Excluded" = true then
                                        CJL."Maintenance VAT" := 0;

                                    if cu."Cust VAT Excluded" = true then
                                        CJL."Maintenance VAT" := 0;

                                end
                                else begin
                                    cjl."Basis maintenance" := 0;
                                    CJL."Maintenance VAT" := 0;
                                end;


                            end;

                        end
                        else begin
                            CJL."Unit Price" := 0;
                            cjl."Basis maintenance" := 0;
                            cjl."Sales Unit Price" := 0;
                            cjl."Purchase Unit Price" := 0;
                            cjl."Distribution Unit Price" := 0;

                        end;
                        if ch."Sales invoice Without M" = true then
                            CJL."Maintenance - part" := 0
                        else
                            CJL."Maintenance - part" := CJL."Basis maintenance" + CJL."Maintenance VAT";
                        if cjl.sm3 < 0 then
                            cjl.SM3 := 0;
                        CJL."GAS - amount" := round((CJL."Unit Price" * CJL.SM3), 0.01, '=');

                        VPS.Reset();
                        vps.SetFilter("VAT Prod. Posting Group", '%1', Item."VAT Prod. Posting Group");
                        VPS.SetFilter("VAT Bus. Posting Group", '%1', item."VAT Bus. Posting Gr. (Price)");
                        if (VPS.FindFirst()) and (CH."Sales Invoice without VAT" = false) then begin
                            CJL."GAS - VAT" := round(((CJL."GAS - amount" * VPS."VAT %") / 100), 0.01, '=');
                            CJL."SM3 VAT Percentage" := VPS."VAT %";
                        end
                        else begin
                            CJL."GAS - VAT" := 0;
                            CJL."SM3 VAT Percentage" := 0;
                        end;



                        if MM."MM VAT Excluded" = true then begin
                            cjl."GAS - VAT" := 0;
                            CJL."SM3 VAT Percentage" := 0;
                        end;

                        if cu."Cust VAT Excluded" = true then begin
                            cjl."GAS - VAT" := 0;
                            CJL."SM3 VAT Percentage" := 0;
                        end;




                        CJL."GAS - part" := CJL."GAS - VAT" + CJL."GAS - amount";
                        CJL.Total := CJL."GAS - part" + CJL."Maintenance - part";





                    end;
                    CAlJournal2.Reset();
                    if cjl."Calculation Date To" <> 0D then ch."Calculation Date To" := cjl."Calculation Date To";
                    CAlJournal2.SetFilter("Calculation Date To", '<%1', CH."Calculation Date To");
                    CAlJournal2.SetFilter(Locked, '%1', true);
                    CAlJournal2.SetFilter(Gauge, '%1', cjl.Gauge);
                    CAlJournal2.SetFilter("Corrector Code", '%1', CJL."Corrector Code");
                    CAlJournal2.SetFilter("Measuring Point Code", '%1', CJL."Measuring Point Code");
                    CAlJournal2.SetCurrentKey("Reading Date To");
                    CAlJournal2.Ascending;
                    if CAlJournal2.FindLast() then begin
                        CJL."Previous Date" := CAlJournal2."Calculation Date To";
                        CJL."Pressure previous - gauge" := CAlJournal2."Pressure new- gauge";
                        CJL."Temperature previous - gauge" := CAlJournal2."Temperature new- gauge";
                        CJL."Correction previous - gauge" := CAlJournal2."Correction new- gauge";
                        CJL."UnCorrection previous - gauge" := CAlJournal2."UnCorrection new- gauge";

                    end;

                    if (CalSetup."Subsidies Date from" <> 0D) and (CalSetup."Subsidies Date to" = 0D)
                    and (CH."Calculation Date To" >= CalSetup."Subsidies Date from") then
                        Subs := true;

                    if (CalSetup."Subsidies Date from" <> 0D) and (CalSetup."Subsidies Date to" <> 0D)
                   and (cjl."Reading Date To" <= CalSetup."Subsidies Date to")
                   and (cjl."Reading Date From" >= CalSetup."Subsidies Date From") then
                        Subs := true;





                    CustomerPrice.Reset();
                    CustomerPrice.SetFilter("No.", '%1', CJL."Customer No.");
                    if CustomerPrice.FindFirst() then begin
                        if (CustomerPrice."Subsidies - YES/NO" = CustomerPrice."Subsidies - YES/NO"::Yes) and (Subs = true) then begin
                            CJL."Deminimis Act Date" := CalSetup."Deminimis Act Date";
                            CJL."Deminimis Act Name" := CalSetup."Deminimis Act Name";
                            CJL."Deminimis Act Number" := CalSetup."Deminimis Act Number";
                            CJL."Deminimis Legal act" := CalSetup."Deminimis Legal act";
                            CJL."Deminimis Purpose" := CalSetup."Deminimis Purpose";
                            CJL."Deminimis Remark" := CalSetup."Deminimis Remark";


                        end
                        else begin

                            CJL."Deminimis Act Date" := 0D;
                            CJL."Deminimis Act Name" := '';
                            CJL."Deminimis Act Number" := '';
                            CJL."Deminimis Legal act" := '';
                            CJL."Deminimis Purpose" := '';
                            CJL."Deminimis Remark" := '';
                        end;

                    end;

                    Gaug2.Reset();
                    Gaug2.SetFilter(Code, '%1', Gauge2.Code);
                    if Gaug2.FindFirst() then
                        cjl."Serial Number" := Gaug2."Inventar number";

                    iHC.Reset();
                    iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                    iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                    iHC.SetFilter(Active, '%1', true);
                    if iHC.FindFirst() then begin
                        cjl."EL Volume Code" := iHC.Code;
                        CJl."EL Volume Description" := iHC."EL Volume Description";
                    end;

                    CJL.Insert();

                end;

            until Gauge2.Next() = 0;

    end;



    var
        myInt: Integer;
        CH: Record "Calcuation Header";
        Gauge2: Record Gauge;
        MM: Record "Service Item";
        CU: Record Customer;
        CJL: Record "Calculation Journal Line";
}