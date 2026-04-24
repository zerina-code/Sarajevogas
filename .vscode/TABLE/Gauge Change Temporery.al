table 50147 "Gauge Change Temporery"
{
    Caption = 'Gauge Change Temporery';
    //   DrillDownPageId = "EE Consents";
    // LookupPageId = "EE Consents";
    // DrillDownPageID = "Activities MM";gkexs
    // LookupPageID = "Activities MM";
    DrillDownPageId = "Gauge Tempoery List";
    LookupPageId = "Gauge Tempoery List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            //Ovo kod bi ja stavila kao parametar šifra zamjene na neki datum
        }

        field(50199; "Gas Station Placement"; Enum "Gas Station Placement")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station Placement';
        }

        field(47; "Remotely Type"; enum "Remotely Type")
        {
            Caption = 'Remotely Type';

        }
        field(48; "Remotely"; Boolean)
        {
            Caption = 'Remotely';
        }


        field(4; "Measuring Point Code"; code[20])
        {
            Caption = 'Measuring Point Code';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                ServiceII: Record "Service Item";
            begin
                ServiceII.reset;
                ServiceII.SetFilter("No.", '%1', "Measuring Point Code");
                if ServiceII.FindFirst() then begin
                    Validate(Remotely, ServiceII.Remotely);
                    Validate("Remotely Type", ServiceII."Remotely Type");
                    Validate("MM Description", ServiceII.Description);
                    validate("Address MM", ServiceII."Address MM");
                    validate("MZ MM", ServiceII."MZ MM");
                    validate("MZ Name MM", ServiceII."MZ Name MM");
                    validate("Street MM", ServiceII."Street Name MM");
                end
                else begin

                    Validate("MM Description", '');
                    validate("Address MM", '');
                    validate("MZ MM", '');
                    validate("MZ Name MM", '');
                    validate("Street MM", '');

                end;

            end;
        }
        field(20; "Installation Date"; Date)
        {
            Caption = 'Installation Date';
            //datum ugradnje koji je bio, a mi ga sad mijenjamo.
        }
        field(8; "Measuring Point Adress"; Text[250]) { Caption = 'Measuring Point Adress'; }


        field(10; "Measurer manufacturer"; Text[250]) { Caption = 'Measurer manufacturer'; }
        field(50112; "Meter Manufacturer Code"; Code[20])
        {
            Caption = 'Meter Manufacturer Code';
            TableRelation = Manufacturer;

            trigger OnValidate()
            var
                myInt: Integer;
                Manufacturer: Record Manufacturer;
            begin
                Manufacturer.reset;
                Manufacturer.setfilteR("Code", '%1', "Meter Manufacturer Code");
                if Manufacturer.findfirst then
                    "Measurer manufacturer" := Manufacturer.name
                else
                    "Measurer manufacturer" := '';
            end;
        }
        field(50113; "Meter Manufacturer Code New"; Code[20])
        {
            Caption = 'Meter Manufacturer Code';
            TableRelation = Manufacturer;

            trigger OnValidate()
            var
                myInt: Integer;
                Manufacturer: Record Manufacturer;
            begin
                Manufacturer.reset;
                Manufacturer.setfilteR("Code", '%1', "Meter Manufacturer Code New");
                if Manufacturer.findfirst then
                    "Measurer manufacturer New" := Manufacturer.name
                else
                    "Measurer manufacturer New" := '';
            end;
        }

        field(11; "Production Year"; Integer) { Caption = 'Production Year'; }
        field(12; "Calibration Year"; Integer) { Caption = 'Calibration Year'; }
        field(13; "Inventory Number"; Code[20]) { Caption = 'Inventory Number'; }

        field(18; "Serial Number I"; text[250]) { Caption = 'Serial Number I'; }
        field(19; "Serial Number II"; text[250]) { Caption = 'Serial Number II'; }

        field(21; "Dismantling date"; Date)
        {
            Caption = 'Dismantling date';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Installation Date" := "Dismantling date";
            end;
        }
        field(22; "Programming date"; Date) { Caption = 'Programming date'; }
        field(23; "Date of rescheduling"; date) { Caption = 'Date of rescheduling'; }

        field(42; "DD calibration"; Integer) { Caption = 'DD calibration'; }

        field(44; "Reason for dismantling"; Text[250])
        {
            Caption = 'Reason for dismantling';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));
            trigger OnValidate()
            var
                myInt: Integer;
                Us: Record
                 "User Setup";
            begin
                if "Dismantling date" = 0D then begin
                    "Dismantling date" := today;
                end;
                if "Date of consumption" = 0D then begin
                    "Date of consumption" := today;

                    "Installation Date" := today;
                end;
                if "Installation Date New" = 0D then begin
                    "Installation Date New" := today
                     ;
                end;

                Us.Reset();
                Us.SetFilter("User ID", '%1', UserId);
                if Us.FindFirst() then begin
                    us."Reason MM" := rec."Reason for dismantling";
                    us.Modify();
                    Commit();
                end;
            end;
        }
        field(45; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                CG: Record Customer;
            begin
                CG.Reset();
                CG.SetFilter("No.", '%1', rec."Customer No.");
                if cg.FindFirst() then
                    rec.Validate("Customer Name", cg.Name)
                else
                    rec.Validate("Customer Name", '');

            end;
        }
        field(46; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';

        }
        field(53; "Customer City"; Text[30])
        {
            //  CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Customer No.")));
            Caption = 'City';
            Editable = false;
            //   FieldClass = FlowField;
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(50000; "Municipality Code MM"; code[20])
        {
            Caption = 'Municipality Code MM';
            TableRelation = Municipality.Code where(type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
                PostCode: Record "Post Code";
            begin
                /*     Mun.Reset();
                     Mun.SetFilter(Code, '%1', "Municipality Code MM");
                     if Mun.FindFirst() then begin
                         City := Mun.City;
                         PostCode.Reset();
                         PostCode.SetFilter(City, '%1', City);
                         if PostCode.FindFirst() then
                             "Post Code" := PostCode.Code
                         else
                             "Post Code" := '';
                     end
                     else begin
                         City := '';
                         "Post Code" := '';
                     end;*/

            end;
        }
        field(50065; "Customer Zone stroke"; Integer)
        {
            Caption = 'Customer Zone stroke';

        }
        field(50015; "Street Name MM"; Text[250])
        {
            Caption = 'Street Name MM';
            // FieldClass = FlowField;
            //CalcFormula = lookup(Street.Description where(Code = field(Street)));
        }

        field(52; "Customer Post Code"; Code[20])
        {
            //   CalcFormula = Lookup(Customer."Post Code" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Post Code';
            Editable = false;
            //  FieldClass = FlowField;
        }
        field(50064; "Street No. MM"; Code[20])
        {
            Caption = 'Street No. MM';
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                /*   if ("Street No. MM" <> '') and (Street <> '') then begin

                       StreetText := TestSubsCu.RemoveLetter("Street No.");
                       Evaluate(StreetInteger, StreetText);
                       Even := TestSubsCu.EvenOrOdd(StreetInteger);
                       if Even = true then begin
                           Stroke.Reset();
                           Stroke.SetFilter(Street, '%1', Street);
                           Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                           Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                           if Stroke.FindFirst() then begin
                               Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                               Rec.Validate("MZ MM", Stroke."MZ-Code");

                               Rec.Validate("Measuring Point Stroke", Stroke.Code);
                               Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                               Rec.Validate("Zone stroke", Stroke."Zone stroke");
                           end
                           else begin
                               "Municipality Code MM" := '';
                               "MZ MM" := '';
                               //ĐK       "Street Customer" := '';
                               "Measuring Point Stroke" := 0;
                               "Measuring Point String" := 0;
                               "Zone stroke" := 0;

                           end;
                           //tražim parne

                       end
                       else begin

                           Stroke.Reset();
                           Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                           Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                           Stroke.SetFilter(Street, '%1', "Street");
                           if Stroke.FindFirst() then begin
                               Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                               Rec.Validate("MZ MM", Stroke."MZ-Code");

                               Rec.Validate("Measuring Point Stroke", Stroke.Code);
                               Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                               Rec.Validate("Zone stroke", Stroke."Zone stroke");
                           end
                           else begin
                               "Municipality Code MM" := '';
                               "MZ MM" := '';

                               "Measuring Point Stroke" := 0;
                               "Measuring Point String" := 0;
                               "Zone stroke" := 0;

                           end;


                       end;
                   end
                   else begin

                       "Municipality Code MM" := '';
                       "MZ MM" := '';
                       "Measuring Point Stroke" := 0;
                       "Measuring Point String" := 0;
                       "Zone stroke" := 0;


                   end;


                   CalcFields("Street Name MM");

                   Address := "Street Name MM" + ' ' + "Street No.";
                   "Address MM" := Address;*/
            end;

        }
        field(114; "MM Description"; Text[100])
        {
            Caption = 'MM Description';

            trigger OnValidate()
            begin

            end;
        }
        field(50; "Customer Address"; Text[100])
        {
            //     CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Customer No.")));
            Caption = 'Address';
            Editable = false;
            //   FieldClass = FlowField;
        }
        field(2; "Autoincrement"; integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;

        }
        field(50050; "Address MM"; text[250])
        {
            Caption = 'Address MM';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //   Address := "Address MM";

            end;


        }
        field(50002; "Street MM"; code[20])
        {
            Caption = 'Street MM';
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

                /*                if ("Street No." <> '') and (Street <> '') then begin

                                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                                    Evaluate(StreetInteger, StreetText);
                                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                                    if Even = true then begin
                                        Stroke.Reset();
                                        Stroke.SetFilter(Street, '%1', Street);
                                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                                        if Stroke.FindFirst() then begin
                                            Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                                            Rec.Validate("MZ MM", Stroke."MZ-Code");

                                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                                        end
                                        else begin
                                            "Municipality Code MM" := '';
                                            "MZ MM" := '';
                                            //ĐK       "Street Customer" := '';
                                            "Measuring Point Stroke" := 0;
                                            "Measuring Point String" := 0;
                                            "Zone stroke" := 0;

                                        end;
                                        //tražim parne

                                    end
                                    else begin

                                        Stroke.Reset();
                                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                                        Stroke.SetFilter(Street, '%1', "Street");
                                        if Stroke.FindFirst() then begin
                                            Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                                            Rec.Validate("MZ MM", Stroke."MZ-Code");

                                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                                        end
                                        else begin
                                            "Municipality Code MM" := '';
                                            "MZ MM" := '';

                                            "Measuring Point Stroke" := 0;
                                            "Measuring Point String" := 0;
                                            "Zone stroke" := 0;

                                        end;


                                    end;
                                end
                                else begin

                                    "Municipality Code MM" := '';
                                    "MZ MM" := '';
                                    "Measuring Point Stroke" := 0;
                                    "Measuring Point String" := 0;
                                    "Zone stroke" := 0;


                                end;
                                CalcFields("Street Name MM");

                                Address := "Street Name MM" + ' ' + "Street No.";
                                "Address MM" := Address;

                */
            end;



        }

        field(50019; "Measuring Point Stroke"; Integer)
        {
            Caption = 'Measuring Point Stroke';
            //TableRelation = Stroke.Code where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));

            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin


            end;
            //Hod


        }
        field(50020; "Measuring Point string"; Integer)
        {
            Caption = 'Measuring Point string';
            //    TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin



            end;
            //niz

        }
        field(50001; "MZ MM"; code[20])
        {
            Caption = 'Local Community';
            TableRelation = MZ.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin

                //     Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";

            end;
        }
        field(50014; "MZ Name MM"; Text[250])
        {
            Caption = 'MZ Name MM';
            //FieldClass = FlowField;
            // CalcFormula = lookup(MZ.Description where(Code = field("MZ MM")));
        }
        field(50057; "Customer Stroke"; Integer)
        {
            Caption = 'Customer Stroke';
            //Hod


        }
        field(50058; "Customer string"; Integer)
        {
            Caption = 'Customer string';
            //niz

        }

        field(50060; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }

        field(50061; "Date of consumption"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of consumption';

        }
        field(50063; "Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading';


        }


        /*  field(50061; "Calculation Valide"; Boolean)
          {
              Caption = 'Calculation Valide';

          }*/
        field(50062; "EL Volume Description"; text[250])
        {
            Caption = 'EL Volume Description';
        }


        //evidencija za novog mjerača

        field(50066; "Measuring Point Code New"; code[20])
        {
            Caption = 'Measuring Point Code New';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                ServiceII: Record "Service Item";
            begin
                ServiceII.reset;
                ServiceII.SetFilter("No.", '%1', "Measuring Point Code New");
                if ServiceII.FindFirst() then begin
                    Validate("MM Description New", ServiceII.Description);
                    validate("Address MM New", ServiceII."Address MM");
                    validate("MZ MM New", ServiceII."MZ MM");
                    validate("MZ Name MM New", ServiceII."MZ Name MM");
                    validate("Street MM New", ServiceII."Street Name MM");
                end
                else begin

                    Validate("MM Description New", '');
                    validate("Address MM New", '');
                    validate("MZ MM New", '');
                    validate("MZ Name MM New", '');
                    validate("Street MM New", '');

                end;

            end;
        }

        field(50067; "Installation Date New"; Date)
        {
            Caption = 'Installation Date';
            //datum ugradnje koji je bio, a mi ga sad mijenjamo.
        }

        field(50068; "Measuring Point Address New"; Text[250]) { Caption = 'Measuring Point Address New'; }


        //ovdje će sve biti new



        field(50069; "Measurer manufacturer New"; Text[250]) { Caption = 'Measurer manufacturer New'; }
        field(50070; "Production Year New"; Integer) { Caption = 'Production Year New'; }
        field(50071; "Calibration Year New"; Integer) { Caption = 'Calibration Year New'; }
        field(50072; "Inventory Number New"; Code[20]) { Caption = 'Inventory Number New'; }

        field(50073; "Serial Number I New"; text[250]) { Caption = 'Serial Number I New'; }
        field(50074; "Serial Number II New"; text[250]) { Caption = 'Serial Number New'; }

        field(50075; "Dismantling date New"; Date)
        {
            Caption = 'Dismantling date New';
        }
        field(50076; "Programming date New"; Date) { Caption = 'Programming date New'; }
        field(50077; "Date of rescheduling New"; date) { Caption = 'Date of rescheduling New'; }

        field(50078; "DD calibration New"; Integer) { Caption = 'DD calibration new'; }

        field(50079; "Reason for dismantling New"; Text[250])
        {
            Caption = 'Reason for dismantling';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));
        }
        field(50080; "Customer No. New"; Code[20])
        {
            Caption = 'Customer No. New';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                CG: record "Customer";
            begin
                CG.Reset();
                CG.SetFilter("No.", '%1', "Customer No. New");
                if cg.FindFirst() then
                    rec.Validate("Customer Name New", cg.Name)
                else
                    rec.Validate("Customer Name New", '');

            end;
        }
        field(50081; "Customer Name New"; Text[250])
        {
            Caption = 'Customer Name New';

        }
        field(50082; "Customer City New"; Text[30])
        {
            //  CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer City New';
            Editable = false;
            //   FieldClass = FlowField;
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(50083; "Municipality Code MM New"; code[20])
        {
            Caption = 'Municipality Code MM New';
            TableRelation = Municipality.Code where(type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
                PostCode: Record "Post Code";
            begin
                /*     Mun.Reset();
                     Mun.SetFilter(Code, '%1', "Municipality Code MM");
                     if Mun.FindFirst() then begin
                         City := Mun.City;
                         PostCode.Reset();
                         PostCode.SetFilter(City, '%1', City);
                         if PostCode.FindFirst() then
                             "Post Code" := PostCode.Code
                         else
                             "Post Code" := '';
                     end
                     else begin
                         City := '';
                         "Post Code" := '';
                     end;*/

            end;
        }
        field(50084; "Customer Zone stroke New"; Integer)
        {
            Caption = 'Customer Zone stroke New';

        }
        field(50085; "Street Name MM New"; Text[250])
        {
            Caption = 'Street Name MM New';
            // FieldClass = FlowField;
            //CalcFormula = lookup(Street.Description where(Code = field(Street)));
        }

        field(50086; "Customer Post Code New"; Code[20])
        {
            //   CalcFormula = Lookup(Customer."Post Code" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Post Code';
            Editable = false;
            //  FieldClass = FlowField;
        }
        field(50087; "Street No. MM New"; Code[20])
        {
            Caption = 'Street No. MM New';
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                /*   if ("Street No. MM" <> '') and (Street <> '') then begin

                       StreetText := TestSubsCu.RemoveLetter("Street No.");
                       Evaluate(StreetInteger, StreetText);
                       Even := TestSubsCu.EvenOrOdd(StreetInteger);
                       if Even = true then begin
                           Stroke.Reset();
                           Stroke.SetFilter(Street, '%1', Street);
                           Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                           Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                           if Stroke.FindFirst() then begin
                               Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                               Rec.Validate("MZ MM", Stroke."MZ-Code");

                               Rec.Validate("Measuring Point Stroke", Stroke.Code);
                               Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                               Rec.Validate("Zone stroke", Stroke."Zone stroke");
                           end
                           else begin
                               "Municipality Code MM" := '';
                               "MZ MM" := '';
                               //ĐK       "Street Customer" := '';
                               "Measuring Point Stroke" := 0;
                               "Measuring Point String" := 0;
                               "Zone stroke" := 0;

                           end;
                           //tražim parne

                       end
                       else begin

                           Stroke.Reset();
                           Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                           Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                           Stroke.SetFilter(Street, '%1', "Street");
                           if Stroke.FindFirst() then begin
                               Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                               Rec.Validate("MZ MM", Stroke."MZ-Code");

                               Rec.Validate("Measuring Point Stroke", Stroke.Code);
                               Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                               Rec.Validate("Zone stroke", Stroke."Zone stroke");
                           end
                           else begin
                               "Municipality Code MM" := '';
                               "MZ MM" := '';

                               "Measuring Point Stroke" := 0;
                               "Measuring Point String" := 0;
                               "Zone stroke" := 0;

                           end;


                       end;
                   end
                   else begin

                       "Municipality Code MM" := '';
                       "MZ MM" := '';
                       "Measuring Point Stroke" := 0;
                       "Measuring Point String" := 0;
                       "Zone stroke" := 0;


                   end;


                   CalcFields("Street Name MM");

                   Address := "Street Name MM" + ' ' + "Street No.";
                   "Address MM" := Address;*/
            end;

        }
        field(50088; "MM Description New"; Text[100])
        {
            Caption = 'MM Description New';

            trigger OnValidate()
            begin

            end;
        }
        field(50089; "Customer Address New"; Text[100])
        {
            //     CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Address New';
            Editable = false;
            //   FieldClass = FlowField;
        }

        field(50090; "Address MM New"; text[250])
        {
            Caption = 'Address MM New';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //   Address := "Address MM";

            end;


        }
        field(50091; "Street MM New"; code[20])
        {
            Caption = 'Street MM New';
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

                /*                if ("Street No." <> '') and (Street <> '') then begin

                                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                                    Evaluate(StreetInteger, StreetText);
                                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                                    if Even = true then begin
                                        Stroke.Reset();
                                        Stroke.SetFilter(Street, '%1', Street);
                                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                                        if Stroke.FindFirst() then begin
                                            Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                                            Rec.Validate("MZ MM", Stroke."MZ-Code");

                                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                                        end
                                        else begin
                                            "Municipality Code MM" := '';
                                            "MZ MM" := '';
                                            //ĐK       "Street Customer" := '';
                                            "Measuring Point Stroke" := 0;
                                            "Measuring Point String" := 0;
                                            "Zone stroke" := 0;

                                        end;
                                        //tražim parne

                                    end
                                    else begin

                                        Stroke.Reset();
                                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                                        Stroke.SetFilter(Street, '%1', "Street");
                                        if Stroke.FindFirst() then begin
                                            Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                                            Rec.Validate("MZ MM", Stroke."MZ-Code");

                                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                                        end
                                        else begin
                                            "Municipality Code MM" := '';
                                            "MZ MM" := '';

                                            "Measuring Point Stroke" := 0;
                                            "Measuring Point String" := 0;
                                            "Zone stroke" := 0;

                                        end;


                                    end;
                                end
                                else begin

                                    "Municipality Code MM" := '';
                                    "MZ MM" := '';
                                    "Measuring Point Stroke" := 0;
                                    "Measuring Point String" := 0;
                                    "Zone stroke" := 0;


                                end;
                                CalcFields("Street Name MM");

                                Address := "Street Name MM" + ' ' + "Street No.";
                                "Address MM" := Address;

                */
            end;



        }

        field(50092; "Measuring Point Stroke New"; Integer)
        {
            Caption = 'Measuring Point Stroke New';
            //TableRelation = Stroke.Code where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));

            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin


            end;
            //Hod


        }
        field(50093; "Measuring Point string New"; Integer)
        {
            Caption = 'Measuring Point string New';
            //    TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin



            end;
            //niz

        }
        field(50094; "MZ MM New"; code[20])
        {
            Caption = 'Local Community New';
            TableRelation = MZ.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin

                //     Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";

            end;
        }
        field(50095; "MZ Name MM New"; Text[250])
        {
            Caption = 'MZ Name MM New';
            //FieldClass = FlowField;
            // CalcFormula = lookup(MZ.Description where(Code = field("MZ MM")));
        }
        field(50096; "Customer Stroke New"; Integer)
        {
            Caption = 'Customer Stroke New';
            //Hod


        }
        field(50097; "Customer string New"; Integer)
        {
            Caption = 'Customer string New';
            //niz

        }

        field(50098; "Customer Category New"; enum Category)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Category New';


        }

        field(50099; "Date of consumption New"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of consumption New';

        }
        field(50100; "Reading New"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New';


        }


        /*  field(50061; "Calculation Valide"; Boolean)
          {
              Caption = 'Calculation Valide';

          }*/
        field(50101; "EL Volume Description New"; text[250])
        {
            Caption = 'EL Volume Description New';
        }
        field(50102; "Create Date"; Date)
        {
            Caption = 'Create Date';
        }
        field(50103; "Gauge Code"; Code[20])
        {
            Caption = 'Gauge Code';

            TableRelation = IF (Type = CONST(Gauge)) "Gauge"
            ELSE
            IF (Type = CONST(Corrector))
                                      "El. Volume Corr" else
            IF (Type = CONST(Radio_Module)) "Radio Module";

            ValidateTableRelation = false;


            //Gauge.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                GG: Record Gauge;
                IH: Record "Installation History";
                CG: Record Customer;
            begin


                IH.Reset();
                IH.SetFilter(Code, '%1', "Gauge Code");
                IH.SetFilter(Type, '%1', rec.type);
                IH.SetFilter(Active, '%1', true);
                IH.SetCurrentKey("Installation Date");
                IH.Ascending;
                if IH.FindLast() then begin
                    rec.Validate("Inventory Number", ih."Inventory Number");
                    rec.Validate("Measuring Point Code", ih."Measuring Point Code");
                    rec.Validate("Measuring Point Adress", ih."Measuring Point Adress");
                    rec.Validate("Customer No.", ih."Customer No.");
                    CG.Reset();
                    CG.SetFilter("No.", '%1', ih."Customer No.");
                    if cg.FindFirst() then
                        rec.Validate("Customer Name", cg.Name)
                    else
                        rec.Validate("Customer Name", '');

                end
                else begin
                    rec.Validate("Inventory Number", '');
                    rec.Validate("Measuring Point Code", '');
                    rec.Validate("Measuring Point Adress", '');
                    rec.Validate("Customer No.", '');

                    rec.Validate("Customer Name", '');


                end;
                if rec.Type = rec.Type::Gauge then begin
                    gg.Reset();
                    gg.SetFilter(Code, '%1', rec.Code);
                    if gg.FindFirst() then begin
                        gg."Gas Station Placement" := gg."Gas Station Placement";
                    end;
                end;


            end;


        }

        field(43; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,Gauge,Corrector,Radio_Module,Gauge_RM,Corrector_RM;
            OptionCaption = ' ,Gauge,Corrector,Radio_Module,Gauge_Radio_Module,Corrector_RadioModule';
        }

        field(50104; "Gauge Code New"; Code[20])
        {
            Caption = 'Gauge Code';
            //  TableRelation = Gauge.Code;

            TableRelation = IF (Type = CONST(Gauge)) "Gauge"
            ELSE
            IF (Type = CONST(Corrector))
                                      "El. Volume Corr" else
            IF (Type = CONST(Radio_Module)) "Radio Module";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
                GG: Record Gauge;
                IH: Record "Installation History";
                CG: Record Customer;
                GaguNe: Record Gauge;

            begin

                /*   rec.Validate("Inventory Number New", ih."Inventory Number");
                   rec.Validate("Measuring Point Code New", ih."Measuring Point Code");
                   rec.Validate("Measuring Point Address New", ih."Measuring Point Adress");
                   rec.Validate("Customer No. New", ih."Customer No.");*/
                rec.Validate("Inventory Number New", rec."Inventory Number");
                rec.Validate("Measuring Point Code New", rec."Measuring Point Code");
                rec.Validate("Measuring Point Address New", rec."Measuring Point Adress");
                rec.Validate("Customer No. New", rec."Customer No.");
                rec.Validate("Customer Name New", rec."Customer Name");
                rec.Validate("Customer Zone stroke New", rec."Customer Zone stroke");
                rec.Validate("Customer Stroke New", rec."Customer Stroke");
                rec.Validate("Customer string New", rec."Customer string");


                GaguNe.Reset();
                GaguNe.SetFilter(Code, '%1', rec."Gauge Code New");
                if GaguNe.FindFirst() then begin
                    rec.Validate("Meter Manufacturer Code New", GaguNe."Meter Manufacturer");
                    rec.Validate("Measurer manufacturer New", GaguNe."Meter Manufacturer Desc");
                    rec.Validate("Inventory Number New", GaguNe."Inventar number");
                end;
                CG.Reset();
                CG.SetFilter("No.", '%1', rec."Customer No. New");
                if cg.FindFirst() then
                    rec.Validate("Customer Name New", cg.Name)
                else
                    rec.Validate("Customer Name New", '');

                rec.Validate("Date of consumption New", today);

                ih.Reset();
                ih.SetFilter(Code, '%1', "Gauge Code New");
                ih.SetFilter(type, '%1', rec.Type);
                ih.SetCurrentKey("Installation Date");
                ih.Ascending;
                if ih.FindLast() then begin
                    rec.Validate("Calibration Year New", ih."Calibration Year");
                    rec.Validate("DD calibration New", ih."DD calibration");

                end;

            end;

        }


    }

    keys
    {
        key(Key1; "Code", "Measuring Point Code", Autoincrement, Type, "Gauge Code", "Gauge Code New")
        {
        }

    }



    fieldgroups
    {
    }
}

