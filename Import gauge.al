xmlport 50046 "Import Gauge GAS"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import XML';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Calculation Journal Line"; "Calculation Journal Line")
            {
                AutoSave = false;
                MinOccurs = Zero;
                XmlName = 'Calculation_Journal_Line';

                textelement(SifraObracuna)
                {
                    MinOccurs = Zero;
                }
                textelement(Autoint_)
                {
                    MinOccurs = Zero;
                }
                textelement(DateFrom)
                {
                    MinOccurs = Zero;
                }
                textelement(DateTo)
                {
                    MinOccurs = Zero;
                }
                textelement(CPC)
                {
                    MinOccurs = Zero;
                }
                textelement(AP)
                {
                    MinOccurs = Zero;
                }
                textelement(SF)
                {
                    MinOccurs = Zero;
                }
                textelement(CC)
                {
                    MinOccurs = Zero;
                }
                textelement(GaugeCode)
                {
                    MinOccurs = Zero;
                }
                textelement(MMCode)
                {
                    MinOccurs = Zero;
                }
                textelement(PreviousC)
                {
                    MinOccurs = Zero;
                }
                textelement(CustomerNo)
                {
                    MinOccurs = Zero;
                }
                textelement(PostCodeCust)
                {
                    MinOccurs = Zero;
                }

                textelement(Email_Delivery)
                {
                    MinOccurs = Zero;
                }
                textelement(Email_Delivery_Date)
                {
                    MinOccurs = Zero;
                }
                textelement(Email_Delivery_Date_to)
                {
                    MinOccurs = Zero;
                }
                textelement(Post_Code_Customer_D)
                {
                    MinOccurs = Zero;
                }
                textelement(City_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(City_Customer_D)
                {
                    MinOccurs = Zero;
                }
                textelement(Address_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(StreetMM)
                {
                    MinOccurs = Zero;
                }
                textelement(DwelingType)
                {
                    MinOccurs = Zero;
                }
                textelement(Street)
                {
                    MinOccurs = Zero;
                }
                textelement(Post_Code_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(City_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Street_No_Text)
                {
                    MinOccurs = Zero;
                }
                textelement(Street_No_TextMM)
                {
                    MinOccurs = Zero;
                }
                textelement(Status_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Current_Status_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Measuring_point_off)
                {
                    MinOccurs = Zero;
                }
                textelement(Measuring_point_off_Date)
                {
                    MinOccurs = Zero;
                }
                textelement(Street_No__int)
                {
                    MinOccurs = Zero;
                }
                textelement(Floor)
                {
                    MinOccurs = Zero;
                }


                textelement(Measuring_Point_string)
                {
                    MinOccurs = Zero;
                }
                textelement(Measuring_Point_Stroke)
                {
                    MinOccurs = Zero;
                }
                textelement(Apartment_No_)
                {
                    MinOccurs = Zero;
                }
                textelement(ApartmentNo2a)
                { MinOccurs = Zero; }
                textelement(Municipality_Code_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Municipality_Name_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Customer_Prepayment)
                {
                    MinOccurs = Zero;
                }
                textelement(Summer_Zone)
                {
                    MinOccurs = Zero;
                }
                textelement(GasPosting)
                {
                    MinOccurs = Zero;
                }

                textelement(MM_Description)
                {
                    MinOccurs = Zero;
                }
                textelement(Reading_Mode)
                {
                    MinOccurs = Zero;
                }
                textelement(Mobile_No_)
                {
                    MinOccurs = Zero;
                }
                textelement(TempCJL_Data)
                {
                    MinOccurs = Zero;
                }
                textelement(Type_of_reading)
                {
                    MinOccurs = Zero;
                }
                textelement(Reading_Time)
                {
                    MinOccurs = Zero;
                }
                textelement(Street_Name_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Posting)
                {
                    MinOccurs = Zero;
                }
                textelement(Distribution)
                {
                    MinOccurs = Zero;
                }
                textelement(Distribution_read)
                {
                    MinOccurs = Zero;
                }
                textelement(Specification)
                {
                    MinOccurs = Zero;
                }
                textelement(Bill_delivery)
                {
                    MinOccurs = Zero;
                }
                textelement(RMS_Maintenance)
                {
                    MinOccurs = Zero;
                }
                textelement(Winter_Zone)
                {
                    MinOccurs = Zero;
                }
                textelement(Remotely_Type)
                {
                    MinOccurs = Zero;
                }
                textelement(Transit_Zone)
                {
                    MinOccurs = Zero;
                }
                textelement(Floor_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Apartment_No__Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Home_No__Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Home_No_)
                {
                    MinOccurs = Zero;
                }
                textelement(Category_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Categ_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(Customer_No_)
                {
                    MinOccurs = Zero;
                }
                textelement(MZ_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(MZ_Name_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Method_of_calculation)
                {
                    MinOccurs = Zero;
                }
                textelement(MZ_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(MZ_Name_MM)
                {
                    MinOccurs = Zero;
                }
                textelement(ZoneStroke)
                {
                    MinOccurs = Zero;
                }
                textelement(ZoneStroke2)
                {
                    MinOccurs = Zero;
                }
                textelement(ZoneStrokeMM)
                {
                    MinOccurs = Zero;
                }

                textelement(Code)
                {
                    MinOccurs = Zero;
                }
                textelement(Month_of_Calculation)
                {
                    MinOccurs = Zero;
                }
                textelement(Year_of_Calculation)
                {
                    MinOccurs = Zero;
                }
                textelement(Month_Of_GAS_Calculation)
                {
                    MinOccurs = Zero;
                }
                textelement(Year_Of_GAS_Calculation)
                {
                    MinOccurs = Zero;
                }
                textelement(Purchase_Unit_Price)
                {
                    MinOccurs = Zero;
                }
                textelement(Distribution_Unit_Price)
                {
                    MinOccurs = Zero;
                }
                textelement(Sales_Unit_Price)
                {
                    MinOccurs = Zero;
                }
                textelement(Unit_Price)
                {
                    MinOccurs = Zero;
                }
                textelement(Customer_Balance)
                {
                    MinOccurs = Zero;
                }
                textelement(Customer_Name)
                {
                    MinOccurs = Zero;
                }
                textelement(Registration_No_)
                {
                    MinOccurs = Zero;
                }
                textelement(VAT_Registration_No_)
                {
                    MinOccurs = Zero;
                }
                textelement(Customer_string)
                {
                    MinOccurs = Zero;
                }
                textelement(Customer_Stroke)
                {
                    MinOccurs = Zero;
                }
                textelement(Street_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Address_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Address_Customer2)
                {
                    MinOccurs = Zero;
                }
                textelement(ReminderValue)
                {
                    MinOccurs = Zero;
                }

                textelement(Street_Name_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Municipality_Code_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Municipality_Name_Customer)
                {
                    MinOccurs = Zero;
                }
                textelement(Serial_Number)
                {
                    MinOccurs = Zero;
                }
                textelement(Gauge_Size)
                {
                    MinOccurs = Zero;
                }
                textelement(Max_Difference)
                {
                    MinOccurs = Zero;
                }
                textelement(Old_Value)
                {
                    MinOccurs = Zero;
                }
                textelement(New_Value)
                {
                    MinOccurs = Zero;
                }
                textelement(Previous_Date)
                {
                    MinOccurs = Zero;
                }
                textelement(Previous_method_of_calculation)
                {
                    MinOccurs = Zero;
                }
                textelement(EL_Volume_Code)
                {
                    MinOccurs = Zero;
                }
                textelement(EL_Volume_Description)
                {
                    MinOccurs = Zero;
                }

                textelement(EL_Correctior_Type)
                {
                    MinOccurs = Zero;
                }
                textelement(Fictive)
                {
                    MinOccurs = Zero;
                }
                textelement(Temp)
                {
                    MinOccurs = Zero;
                }
                textelement(TemperatureNew)
                {
                    MinOccurs = Zero;
                }

                textelement(Pressure)
                {
                    MinOccurs = Zero;
                }
                textelement(PressureNew)
                {
                    MinOccurs = Zero;
                }
                textelement(Uncorrection)
                {
                    MinOccurs = Zero;
                }
                textelement(UncorrectionNew)
                {
                    MinOccurs = Zero;
                }


                textelement(Correction)
                {
                    MinOccurs = Zero;
                }
                textelement(CorrectionNew)
                {
                    MinOccurs = Zero;
                }
                textelement(TempCorr)
                {
                    MinOccurs = Zero;
                }
                textelement(PressureCOrr)
                {
                    MinOccurs = Zero;
                }


                textelement(MSummer)
                {
                    MinOccurs = Zero;
                }
                textelement(MWinter)
                {
                    MinOccurs = Zero;

                }
                textelement(RDateFrom)
                {
                    MinOccurs = Zero;
                }
                textelement(RDateTo)
                {
                    MinOccurs = Zero;
                }
                textelement(HomeNo2) { MinOccurs = Zero; }
                textelement(LastYearCacl)
                {
                    MinOccurs = Zero;
                }
                textelement(Act)
                { MinOccurs = Zero; }

                textelement(ActEf)
                { MinOccurs = Zero; }

                textelement(ActEU)
                { MinOccurs = Zero; }

                textelement(Average_Calculation)
                { MinOccurs = Zero; }

                /*
                + ';' + Format(cjl.Activity)
+ ';' + Format(cjl."EF Activity")
+ ';' + Format(cjl."EU Activity");
*/

                textelement(Customer_String_2)
                { MinOccurs = Zero; }
                textelement(customerstroke)
                {
                    MinOccurs = Zero;

                }

                textelement(customerstroke2)
                {
                    MinOccurs = Zero;

                }

                textelement(MZ_Customer_C)
                {
                    MinOccurs = Zero;

                }


                textelement(MZ_Customer2)
                {
                    MinOccurs = Zero;

                }


                textelement(MZ_Customer_CName)
                {
                    MinOccurs = Zero;

                }


                textelement(MZ_CustomerName2)
                {
                    MinOccurs = Zero;

                }

                textelement(Floor_Customer_C)
                {
                    MinOccurs = Zero;

                }
                textelement(Floor_Customer_C2)
                {
                    MinOccurs = Zero;

                }


                textelement(Street_Customer_C)
                {
                    MinOccurs = Zero;

                }
                textelement(Floor_Customer_C2_1)
                {
                    MinOccurs = Zero;

                }


                textelement(Street_Customer_C2)
                {
                    MinOccurs = Zero;

                }
                textelement(StreetName_Customer_C2)
                {
                    MinOccurs = Zero;

                }
                textelement(StreetName_Customer_C2_1)
                {
                    MinOccurs = Zero;

                }

                textelement(Mun_Customer_C2)
                {
                    MinOccurs = Zero;

                }
                textelement(Mun_Customer_C2_1)
                {
                    MinOccurs = Zero;

                }

                textelement(Mun_Customer_C2N)
                {
                    MinOccurs = Zero;

                }
                textelement(Mun_Customer_C2_1N)
                {
                    MinOccurs = Zero;

                }

                textelement(StretNo)
                {
                    MinOccurs = Zero;

                }
                textelement(StretNo2)
                {
                    MinOccurs = Zero;

                }

                textelement(StretNoText)
                {
                    MinOccurs = Zero;

                }
                textelement(StretNo2Text2)
                {
                    MinOccurs = Zero;

                }
                textelement(StretNo2Text2MM)
                {
                    MinOccurs = Zero;

                }


                textelement(OldG)
                {
                    MinOccurs = Zero;

                }
                textelement(NewG)
                {
                    MinOccurs = Zero;

                }
                textelement(BillP)
                {
                    MinOccurs = Zero;

                }

                textelement(BillA)
                {
                    MinOccurs = Zero;

                }
                textelement(Unbiv)
                {
                    MinOccurs = Zero;
                }
                textelement(AjdP)
                {
                    MinOccurs = Zero;
                    //vrijednost

                }
                textelement(AdjDate)
                {
                    MinOccurs = Zero;

                }
                textelement(EmailDelivery)
                {
                    MinOccurs = Zero;

                }
                textelement(STrretNoFloor)
                {
                    minoccurs = zero;
                }

                trigger OnAfterInsertRecord()
                var
                    CalJ: Record "Calculation Journal Line";
                    IntStreet2: Integer;
                    MobI: Integer;
                    NewDecimal: Decimal;
                    DifA: Decimal;
                    DateD: Date;
                    DateP: Date;
                    RF: Decimal;
                    StreetInt: Integer;
                    CU: Record Customer;
                    DateAd: Date;
                    AjdV: Decimal;
                    EL_Volume_CodeInt: Integer;
                begin



                    /*  TempCJL.Reset();
                      TempCJL.SetFilter(Code, '%1', SifraObracuna);
                      TempCJL.SetFilter("Customer No.", '%1', Customer_No_);
                      TempCJL.SetFilter("Measuring Point Code", '%1', MMCode);
                      TempCJL.SetFilter("Gauge", '%1', GaugeCode);*/
                    if not TempCJL.get(SifraObracuna, Customer_No_, MMCode, GaugeCode) then begin



                        TempCJL.Init();
                        TempCJL.Code := SifraObracuna;



                        if Evaluate(MWinterI, MWinter) then
                            TempCJL."Measuring Zone - winter" := MWinterI
                        else
                            TempCJL."Measuring Zone - winter" := 0;

                        if Evaluate(MSummerI, MSummer) then
                            TempCJL."Measuring Zone - summer" := MSummerI
                        else
                            TempCJL."Measuring Zone - summer" := 0;




                        if Evaluate(TempDec, Temp) then
                            TempCJL."Temperature previous - gauge" := TempDec
                        else
                            TempCJL."Temperature previous - gauge" := 0;


                        if Evaluate(TempDecNew, TemperatureNew) then
                            TempCJL.validate("Temperature new- gauge", TempDecNew)
                        else
                            TempCJL.validate("Temperature new- gauge", 0);




                        if Evaluate(PressDec, Pressure) then
                            TempCJL."Pressure previous - gauge" := PressDec
                        else
                            TempCJL."Pressure previous - gauge" := 0;

                        if Evaluate(PressDecNew, PressureNew) then
                            TempCJL.validate("Pressure new- gauge", PressDecNew)
                        else
                            TempCJL.validate("Pressure new- gauge", 0);






                        if Evaluate(UncorrectionDec, Uncorrection) then
                            TempCJL."UnCorrection previous - gauge" := UncorrectionDec
                        else
                            TempCJL."UnCorrection previous - gauge" := 0;

                        if Evaluate(UncorrectionDecNew, Uncorrectionnew) then
                            TempCJL.validate("UnCorrection new- gauge", UncorrectionDecNew)
                        else
                            TempCJL.validate("UnCorrection new- gauge", 0);



                        if Evaluate(CorrectionDec, Correction) then
                            TempCJL."Correction previous - gauge" := CorrectionDec
                        else
                            TempCJL."Correction previous - gauge" := 0;


                        if Evaluate(CorrectionDecNew, CorrectionNew) then
                            TempCJL.validate("Correction new- gauge", CorrectionDecNew)
                        else
                            TempCJL.validate("Correction new- gauge", 0);



                        if Evaluate(TempCOrrNew, TempCorr) then
                            TempCJL."Temperature Correction" := TempCOrrNew
                        else
                            TempCJL."Temperature Correction" := 0;


                        if Evaluate(PressureCOrrNew, PressureCOrr) then
                            TempCJL."Pressure Correction" := PressureCOrrNew
                        else
                            TempCJL."Pressure Correction" := 0;




                        if Evaluate(FictiveInt, Fictive) then
                            TempCJL."Fictitious Code" := FictiveInt
                        else
                            TempCJL."Fictitious Code" := 0;

                        if Evaluate(LastYearCacl_Dec, LastYearCacl) then
                            TempCJL."Last Year Calculation" := LastYearCacl_Dec

                        else
                            TempCJL."Last Year Calculation" := 0;


                        if Evaluate(Autoint_Int, Autoint_) then
                            TempCJL.Autoint := Autoint_Int
                        else
                            TempCJL.Autoint := 0;
                        if Evaluate(DateFrom_D, DateFrom) then
                            TempCJL."Calculation Date From" := DateFrom_D
                        else
                            TempCJL."Calculation Date To" := 0D;
                        if Evaluate(DateTo_D, DateTo) then
                            TempCJL."Calculation Date To" := DateTo_D
                        else
                            TempCJL."Calculation Date To" := 0D;




                        if Evaluate(RDateFrom_D, RDateFrom) then
                            TempCJL."Reading Date From" := RDateFrom_D
                        else
                            TempCJL."Reading Date From" := 0D;
                        if Evaluate(RDateTo_D, RDateTo) then
                            TempCJL."Reading Date To" := RDateTo_D
                        else
                            TempCJL."Reading Date To" := 0D;

                        if Evaluate(NewGau, NewG) then
                            TempCJL.Validate("New Gauge", NewGau);
                        if Evaluate(OldGau, OldG) then
                            TempCJL.Validate("Old Gauge", OldGau);

                        if Evaluate(DateAd, AdjDate) then
                            TempCJL."Pressure Date" := DateAd;

                        if Evaluate(AjdV, AjdP) then
                            TempCJL."Adjusted Pressure" := AjdV;


                        if Evaluate(CPC_Decimal, CPC) then
                            TempCJL."Calorific power coefficient" := CPC_Decimal
                        else
                            TempCJL."Calorific power coefficient" := 0;
                        if Evaluate(AP_Decimal, ap) then
                            TempCJL."Atmospheric pressure" := AP_Decimal
                        else
                            TempCJL."Atmospheric pressure" := 0;
                        if Evaluate(SF_Decimal, SF) then
                            TempCJL."Scale factor" := SF_Decimal
                        else
                            TempCJL."Scale factor" := 0;
                        if Evaluate(CC_decimal, CC) then
                            TempCJL."Compression coefficient" := CC_decimal
                        else
                            TempCJL."Compression coefficient" := 0;
                        TempCJL.Gauge := GaugeCode;
                        TempCJL."Measuring Point Code" := MMCode;
                        TempCJL.MM := MMCode;
                        if Evaluate(PreviousC_inte, PreviousC) then
                            TempCJL."Previous Calculations" := PreviousC_inte
                        else
                            TempCJL."Previous Calculations" := 0;

                        TempCJL."Customer No." := Customer_No_;
                        TempCJL."Post Code Customer" := PostCodeCust;
                        TempCJL."E-mail Delivery" := TempCJL."E-mail Delivery"::" ";
                        if (Email_Delivery = 'No') or (Email_Delivery = 'Ne') then
                            TempCJL."E-mail Delivery" := TempCJL."E-mail Delivery"::No;
                        if (Email_Delivery = 'Yes') or (Email_Delivery = 'Da') then
                            TempCJL."E-mail Delivery" := TempCJL."E-mail Delivery"::Yes;
                        if Evaluate(Email_Delivery_Date_Date, Email_Delivery_Date) then
                            TempCJL."E-mail Delivery Date" := Email_Delivery_Date_Date
                        else
                            TempCJL."E-mail Delivery Date" := 0D;

                        if Evaluate(Email_Delivery_DateTo, Email_Delivery_Date_to) then
                            TempCJL."E-mail Delivery Date to" := Email_Delivery_DateTo
                        else
                            TempCJL."E-mail Delivery Date to" := 0D;
                        TempCJL."E-Mail 2" := Replacestring_TName(EmailDelivery, 'ĐĐ', ';');
                        TempCJL."Post Code Customer D." := Post_Code_Customer_D;
                        TempCJL."City Customer" := City_Customer;
                        TempCJL."City Customer D." := City_Customer_D;
                        TempCJL."Address MM" := Replacestring_TName(Address_MM, '&quot', '"');

                        TempCJL."Street MM" := StreetMM;
                        if Evaluate(StreetInt, Street) then
                            TempCJL."Street No. Int MM" := StreetInt
                        else
                            TempCJL."Street No. Int MM" := 0;
                        TempCJL."Dwelling Type" := DwelingType;

                        TempCJL.street := Street;
                        CU.Reset();
                        CU.SetFilter("No.", '%1', Customer_No_);
                        if cu.FindFirst() then begin



                            if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                                TempCJL."Street No. Text Apartment" := AparmentInt
                            else
                                TempCJL."Street No. Text Apartment" := 0;



                        end;

                        mm.reset;
                        mm.SetFilter("No.", '%1', MMCode);
                        if mm.findfirst then begin

                            if Evaluate(FloorInt, mm.floor) then
                                TempCJL."Street No. Text int" := FloorInt
                            else
                                TempCJL."Street No. Text int" := 0;
                        end;


                        TempCJL."Post Code MM" := Post_Code_MM;
                        TempCJL."City MM" := City_MM;
                        TempCJL."Street No. Text" := Replacestring_TName(Street_No_Text, '&quot', '"');
                        if (Status_MM = 'Active') or (Status_MM = 'Aktivan') then
                            TempCJL."Status MM" := TempCJL."Status MM"::Active;

                        if (Status_MM = 'Permanently deregistered') or (Status_MM = 'Privremeno odjavljen') then
                            TempCJL."Status MM" := TempCJL."Status MM"::"Permanently deregistered";

                        if (Status_MM = 'Permanently inactive') or (Status_MM = 'Trajno neaktivan') then
                            TempCJL."Status MM" := TempCJL."Status MM"::"Permanently inactive";

                        if (Status_MM = 'Terminated') or (Status_MM = 'Neaktivan') then
                            TempCJL."Status MM" := TempCJL."Status MM"::Terminated;


                        TempCJL."Current Status MM" := TempCJL."Status MM";

                        if (Measuring_point_off = 'Da') or (Measuring_point_off = 'YES') then
                            TempCJL."Measuring point off" := TRUE
                        else
                            TempCJL."Measuring point off" := false;

                        if (GasPosting = 'Posting Yes') or (GasPosting = 'Ide na fakturisanje') then
                            TempCJL."Posting GAS" := TempCJL."Posting GAS"::"Posting Yes"
                        else
                            TempCJL."Posting GAS" := TempCJL."Posting GAS"::"Posting No";



                        if Evaluate(Measuring_point_off_Date_Date, Measuring_point_off_Date) then
                            TempCJL."Measuring point off Date" := Measuring_point_off_Date_Date
                        else
                            TempCJL."Measuring point off Date" := 0D;

                        TempCJL."Street Name MM" := Street_Name_MM;
                        if Evaluate(Street_No__int_Int, Street_No__int) then
                            TempCJL."Street No. int" := Street_No__int_Int
                        else
                            TempCJL."Street No. int" := 0;




                        TempCJL.Floor := Floor;

                        CU.Reset();
                        CU.SetFilter("No.", '%1', Customer_No_);
                        if cu.FindFirst() then begin



                            if Evaluate(AparmentInt, CU."Apartment No. Customer") then
                                TempCJL."Street No. Text Apartment" := AparmentInt
                            else
                                TempCJL."Street No. Text Apartment" := 0;


                            if Evaluate(FloorInt, CU."Floor Customer") then
                                TempCJL."Street No. Text int" := AparmentInt
                            else
                                TempCJL."Street No. Text int" := 0;
                        end;



                        TempCJL."Address MM" := Replacestring_TName(Address_MM, '&quot', '"');
                        TempCJL."Street MM" := StreetMM;

                        if Evaluate(Measuring_Point_string_int, Measuring_Point_string) then
                            TempCJL."Measuring Point string" := Measuring_Point_string_int
                        else
                            TempCJL."Measuring Point string" := 0;
                        if Evaluate(Measuring_Point_stroke_int, Measuring_Point_Stroke) then
                            TempCJL."Measuring Point Stroke" := Measuring_Point_stroke_int
                        else
                            TempCJL."Measuring Point Stroke" := 0;
                        TempCJL."Apartment No." := Apartment_No_;
                        TempCJL."Apartment No. Customer 2" := ApartmentNo2a;
                        TempCJL."Municipality Code MM" := Municipality_Code_MM;
                        TempCJL."Municipality Name MM" := Municipality_Name_MM;

                        TempCJL."EU Activity" := ActEU;
                        TempCJL."EF Activity" := ActEf;
                        if Evaluate(BillPD, BillP) then
                            TempCJL."Bill distribution percentage" := BillPD
                        else
                            TempCJL."Bill distribution percentage" := 0;
                        TempCJL.Agreement := BillA;

                        if Evaluate(UnbInt, Unbiv) then
                            TempCJL."Previous Unobvious Month" := UnbInt
                        else
                            TempCJL."Previous Unobvious Month" := 0;
                        if Evaluate(Average_CalculationD, Average_Calculation)
                         then
                            TempCJL."Average Calculation" := Average_CalculationD
                        else
                            TempCJL."Average Calculation" := 0;
                        TempCJL.Activity := Act;
                        if Evaluate(Summer_Zone_integer, Summer_Zone) then
                            TempCJL."Summer Zone" := Summer_Zone_integer
                        else
                            TempCJL."Summer Zone" := 0;

                        TempCJL."MM Description" := Replacestring_TName(MM_Description, '&quot', '"');

                        if (Reading_Mode = 'Reading List') or (Reading_Mode = 'Manuelno (mobilno očitanje)') then
                            TempCJL."Reading Mode" := TempCJL."Reading Mode"::"Reading List";
                        if (Reading_Mode = 'Digital') or (Reading_Mode = 'Daljinsko') then
                            TempCJL."Reading Mode" := TempCJL."Reading Mode"::Digital;
                        if Evaluate(Mobile_No_integer, Mobile_No_)
                        then
                            TempCJL."Mobile No." := Mobile_No_integer
                        else
                            TempCJL."Mobile No." := 0;
                        TempCJL."Type of reading" := TempCJL."Type of reading"::Unknown;
                        if (Type_of_reading = 'Module Type 3') or (Type_of_reading = 'Modul tipa 3')
                        then
                            TempCJL."Type of reading" := TempCJL."Type of reading"::"Module Type 3";

                        if (Type_of_reading = 'Radio Module') or (Type_of_reading = 'Radio modul')
then
                            TempCJL."Type of reading" := TempCJL."Type of reading"::"Radio Module";

                        if Evaluate(ReadingTimeEnum, Reading_Time) then
                            TempCJL."Reading Time" := ReadingTimeEnum;

                        if Evaluate(TempCJL_DataEnum, TempCJL_Data) then
                            TempCJL."Source Data" := TempCJL_DataEnum;

                        if Evaluate(PostingEnum, Posting) then
                            TempCJL.Posting := PostingEnum;
                        if Evaluate(DistribE, Distribution) then
                            TempCJL.Distribution := DistribE;
                        if Evaluate(Distribution_readEnum, Distribution_read) then
                            TempCJL."Distribution - read" := Distribution_readEnum;
                        if Evaluate(EnumSpec, Specification) then
                            TempCJL.Specification := EnumSpec;
                        if Evaluate(EnumBillDelivery, Bill_delivery) then
                            TempCJL."Bill delivery" := EnumBillDelivery;
                        if Evaluate(EnumRMS, RMS_Maintenance) then
                            TempCJL."RMS Maintenance" := EnumRMS;
                        if evaluate(Winter_Zone_int, Winter_Zone) then
                            TempCJL."Winter Zone" := Winter_Zone_int
                        else
                            TempCJL."Winter Zone" := 0;
                        if Evaluate(EnumRemotely, Remotely_Type) then
                            TempCJL."Remotely Type" := EnumRemotely;

                        if Evaluate(Transit_Zone_int, Transit_Zone) then
                            TempCJL."Transit Zone" := Transit_Zone_int
                        else
                            TempCJL."Transit Zone" := 0;
                        TempCJL."Floor Customer" := Floor_Customer;
                        TempCJL."Apartment No. Customer" := Apartment_No__Customer;
                        TempCJL."Home No. Customer" := Home_No__Customer;
                        TempCJL."Home No." := Home_No_;
                        if Evaluate(EnumC, Category_Customer) then
                            TempCJL."Category Customer" := EnumC;
                        if Evaluate(EnumC, Categ_MM) then
                            TempCJL."Category MM" := EnumC;

                        TempCJL."Customer No." := Customer_No_;
                        TempCJL."MZ Customer" := MZ_Customer;
                        TempCJL."MZ Name Customer" := MZ_Name_Customer;
                        TempCJL."MM Description" := Replacestring_TName(MM_Description, '&quot', '"');
                        if Evaluate(EnumMethod, Method_of_calculation) then
                            TempCJL."Method of calculation" := EnumMethod;
                        TempCJL."MZ MM" := MZ_MM;
                        TempCJL."MZ Name MM" := MZ_Name_MM;
                        if Evaluate(ZoneStrokeInt, ZoneStroke) then
                            TempCJL."Zone stroke" := ZoneStrokeInt
                        else
                            TempCJL."Zone stroke" := 0;

                        if Evaluate(ZoneStrokeInt2, ZoneStroke2) then
                            TempCJL."Zone stroke 2" := ZoneStrokeInt2 else
                            TempCJL."Zone stroke 2" := 0;

                        if Evaluate(ZoneStrokeIntMM, ZoneStrokeMM) then
                            TempCJL."Zone stroke MM" := ZoneStrokeIntMM else
                            TempCJL."Zone stroke MM" := 0;


                        TempCJL.Code := Code;
                        if Evaluate(MCMonth, Month_of_Calculation)
                        then
                            TempCJL."Month of Calculation" := MCMonth
                        else
                            TempCJL."Month of Calculation" := 0;
                        if Evaluate(MCYear, Year_of_Calculation)
                         then
                            TempCJL."Year of Calculation" := MCYear
                        else
                            TempCJL."Year of Calculation" := 0;

                        if Evaluate(MCMonthG, Month_Of_GAS_Calculation) then
                            TempCJL."Month Of GAS Calculation" := MCMonthG
                        else
                            TempCJL."Month Of GAS Calculation" := 0;
                        if Evaluate(MCYearG, Year_Of_GAS_Calculation) then
                            TempCJL."Year Of GAS Calculation" := MCYearG
                        else
                            TempCJL."Year Of GAS Calculation" := 0;

                        if Evaluate(PurchaseUnitPriceDecimal, Purchase_Unit_Price) then
                            TempCJL."Purchase Unit Price" := PurchaseUnitPriceDecimal
                        else
                            TempCJL."Purchase Unit Price" := 0;

                        if Evaluate(Distribution_Unit_Price_Decimal, Distribution_Unit_Price) then
                            TempCJL."Distribution Unit Price" := Distribution_Unit_Price_Decimal
                        else
                            TempCJL."Distribution Unit Price" := 0;
                        if Evaluate(Sales_Unit_Price_Decimal, Sales_Unit_Price) then
                            TempCJL."Sales Unit Price" := Sales_Unit_Price_Decimal
                        else
                            TempCJL."Sales Unit Price" := 0;
                        if Evaluate(Unit_Price_Decimal, Unit_Price) then
                            TempCJL."Unit Price" := Unit_Price_Decimal
                        else
                            TempCJL."Unit Price" := 0;
                        if Evaluate(Customer_Balance_Decimal, Customer_Balance) then
                            TempCJL."Customer Balance" := Customer_Balance_Decimal
                        else
                            TempCJL."Customer Balance" := 0;
                        if Evaluate(Customer_Prepayment_Dec, Customer_Prepayment) then
                            TempCJL."Customer Prepayment" := Customer_Prepayment_Dec
                        else
                            TempCJL."Customer Prepayment" := 0;
                        TempCJL."Customer Name" := Replacestring_TName(Customer_Name, '&quot', '"');
                        TempCJL."Registration No." := Registration_No_;
                        TempCJL."VAT Registration No." := VAT_Registration_No_;
                        if Evaluate(Customer_string_int, Customer_string) then
                            TempCJL."Customer string" := Customer_string_int
                        else
                            TempCJL."Customer string" := 0;
                        if Evaluate(Customer_Stroke_int, Customer_Stroke)
                        then
                            TempCJL."Customer Stroke" := Customer_Stroke_int
                        else
                            TempCJL."Customer Stroke" := 0;
                        TempCJL."MZ Customer" := MZ_Customer;
                        TempCJL."Floor Customer" := Floor_Customer;
                        TempCJL."Street Customer" := Street_Customer;
                        TempCJL."Address Customer" := Address_Customer;
                        TempCJL."Address 2" := Address_Customer2;
                        tempcjl."Reminder Terms Code" := ReminderValue;
                        TempCJL."MZ Name Customer" := MZ_Name_Customer;

                        TempCJL."Home No. Customer" := Home_No__Customer;
                        TempCJL."Home No. Customer 2" := HomeNo2;

                        TempCJL."Municipality Code Customer" := Municipality_Code_Customer;
                        TempCJL."Municipality Name Customer" := Municipality_Name_Customer;
                        TempCJL."Serial Number" := Serial_Number;
                        TempCJL."Gauge Size" := Gauge_Size;
                        if evaluate(Max_Difference_Dec, Max_Difference) then
                            TempCJL."Max Difference" := Max_Difference_Dec
                        else
                            TempCJL."Max Difference" := 0;
                        if Evaluate(Old_Value_dec, Old_Value) then
                            TempCJL."Old Value" := Old_Value_dec
                        else
                            TempCJL."Old Value" := 0;

                        if Evaluate(New_Value_dec, New_Value) then
                            TempCJL."New Value" := New_Value_dec
                        else
                            TempCJL."New Value" := 0;


                        if Evaluate(Previous_Date_Date, Previous_Date) then
                            TempCJL."Previous Date" := Previous_Date_Date
                        else
                            TempCJL."Previous Date" := 0D;
                        if Evaluate(Previous_method_of_calculationEnum, Previous_method_of_calculation) then
                            TempCJL."Previous method of calculation" := Previous_method_of_calculationEnum;
                        TempCJL."EL Volume Code" := EL_Volume_Code;
                        if Evaluate(EL_Volume_CodeInt, EL_Volume_Code) then
                            TempCJL."Corrector Code" := EL_Volume_CodeInt
                        else
                            TempCJL."Corrector Code" := 0;
                        TempCJL."EL Volume Description" := EL_Volume_Description;
                        TempCJL."EL Correctior Type" := EL_Correctior_Type;

                        if Evaluate(Customer_String_2I, Customer_String_2) then
                            TempCJL."Customer String 2" := Customer_String_2I
                        else
                            TempCJL."Customer String 2" := 0;



                        if Evaluate(Customer_StrokeI, Customer_Stroke) then
                            TempCJL."Customer Stroke" := Customer_StrokeI
                        else
                            TempCJL."Customer Stroke" := 0;

                        if Evaluate(customerstroke2I, customerstroke2) then
                            TempCJL."Customer Stroke 2" := customerstroke2I
                        else
                            TempCJL."Customer Stroke 2" := 0;

                        TempCJL."MZ Customer" := MZ_Customer_C;
                        TempCJL."MZ Customer 2" := MZ_Customer2;

                        TempCJL."MZ Name Customer" := MZ_Customer_CName;
                        TempCJL."MZ Name Customer 2" := MZ_CustomerName2;

                        TempCJL."Floor Customer" := Floor_Customer_C;
                        TempCJL."Floor Customer 2" := Floor_Customer_C2;

                        TempCJL."Floor Customer 2" := Floor_Customer_C2_1;


                        TempCJL."Street Customer 2" := Street_Customer_C2;
                        TempCJL."Street Name Customer" := StreetName_Customer_C2;
                        TempCJL."Street Name Customer 2" := StreetName_Customer_C2_1;



                        TempCJL."Municipality Name Customer" := Mun_Customer_C2N;
                        TempCJL."Municipality Name Customer 2" := Mun_Customer_C2_1N;

                        TempCJL."Municipality Code Customer 2" := Mun_Customer_C2_1;

                        TempCJL."Street No." := StretNo;
                        TempCJL."Street No. 2" := StretNo2;
                        if (Evaluate(IntStreet2, StretNo2)) then
                            TempCJL."Street No.2 int" := IntStreet2
                        else
                            TempCJL."Street No.2 int" := 0;

                        TempCJL."Street No.2 Text" := StretNoText;
                        //  TempCJL."Street No. Text" := StretNo2Text2;
                        TempCJL."Street No. Text MM" := StretNo2Text2MM;
                        if (TempCJL."Filter by Old RMS" = True) and (TempCJL."Old Gauge" = true) then
                            TempCJL."Source Data" := TempCJL."Source Data"::Manual
                        else
                            TempCJL."Source Data" := TempCJL."Source Data"::Unobvious;
                        if Evaluate(CustomerInt, TempCJL."Customer No.") then
                            TempCJL."Customer No. int" := CustomerInt
                        else
                            TempCJL."Customer No. int" := 0;
                        TempCJL.Difference := TempCJL."New value" - TempCJL."Old Value";
                        if evaluate(FloorIntF, STrretNoFloor) then
                            TempCJL."Street No. Text int" := FloorIntF
                        else
                            TempCJL."Street No. Text int" := 0;

                        TempCJL.Insert();
                        // if Broj2 mod 10000 = 0 then
                        //   COMMIT;

                        Broj2 += 1;
                        CurrentDateT := time;
                        Progress.UPDATE(1, ROUND(Broj2));
                        Progress.UPDATE(2, CurrentDateT);

                    end;

                end;

            }
        }


    }

    trigger OnPreXmlPort()
    begin

        Broj2 := 0;
        StartDaT := time;
        Progress.OPEN('Ukupan broj uvoza podataka ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;


    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        CopyBatchToMain;

    end;


    procedure CopyBatchToMain()
    var

        CalcLine: Record "Calculation Journal Line";
    begin
        Broj2 := 0;
        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja novi ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;


        // Masovni insert iz temp tabele u glavnu
        CopyAllTo(CalcLine);

        // Opcionalno, možeš obrisati temp zapis ako želiš osloboditi memoriju
        TempCJL.DeleteAll();

    end;

    procedure CopyAllTo(Target: Record "Calculation Journal Line")
    var
        TempRec: Record "Calculation Journal Line";
        brojaMod: Integer;
    begin
        brojaMod := 0;
        Broj2 := 0;
        // Reset target record za masovni insert
        TempRec.Init();

        if TempCJL.FindSet() then
            repeat
                TempRec := TempCJL;       // Kopira sve polja iz temp
                TempRec.Insert();
                brojaMod += 1;
                if brojaMod MOD 10000 = 0 then
                    Commit();
                // Ubacuje u glavnu tabelu
                Broj2 += 1;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(Broj2));
                Progress.UPDATE(2, CurrentDateT);
            until TempCJL.Next() = 0;
    end;

    var
        Autoint_Int: Integer;
        PreviousC_inte: Integer;
        ZoneStrokeInt: integer;
        ZoneStrokeInt2: integer;
        PressureCOrrNew: Decimal;
        ZoneStrokeIntMM: Integer;
        UncorrectionDec: Decimal;
        CorrectionDec: Decimal;
        DateFrom_D: Date;
        DateTo_D: Date;
        RDateFrom_D: Date;
        OldGau: Boolean;
        NewGau: Boolean;
        RDateTo_D: Date;
        CPC_Decimal: Decimal;
        AP_Decimal: Decimal;
        SF_Decimal: Decimal;
        CC_decimal: Decimal;
        Email_Delivery_Date_Date: Date;
        TempCJL: record "Calculation Journal Line" temporary;
        Email_Delivery_DateTo: Date;
        Measuring_point_off_Date_Date: Date;
        Street_No__int_Int: Integer;
        Progress: Dialog;
        CurrRecNo: Integer;
        Measuring_Point_string_int: Integer;
        Measuring_Point_stroke_int: Integer;
        Summer_Zone_integer: Integer;
        Mobile_No_integer: Integer;
        Customer_Prepayment_Dec: Decimal;
        ReadingTimeEnum: enum "Reading Time";
        TempCJL_DataEnum: Enum "Import Data";
        PostingEnum: enum "Enum Posting Sales";
        DistribE: enum Distribution;
        Customer_string_int: Integer;
        Customer_Stroke_int: Integer;
        Average_CalculationD: Decimal;
        Distribution_readEnum: enum "Enum Distribution or Read";
        EnumSpec: enum Specification;
        EnumBillDelivery: enum "Bill delivery";
        EnumRMS: enum "RMS MAINTENANCE";
        EnumRemotely: enum "Remotely Type";
        Transit_Zone_int: Integer;
        EnumC: enum Category;
        EnumMethod: enum "Method of calculation";
        Winter_Zone_int: Integer;
        MCYear: Integer;
        MCMonth: Integer;
        MCYearG: Integer;
        MCMonthG: Integer;
        PurchaseUnitPriceDecimal: Decimal;
        Distribution_Unit_Price_Decimal: Decimal;
        Sales_Unit_Price_Decimal: Decimal;
        Unit_Price_Decimal: Decimal;
        StartDaT: Time;
        CurrentDateT: Time;
        Broj2: Integer;

        TempDec: Decimal;
        CorrectionDecNew: Decimal;
        PressDec: Decimal;
        Customer_Balance_Decimal: Decimal;
        Customer_Prepayment_Decimal: Decimal;
        Max_Difference_Dec: Decimal;
        Old_Value_dec: Decimal;
        New_Value_dec: decimal;
        LastYearCacl_Dec: Decimal;
        TempDecNew: Decimal;
        PressDecNew: Decimal;
        MWinterI: Integer;
        MSummerI: Integer;
        Previous_Date_Date: Date;
        UncorrectionDecNew: Decimal;
        TempCOrrNew: Decimal;

        AparmentInt: Integer;
        BillPD: Decimal;
        FloorInt: Integer;
        CustomerInt: Integer;
        mm: record "Service Item";

        FictiveInt: Decimal;
        Customer_String_2I: Integer;
        Customer_StrokeI: Integer;
        customerstroke2I: Integer;
        Previous_method_of_calculationEnum: enum "Method of calculation";
        UnbInt: integer;
        FloorIntF: integer;




    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;



}

