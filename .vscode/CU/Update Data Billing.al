codeunit 50024 "Update Data Billing"
{
    trigger OnRun()
    begin




    end;

    procedure UpdateCustomerData(CustomerR: Record Customer)
    var
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        FloorInt: Integer;
        AparmentInt: Integer;
    begin


        CH.Reset();
        CH.SetFilter(status, '%1', ch.Status::Open);
        ch.SetFilter("Category Calculation", '%1', CustomerR."Customer Category");
        if ch.FindFirst() then begin

            if Today <= ch."Calculation Date To" then begin
                CJL.Reset();
                CJL.SetFilter("Customer No.", '%1', CustomerR."No.");
                CJL.SetFilter(Locked, '%1', false);
                cjl.SetFilter(Code, '%1', ch.Code);
                if cjl.FindSet() then
                    repeat

                        CustomerR.CalcFields("MZ Name Customer", "MZ Name Customer 2", "Street Name Customer", "Street Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2");
                        CJL."Post Code Customer" := CustomerR."Post Code";
                        cjl.Agreement := CustomerR.Agreement;
                        cjl."Bill distribution percentage" := CustomerR."Bill distribution percentage";
                        CJL."E-Mail 2" := CustomerR."E-Mail 2";
                        CJL."E-mail Delivery" := CustomerR."E-mail Delivery";
                        cjl."Address Customer" := CustomerR.Address;
                        cjl."Address 2" := CustomerR."Address 2";
                        cjl."E-mail Delivery Date" := CustomerR."E-mail Delivery Date";
                        CJL."E-mail Delivery Date to" := CustomerR."E-mail Delivery Date to";
                        CJL."Post Code Customer D." := CustomerR."Post Code 2";
                        CJL."City Customer" := CustomerR.City;
                        CJL."City Customer D." := CustomerR."City 2";
                        cjl."Customer string" := CustomerR."Customer String";
                        cjl."Customer String 2" := CustomerR."Customer String 2";
                        cjl."Customer Stroke" := CustomerR."Customer Stroke";
                        cjl."Customer Stroke 2" := CustomerR."Customer Stroke 2";
                        cjl."Zone stroke" := CustomerR."Zone stroke";
                        cjl."Zone stroke 2" := CustomerR."Zone stroke 2";
                        cjl."MZ Customer" := CustomerR."MZ Customer";
                        cjl."MZ Customer 2" := CustomerR."MZ Customer 2";
                        cjl."MZ Name Customer" := CustomerR."MZ Name Customer";
                        cjl."MZ Name Customer 2" := CustomerR."MZ Name Customer 2";
                        cjl."Floor Customer" := CustomerR."Floor Customer";
                        cjl."Floor Customer 2" := CustomerR."Floor Customer 2";
                        cjl."Street Customer" := CustomerR."Street Customer";
                        cjl."Street Customer 2" := CustomerR."Street Customer 2";
                        cjl."Street Name Customer" := CustomerR."Street Name Customer";
                        cjl."Street Name Customer 2" := CustomerR."Street Name Customer 2";
                        cjl."Municipality Code Customer" := CustomerR."Municipality Code Customer";
                        cjl."Municipality Code Customer 2" := CustomerR."Municipality Code Customer 2";
                        cjl."Municipality Name Customer" := CustomerR."Municipality Name Customer";
                        cjl."Municipality Name Customer 2" := CustomerR."Municipality Name Customer 2";
                        cjl."Street No." := CustomerR."Street No.";
                        cjl."Street No. 2" := CustomerR."Street No. 2";
                        cjl."Street No.2 Text" := CustomerR."Street No.2 Text";
                        cjl."Street No. Text" := CustomerR."Street No. Text";
                        if Evaluate(AparmentInt, CustomerR."Apartment No. Customer") then
                            CJL."Street No. Text Apartment" := AparmentInt
                        else
                            CJL."Street No. Text Apartment" := 0;


                        CJL."Apartment No. Customer 2" := CustomerR."Apartment No. Customer 2";

                        CJL."Apartment No. Customer" := CustomerR."Apartment No. Customer";

                        if Evaluate(FloorInt, CustomerR."Floor Customer") then
                            CJL."Street No. Text int" := FloorInt
                        else
                            CJL."Street No. Text int" := 0;
                        SalesPr.Reset();
                        SalesPr.SetFilter("Item No.", '%1', Csetup."Item No. 2");
                        SalesPr.SetFilter("Sales Code", '%1', CustomerR."Customer Price Group");
                        SalesPr.SetFilter("Starting Date", '<=%1', cjl."Reading Date To");
                        SalesPr.SetCurrentKey("Starting Date");
                        SalesPr.Ascending;
                        if SalesPr.FindLast() then begin
                            cjl."Purchase Unit Price" := SalesPr."Purchase unit price";
                            cjl."Distribution Unit Price" := SalesPr."Unit price of distribution";
                            cjl."Sales Unit Price" := SalesPr."Unit Price";
                            cjl."Unit Price" := SalesPr."Unit Price";
                        end
                        else begin

                            cjl."Purchase Unit Price" := 0;
                            cjl."Distribution Unit Price" := 0;
                            cjl."Sales Unit Price" := 0;
                            cjl."Unit Price" := 0;

                        end;

                        CustomerLedgerEntry.Reset();
                        CustomerLedgerEntry.SetFilter("Customer No.", '%1', CustomerR."No.");
                        CustomerLedgerEntry.SetFilter("Bill Type", '%1|%2|%3', '01', '02', '03');
                        CustomerLedgerEntry.SetFilter(Prepayment, '%1', false);
                        CustomerLedgerEntry.SetFilter(Open, '%1', true);

                        if CustomerLedgerEntry.FindSet() then
                            repeat
                                CustomerLedgerEntry.calcfields("Remaining Amt. (LCY)");

                                RezDecimal += CustomerLedgerEntry."Remaining Amt. (LCY)";


                            until CustomerLedgerEntry.Next() = 0;

                        if RezDecimal > 0 then
                            cjl."Customer Balance" := RezDecimal
                        else
                            cjl."Customer Prepayment" := abs(RezDecimal);

                        CJL."Customer Name" := CustomerR.Name + CustomerR."Name 2";
                        cjl."Registration No." := CustomerR."Registration No.";
                        CJL."VAT Registration No." := CustomerR."VAT Registration No.";
                        CJL."Customer string" := CustomerR."Customer String";
                        cjl."Customer Stroke" := CustomerR."Customer Stroke";
                        cjl."MZ Customer" := CustomerR."MZ Customer";
                        cjl."Floor Customer" := CustomerR."Floor Customer";
                        cjl."Street Customer" := CustomerR."Street Customer";
                        cjl."Address Customer" := CustomerR.Address;
                        cjl."MZ Name Customer" := CustomerR."MZ Name Customer";
                        cjl."Category Customer" := CustomerR."Customer Category";
                        cjl."Home No. Customer" := CustomerR."Home No. Customer";
                        cjl."Address 2" := CustomerR."Address 2";
                        cjl."Street Customer 2" := CustomerR."Street Customer 2";
                        CustomerR.CalcFields("Street Name Customer 2");
                        cjl."Street Name Customer 2" := CustomerR."Street Name Customer 2";


                        cjl."Street Name Customer" := CustomerR."Street Name Customer";
                        cjl."Municipality Code Customer" := CustomerR."Municipality Code Customer";
                        CustomerR.CalcFields("Municipality Name Customer");
                        cjl."Municipality Name Customer" := CustomerR."Municipality Name Customer";
                        cjl.Difference := cjl."New Value" - cjl."Old Value";
                        cjl.Modify();


                    until cjl.Next() = 0;

            end;
        end;
    end;


    procedure StatusUpdate(StatusHistory: Record "Status History MM")
    var
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
        MM: Record "Service Item";
    begin
        CH.Reset();
        CH.SetFilter(status, '%1', ch.Status::Open);
        if MM.get(StatusHistory."Measuring Point") then begin
            ch.SetFilter("Category Calculation", '%1', MM."Customer Category");
            if ch.FindFirst() then begin

                if Today <= ch."Calculation Date To" then begin
                    CJL.Reset();
                    CJL.SetFilter("Measuring Point Code", '%1', MM."No.");
                    CJL.SetFilter(Locked, '%1', false);
                    cjl.SetFilter(Code, '%1', ch.Code);
                    if cjl.FindSet() then
                        repeat
                            cjl."Current Status MM" := StatusHistory."Information of processing";
                            cjl."Status MM" := StatusHistory."Information of processing";
                            cjl.Difference := cjl."New Value" - cjl."Old Value";
                            cjl.Modify();

                        until cjl.next = 0;
                end;
            end;
        end;
    end;



    procedure UpdateMMData(ServiceItem: Record "Service Item")
    var
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
    begin
        CH.Reset();
        CH.SetFilter(status, '%1', ch.Status::Open);
        ch.SetFilter("Category Calculation", '%1', ServiceItem."Customer Category");
        if ch.FindFirst() then begin

            if Today <= ch."Calculation Date To" then begin
                CJL.Reset();
                CJL.SetFilter("Measuring Point Code", '%1', ServiceItem."No.");
                CJL.SetFilter(Locked, '%1', false);
                cjl.SetFilter(Code, '%1', ch.Code);
                if cjl.FindSet() then
                    repeat


                        ServiceItem.SetAutoCalcFields("Street Name MM", "Municipality Name MM", "MZ Name MM", "Street Name MM", "Municipality Name MM", "Status MM");
                        cjl."Adjusted Pressure" := ServiceItem."Adjusted Pressure";
                        cjl."Pressure Date" := ServiceItem."Pressure Date";


                        //   ServiceItem.CalcFields("Street Name MM", "Municipality Name MM");

                        CJL."Address MM" := ServiceItem.Address;
                        cjl."Street MM" := ServiceItem.Street;
                        if ServiceItem."Control Number" <> '' then
                            cjl.Agreement := ServiceItem."Control Number";



                        //  ServiceItem.CalcFields("MZ Name MM", "Street Name MM", "Municipality Name MM");

                        if Evaluate(MMStreetInt, ServiceItem."Street No.") then
                            CJL."Street No. Int MM" := MMStreetInt
                        else
                            CJL."Street No. Int MM" := 0;

                        ServiceItem.CalcFields("Post Code");
                        CJL."Post Code MM" := ServiceItem."Post Code";
                        ServiceItem.CalcFields(City);
                        CJL."City MM" := ServiceItem.City;
                        cjl."Street No. Text MM" := ServiceItem."Street No. Text";
                        ServiceItem.CalcFields("Status MM");

                        cjl."Status MM" := ServiceItem."Status MM";
                        cjl."Current Status MM" := ServiceItem."Status MM";
                        cjl.Activity := ServiceItem.Activity;
                        cjl."EF Activity" := ServiceItem."EF Activity";
                        cjl."EU Activity" := ServiceItem.Activity;


                        cjl."Measuring point off" := ServiceItem."Measuring point off";
                        cjl."Measuring point off Date" := ServiceItem."Measuring point off Date";
                        cjl."Street Name MM" := ServiceItem."Street Name MM";
                        if Evaluate(StreetInt, ServiceItem."Street No.") then begin
                            cjl."Street No. int" := StreetInt;
                        end
                        else begin
                            cjl."Street No. int" := 0;
                        end;


                        cjl.Floor := ServiceItem.Floor;
                        cjl."Address MM" := ServiceItem."Address MM";
                        cjl."Measuring Point string" := ServiceItem."Measuring Point string";
                        cjl."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                        CJL."Apartment No." := ServiceItem."Apartment No.";
                        cjl."Municipality Code MM" := ServiceItem."Municipality Code MM";
                        CJL."Municipality Name MM" := ServiceItem."Municipality Name MM";
                        cjl."Zone stroke MM" := ServiceItem."Zone stroke";

                        cjl."Summer Zone" := ServiceItem."Summer Zone";
                        cjl."Winter Zone" := ServiceItem."Winter Zone";
                        cjl."Measuring Zone - summer" := ServiceItem."Measuring Zone - summer";
                        cjl."Measuring Zone - winter" := ServiceItem."Measuring Zone - winter";
                        CJL."MM Description" := ServiceItem.Description + ServiceItem."Description 2";
                        cjl."Reading Mode" := ServiceItem."Reading Mode";
                        CJL."Mobile No." := ServiceItem."Mobile No.";
                        cjl."Fictitious Code" := ServiceItem."Fictitious Code";


                        cjl."Type of reading" := ServiceItem."Type of reading";
                        cjl."Reading Time" := ServiceItem."Reading Time";
                        if cjl."Reading Time" = cjl."Reading Time"::"Per Year" then
                            cjl."Source Data" := cjl."Source Data"::"Per Year";

                        cjl.Posting := ServiceItem.Posting;
                        cjl.Distribution := ServiceItem.Distribution;
                        cjl."Distribution - read" := ServiceItem."Distribution - read";
                        cjl.Specification := ServiceItem.Specification;
                        cjl."Bill delivery" := ServiceItem."Bill delivery";
                        cjl."RMS Maintenance" := ServiceItem."RMS Maintenance";
                        cjl."Winter Zone" := ServiceItem."Winter Zone";
                        CJL."Remotely Type" := ServiceItem."Remotely Type";
                        cjl."Transit Zone" := ServiceItem."Transit Zone";
                        cjl.Floor := ServiceItem.Floor;
                        cjl."Apartment No." := ServiceItem."Apartment No.";
                        cjl."Home No." := ServiceItem."Home No.";

                        cjl."Category Customer" := ServiceItem."Customer Category";
                        cjl."Category MM" := ServiceItem."MM Category";
                        cjl."Customer No." := ServiceItem."Customer No.";
                        cjl."MZ Customer" := ServiceItem."MZ Customer";
                        cjl."MZ Name Customer" := ServiceItem."MZ Name Customer";
                        CJL."MM Description" := ServiceItem.Description + ServiceItem."Description 2";
                        cjl."Method of calculation" := ServiceItem."Method of calculation";
                        cjl."MZ MM" := ServiceItem."MZ MM";
                        cjl."MZ Name MM" := ServiceItem."MZ Name MM";
                        cjl.Difference := cjl."New Value" - cjl."Old Value";
                        cjl.Modify();
                    until cjl.Next = 0;

            end;
        end;
    end;

    procedure UpdateGaugeData(GG: Record Gauge)
    var
        GaugeG: Record gauge;
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
    begin

        CH.Reset();
        CH.SetFilter(status, '%1', ch.Status::Open);
        if ch.FindSet() then
            repeat

                if Today <= ch."Calculation Date To" then begin
                    CJL.Reset();
                    CJL.SetFilter(Gauge, '%1', GG.Code);
                    CJL.SetFilter(Locked, '%1', false);
                    cjl.SetFilter(Code, '%1', ch.Code);
                    if cjl.FindSet() then
                        repeat
                            cjl."Gauge Size" := gg."Gauge Size";
                            cjl."Serial Number" := gg."Inventar number";
                            cjl.Difference := cjl."New Value" - cjl."Old Value";
                            cjl.Modify();
                        until cjl.Next() = 0;
                end;
            until ch.Next() = 0;


    end;

    procedure UpdateCorrectorData(CC: Record "El. Volume Corr")
    var
        CC_Record: Record "El. Volume Corr";
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
        CodeC: Integer;
    begin

        CH.Reset();
        CH.SetFilter(status, '%1', ch.Status::Open);
        if ch.FindSet() then
            repeat

                if Today <= ch."Calculation Date To" then begin

                    CJL.Reset();
                    if Evaluate(CodeC, CC.Code) then begin
                        CJL.SetFilter("Corrector Code", '%1', CodeC);
                        CJL.SetFilter(Locked, '%1', false);
                        cjl.SetFilter(Code, '%1', ch.Code);
                        if cjl.FindSet() then
                            repeat
                                cjl."EL Correctior Type" := CC.Model;
                                cjl."EL Volume Description" := CC."Serial Number";
                                cjl.Difference := cjl."New Value" - cjl."Old Value";
                                cjl.Modify();

                            until cjl.Next() = 0;
                    end;
                end;
            until ch.Next() = 0;

    end;

    procedure UpdateGaugeChangeDismantling(CC: Record "Installation History"; ServiceItemNw: record "Service Item Line")
    var
        CC_Record: Record "El. Volume Corr";
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
        CodeC: Integer;
        CorrectorInt: Integer;
    begin
        //ako je nova došla zamjena i postala kao aktivna, prethodna mora biti nevažeća

        //mogla je prvo doći demontaža, pa onda montaža (možda bi trebalo kod one apliciraj promjene to pozvati)

        if (cc."Dismantling date" <> 0D) and (cc.Type = cc.Type::Gauge) and (CC."CUstomer no." <> '') then begin
            //ovo je stari mjerač 
            CH.Reset();
            CH.SetFilter(status, '%1', ch.Status::Open);
            CH.SetFilter("Calculation Date To", '>=%1', CC."Dismantling date");
            if ch.FindSet() then
                repeat



                    CJL.Reset();
                    CJL.SetFilter(Locked, '%1', false);
                    cjl.SetFilter(Code, '%1', ch.Code);
                    cjl.SetFilter("Customer No.", '%1', CC."Customer No.");
                    cjl.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");
                    cjl.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                    cjl.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation");
                    cjl.SetFilter(Gauge, '%1', cc.Code);
                    if cjl.FindSet() then
                        repeat
                            cjl."Reading Date To" := CC."Dismantling date";
                            cjl.Validate("Old Gauge", true);
                            cjl."Source Data" := cjl."Source Data"::Manual;


                            cjl.validate("New Value", ServiceItemNw.Reading);

                            cjl.validate("Temperature new- gauge", ServiceItemNw.Temperature);
                            cjl.validate("UnCorrection new- gauge", ServiceItemNw."Unadjusted Volume");
                            cjl.validate("Correction new- gauge", ServiceItemNw."Adjusted Volume");

                            cjl.Difference := cjl."New Value" - cjl."Old Value";

                            cjl.Modify();
                        until cjl.Next() = 0;
                until ch.Next() = 0;
        end
        else begin
            //ako je korektor, samo ću zamijeniti korektor

            CH.Reset();
            CH.SetFilter(status, '%1', ch.Status::Open);
            CH.SetFilter("Calculation Date To", '>=%1', CC."Dismantling date");
            if ch.FindSet() then
                repeat



                    CJL.Reset();
                    CJL.SetFilter(Locked, '%1', false);
                    cjl.SetFilter(Code, '%1', ch.Code);
                    cjl.SetFilter("Customer No.", '%1', CC."Customer No.");
                    cjl.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");
                    cjl.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                    cjl.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation");
                    if Evaluate(CorrectorInt, cc.Code) then begin
                        cjl.SetFilter("Corrector Code", '%1', CorrectorInt);
                        if cjl.FindSet() then
                            repeat
                                //      cjl."Reading Date To" := CC."Dismantling date";
                                //    cjl.Validate("Old Gauge", true);



                                cjl.validate("New Value", ServiceItemNw.Reading);

                                cjl.validate("Temperature new- gauge", ServiceItemNw.Temperature);
                                cjl.validate("UnCorrection new- gauge", ServiceItemNw."Unadjusted Volume");
                                cjl.validate("Correction new- gauge", ServiceItemNw."Adjusted Volume");


                                cjl.Difference := cjl."New Value" - cjl."Old Value";
                                cjl.Modify();
                            until cjl.Next() = 0;
                    end;
                until ch.Next() = 0;

            //kraj
        end;
    end;

    procedure UpdateGaugeChangeInstalling(CC: Record "Installation History"; ServiceItemNw: record "Service Item Line")
    var
        CC_Record: Record "El. Volume Corr";
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
        CodeC: Integer;
        CJLNew: Record "Calculation Journal Line";
        GGF: Record gauge;
        CJLUnReadBefore: Record "Calculation Journal Line";
        CJLUnReadBefore2: Record "Calculation Journal Line";
        CJLNewExs: Record "Calculation Journal Line";
    begin
        //ako je nova došla zamjena i postala kao aktivna, prethodna mora biti nevažeća

        //mogla je prvo doći demontaža, pa onda montaža (možda bi trebalo kod one apliciraj promjene to pozvati)
        if (cc."Installation Date" <> 0D) and (cc.Type = cc.Type::Gauge) and (CC."CUstomer no." <> '') then begin
            CH.Reset();
            CH.SetFilter(status, '%1', ch.Status::Open);
            ch.SetFilter("Calculation Date To", '>=%1', cc."Installation Date");

            if ch.FindSet() then
                repeat
                    CJL.Reset();
                    CJL.SetFilter(Locked, '%1', false);
                    cjl.SetFilter(Code, '%1', ch.Code);
                    cjl.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                    cjl.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation");
                    cjl.SetFilter("Customer No.", '%1', CC."Customer No.");
                    cjl.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");

                    if cjl.FindSet() then
                        repeat
                            CJLNew.Init();
                            CJLNew.TransferFields(CJL);
                            CJLNew.Validate(Gauge, cc.Code);
                            CJLNew.Validate("New Gauge", true);
                            GGF.reset;
                            GGF.SetFilter(code, '%1', cc.Code);
                            if ggF.FindFirst() then begin
                                CJLNew.validate("Gauge Size", ggf."Gauge Size");
                                CJLNew."Serial Number" := ggf."Inventar number";
                            end;
                            //vrijednosti trebam dodati
                            CJLNew."Reading Date From" := CC."Installation Date";
                            CJLNew."Reading Date To" := ch."Calculation Date To";

                            CJLNew.validate("New Value", ServiceItemNw."Reading New");

                            CJLNew.validate("Temperature new- gauge", ServiceItemNw."Temperature New");
                            CJLNew.validate("UnCorrection new- gauge", ServiceItemNw."Unadjusted Volume New");
                            CJLNew.validate("Correction new- gauge", ServiceItemNw."Adjusted Volume New");

                            //sa

                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', Gauge2.Code);
                            CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', CJLNew."Measuring Point Code");
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', CJLNew."Calculation Date To");
                            CJLUnReadBefore.SetFilter(code, '<>%1', CJLNew.Code);
                            CJLUnReadBefore.SetCurrentKey(Difference);
                            CJLUnReadBefore.Ascending;
                            if CJLUnReadBefore.FindLast()
                             then begin
                                CJLNew."Max Difference" := CJLUnReadBefore.Difference;
                            end;

                            /*  CJLUnReadBefore.Reset();
                              //   CJLUnReadBefore.SetFilter(Gauge, '%1', Gauge2.Code);
                              CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                              CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', Rec."Calculation Date To");
                              CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                              CJLUnReadBefore.SetCurrentKey(Difference);
                              CJLUnReadBefore.Ascending;
                              if CJLUnReadBefore.FindLast()
                               then begin
                                  //   CJLUnReadBefore.CalcSums(CJLUnReadBefore."New Value");
                                  Rec."Old Value" := CJLUnReadBefore."New Value";
                                  Rec."Previous Date" := CJLUnReadBefore."Calculation Date To";
                                  Rec."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                              end;*/
                            //dodala djemina
                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            CJLUnReadBefore.SetFilter(Gauge, '%1', CJLNew.Gauge);
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', CJLNew."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', CJLNew.Code);
                            CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending;
                            if CJLUnReadBefore.FindLast()
                             then begin
                                CJLNew."Old Value" := CJLUnReadBefore."New Value";

                            end
                            else begin
                                CJLNew."Old Value" := 0;
                            end;

                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            CJLUnReadBefore.SetFilter(Gauge, '%1', CJLNew.Gauge);
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', CJLNew."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', CJLNew.Code);
                            //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending;
                            if CJLUnReadBefore.FindLast()
                             then begin
                                //  cjl."Old Value" := CJLUnReadBefore."Old Value";
                                CJLNew."Previous Date" := CJLUnReadBefore."Reading Date To";
                                CJLNew."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                CJLNew."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                CJLNew."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                CJLNew."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                CJLNew."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                CJLNew."Method of calculation" := CJLUnReadBefore."Method of calculation";
                            end
                            else begin


                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', CJLNew."Measuring Point Code");
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', CJLNew."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', CJLNew.Code);
                                CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending;
                                if CJLUnReadBefore.FindLast()
                                 then begin
                                    CJLNew."Old Value" := CJLUnReadBefore."New Value";

                                end
                                else begin
                                    CJLNew."Old Value" := 0;
                                end;

                                CJLUnReadBefore.Reset();
                                CJLUnReadBefore.SetFilter(Gauge, '%1', CJLNew.Gauge);
                                //    CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', CJLNew."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', CJLNew.Code);
                                //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending;
                                if CJLUnReadBefore.FindLast()
                                 then begin
                                    // cjl."Old Value" := CJLUnReadBefore."Old Value";
                                    CJLNew."Previous Date" := CJLUnReadBefore."Reading Date To";
                                    CJLNew."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                    CJLNew."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                    CJLNew."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                    CJLNew."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                    CJLNew."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                    CJLNew."Method of calculation" := CJLUnReadBefore."Method of calculation";
                                end
                                else begin
                                    CJLNew."Previous Date" := 0D;
                                    CJLNew."Previous method of calculation" := CJLUnReadBefore."Method of calculation"::"1";
                                    CJLNew."Temperature previous - gauge" := 0;
                                    CJLNew."Pressure previous - gauge" := 0;
                                    CJLNew."UnCorrection previous - gauge" := 0;
                                    CJLNew."Correction previous - gauge" := 0;
                                    CJLNew."Method of calculation" := CJLNew."Method of calculation"::"1";
                                end;


                            end;
                            //ispravka
                            CJLNewExs.Reset();
                            CJLNewExs.SetFilter("Customer No.", '%1', CJLNew."Customer No.");
                            CJLNewExs.SetFilter("Measuring Point Code", '%1', CJLNew."Measuring Point Code");
                            CJLNewExs.SetFilter(gauge, '%1', CJLNew."Gauge");
                            CJLNewExs.SetFilter("Code", '%1', CJLNew."COde");
                            if not CJLNewExs.FindFirst() then begin
                                CJLNew.Difference := CJLNew."New Value" - CJLNew."Old Value";
                                CJLNew.Insert();
                            end;
                        until cjl.Next() = 0;
                until ch.Next() = 0;
        end;

    end;

    procedure UpdateDeleteGaug(CC: Record "Installation History")
    var
        CC_Record: Record "El. Volume Corr";
        CustomerC: Record Customer;
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
        CodeC: Integer;
        CJLNew: Record "Calculation Journal Line";
        CJLPrev: Record "Calculation Journal Line";
        ELVolumene: Record "El. Volume Corr";
        Correctori: Integer;
    begin
        //ako je nova došla zamjena i postala kao aktivna, prethodna mora biti nevažeća

        //mogla je prvo doći demontaža, pa onda montaža (možda bi trebalo kod one apliciraj promjene to pozvati)
        //novi mjerač sam brisala, prema tome trebam obrisati to kao novi mjerač
        if (cc."Installation Date" <> 0D) and (cc.Type = cc.Type::Gauge) and (CC."CUstomer no." <> '') then begin
            CH.Reset();
            CH.SetFilter(status, '%1', ch.Status::Open);
            ch.SetFilter("Calculation Date To", '>=%1', cc."Installation Date");

            if ch.FindSet() then
                repeat
                    CJL.Reset();
                    CJL.SetFilter(Locked, '%1', false);
                    cjl.SetFilter(Code, '%1', ch.Code);
                    cjl.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                    cjl.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation");
                    cjl.SetFilter("Customer No.", '%1', CC."Customer No.");
                    cjl.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");
                    cjl.SetFilter("New Gauge", '%1', true);
                    cjl.SetFilter(Gauge, '%1', cc.Code);

                    if cjl.FindSet() then
                        repeat
                            CJL.Delete();

                            CJLPrev.Reset();
                            CJLPrev.SetFilter(Locked, '%1', false);
                            CJLPrev.SetFilter(Code, '%1', ch.Code);
                            CJLPrev.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                            CJLPrev.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation");
                            CJLPrev.SetFilter("Customer No.", '%1', CC."Customer No.");
                            CJLPrev.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");
                            CJLPrev.SetFilter("Old Gauge", '%1', true);
                            if CJLPrev.FindFirst() then begin
                                CJLPrev.Validate("Old Gauge", false);
                                cjlprev.Validate("Reading Date To", ch."Calculation Date To");
                                cjlprev.Difference := cjlprev."New Value" - cjlprev."Old Value";
                                CJLPrev.Modify();
                            end;
                        until cjl.Next() = 0;
                until ch.Next() = 0;
        end
        else begin

            //da dodam trenutno važeći korektor i to je to
            CH.Reset();
            CH.SetFilter(status, '%1', ch.Status::Open);
            ch.SetFilter("Calculation Date To", '>=%1', cc."Installation Date");

            if ch.FindSet() then
                repeat

                    CJLPrev.Reset();
                    CJLPrev.SetFilter(Locked, '%1', false);
                    CJLPrev.SetFilter(Code, '%1', ch.Code);
                    CJLPrev.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                    CJLPrev.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation");
                    CJLPrev.SetFilter("Customer No.", '%1', CC."Customer No.");
                    CJLPrev.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");
                    if CJLPrev.FindFirst() then begin
                        ELVolumene.Reset();
                        ELVolumene.SetFilter("Measuring Point", '%1', CJLPrev."Measuring Point Code");
                        ELVolumene.SetFilter("Customer No.", '%1', CJLPrev."Customer No.");
                        if ELVolumene.FindFirst() then begin
                            if Evaluate(Correctori, ELVolumene.Code) then begin
                                cjl.Validate("Corrector Code", Correctori);
                                cjl."EL Volume Code" := ELVolumene.Code;
                                cjl."EL Volume Description" := ELVolumene."Serial Number";
                                cjl."EL Correctior Type" := ELVolumene.Model;
                                cjl.Validate("Reading Date To", ch."Calculation Date To");
                                cjl.Difference := cjl."New Value" - cjl."Old Value";
                                cjl.Modify();

                            end;

                        end;
                    end;
                until ch.Next() = 0;

        end;

    end;


    procedure InsertNewFirst(CC: Record "Installation History")
    var
        CC_Record: Record "El. Volume Corr";
        CustomerC: Record Customer;
        FloorInt: Integer;
        AparmentInt: Integer;
        ELVOlume: Record "El. Volume Corr";
        CH: Record "Calcuation Header";
        CJL: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        StreetInt: Integer;
        CodeC: Integer;
        CJLNew: Record "Calculation Journal Line";
        CHStatus: text;
        CustomerR: Record Customer;
        ServiceItem: Record "Service Item";
        gg: Record Gauge;
    begin
        CHStatus := '';

        CH.Reset();
        CH.SetFilter(status, '%1', ch.Status::Open);
        if ch.FindSet() then
            repeat
                CHStatus += ch.Code + '|';

            until ch.Next() = 0;
        if StrLen(CHStatus) > 2 then begin
            CHStatus := CopyStr(CHStatus, 1, StrLen(CHStatus) - 1);
        end;


        CJL.Reset();
        CJL.SetFilter(Locked, '%1', false);
        cjl.SetFilter(Code, CHStatus);
        cjl.SetFilter("Customer No.", '%1', CC."Customer No.");
        cjl.SetFilter("Measuring Point Code", '%1', cc."Measuring Point Code");
        if not cjl.FindFirst() then begin
            cjl.Init();
            CustomerR.Reset();
            CustomerR.SetFilter("No.", '%1', cc."Customer No.");
            if CustomerR.FindFirst() then begin

                CustomerR.CalcFields("MZ Name Customer", "MZ Name Customer 2", "Street Name Customer", "Street Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2");
                CJL."Post Code Customer" := CustomerR."Post Code";
                cjl.Agreement := CustomerR.Agreement;
                cjl."Bill distribution percentage" := CustomerR."Bill distribution percentage";
                CJL."E-Mail 2" := CustomerR."E-Mail 2";
                CJL."E-mail Delivery" := CustomerR."E-mail Delivery";
                cjl."Address Customer" := CustomerR.Address;
                cjl."Address 2" := CustomerR."Address 2";
                cjl."E-mail Delivery Date" := CustomerR."E-mail Delivery Date";
                CJL."E-mail Delivery Date to" := CustomerR."E-mail Delivery Date to";
                CJL."Post Code Customer D." := CustomerR."Post Code 2";
                CJL."City Customer" := CustomerR.City;
                CJL."City Customer D." := CustomerR."City 2";
                cjl."Customer string" := CustomerR."Customer String";
                cjl."Customer String 2" := CustomerR."Customer String 2";
                cjl."Customer Stroke" := CustomerR."Customer Stroke";
                cjl."Customer Stroke 2" := CustomerR."Customer Stroke 2";
                cjl."Zone stroke" := CustomerR."Zone stroke";
                cjl."Zone stroke 2" := CustomerR."Zone stroke 2";
                cjl."MZ Customer" := CustomerR."MZ Customer";
                cjl."MZ Customer 2" := CustomerR."MZ Customer 2";
                cjl."MZ Name Customer" := CustomerR."MZ Name Customer";
                cjl."MZ Name Customer 2" := CustomerR."MZ Name Customer 2";
                cjl."Floor Customer" := CustomerR."Floor Customer";
                cjl."Floor Customer 2" := CustomerR."Floor Customer 2";
                cjl."Street Customer" := CustomerR."Street Customer";
                cjl."Street Customer 2" := CustomerR."Street Customer 2";
                cjl."Street Name Customer" := CustomerR."Street Name Customer";
                cjl."Street Name Customer 2" := CustomerR."Street Name Customer 2";
                cjl."Municipality Code Customer" := CustomerR."Municipality Code Customer";
                cjl."Municipality Code Customer 2" := CustomerR."Municipality Code Customer 2";
                cjl."Municipality Name Customer" := CustomerR."Municipality Name Customer";
                cjl."Municipality Name Customer 2" := CustomerR."Municipality Name Customer 2";
                cjl."Street No." := CustomerR."Street No.";
                cjl."Street No. 2" := CustomerR."Street No. 2";
                cjl."Street No.2 Text" := CustomerR."Street No.2 Text";
                cjl."Street No. Text" := CustomerR."Street No. Text";
                if Evaluate(AparmentInt, CustomerR."Apartment No. Customer") then
                    CJL."Street No. Text Apartment" := AparmentInt
                else
                    CJL."Street No. Text Apartment" := 0;


                if Evaluate(FloorInt, CustomerR."Floor Customer") then
                    CJL."Street No. Text int" := FloorInt
                else
                    CJL."Street No. Text int" := 0;

                CJL."Apartment No. Customer 2" := CustomerR."Apartment No. Customer 2";

                CJL."Apartment No. Customer" := CustomerR."Apartment No. Customer";

                SalesPr.Reset();
                SalesPr.SetFilter("Item No.", '%1', Csetup."Item No. 2");
                SalesPr.SetFilter("Sales Code", '%1', CustomerR."Customer Price Group");
                SalesPr.SetFilter("Starting Date", '<=%1', cjl."Reading Date To");
                SalesPr.SetCurrentKey("Starting Date");
                SalesPr.Ascending;
                if SalesPr.FindLast() then begin
                    cjl."Purchase Unit Price" := SalesPr."Purchase unit price";
                    cjl."Distribution Unit Price" := SalesPr."Unit price of distribution";
                    cjl."Sales Unit Price" := SalesPr."Unit Price";
                    cjl."Unit Price" := SalesPr."Unit Price";
                end
                else begin

                    cjl."Purchase Unit Price" := 0;
                    cjl."Distribution Unit Price" := 0;
                    cjl."Sales Unit Price" := 0;
                    cjl."Unit Price" := 0;

                end;

                CustomerLedgerEntry.Reset();
                CustomerLedgerEntry.SetFilter("Customer No.", '%1', CustomerR."No.");
                CustomerLedgerEntry.SetFilter("Bill Type", '%1|%2|%3', '01', '02', '03');
                CustomerLedgerEntry.SetFilter(Prepayment, '%1', false);
                CustomerLedgerEntry.SetFilter(Open, '%1', true);

                if CustomerLedgerEntry.FindSet() then
                    repeat
                        CustomerLedgerEntry.calcfields("Remaining Amt. (LCY)");

                        RezDecimal += CustomerLedgerEntry."Remaining Amt. (LCY)";


                    until CustomerLedgerEntry.Next() = 0;

                if RezDecimal > 0 then
                    cjl."Customer Balance" := RezDecimal
                else
                    cjl."Customer Prepayment" := abs(RezDecimal);

                CJL."Customer Name" := CustomerR.Name + CustomerR."Name 2";
                cjl."Registration No." := CustomerR."Registration No.";
                CJL."VAT Registration No." := CustomerR."VAT Registration No.";
                CJL."Customer string" := CustomerR."Customer String";
                cjl."Customer Stroke" := CustomerR."Customer Stroke";
                cjl."MZ Customer" := CustomerR."MZ Customer";
                cjl."Floor Customer" := CustomerR."Floor Customer";
                cjl."Street Customer" := CustomerR."Street Customer";
                cjl."Address Customer" := CustomerR.Address;
                cjl."MZ Name Customer" := CustomerR."MZ Name Customer";
                cjl."Category Customer" := CustomerR."Customer Category";
                cjl."Home No. Customer" := CustomerR."Home No. Customer";
                cjl."Address 2" := CustomerR."Address 2";
                cjl."Street Customer 2" := CustomerR."Street Customer 2";
                CustomerR.CalcFields("Street Name Customer 2");
                cjl."Street Name Customer 2" := CustomerR."Street Name Customer 2";


                cjl."Street Name Customer" := CustomerR."Street Name Customer";
                cjl."Municipality Code Customer" := CustomerR."Municipality Code Customer";
                CustomerR.CalcFields("Municipality Name Customer");
                cjl."Municipality Name Customer" := CustomerR."Municipality Name Customer";
            end;
            ServiceItem.Reset();
            ServiceItem.SetFilter("No.", '%1', cc."Measuring Point Code");
            if ServiceItem.FindFirst() then begin
                ServiceItem.SetAutoCalcFields("Street Name MM", "Municipality Name MM", "MZ Name MM", "Street Name MM", "Municipality Name MM", "Status MM");
                cjl."Adjusted Pressure" := ServiceItem."Adjusted Pressure";
                cjl."Pressure Date" := ServiceItem."Pressure Date";


                //   ServiceItem.CalcFields("Street Name MM", "Municipality Name MM");

                CJL."Address MM" := ServiceItem.Address;
                cjl.Street := ServiceItem.Street;

                if ServiceItem."Control Number" <> '' then
                    cjl.Agreement := ServiceItem."Control Number";


                //  ServiceItem.CalcFields("MZ Name MM", "Street Name MM", "Municipality Name MM");

                if Evaluate(MMStreetInt, ServiceItem."Street No.") then
                    CJL."Street No. Int MM" := MMStreetInt
                else
                    CJL."Street No. Int MM" := 0;

                ServiceItem.CalcFields("Post Code");
                CJL."Post Code MM" := ServiceItem."Post Code";
                ServiceItem.CalcFields(City);
                CJL."City MM" := ServiceItem.City;
                cjl."Street No. Text" := ServiceItem."Street No. Text";
                ServiceItem.CalcFields("Status MM");

                cjl."Status MM" := ServiceItem."Status MM";
                cjl."Current Status MM" := ServiceItem."Status MM";
                cjl.Activity := ServiceItem.Activity;
                cjl."EF Activity" := ServiceItem."EF Activity";
                cjl."EU Activity" := ServiceItem.Activity;


                cjl."Measuring point off" := ServiceItem."Measuring point off";
                cjl."Measuring point off Date" := ServiceItem."Measuring point off Date";
                cjl."Street Name MM" := ServiceItem."Street Name MM";
                if Evaluate(StreetInt, ServiceItem."Street No.") then begin
                    cjl."Street No. int" := StreetInt;
                end
                else begin
                    cjl."Street No. int" := 0;
                end;


                cjl.Floor := ServiceItem.Floor;
                cjl."Address MM" := ServiceItem."Address MM";
                cjl."Measuring Point string" := ServiceItem."Measuring Point string";
                cjl."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                CJL."Apartment No." := ServiceItem."Apartment No.";
                cjl."Municipality Code MM" := ServiceItem."Municipality Code MM";
                CJL."Municipality Name MM" := ServiceItem."Municipality Name MM";
                cjl."Zone stroke MM" := ServiceItem."Zone stroke";

                cjl."Summer Zone" := ServiceItem."Summer Zone";
                cjl."Winter Zone" := ServiceItem."Winter Zone";
                cjl."Measuring Zone - summer" := ServiceItem."Measuring Zone - summer";
                cjl."Measuring Zone - winter" := ServiceItem."Measuring Zone - winter";
                CJL."MM Description" := ServiceItem.Description + ServiceItem."Description 2";
                cjl."Reading Mode" := ServiceItem."Reading Mode";
                CJL."Mobile No." := ServiceItem."Mobile No.";
                cjl."Fictitious Code" := ServiceItem."Fictitious Code";


                cjl."Type of reading" := ServiceItem."Type of reading";
                cjl."Reading Time" := ServiceItem."Reading Time";
                if cjl."Reading Time" = cjl."Reading Time"::"Per Year" then
                    cjl."Source Data" := cjl."Source Data"::"Per Year";

                cjl.Posting := ServiceItem.Posting;
                cjl.Distribution := ServiceItem.Distribution;
                cjl."Distribution - read" := ServiceItem."Distribution - read";
                cjl.Specification := ServiceItem.Specification;
                cjl."Bill delivery" := ServiceItem."Bill delivery";
                cjl."RMS Maintenance" := ServiceItem."RMS Maintenance";
                cjl."Winter Zone" := ServiceItem."Winter Zone";
                CJL."Remotely Type" := ServiceItem."Remotely Type";
                cjl."Transit Zone" := ServiceItem."Transit Zone";
                cjl."Floor Customer" := ServiceItem."Floor Customer";
                //  cjl."Apartment No. Customer" := ServiceItem."Apartment No. Customer";
                cjl."Home No. Customer" := ServiceItem."Home No. Customer";
                cjl."Home No." := ServiceItem."Home No.";
                cjl."Category Customer" := ServiceItem."Customer Category";
                cjl."Category MM" := ServiceItem."MM Category";
                cjl."Customer No." := ServiceItem."Customer No.";
                cjl."MZ Customer" := ServiceItem."MZ Customer";
                cjl."MZ Name Customer" := ServiceItem."MZ Name Customer";
                CJL."MM Description" := ServiceItem.Description + ServiceItem."Description 2";
                cjl."Method of calculation" := ServiceItem."Method of calculation";
                cjl."MZ MM" := ServiceItem."MZ MM";
                cjl."MZ Name MM" := ServiceItem."MZ Name MM";
            end;
            if cc.Type = cc.Type::Gauge then begin
                gg.Reset();
                gg.SetFilter(Code, '%1', cc.Code);
                if gg.FindFirst() then begin
                    cjl.Validate(Gauge, gg.Code);
                    cjl."Gauge Size" := gg."Gauge Size";
                    cjl."Serial Number" := gg."Inventar number";
                end;

            end;

            if cc.Type = cc.Type::Corrector then begin
                ELVOlume.Reset();
                ELVOlume.SetFilter(Code, '%1', cc.Code);
                if ELVOlume.FindFirst() then begin
                    cjl."EL Correctior Type" := ELVOlume.Model;
                    cjl."EL Volume Description" := ELVOlume."Serial Number";
                    if Evaluate(CodeC, CC.Code) then begin

                        cjl.Validate("Corrector Code", CodeC);
                    end;
                end;
            end;
            if cc."Installation Date" <= ch."Calculation Date To" then begin
                if (cjl."Customer No." <> '') and (cjl."Measuring Point Code" <> '') and (cjl.Gauge <> '')
                and ((cjl."Status MM" = cjl."Status MM"::Active) or
                ((CJL."Reading Mode" = CJL."Reading Mode"::Digital) and (cjl."Status MM" = cjl."Status MM"::"Permanently inactive")))
    then begin
                    cjl.Difference := cjl."New Value" - cjl."Old Value";
                    cjl.Insert();
                end;
            end;

        end;

    end;

    var
        myInt: Integer;
        SalesPr: Record "Sales Price";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        Csetup: Record "Calculation Setup";
        RezDecimal: Decimal;
}