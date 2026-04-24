table 50080 "Calculation Journal Line"
{
    Caption = 'Calculation Journal Line';
    DrillDownPageId = "Calculation List";
    LookupPageId = "Calculation List";
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            //broj obračuna
        }
        field(2; MM; code[20])
        {
            Caption = 'MM Code';
            TableRelation = "Service Item"."No.";
        }
        field(3; "Gauge"; Code[20])
        {
            TableRelation = Gauge.Code;
           
        }
        field(4; "Year of Calculation"; Integer)
        { Caption = 'Year of calculation'; }

        field(5; "Month of Calculation"; Integer)
        { Caption = 'Month of Calculation'; }
        field(6; "Category MM"; enum Category) { Caption = 'Category MM'; }
        field(7; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            
            trigger OnValidate()
            var
                myInt: Integer;
                IntCus: Integer;
            begin
                if Evaluate(IntCus, "Customer No.") then
                    "Customer No. int" := IntCus
                else
                    "Customer No. int" := 0;


            end;
        }
        field(8; "Customer Name"; Text[250]) { Caption = 'Customer Name';  }
        field(9; "Category Customer"; enum Category) { Caption = 'Category Customer'; }
        field(10; "Summer Zone"; Integer)
        {
            Caption = 'Summer Zone';


        }
        field(11; "Winter Zone"; Integer)
        {
            Caption = 'Winter Zone';


        }
        field(12; "Transit Zone"; Integer)
        {
            Caption = 'Transit Zone';


        }
        field(13; "Address MM"; Text[250])
        {
            Caption = 'Address MM';

        }
        field(14; "Address Customer"; text[250])
        {
            Caption = 'Address Customer';
        }
        field(15; "Municipality Code MM"; code[20])
        {
            Caption = 'Municipality Code MM';
            TableRelation = Municipality.Code where(Type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
            begin
                Mun.Reset();
                Mun.SetFilter(Code, '%1', "Municipality Code MM");
                Mun.SetFilter(type, '%1', Mun.Type::Regular);
                if Mun.FindFirst() then
                    "Municipality Name MM" := Mun.Name
                else
                    "Municipality Name MM" := '';

            end;
        }
        field(16; "Municipality Name MM"; Text[250])
        {
            Caption = 'Municipality Name MM';
            Editable = false;

        }

        field(17; "MZ MM"; code[20])
        {
            Caption = 'Local Community';
            TableRelation = MZ.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
                MZ: Record MZ;
            begin
                //     Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";
                mz.Reset();
                mz.SetFilter(Code, '%1', Rec."MZ MM");
                if mz.FindFirst() then
                    "MZ Name MM" := MZ.Description
                else
                    "MZ Name MM" := '';

            end;
        }
        field(18; "MZ Name MM"; Text[250])
        {
            Caption = 'MZ Name MM';
            Editable = false;
        }

        field(19; "Street"; Code[20])
        {
            Caption = 'Street';
            //Mjernog mjesta Br. ulice
            //   TableRelation = Street.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
                ST: Record Street;
            begin
                //                Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";
                st.Reset();
                st.SetFilter(Code, '%1', format(Street));
                if st.findfirst then
                    "Street Name MM" := st.Description
                else
                    "Street Name MM" := '';

            end;

        }

        field(20; "Street Name MM"; Text[250])
        {
            Caption = 'Street Name MM';
            Editable = false;
        }
        field(21; "Home No."; Code[5])
        {
            Caption = 'Home No.';
            //    TableRelation = Street."Home No." where(Code = field(Street));
            trigger Onvalidate()
            var
                myInt: Integer;
                st: Record street;
            begin
                /*      st.Reset();
                      st.SetFilter("Home No.", '%1', "Home No.");
                      st.SetFilter(Code, '%1', Rec.Street);
                      if st.findfirst then
                          "Street Name MM" := st.Description
                      else
                          "Street Name MM" := '';*/


            end;
        }
        field(50004; "Apartment No."; Code[5])
        {
            Caption = 'Apartment No.';
            // TableRelation = Street."Apartment No." where(Code = field(Street), "Home No." = field("Home No."), Floor = field(Floor));

            trigger Onvalidate()
            var
                myInt: Integer;
                st: Record street;
            begin
                /*     st.Reset();
                     st.SetFilter("Home No.", '%1', "Home No.");
                     st.SetFilter(Code, '%1', Rec.Street);
                     st.SetFilter(Floor, '%1', Rec.Floor);
                     if st.findfirst then
                         "Street Name MM" := st.Description
                     else
                         "Street Name MM" := '';*/


            end;

        }
        field(50005; "Floor"; code[20])
        {
            Caption = 'Floor MM';
            //    TableRelation = Street.Floor where(Code = field(Street), "Home No." = field("Home No."));


        }

        field(50007; "Municipality Code Customer"; code[20])
        {
            Caption = 'Customer Municipality Code Customer';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(50016; "Municipality Name Customer"; Text[250])
        {
            Caption = 'Municipality name Customer';

        }

        field(50064; "Street No."; Code[20])
        { }
        field(50076; "Street No. Text"; text[250])
        {
            Caption = 'Street No. text';
        }
        field(50065; "Zone stroke"; Integer)
        {
            Caption = 'Zone stroke';

        }
        field(50057; "Customer Stroke"; Integer)
        {
            Caption = 'Customer Stroke';
            //Hod


        }

        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }


        field(50000; "Registration No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Customer string"; Integer)
        {
            Caption = 'Customer string';
            //niz

        }


        field(50008; "MZ Customer"; code[20])
        {
            Caption = 'Customer Local Community';
            TableRelation = MZ.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //     "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;
        }
        field(50018; "MZ Name Customer"; Text[250])
        {
            Caption = 'MZ Name Customer';

        }

        field(50009; "Street Customer"; code[20])
        {
            Caption = 'Street Customer';
            TableRelation = Street.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //                "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;

        }

        field(50017; "Street Name Customer"; Text[250])
        {
            Caption = 'Street Name Customer';

        }
        field(70; "Month Of GAS Calculation"; Integer)
        {
            Caption = 'Month of GAS Calculation';
            Description = 'Month for which the wage is calculated and paid';

            trigger OnValidate()
            var
                CH: Record "Calcuation Header";
            begin
                if (rec."Year Of GAS Calculation" <> 0) and (rec."Month Of GAS Calculation" <> 0) then begin
                    CH.Reset();
                    ch.SetFilter("Year Of GAS Calculation", '%1', rec."Year Of GAS Calculation");
                    ch.SetFilter("Month Of GAS Calculation", '%1', rec."Month Of GAS Calculation");
                    if ch.FindFirst() then begin
                        if CH.Status <> CH.Status::Open then begin
                            "Calorific power coefficient" := CH."Calorific power coefficient";
                        end;
                    end;
                end;

            end;
        }
        field(75; "Year Of GAS Calculation"; Integer)
        {
            Caption = 'Year of GAS Calculation';
            Description = 'Year for which the wage is calculated and paid';

            trigger OnValidate()
            var
                CH: Record "Calcuation Header";
            begin
                if (rec."Year Of GAS Calculation" <> 0) and (rec."Month Of GAS Calculation" <> 0) then begin
                    CH.Reset();
                    ch.SetFilter("Year Of GAS Calculation", '%1', rec."Year Of GAS Calculation");
                    ch.SetFilter("Month Of GAS Calculation", '%1', rec."Month Of GAS Calculation");
                    if ch.FindFirst() then begin
                        if CH.Status <> CH.Status::Open then begin
                            "Calorific power coefficient" := CH."Calorific power coefficient";
                        end;
                    end;
                end;

            end;
        }


        field(50010; "Home No. Customer"; Code[5])
        {
            Caption = 'Home No.';
            //    TableRelation = Street."Home No." where(Code = field(Street));
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //   "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;
        }
        field(50011; "Apartment No. Customer"; Code[5])
        {
            Caption = 'Apartment No. Customer';
            //   TableRelation = Street."Apartment No." where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"), Floor = field("Floor Customer"));
        }
        field(50012; "Floor Customer"; code[20])
        {
            Caption = 'Floor Customer';
            //      TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));
        }
        field(50013; "Measuring Point Code"; Code[20])
        {
            TableRelation = "Service Item"."No.";
            Caption = 'Measuring Point Code';
        }
        field(50014; "Unit Price"; Decimal)
        {

            Caption = 'Unit Price';
            DecimalPlaces = 1 : 4;
        }
        field(50015; "KOEKAL"; Decimal)
        {

            Caption = 'KOEKAL';
            DecimalPlaces = 1 : 6;
            trigger OnValidate()
            var
                DecimalV: Decimal;
                DecimalV2: text[250];
                DecimalV2E: Decimal;
                A: Decimal;
                PercMM: Decimal;
                CHWin: Record "Calcuation Header";
                MMPerc: Record "Service Item";
            begin
                Rec.Reset();
                rec.SetFilter("Calorific power coefficient", '<>%1', rec."Calorific power coefficient");
                rec.SetFilter(Code, '%1', rec.Code);
                if Rec.FindSet()
                then
                    repeat

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

                        Rec.Validate("Calorific power coefficient", rec."Calorific power coefficient");
                        if "Method of calculation" = "Method of calculation"::"3" then begin
                            validate(SM3, round((("Correction new- gauge" - "Correction previous - gauge") * "Calorific power coefficient"), 0.01, '='));
                        end;
                        if "Method of calculation" = "Method of calculation"::"1" then begin

                            if ("Category MM" = "Category MM"::"Large Economy") or ("Category MM" = "Category MM"::"KJKP Heating plant") then begin

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
                        Rec.USERID_ID := USERID;
                        Rec.Modify();
                    until Rec.Next() = 0;

            end;
        }
        field(50019;
        "GAS - amount";
        Decimal)
        {
            Caption = 'GAS - amount';
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(50020; "GAS - VAT"; Decimal)
        {
            Caption = 'GAS - VAT';
        }
        field(50021; "GAS- Calculation"; Decimal)
        {
            Caption = 'GAS- Calculation';
        }
        field(50022; "Basis maintenance"; Decimal)
        {
            Caption = 'Basis maintenance';
        }
        field(50023; "Maintenance VAT"; Decimal)
        {
            Caption = 'Maintenance VAT';
        }

        field(50024; "Old Value"; Integer)
        {
            Caption = 'Old Value';
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                validate(Difference, "New Value" - "Old Value");

            end;
        }
        field(50025; "New Value"; Integer)
        {
            Caption = 'New Value';
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                validate(Difference, "New Value" - "Old Value");

            end;
        }
        field(50026; "Difference"; Decimal)
        {
            Caption = 'Difference';

            trigger OnValidate()
            var
                myInt: Integer;
                CalS: Record "Calculation Setup";
            begin
                //   "Rounding Quantity" := round(Difference * koekal, CalS."Rounding Value Quantity", '=');
                "Rounding Quantity" := Difference * koekal;

                if "Difference Amount 1" <> 0 then
                    "Difference Range 1" := "Difference Amount 1" - Difference;

                if "Difference Amount 2" <> 0 then
                    "Difference Range 2" := "Difference Amount 2" - Difference;

                if "Difference Amount 3" <> 0 then
                    "Difference Range 3" := "Difference Amount 3" - Difference;

                if "Difference Amount 4" <> 0 then
                    "Difference Range 4" := "Difference Amount 4" - Difference;

                if "Difference Amount 5" <> 0 then
                    "Difference Range 5" := "Difference Amount 5" - Difference;






            end;
        }
        field(50027; "SM3"; Decimal)
        {
            Caption = 'SM3';
        }

        field(50028; "GAS - part"; Decimal)
        {
            Caption = 'GAS - part';
        }
        field(50029; "Maintenance - part"; Decimal)
        {
            Caption = 'Maintenance - part';
        }
        field(50030; "Total"; Decimal)
        {
            Caption = 'Total';
        }
        field(50031; "Previous Date"; Date)
        {
            Caption = 'Previous Date';
        }
        field(50032; "Measuring Point Stroke"; Integer)
        {
            Caption = 'Measuring Point Stroke';


        }
        field(50033; "Measuring Point string"; Integer)
        {
            Caption = 'Measuring Point string';

        }
        field(50034; "Corrector Code"; Integer)
        {
            Caption = 'Corrector Code';
            NotBlank = true;
        }
        field(30; "Gauge Size"; text[250])
        {
            Caption = 'Gauge size';
            TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(31; "Calculation Date From"; Date)
        {
            Caption = 'Calculation Date From';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //  "Reading Date From" := "Calculation Date From";

            end;
        }
        field(32; "Calculation Date To"; Date)
        {
            Caption = 'Calculation Date To';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //     "Reading Date To" := "Calculation Date To";

            end;
        }

        field(33; "Proceedings No."; Code[20])
        {
            Caption = 'Proceedings No.';
        }
        field(34; "Temperature previous - gauge"; Decimal)
        {
            Caption = 'Temperature previous - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Temperature result- gauge" := ("Temperature previous - gauge" + "Temperature new- gauge") / 2;

            end;
        }
        field(35; "Temperature new- gauge"; Decimal)
        {
            Caption = 'Temperature new - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Temperature result- gauge" := ("Temperature previous - gauge" + "Temperature new- gauge") / 2;

            end;
        }
        field(36; "Temperature result- gauge"; Decimal)
        {
            Caption = 'Temperature new - gauge';
        }
        field(37; "Pressure previous - gauge"; Decimal)
        {
            Caption = 'Pressure previous - gauge"';
            DecimalPlaces = 1 : 4;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                //  "Pressure result- gauge" := ("Pressure previous - gauge" + "Pressure new- gauge") / 2;

            end;
        }
        field(38; "Pressure new- gauge"; Decimal)
        {
            Caption = 'Pressure new - gauge';
            DecimalPlaces = 1 : 4;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Pressure result- gauge" := "Pressure new- gauge";

            end;
        }
        field(39; "Pressure result- gauge"; Decimal)
        {
            Caption = 'Pressure new - gauge';
            DecimalPlaces = 1 : 4;
        }

        field(40; "Correction previous - gauge"; Decimal)
        {
            Caption = 'Correction previous - gauge"';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Correction result- gauge" := ("Correction new- gauge" - "Correction previous - gauge");

            end;

        }
        field(41; "Correction new- gauge"; Decimal)
        {
            Caption = 'Correction new - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Correction result- gauge" := ("Correction new- gauge" - "Correction previous - gauge");

            end;
        }
        field(42; "Correction result- gauge"; Decimal)
        {
            Caption = 'Correction new - gauge';
        }
        field(43; "UnCorrection previous - gauge"; Decimal)
        {
            Caption = 'UnCorrection previous - gauge"';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "UnCorrection result- gauge" := ("UnCorrection new- gauge" - "UnCorrection previous - gauge");

            end;
        }
        field(44; "UnCorrection new- gauge"; Decimal)
        {
            Caption = 'UnCorrection new - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "UnCorrection result- gauge" := ("UnCorrection new- gauge" - "UnCorrection previous - gauge");

            end;
        }
        field(45; "UnCorrection result- gauge"; Decimal)
        {
            Caption = 'UnCorrection new - gauge';
        }
        field(46; "Temperature Correction"; Decimal)
        {
            Caption = 'Temperature Correction';
        }
        field(47; "Pressure Correction"; Decimal)
        {
            Caption = 'Pressure Correction';
            DecimalPlaces = 1 : 4;
        }
        field(48; "Calorific power coefficient"; Decimal)
        {
            Caption = 'Calorific power coefficient';
            DecimalPlaces = 1 : 6;
        }
        field(49; "Compression coefficient"; Decimal)
        {
            Caption = 'Compression coefficient';
            DecimalPlaces = 1 : 4;
        }
        field(50; "Atmospheric pressure"; Decimal)
        {
            Caption = 'Atmospheric pressure';
            DecimalPlaces = 1 : 6;
        }
        field(51; "% reduction"; Decimal)
        {
            Caption = '% reduction';
            MaxValue = 100;
        }
        field(52; "Method of calculation"; enum "Method of calculation")
        {
            Caption = 'Method of calculation';



        }
        field(53; "Working pressure"; Decimal)
        {
            Caption = 'Working pressure';
        }

        field(54; "Scale factor"; Decimal)
        {
            Caption = 'Scale factor';
        }
        field(56; "Correct consumption"; Boolean)
        {
            Caption = 'Correct consumption';
        }
        field(57; "USERID_ID"; text[250])
        {
            Caption = 'USERID';
            Editable = false;
        }
        field(58; "Bill Created"; Boolean)
        {
            Caption = 'Bill Created';
        }
        field(59; "Locked"; Boolean)
        {
            Caption = 'Locked';

        }
        field(64; "Deminimis Legal act"; text[250])
        {
            Caption = 'Deminimis Legal act';
        }
        field(65; "Deminimis Act Name"; Text[250])

        {
            Caption = 'Deminimis Act Name';
        }
        field(66; "Deminimis Act Number"; Text[250])
        {
            Caption = 'Deminimis Act Number';
        }
        field(50072; "Deminimis Act Date"; Date)
        {
            Caption = 'Deminimis Act Date';
        }
        field(50073; "Deminimis Purpose"; Text[250])
        {
            Caption = 'Deminimis Purpose';
        }
        field(50074; "Aid granting instrument"; text[250])
        {
            Caption = 'Aid granting instrument';
        }
        field(50075; "Deminimis Remark"; Text[250])
        {
            Caption = 'Deminimis Remark';
        }
        field(50077; "Date for previous Quantity"; Date)
        {
            Caption = 'Date for previous Quantity';
        }
        field(50078; "Last Bill"; Date)
        {
            Caption = 'Last Bill';
        }
        field(50079; "Quantity last Bill"; Decimal)
        {
            Caption = 'Quantity last Bill';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Difference Quantity last Bill" := "New Value" - "Quantity last Bill";
                if "Quantity last Bill" <> 0 then
                    "Index Difference Quantity" := "New Value" / "Quantity last Bill"
                else
                    "Index Difference Quantity" := 0;

            end;
        }

        field(50080; "Difference Quantity last Bill"; Decimal)
        {
            Caption = 'Difference quantity last Bill';
        }
        field(50081; "Index Difference Quantity"; Decimal)
        {
            Caption = 'Index difference quantity last Bill';
        }
        field(50082; "Pressure last Bill"; Decimal)
        {
            Caption = 'Pressure last Bill';
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }

        field(50083; "Previous method of calculation"; enum "Method of calculation")
        {
            Caption = 'Previous Method of calculation';


        }
        field(50084; "Previous month method of calcu"; enum "Method of calculation")
        {
            Caption = 'Previous month Method of calculation';



        }
        field(50085; "MM Description"; Text[250])
        {
            Caption = 'MM Description';



        }
        field(50086; "Serial Number"; Text[250])
        {
            Caption = 'MM Description';



        }

        field(50087; "Remotely Type"; enum "Remotely Type")
        {
            //    FieldClass = FlowField;
            //   CalcFormula = lookup("Installation History"."Remotely Type" where(Type = filter(Corrector), Active = filter(true), "Measuring Point Code" = field("No.")));

            Caption = 'Remotely Type';

        }
        field(50088; "Reading Mode"; Option)
        {
            Caption = 'Reading Mode';
            DataClassification = CustomerContent;
            OptionMembers = ,"Reading List","Digital";
            OptionCaption = ' ,Reading List,Digital';
        }

        field(50089; "EL Volume Code"; Code[20])
        {
            Caption = 'El Volume Code';
            NotBlank = true;
        }
        field(50090; "EL Volume Description"; Text[100])
        {
            Caption = 'El Volume Description';
        }
        field(50091; "Mobile No."; Integer)
        {
            Caption = 'Mobile No.';
        }
        field(50092; "Source Data"; enum "Import Data")
        {
            Caption = 'Source Data';
        }
        field(50110; "Reading Time"; enum "Reading Time")
        {
            Caption = 'Reading Time';
        }

        field(50111; "Type of reading"; enum "Type of reading")
        {
            Caption = 'Type of reading';
        }
        field(50112; "EL Correctior previous"; Decimal)
        {
            Caption = 'EL Correctior previous';
        }
        field(50113; "EL Correctior previous Date"; Date)
        {
            Caption = 'EL Correctior previous Date';
        }
        field(50114; "EL Correctior Type"; Text[250])
        {
            Caption = 'EL Correctior Type';
        }
        field(50115; "Purchase Unit Price"; Decimal)
        {
            Caption = 'Purchase Unit Price';
            DecimalPlaces = 1 : 5;
        }
        field(50116; "Distribution Unit Price"; Decimal)
        {
            Caption = 'Distribution Unit Price';
            DecimalPlaces = 1 : 4;
        }
        field(50117; "Sales Unit Price"; Decimal)
        {
            Caption = 'Sales Unit Price';
            DecimalPlaces = 1 : 4;
        }
        /* field(50118; "Letters"; Text[250])
         {
             Caption = 'Letters';
             TableRelation = Letters.Description;
             trigger OnValidate()
             var
                 myInt: Integer;
                 Lett: Record Letters;
             begin
                 Lett.Reset();
                 Lett.SetFilter(Description, '%1', Letters);
                 if Lett.FindFirst() then
                     Posting := Lett.Posting
                 else
                     Posting := false;

             end;
         }*/

        field(50120; "War Calculation"; Decimal)
        {
            Caption = 'Posting';
            //obračunati ratni dug
            trigger OnValidate()
            var
                myInt: Integer;
                CER: Record "Currency Exchange Rate";
                ChGet2: Record "Calcuation Header";
            begin
                if "Rec"."Manualy War Value" = false then begin
                    CER.Reset();
                    CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                    // CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");

                    ChGet2.get(Rec.Code);

                    if (ChGet2."Month Of GAS Calculation" = Rec."Month Of GAS Calculation") and (ChGet2."Year Of GAS Calculation" = Rec."Year Of GAS Calculation") then
                        CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To")
                    else
                        CER.SetFilter("Starting Date", '<=%1', Rec."Reading Date To");

                    CER.SetCurrentKey("Starting Date");
                    CER.Ascending;
                    if CER.FindLast() then begin

                        "War Calculation (LVT)" := (("War Calculation") * CER."Relational Exch. Rate Amount")

                    end
                    else begin
                        "War Calculation (LVT)" := "War Calculation";
                    end;
                end;
            end;
        }
        field(50121; "War Calculation (LVT)"; Decimal)
        {
            Caption = 'Posting';
            //obračunati ratni dug

            trigger OnValidate()
            var
                myInt: Integer;
                CER: Record "Currency Exchange Rate";
                ChGet2: Record "Calcuation Header";
            begin
                if Rec."Manualy War Value" = false then begin
                    CER.Reset();
                    CER.SetFilter("Currency Code", '%1', Rec."Currency Code");
                    //      CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To");

                    ChGet2.get(Rec.Code);

                    if (ChGet2."Month Of GAS Calculation" = Rec."Month Of GAS Calculation") and (ChGet2."Year Of GAS Calculation" = Rec."Year Of GAS Calculation") then
                        CER.SetFilter("Starting Date", '<=%1', Rec."Calculation Date To")
                    else
                        CER.SetFilter("Starting Date", '<=%1', Rec."Reading Date To");

                    CER.SetCurrentKey("Starting Date");
                    CER.Ascending;
                    if CER.FindLast() then begin

                        "War Calculation" := (("War Calculation (LVT)") / CER."Relational Exch. Rate Amount")

                    end
                    else begin
                        "War Calculation" := "War Calculation";
                    end;
                end;
            end;
        }
        field(50122; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            //obračunati ratni dug
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                validate("War Calculation", "War Calculation");

            end;
        }
        field(50123; "Subsidies"; Boolean)
        {
            Caption = 'Subsidies - yes';
        }
        field(50124; "Subsidies Amount"; Decimal)
        {
            Caption = 'Subsidies Amount';
        }
        field(50125; "Subsidies VAT Amount"; Decimal)
        {
            Caption = 'Subsidies VAT Amount';
        }
        field(50126; "Subsidies Total Amount"; Decimal)
        {
            Caption = 'Subsidies VAT Amount';
        }

        field(50128; "Posting"; enum "Enum Posting Sales")
        {
            Caption = 'Posting';
        }
        field(50129; "Distribution"; enum Distribution)
        {
            Caption = 'Distribution of consumption (multiple customers on one scale)';
        }
        field(50130; "Distribution - read"; enum "Enum Distribution or Read"
        )
        {
            Caption = 'Distribution - read';
        }
        field(50131; "Specification"; enum Specification)
        {
            Caption = 'Specification';
        }
        field(50132; "Bill delivery"; enum "Bill delivery")
        {
            Caption = 'Bill delivery';
        }
        field(50133; "RMS Maintenance"; enum "RMS MAINTENANCE")
        {
            Caption = 'RMS Maintenance';
        }
        field(50134; "Date"; DateTime)
        {
            Caption = 'Date';
        }
        field(50135; "Post Code MM"; Code[20])
        {
            Caption = 'Post Code MM';

        }

        field(50136; "Post Code Customer"; Code[20])
        {
            Caption = 'Post COde Customer';

        }
        field(50137; "Post Code Customer D."; Code[20])
        {
            Caption = 'Post Code Customer Delivery';

        }

        field(50140; "City MM"; Code[20])
        {
            Caption = 'City MM';

        }

        field(50138; "City Customer"; Code[20])
        {
            Caption = 'City Customer';

        }
        field(50139; "City Customer D."; Code[20])
        {
            Caption = 'City Customer Delivery';

        }
        field(50141; "Document No. Posting"; Code[20])
        {
            Caption = 'Document No. Posting';

        }
        field(50142; "Reading Date From"; Date)
        {
            Caption = 'Reading Date From';

        }

        field(50143; "Reading Date To"; Date)
        {
            Caption = 'Reading Date To';

        }
        field(50144; "Rounding Quantity"; decimal)
        {
            Caption = 'Rounding Quantity';

        }
        field(50145; "Customer Balance"; decimal)
        {
            Caption = 'Customer Balance';

        }

        field(50146; "Customer Prepayment"; decimal)
        {
            Caption = 'Customer Prepayment';

        }
        field(50147; "Average Calculation"; decimal)
        {
            Caption = 'Average Calculation';

        }
        field(50148; "Last Year Calculation"; decimal)
        {
            Caption = 'Last Year Calculation';

        }

        field(50149; "Bill Category"; code[20])
        {
            Caption = 'Bill Category';

        }
        field(50150; "Previous Unobvious Month"; Integer)
        {
            Caption = 'Previous Unobvious Month';
        }
        field(50152; "Street No. int"; Integer)
        { }
        field(50153; "Max Difference"; Integer)

        {
            Caption = 'Max Difference'; //maksimalna potrošnja
        }
        field(50154; "Difference Last Month"; Integer)

        {
            Caption = 'Difference Last Month'; //razlika u odnosu na prošli mjesec (procenat opseg dozvoljeni)  - za usporedbu
            //kada dodam 20 posto, koliko dobijem razlike: 


        }

        field(50155; "Difference Out of range"; Boolean)

        {
            Caption = 'Max Difference';
            //označim crvenim kako bi mogli da ih filtriraju
        }
        field(50156; "Date Difference 1"; date)

        {
            Caption = 'Date Difference 1';
            //proizvoljni datum 2
        }

        field(50157; "Difference Amount 1"; Integer)

        {
            Caption = 'Difference Amount 1';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Difference Range 1" := "Difference Amount 1" - Difference;

            end;
            //odnos razlike
        }

        field(50158; "Difference Out of range 1"; Boolean)

        {
            Caption = 'Max Difference 1';
        }

        field(50159; "Date Difference 2"; Date)

        {
            Caption = 'Date Difference 2';
        }

        field(50160; "Difference Amount 2"; Integer)

        {
            Caption = 'Difference Amount 2';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Difference Range 2" := "Difference Amount 2" - Difference;

            end;

        }

        field(50161; "Difference Out of range 2"; Boolean)

        {
            Caption = 'Difference Out of range 2';
        }

        ///3

        field(50162; "Date Difference 3"; date)

        {
            Caption = 'Date Difference 2';
        }

        field(50163; "Difference Amount 3"; Integer)

        {
            Caption = 'Difference Amount 3';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Difference Range 3" := "Difference Amount 3" - Difference;

            end;
        }

        field(50164; "Difference Out of range 3"; Boolean)

        {
            Caption = 'Difference out of range 3';
        }
        ///4

        field(50165; "Date Difference 4"; date)

        {
            Caption = 'Difference Date 4';
        }

        field(50166; "Difference Amount 4"; Integer)

        {
            Caption = 'Difference Amount 4';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Difference Range 4" := "Difference Amount 4" - Difference;

            end;

        }

        field(50167; "Difference Out of range 4"; Boolean)

        {
            Caption = 'Difference out of range 4';
        }

        ///5

        field(50168; "Date Difference 5"; Date)

        {
            Caption = 'Difference date 5';
        }

        field(50169; "Difference Amount 5"; Integer)

        {
            Caption = 'Difference Amount 5';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Difference Range 5" := "Difference Amount 5" - Difference;

            end;
        }

        field(50170; "Difference Out of range 5"; Boolean)

        {
            Caption = 'Difference out of range 5';
        }

        //

        field(50171; "Range 1"; Decimal)

        {
            Caption = 'Range 1';
            MaxValue = 100;
        }
        field(50172; "Range 2"; Decimal)

        {
            Caption = 'Range 2';
            MaxValue = 100;
        }
        field(50173; "Range 3"; Decimal)

        {
            Caption = 'Range 3';
            MaxValue = 100;
        }

        field(50174; "Range 4"; Decimal)

        {
            Caption = 'Range 4';
            MaxValue = 100;
        }

        field(50175; "Range 5"; Decimal)

        {
            Caption = 'Range 5';
            MaxValue = 100;
        }
        field(50176; "Previous Calculations"; Integer)

        {
            Caption = 'Previous Calculations';
            FieldClass = Normal;
            // CalcFormula = count("Calculation Journal Line" where("Measuring Point Code" = field("Measuring Point Code"), Locked = filter(true)));

        }

        //Difference - odstupanje razlike 1


        field(50177; "Difference Range 1"; Integer)

        {
            Caption = 'Difference  Range 1';



        }
        field(50178; "Difference Range 2"; Integer)

        {
            Caption = 'Difference Range 2';

        }
        field(50179; "Difference Range 3"; Integer)

        {
            Caption = 'Difference Range 3';

        }

        field(50180; "Difference Range 4"; Integer)

        {
            Caption = 'Difference Range 4';

        }

        field(50181; "Difference Range 5"; Integer)

        {
            Caption = 'Difference Range 5';

        }

        field(50182; "Basis Resource Code"; Code[20])

        {
            Caption = 'Basis Resource Code';

        }

        field(50183; "War Resource Code"; Code[20])

        {
            Caption = 'War Resource Code';

        }
        field(50184; "Dwelling Type"; Text[250])
        {
            Caption = 'Dwelling Type';


        }
        field(50185; "Autoint"; Integer)
        {
            Caption = 'Autoin';
            //   AutoIncrement = true;
        }
        //5

        field(50186; "E-Mail 2"; Text[250])
        {
            Caption = 'Email 2';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail 2");
            end;
        }
        field(50187; "E-mail Delivery"; Option)
        {
            Caption = 'E-mail Delivery';
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;

        }
        field(50188; "E-mail Delivery Date"; Date)
        {
            Caption = 'E-mail Delivery Date';


        }
        field(50189; "E-mail Delivery Date to"; Date)
        {
            Caption = 'E-mail Delivery Date to';


        }
        field(50190; "Current Balance"; Decimal)
        {

            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Customer No."),
            "Bill type" = filter('01|02|03'), "Posting Date" = FIELD("Date Filter")

                                                                        ));
            Caption = 'Current Balance';
            Editable = false;
            FieldClass = FlowField;

        }
        field(50191; "Return RN"; Boolean)
        {
            Caption = 'Return RN';
            trigger onvalidate()
            var
                myInt: Integer;
                SH: Record "Service Header";
                SILine: Record "Service Item Line";
            begin
                sh.Reset();
                sh.SetFilter("Calculation Code", '%1', rec.Code);
                if sh.FindSet() then
                    repeat
                        SILine.Reset();
                        SILine.SetFilter("Document No.", '%1', sh."No.");

                        SILine.SetFilter("Document Type", '%1', sh."Document Type");
                        SILine.SetFilter("Customer No.", '%1', rec."Customer No.");
                        SILine.SetFilter("Service Item No.", rec."Measuring Point Code");
                        SILine.SetFilter(Gauge, '%1', rec.Gauge);
                        if SILine.FindSet() then
                            repeat
                                if rec."Return RN" = True then
                                    SILine."Return RN" := true
                                else
                                    SILine."Return RN" := false;
                                SILine.Modify();
                            until SILine.Next() = 0;
                    until sh.Next() = 0;

            end;
        }
        field(50192; "Measuring point off"; Boolean)
        {
            Caption = 'Measuring point off';

        }
        field(50193; "Status MM"; enum "Status Cust/MM")
        {

            //  FieldClass = FlowField;
            //CalcFormula = lookup("Status History"."Information of processing" where(Active = const(true), "Measuring Point" = field("Measuring Point Code"), "Source Table" = filter(5940)));

        }
        field(50194; "Measuring point off Date"; Date)
        {
            Caption = 'Measuring point off Date';

        }
        field(50195; "Current Status MM"; enum "Status Cust/MM")
        {

            //  FieldClass = FlowField;
            //CalcFormula = lookup("Status History"."Information of processing" where(Active = const(true), "Measuring Point" = field("Measuring Point Code"), "Source Table" = filter(5940)));

        }
        field(50196; "Fictitious Code"; Integer)
        {
            Caption = 'Fictitious Code';
        }
        field(50197; "New and Old value compare"; Decimal)
        {
            Caption = 'New and Old value compare';
        }
        field(50198; "Reason for Control"; Text[250])
        {
            Caption = 'Reason for Control';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for Control"));

        }
        field(50199; "New and Old value compare Max"; Decimal)
        {
            Caption = 'New and Old value compare Max';
        }
        field(50200; "Measuring Zone - winter"; Integer)
        {
            Caption = 'Measuring Zone - winter';


        }
        field(50201; "Measuring Zone - summer"; Integer)
        {
            Caption = 'Measuring Zone - summer';


        }

        field(50202; "Old Gauge"; Boolean)
        {
            Caption = 'Old Gauge';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Old Gauge" = true then
                    "Filter by Old RMS" := true;

                if "Old Gauge" = true then "New Gauge" := false;

                if ("Old Gauge" = true) or ("New Gauge" = true) then
                    "Filter by Old RMS" := true
                else
                    "Filter by Old RMS" := false;
            end;


        }
        field(50203; "New Gauge"; Boolean)
        {
            Caption = 'Old Gauge';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "New Gauge" = true then
                    "Filter by Old RMS" := true;

                if "New Gauge" = true then
                    "Old Gauge" := false;

                if ("Old Gauge" = true) or ("New Gauge" = true) then
                    "Filter by Old RMS" := true
                else
                    "Filter by Old RMS" := false;

            end;

        }
        //podaci o dostavi računa

        field(50204; "Customer Stroke 2"; Integer)
        {
            Caption = 'Customer Stroke 2';
            TableRelation = Stroke.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin
                Stroke.Reset();
                Stroke.SetFilter(Code, '%1', "Customer Stroke 2");
                Stroke.SetFilter(Street, '%1', Rec."Street Customer 2");
                Stroke.SetFilter("MZ-Code", '%1', Rec."MZ Customer 2");
                Stroke.SetFilter("Municipality Code", '%1', Rec."Municipality Code Customer 2");
                if Stroke.FindFirst() then
                    "Customer String 2" := Stroke."Measuring Point string"
                else
                    "Customer String 2" := 0;

            end;

        }
        field(50205; "Customer String 2"; Integer)
        {
            Caption = 'Customer String 2';
            //  TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ Customer 2"), Street = field("Street Customer 2"), "Municipality Code" = field("Municipality Code Customer 2"));

        }


        //

        field(50207; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }

        field(50206; "Municipality Code Customer 2"; code[20])
        {
            Caption = 'Customer Municipality Code Customer 2';
            TableRelation = Municipality.Code where(Type = filter(Regular));

            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
                PostCode: Record "Post Code";

            begin
                Mun.Reset();
                Mun.SetFilter(Code, '%1', "Municipality Code Customer 2");
                mun.SetFilter(type, '%1', mun.Type::Regular);
                if Mun.FindFirst() then begin
                    "City 2" := Mun.City;
                    PostCode.Reset();
                    PostCode.SetFilter(City, '%1', "City 2");
                    if PostCode.FindFirst() then
                        "Post Code 2" := PostCode.Code
                    else
                        "Post Code 2" := '';
                end
                else begin
                    "City 2" := '';
                    "Post Code 2" := '';
                end;
                //   CalcFields("Street Name Customer", "Street Name Customer 2");

                "Address Customer" := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";
            end;

        }
        field(50208; "Zone stroke 2"; Integer)
        {
            Caption = 'Zone stroke 2';

        }

        field(50212; "Street MM"; Code[20])
        {
            Caption = 'Street MM ';

        }
        field(50063; "Street No. 2"; code[20])
        {
            Caption = 'Street No. 2';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"))
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                if "Street No. 2" <> '' then
                    Evaluate(myInt, "Street No. 2");

                if ("Street No. 2" <> '') and ("Street Customer 2" <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street No. 2");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', "Street Customer 2");
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer 2", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer 2", Stroke."MZ-Code");

                            Rec.Validate("Customer Stroke 2", Stroke.Code);
                            Rec.Validate("Customer String 2", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke 2", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer 2" := '';
                            "MZ Customer 2" := '';
                            //ĐK       "Street Customer" := '';
                            "Customer Stroke 2" := 0;
                            "Customer String 2" := 0;
                            "Zone stroke 2" := 0;

                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();
                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street Customer 2");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer 2", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer 2", Stroke."MZ-Code");

                            Rec.Validate("Customer Stroke 2", Stroke.Code);
                            Rec.Validate("Customer String 2", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke 2", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer 2" := '';
                            "MZ Customer 2" := '';

                            "Customer Stroke 2" := 0;
                            "Customer String 2" := 0;
                            "Zone stroke 2" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code Customer 2" := '';
                    "MZ Customer 2" := '';
                    "Customer Stroke 2" := 0;
                    "Customer String 2" := 0;
                    "Zone stroke 2" := 0;


                end;

                "Address Customer" := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

            end;
        }
        field(50050; "Municipality Name Customer 2"; Text[250])
        {
            Caption = 'Municipality name Customer 2';

        }

        field(50051; "MZ Customer 2"; code[20])
        {
            Caption = 'Customer Local Community 2';
            TableRelation = MZ.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //     "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;
        }
        field(50052; "MZ Name Customer 2"; Text[250])
        {
            Caption = 'MZ Name Customer 2';
        }

        field(50053; "Street Customer 2"; code[20])
        {
            Caption = 'Street Customer 2';
            TableRelation = Street.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                if ("Street No. 2" <> '') and ("Street Customer 2" <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street No. 2");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', "Street Customer 2");
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer 2", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer 2", Stroke."MZ-Code");
                            //ĐK   Rec.validate("Street Customer", Stroke.Street);
                            Rec.Validate("Customer Stroke 2", Stroke.Code);
                            Rec.Validate("Customer String 2", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke 2", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer 2" := '';
                            "MZ Customer 2" := '';
                            //ĐK       "Street Customer" := '';
                            "Customer Stroke 2" := 0;
                            "Customer String 2" := 0;
                            "Zone stroke 2" := 0;

                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();

                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street Customer 2");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer 2", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer 2", Stroke."MZ-Code");
                            Rec.Validate("Customer Stroke 2", Stroke.Code);
                            Rec.Validate("Customer String 2", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke 2", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer 2" := '';
                            "MZ Customer 2" := '';

                            "Customer Stroke 2" := 0;
                            "Customer String 2" := 0;
                            "Zone stroke 2" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code Customer 2" := '';
                    "MZ Customer 2" := '';
                    "Customer Stroke 2" := 0;
                    "Customer String 2" := 0;
                    "Zone stroke 2" := 0;


                end;

                //                CalcFields("Street Name Customer", "Street Name Customer 2");

                "Address Customer" := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

                //                "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;

        }

        field(50054; "Street Name Customer 2"; Text[250])
        {
            Caption = 'Street Name Customer 2';
        }


        field(50055; "Home No. Customer 2"; Code[5])
        {
            Caption = 'Home No. 2';
            //ĐK  TableRelation = Street."Home No." where(Code = field("Street Customer"));
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //   "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;
        }
        field(50056; "Apartment No. Customer 2"; Code[5])
        {
            Caption = 'Apartment No. Customer 2';
            //ĐK  TableRelation = Street."Apartment No." where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"), Floor = field("Floor Customer"));
        }
        field(50209; "Floor Customer 2"; code[20])
        {
            Caption = 'Floor Customer 2';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));


        }
        field(50211; "Zone stroke MM"; Integer)
        {
            Caption = 'Zone stroke MM';

        }
        field(50210; "City 2"; Text[30])
        {
            Caption = 'City 2';

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin


            end;
        }

        field(50059; "Post Code 2"; Code[20])
        {
            Caption = 'Post Code 2';



            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin



            end;
        }
        field(90006; "Street No.2 Text"; text[250])
        {
            Caption = 'Street No.2 text';
        }
        field(90007; "Street No.2 int"; Integer)
        {
            Caption = 'Street No.2 int';
        }

        field(90008; "Unobvious"; Boolean)
        {
            Caption = 'Unobvious';
        }

        field(90009; "Activity"; text[250])
        {
            Caption = 'Activity';
            TableRelation = "MM Activity".Description where(Type = const(Basic));

        }
        field(90010; "EU Activity"; text[250])
        {
            Caption = 'EU Activity';
            TableRelation = "MM Activity".Description where(Type = const(EU));

        }
        field(90011; "EF Activity"; text[250])
        {
            Caption = 'EF Activity';
            TableRelation = "MM Activity".Description where(Type = const(Ef));

        }

        field(90012; "Street No. MM"; Code[20])
        {
            Caption = 'Street No. MM';

        }
        field(90013; "Street No. Text MM"; text[250])
        {
            Caption = 'Street No. MM';

        }
        field(90014; "Street No. Int MM"; Integer)
        {
            Caption = 'Street No. MM';

        }

        field(90015; "Customer No. int"; Integer)
        {
            Caption = 'Customer No. int';

        }
        field(90016; "Street No. Text int"; Integer)
        {
            Caption = 'Street No. Text int';
        }

        field(90017; "Street No. Text Apartment"; Integer)
        {
            Caption = 'Street No. Text Apartment';
        }
        field(90018; "Posting GAS"; enum Posting)
        {
            Caption = 'Posting GAS';



        }
        field(90019; "Filter by Old RMS"; Boolean)
        {
            Caption = 'Filter by Old RMS';


        }
        field(90020; "RN Date"; Date)
        {
            Caption = 'RN Date';


        }
        field(90021; "RN Reading Value"; Decimal)
        {
            Caption = 'RN Reading Value';


        }
        field(90022; "Bill distribution percentage"; Decimal)
        {
            Caption = 'Bill distribution percentage';
            MaxValue = 100;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;

        }

        field(90023; "Agreement"; Text[500])
        {
            Caption = 'Agreement';

        }
        field(90024; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            TableRelation = "Reminder Terms";
        }



        field(50094; "Winter Pecentage"; Decimal)
        {
            Caption = 'Winter Pecentage';
        }
        field(50095; "Summer Pecentage"; Decimal)
        {
            Caption = 'Summer Pecentage';
        }

        field(50096; "Pressure Date"; Date)
        {
            Caption = 'Pressure Date';

        }
        field(50097; "Adjusted Pressure"; Decimal)
        {
            Caption = 'Adjusted Pressure';
            DecimalPlaces = 1 : 4;

        }
        field(50098; "Sent e-mail"; Boolean)
        {
            Caption = 'Sent e-mail';

        }
        field(50099; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50100; "Difference Balance"; Boolean)
        {
            Caption = 'Difference Balance';

        }
        field(51198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(51199; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }
        field(51200; "Manualy War Value"; Boolean)
        {
            Caption = 'Manualy War Value';
        }
        field(51201; "Proceedings No. Print"; Code[20])
        {
            Caption = 'Proceedings No.';
        }



        field(51202; "Proceedings Order"; integer)
        {
            Caption = 'Proceedings Order';
        }

        //Billing Created Memo


        field(51203; "Billing Created Memo"; Boolean)
        {
            Caption = 'Billing Created Memo';
        }
        field(51204; "SM3 VAT Percentage"; Decimal)
        {
            Caption = 'SM3 VAT Percentage';
        }
        field(51205; "Main. VAT Percentage"; Decimal)
        {
            Caption = 'Main. VAT Percentage';
        }
        field(51206; "Sub. VAT Percentage"; Decimal)
        {
            Caption = 'Sub. VAT Percentage';
        }
        field(51207; "Q. total Sum - War"; Decimal)
        {
            Caption = 'Q. total Sum - War';
        }
        field(51208; "Undo Calculation"; Boolean)
        {
            Caption = 'Undo Calculation';
        }

field(51209; "Undo Document No.";Code[20])
        {
            Caption = 'Undo Document No.';
        }









        //kraj




        //kraj



















    }


    keys
    {
        key(Key1; "Code", MM, "Customer No.", Gauge, Autoint)
        {
        }
        key(Keys2; "Measuring Point Code", Locked)
        {
            SumIndexFields = Difference;
        }
        key(Key3; "Measuring Point Code", "Calculation Date To", Locked)
        {
            Enabled = false;
            SumIndexFields = SM3;
        }
        key(Key4; "Code", "Measuring Point Code", "New Value")
        {
        }

        key(Key5; Gauge, Code, "Calculation Date To", "New Value", "Reading Date To")
        {
        }

        key(Key6; Code, "Customer No.", "Bill Created", "Distribution", "Previous Unobvious Month", "Reading Date To")
        {
        }
        key(CustomerNoBillDistMonth; "Customer No.", "Bill Created", Distribution, "Previous Unobvious Month")
        {
            Clustered = false;
        }

        key(CustomerNoBillDistMonth2; Code, "Customer No.", "Bill Created", Distribution, "Previous Unobvious Month")
        {
            Clustered = false;
        }

        //("Measuring Point Stroke", "Measuring Point string", "Street No. Int MM", "Zone stroke MM")

        key(ExportVP; "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM", "Zone stroke MM", "Street No. Text int", "Street No. Text Apartment")
        {

        }
        key(ExportVPFilters; "Mobile No.", Code, Locked, "Reading Mode", "Reading Time", "Old Gauge", "Status MM")
        {

        }

        key(ExportVPFilters2; Code, Locked, "Reading Mode", "Reading Time", "Old Gauge", "Status MM")
        {

        }
        key(ExportVPFilters3; "Measuring Zone - summer", "Measuring Zone - winter", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM") { }

        key(ExportVPFilters4; "Measuring Zone - winter", "Measuring Zone - summer", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM") { }

        key(AppliedDoc; "Municipality Name Customer 2", "Street Name Customer 2", "Street No.2 int", "Street No.2 Text", "Street No. Text Apartment", "Apartment No. Customer 2", "Customer No. int", "Calculation Date To", "Reading Date To") { }


        key(InsertAdd; Code, "Customer No.", "Measuring Point Code", Gauge) { }



    }

    fieldgroups
    {
    }
    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if (Locked = true) and (UserId <> 'SARAJEVOGAS\TENEO') then
            Error('Obračun koji ima kreiran račun ne možete obrisati!');

    end;


    procedure Recalculation()
    var
        CustomerPrice: Record Customer;

        SP: Record "Sales Price";
        Reso: Record Resource;
        VPS: record "VAT Posting Setup";
        CU: Record Customer;
        CalSetup: Record "Calculation Setup";
        Item: Record item;
        CH: Record "Calcuation Header";
        TypeD: Record "Types Of Diseases";
        CustP: Record Customer;
        Perc: Decimal;
        NoSeries: Record "No. Series";
        DomV: Boolean;
        PercMM: Decimal;
        CHWin: Record "Calcuation Header";
        MMPerc: Record "Service Item";
        MMF: Record "Service Item";
        CustF: Record Customer;


    begin
        CalSetup.FindFirst();
        DomV := false;

        Item.Get(CalSetup."Item No.");
        ch.Get(Code);
        CustP.Reset();
        CustP.SetFilter("No.", '%1', rec."Customer No.");
        if CustP.FindFirst() then
            Perc := CustP."Bill distribution percentage";


        CHWin.reset;
        CHWin.setfilter(Code, '%1', code);
        if CHWin.findfirst then begin
            MMPerc.Reset();
            MMPerc.SetFilter("No.", '%1', "Measuring Point Code");
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




        CustomerPrice.Reset;
        CustomerPrice.SetFilter("No.", '%1', Rec."Customer No.");
        if CustomerPrice.FindFirst() then begin
            SP.Reset();
            sp.SetFilter("Sales Code", '%1', CustomerPrice."Customer Price Group");
            sp.SetFilter("Sales Type", '%1', sp."Sales Type"::"Customer Price Group");
            Sp.SetFilter("Starting Date", '<=%1', "Reading Date To");
            Sp.SetCurrentKey("Starting Date");
            sp.Ascending;
            if sp.FindLast() then begin
                "Unit Price" := SP."Unit Price";
                NoSeries.Reset();
                NoSeries.SetFilter("Customer Category", '%1', "Category Customer");
                NoSeries.SetFilter("Customer Price Group", '<>%1', '');
                if NoSeries.FindFirst() then begin
                    if NoSeries."Customer Price Group" = CustomerPrice."Customer Price Group" then
                        DomV := true
                    else
                        DomV := false;
                end
                else begin
                    DomV := false;
                end;

                if (("Category Customer" = "Category Customer"::"Large Economy") or ("Category Customer" = "Category Customer"::"KJKP Heating plant") or ("Category Customer" = "Category Customer"::"Small Economy"))
                and (DomV = true)
                 then begin
                    //ovdje đemina update
                    ///ĐEMINA
                    if sp."Price not by Gauge" = true then begin

                    end
                    else begin
                        TypeD.Reset();
                        TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                        TypeD.SetFilter("Description", '%1', "Gauge Size");
                        if TypeD.FindFirst() then begin
                            if "EL Volume Description" <> '' then
                                sp."Maintenance Resource No." := TypeD."Maintenance Resource No."
                            else
                                sp."Maintenance Resource No." := TypeD."Maintenance Resource without";

                        end;
                    end;
                end;


                if ("Category Customer" = "Category Customer"::"Large Economy") or ("Category Customer" = "Category Customer"::"KJKP Heating plant") then begin
                    if sp."Price not by Gauge" = true then begin

                    end else begin
                        TypeD.Reset();
                        TypeD.SetFilter(Types, '%1', TypeD.Types::"Gauge size");
                        TypeD.SetFilter("Description", '%1', "Gauge Size");
                        if TypeD.FindFirst() then begin
                            if "EL Volume Description" <> '' then
                                sp."Maintenance Resource No." := TypeD."Maintenance Resource No."
                            else
                                sp."Maintenance Resource No." := TypeD."Maintenance Resource without";

                        end;
                    end;
                end;

                Reso.Reset();
                Reso.SetFilter("No.", '%1', SP."Maintenance Resource No.");
                if Reso.FindFirst() then begin
                    "Basis maintenance" := Reso."Unit Price";
                    if perc <> 0 then begin
                        "Basis maintenance" := "Basis maintenance" * perc / 100;
                    end;




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
                    if CU.get(Rec."Customer No.") then
                        VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
                    if VPS.FindFirst() then begin
                        "Maintenance VAT" := round(("Basis maintenance" * VPS."VAT %") / 100, 0.01, '=');
                        "Main. VAT Percentage" := VPS."VAT %";
                    end;

                    if ch."Sales invoice Without M" = true then "Maintenance VAT" := 0;
                    if ch."Sales invoice Without M" = true then "Basis maintenance" := 0;
                    if ch."Sales invoice Without M" = true then "Main. VAT Percentage" := 0;


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

        end
        else begin
            "Unit Price" := 0;
            "Basis maintenance" := 0;

        end;
        "Maintenance - part" := "Basis maintenance" + "Maintenance VAT";
        if ch."Sales invoice Without M" = true then
            "Maintenance - part" := 0;

        if sm3 < 0 then
            SM3 := 0;

        "GAS - amount" := round(("Unit Price" * sm3), 0.01, '=');


        VPS.Reset();
        vps.SetFilter("VAT Prod. Posting Group", '%1', Item."VAT Prod. Posting Group");
        if CU.get(Rec."Customer No.") then
            VPS.SetFilter("VAT Bus. Posting Group", '%1', cu."VAT Bus. Posting Group");
        if VPS.FindFirst() then begin
            "GAS - VAT" := round((("GAS - amount" * VPS."VAT %") / 100), 0.01, '=');
            "SM3 VAT Percentage" := VPS."VAT %";
        end

        else begin
            "GAS - VAT" := 0;
            "SM3 VAT Percentage" := 0;
        end;

        MMF.Reset();
        MMF.SetFilter("No.", '%1', "Measuring Point Code");
        if MMF.FindFirst() then begin
            if MMF."MM VAT Excluded" = true then begin
                "GAS - VAT" := 0;
                "SM3 VAT Percentage" := 0;
            end;
        end;

        CustF.Reset();
        CustF.SetFilter("No.", '%1', "Customer No.");
        if CustF.FindFirst() then begin
            if CustF."Cust VAT Excluded" = true then
                "GAS - VAT" := 0;
        end;

        "GAS - part" := "GAS - VAT" + "GAS - amount";
        Total := "GAS - part" + "Maintenance - part";






    end;

    trigger OnInsert()
    var
        myInt: Integer;
        IntCus: Integer;
        us: Record "User Setup";

    begin

        if Evaluate(IntCus, "Customer No.") then
            "Customer No. int" := IntCus
        else
            "Customer No. int" := 0;
        us.reset;
        us.setfilter("Entries or Calculation", '%1', false);
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if Locked = true then
                Error('Obračun koji ima kreirane račune ne možete mijenjati');
        end;


    end;

    trigger OnModify()
    var
        myInt: Integer;
        US: record "User Setup";

    begin
        //ĐK if (Rec.SM3 <> xRec.SM3) or (rec."GAS - amount" <> xRec."GAS - amount") or (Difference <> xRec.Difference) or ("Old Value" <> xRec."Old Value") or ("New Value" <> xRec."New Value") then
        if (Locked = true) and (UserId <> 'SARAJEVOGAS\TENEO') then
            Error('Obračun koji ima kreiran račun ne možete mijenjati');

        if ("Filter by Old RMS" = false) and (Xrec."Old Value" <> Rec."Old Value") then begin
            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            if Us.FindFirst() then begin
                if us."Modify Old Value" = false then
                    Error('Nije moguće mijenjati staru vrijednost!');
            end;
        end;


        Recalculation();
        Rec.USERID_ID := USERID

    end;

}

