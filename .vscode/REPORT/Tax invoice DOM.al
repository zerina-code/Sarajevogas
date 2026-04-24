report 50182 "Tax Invoice DOM"
{
    // BH1.00, Fiscal Process
    // BH1.01, Invoice elements
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Invoice DOM2.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Tax - Invoice';
    EnableExternalAssemblies = true;
    //Permissions = TableData 7190 = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem5581; "Calculation Journal Line")
        {

            RequestFilterHeading = 'Posted Sales Invoice';

            column(Customer_No_; "Customer No.") { }
            column(TextParam; TextParam) { }
            column(transactionResult; transactionResult) { }
            column(NameCenter; comp."Name")
            {

            }
            column(Municipality_Name_Customer_2; "Municipality Name Customer 2") { }
            column(Street_Name_MM; "Street Name MM") { }
            column(BrojacRedovaaaaa; BrojacRedovaaaaa) { }
            column(Brojaczamjena; Brojaczamjena) { }
            column(Post_Code_Customer_D_; "Post Code Customer D.") { }
            column(RazlikaZamjena; RazlikaZamjena) { }
            column(Apartment_No__Customer; "Apartment No. Customer") { }
            column(Apartment_No_; "Apartment No.") { }
            column(Apartment_No__Customer_2; "Apartment No. Customer 2") { }
            column(CustCategory; DataItem5581."Category Customer") { }

            column(MMCategory; DataItem5581."Category MM") { }
            column(CHComment; CH.Comment) { }
            column(BrojacKupca; BrojacKupca) { }
            column(EF_Activity; "EF Activity") { }

            column(RegistrationCompany; comp."Registration No.")
            {

            }
            column(TaxNo; comp."Tax No.")
            {

            }
            column(City_Customer; "City Customer") { }
            column(City_Customer_D_; "City Customer D.") { }
            column(IndustrialClasification; comp."Industrial Classification")
            {

            }
            column(RegistrationText; comp."Registration Text")
            {

            }
            column(Q__total_Sum___War; "Q. total Sum - War") { }
            column(Companyemail; comp."E-Mail")
            {

            }
            column(OrgJed; OrgJed) { }


            column(Companyweb; comp."Home Page")
            {

            }
            column(Bill_distribution_percentage; "Bill distribution percentage") { }
            column(Agreement; Agreement) { }
            column(Signatory; ch."Billing Signatory") { }
            column(SignatoryDocument; ch."Billing Sign") { }
            column(BillingSignatoryName; BillingSignatoryName) { }

            column(SlovimaRez; SlovimaRez) { }
            column(BillingSignatoryPos; ch."Billing Signatory Position") { }
            column(PhoneBilling; ch."Contact Phone No.") { }
            column(CompanyInfo2Picture; comp.Picture1) { }
            column(CompanyInfo2PictureC; comp.Picture2) { }
            column(CompanyInfo2PictureC2; comp.Picture3) { }
            column(HideeOption; HideeOption) { }
            column(Source_Data; "Source Data") { }
            column(Napomena1; Napomena1) { }
            column(Napomena2; Napomena2) { }
            column(NapomenaAll; NapomenaAll) { }
            column(Napomena3; Napomena3) { }
            column(Napomena4; Napomena4) { }
            column(Napomena5; Napomena5) { }
            column(Napomena6; Napomena6) { }
            column(Napomena7; Napomena7) { }
            column(Napomena8; Napomena8) { }
            column(Napomena9; Napomena9) { }
            column(HideeOptionO; HideeOptionO) { }
            column(DateCer; format(CER."Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(DateCerRelation; CER."Relational Exch. Rate Amount") { }
            column(DateCerRelationPet; format((CER."Relational Exch. Rate Amount" * 5), 0, '<Precision,5:5><Standard Format,0>')) { }
            column(DateCerRelationPetR; format(round((CER."Relational Exch. Rate Amount" * 5), 0.000001, '='), 0, '<Precision,5:5><Standard Format,0>')) { }

            column(Last_Year_Calculation; "Last Year Calculation") { }
            column(Napomena10; Napomena10) { }
            column(KOEKAL; KOEKAL) { }
            column(DugIliPrep; DugIliPrep) { }
            column(ukupdugiliprep; ukupdugiliprep) { }
            column(IznosDugIliPrep; IznosDugIliPrep) { }

            column(NoviSaldo; (NoviSaldo)) { }
            column(NoviSaldoDom; RoundDecimal(NoviSaldo)) { }

            column(comp_address; comp.Address) { }
            column(Post_Code_MM; "Post Code MM") { }
            column(Street_No__Text_MM; "Street No. Text MM") { }
            column(City_MM; "City MM") { }
            column(Municipality_Name_MM; "Municipality Name MM") { }
            column(Document_No__Posting; "Document No. Posting") { }
            column(Correction_previous___gauge; "Correction previous - gauge") { }
            column(Correction_new__gauge; "Correction new- gauge") { }
            column(Correction_result__gauge; "Correction result- gauge") { }
            column(Pressure_new__gauge; "Pressure new- gauge") { }
            column(Pressure_previous___gauge; "Pressure previous - gauge") { }
            column(Pressure_result__gauge; "Pressure result- gauge") { }
            column(Temperature_previous___gauge; "Temperature previous - gauge") { }
            column(Temperature_new__gauge; "Temperature new- gauge") { }
            column(Temperature_result__gauge; "Temperature result- gauge") { }
            column(Metod; Metod) { }
            column(PS; CalcS."PS Constant") { }
            column(AT; CalcS."Atmospheric pressure") { }
            column(AZ; CalcS."Absolute zero") { }
            column(ATC; CalcS."TS Constant") { }
            column(ImaOpomenu; ImaOpomenu) { }
            column(Date; Date) { }
            column(Reading_Date_From; format("Reading Date From", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Reading_Date_To; format("Reading Date To", 0, '<day,2>.<month,2>.<year4>')) { }
            column(comp_reg; comp."Registration No.") { }
            column(comp_vat; comp."VAT Registration No.") { }
            column(Registration_No_; "Registration No.") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Customer_Balance; "Customer Balance") { }
            column(Average_Calculation; "Average Calculation") { }
            column(Customer_Prepayment; "Customer Prepayment") { }
            column(CustomerNowNo; CustomerNow.Description) { }
            column(CustomerNowNoStart; format(CustomerNow."Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(CustomerNowNoJN; CustomerNow."Public Document No.") { }
            column(CustomerNowNoStartJN; format(CustomerNow."Date of Public Procurement", 0, '<day,2>.<month,2>.<year4>')) { }
            column(CustomerNowNoJN_Yes; CustomerNow."Public Procurement") { }
            column(comp_tax; comp."Tax No.") { }
            column(compCont; comp."Contact Phone") { }
            column(compPhone; comp."Phone No.") { }
            column(PhoneNo2; comp."Phone No. 2") { }
            column(ButilePhone; comp."Phone Number Butile") { }
            column(ButilePFax; comp."Fax Butile") { }
            column(DispatchCenter; comp."Dispatch Center") { }
            column(compPurchasePhone; comp."Purchase Phone No.") { }
            column(compFax; comp."Fax No.") { }
            column(comp_djelatnost; comp."Industrial Classification") { }
            column(comp_regtext; comp."Registration Text") { }
            column(comp_MBS; comp.MBS) { }
            column(comp_email; comp."E-Mail") { }
            column(comp_mun; comp."Municipality Name") { }
            column(transaction1; transaction1) { }
            column(transaction1Name; transaction1Name) { }
            column(transaction11; transaction11) { }
            column(transaction11Name; transaction11Name) { }
            column(transaction12; transaction12) { }
            column(transaction12Name; transaction12Name) { }

            column(transaction10; transaction10) { }
            column(transaction10Name; transaction10Name) { }
            column
            (transaction2; transaction2)
            { }
            column(transaction2Name; transaction2Name) { }
            column(transaction3; transaction3) { }
            column(transaction3Name; transaction3Name) { }
            column(transaction4; transaction4) { }
            column(transaction4Name; transaction4Name) { }
            column(transaction5; transaction5) { }
            column(transaction5Name; transaction5Name) { }
            column(transaction6; transaction6) { }
            column(transaction6Name; transaction6Name) { }
            column(transaction7; transaction7) { }
            column(transaction7Name; transaction7Name) { }
            column(transaction8; transaction8)
            {

            }
            column(transaction8Name; transaction8Name) { }
            column(transaction9; transaction9) { }
            column(transaction9Name; transaction9Name) { }
            column(BarCode1; BarCode1) { }
            column(BarCode2; BarCode2) { }

            column(NacinOcitanja; DataItem5581."Source Data") { }
            column(NacinOcitanjaZamjena; NacinOcitanjaZamjena) { }
            column(DatumOdMaxZamjena; format(DatumOdMaxZamjena, 0, '<day,2>.<month,2>.<year4>')) { }
            column(DatumOdMinZamjena; format(DatumOdMinZamjena, 0, '<day,2>.<month,2>.<year4>')) { }
            column(DatumiSpojeniod; DatumiSpojeniOd) { }
            column(DatumiSpojeniDo; DatumiSpojeniDo) { }
            column(OldZamjena; OldZamjena) { }
            column(NewZamjena; NewZamjena) { }

            column(OldZamjena1; OldZamjena1) { }
            column(NewZamjena1; NewZamjena1) { }
            column(RazlikaZamjena1; RazlikaZamjena1) { }

            column(MjeraciZamjena; MjeraciZamjena) { }
            column(Customer_Name; "Customer Name") { }
            column(Mjesec; Mjesec[1]) { }
            column(Mjesec2; Mjesec[2]) { }
            column(Address_Customer; "Address Customer") { }
            column(Address_Customer2; "Address 2") { }
            column(Address_MM; "Address MM") { }
            column(Measuring_Point_Code; "Measuring Point Code") { }
            column(Serial_Number; "Serial Number") { }
            column(Customer_string; "Customer string") { }
            column(MM_Description; "MM Description") { }
            column(Customer_Stroke; "Customer Stroke") { }
            column(Customer_Stroke_2; "Customer Stroke 2") { }
            column(Customer_String_2; "Customer String 2") { }
            column(Customer_String_; "Customer String") { }
            column(comp_city; comp.City) { }
            column(Calculation_Date_From; format(CaldF, 0, '<day,2>.<month,2>.<year4>')) { }
            column(Calculation_Date_To; format(CalcD, 0, '<day,2>.<month,2>.<year4>')) { }

            //DueOrg
            column(DueOrg; format(DueOrg, 0, '<day,2>.<month,2>.<year4>')) { }
            column(New_Value; NewValueDec) { }
            column(Difference; Difference) { }
            column(Gauge_Size; "Gauge Size") { }
            column(Calorific_power_coefficient; "Calorific power coefficient") { }
            column(Basis_maintenance; "Basis maintenance") { }
            column(GAS___amount; "GAS - amount") { }
            column(GAS___part; "GAS - part") { }

            column(Maintenance___part; "Maintenance - part") { }
            column(Total; Total) { }
            column(GAS___VAT; "GAS - VAT") { }
            column(Total_without_VAT; "GAS - amount" + "Basis maintenance") { }
            column(Total_VAT; "GAS - VAT" + "Maintenance VAT") { }
            column(Maintenance_VAT; "Maintenance VAT") { }
            column(Winter_Pecentage; "Winter Pecentage") { }
            column(Summer_Pecentage; "Summer Pecentage") { }
            column(WInterYs; WInterYs) { }
            column(Purchase_Unit_Price; "Purchase Unit Price") { }
            column(Sales_Unit_Price; "Sales Unit Price") { }
            column(Unit_Price; "Unit Price") { }
            column(SM3; SM3) { }
            column(SumGAS___amount; SumGAS___amount) { }
            column(SumGasVat; SumGasVat) { }
            column(SumMainVat; SumMainVat) { }
            column(SUmGasPart; SUmGasPart) { }
            column(SumDifference; SumDifference) { }
            column(SumMain; SumMain) { }
            column(SumMainCount; SumMainCount) { }
            column(SumSm3; SumSm3) { }
            column(SumWar_Calculation__LVT_; SumWar_Calculation__LVT_) { }
            column(SUmTotal_without_VAT; SUmTotal_without_VAT) { }
            column(SUmTotalVat; SUmTotalVat) { }
            column(Distribution_Unit_Price; "Distribution Unit Price") { }
            column(Previous_Date; format("Previous Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(War_Calculation__LVT_; "War Calculation (LVT)") { }
            column(Old_Value; "Old Value") { }
            column(CustFloorCustomer2; CustFloorCustomer2) { }
            column(CustStreetNoText2; CustStreetNoText2) { }
            column(Street_No__Text; "Street No. Text") { }
            column(CustFloorCustomer; CustFloorCustomer) { }




            dataitem("Reminder Line"; "Reminder Line")
            {

                column(Document_No_; "Document No.") { }
                column(Original_Amount; "Original Amount") { }
                column(Remaining_Amount; "Remaining Amount") { }
                column(TotalOpomene; TotalOpomene) { }
                column(TextParam2; TextParam2) { }
                column(OrginalDate; format(CalcDate('<-15D>', "Due Date"), 0, '<day,2>.<month,2>.<year4>')) { }
                column(Due_Date; format("Due Date", 0, '<day,2>.<month,2>.<year4>')) { }
                column(Brojac; Brojac) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    setfilter("No.", '%1', OpomenaCode);


                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    re: Record "Reminder Header";
                    CalcDuplicate: Record "Calculation Journal Line";


                begin



                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        ECL.Reset();
                        ECL.SetFilter("Employee No.", '%1', us."Employee No. for Wage");
                        ecl.SetFilter(Active, '%1', true);
                        if ecl.FindFirst() then
                            OrgJed := ecl."Department Code"
                        else
                            OrgJed := '';
                    end;

                    Brojac += 1;
                    re.Reset();
                    re.SetFilter("No.", '%1', "Reminder Line"."No.");
                    if re.FindFirst() then begin
                        re.CalcFields("Remaining Amount");
                        TotalOpomene := re."Remaining Amount";
                    end;



                    TextParam2 := '';
                    TextParam := '';

                    if DataItem5581."Document No. Posting" <> '' then begin
                        if CopyStr(DataItem5581."Document No. Posting", 1, 2) = '03' then begin
                            TextParam2 := 'RC-TU-02-03-03, Opomena pred prekid isporuke zbog duga za gas';
                        end;
                    end;
                    if DataItem5581."Document No. Posting" <> '' then begin
                        if CopyStr(DataItem5581."Document No. Posting", 1, 2) = '01' then begin
                            TextParam2 := 'RC-TU-02-03-01, Opomena pred prekid isporuke zbog duga za gas';
                        end;
                    end;

                    if DataItem5581."Document No. Posting" <> '' then begin
                        if CopyStr(DataItem5581."Document No. Posting", 1, 2) = '02' then begin
                            TextParam2 := 'RC-TU-02-03-02, Opomena pred prekid isporuke zbog duga za gas';
                        end;
                    end;






                end;
            }


            trigger OnPreDataItem()
            var
                myInt: Integer;

            begin
                comp.get;
                comp.CalcFields(Picture1, Picture2, Picture3, Picture);
                SetCurrentKey("Customer Stroke 2", "Customer String 2", "Municipality Name Customer 2", "Street Name Customer 2", "Street No.2 int", "Street No.2 Text", "Street No. Text Apartment", "Apartment No. Customer 2", "Customer No. int", "Measuring Point Code", "Calculation Date To", "Reading Date To");
                TaxD.DeleteAll();

                CustFloorCustomer2 := '';
                CustFloorCustomer := '';
                CustStreetNoText2 := '';
                BrojacRedovaaaaa := 0;
                CategTemp.DeleteAll;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;

                Doc: Text[250];
                Noseries: code[20];
                ECL: Record "Employee Contract Ledger";
                MyCU: Codeunit "TestSubsCu";
                DataItemR: Record "Calculation Journal Line";
                CalcDuplicate: Record "Calculation Journal Line";
                CalcDuplicate2: Record "Calculation Journal Line";

            begin
                CategTemp.Reset();
                CategTemp.SetFilter("Document No.", '%1', DataItem5581."Customer No.");
                CategTemp.SetFilter("Message Code", '%1', DataItem5581."Document No. Posting");
                if not CategTemp.FindFirst() then begin
                    CategTemp.Init();
                    CategTemp."Document No." := DataItem5581."Customer No.";
                    CategTemp."Message Code" := DataItem5581."Document No. Posting";
                    CategTemp.Insert();
                    BrojacRedovaaaaa := 0;
                end
                else begin
                    BrojacRedovaaaaa += 1;
                end;

                NacinOcitanjaZamjena := '';
                DatumOdMaxZamjena := 0D;
                RazlikaZamjena := '';
                NewZamjena := '';
                OldZamjena := '';
                NewZamjena1 := '';
                OldZamjena1 := '';
                RazlikaZamjena1 := '';
                DatumiSpojeniOd := '';
                DatumiSpojenido := '';
                DatumOdMinZamjena := 0D;
                MjeraciZamjena := '';

                CalcDuplicate.reset;
                CalcDuplicate.CopyFilters(DataItem5581);

                CalcDuplicate.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                Brojaczamjena := CalcDuplicate.Count;

                if Brojaczamjena > 1 then begin
                    CalcDuplicate.reset;
                    CalcDuplicate.CopyFilters(DataItem5581);

                    CalcDuplicate.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                    CalcDuplicate.SetCurrentKey("Reading Date From", "Reading Date To");
                    CalcDuplicate.Ascending(true);
                    // CalcDuplicate.SetFilter("New Gauge", '%1', true);
                    if CalcDuplicate.FindSet() then
                        repeat

                            if (CalcDuplicate."Old Gauge" = true) and (CalcDuplicate."Category MM" = CalcDuplicate."Category MM"::Household)
                            then begin

                                if StrPos(NacinOcitanjaZamjena, format('Zamjena mjerača')) = 0 then
                                    NacinOcitanjaZamjena += format('Zamjena mjerača') + '/';

                            end
                            else begin
                                if StrPos(NacinOcitanjaZamjena, format(CalcDuplicate."Source Data")) = 0 then
                                    NacinOcitanjaZamjena += format(CalcDuplicate."Source Data") + '/';
                            end;


                            if StrPos(MjeraciZamjena, format(CalcDuplicate."Serial Number")) = 0 then
                                MjeraciZamjena += format(CalcDuplicate."Serial Number") + '/';

                            RazmaciAdd := '';
                            BrojacRazmaka := 0;

                            for BrojacRazmaka := 0 to strlen(format(CalcDuplicate."Old Value")) - 4 do begin
                                RazmaciAdd += ' ';
                            end;

                            CalcDuplicate2.reset;
                            CalcDuplicate2.copyfilters(CalcDuplicate);
                            CalcDuplicate2.SetFilter("Old Gauge", '%1', true);
                            if CalcDuplicate2.FindFirst() then begin
                                if CalcDuplicate2."Old Gauge" = true then begin
                                    OldZamjena := format(CalcDuplicate2."Old Value");
                                end;
                            end;



                            CalcDuplicate2.reset;
                            CalcDuplicate2.copyfilters(CalcDuplicate);
                            CalcDuplicate2.SetFilter("New Gauge", '%1', true);
                            if CalcDuplicate2.FindFirst() then begin
                                if CalcDuplicate2."New Gauge" = true then
                                    OldZamjena1 := format(CalcDuplicate2."Old Value");
                            end;

                            RazmaciAdd := '';
                            BrojacRazmaka := 0;

                            for BrojacRazmaka := 0 to strlen(format(CalcDuplicate."New Value")) - 4 do begin
                                RazmaciAdd += ' ';
                            end;



                            CalcDuplicate2.reset;
                            CalcDuplicate2.copyfilters(CalcDuplicate);
                            CalcDuplicate2.SetFilter("Old Gauge", '%1', true);
                            if CalcDuplicate2.FindFirst() then begin
                                if CalcDuplicate2."Old Gauge" = true then begin
                                    if (CalcDuplicate2."New Value" = 0) and ((CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unknown) or (CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unobvious))
                                    then
                                        NewZamjena := format('-')
                                    else
                                        NewZamjena := format(CalcDuplicate2."New Value")

                                end;
                            end;

                            CalcDuplicate2.reset;
                            CalcDuplicate2.copyfilters(CalcDuplicate);
                            CalcDuplicate2.SetFilter("New Gauge", '%1', true);
                            if CalcDuplicate2.FindFirst() then begin
                                if CalcDuplicate2."New Gauge" = true then begin
                                    if (CalcDuplicate2."New Value" = 0) and ((CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unknown) or (CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unobvious))
                                    then
                                        NewZamjena1 := format('-')
                                    else
                                        NewZamjena1 := format(CalcDuplicate2."New Value")

                                end;
                            end;
                            RazmaciAdd := '';
                            BrojacRazmaka := 0;
                            if CalcDuplicate."Old Gauge" = true then begin


                                for BrojacRazmaka := 0 to strlen(format(CalcDuplicate.Difference)) - 4 do begin
                                    RazmaciAdd += ' ';
                                end;
                            end;

                            //   RazlikaZamjena += RazmaciAdd + Format(CalcDuplicate.Difference) + '   ';

                            RazmaciAdd := '';
                            BrojacRazmaka := 0;

                            for BrojacRazmaka := 0 to strlen(format(CalcDuplicate."Old Value")) - 4 do begin
                                RazmaciAdd += ' ';
                            end;

                            // OldZamjena += RazmaciAdd + format(CalcDuplicate."Old Value") + '     ';



                            CalcDuplicate2.reset;
                            CalcDuplicate2.copyfilters(CalcDuplicate);
                            CalcDuplicate2.SetFilter("Old Gauge", '%1', true);
                            if CalcDuplicate2.FindFirst() then begin
                                if CalcDuplicate2."Old Gauge" = true then begin
                                    if (CalcDuplicate2.Difference <= 0) and ((CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unknown) or (CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unobvious))

                                     then
                                        RazlikaZamjena := format('-')
                                    else
                                        RazlikaZamjena := format(CalcDuplicate2.Difference);
                                end;
                            end;


                            CalcDuplicate2.reset;
                            CalcDuplicate2.copyfilters(CalcDuplicate);
                            CalcDuplicate2.SetFilter("New Gauge", '%1', true);
                            if CalcDuplicate2.FindFirst() then begin
                                if CalcDuplicate2."New Gauge" = true then begin
                                    if (CalcDuplicate2.Difference <= 0) and ((CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unknown) or (CalcDuplicate2."Source Data" = CalcDuplicate2."Source Data"::Unobvious)) then
                                        RazlikaZamjena1 := format('-')
                                    else
                                        RazlikaZamjena1 := format(CalcDuplicate2.Difference);
                                end;
                            end;
                            if CalcDuplicate."Reading Date From" <> 0D then
                                DatumiSpojeniOd += copystr(format(format(CalcDuplicate."Reading Date From", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + '         '
                            else
                                DatumiSpojeniOd += '';

                            if CalcDuplicate."Reading Date To" <> 0D then
                                DatumiSpojeniDo += copystr(format(format(CalcDuplicate."Reading Date TO", 0, '<day,2>.<month,2>.<year4>')), 1, 6) + '         '
                            else
                                DatumiSpojeniDo += '';


                        until CalcDuplicate.Next() = 0;

                    if StrLen(NacinOcitanjaZamjena) > 1 then
                        NacinOcitanjaZamjena := CopyStr(NacinOcitanjaZamjena, 1, StrLen(NacinOcitanjaZamjena) - 1);







                    if StrLen(MjeraciZamjena) > 1 then
                        MjeraciZamjena := CopyStr(MjeraciZamjena, 1, StrLen(MjeraciZamjena) - 1);


                    if StrLen(DatumiSpojenido) > 1 then
                        DatumiSpojenido := CopyStr(DatumiSpojenido, 1, StrLen(DatumiSpojenido) - 1);

                    if StrLen(DatumiSpojeniOd) > 1 then
                        DatumiSpojeniOd := CopyStr(DatumiSpojeniOd, 1, StrLen(DatumiSpojeniOd) - 1);


                    if DatumiSpojeniDo <> '' then begin

                    end;
                    if DatumiSpojeniOd <> '' then begin

                    end;

                    if MjeraciZamjena <> '' then begin

                        CalcDuplicate.reset;
                        CalcDuplicate.CopyFilters(DataItem5581);

                        CalcDuplicate.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                        CalcDuplicate.SetCurrentKey("Reading Date To");
                        CalcDuplicate.Ascending(false);
                        if CalcDuplicate.FindFirst() then
                            DatumOdMaxZamjena := CalcDuplicate."Reading Date To";


                        CalcDuplicate.reset;
                        CalcDuplicate.CopyFilters(DataItem5581);

                        CalcDuplicate.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                        CalcDuplicate.SetCurrentKey("Reading Date From", "Reading Date To");
                        CalcDuplicate.Ascending(false);
                        if CalcDuplicate.FindLast() then
                            DatumOdMinZamjena := CalcDuplicate."Reading Date From";
                    end;
                end;

                TaxD.Reset();
                TaxD.SetFilter("Valid Year", '%1', "Customer Stroke 2");
                if not TaxD.FindFirst() then
                    BrojacKupca := 0;
                TaxD.Reset();
                TaxD.SetFilter("Entity Code", '%1', DataItem5581."Customer No.");
                if not TaxD.FindFirst() then begin
                    BrojacKupca += 1;
                    TaxD.Init();
                    TaxD."Entity Code" := DataItem5581."Customer No.";
                    TaxD."Valid Year" := "Customer Stroke 2";
                    TaxD.Insert();


                end;

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
                CalcSum.CopyFilters(DataItem5581);
                CalcSum.SetFilter("Customer No.", '%1', DataItem5581."Customer No.");
                CalcSum.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
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


                    //    SumDifference := CalcSum.Difference;

                end;
                SumDifference := 0;
                CalcSum.Reset();
                CalcSum.CopyFilters(DataItem5581);
                CalcSum.SetFilter("Customer No.", '%1', DataItem5581."Customer No.");
                CalcSum.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                CalcSum.SetFilter(Difference, '>=%1', 0);
                if CalcSum.FindSet() then begin
                    CalcSum.CalcSums(Difference);
                    SumDifference := CalcSum.Difference;
                end;
                //SumMainCount

                CalcSum.Reset();
                CalcSum.CopyFilters(DataItem5581);
                CalcSum.SetFilter("Customer No.", '%1', DataItem5581."Customer No.");
                CalcSum.SetFilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                CalcSum.SetFilter("Basis maintenance", '>%1', 0);
                if CalcSum.findfirst() then begin
                    SumMainCount := CalcSum.count;

                end;

                TextParam2 := '';
                TextParam := '';
                if "Document No. Posting" <> '' then begin
                    if CopyStr("Document No. Posting", 1, 2) = '03' then begin
                        TextParam := 'RC-TU-02-03-03, Račun za prirodni gas';
                    end;
                end;
                if "Document No. Posting" <> '' then begin
                    if CopyStr("Document No. Posting", 1, 2) = '01' then begin
                        TextParam := 'RC-TU-02-03-01, Račun za prirodni gas';
                    end;
                end;

                if "Document No. Posting" <> '' then begin
                    if CopyStr("Document No. Posting", 1, 2) = '02' then begin
                        TextParam := 'RC-TU-02-03-02, Račun za prirodni gas';
                    end;
                end;


                if ("Winter Pecentage" <> 0) then
                    WInterYs := "Winter Pecentage"
                ELSE
                    WInterYs := "Summer Pecentage";

                NewValueDec := "New Value";
                //if ("New Value" = 0) and ("Category Customer" = "Category Customer"::"Large Economy") then
                //  NewValueDec := "Old Value";
                CER.Reset();
                CER.SetFilter("Currency Code", '%1', DataItem5581."Currency Code");
                //  CER.SetFilter("Starting Date", '<=%1', DataItem5581."Calculation Date To");

                ChGet2.get(DataItem5581.Code);

                if (ChGet2."Month Of GAS Calculation" = DataItem5581."Month Of GAS Calculation") and (ChGet2."Year Of GAS Calculation" = DataItem5581."Year Of GAS Calculation") then
                    CER.SetFilter("Starting Date", '<=%1', DataItem5581."Calculation Date To")
                else
                    CER.SetFilter("Starting Date", '<=%1', DataItem5581."Reading Date To");

                CER.SetCurrentKey("Starting Date");
                CER.Ascending;
                if CER.FindLast() then
                    BillingSignatoryName := '';
                DataItemR.Reset();
                DataItemR.CopyFilters(DataItem5581);
                DataItemR.SetFilter("Customer No.", '%1', DataItem5581."Customer No.");
                DataItemR.SetFilter("Month Of GAS Calculation", '%1', DataItem5581."Month Of GAS Calculation");
                DataItemR.SetFilter("Year Of GAS Calculation", '%1', DataItem5581."Year Of GAS Calculation");
                if DataItemR.FindFirst() then begin
                    DataItemR.CalcSums(Total, "War Calculation (LVT)");
                    if DataItemR.Total + DataItemR."War Calculation (LVT)" <> 0 then begin
                        SlovimaRez := UpperCase(copystr(MyCU.NumberToWordsBilling(round(DataItemR.Total + DataItemR."War Calculation (LVT)", 0.01, '='), TRUE), 1, 1)) +
    LowerCase(copystr(MyCU.NumberToWordsBilling(round(DataItemR.Total + DataItemR."War Calculation (LVT)", 0.01, '='), TRUE), 2, strlen(MyCU.NumberToWordsBilling(round(DataItemR.Total + DataItemR."War Calculation (LVT)", 0.01, '='), TRUE))));
                    end else begin
                        SlovimaRez := ''
                        ;
                    end;
                end else begin
                    SlovimaRez := '';
                end;



                CH.Reset();
                ch.SetFilter(Code, '%1', DataItem5581.Code);
                if ch.FindFirst() then begin
                    ch.CalcFields("Billing Signatory", "Billing Sign");
                    EmpBilling.Reset();
                    EmpBilling.SetFilter("No.", '%1', ch."Billing Signatory Emp");
                    if EmpBilling.FindFirst() then
                        BillingSignatoryName := EmpBilling."First Name" + ' ' + EmpBilling."Last Name"
                    else
                        BillingSignatoryName := '';
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', ch."Billing Signatory Emp");
                    ecl.SetFilter("Starting Date", '<=%1', ch."Calculation Date To");
                    ecl.SetCurrentKey("Starting Date");
                    ecl.Ascending;
                    if ecl.FindLast() then begin
                        CH."Billing Signatory Position" := ecl."Position Description";

                    end;

                end;
                Napomena1 := '';
                Napomena2 := '';
                napomena3 := '';
                napomena4 := '';
                napomena5 := '';
                napomena6 := '';
                napomena7 := '';
                napomena8 := '';
                napomena9 := '';
                Napomena10 := '';
                if Date2DMY(ch."Calculation Date To", 2) = 1 then
                    Mjesec[1] := 'Januar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 2 then
                    Mjesec[1] := 'Februar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 3 then
                    Mjesec[1] := 'Mart' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 4 then
                    Mjesec[1] := 'April' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 5 then
                    Mjesec[1] := 'Maj' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 6 then
                    Mjesec[1] := 'Juni' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 7 then
                    Mjesec[1] := 'Juli' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 8 then
                    Mjesec[1] := 'Avgust' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 9 then
                    Mjesec[1] := 'Septembar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 10 then
                    Mjesec[1] := 'Oktobar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 11 then
                    Mjesec[1] := 'Novembar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));
                if Date2DMY(ch."Calculation Date To", 2) = 12 then
                    Mjesec[1] := 'Decembar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3));

                if Date2DMY(ch."Calculation Date To", 2) = 1 then
                    Mjesec[2] := 'Januar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 2 then
                    Mjesec[2] := 'Februar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 3 then
                    Mjesec[2] := 'Mart' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 4 then
                    Mjesec[2] := 'April' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 5 then
                    Mjesec[2] := 'Maj' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 6 then
                    Mjesec[2] := 'Juni' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 7 then
                    Mjesec[2] := 'Juli' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 8 then
                    Mjesec[2] := 'Avgust' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 9 then
                    Mjesec[2] := 'Septembar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 10 then
                    Mjesec[2] := 'Oktobar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 11 then
                    Mjesec[2] := 'Novembar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);
                if Date2DMY(ch."Calculation Date To", 2) = 12 then
                    Mjesec[2] := 'Decembar' + ' ' + FORMAT(DATE2DMY(ch."Calculation Date To", 3) - 1);

                if (DataItem5581."EF Activity" = '') and ("Category Customer" = "Category Customer"::Household) then
                    "EF Activity" := 'Stambeni sektor';

                if ("Customer Balance") > 1 then
                    Napomena1 := 'Račun se smatra opomenom pred utuženje i prekid isporuke gasa.' + format(CharEnter)
                else
                    Napomena1 := 'Zahvaljujemo Vam se na uredno izmirenim obavezama.' + format(CharEnter);

                if ("Bill delivery" = "Bill delivery"::Quarterly) and ("Last Year Calculation" = 0) and ("Source Data" = "Source Data"::Unobvious)
                then begin
                    Napomena2 := '';
                end
                else begin
                    if ("Last Year Calculation" <> 0) or ("Last Year Calculation" = 0) then
                        Napomena2 := 'Prosjek kategorije ' + "EF Activity" + ' za ' + mjesec[1] + '.: ' + format("Average Calculation") + ' Sm3. Vaša potrošnja za ' + mjesec[2] + '.: ' + format(round("Last Year Calculation", 1, '>')) + ' Sm3.' + format(CharEnter)

                    else
                        Napomena2 := 'Prosjek kategorije ' + "EF Activity" + ' za ' + mjesec[1] + '.: ' + format("Average Calculation") + ' Sm3.' + format(CharEnter);
                end;
                Napomena3 := 'Rok plaćanja: 15 dana od datuma izdavanja računa.' + format(CharEnter);

                if "Subsidies Amount" <> 0 then begin
                    if Difference <> 0 then begin
                        SubA := Round("Subsidies Amount" / Difference, 0.01, '>');

                        Napomena4 := 'Razlika u prodajnoj cijeni ' + format(SubA) + ' KM/Sm3 bez PDV-a' + format(CharEnter);
                    end;
                    ;
                    Napomena5 := 'Obračun subvencije: ' + format(SM3) + ' x ' + format(SubA) + ' KM = ' + format("Subsidies Amount") + ' KM.  Iznos PDV-a (17%) = ' + format("Subsidies VAT Amount") + ' KM. Ukupno = ' + format("Subsidies Total Amount") + ' KM.' + format(CharEnter);
                    Napomena6 := 'Iznos subvencije od ' + format("Subsidies Total Amount") + ' KM je uključen u Vaš saldo' + format(CharEnter);



                end;

                if DataItem5581."Calculation Date To" = 0D then
                    CalcD := ch."Calculation Date To"
                else
                    CalcD := DataItem5581."Calculation Date To";

                if "War Calculation (LVT)" <> 0 then begin
                    WarSetup.Reset();
                    WarSetup.SetFilter("Customer Category", '%1', DataItem5581."Category Customer");
                    WarSetup.SetFilter(Month, '%1', Date2DMY(DataItem5581."Calculation Date To", 2));
                    if WarSetup.findfirst then begin


                        if WarSetup.Totaling = '1..4' then
                            Napomena7 := 'Taksa je obračunata na osnovu utrošenih količina za period janur - april ' + format(Date2DMY(DataItem5581."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                        if WarSetup.Totaling = '5..10' then
                            Napomena7 := 'Taksa je obračunata na osnovu utrošenih količina za period maj - oktobar ' + format(Date2DMY(DataItem5581."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);




                        if WarSetup.Totaling = '11..12' then
                            Napomena7 := 'Taksa je obračunata na osnovu utrošenih količina za period novembar - decembar ' + format(Date2DMY(DataItem5581."Calculation Date To", 3)) + ' prema srednjem kursu CH BIH na dan ' + format(CalcD, 0, '<day,2>.<month,2>.<year4>') + format(CharEnter);


                    end;
                end;

                if DataItem5581."Bill delivery" = DataItem5581."Bill delivery"::Quarterly then begin
                    Napomena8 := 'Račun za naknadu mjernog mjesta dostavljaju se kvartalno, u slučaju da se ne evidentira potrošnja prirodnog gasa.' + format(CharEnter);
                    Napomena9 := 'Ukoliko želite mjesečnu dostavu računa za naknadu mjernog mjesta, molimo da nas obavijestite u pisanoj formi.' + format(CharEnter);
                end;

                if (Unobvious = true)
                then
                    Napomena10 := 'S obzirom da nekoliko mjeseci nismo mogli očitati vaše mjerilo protoka gasa, nakon izvršenog očitanja urađena je raspodjela potrošnje gasa po mjesecima.' + format(CharEnter);


                NapomenaAll := napomena1 + napomena2 + napomena3 + napomena4 + napomena5 + napomena6 + napomena7 + napomena8 + napomena9 + Napomena10;
                CH.Reset();
                ch.SetFilter(Code, '%1', DataItem5581.Code);
                if ch.FindFirst() then begin

                    if DataItem5581."Calculation Date From" = 0D then
                        CaldF := ch."Calculation Date From"
                    else
                        CaldF := DataItem5581."Calculation Date From";

                    if DataItem5581."Calculation Date To" = 0D then
                        CalcD := ch."Calculation Date To"
                    else
                        CalcD := DataItem5581."Calculation Date To";

                    if CalcD <> 0D then
                        DueOrg := calcdate('<+15D>', CalcD)
                    else
                        DueOrg := 0D;


                end;
                ch.CalcFields("Billing Signatory", "Billing Sign");



                CalcSu.Reset();

                CalcSu.CopyFilters(DataItem5581);
                CalcSu.setfilter("CUstomer No.", '%1', DataItem5581."Customer No.");
                CalcSu.setfilter("Document No. Posting", '%1', DataItem5581."Document No. Posting");
                if CalcSu.FindFirst() then
                    CalcSu.CalcSums(Total, "War Calculation (LVT)");
                if "Customer Prepayment" - CalcSu.Total - CalcSu."War Calculation (LVT)" > 0 then begin

                    NoviSaldo := "Customer Prepayment" - CalcSu.Total - round(CalcSu."War Calculation (LVT)", 0.01, '=');
                    //  "Customer Prepayment" := "Customer Prepayment" - Total - "War Calculation (LVT)";

                end
                else begin

                    if "Customer Prepayment" > 0 then begin
                        NoviSaldo := (CalcSu.total + round(CalcSu."War Calculation (LVT)", 0.01, '=') - "Customer Prepayment") + "Customer Balance";

                    end
                    else begin

                        NoviSaldo := "Customer Balance" + "Customer Prepayment" + CalcSu.Total + round(CalcSu."War Calculation (LVT)", 0.01, '=');
                    end;
                end;

                "Customer Balance" := Round("Customer Balance", 0.01, '=');
                "Customer Prepayment" := Round("Customer Prepayment", 0.01, '=');

                IznosDugIliPrep := 0;
                DugIliPrep := '';
                ukupdugiliprep := '';
                ukupdugiliprep := '';

                if "Customer Balance" > 0 then begin
                    DugIliPrep := 'dugovanje';
                    IznosDugIliPrep := "Customer Balance";
                end;
                if "Customer Prepayment" > 0 then begin
                    DugIliPrep := 'preplata';
                    IznosDugIliPrep := "Customer Prepayment";
                end;

                if ("Customer Balance" = 0) and ("Customer Prepayment" = 0) then begin
                    ukupdugiliprep := 'Dug po računu ';
                end
                else begin
                    if ("Customer Balance" <> 0) then begin
                        ukupdugiliprep := 'Ukupan dug ';
                    end;

                end;

                if ("Customer Prepayment" <> 0) then begin

                    Rez := "Customer Prepayment" - CalcSu.Total - CalcSu."War Calculation (LVT)";
                    if rez > 0 then
                        ukupdugiliprep := 'Ukupna preplata '
                    else
                        ukupdugiliprep := 'Ukupan dug ';

                end;

                CustomerNow.Reset();
                CustomerNow.SetFilter("Customer No.", '%1', "Customer No.");
                CustomerNow.SetFilter("Starting Date", '<=%1', "Calculation Date To");
                CustomerNow.SetCurrentKey("Starting Date");
                CustomerNow.Ascending;
                if CustomerNow.FindLast() then begin
                end
                else begin
                    CustomerNow.Description := '';
                    CustomerNow."Starting Date" := 0D;
                end;
                CalcD := 0D;
                CaldF := 0D;
                comp.get;
                comp.CalcFields(Picture1, Picture2, Picture3, Picture);
                CH.Reset();
                ch.SetFilter(Code, '%1', DataItem5581.Code);
                if ch.FindFirst() then begin

                    ch.CalcFields("Billing Signatory", "Billing Sign");
                    if DataItem5581."Calculation Date From" = 0D then
                        CaldF := ch."Calculation Date From"
                    else
                        CaldF := DataItem5581."Calculation Date From";

                    if DataItem5581."Calculation Date To" = 0D then
                        CalcD := ch."Calculation Date To"
                    else
                        CalcD := DataItem5581."Calculation Date To";



                end;
                CalcS.Get();

                if DataItem5581."Method of calculation" = DataItem5581."Method of calculation"::"1" then
                    Metod := '1';
                if DataItem5581."Method of calculation" = DataItem5581."Method of calculation"::"2" then
                    Metod := '2';
                if DataItem5581."Method of calculation" = DataItem5581."Method of calculation"::"3" then
                    Metod := '3';
                if DataItem5581."Method of calculation" = DataItem5581."Method of calculation"::"4" then
                    Metod := '4';



                if "Document No. Posting" = '' then begin
                    CustT.Reset();
                    CustT.SetFilter("Bill Category", '%1', "Category Customer");
                    if CustT.FindFirst() then begin

                        //  NoSeriesMgt.InitSeries(CustT."No. Series Bill", '', 0D, "Document No. Posting", Noseries);
                        //       Modify();
                    end;
                    // "Document No. Posting" := "Document No. Posting" + '/' + format(copystr(format(Date2DMY(ch."Calculation Date To", 3)), 3, 4));

                end
                else begin
                    // "Document No. Posting" := "Document No. Posting";


                end;


                Doc := delchr("Document No. Posting" + '/' + format(copystr(format(Date2DMY(CalcD, 3)), 3, 2)), '=', '01-');
                Doc := delchr("Document No. Posting" + '/' + format(copystr(format(Date2DMY(CalcD, 3)), 3, 2)), '=', '02-');
                Doc := delchr("Document No. Posting" + '/' + format(copystr(format(Date2DMY(CalcD, 3)), 3, 2)), '=', '03-');
                DocRez := Dataitem5581."Customer No." + Doc;



                if StrLen(DocRez) < 15 then begin

                    for BrojacI := 1 to 15 - strlen(DocRez) do begin
                        DocRez := '0' + DocRez;
                        BrojacI += 1;
                    end;

                end;

                if DataItem5581."Category Customer" = DataItem5581."Category Customer"::Household then
                    BarCode1 := GenerateQRCodeCU(DocRez);


                Doc := "Document No. Posting";




                if DataItem5581."Category Customer" = DataItem5581."Category Customer"::Household then
                    BarCode2 := GenerateQRCodeCU(Doc);


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
                banacc.SetFilter("No.", CompanyInfo."Bank No. 11");
                if banacc.FindFirst() then begin

                    transaction11Name := banacc.Name;
                    transaction11 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 12");
                if banacc.FindFirst() then begin

                    transaction12Name := banacc.Name;
                    transaction12 := banacc."Bank Account No.";
                end;
                BrojacRandom += 1;

                if BrojacRandom = 1 then begin
                    transactionresult := transaction1 + ' ' + transaction1Name;
                end;
                if BrojacRandom = 2 then begin
                    transactionresult := transaction2 + ' ' + transaction2Name;
                end;

                if BrojacRandom = 3 then begin
                    transactionresult := transaction3 + ' ' + transaction3Name;
                end;

                if BrojacRandom = 4 then begin
                    transactionresult := transaction4 + ' ' + transaction4Name;
                end;
                if BrojacRandom = 6 then begin
                    transactionresult := transaction5 + ' ' + transaction5Name;
                end;
                if BrojacRandom = 6 then begin
                    transactionresult := transaction6 + ' ' + transaction6Name;
                end;
                if BrojacRandom = 7 then begin
                    transactionresult := transaction7 + ' ' + transaction7Name;
                end;
                if BrojacRandom = 8 then begin
                    transactionresult := transaction8 + ' ' + transaction8Name;
                end;
                if BrojacRandom = 9 then begin
                    transactionresult := transaction9 + ' ' + transaction9Name;
                end;
                if BrojacRandom = 10 then begin
                    transactionresult := transaction10 + ' ' + transaction10Name;
                end;

                if BrojacRandom = 11 then begin
                    transactionresult := transaction11 + ' ' + transaction11Name;
                end;
                if BrojacRandom = 12 then begin
                    transactionresult := transaction12 + ' ' + transaction12Name;
                end;

                if BrojacRandom = 12 then
                    BrojacRandom := 0;

                rh.Reset();
                rh.SetFilter(WH, '%1', DataItem5581.code);
                rh.SetFilter("Customer No.", '%1', DataItem5581."Customer No.");
                if rh.FindFirst() then
                    OpomenaCode := rh."No."
                else
                    OpomenaCode := '';
                Brojac := 0;

                if OpomenaCode <> '' then
                    ImaOpomenu := true
                else
                    ImaOpomenu := false;

                CustFloorCustomer2 := DataItem5581."Floor Customer 2";
                CustFloorCustomer := DataItem5581."Floor Customer";
                CustStreetNoText2 := DataItem5581."Street No.2 Text";
                if DataItem5581."Floor Customer 2" = '' then begin
                    Cust.Reset();
                    Cust.SetFilter("No.", '%1', DataItem5581."Customer No.");
                    if Cust.FindFirst() then begin
                        CustFloorCustomer2 := Cust."Floor Customer 2";
                        CustFloorCustomer := Cust."Floor Customer";

                    end;

                end;
                if DataItem5581."Street No.2 Text" <> '' then begin
                    Cust.Reset();
                    Cust.SetFilter("No.", '%1', DataItem5581."Customer No.");
                    if Cust.FindFirst() then begin
                        CustStreetNoText2 := Cust."Street No.2 Text";

                    end;
                end;

            end;


        }





    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Select an option")
                {
                    Caption = 'Select an option';

                    field(ReportLayout; ReportLayout)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Report Layout';
                        //   TableRelation="Custom Report Layout".Description wher;

                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomReportLayout: Record "Custom Report Layout";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            CRLPage: Page "Custom Report Layouts";
                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50182);
                            CRLPage.SetTableView(CustomReportLayout);

                            CRLPage.LOOKUPMODE(TRUE);
                            IF CRLPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                CRLPage.GETRECORD(CustomReportLayout);
                                ReportLayout := CustomReportLayout.Description;
                                ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));
                            end;
                        end;
                    }

                    field(HideeOption; HideeOption)
                    {
                        Caption = 'Hide Option';

                    }
                    field(HideeOptionO; HideeOptionO)
                    {
                        Caption = 'Hide Option Reminder';

                    }
                }
            }
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
        CL: Record "Custom Report Layout";
    begin
        CL.Reset();
        CL.SetFilter("Report ID", '%1', 50182);
        if cl.FindFirst() then
            ReportLayout := cl.Description;

    end;

    trigger OnPreReport()
    var

        myInt: Integer;



    begin
        CharEnter := 10;

        comp.get;
        comp.CalcFields(Picture1, Picture2, Picture3, Picture);


    end;



    var

        comp: Record "Company Information";
        RHFind: Record "Reminder Header";
        HideeOptionO: Boolean;
        ChGet2: Record "Calcuation Header";
        CalcD: Date;
        NacinOcitanjaZamjena: Text;
        OldZamjena: text;
        RazlikaZamjena: text;
        NewZamjena: Text;
        OldZamjena1: text;
        RazlikaZamjena1: text;
        NewZamjena1: Text;
        DatumiSpojeniOd: Text;
        DatumiSpojenido: Text;
        MjeraciZamjena: text;
        RazmaciAdd: text;
        BrojacRazmaka: integer;
        CategTemp: Record Template_Message temporary;
        DatumOdMinZamjena: date;
        DatumOdMaxZamjena: Date;
        SumSm3: Decimal;
        SumMain: Decimal;
        SumMainCount: Integer;
        SumGAS___amount: Decimal;
        SUmTotal_without_VAT: Decimal;
        SUmTotalVat: Decimal;
        SumWar_Calculation__LVT_: Decimal;
        CalcSum: Record "Calculation Journal Line";
        CaldF: Date;
        HideeOption: boolean;
        CharEnter: char;
        NapomenaAll: text[20000];
        banacc: Record "Bank Account";
        CompanyInfo: Record "Company Information";

        CustomerNow: Record "Customer Ledger Entry";
        Rez: Decimal;
        Mjesec: array[12] of Text;

        OpomenaCode: code[20];

        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        transaction1: text[100];
        transaction3: text[100];

        transaction3Name: text[100];

        transaction2Name: text[100];
        transaction4Name: text[100];

        CalcSu: Record "Calculation Journal Line";
        transaction4: Text[100];
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];

        IznosSaldo: Decimal;

        transaction8Name: TEXT[100];
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];

        transaction10: TEXT[100];
        transaction11Name: TEXT[100];
        transaction11: TEXT[100];
        transaction12Name: TEXT[100];
        transaction12: TEXT[100];

        NoviSaldo: Decimal;
        DugIliPrep: text[250];
        ReportLayout: Text;
        ukupdugiliprep: text[250];
        BrojacI: Integer;

        BarCode1: text;
        CER: Record "Currency Exchange Rate";

        transactionResult: text[250];
        BarCode2: text;

        Napomena1: Text[250];
        Napomena2: Text[250];
        Napomena3: Text[250];
        Napomena4: Text[250];
        Napomena5: Text[250];
        CH: Record "Calcuation Header";
        BillingSignatoryName: text[250];
        us: Record "User Setup";
        OrgJed: Text[250];
        EmpBilling: Record Employee;
        Napomena6: text[250];
        ECL: Record "Employee Contract Ledger";
        Napomena7: text[250];
        IznosDugIliPrep: decimal;
        WInterYs: Decimal;
        Napomena8: text[250];
        Napomena9: text[250];
        Napomena10: text[250];

        WarSetup: Record "War Debt Setup";

        BrojacKupca: Integer;

        TaxD: Record "Tax deduction list" temporary;


        CustT: Record "Customer Templ.";
        BrojacRedovaaaaa: Integer;
        Brojaczamjena: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;


        ImaOpomenu: Boolean;
        RH: Record "Reminder Header";
        RL: Record "Reminder Line";
        NewValueDec: Decimal;
        SifraInitCust: Code[20];
        DocumentInitCust: Code[20];
        SUmGasPart: Decimal;
        SumGasVat: Decimal;
        SumMainVat: Decimal;
        SumDifference: decimal;
        BrojacRandom: Integer;
        TextParam: Text;
        DocRez: Text;
        TextParam2: Text;
        CalcS: Record "Calculation Setup";
        TotalOpomene: Decimal;
        RedniBrojIspis: Text;
        SlovimaRez: text[250];
        Brojac: Integer;
        SubA: Decimal;

        Cust: Record Customer;
        Metod: Text;
        CustFloorCustomer2, CustStreetNoText2 : Code[20];
        CustFloorCustomer: code[20];



        DueOrg: date;

    // Mjesec: array[14] of Text;

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

    procedure Setparam(SetLayout: Text[250]; CustomerNo: code[20]; DocumentoNo: code[20])
    var
        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
    begin
        SifraInitCust := CustomerNo;
        DocumentInitCust := DocumentoNo;

        CustomReportLayout.reset;
        CustomReportLayout.SetFilter("Report ID", '%1', 50182);
        CustomReportLayout.SetFilter(Description, '%1', SetLayout);
        if CustomReportLayout.FindFirst() then begin
            ReportLayout := CustomReportLayout.Description;
            ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));
        end;
    end;





    /*
        local procedure InitArguments(TextIspis: Text): text
        var
            BaseURL: Text;
            Base64Convert: Codeunit "Base64 Convert";
            TempBlob: Codeunit "Temp Blob";
            TypeHelper: Codeunit "Type Helper";
            client: HttpClient;
            response: HttpResponseMessage;
            InStr: InStream;

        begin

            client.get('https://barcode.tec-it.com/barcode.ashx?data=' + TextIspis + '&code=Code128', response);


            TempBlob.CreateInStream(InStr);
            response.Content().ReadAs(InStr);
            BarCode1 := Base64Convert.ToBase64(InStr);
            exit(BarCode1);
        end;
        */

    local procedure GenerateQRCodeCU(InputText: Text): Text
    var
        QRGenerator: Codeunit "QR Code Generator";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStream: OutStream;
        InStream: InStream;
    begin
        // Generiši QR code kao image
        TempBlob.CreateOutStream(OutStream);
        QRGenerator.Generate(InputText, OutStream);

        TempBlob.CreateInStream(InStream);

        // Pretvori image u Base64
        exit(Base64Convert.ToBase64(InStream));
    end;

    local procedure InitArguments2(TextIspis: Text): text
    var
        BaseURL: Text;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        client: HttpClient;
        response: HttpResponseMessage;
        InStr: InStream;

    begin
        client.get('https://barcode.tec-it.com/barcode.ashx?data=' + TextIspis + '&code=Code128', response);
        TempBlob.CreateInStream(InStr);
        response.Content().ReadAs(InStr);
        BarCode2 := Base64Convert.ToBase64(InStr);
        exit(BarCode2);
    end;

}