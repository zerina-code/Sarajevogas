report 50208 "Export Gauge"
{
    // //
    //ĐK WordLayout = './Transport print.docx';

    Caption = 'Export Gauge';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem2; "Installation History")
        {

            trigger OnPreDataItem()
            var
                myInt: Integer;



            begin

                cjl."Temperature new- gauge" := 0;
                cjl."New Value" := 0;
                cjl."Pressure new- gauge" := 0;
                cjl."Correction new- gauge" := 0;
                cjl."UnCorrection new- gauge" := 0;
                cjl."UnCorrection previous - gauge" := 0;
                cjl."Correction previous - gauge" := 0;

                CH.Reset();
                CH.SetFilter(status, '%1', ch.Status::Open);
                ch.SetFilter("Category Calculation", '%1', DataItem2."Customer Category");
                if ch.FindSet() then begin
                    CJLSum.Reset();
                    CJLSum.SetFilter("Month Of GAS Calculation", '%1', ch."Month Of GAS Calculation");
                    CJLSum.SetFilter("Year Of GAS Calculation", '%1', ch."Year Of GAS Calculation" - 1);
                    if CJLSum.FindFirst() then begin
                        CJLSum.CalcSums(SM3);
                        //ukupna suma
                    end;
                end;
                //   AQ.SetFilter(Month_Of_GAS_Calculation, '%1', ch."Month Of GAS Calculation");
                //  AQ.setfilter(Year_Of_GAS_Calculation, '%1', 3);

                /*if AQ.Open() then begin
                    while AQ.Read() do begin
                        CountV := aq.Totals;

                    end;*/

                //  end;


            end;

            trigger OnAfterGetRecord()
            var
                IHFind: Record "Installation History";
                IHToplane: Record "Installation History";
                CHPrevious: Record "Calcuation Header";
                IHFacility: Record "Installation History";
            begin

                cjl."Pressure Correction" := 0;
                cjl."Temperature Correction" := 0;
                CH.Reset();
                CH.SetFilter(status, '%1', ch.Status::Open);
                if (DataItem2."Customer Category" = DataItem2."Customer Category"::"KJKP Heating plant") or (DataItem2."Customer Category" = DataItem2."Customer Category"::"Special Customer") then
                    ch.SetFilter("Category Calculation", '%1', ch."Category Calculation"::"Large Economy")
                else
                    ch.SetFilter("Category Calculation", '%1', DataItem2."Customer Category");

                if ch.FindSet() then
                    cjl."Calculation Date From" := ch."Calculation Date From";
                cjl."Calculation Date To" := ch."Calculation Date To";


                cjl."New Value" := 0;

                CHPrevious.Reset();
                CHPrevious.SetFilter("Category Calculation", '%1', DataItem2."Customer Category");
                CHPrevious.SetFilter("Calculation Date To", '<%1', CH."Calculation Date To");
                CHPrevious.SetFilter(Code, '<>%1', ch.Code);
                //  CHPrevious.SetFilter(status, '<>%1', CHPrevious.Status::Open);
                //  CHPrevious.SetCurrentKey("Year Of GAS Calculation", "Month Of GAS Calculation");
                CHPrevious.SetCurrentKey("Calculation Date To");
                CHPrevious.Ascending(False);
                if CHPrevious.findfirst() then
                    CJLUnReadBefore.Reset();
                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                //CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', DataItem2."Measuring Point Code");
                CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', CH."Calculation Date To");
                CHPrevious.Reset();
                CHPrevious.SetFilter("Category Calculation", '%1', DataItem2."Customer Category");
                CHPrevious.SetFilter("Calculation Date To", '<%1', CH."Calculation Date To");
                CHPrevious.SetFilter(Code, '<>%1', ch.Code);
                CHPrevious.SetCurrentKey("Calculation Date To");
                CHPrevious.Ascending(False);
                if CHPrevious.findfirst() then
                    CJLUnReadBefore.SetFilter(Code, '%1', CHPrevious.Code)
                else
                    CJLUnReadBefore.SetFilter(Code, '%1', '');

                CJLUnReadBefore.SetCurrentKey("Calculation Date To", "Reading Date To");
                CJLUnReadBefore.Ascending(false);
                if CJLUnReadBefore.findfirst() then begin
                    if CJLUnReadBefore."Reading Date To" = 0D then CJLUnReadBefore."Reading Date To" := CJLUnReadBefore."Calculation Date To";
                    if (CJLUnReadBefore."Reading Date To" <> 0D) and
(cjl."Calculation Date To" - CJLUnReadBefore."Reading Date To" > 60)
                    then begin




                        if (DataItem2."Installation Date" <= CJLUnReadBefore."Reading Date To") and
                                      (DataItem2.Active = false) and (DataItem2."Dismantling date" <= cjl."Reading Date From") then
                            CurrReport.Skip();
                    end
                    else begin
                        if (DataItem2."Installation Date" <= ch."Calculation Date From")
                        and (DataItem2."Dismantling date" < ch."Calculation Date From") and
                                       (DataItem2.Active = false) then
                            CurrReport.Skip();
                    end;
                end

                else begin
                    if (DataItem2."Installation Date" <= ch."Calculation Date From") and
                                   (DataItem2.Active = false) and (DataItem2."Dismantling date" <= ch."Calculation Date From") then
                        CurrReport.Skip();
                end;



                CurrRecNo += 1;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(CurrRecNo, 1));
                Progress.UPDATE(2, CurrentDateT);
                CH.Reset();
                CH.SetFilter(status, '%1', ch.Status::Open);
                ch.SetFilter("Category Calculation", '%1', DataItem2."Customer Category");
                if ch.FindSet() then
                    CJL2.Reset();
                CJL2.SetFilter(code, '%1', ch.Code);
                CJL2.SetFilter(MM, '%1', DataItem2."Measuring Point Code");
                CJL2.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                CJL2.SetFilter(Gauge, '%1', DataItem2.Code);
                if not CJL2.FindFirst() then begin
                    BrojI += 1;
                    Csetup.get;
                    CJL.Autoint := BrojI;
                    cjl."Calculation Date From" := ch."Calculation Date From";
                    cjl."Calculation Date To" := ch."Calculation Date To";
                    if CountV <> 0 then
                        cjl."Average Calculation" := 0
                    else
                        cjl."Average Calculation" := 0;

                    //očitanje od do 
                    CJL.Code := ch.Code;

                    cjl."Reading Date From" := CJLUnReadBefore."Reading Date To";

                    if cjl."Reading Date From" <= CalcDate('<-5D>', ch."Calculation Date From")
                    then
                        cjl."Reading Date From" := ch."Calculation Date From";


                    cjl."Reading Date To" := cjl."Calculation Date To";

                    cjl."Reading Date To" := ch."Calculation Date To";


                    if cjl."Reading Date From" = 0D then
                        cjl."Reading Date From" := cjl."Calculation Date From";

                    cjl."New Gauge" := false;
                    cjl."Old Gauge" := false;
                    cjl."Filter by Old RMS" := false;

                    if (DataItem2."Installation Date" <= cjl."Reading Date To") and (DataItem2.Active = true) then begin

                        //ako je trenutno važeće stanje

                        cjl."Reading Date From" := cjl."Reading Date From";

                        cjl."Reading Date To" := cjl."Reading Date To";
                        if (DataItem2."Installation Date" <= cjl."Reading Date To") and (DataItem2."Installation Date" >= cjl."Reading Date From")
                        and (DataItem2."Installation Date" <> 0D)
                        and (DataItem2.Active = true) then begin
                            cjl."New Gauge" := true;
                            cjl."Old Value" := DataItem2.Reading;
                            cjl."Reading Date From" := DataItem2."Installation Date";
                            cjl."Temperature previous - gauge" := DataItem2.Temperature;
                            cjl."Pressure previous - gauge" := DataItem2."Operating Pressure On ML";
                            if DataItem2."Dismantling date" = 0D then
                                cjl."Reading Date To" := cjl."Calculation Date To"
                            else
                                cjl."Reading Date To" := DataItem2."Dismantling date";

                            if DataItem2."Dismantling date" <= ch."Calculation Date From" then
                                cjl."Reading Date To" := cjl."Calculation Date To";

                            if (RN = '') and ("Installation Date" >= 20251001D) then begin
                                cjl."New Gauge" := false;

                            end;
                            if (RN = '') and ("Installation Date" >= 20251001D) then begin
                                cjl."Reading Date From" := CH."Calculation Date From";
                            end
                            else begin
                                cjl."Reading Date From" := DataItem2."Installation Date";
                            end;
                            cjl."Temperature previous - gauge" := DataItem2.Temperature;
                            cjl."Pressure previous - gauge" := DataItem2."Operating Pressure On ML";
                            if DataItem2."Dismantling date" = 0D then
                                cjl."Reading Date To" := cjl."Calculation Date To"
                            else
                                cjl."Reading Date To" := DataItem2."Dismantling date";

                            if DataItem2."Dismantling date" <= ch."Calculation Date From" then
                                cjl."Reading Date To" := cjl."Calculation Date To";
                            if (RN = '') and ("Installation Date" >= 20251001D) then begin
                                cjl."Reading Date To" := CH."Calculation Date To";
                            end;

                            //dodala samo novi mjerač
                            if cjl."New Gauge" = false then begin
                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                                //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending(false);
                                if CJLUnReadBefore.findfirst()
                                 then begin
                                    //  cjl."Old Value" := CJLUnReadBefore."Old Value";
                                    cjl."Previous Date" := CJLUnReadBefore."Reading Date To";
                                    cjl."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                    cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                    cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                    cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                    cjl."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                    cjl."Method of calculation" := CJLUnReadBefore."Method of calculation";
                                    if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                                        cjl."Method of calculation" := cjl."Method of calculation"::"1";

                                    if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                        cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                        cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                        cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                        cjl."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                        cjl."Old Value" := CJLUnReadBefore."Old Value";
                                    end;

                                end
                                else begin
                                    cjl."Previous Date" := 0D;
                                    cjl."Previous method of calculation" := CJLUnReadBefore."Method of calculation"::"1";
                                    cjl."Temperature previous - gauge" := 0;
                                    cjl."Pressure previous - gauge" := 0;
                                    cjl."UnCorrection previous - gauge" := 0;
                                    cjl."Correction previous - gauge" := 0;
                                    cjl."Method of calculation" := 0;
                                end;


                                //kraj
                                cjl."Temperature previous - gauge" := DataItem2.Temperature;
                                cjl."Pressure previous - gauge" := DataItem2."Operating Pressure On ML";
                                cjl."Temperature new- gauge" := 0;
                                cjl."Pressure new- gauge" := 0;
                            end;

                        end


                        else begin


                            cjl."New Gauge" := false;
                        end;

                    end
                    else begin

                        //ako je trenutno važeće stanje

                        //može biti više zamjena recimo u tom mjesecu i mora imati slijed od kada do kada to ide

                        //moj datum instalacije je sigurno datum od 
                        if cjl."New Gauge" = false then begin

                            if DataItem2."Installation Date" <= cjl."Reading Date From" then
                                cjl."Reading Date From" := cjl."Calculation Date From"
                            else
                                cjl."Reading Date From" := DataItem2."Installation Date";

                            if cjl."Reading Date From" <= CalcDate('<-5D>', ch."Calculation Date From")
              then
                                cjl."Reading Date From" := ch."Calculation Date From";


                        end;

                        if (DataItem2.Active = false) then begin
                            if (DataItem2."Dismantling date" <= cjl."Reading Date To") and (DataItem2."Dismantling date" >= cjl."Reading Date From")
                            and (DataItem2."Dismantling date" <> 0D)
   then begin
                                cjl."New Value" := DataItem2.Reading;



                                IHFacility.Reset();
                                IHFacility.SetFilter(Type, '%1', IHFacility.Type::Gauge);
                                IHFacility.SetFilter("Date of consumption", '%1', DataItem2."Dismantling date");
                                IHFacility.SetFilter(Code, '%1', DataItem2.Code);
                                if IHFacility.FindFirst() then begin
                                    cjl."New Value" := Round(IHFacility.Reading, 1, '<');
                                    cjl."Temperature new- gauge" := IHFacility.Temperature;
                                    cjl."Pressure new- gauge" := IHFacility."Operating Pressure On ML";
                                end;



                                cjl."Old Gauge" := true;
                                cjl."Reading Date To" := DataItem2."Dismantling date";

                                if DataItem2."Dismantling date" < ch."Calculation Date From" then
                                    cjl."Reading Date To" := ch."Calculation Date To";



                                if DataItem2."Installation Date" < cjl."Calculation Date From" then
                                    cjl."Reading Date From" := cjl."Calculation Date From"
                                else
                                    cjl."Reading Date From" := DataItem2."Installation Date";


                                if cjl."Reading Date From" <= calcdate('<-5D>', ch."Calculation Date From") then
                                    cjl."Reading Date From" := ch."Calculation Date From";


                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                                CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending(False);
                                if CJLUnReadBefore.findfirst()
                                 then begin
                                    cjl."Old Value" := CJLUnReadBefore."New Value";
                                    cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                    cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure new- gauge";
                                end
                                else begin
                                    cjl."Old Value" := 0;
                                    cjl."Temperature previous - gauge" := 0;
                                    cjl."Pressure previous - gauge" := 0;
                                end;




                                //  cjl."Temperature new- gauge" := DataItem2.Temperature;

                                //   cjl."Pressure new- gauge" := DataItem2."Operating Pressure On ML";
                                cjl."Pressure result- gauge" := cjl."Pressure new- gauge";

                                cjl."Temperature result- gauge" := (cjl."Temperature new- gauge" - cjl."Temperature previous - gauge") / 2;




                            end;
                        end
                        else begin
                            cjl."Old Gauge" := false;
                            cjl."Old Value" := 0;
                        end;



                        if cjl."Old Gauge" = false then begin
                            IHFind.Reset();
                            IHFind.SetFilter(Code, '%1', DataItem2.Code);
                            IHFind.SetFilter(Type, '%1', DataItem2.Type::Gauge);
                            IHFind.SetFilter("Installation Date", '<%1', DataItem2."Installation Date");
                            IHFind.SetCurrentKey("Installation Date");
                            IHFind.Ascending(false);
                            //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023
                            if iHC.findfirst() then begin
                                cjl."Reading Date To" := ihc."Installation Date";
                            end
                            else begin
                                cjl."Reading Date To" := ch."Calculation Date To";
                            end;

                            if cjl."Reading Date To" <= ch."Calculation Date From" then
                                cjl."Reading Date To" := ch."Calculation Date To";
                        end;



                    end;

                    /*      if (cjl."Old Gauge" = true) and (DataItem2."Dismantling date" <> 0D)
                                               and ((DataItem2."Dismantling date" >= cjl."Calculation Date From")
                                               and (DataItem2."Dismantling date" <= cjl."Calculation Date To")) then
                              cjl."Reading Date To" := DataItem2."Dismantling date";


                            //  cjl."Reading Date From" := DataItem2."Installation Date";
      */

                    cjl."Calorific power coefficient" := Csetup."Calorific power coefficient";
                    CJL."Atmospheric pressure" := Csetup."Atmospheric pressure";
                    CJL."Scale factor" := Csetup."Scale factor";
                    CJL."Compression coefficient" := Csetup."Compression coefficient";


                    CJL.Gauge := DataItem2.Code;
                    CJL."Measuring Point Code" := DataItem2."Measuring Point Code";
                    CJL.MM := DataItem2."Measuring Point Code";
                    CJL2Count.Reset();
                    CJL2Count.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                    CJL2Count.SetFilter(Locked, '%1', true);
                    if CJL2.FindFirst()
    then begin
                        cjl."Previous Calculations" := CJL2.Count
                    end else begin
                        CJL."Previous Calculations" := 0;
                    end;


                    CJL."Customer No." := DataItem2."Customer No.";


                    IF CU.Get(DataItem2."Customer No.") THEN BEGIN
                        cu.CalcFields("MZ Name Customer", "MZ Name Customer 2", "Street Name Customer", "Street Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2", "Municipality Name Customer", "Municipality Name Customer 2");
                        CJL."Post Code Customer" := CU."Post Code";
                        cjl.Agreement := cu.Agreement;

                        cjl."Bill distribution percentage" := cu."Bill distribution percentage";
                        CJL."E-Mail 2" := cu."E-Mail 2";
                        cjl."E-Mail 2" := Replacestring_TName(cjl."E-Mail 2", ';', 'ĐĐ');
                        CJL."E-mail Delivery" := cu."E-mail Delivery";
                        cjl."Address Customer" := cu.Address;
                        cjl."Address 2" := cu."Address 2";
                        CJL."Reminder Terms Code" := CU."Reminder Terms Code";
                        cjl."E-mail Delivery Date" := cu."E-mail Delivery Date";
                        CJL."E-mail Delivery Date to" := cu."E-mail Delivery Date to";
                        CJL."Post Code Customer D." := CU."Post Code 2";
                        CJL."City Customer" := CU.City;
                        CJL."City Customer D." := CU."City 2";
                        cjl."Customer string" := cu."Customer String";
                        cjl."Customer String 2" := cu."Customer String 2";
                        cjl."Customer Stroke" := cu."Customer Stroke";
                        cjl."Customer Stroke 2" := cu."Customer Stroke 2";
                        cjl."MZ Customer" := cu."MZ Customer";
                        cjl."MZ Customer 2" := cu."MZ Customer 2";
                        cjl."MZ Name Customer" := cu."MZ Name Customer";
                        cjl."MZ Name Customer 2" := cu."MZ Name Customer 2";
                        cjl."Floor Customer" := cu."Floor Customer";
                        cjl."Floor Customer 2" := cu."Floor Customer 2";
                        cjl."Street Customer" := cu."Street Customer";
                        cjl."Home No. Customer 2" := cu."Home No. Customer 2";
                        cjl."Street Customer 2" := cu."Street Customer 2";
                        cjl."Street Name Customer" := cu."Street Name Customer";
                        cjl."Street Name Customer 2" := cu."Street Name Customer 2";
                        cjl."Municipality Code Customer" := cu."Municipality Code Customer";
                        cjl."Municipality Code Customer 2" := cu."Municipality Code Customer 2";
                        cjl."Municipality Name Customer" := cu."Municipality Name Customer";
                        cjl."Municipality Name Customer 2" := cu."Municipality Name Customer 2";
                        cjl."Street No." := cu."Street No.";
                        cjl."Street No. 2" := cu."Street No. 2";
                        cjl."Street No.2 Text" := cu."Street No.2 Text";
                        cjl."Street No. Text" := cu."Street No. Text";
                        cjl."Apartment No. Customer 2" := cu."Apartment No. Customer 2";
                        cjl."Zone stroke" := cu."Zone stroke";
                        cjl."Zone stroke 2" := cu."Zone stroke 2";
                        cjl.Street := cu."Street Customer";
                        cjl."Home No. Customer 2" := cu."Home No. Customer 2";


                    END;
                    MM.Reset();
                    MM.SetFilter("No.", '%1', DataItem2."Measuring Point Code");
                    mm.SetAutoCalcFields("Street Name MM", "Municipality Name MM", "MZ Name MM", "Street Name MM", "Municipality Name MM", "Status MM");
                    if mm.FindSet() then begin
                        cjl."Adjusted Pressure" := mm."Adjusted Pressure";
                        cjl."Pressure Date" := mm."Pressure Date";


                        //   mm.CalcFields("Street Name MM", "Municipality Name MM");

                        CJL."Address MM" := mm.Address;
                        cjl."Street MM" := mm.Street;
                        cjl."Dwelling Type" := mm."Dwelling Type";



                        //  mm.CalcFields("MZ Name MM", "Street Name MM", "Municipality Name MM");

                        if Evaluate(MMStreetInt, MM."Street No.") then
                            CJL."Street No. Int MM" := MMStreetInt
                        else
                            CJL."Street No. Int MM" := 0;



                        if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                            CJL."Street No. Text Apartment" := AparmentInt
                        else
                            CJL."Street No. Text Apartment" := 0;









                        mm.CalcFields("Post Code");
                        CJL."Post Code MM" := MM."Post Code";
                        mm.CalcFields(City);
                        CJL."City MM" := MM."City MM";

                        mm.CalcFields("Status MM");
                        cjl."Street No. Text MM" := mm."Street No. Text";
                        cjl."Status MM" := mm."Status MM";
                        cjl."Current Status MM" := mm."Status MM";
                        cjl.Activity := mm.Activity;
                        cjl."EF Activity" := mm."EF Activity";
                        cjl."EU Activity" := mm."EU Activity";


                        cjl."Measuring point off" := mm."Measuring point off";
                        cjl."Measuring point off Date" := mm."Measuring point off Date";
                        cjl."Street Name MM" := MM."Street Name MM";
                        if Evaluate(StreetInt, mm."Street No.") then begin
                            cjl."Street No. int" := StreetInt;
                        end
                        else begin
                            cjl."Street No. int" := 0;
                        end;


                        if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                            CJL."Street No. Text Apartment" := AparmentInt
                        else
                            CJL."Street No. Text Apartment" := 0;


                        if Evaluate(FloorInt, mm.Floor) then
                            CJL."Street No. Text int" := FloorInt
                        else
                            CJL."Street No. Text int" := 0;

                        cjl.Floor := mm.Floor;
                        cjl."Address MM" := mm."Address MM";
                        cjl."Street MM" := mm.Street;
                        cjl."Dwelling Type" := mm."Dwelling Type";
                        cjl."Measuring Point string" := mm."Measuring Point string";
                        cjl."Measuring Point Stroke" := mm."Measuring Point Stroke";
                        cjl."Posting GAS" := mm."Posting GAS";
                        CJL."Apartment No." := mm."Apartment No.";
                        cjl."Municipality Code MM" := MM."Municipality Code MM";
                        CJL."Municipality Name MM" := mm."Municipality Name MM";
                        cjl."Zone stroke MM" := mm."Zone stroke";

                        cjl."Summer Zone" := mm."Summer Zone";
                        if mm."Control Number" <> '' then
                            cjl.Agreement := mm."Control Number";
                        cjl."Winter Zone" := mm."Winter Zone";
                        cjl."Measuring Zone - summer" := mm."Measuring Zone - summer";
                        cjl."Measuring Zone - winter" := mm."Measuring Zone - winter";
                        CJL."MM Description" := mm.Description + mm."Description 2";
                        cjl."Reading Mode" := mm."Reading Mode";
                        CJL."Mobile No." := mm."Mobile No.";
                        cjl."Fictitious Code" := mm."Fictitious Code";


                        cjl."Type of reading" := mm."Type of reading";
                        cjl."Reading Time" := mm."Reading Time";
                        if cjl."Reading Time" = cjl."Reading Time"::"Per Year" then
                            cjl."Source Data" := cjl."Source Data"::"Per Year";

                        cjl.Posting := mm.Posting;
                        cjl.Distribution := mm.Distribution;
                        cjl."Distribution - read" := mm."Distribution - read";
                        cjl.Specification := mm.Specification;
                        cjl."Bill delivery" := mm."Bill delivery";
                        cjl."RMS Maintenance" := mm."RMS Maintenance";
                        cjl."Winter Zone" := mm."Winter Zone";
                        CJL."Remotely Type" := mm."Remotely Type";
                        cjl."Transit Zone" := mm."Transit Zone";


                        //     CJL."Municipality Code Customer" := mm."Municipality Code Customer";
                        //   cjl."Municipality Name Customer" := mm."Municipality Name Customer";
                        //     cjl."Street Customer" := mm."Street Customer";
                        //   CJL."Street Name Customer" := mm."Street Name Customer";
                        cjl."Floor Customer" := mm."Floor Customer";
                        cjl."Apartment No. Customer" := mm."Apartment No. Customer";
                        cjl."Home No. Customer" := mm."Home No. Customer";
                        cjl."Home No." := mm."Home No.";
                        cjl."Category Customer" := mm."Customer Category";
                        cjl."Category MM" := mm."MM Category";
                        cjl."Customer No." := mm."Customer No.";
                        cjl."MZ Customer" := mm."MZ Customer";

                        if Evaluate(AparmentInt, mm."Apartment No.") then
                            CJL."Street No. Text Apartment" := AparmentInt
                        else
                            CJL."Street No. Text Apartment" := 0;


                        CJL."MM Description" := mm.Description + mm."Description 2";
                        cjl."Method of calculation" := mm."Method of calculation";
                        if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                            cjl."Method of calculation" := cjl."Method of calculation"::"1";
                        cjl."MZ MM" := mm."MZ MM";
                        cjl."MZ Name MM" := mm."MZ Name MM";
                        CJL.Code := ch.Code;
                        CJL."Month of Calculation" := ch."Month of Calculation";
                        cjl."Year of Calculation" := ch."Year of Calculation";
                        CJL."Month Of GAS Calculation" := ch."Month Of GAS Calculation";
                        cjl."Year Of GAS Calculation" := ch."Year Of GAS Calculation";

                        CU.get(DataItem2."Customer No.");
                        cu.CalcFields("MZ Name Customer", "MZ Name Customer 2");
                        SalesPr.Reset();
                        SalesPr.SetFilter("Item No.", '%1', Csetup."Item No. 2");
                        SalesPr.SetFilter("Sales Code", '%1', cu."Customer Price Group");
                        SalesPr.SetFilter("Starting Date", '<=%1', cjl."Reading Date To");
                        SalesPr.SetCurrentKey("Starting Date");
                        SalesPr.Ascending(False);
                        if SalesPr.findfirst() then begin
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
                        RezDecimal := 0;
                        cjl."Customer Balance" := 0;
                        cjl."Customer Prepayment" := 0;

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
                            cjl."Customer Balance" := RezDecimal
                        else
                            cjl."Customer Prepayment" := abs(RezDecimal);
                        CJL."Customer Name" := CU.Name + Cu."Name 2";
                        cjl."Registration No." := CU."Registration No.";
                        CJL."VAT Registration No." := CU."VAT Registration No.";
                        CJL."Customer string" := cu."Customer String";
                        cjl."Customer Stroke" := CU."Customer Stroke";
                        cjl."MZ Customer" := CU."MZ Customer";
                        cjl."Floor Customer" := CU."Floor Customer";
                        cjl."Street Customer" := CU."Street Customer";
                        cjl."Home No. Customer 2" := cu."Home No. Customer 2";
                        cjl."Address Customer" := CU.Address;
                        cjl."MZ Name Customer" := CU."MZ Name Customer";
                        cjl."Category Customer" := CU."Customer Category";
                        cjl."Home No. Customer" := CU."Home No. Customer";
                        cjl."Address 2" := cu."Address 2";
                        CJL."Reminder Terms Code" := CU."Reminder Terms Code";
                        cjl."Street Customer 2" := cu."Street Customer 2";
                        cu.CalcFields("Street Name Customer 2", "Street Name Customer");
                        cjl."Street Name Customer 2" := cu."Street Name Customer 2";


                        cjl."Street Name Customer" := CU."Street Name Customer";
                        cjl."Municipality Code Customer" := cu."Municipality Code Customer";
                        CJL."Reminder Terms Code" := CU."Reminder Terms Code";
                        cu.CalcFields("Municipality Name Customer");
                        cjl."Municipality Name Customer" := cu."Municipality Name Customer";



                    end;
                    Gaug2.Reset();
                    Gaug2.SetFilter(Code, '%1', DataItem2.Code);
                    Gaug2.SetLoadFields("Inventar number", "Gauge Size", Code);
                    if Gaug2.FindSet() then begin

                        cjl."Serial Number" := Gaug2."Inventar number";
                        cjl."Gauge Size" := Gaug2."Gauge Size";
                    end;

                    cjl."Max Difference" := 0;

                    LastYeartF.Reset();
                    // LastYeartF.SetFilter("Customer No.", '%1', cjl."Customer No.");
                    LastYeartF.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                    LastYeartF.SetFilter(Code, '<>%1', cjl.Code);
                    LastYeartF.SetCurrentKey(SM3);
                    LastYeartF.Ascending(false);
                    if LastYeartF.FindFirst() then begin
                        cjl."Max Difference" := LastYeartF.SM3;
                    end;


                    //GetMaxNewValueExceptCurrent
                    cjl."Last Year Calculation" := 0;
                    LastYeartF.Reset();
                    //  LastYeartF.SetFilter("Customer No.", '%1', cjl."Customer No.");
                    LastYeartF.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                    LastYeartF.SetFilter("Year Of GAS Calculation", '%1', Date2DMY(cjl."Calculation Date To", 3) - 1);
                    LastYeartF.SetFilter("Month Of GAS Calculation", '%1', Date2DMY(cjl."Calculation Date To", 2));
                    LastYeartF.SetCurrentKey("Reading Date To");
                    LastYeartF.Ascending(false);
                    if LastYeartF.FindSet() then begin
                        LastYeartF.CalcSums(sm3);
                        cjl."Last Year Calculation" := LastYeartF.SM3;


                    end;




                    cjl."EL Volume Code" := '';
                    cjl."Corrector Code" := 0;
                    cjl."EL Correctior Type" := '';
                    cjl."EL Volume Description" := '';
                    cjl."UnCorrection previous - gauge" := 0;
                    cjl."Correction previous - gauge" := 0;
                    cjl."UnCorrection new- gauge" := 0;
                    cjl."Correction new- gauge" := 0;


                    if (cjl."Old Gauge" = false) and (cjl."New Gauge" = false) then begin

                        CJLUnReadBefore.Reset();
                        //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                        CJLUnReadBefore.SetFilter(Gauge, '%1', cjl.Gauge);
                        CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                        CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                        CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                        CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                        CJLUnReadBefore.Ascending(False);
                        if CJLUnReadBefore.FindFirst()
                         then begin
                            cjl."Old Value" := CJLUnReadBefore."New Value";

                        end
                        else begin
                            cjl."Old Value" := 0;
                        end;

                        CJLUnReadBefore.Reset();
                        //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                        CJLUnReadBefore.SetFilter(Gauge, '%1', cjl.Gauge);
                        CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                        CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                        //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                        CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                        CJLUnReadBefore.Ascending(false);
                        if CJLUnReadBefore.FindFirst()
                         then begin
                            //  cjl."Old Value" := CJLUnReadBefore."Old Value";
                            cjl."Previous Date" := CJLUnReadBefore."Reading Date To";
                            cjl."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                            cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                            cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                            cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                            cjl."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                            cjl."Method of calculation" := CJLUnReadBefore."Method of calculation";

                            cjl."Temperature new- gauge" := 0;
                            cjl."New Value" := 0;
                            cjl."Pressure new- gauge" := 0;
                            cjl."Correction new- gauge" := 0;
                            cjl."UnCorrection new- gauge" := 0;

                            if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                                cjl."Method of calculation" := cjl."Method of calculation"::"1";

                            if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                cjl."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                cjl."Old Value" := CJLUnReadBefore."Old Value";
                            end;
                            cjl."Pressure Correction" := CJLUnReadBefore."Pressure Correction";
                            cjl."Temperature Correction" := CJLUnReadBefore."Temperature Correction";

                        end
                        else begin


                            CJLUnReadBefore.Reset();
                            CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            //  CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                            CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending(false);
                            if CJLUnReadBefore.FindFirst()
                             then begin
                                cjl."Old Value" := CJLUnReadBefore."New Value";

                            end
                            else begin
                                cjl."Old Value" := 0;
                            end;

                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            CJLUnReadBefore.SetFilter(gauge, '%1', cjl.Gauge);
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                            //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending(false);
                            if CJLUnReadBefore.findfirst()
                             then begin
                                // cjl."Old Value" := CJLUnReadBefore."Old Value";
                                cjl."Previous Date" := CJLUnReadBefore."Reading Date To";
                                cjl."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                cjl."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                cjl."Method of calculation" := CJLUnReadBefore."Method of calculation";
                                if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                                    cjl."Method of calculation" := cjl."Method of calculation"::"1";
                                if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                    cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                    cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                    cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                    cjl."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                    cjl."Old Value" := CJLUnReadBefore."Old Value";
                                end;

                                cjl."Temperature new- gauge" := 0;
                                cjl."New Value" := 0;
                                cjl."Pressure new- gauge" := 0;
                                cjl."Correction new- gauge" := 0;
                                cjl."UnCorrection new- gauge" := 0;



                            end
                            else begin
                                cjl."Previous Date" := 0D;
                                cjl."Previous method of calculation" := cjl."Previous method of calculation"::"1";
                                cjl."Temperature previous - gauge" := 0;
                                cjl."Pressure previous - gauge" := 0;
                                cjl."UnCorrection previous - gauge" := 0;
                                cjl."Correction previous - gauge" := 0;
                                cjl."Method of calculation" := 0;
                            end;




                        end;
                    end;








                    if ((cjl."New Gauge" = false) and (cjl."Old Gauge" = false)) or (cjl."New Gauge" = true) then begin

                        iHC.Reset();
                        iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                        iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                        iHC.SetFilter(Active, '%1', true);
                        ihc.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                        iHC.SetLoadFields(Code, "EL Volume Description");
                        if iHC.FindSet() then begin
                            if cjl."New Gauge" = true then begin
                                cjl."UnCorrection previous - gauge" := ihc."Unadjusted Volume";
                                cjl."Correction previous - gauge" := ihc."Adjusted Volume";
                                cjl."Pressure Correction" := ihc."Absolute Pressure Of Corrector";
                                cjl."Temperature Correction" := ihc."Temperature Value";
                            end;


                            if (cjl."Old Gauge" = false) and (cjl."New Gauge" = false) then begin

                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter(Gauge, '%1', cjl.Gauge);
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                                CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending(False);
                                if CJLUnReadBefore.FindFirst()
                                 then begin
                                    cjl."Old Value" := CJLUnReadBefore."New Value";

                                end
                                else begin
                                    cjl."Old Value" := 0;
                                end;

                                CJLUnReadBefore.Reset();
                                //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                CJLUnReadBefore.SetFilter(Gauge, '%1', cjl.Gauge);
                                CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                                CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                                //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                CJLUnReadBefore.Ascending(false);
                                if CJLUnReadBefore.FindFirst()
                                 then begin
                                    //  cjl."Old Value" := CJLUnReadBefore."Old Value";
                                    cjl."Previous Date" := CJLUnReadBefore."Reading Date To";
                                    cjl."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                    cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                    cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                    cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                    cjl."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                    cjl."Method of calculation" := CJLUnReadBefore."Method of calculation";

                                    cjl."Temperature new- gauge" := 0;
                                    cjl."New Value" := 0;
                                    cjl."Pressure new- gauge" := 0;
                                    cjl."Correction new- gauge" := 0;
                                    cjl."UnCorrection new- gauge" := 0;

                                    if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                                        cjl."Method of calculation" := cjl."Method of calculation"::"1";

                                    if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                        cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                        cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                        cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                        cjl."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                        cjl."Old Value" := CJLUnReadBefore."Old Value";
                                    end;
                                    cjl."Pressure Correction" := CJLUnReadBefore."Pressure Correction";
                                    cjl."Temperature Correction" := CJLUnReadBefore."Temperature Correction";

                                end
                                else begin


                                    CJLUnReadBefore.Reset();
                                    CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                    //  CJLUnReadBefore.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                                    CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                                    CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                                    CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                    CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                    CJLUnReadBefore.Ascending(false);
                                    if CJLUnReadBefore.FindFirst()
                                     then begin
                                        cjl."Old Value" := CJLUnReadBefore."New Value";

                                    end
                                    else begin
                                        cjl."Old Value" := 0;
                                    end;

                                    CJLUnReadBefore.Reset();
                                    //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                                    CJLUnReadBefore.SetFilter(gauge, '%1', cjl.Gauge);
                                    CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                                    CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                                    //  CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                                    CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                                    CJLUnReadBefore.Ascending(false);
                                    if CJLUnReadBefore.findfirst()
                                     then begin
                                        // cjl."Old Value" := CJLUnReadBefore."Old Value";
                                        cjl."Previous Date" := CJLUnReadBefore."Reading Date To";
                                        cjl."Previous method of calculation" := CJLUnReadBefore."Method of calculation";
                                        cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature new- gauge";
                                        cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure result- gauge";
                                        cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                        cjl."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";
                                        cjl."Method of calculation" := CJLUnReadBefore."Method of calculation";
                                        if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                                            cjl."Method of calculation" := cjl."Method of calculation"::"1";
                                        if CJLUnReadBefore."Source Data" = CJLUnReadBefore."Source Data"::Unobvious then begin

                                            cjl."Temperature previous - gauge" := CJLUnReadBefore."Temperature previous - gauge";
                                            cjl."Pressure previous - gauge" := CJLUnReadBefore."Pressure previous - gauge";
                                            cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection previous - gauge";
                                            cjl."Correction previous - gauge" := CJLUnReadBefore."Correction previous - gauge";
                                            cjl."Old Value" := CJLUnReadBefore."Old Value";
                                        end;

                                        cjl."Temperature new- gauge" := 0;
                                        cjl."New Value" := 0;
                                        cjl."Pressure new- gauge" := 0;
                                        cjl."Correction new- gauge" := 0;
                                        cjl."UnCorrection new- gauge" := 0;



                                    end
                                    else begin
                                        cjl."Previous Date" := 0D;
                                        cjl."Previous method of calculation" := cjl."Previous method of calculation"::"1";
                                        cjl."Temperature previous - gauge" := 0;
                                        cjl."Pressure previous - gauge" := 0;
                                        cjl."UnCorrection previous - gauge" := 0;
                                        cjl."Correction previous - gauge" := 0;
                                        cjl."Method of calculation" := 0;
                                    end;




                                end;
                            end;
                            cjl."UnCorrection result- gauge" := cjl."UnCorrection new- gauge" - cjl."UnCorrection previous - gauge";
                            cjl."Correction result- gauge" := cjl."Correction new- gauge" - cjl."Correction previous - gauge";



                            cjl."EL Volume Code" := iHC.Code;
                            if Evaluate(CodeC, iHC.code) then
                                cjl."Corrector Code" := CodeC
                            else
                                cjl."Corrector Code" := 0;

                            CJl."EL Volume Description" := iHC."Inventory Number";
                            ELV.Reset();
                            ELV.SetFilter(Code, '%1', iHC.Code);
                            if ELV.FindFirst() then begin
                                cjl."EL Correctior Type" := elv.Model;
                                cjl."EL Volume Description" := ELV."Serial Number";
                            end;

                            //novi mjerač /novi korektor kakav mu je aktivan ()


                        end;
                    end;


                    if cjl."Old Gauge" = true then begin //treba mi stari korektor


                        iHC.Reset();
                        iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                        iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                        ihc.SetFilter("Dismantling date", '%1', cjl."Reading Date To");

                        ihc.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");

                        iHC.SetLoadFields(Code, "EL Volume Description");

                        iHC.SetCurrentKey("Installation Date");
                        iHC.Ascending(False);
                        if iHC.findfirst() then begin

                            cjl."EL Volume Code" := iHC.Code;

                            /*    cjl."UnCorrection new- gauge" := ihc."Unadjusted Volume";
                                cjl."Correction new- gauge" := ihc."Adjusted Volume";
                                cjl."Temperature Correction" := ihc."Temperature Value";
                                cjl."Pressure Correction" := ihc."Absolute Pressure Of Corrector";*/


                            IHFacility.Reset();
                            IHFacility.SetFilter(Type, '%1', IHFacility.Type::Corrector);
                            IHFacility.SetFilter("Date of consumption", '%1', cjl."Reading Date To");
                            IHFacility.SetFilter(Code, '%1', ihc.Code);
                            if IHFacility.FindFirst() then begin
                                cjl."UnCorrection new- gauge" := IHFacility."Unadjusted Volume";
                                cjl."Correction new- gauge" := IHFacility."Adjusted Volume";
                                cjl."Temperature Correction" := IHFacility."Temperature Value";
                                cjl."Pressure Correction" := IHFacility."Absolute Pressure Of Corrector"
                            end
                            else begin
                                cjl."UnCorrection new- gauge" := 0;
                                cjl."Correction new- gauge" := 0;
                                cjl."Temperature Correction" := 0;
                                cjl."Pressure Correction" := 0;
                            end;


                            //before od mjerača
                            CJLUnReadBefore.Reset();
                            //   CJLUnReadBefore.SetFilter(Gauge, '%1', DataItem2.Code);
                            CJLUnReadBefore.SetFilter(gauge, '%1', cjl.Gauge);
                            CJLUnReadBefore.SetFilter("Calculation Date To", '<%1', cjl."Calculation Date To");
                            CJLUnReadBefore.SetFilter(Code, '<>%1', cjl.Code);
                            CJLUnReadBefore.SetFilter("New Value", '<>%1', 0);
                            CJLUnReadBefore.SetCurrentKey("Reading Date To", "Calculation Date To");
                            CJLUnReadBefore.Ascending(false);
                            if CJLUnReadBefore.findfirst()
                             then begin
                                // cjl."Old Value" := CJLUnReadBefore."Old Value";

                                cjl."UnCorrection previous - gauge" := CJLUnReadBefore."UnCorrection new- gauge";
                                cjl."Correction previous - gauge" := CJLUnReadBefore."Correction new- gauge";

                            end
                            else begin

                                cjl."UnCorrection previous - gauge" := 0;
                                cjl."Correction previous - gauge" := 0;
                            end;


                            //kraj





                            cjl."UnCorrection result- gauge" := cjl."UnCorrection new- gauge" - cjl."UnCorrection previous - gauge";
                            cjl."Correction result- gauge" := cjl."Correction new- gauge" - cjl."Correction previous - gauge";

                            //sada bi trebala uzeti staru vrijednost po obračuna sa korektora


                            cjl."EL Volume Code" := iHC.Code;
                            if Evaluate(CodeC, iHC.code) then
                                cjl."Corrector Code" := CodeC
                            else
                                cjl."Corrector Code" := 0;

                            CJl."EL Volume Description" := iHC."Inventory Number";
                            ELV.Reset();
                            ELV.SetFilter(Code, '%1', iHC.Code);
                            if ELV.FindFirst() then begin
                                cjl."EL Correctior Type" := elv.Model;
                                cjl."EL Volume Description" := ELV."Serial Number";
                            end;
                        end;
                    end;
                    if (cjl."New Gauge" = true) or (cjl."Old Gauge" = true) then
                        cjl."Filter by Old RMS" := true;
                    // if (cjl."Previous Date" <> 0D) and (cjl."Filter by Old RMS" = false) then
                    //   cjl."Reading Date From" := cjl."Previous Date";

                    //   if (cjl."Calculation Date From" - cjl."Reading Date From" > 10) and (cjl."Filter by Old RMS" = false) then
                    //     cjl."Reading Date From" := cjl."Calculation Date From";




                    if cjl."Reading Date From" <= CalcDate('<-5D>', ch."Calculation Date From")
                                     then
                        cjl."Reading Date From" := ch."Calculation Date From";

                    if cjl."Reading Date To" < ch."Calculation Date From" then
                        cjl."Reading Date To" := ch."Calculation Date To";



                    if cjl."Calculation Date From" <= CalcDate('<-5D>', ch."Calculation Date From")
                                      then
                        cjl."Calculation Date From" := ch."Calculation Date From";


                    if cjl."Calculation Date To" < ch."Calculation Date From" then
                        cjl."Calculation Date To" := ch."Calculation Date To";


                    if (cjl."Category MM" = cjl."Category MM"::Household) or (cjl."Category MM" = cjl."Category MM"::"Small Economy") then
                        cjl."Method of calculation" := cjl."Method of calculation"::"1";



                    mm.get(CJL."Measuring Point Code");
                    mm.CalcFields("Status MM");
                    UnbMonth := 0;
                    if NacinIzracunaPM = false then begin
                        Unb.Reset();
                        Unb.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                        Unb.SetFilter("Customer No.", '%1', cjl."Customer No.");
                        Unb.SetFilter("Source Data", '<>%1', Unb."Source Data"::Unobvious);
                        Unb.SetFilter("Locked", '%1', true);
                        unb.SetFilter(Code, '<>%1', cjl.Code);
                        // Unb.SetFilter("New Value", '<>%1', 0);
                        Unb.SetCurrentKey("Calculation Date To");
                        unb.Ascending(false);
                        if Unb.findfirst() then begin
                            //nađem prvi očitani
                            unb2.Reset();
                            Unb2.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                            Unb2.SetFilter("Customer No.", '%1', cjl."Customer No.");
                            Unb2.SetFilter("Calculation Date To", '>%1', unb."Calculation Date To");
                            Unb2.SetFilter("Locked", '%1', true);
                            Unb2.SetFilter("New Gauge", '%1', false);
                            unb2.SetFilter(Code, '<>%1', cjl.Code);
                            Unb2.SetCurrentKey("Calculation Date To");
                            if Unb2.FindFirst() then begin
                                UnbMonth := Unb2.Count;
                            end;
                        end;
                    end
                    else begin
                        //vraćam se na prethodni mjesec

                        Unb.Reset();
                        Unb.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                        Unb.SetFilter("Customer No.", '%1', cjl."Customer No.");
                        Unb.SetFilter("Locked", '%1', true);
                        unb.SetFilter(Code, '<>%1', cjl.Code);
                        unb.SetFilter("Previous Unobvious Month", '<>%1', 0);
                        Unb.SetCurrentKey("Calculation Date To");

                        unb.Ascending(false);
                        if Unb.findfirst() then begin
                            if (unb."Previous Unobvious Month" <> 0) and (unb."Source Data" = Unb."Source Data"::Unobvious) and (unb.Unobvious = false) then begin
                                UnbMonth := unb."Previous Unobvious Month" + 1;
                            end;
                        end;
                    end;
                    cjl."Previous Unobvious Month" := UnbMonth;



                    if cjl."New Gauge" = true then
                        cjl."Previous Date" := cjl."Reading Date From";

                    if cjl."New Gauge" = true then
                        cjl."Previous Unobvious Month" := 0;

                    //
                    FirstString := '';

                    if mm."Status MM" = mm."Status MM"::Active
                    then begin
                        FirstString := format(cjl.Code) + ';' + format(CJL.Autoint) + ';' + format(cjl."Calculation Date From") + ';' +
                        Format(cjl."Calculation Date To") + ';' + Format(cjl."Calorific power coefficient")
                        + ';' + Format(cjl."Atmospheric pressure") + ';' + Format(CJL."Scale factor")
                        + ';' + Format(cjl."Compression coefficient") + ';' + Format(CJL.Gauge) +
                        ';' + Format(cjl."Measuring Point Code") + ';' + Format(cjl."Previous Calculations") + ';' +
                        Format(cjl."Customer No.") + ';' + Format(cjl."Post Code Customer")


                        + ';' + format(CJL."E-mail Delivery")
    + ';' + format(cjl."E-mail Delivery Date")
    + ';' + format(CJL."E-mail Delivery Date to")
    + ';' + format(CJL."Post Code Customer D.")
    + ';' + format(CJL."City Customer")
    + ';' + format(CJL."City Customer D.")
    + ';' + format(CJL."Address MM")
    + ';' + format(CJL."Street MM")
    + ';' + format(Cjl."Dwelling Type")
    + ';' + format(CJL.Street)
    + ';' + format(CJL."Post Code MM")
    + ';' + format(CJL."City MM")
    + ';' + format(cjl."Street No. Text")
    + ';' + format(cjl."Street No. Text MM")

    + ';' + format(cjl."Status MM")
    + ';' + format(cjl."Current Status MM")
    + ';' + format(cjl."Measuring point off")
    + ';' + format(cjl."Measuring point off Date")
    + ';' + format(cjl."Street No. int")
    + ';' + format(cjl.Floor)
    + ';' + format(cjl."Measuring Point string")
    + ';' + format(cjl."Measuring Point Stroke")
    + ';' + format(CJL."Apartment No.")
    + ';' + format(CJL."Apartment No. Customer 2")
    + ';' + format(cjl."Municipality Code MM")
    + ';' + format(CJL."Municipality Name MM")
    + ';' + format(cjl."Customer Prepayment")
    + ';' + format(cjl."Summer Zone")
    + ';' + format(cjl."Posting GAS")
    + ';' + format(CJL."MM Description")
    + ';' + format(cjl."Reading Mode")
    + ';' + format(CJL."Mobile No.")
    + ';' + format(cjl."Source Data")
    + ';' + format(cjl."Type of reading")
    + ';' + format(cjl."Reading Time")
    + ';' + format(cjl."Street Name MM")
    + ';' + format(cjl.Posting)
    + ';' + format(cjl.Distribution)
    + ';' + format(cjl."Distribution - read")
    + ';' + format(cjl.Specification)
    + ';' + format(cjl."Bill delivery")
    + ';' + format(cjl."RMS Maintenance")
    + ';' + format(cjl."Winter Zone")
    + ';' + format(CJL."Remotely Type")
    + ';' + format(cjl."Transit Zone")
    + ';' + format(cjl."Floor Customer")
    + ';' + format(cjl."Apartment No. Customer")
    + ';' + format(cjl."Home No. Customer")
    + ';' + format(cjl."Home No.")
    + ';' + format(cjl."Category Customer")
    + ';' + format(cjl."Category MM")
    + ';' + format(cjl."Customer No.")
    + ';' + format(cjl."MZ Customer")
    + ';' + format(cjl."MZ Name Customer")
    + ';' + format(cjl."Method of calculation")
    + ';' + format(cjl."MZ MM")
    + ';' + format(cjl."MZ Name MM")
    + ';' + format(cjl."Zone stroke")
    + ';' + format(cjl."Zone stroke 2")
    + ';' + format(cjl."Zone stroke MM")
    + ';' + format(CJL.Code)
    + ';' + format(CJL."Month of Calculation")
    + ';' + format(cjl."Year of Calculation")
    + ';' + format(CJL."Month Of GAS Calculation")
    + ';' + format(cjl."Year Of GAS Calculation")
    + ';' + format(cjl."Purchase Unit Price")
    + ';' + format(cjl."Distribution Unit Price")
    + ';' + format(cjl."Sales Unit Price")
    + ';' + format(cjl."Unit Price")
    + ';' + format(cjl."Customer Balance")
    + ';' + format(CJL."Customer Name")
    + ';' + format(cjl."Registration No.")
    + ';' + format(CJL."VAT Registration No.")
    + ';' + format(CJL."Customer string")
    + ';' + format(cjl."Customer Stroke")
    + ';' + format(cjl."Street Customer")
    + ';' + format(cjl."Address Customer")
    + ';' + format(cjl."Address 2")
    + ';' + format(cjl."Reminder Terms Code")
    + ';' + format(cjl."Street Name Customer")
    + ';' + format(cjl."Municipality Code Customer")
    + ';' + format(cjl."Municipality Name Customer")
    + ';' + format(cjl."Serial Number")
    + ';' + format(cjl."Gauge Size")
    + ';' + format(cjl."Max Difference")
    + ';' + format(cjl."Old Value")
    + ';' + format(cjl."New Value")
    + ';' + format(cjl."Previous Date")
    + ';' + format(cjl."Previous method of calculation")
    + ';' + format(cjl."EL Volume Code")
    + ';' + format(cjl."EL Volume Description")
    + ';' + format(cjl."EL Correctior Type")


    + ';' + format(cjl."Fictitious Code")
    + ';' + format(cjl."Temperature previous - gauge")
    + ';' + format(cjl."Temperature new- gauge")
    + ';' + format(cjl."Pressure previous - gauge")
    + ';' + format(cjl."Pressure new- gauge")
    + ';' + format(cjl."UnCorrection previous - gauge")
    + ';' + format(cjl."UnCorrection new- gauge")
    + ';' + format(cjl."Correction previous - gauge")
    + ';' + format(cjl."Correction new- gauge")
    + ';' + format(cjl."Temperature Correction")
    + ';' + format(cjl."Pressure Correction")

    + ';' + format(cjl."Measuring Zone - summer")
    + ';' + format(cjl."Measuring Zone - winter")
    + ';' + format(cjl."Reading Date From")
    + ';' + format(cjl."Reading Date To")
    + ';' + format(cjl."Home No. Customer 2")
    + ';' + Format(cjl."Last Year Calculation")
    + ';' + Format(cjl.Activity)
    + ';' + Format(cjl."EF Activity")
    + ';' + Format(cjl."EU Activity")
    + ';' + format(cjl."Average Calculation")
    + ';' + format(cjl."Customer String 2")
    + ';' + format(cjl."Customer Stroke")
    + ';' + format(cjl."Customer Stroke 2")
    + ';' + format(cjl."MZ Customer")
     + ';' + format(cjl."MZ Customer 2")
         + ';' + format(cjl."MZ Name Customer")
           + ';' + format(cjl."MZ Name Customer 2")
             + ';' + format(cjl."Floor Customer")
    + ';' + format(cjl."Floor Customer 2")
       + ';' + format(cjl."Street Customer")
    + ';' + format(cjl."Floor Customer 2")
       + ';' + format(cjl."Street Customer 2")
         + ';' + format(cjl."Street Name Customer")
       + ';' + format(cjl."Street Name Customer 2")
         + ';' + format(cjl."Municipality Code Customer")
          + ';' + format(cjl."Municipality Code Customer 2")
       + ';' + format(cjl."Municipality Name Customer")
           + ';' + format(cjl."Municipality Name Customer 2")
             + ';' + format(cjl."Street No.")
              + ';' + format(cjl."Street No. 2")
          + ';' + format(cjl."Street No.2 Text")
          + ';' + format(cjl."Street No. Text")
            + ';' + format(cjl."Street No. Text MM")
             + ';' + format(cjl."Old Gauge")
          + ';' + format(cjl."New Gauge")
              + ';' + format(cjl."Bill distribution percentage")
          + ';' + format(cjl.Agreement)
           + ';' + format(cjl."Previous Unobvious Month")
          + ';' + format(cjl."Adjusted Pressure") + ';' + format(cjl."Pressure Date") + ';' + format(cjl."E-Mail 2") + ';' + format(cjl."Street No. Text int");

                        //



                    end
                    else begin
                        if (mm."Reading Mode" = mm."Reading Mode"::Digital) and (MM."Status MM" = mm."Status MM"::"Terminated")
                        then
                            FirstString := format(cjl.Code) + ';' + format(CJL.Autoint) + ';' + format(cjl."Calculation Date From") + ';' +
                       Format(cjl."Calculation Date To") + ';' + Format(cjl."Calorific power coefficient")
                       + ';' + Format(cjl."Atmospheric pressure") + ';' + Format(CJL."Scale factor")
                       + ';' + Format(cjl."Compression coefficient") + ';' + Format(CJL.Gauge) +
                       ';' + Format(cjl."Measuring Point Code") + ';' + Format(cjl."Previous Calculations") + ';' +
                       Format(cjl."Customer No.") + ';' + Format(cjl."Post Code Customer")


                       + ';' + format(CJL."E-mail Delivery")
    + ';' + format(cjl."E-mail Delivery Date")
    + ';' + format(CJL."E-mail Delivery Date to")
    + ';' + format(CJL."Post Code Customer D.")
    + ';' + format(CJL."City Customer")
    + ';' + format(CJL."City Customer D.")
    + ';' + format(CJL."Address MM")
    + ';' + format(CJL."Street MM")
    + ';' + format(Cjl."Dwelling Type")
    + ';' + format(CJL.Street)
    + ';' + format(CJL."Post Code MM")
    + ';' + format(CJL."City MM")
    + ';' + format(cjl."Street No. Text")
    + ';' + format(cjl."Street No. Text MM")

    + ';' + format(cjl."Status MM")
    + ';' + format(cjl."Current Status MM")
    + ';' + format(cjl."Measuring point off")
    + ';' + format(cjl."Measuring point off Date")
    + ';' + format(cjl."Street No. int")
    + ';' + format(cjl.Floor)
    + ';' + format(cjl."Measuring Point string")
    + ';' + format(cjl."Measuring Point Stroke")
    + ';' + format(CJL."Apartment No.")
    + ';' + format(CJL."Apartment No. Customer 2")
    + ';' + format(cjl."Municipality Code MM")
    + ';' + format(CJL."Municipality Name MM")
    + ';' + format(cjl."Customer Prepayment")
    + ';' + format(cjl."Summer Zone")
    + ';' + format(cjl."Posting GAS")
    + ';' + format(CJL."MM Description")
    + ';' + format(cjl."Reading Mode")
    + ';' + format(CJL."Mobile No.")
    + ';' + format(cjl."Source Data")
    + ';' + format(cjl."Type of reading")
    + ';' + format(cjl."Reading Time")
    + ';' + format(cjl."Street Name MM")
    + ';' + format(cjl.Posting)
    + ';' + format(cjl.Distribution)
    + ';' + format(cjl."Distribution - read")
    + ';' + format(cjl.Specification)
    + ';' + format(cjl."Bill delivery")
    + ';' + format(cjl."RMS Maintenance")
    + ';' + format(cjl."Winter Zone")
    + ';' + format(CJL."Remotely Type")
    + ';' + format(cjl."Transit Zone")
    + ';' + format(cjl."Floor Customer")
    + ';' + format(cjl."Apartment No. Customer")
    + ';' + format(cjl."Home No. Customer")
    + ';' + format(cjl."Home No.")
    + ';' + format(cjl."Category Customer")
    + ';' + format(cjl."Category MM")
    + ';' + format(cjl."Customer No.")
    + ';' + format(cjl."MZ Customer")
    + ';' + format(cjl."MZ Name Customer")
    + ';' + format(cjl."Method of calculation")
    + ';' + format(cjl."MZ MM")
    + ';' + format(cjl."MZ Name MM")
    + ';' + format(cjl."Zone stroke")
    + ';' + format(cjl."Zone stroke 2")
    + ';' + format(cjl."Zone stroke MM")
    + ';' + format(CJL.Code)
    + ';' + format(CJL."Month of Calculation")
    + ';' + format(cjl."Year of Calculation")
    + ';' + format(CJL."Month Of GAS Calculation")
    + ';' + format(cjl."Year Of GAS Calculation")
    + ';' + format(cjl."Purchase Unit Price")
    + ';' + format(cjl."Distribution Unit Price")
    + ';' + format(cjl."Sales Unit Price")
    + ';' + format(cjl."Unit Price")
    + ';' + format(cjl."Customer Balance")
    + ';' + format(CJL."Customer Name")
    + ';' + format(cjl."Registration No.")
    + ';' + format(CJL."VAT Registration No.")
    + ';' + format(CJL."Customer string")
    + ';' + format(cjl."Customer Stroke")
    + ';' + format(cjl."Street Customer")
    + ';' + format(cjl."Address Customer")
    + ';' + format(cjl."Address 2")
    + ';' + format(cjl."Reminder Terms Code")
    + ';' + format(cjl."Street Name Customer")
    + ';' + format(cjl."Municipality Code Customer")
    + ';' + format(cjl."Municipality Name Customer")
    + ';' + format(cjl."Serial Number")
    + ';' + format(cjl."Gauge Size")
    + ';' + format(cjl."Max Difference")
    + ';' + format(cjl."Old Value")
    + ';' + format(cjl."New Value")
    + ';' + format(cjl."Previous Date")
    + ';' + format(cjl."Previous method of calculation")
    + ';' + format(cjl."EL Volume Code")
    + ';' + format(cjl."EL Volume Description")
    + ';' + format(cjl."EL Correctior Type")


    + ';' + format(cjl."Fictitious Code")
    + ';' + format(cjl."Temperature previous - gauge")
    + ';' + format(cjl."Temperature new- gauge")
    + ';' + format(cjl."Pressure previous - gauge")
    + ';' + format(cjl."Pressure new- gauge")
    + ';' + format(cjl."UnCorrection previous - gauge")
    + ';' + format(cjl."UnCorrection new- gauge")
    + ';' + format(cjl."Correction previous - gauge")
    + ';' + format(cjl."Correction new- gauge")
    + ';' + format(cjl."Temperature Correction")
    + ';' + format(cjl."Pressure Correction")

    + ';' + format(cjl."Measuring Zone - summer")
    + ';' + format(cjl."Measuring Zone - winter")
    + ';' + format(cjl."Reading Date From")
    + ';' + format(cjl."Reading Date To")
    + ';' + format(cjl."Home No. Customer 2")
    + ';' + Format(cjl."Last Year Calculation")
    + ';' + Format(cjl.Activity)
    + ';' + Format(cjl."EF Activity")
    + ';' + Format(cjl."EU Activity")
    + ';' + format(cjl."Average Calculation")
    + ';' + format(cjl."Customer String 2")
    + ';' + format(cjl."Customer Stroke")
    + ';' + format(cjl."Customer Stroke 2")
    + ';' + format(cjl."MZ Customer")
    + ';' + format(cjl."MZ Customer 2")
        + ';' + format(cjl."MZ Name Customer")
          + ';' + format(cjl."MZ Name Customer 2")
            + ';' + format(cjl."Floor Customer")
    + ';' + format(cjl."Floor Customer 2")
      + ';' + format(cjl."Street Customer")
    + ';' + format(cjl."Floor Customer 2")
      + ';' + format(cjl."Street Customer 2")
        + ';' + format(cjl."Street Name Customer")
      + ';' + format(cjl."Street Name Customer 2")
        + ';' + format(cjl."Municipality Code Customer")
         + ';' + format(cjl."Municipality Code Customer 2")
      + ';' + format(cjl."Municipality Name Customer")
          + ';' + format(cjl."Municipality Name Customer 2")
            + ';' + format(cjl."Street No.")
             + ';' + format(cjl."Street No. 2")
         + ';' + format(cjl."Street No.2 Text")
         + ';' + format(cjl."Street No. Text")
           + ';' + format(cjl."Street No. Text MM")
            + ';' + format(cjl."Old Gauge")
         + ';' + format(cjl."New Gauge")
             + ';' + format(cjl."Bill distribution percentage")
         + ';' + format(cjl.Agreement)
          + ';' + format(cjl."Previous Unobvious Month")
         + ';' + format(cjl."Adjusted Pressure") + ';' + format(cjl."Pressure Date") + ';' + format(cjl."E-Mail 2") + ';' + format(cjl."Street No. Text int");

                        //

                    end;
                end;


                // This command is to move to next line

                FirstString := Replacestring_TName(FirstString, ';;', '; ;');
                FirstString := Replacestring_TName(FirstString, '"', '&quot');
                if FirstString <> '' then begin
                    OutStreamObj.WRITETEXT(FirstString);
                    OutStreamObj.WRITETEXT();
                end;
                Broj2 += 1;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(Broj2));
                Progress.UPDATE(2, CurrentDateT);
            end;

        }
    }
    requestpage
    {
        Caption = 'Update';

        layout
        {
            area(content)
            {

                field(NacinIzracunaPM; NacinIzracunaPM)
                {
                    Caption = 'NacinIzracunaPM';
                }
            }
        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
        AQ: Query "My Query";
        CJLSum: Record "Calculation Journal Line";
    begin
        Company.get;

        FileName := 'AzuriranjePodaci3.txt';
        // TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        File1.CREATE(Company."Path for Documents" + 'AzuriranjePodaci3.txt', TEXTENCODING::UTF8);

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
        // FileManagement.DownloadToFile(Company."Path for Documents" + 'AzuriranjePodaci3.txt', Company."Path for Documents" + 'AzuriranjePodaci3.txt');

        FileManagement.BLOBExport(TempBlob, Company."Path for Documents" + 'AzuriranjePodaci3.txt', true);

        Commit();

        Filexml.OPEN(Company."Path for Documents" + 'AzuriranjePodaci3.txt');
        Filexml.CREATEINSTREAM(instreamobject);
        XMLPORT.IMPORT(50046, instreamobject);
        Commit();

    end;



    var
        Company: Record "Company Information";
        FileManagement: Codeunit "File Management";
        FirstString: Text;
        DatePrevious: Date;
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        DateT1: Text;
        DateT2: Text;
        FileName: Text;
        Selected: Option "Usporedba 1","Usporedba 2","Usporedba 3","Usporedba 4","Usporedba 5";
        Range1: Decimal;
        SelectedT: Text;
        Broj2: Integer;

        DateUpdate: Date;
        DecimalV: Decimal;
        instreamobject: InStream;
        DecimalV2: Text;
        DecimalV2E: Integer;
        Filexml: File;
        File1: File;
        OutStreamObj: OutStream;
        Gauge2: Record "Installation History";
        CJL: Record "Calculation Journal Line";
        MM: Record "Service Item";
        CH: Record "Calcuation Header";
        CU: Record Customer;
        CJL2: Record "Calculation Journal Line";
        Gaug2: Record Gauge;
        iHC: Record "Installation History";
        Csetup: Record "Calculation Setup";
        ELV: Record "El. Volume Corr";
        SalesPr: Record "Sales Price";
        SaldoFirst: Decimal;
        RezDecimal: Decimal;
        Prepayment: Decimal;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CJLUnReadBefore: Record "Calculation Journal Line";
        CJLUnReadBefore2: Record "Calculation Journal Line";
        StreetInt: integer;

        BrojNeocitanihMjeseci: Integer;
        Progress: Dialog;
        CurrRecNo: Integer;
        CodeC: Integer;
        Unb: Record "Calculation Journal Line";
        Unb2: Record "Calculation Journal Line";
        LastYeartF: Record "Calculation Journal Line";
        BrojI: Integer;
        UnbMonth: Integer;
        TotalRecNo: Integer;
        StartDaT: Time;
        CurrentDateT: Time;
        CJLSum: Record "Calculation Journal Line";
        AQ: Query "My Query";
        CountV: Integer;
        CJL2Count: Record "Calculation Journal Line";
        MMStreetInt: Integer;
        NacinIzracunaPM: Boolean;
        FloorInt: Integer;
        AparmentInt: Integer;

    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure GetMaxNewValueExceptCurrent(CurrentCode: Code[20]; MM: code[20]): Decimal
    var
        MaxQuery: Query "MaxNewValueQuery";
    begin
        MaxQuery.SetFilter("Code", '<>%1', CurrentCode);
        MaxQuery.SetFilter(Measuring_Point_Code, MM);

        if MaxQuery.Open() then
            if MaxQuery.Read() then
                exit(MaxQuery.NewValue);

        exit(0);
    end;

    procedure GetMaxNewValueExceptCurrentLast(CurrentCode: Code[20]; MM: code[20]; CJL: Record "Calculation Journal Line"): Decimal
    var
        MaxQuery: Query "MaxNewValueQueryLast";
    begin
        MaxQuery.SetFilter("Code", '<>%1', CurrentCode);
        MaxQuery.SetFilter(Measuring_Point_Code, MM);
        MaxQuery.setfilter(Calculation_Date_To, '%1..%2', CalcDate('<-1Y>', cjl."Calculation Date From"), CalcDate('<-1Y>', cjl."Calculation Date To"));

        if MaxQuery.Open() then
            if MaxQuery.Read() then
                exit(MaxQuery.NewValue);

        exit(0);
    end;



}

