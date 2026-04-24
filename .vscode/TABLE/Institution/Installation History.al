table 50109 "Installation History"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Installation History Page";
    LookupPageId = "Installation History Page";



    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';


            //Broj mjerača

        }

        field(2; "Autoincrement"; integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;

        }


        field(7; "Measuring Point Code"; Code[20])
        {
            Caption = 'Measuring Point Code';
            TableRelation = "Service Item"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                ServiceItem: Record "Service Item";
                Install: Record "Installation History";
                GFind: Record Gauge;
                Corr: Record "El. Volume Corr";
                RM: Record "Radio Module";
            begin

                if Type = Type::Gauge then begin
                    GFind.Reset();
                    GFind.SetFilter(Code, '%1', Code);
                    if GFind.FindFirst() then begin
                        "Gauge Size" := GFind."Gauge Size";
                        "Measurer manufacturer" := GFind."Meter Manufacturer Desc";


                    end;
                end;

                if Type = type::Corrector then begin
                    Corr.Reset();
                    Corr.SetFilter(Code, '%1', rec.Code);
                    if Corr.FindFirst() then begin
                        "Measurer manufacturer" := Corr."Meter Manufacturer Desc";
                    end;
                end;

                if Type = type::Radio_Module then begin
                    RM.Reset();
                    RM.SetFilter(Code, '%1', rec.Code);
                    if RM.FindFirst() then begin
                        "Measurer manufacturer" := RM."Meter Manufacturer Desc";
                    end;
                end;
                ServiceItem.Reset();
                ServiceItem.SetFilter("No.", '%1', "Measuring Point Code");
                if ServiceItem.FindFirst() then begin
                    "Measuring Point Adress" := ServiceItem."Address MM";
                    "Measuring Point string" := ServiceItem."Measuring Point string";
                    "Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                    "Municipality Code MM" := ServiceItem."Municipality Code MM";
                    "Remotely Type" := ServiceItem."Remotely Type";
                    Remotely := ServiceItem.Remotely;






                    Install.Reset();
                    Install.SetFilter("Measuring Point Code", '%1', "Measuring Point Code");
                    Install.SetFilter(Active, '%1', true);
                    if Install.FindFirst() then begin
                        Validate("Customer No.", Install."Customer No.");
                    end;


                end
                else begin
                    "Measuring Point Code" := '';
                    "Customer No." := '';
                    "Measuring Point Adress" := '';
                    "Measuring Point string" := 0;
                    "Measuring Point Stroke" := 0

                end;

            end;
        }
        field(8; "Measuring Point Adress"; Text[250]) { Caption = 'Measuring Point Adress'; }
        field(9; "Active"; Boolean)
        {
            Caption = 'Active';
        }



        field(10; "Measurer manufacturer"; Text[250]) { Caption = 'Measurer manufacturer'; }
        field(11; "Production Year"; Integer) { Caption = 'Production Year'; }
        field(12; "Calibration Year"; Integer) { Caption = 'Calibration Year'; }
        field(13; "Inventory Number"; Code[20]) { Caption = 'Inventory Number'; }



        field(18; "Serial Number I"; Text[250]) { Caption = 'Serial Number I'; }
        field(19; "Serial Number II"; Text[250]) { Caption = 'Serial Number II'; }
        field(20; "Installation Date"; Date)
        {
            Caption = 'Installation Date';
            trigger Onvalidate()
            var
                myInt: Integer;
                InstallH: Record "Installation History";

            begin

                if ("Installation Date" <= Today) and (("Dismantling date" = 0D) or ("Dismantling date" > Today)) then begin
                    Active := true
                end
                else
                    Active := false;

                //

                /*  InstallH.Reset();
                  InstallH.SetFilter(Type, '%1', InstallH.Type::Corrector);
                  InstallH.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point Code");
                  InstallH.SetFilter(Active, '%1', true);
                  if InstallH.FindFirst() then
                      Rec.Code := InstallH.Code
                  else
                      Rec.Code := '';
  */


            end;

        }
        field(21; "Dismantling date"; Date)
        {
            Caption = 'Dismantling date';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                if ("Installation Date" <= Today) and (("Dismantling date" = 0D) or ("Dismantling date" > Today)) then begin
                    Active := true
                end
                else
                    Active := false;
            end;
        }
        field(22; "Programming date"; Date) { Caption = 'Programming date'; }
        field(23; "Date of rescheduling"; date) { Caption = 'Date of rescheduling'; }

        field(42; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(43; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,Gauge,Corrector,Radio_Module,Gauge_RM,Corrector_RM;
            OptionCaption = ' ,Gauge,Corrector,Radio_Module,Gauge_Radio_Module,Corrector_RadioModule';
        }
        field(44; "Reason for dismantling"; Text[250])
        {
            Caption = 'Reason for dismantling';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));
        }
        field(45; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                Cust.reset;
                Cust.SetFilter("No.", '%1', "Customer No.");
                if Cust.FindFirst() then begin
                    "Customer Name" := Cust.Name;
                    "Customer Category" := Cust."Customer Category";
                    "Customer Category Filter" := Cust."Customer Category";
                    if "Customer Category Filter".AsInteger() in [4, 5, 6] then
                        "Customer Category Filter" := "Customer Category Filter"::"Large Economy";
                    "Customer Address" := Cust.Address;
                    "Customer City" := Cust.City;
                    "Customer Post Code" := cust."Post Code";
                    "Customer string" := cust."Customer String";
                    "Customer Stroke" := cust."Customer Stroke";
                    "Customer Zone stroke" := cust."Zone stroke";

                end
                else begin
                    "Customer Name" := '';
                    "Customer Category" := "Customer Category"::" ";
                    "Customer Category Filter" := "Customer Category Filter"::" ";
                    "Customer Address" := '';
                    "Customer City" := '';
                    "Customer Post Code" := '';
                    "Customer string" := 0;
                    "Customer Stroke" := 0;
                    "Customer Zone stroke" := 0;

                end;

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

        field(60099; "RN"; Code[20])
        {
            Caption = 'RN';
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
        field(4; "MM Description"; Text[100])
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
        field(47; "Remotely Type"; enum "Remotely Type")
        {
            Caption = 'Remotely Type';

        }
        field(48; "Remotely"; Boolean)
        {
            Caption = 'Remotely';
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
        field(50066; "Status MM"; enum "Status Cust/MM")
        {
            Caption = 'Status MM';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History MM"."Information of processing" where("Measuring Point" = field("Measuring Point Code"), "Source Table" = filter(5940), Active = filter(true)));
        }

        field(50067; "Year of Production"; Integer)
        {
            Caption = 'Year of Production"';

        }
        field(50079; "Gas Station Placement"; Enum "Gas Station Placement")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station Placement';
        }

        field(50068; "Gauge Size"; Text[250])
        {
            Caption = 'Gauge size';
            //TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(50069; "Gauge Type"; Text[100])
        {
            Caption = 'Description';
            TableRelation = "Types of Diseases".Description where(types = filter("Gauge Type"));
        }
        field(50070; "Radio Type"; enum "Type radio module")
        {
            Caption = 'Description';
            //  TableRelation = "Types of Diseases".Description where(types = filter("Gauge Type"));
        }


        field(50121; "Measuring point off"; Boolean)
        {
            Caption = 'Measuring point off';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Item"."Measuring point off" where("No." = field("Measuring Point Code")));

        }
        field(50122; "Measuring point off Date"; Date)
        {
            Caption = 'Measuring point off Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Item"."Measuring point off Date" where("No." = field("Measuring Point Code")));

        }
        field(50123; "Gauge Code"; Code[20])
        {
            Caption = 'Gauge Code';
            TableRelation = Gauge.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                G: Record gauge;
            begin
                G.Reset();
                G.SetFilter(Code, '%1', Rec."Gauge Code");
                if G.FindFirst() then
                    "Gauge Description" := G.Description
                else
                    "Gauge Description" := '';
            end;
        }
        field(50124; "Gauge Description"; Text[250])
        {
            Caption = 'Gauge Description';
        }
        field(50125; "Type Radio Module"; enum "Type radio module")
        {
            Caption = 'Type Radio Module';
        }
        field(50126; Model; text[250]) { Caption = 'Model'; }

        field(50127; InvterentoryFil; text[250]) { Caption = 'InvterentoryFil'; }
        field(50092; "Author UserName"; Text[250])
        {
            Caption = 'Author UserName';
            FieldClass = FlowField;
            CalcFormula = lookup(user."User Name" where("User Security ID" = field(SystemCreatedBy)));

        }
        field(50093; "Modify UserName"; Text[250])
        {
            Caption = 'Modify UserName';
            FieldClass = FlowField;
            CalcFormula = lookup(user."User Name" where("User Security ID" = field(SystemModifiedBy)));

        }
        field(50094; "Customer Category Filter"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(50095; Email; Text[250])
        {
            Caption = 'Email';

        }
        field(50096; "Billing"; Decimal)
        {
            Caption = 'Billing';
            FieldClass = FlowField;
            CalcFormula = Sum("Calculation Journal Line".SM3 WHERE("Measuring Point Code" = field("Measuring Point Code"),
            Locked = filter(true), "Calculation Date To" = FIELD("Date Filter")));


        }
        field(50097; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }

        field(50098; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(50099; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }

        field(60106; "Pressure Type"; enum "Pressure type")
        {
            Caption = 'Pressure Type';
        }

        field(60110; "Temperature Value"; decimal)
        {
            Caption = 'Temperature Value';
        }

        field(60111; "Adjusted Volume"; Decimal)
        {
            Caption = 'Adjusted Volume';
        }

        field(60112; "Unadjusted Volume"; Decimal)
        {
            Caption = 'Unadjusted Volume';
        }

        field(60113; "Absolute Pressure Of Corrector"; Decimal)
        {
            Caption = 'Absolute Pressure Of The Corrector';
            DecimalPlaces = 1 : 4;
        }
        field(60114; "Temperature"; Decimal)
        {
            Caption = 'Temperature';
        }
        field(60115; "Correction Factor"; Decimal)
        {
            Caption = 'Correction Factor';
            DecimalPlaces = 1 : 6;
        }
        field(60116; "Operating Pressure On ML"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Caption = 'Operating Pressure On ML';
        }




        //


        /*  field(50063; "Date Filter"; Date)
          {
              Caption = 'Date Filter';
              FieldClass = FlowFilter;
          }
          field(50066; "Date_V"; Date)
          {
              AutoFormatType = 1;
              CalcFormula = lookup("Installation History"."Installation Date" where("Installation Date" = field("Date Filter")));

              FieldClass = FlowField;
          }
          field(50067; "Date Filter 2"; Date)
          {
              Caption = 'Date Filter';
              FieldClass = FlowFilter;
          }
          field(50068; "Date_V2"; Date)
          {
              AutoFormatType = 1;
              FieldClass = FlowField;
              CalcFormula = lookup("Installation History"."Dismantling date" where("Dismantling date" = field("Date Filter 2")));


          }
  */







    }

    keys
    {
        key(Key1; Code, Type, Autoincrement, "Measuring Point Code", "Inventory Number")
        {
            Clustered = true;
        }
        /*   iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                        iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                        iHC.SetFilter(Active, '%1', true);
                        ihc.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");
                        iHC.SetLoadFields(Code, "EL Volume Description");*/

        key(Key2; Type, "Customer No.", Active, "Measuring Point Code", "EL Volume Description")
        {
        }

        /*  IHFacility.Reset();
                                IHFacility.SetFilter(Type, '%1', IHFacility.Type::Gauge);
                                IHFacility.SetFilter("Date of consumption", '%1', DataItem2."Dismantling date");
                                IHFacility.SetFilter(Code, '%1', DataItem2.Code);
                                if IHFacility.FindFirst() then begin*/

        key(Key3; Type, "Date of consumption", Code)
        {
        }

        /*
         IHFind.Reset();
                            IHFind.SetFilter(Code, '%1', DataItem2.Code);
                            IHFind.SetFilter(Type, '%1', DataItem2.Type::Gauge);
                            IHFind.SetFilter("Installation Date", '<%1', DataItem2."Installation Date");
                            IHFind.SetCurrentKey("Installation Date");
                            IHFind.Ascending(False);*/

        key(Key4; Code, Type, "Installation Date")
        {
        }
        /*iHC.Reset();
                                iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                                iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                                ihc.SetFilter("Dismantling date", '%1', cjl."Reading Date To");

                                ihc.SetFilter("Measuring Point Code", '%1', cjl."Measuring Point Code");

                                iHC.SetLoadFields(Code, "EL Volume Description");

                                iHC.SetCurrentKey("Installation Date");
                                iHC.Ascending(False);*/


        key(Key5; Type, "Customer No.", "Dismantling date", "Measuring Point Code")
        {
        }


    }
    fieldgroups
    {
        fieldgroup(DropDown; "Inventory Number", "Measuring Point Code", code, "Measuring Point Adress", "Customer No.", "Customer Name")
        {
        }
    }


    var
        myInt: Integer;

    trigger OnInsert()

    var
        userse: Record "User Setup";
        GYear: Record gauge;
        RYear: Record "Radio Module";
        CYear: Record "El. Volume Corr";
        MMnew: Record "Installation History";
        CUstCateg: Record CUstomer;
        CS: Record "Calculation Setup";
        CU: Codeunit "Update Data Billing";


    begin
        if "Installation Date" > WorkDate() then
            Error('Ne može datum biti veći od danas!');
        if (rec.Type = rec.Type::Gauge) and (Active = true) then begin
            MMnew.Reset();
            MMnew.SetFilter("Measuring Point Code", '%1', rec."Measuring Point Code");
            MMnew.SetFilter(Active, '%1', true);
            MMnew.SetFilter(Type, '%1', MMnew.Type::Gauge);
            MMnew.SetFilter(Code, '<>%1', rec.Code);
            if MMnew.FindFirst() then begin
                Message('Ovo mjerno mjesto već ima mjerač sa šifrom u novom sistemu ' + format(MMnew.Code) + ' potrebno je isti demontirati prije nešto što aplicirate promjene!');
            end;

        end;

        if rec."Customer No." <> '' then begin
            CUstCateg.Reset();
            CUstCateg.SetFilter("No.", '%1', rec."Customer No.");
            if CUstCateg.FindFirst() then begin
                "Customer Category" := CUstCateg."Customer Category";
                "Customer Category Filter" := "Customer Category";
                if "Customer Category" = "Customer Category"::"KJKP Heating plant" then
                    "Customer Category Filter" := "Customer Category Filter"::"Large Economy";
                if "Customer Category" = "Customer Category"::"Special Customer" then
                    "Customer Category Filter" := "Customer Category Filter"::"Large Economy";
                if "Customer Category" = "Customer Category"::CNG then
                    "Customer Category Filter" := "Customer Category Filter"::"Large Economy";
            end;

        end;
        userse.Reset();
        userse.SetFilter("User ID", '%1', UserId);
        if userse.FindFirst() then begin
            Validate("Customer No.", userse."Customer No.");
            if (Type = Type::Gauge) and (userse."Gauge Code" <> '') then
                Code := userse."Gauge Code";
            if (Type = Type::Radio_Module) and ((userse."Radio Module Code" <> '')) then
                Code := userse."Radio Module Code";
            if (Type = Type::Corrector) and (userse."Corrector Code" <> '') then
                Code := userse."Corrector Code";
            Validate("Measuring Point Code", userse."Measuring Code");


            if Type = Type::Gauge then begin

                GYear.Reset();
                GYear.SetFilter(Code, '%1', Code);
                if GYear.FindFirst() then begin
                    "Year of Production" := GYear."Year of Production";
                    "Production Year" := GYear."Year of Production";
                    "Inventory Number" := GYear."Inventar number";
                    InvterentoryFil := GYear."Inventar number";
                    "Gauge Size" := GYear."Gauge Size";
                    "Gauge Type" := GYear."Gauge Type";
                end;
            end;

            if Type = Type::Corrector then begin


                CYear.Reset();
                CYear.SetFilter(Code, '%1', Code);
                if CYear.FindFirst() then begin
                    "Year of Production" := CYear."Year of Production";
                    Model := CYear.Model;
                end;

                RYear.Reset();
                RYear.SetFilter(Code, '%1', Code);
                if RYear.FindFirst() then begin
                    "Year of Production" := RYear."Year of Production";
                    "Radio Type" := RYear."Type Radio Module"
                end;


            end;




        end;




    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        CS: Record "Calculation Setup";
        CU: Codeunit "Update Data Billing";
    begin


        if (Type = Type::Gauge) or (Type = Type::Corrector)
               then begin
            cs.get;
            if cs."Update Data" = true then begin
                if rec."Dismantling date" <> 0D then
                    cu.UpdateDeleteGaug(rec);
                Commit();
            end;

        end;
    end;

    trigger OnRename()
    begin

    end;

}