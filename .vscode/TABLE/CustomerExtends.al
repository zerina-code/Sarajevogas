tableextension 50018 CustomerExtends extends "Customer"
{



    fields
    {

        modify(Name)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                ServiceI: Record "Service Item";
                BrojMM: Integer;
            begin

                if "Contract Name" = '' then begin
                    if "Name 2" <> '' then
                        "Contract Name" := rec.Name + ' ' + "Name 2"
                    else
                        "Contract Name" := rec.Name;
                end;
                if rec."Customer Category" = rec."Customer Category"::Household then begin
                    ServiceI.reset;
                    ServiceI.SetFilter("Customer No.", '%1', rec."No.");
                    ServiceI.SetFilter("Status MM", '%1|%2|%3|%4', ServiceI."Status MM"::Active, ServiceI."Status MM"::Terminated, ServiceI."Status MM"::Potential, ServiceI."Status MM"::"Permanently deregistered");
                    if ServiceI.FindSet() then
                        repeat
                            ServiceI.Name := rec.Name + rec."Name 2";
                            ServiceI.Description := rec.Name + rec."Name 2";
                            ServiceI."Search Description" := rec.Name + rec."Name 2";
                            ServiceI."Customer Name. - Gauge" := rec.Name + rec."Name 2";
                            ServiceI.Modify();
                        until ServiceI.Next() = 0;
                end;

                if rec."Customer Category" <> rec."Customer Category"::Household then begin

                    ServiceI.reset;
                    ServiceI.SetFilter("Customer No.", '%1', rec."No.");
                    ServiceI.SetFilter("Status MM", '%1|%2|%3|%4', ServiceI."Status MM"::Active, ServiceI."Status MM"::Terminated, ServiceI."Status MM"::Potential, ServiceI."Status MM"::"Permanently deregistered");
                    BrojMM := ServiceI.Count;

                    if BrojMM = 1 then begin
                        ServiceI.reset;
                        ServiceI.SetFilter("Customer No.", '%1', rec."No.");
                        ServiceI.SetFilter("Status MM", '%1|%2|%3|%4', ServiceI."Status MM"::Active, ServiceI."Status MM"::Terminated, ServiceI."Status MM"::Potential, ServiceI."Status MM"::"Permanently deregistered");
                        if ServiceI.FindSet() then
                            repeat
                                ServiceI.Name := rec.Name + rec."Name 2";
                                ServiceI.Description := rec.Name + rec."Name 2";
                                ServiceI."Search Description" := rec.Name + rec."Name 2";
                                ServiceI."Customer Name. - Gauge" := rec.Name + rec."Name 2";
                                ServiceI.Modify();
                            until ServiceI.Next() = 0;
                    end;
                end;
            end;



        }



        modify("Name 2")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                ServiceI: Record "Service Item";
            begin
                if rec."Customer Category" = rec."Customer Category"::Household then begin
                    ServiceI.reset;
                    ServiceI.SetFilter("Customer No.", '%1', rec."No.");
                    ServiceI.SetFilter("Status MM", '%1|%2|%3|%4', ServiceI."Status MM"::Active, ServiceI."Status MM"::Terminated, ServiceI."Status MM"::Potential, ServiceI."Status MM"::"Permanently deregistered");
                    if ServiceI.FindSet() then
                        repeat
                            ServiceI.Name := rec.Name + rec."Name 2";
                            ServiceI.Description := rec.Name + rec."Name 2";
                            ServiceI."Search Description" := rec.Name + rec."Name 2";
                            ServiceI."Customer Name. - Gauge" := rec.Name + rec."Name 2";
                            ServiceI.Modify();
                        until ServiceI.Next() = 0;



                end;
            end;

        }


        field(50100; "Balance (LCY) Prepayment"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 Prepayment = filter(false)));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        //    VAT Base (retro.)
        field(50005; "Entity Code"; Code[2048])
        {

            DataClassification = ToBeClassified;
            TableRelation = Entity;
        }

        field(50000; "Registration No."; Text[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Registration No." <> '' then begin
                    IF StrLen("Registration No.") <> 12 then
                        ERROR('Mora imati 12 karaktera');
                end;
            end;

        }
        field(90017; "Contract Name"; Text[250])
        {

            Caption = 'Contract Name';

        }


        field(50004; "Entry Finished"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //VAT Amount (retro.)

        field(50006; "Old No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        //VAT

        field(50007; "Payment Terms Code 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }


        field(50008; "Payment Terms Code 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }



        field(50010; "Date Filter Block"; Date)
        {
            DataClassification = ToBeClassified;
        }

        /*    field(50009; "No. Of Blocks"; Integer)
            {
                FieldClass = FlowField;
                CalcFormula = count("Blocked By" WHERE("No." = field("No."), Date = field("Date Filter Block"), Blocked
                  = filter(All)));

            }*/


        field(50011; "Prepayment (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."), "Initial Entry Global Dim. 1"
              = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
              "Currency Code" = field("Currency Filter"), Prepayment = FILTER(true), "Entry Type" = filter("Initial Entry")));

        }


        field(50017; "Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(50018; "Debenture"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50021; "Insurance (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50022; "Allowed to Unlock Customer 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50023; "Allowed to Unlock Customer 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Orderer"; text[1000])
        {
            Caption = 'Orderer';
        }
        field(50025; "Contract Number"; Text[1000])
        {
            Caption = 'Contract Number';
        }
        field(50026; "Order person"; Text[1000])
        {
            Caption = 'Order person';
        }
        field(50027; "Responsible Person"; Text[1000])
        {
            Caption = 'Responsible Person';

        }
        field(50028; "Designer"; Text[1000])
        {
            Caption = 'Designer';
        }
        modify("VAT Registration No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                Length: Integer;
                Text000: Label 'The Max number of characters is 13.';

            begin
                if "VAT Registration No." <> '' then begin
                    "Tax Liable" := true;
                    Length := StrLen("VAT Registration No.");
                    IF Length > 13 then
                        ERROR(Text000);
                end;
            end;
        }
        field(50029; "Project manager"; Text[1000])
        {
            Caption = 'Project manager';
        }
        field(50030; "Responsible Person Infodom"; Text[1000])
        {
            Caption = 'Responsible Person Infodom';
        }

        field(50031; "Message Code"; Text[30])
        {
            TableRelation = Template_Message."Message Code" where("Type" = filter("Mail notification"), CustomerCOde = field("No."));
            Caption = 'Message Code';
        }
        field(5105; "E-Mail 2"; Text[250])
        {
            Caption = 'Email 2';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
                US: Record "User Setup";
                ECL: Record "Employee Contract Ledger";
                IH: Record "Installation History";
            begin
                // MailManagement.ValidateEmailAddressField("E-Mail 2");

                US.Reset();
                us.setfilter("User ID", '%1', userid);
                if us.FindFirst() then begin
                    rec."E-CZK" := us.CZK;
                    if rec."E-CZK" = '' then begin

                        ECL.Reset();
                        ECL.SetFilter("Employee No.", '%1', us."Employee No. for Wage");
                        ecl.SetFilter(Active, '%1', true);
                        if ecl.FindFirst() then begin
                            rec."E-CZK" := ecl."Department Name";
                        end
                        else begin
                            rec."E-CZK" := '';
                        end;
                    end;

                end
                else begin

                    rec."E-CZK" := '';
                end;
                IH.Reset();
                ih.SetFilter(Active, '%1', true);

                ih.SetFilter("Customer No.", '%1', rec."No.");

                if ih.FindSet() then
                    repeat
                        ih.Email := "E-Mail 2";
                        ih.Modify;

                    until ih.next() = 0;
            end;
        }


        field(50032; "Poruka test"; Text[30])
        {
            Caption = 'Message test';
        }
        field(50033; "Social status category"; enum "Social Status")
        {
            Caption = 'Social status category';
        }
        field(50034; "Customer Status"; enum "Status Cust/MM")
        {
            Caption = 'Customer Status';
            // ValuesAllowed = 0, 19, 50, 18, 49;
            FieldClass = FlowField;
            CalcFormula = lookup("Status History"."Information of processing" where(Active = filter(true), "Source Table" = filter(18), "Customer No." = field("No."
            )));
        }

        field(50035; "Municipality Code Customer"; code[20])
        {
            Caption = 'Customer Municipality Code Customer';
            TableRelation = Municipality.Code where(Type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
                PostCode: Record "Post Code";
                Contact: Record Contact;

            begin
                Mun.Reset();
                Mun.SetFilter(Code, '%1', "Municipality Code Customer");
                mun.SetFilter(Type, '%1', mun.type::Regular);
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
                end;


                CalcFields("Street Name Customer", "Street Name Customer 2");
                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name Customer" + ' ' + "Street No. Text"
                else
                    Address := "Street Name Customer" + ' ' + "Street No.";

                if ("Street No.2 Text" = 'bb') or ("Street No.2 Text" = 'BB') then
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No.2 Text"
                else
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

            end;
        }
        field(50036; "Municipality Name Customer"; Text[250])
        {
            Caption = 'Municipality name Customer';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code Customer"), Type = filter(Regular)));
        }

        field(50037; "MZ Customer"; code[20])
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
        field(50038; "MZ Name Customer"; Text[250])
        {
            Caption = 'MZ Name Customer';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ Customer")));
        }

        field(50039; "Street Customer"; code[20])
        {
            Caption = 'Street Customer';
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
                if ("Street No." <> '') and ("Street Customer" <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', "Street Customer");
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer", Stroke."MZ-Code");
                            //ĐK   Rec.validate("Street Customer", Stroke.Street);
                            Rec.Validate("Customer Stroke", Stroke.Code);
                            Rec.Validate("Customer String", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");

                        end
                        else begin
                            "Municipality Code Customer" := '';
                            "MZ Customer" := '';
                            //ĐK       "Street Customer" := '';
                            "Customer Stroke" := 0;
                            "Customer String" := 0;
                            "Zone stroke" := 0;

                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();

                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street Customer");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer", Stroke."MZ-Code");
                            Rec.Validate("Customer Stroke", Stroke.Code);
                            Rec.Validate("Customer String", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer" := '';
                            "MZ Customer" := '';

                            "Customer Stroke" := 0;
                            "Customer String" := 0;
                            "Zone stroke" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code Customer" := '';
                    "MZ Customer" := '';
                    "Customer Stroke" := 0;
                    "Customer String" := 0;
                    "Zone stroke" := 0;


                end;



                CalcFields("Street Name Customer", "Street Name Customer 2");

                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name Customer" + ' ' + "Street No. Text"
                else
                    Address := "Street Name Customer" + ' ' + "Street No.";

                if ("Street No.2 Text" = 'bb') or ("Street No.2 Text" = 'BB') then
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No.2 Text"
                else
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";


                //                "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;

        }

        field(50040; "Street Name Customer"; Text[250])
        {
            Caption = 'Street Name Customer';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street Customer")));
        }


        field(50041; "Home No. Customer"; Code[5])
        {
            Caption = 'Home No.';
            //ĐK  TableRelation = Street."Home No." where(Code = field("Street Customer"));
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //   "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;
        }
        field(50042; "Apartment No. Customer"; Code[5])
        {
            Caption = 'Apartment No. Customer';
            //ĐK  TableRelation = Street."Apartment No." where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"), Floor = field("Floor Customer"));
        }

        field(50043; "Floor Customer"; code[20])
        {
            Caption = 'Floor Customer';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));


        }


        field(50044; "Bill distribution percentage"; Decimal)
        {
            Caption = 'Bill distribution percentage';
            MaxValue = 100;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestField(Agreement);

            end;

        }

        field(50045; "Customer Stroke"; Integer)
        {
            Caption = 'Customer Stroke';
            //ĐK  TableRelation = Stroke.Code where("MZ-Code" = field("MZ Customer"), Street = field("Street Customer"), "Municipality Code" = field("Municipality Code Customer"));
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin

                Stroke.Reset();
                Stroke.SetFilter(Code, '%1', "Customer Stroke");
                Stroke.SetFilter(Street, '%1', Rec."Street Customer");
                Stroke.SetFilter("MZ-Code", '%1', Rec."MZ Customer");
                Stroke.SetFilter("Municipality Code", '%1', Rec."Municipality Code Customer");
                if Stroke.FindFirst() then
                    "Customer String" := Stroke."Measuring Point string"
                else
                    "Customer String" := 0;

            end;

        }
        field(50046; "Customer String"; Integer)
        {
            Caption = 'Customer String';
            //ĐK    TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ Customer"), Street = field("Street Customer"), "Municipality Code" = field("Municipality Code Customer"));


        }


        field(50047; "Customer Stroke 2"; Integer)
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
        field(50048; "Customer String 2"; Integer)
        {
            Caption = 'Customer String 2';
            //  TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ Customer 2"), Street = field("Street Customer 2"), "Municipality Code" = field("Municipality Code Customer 2"));

        }


        //

        field(50049; "Municipality Code Customer 2"; code[20])
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
                CalcFields("Street Name Customer", "Street Name Customer 2");

                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name Customer" + ' ' + "Street No. Text"
                else
                    Address := "Street Name Customer" + ' ' + "Street No.";

                if ("Street No.2 Text" = 'bb') or ("Street No.2 Text" = 'BB') then
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No.2 Text"
                else
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

            end;

        }
        field(50050; "Municipality Name Customer 2"; Text[250])
        {
            Caption = 'Municipality name Customer 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code Customer 2"), Type = filter(Regular)));
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
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ Customer 2")));
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

                CalcFields("Street Name Customer", "Street Name Customer 2");

                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name Customer" + ' ' + "Street No. Text"
                else
                    Address := "Street Name Customer" + ' ' + "Street No.";

                if ("Street No.2 Text" = 'bb') or ("Street No.2 Text" = 'BB') then
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No.2 Text"
                else
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";


                //                "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;

        }

        field(50054; "Street Name Customer 2"; Text[250])
        {
            Caption = 'Street Name Customer 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street Customer 2")));
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
        field(50057; "Floor Customer 2"; code[20])
        {
            Caption = 'Floor Customer 2';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));


        }
        field(50058; "City 2"; Text[30])
        {
            Caption = 'City 2';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;



            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin


                PostCode.ValidateCity("City 2", "Post Code 2", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);


            end;
        }

        field(50059; "Post Code 2"; Code[20])
        {
            Caption = 'Post Code 2';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;



            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin


                PostCode.ValidatePostCode("City 2", "Post Code 2", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);

            end;
        }

        field(50060; "Activity"; text[250])
        {
            Caption = 'Activity';
            TableRelation = "MM Activity".Description where(Type = const(Basic));

            trigger OnValidate()
            var
                myInt: Integer;
                MMA: Record "MM Activity";
            begin
                mma.Reset();
                mma.SetFilter(Description, '%1', Rec.Activity);
                mma.SetFilter(type, '%1', mma.Type::Basic);
                if MMA.FindFirst() then
                    "Activity Code" := MMA.Code
                else
                    "Activity Code" := '';

            end;

        }
        field(50066; "MM"; Integer)
        {
            Caption = 'MM';
            FieldClass = FlowField;
            CalcFormula = count("Service Item" WHERE("Customer No. - Gauge" = field("No.")));

        }

        field(50081; "Customer No. - MM"; Integer)

        {
            Caption = 'Customer No. - MM';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = count("Service Item" where("Customer No." = field("No."), "Status MM" = const(Active)));

        }
        field(50061; "Activity Code"; text[250])
        {
            Caption = 'Activity Code';


        }
        field(50062; "Street No."; code[20])
        {
            Caption = 'Street No.';

            //TableRelation = Street.Floor;
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin
                if "Street No." <> '' then
                    Evaluate(myInt, "Street No.");

                if ("Street No." <> '') and ("Street Customer" <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', "Street Customer");
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer", Stroke."MZ-Code");

                            Rec.Validate("Customer Stroke", Stroke.Code);
                            Rec.Validate("Customer String", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer" := '';
                            "MZ Customer" := '';
                            //ĐK       "Street Customer" := '';
                            "Customer Stroke" := 0;
                            "Customer String" := 0;
                            "Zone stroke" := 0;

                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();
                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street Customer");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code Customer", Stroke."Municipality Code");
                            Rec.Validate("MZ Customer", Stroke."MZ-Code");

                            Rec.Validate("Customer Stroke", Stroke.Code);
                            Rec.Validate("Customer String", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code Customer" := '';
                            "MZ Customer" := '';

                            "Customer Stroke" := 0;
                            "Customer String" := 0;
                            "Zone stroke" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code Customer" := '';
                    "MZ Customer" := '';
                    "Customer Stroke" := 0;
                    "Customer String" := 0;
                    "Zone stroke" := 0;


                end;

                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name Customer" + ' ' + "Street No. Text"
                else
                    Address := "Street Name Customer" + ' ' + "Street No.";

                if ("Street No.2 Text" = 'bb') or ("Street No.2 Text" = 'BB') then
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No.2 Text"
                else
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";



            end;

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

                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name Customer" + ' ' + "Street No. Text"
                else
                    Address := "Street Name Customer" + ' ' + "Street No.";

                if ("Street No.2 Text" = 'bb') or ("Street No.2 Text" = 'BB') then
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No.2 Text"
                else
                    "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";


            end;
        }
        field(50064; "Zone stroke"; Integer)
        {
            Caption = 'Zone stroke';

        }

        field(50065; "Zone stroke 2"; Integer)
        {
            Caption = 'Zone stroke 2';

        }

        field(50067; "Primary Contact No.2"; Code[20])
        {
            Caption = 'Primary Contact No.2';
            TableRelation = Contact;

            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin

                Commit();
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Type Relation" := UserSetup."Type Relation"::Customer;
                    UserSetup.Modify();
                end;
                Commit();
                LookupContactList;
                Commit();
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                Contact := '';
                if "Primary Contact No.2" <> '' then begin
                    Cont.Get("Primary Contact No.2");

                    CheckCustomerContactRelation(Cont);

                    //     if Cont.Type = Cont.Type::Person then
                    Contact := Cont.Name;

                    if Cont.Image.HasValue then
                        CopyContactPicture(Cont);

                    if Cont."Phone No." <> '' then
                        "Phone No." := Cont."Phone No.";
                    if Cont."E-Mail" <> '' then
                        "E-Mail" := Cont."E-Mail";
                    if Cont."Mobile Phone No." <> '' then
                        "Mobile Phone No." := Cont."Mobile Phone No.";

                end else
                    if Image.HasValue then
                        Clear(Image);

                "Primary Contact No." := "Primary Contact No.2";
            end;

        }
        field(50068; "E-mail Delivery"; Option)
        {
            Caption = 'E-mail Delivery';
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;

        }
        field(50069; "E-mail Delivery Date"; Date)
        {
            Caption = 'E-mail Delivery Date';


        }
        field(50070; "E-mail Delivery Date to"; Date)
        {
            Caption = 'E-mail Delivery Date to';


        }
        field(50071; "Customer ID"; Integer)
        {
            Caption = 'Customer ID';
            FieldClass = FlowField;
            CalcFormula = count("Customer ID" where("Customer No." = field("No."), Active = filter(true)));
        }

        //agreement
        field(50072; "Agreement"; Text[500])
        {
            Caption = 'Agreement';

        }



        field(90002; "Phone - Transfer"; Text[500])
        {
            Caption = 'Phone - Transfer';

        }
        field(90003; "Fax - Transfer"; Text[500])
        {
            Caption = 'Phone - Transfer';

        }
        field(90004; "Subsidies - YES/NO"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(90005; "Street No. Text"; text[250])
        {
            Caption = 'Street No. text';

            trigger OnValidate()
            var
                myInt: Integer;
            begin

                if ("Street No. Text" <> '') and (("Street No." = '') or ("Street No." = '0')) then begin
                    Validate("Street No.", '1');
                    "Street No." := '';

                end;

            end;
        }
        field(90006; "Street No.2 Text"; text[250])
        {
            Caption = 'Street No.2 text';

            trigger OnValidate()
            var
                myInt: Integer;
            begin

                if ("Street No.2 Text" <> '') and (("Street No. 2" = '') or ("Street No. 2" = '0')) then begin
                    Validate("Street No. 2", '1');
                    "Street No. 2" := '';

                end;

            end;
        }
        field(90007; "Box Number"; Text[250])
        {
            Caption = 'Box Number';
        }
        field(90008; "Internal Customer"; Boolean)
        {
            Caption = 'Internal Customer';
        }
        field(50073; "PDV_NUMBER"; Integer)
        {
            Caption = 'PDV Number';
        }
        field(50074; "Subsidies - has statement"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(50075; "Exclude from repost"; Boolean)
        {
            Caption = 'Exclude from repost';

        }

        //podaci o vlasniku

        field(50076; "Owner Primary Contact"; Code[20])
        {
            Caption = 'Owner Primary Contact No';
            TableRelation = Contact where("Type Relation" = filter(Owner));

            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin

                Commit();
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Type Relation" := UserSetup."Type Relation"::Owner;
                    UserSetup.Modify();
                end;
                Commit();
                LookupContactList;
                Commit();
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                Contact := '';
                if "Owner Primary Contact" <> '' then begin
                    Cont.Get("Owner Primary Contact");

                    CheckCustomerContactRelation(Cont);

                    if Cont.Type = Cont.Type::Person then
                        "Owner Contact" := Cont.Name;

                    if Cont.Image.HasValue then
                        CopyContactPicture(Cont);

                    if Cont."Phone No." <> '' then
                        "Owner Phone No." := Cont."Phone No.";
                    if Cont."E-Mail" <> '' then
                        "Owner E-Mail" := Cont."E-Mail";
                    if Cont."Mobile Phone No." <> '' then
                        "Owner Mobile Phone No." := Cont."Mobile Phone No.";

                end else
                    if Image.HasValue then
                        Clear(Image);


            end;

        }

        field(50077; "Owner Phone No."; Text[250])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Phone No.") do
                    if Char.IsLetter("Phone No."[i]) then
                        FieldError("Phone No.", PhoneNoCannotContainLettersErr);
            end;
        }

        field(50078; "Owner E-Mail"; Text[80])
        {
            Caption = 'Owner Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "E-Mail" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("E-Mail");
            end;
        }

        field(50079; "Owner Mobile Phone No."; Text[30])
        {
            Caption = 'Owner Mobile Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Mobile Phone No.") do
                    if Char.IsLetter("Mobile Phone No."[i]) then
                        FieldError("Mobile Phone No.", PhoneNoCannotContainLettersErr);
            end;
        }
        field(50080; "Owner Contact"; Text[100])
        {
            Caption = 'Owner Contact';


            trigger OnLookup()
            begin
                LookupContactList;

            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
                RMSetup: Record "Marketing Setup";
            begin
                IsHandled := false;
                if IsHandled then
                    exit;

                if RMSetup.Get then
                    if RMSetup."Bus. Rel. Code for OW" <> '' then
                        if (xRec."Owner Contact" = '') and (xRec."Owner Primary Contact" = '') and ("Owner Contact" <> '') then begin
                            Modify;

                            Modify(true);
                        end
            end;
        }
        field(50082; "Applied address"; Boolean)
        {
            Caption = 'Applied address';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Applied address" = true then begin
                    Validate("Street Customer 2", "Street Customer");
                    Validate("Street No. 2", "Street No.");
                    "Street No.2 Text" := "Street No. Text";

                    //5050

                end;

            end;
        }
        field(90009; "Way of Sending Reminder"; Enum AccusationDelivery)
        {

            Caption = 'Way of Sending Reminder';
        }
        field(90010; "Customer Phone No."; Text[30])
        {

            Caption = 'Customer Phone No.';
        }
        field(90011; "Documents for customer"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("A-B Attachments" where(Code = field("No."), Type = filter("Customer Documents"), Source = filter(Customer)));

        }

        field(90012; "Customer Connection"; Code[20])
        {

            Caption = 'Customer Connection';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                MM: Record "Service Item";
                GaugeG: Record Gauge;
                GaugeRename: Record gauge;
                IH: Record "Installation History";
                IHInsert: Record "Installation History";
                ServiceItem: Record "Service Item";

                //korektor
                CGaugeG: Record "El. Volume Corr";
                CGaugeRename: Record "El. Volume Corr";
                CIH: Record "Installation History";
                CIHInsert: Record "Installation History";
                IHLast: Record "Installation History";
                LastNo: Integer;

            begin

                IHLast.Reset();
                IHLast.SetCurrentKey(Autoincrement);

                if IHLast.FindLast() then
                    LastNo := IHLast.Autoincrement
                else
                    LastNo := 1;

                MM.Reset();
                MM.SetFilter("Customer No.", '%1', "Customer Connection");
                MM.SetFilter("Status MM", '%1', mm."Status MM"::Active);
                if mm.FindFirst() then begin

                    if Confirm('Da li želite promijeniti kupca za mjerno mjesto ' + format(mm."No.")) then begin
                        mm.validate("Customer No.", rec."No.");

                        mm.Validate(Description, rec.Name);
                        mm.Modify();



                        //mjerac
                        GaugeG.Reset();
                        GaugeG.SetFilter("Customer No.", '%1', "Customer Connection");
                        if GaugeRename.get(GaugeG.code, GaugeG."Measuring Point", GaugeG."Customer No.", GaugeG."Address MM") then
                            GaugeRename.Rename(GaugeG.code, GaugeG."Measuring Point", rec."No.", GaugeG."Address MM");


                        IH.SetFilter("Customer No.", '%1', "Customer Connection");
                        IH.SetFilter(Type, '%1', ih.Type::Gauge);
                        ih.SetCurrentKey("Installation Date");
                        ih.Ascending;
                        if ih.FindLast() then begin
                            IHInsert.Reset();
                            IHInsert.SetFilter("Installation Date", '%1', Today);
                            IHInsert.SetFilter("Customer No.", '%1', rec."No.");
                            if not IHInsert.FindFirst() then begin
                                IHInsert.Init();
                                IHInsert.TransferFields(ih);
                                IH.Active := false;
                                IH.Modify();
                                IHInsert.Autoincrement := LastNo + 1;
                                LastNo += 1;
                                IHInsert.Type := IHInsert.Type::Gauge;
                                IHInsert.validate("Customer No.", rec."No.");
                                IHInsert."Measuring Point Code" := MM."No.";
                                IHInsert."Installation Date" := today;
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                if ServiceItem.FindFirst() then begin
                                    IHInsert."Measuring Point Adress" := ServiceItem."Address MM";
                                    IHInsert."Measuring Point string" := ServiceItem."Measuring Point string";
                                    IHInsert."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                                    IHInsert.Active := true;

                                    IHInsert.Insert();
                                end;
                            end;

                        end;

                        //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")


                        CGaugeG.SetFilter("Customer No.", '%1', "Customer Connection");
                        if CGaugeG.FindFirst() then begin
                            if CGaugeG.get(CGaugeG.code, CGaugeG."Measuring Point", CGaugeG."Customer No.", CGaugeG."Address MM") then
                                CGaugeG.Rename(CGaugeG.code, CGaugeG."Measuring Point", rec."No.", CGaugeG."Address MM");
                        end;

                        IH.SetFilter("Customer No.", '%1', "Customer Connection");
                        IH.SetFilter(Type, '%1', ih.Type::Corrector);
                        ih.SetCurrentKey("Installation Date");
                        ih.Ascending;
                        if ih.FindLast() then begin
                            IHInsert.Reset();
                            IHInsert.SetFilter("Installation Date", '%1', Today);
                            IHInsert.SetFilter("Customer No.", '%1', rec."No.");
                            if not IHInsert.FindFirst() then begin
                                IHInsert.Init();
                                IHInsert.TransferFields(ih);
                                IH.Active := false;
                                IH.Modify();
                                IHInsert.Autoincrement := LastNo + 1;
                                LastNo += 1;
                                IHInsert.Type := IHInsert.Type::Corrector;
                                IHInsert."Installation Date" := today;
                                IHInsert.validate("Customer No.", rec."No.");
                                IHInsert."Measuring Point Code" := MM."No.";
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                if ServiceItem.FindFirst() then begin
                                    IHInsert."Measuring Point Adress" := ServiceItem."Address MM";
                                    IHInsert."Measuring Point string" := ServiceItem."Measuring Point string";
                                    IHInsert."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                                    IHInsert.Active := true;

                                    IHInsert.Insert();
                                end;

                            end;
                        end;

                        //radio module

                        IH.Reset();
                        IH.SetFilter("Customer No.", '%1', "Customer Connection");
                        IH.SetFilter(Type, '%1', ih.Type::Corrector);
                        ih.SetCurrentKey("Installation Date");
                        ih.Ascending;
                        if ih.FindLast() then begin
                            IHInsert.Reset();
                            IHInsert.SetFilter("Installation Date", '%1', Today);
                            IHInsert.SetFilter("Customer No.", '%1', rec."No.");
                            if not IHInsert.FindFirst() then begin
                                IHInsert.Init();
                                IHInsert.TransferFields(ih);
                                IH.Active := false;
                                IH.Modify();
                                IHInsert."Installation Date" := today;
                                IHInsert.Autoincrement := LastNo + 1;
                                LastNo += 1;
                                IHInsert.Type := IHInsert.Type::Radio_Module;
                                IHInsert.validate("Customer No.", rec."No.");
                                IHInsert."Measuring Point Code" := MM."No.";
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                if ServiceItem.FindFirst() then begin
                                    IHInsert."Measuring Point Adress" := ServiceItem."Address MM";
                                    IHInsert."Measuring Point string" := ServiceItem."Measuring Point string";
                                    IHInsert."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                                    IHInsert.Active := true;

                                    IHInsert.Insert();
                                end;

                            end;
                        end;
                    end;


                end;
            end;

        }
        field(90013; "Activity ID"; Code[20])
        {

            Caption = 'Activity ID';

        }
        field(90014; "Father Name"; Text[250])
        {

            Caption = 'Father Name';

            trigger OnValidate()
            var
                myInt: Integer;
                Separator: Integer;
            begin

                Separator := StrPos(Name, ' ');
                if Separator > 0 then begin

                    "Contract Name" := copystr(Name, 1, Separator) + '(' + "Father Name" + ') ' + copystr(Name, Separator + 1, StrLen(Name));

                end;

            end;

        }
        field(90016; "Agreement Customer No."; Code[20])
        {
            Caption = 'Agreement Customer No.';
            TableRelation = Customer."No.";
        }

        field(90018; "Cust VAT Excluded"; Boolean)
        {
            Caption = 'Cust VAT Excluded';
        }
        field(90019; "E-CZK"; Text[250])
        {
            Caption = 'E-CZK';
        }
        field(90020; "E-verification"; Boolean)
        {
            Caption = 'E-verification';
        }
        field(90021; "Customer Contract Number"; Text[250])
        {
            Caption = 'Customer Contract Number';

        }
        field(90022; "Contract Starting Date"; Date)
        {
            Caption = 'Customer Contract Starting Date';

        }
        field(90024; "MM Exsist"; Boolean)
        {
            Caption = 'MM';
            FieldClass = FlowField;
            CalcFormula = exist("Service Item" where("Customer No." = field("No.")));


        }


        field(90023; "Reminder Date"; Date)
        {
            Caption = 'Reminder Date';

        }

        field(90015; "MM Connection"; Code[20])
        {

            Caption = 'MM Connection';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                MM: Record "Service Item";
                GaugeG: Record Gauge;
                GaugeRename: Record gauge;
                IH: Record "Installation History";
                IHInsert: Record "Installation History";
                ServiceItem: Record "Service Item";

                //korektor
                CGaugeG: Record "El. Volume Corr";
                CGaugeRename: Record "El. Volume Corr";
                CIH: Record "Installation History";
                CIHInsert: Record "Installation History";
                IHLast: Record "Installation History";
                LastNo: Integer;

            begin

                IHLast.Reset();
                IHLast.SetCurrentKey(Autoincrement);

                if IHLast.FindLast() then
                    LastNo := IHLast.Autoincrement
                else
                    LastNo := 1;

                MM.Reset();
                MM.SetFilter("No.", '%1', "MM Connection");
                if mm.FindFirst() then begin

                    if Confirm('Da li želite promijeniti kupca za mjerno mjesto ' + format(mm."No.")) then begin
                        mm.validate("Customer No.", rec."No.");

                        mm.Validate(Description, rec.Name);
                        mm.Modify();



                        //mjerac
                        GaugeG.Reset();
                        GaugeG.SetFilter("Measuring Point", '%1', "MM Connection");

                        if GaugeRename.get(GaugeG.code, GaugeG."Measuring Point", GaugeG."Customer No.", GaugeG."Address MM") then
                            GaugeRename.Rename(GaugeG.code, "MM Connection", rec."No.", GaugeG."Address MM");

                        IH.Reset();
                        IH.SetFilter("Measuring Point Code", '%1', "MM Connection");
                        IH.SetFilter(Type, '%1', ih.Type::Gauge);
                        ih.SetCurrentKey("Installation Date");
                        ih.Ascending;
                        if ih.FindLast() then begin
                            IHInsert.Reset();
                            IHInsert.SetFilter("Installation Date", '%1', Today);
                            IHInsert.SetFilter("Customer No.", '%1', rec."No.");
                            IHInsert.SetFilter("Measuring Point Code", '%1', "MM Connection");
                            if not IHInsert.FindFirst() then begin
                                IHInsert.Init();
                                IHInsert.TransferFields(ih);
                                IH.Active := false;
                                IH.Modify();
                                IHInsert.Autoincrement := LastNo + 1;
                                LastNo += 1;
                                IHInsert.Type := IHInsert.Type::Gauge;
                                IHInsert.validate("Customer No.", rec."No.");
                                IHInsert."Measuring Point Code" := "MM Connection";
                                IHInsert."Installation Date" := today;
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', "MM Connection");
                                if ServiceItem.FindFirst() then begin
                                    IHInsert."Measuring Point Adress" := ServiceItem."Address MM";
                                    IHInsert."Measuring Point string" := ServiceItem."Measuring Point string";
                                    IHInsert."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                                    IHInsert.Active := true;

                                    IHInsert.Insert();
                                end;
                            end;

                        end;

                        //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")

                        CGaugeG.Reset();
                        CGaugeG.SetFilter("Measuring Point", '%1', "MM Connection");
                        if CGaugeG.FindFirst() then begin
                            if CGaugeG.get(CGaugeG.code, CGaugeG."Measuring Point", CGaugeG."Customer No.", CGaugeG."Address MM") then
                                CGaugeG.Rename(CGaugeG.code, "MM Connection", rec."No.", CGaugeG."Address MM");
                        end;

                        //  IH.SetFilter("Customer No.", '%1', "Customer Connection");
                        IH.Reset();
                        IH.SetFilter("Measuring Point Code", '%1', "MM Connection");
                        IH.SetFilter(Type, '%1', ih.Type::Corrector);
                        ih.SetCurrentKey("Installation Date");
                        ih.Ascending;
                        if ih.FindLast() then begin
                            IHInsert.Reset();
                            IHInsert.SetFilter("Installation Date", '%1', Today);
                            IHInsert.SetFilter("Customer No.", '%1', rec."No.");
                            IHInsert.SetFilter("Measuring Point Code", '%1', "MM Connection");
                            if not IHInsert.FindFirst() then begin
                                IHInsert.Init();
                                IHInsert.TransferFields(ih);
                                IH.Active := false;
                                IH.Modify();
                                IHInsert.Autoincrement := LastNo + 1;
                                LastNo += 1;
                                IHInsert.Type := IHInsert.Type::Corrector;
                                IHInsert."Installation Date" := today;
                                IHInsert.validate("Customer No.", rec."No.");
                                IHInsert."Measuring Point Code" := "MM Connection";
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', "MM Connection");
                                if ServiceItem.FindFirst() then begin
                                    IHInsert."Measuring Point Adress" := ServiceItem."Address MM";
                                    IHInsert."Measuring Point string" := ServiceItem."Measuring Point string";
                                    IHInsert."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                                    IHInsert.Active := true;

                                    IHInsert.Insert();
                                end;

                            end;
                        end;

                        //radio module

                        IH.Reset();
                        // IH.SetFilter("Customer No.", '%1', "Customer Connection");
                        IH.SetFilter("Measuring Point Code", '%1', "MM Connection");
                        IH.SetFilter(Type, '%1', ih.Type::Corrector);
                        ih.SetCurrentKey("Installation Date");
                        ih.Ascending;
                        if ih.FindLast() then begin
                            IHInsert.Reset();
                            IHInsert.SetFilter("Installation Date", '%1', Today);
                            IHInsert.SetFilter("Customer No.", '%1', rec."No.");
                            IHInsert.SetFilter("Measuring Point Code", '%1', "MM Connection");
                            if not IHInsert.FindFirst() then begin
                                IHInsert.Init();
                                IHInsert.TransferFields(ih);
                                IH.Active := false;
                                IH.Modify();
                                IHInsert."Installation Date" := today;
                                IHInsert.Autoincrement := LastNo + 1;
                                LastNo += 1;
                                IHInsert.Type := IHInsert.Type::Radio_Module;
                                IHInsert.validate("Customer No.", rec."No.");
                                IHInsert."Measuring Point Code" := MM."No.";
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', "MM Connection");
                                if ServiceItem.FindFirst() then begin
                                    IHInsert."Measuring Point Adress" := ServiceItem."Address MM";
                                    IHInsert."Measuring Point string" := ServiceItem."Measuring Point string";
                                    IHInsert."Measuring Point Stroke" := ServiceItem."Measuring Point Stroke";
                                    IHInsert.Active := true;

                                    IHInsert.Insert();
                                end;

                            end;
                        end;
                    end;


                end;
            end;


        }


    }





    trigger OnModify()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
        CU: Codeunit "Update Data Billing";
        CS: Record "Calculation Setup";
        ServiceItem: Record "Service Item";
        CUC: Record customer;
    begin
        if (xRec."No." <> Rec."No.") and (xrec."No." <> '') then
            Error('Nije moguće mijenjati već dodijeljenu šifru!');
        cs.Get();
        if cs."Update Data" = true then begin
            cu.UpdateCustomerData(rec);
        end;

        if rec."Customer Category" = rec."Customer Category"::Household then begin
            ServiceItem.Reset();
            serviceitem.SetFilter("No.", '%1', rec."No.");
            if ServiceItem.FindFirst() then begin

                CalcFields("Municipality Name Customer", "Street Name Customer", "MZ Name Customer");

                ServiceItem.Validate("Address Customer", Address);
                ServiceItem.Validate("MZ Customer", "MZ Customer");
                ServiceItem."MZ Name Customer" := "MZ Name Customer";
                ServiceItem.Validate("Street Customer", "Street Customer");
                ServiceItem."Street Name Customer" := "Street Name Customer";
                ServiceItem."Municipality Code Customer" := "Municipality Code Customer";
                ServiceItem."Municipality Name Customer" := "Municipality Name Customer";
                ServiceItem."Home No. Customer" := "Home No. Customer";
                ServiceItem."Customer Category" := "Customer Category";
                ServiceItem."Floor Customer" := "Floor Customer";
                ServiceItem."Customer string" := "Customer String";
                ServiceItem."Customer Stroke" := "Customer Stroke";

                ServiceItem."Apartment No. Customer" := "Apartment No. Customer";
                ServiceItem.Modify();

            end;

        end;





    end;

    trigger OnRename()
    var
        myInt: Integer;
    begin
        if (xRec."No." <> Rec."No.") and (xrec."No." <> '') then
            Error('Nije moguće mijenjati već dodijeljenu šifru!');

    end;

    trigger OnInsert()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
        NoSeries: Record "No. Series";
        SH: Record "Status History";
        MM: Record "Service Item";
        NoSeriesFind: Record "No. Series Line";
        NoSeriesFind2: Record "No. Series";
        US: Record "User Setup";
        SHLast: Record "Status History";
    begin
        if "No." <> '200359' then
            "Internal Customer" := false;

        "Reminder Terms Code" := 'OPOMENA';

        if "No. Series" <> '' then begin
            NoSeries.Reset();
            NoSeries.SetFilter(Code, '%1', rec."No. Series");
            if NoSeries.FindFirst() then begin
                Validate("Gen. Bus. Posting Group", NoSeries."Cust. Gen. Bus. Posting Group");
                validate("VAT Bus. Posting Group", NoSeries."Cust. VAT Bus. Posting Group");
                Validate("Customer Posting Group", NoSeries."Customer Posting Group");
                Validate("Customer Price Group", NoSeries."Customer Price Group");
                validate("Customer Category", NoSeries."Customer Category");
                "Application Method" := "Application Method"::"Apply to Oldest";
            end;
        end;
        if rec."Customer Category" = rec."Customer Category"::Household then begin
            MM.Init();
            mm."No." := rec."No.";
            mm."Customer No." := rec."No.";
            mm."MM Category" := mm."MM Category"::Household;
            mm."Customer Category" := mm."MM Category";
            us.Reset();
            us.SetFilter("User ID", '%1', UserId);
            if us.FindFirst() then begin
                us."Customer No." := mm."No.";
                us.Modify();
                Commit();

            end;
            NoSeriesFind2.Reset();
            NoSeriesFind2.SetFilter("Customer Category", '%1', rec."Customer Category"::Household);
            if NoSeriesFind2.FindFirst() then begin
                NoSeriesFind.reset;
                NoSeriesFind.setfilter("Series Code", '%1', NoSeriesFind2.Code);
                NoSeriesFind.SetFilter("Starting Date", '<=%1', WorkDate());
                NoSeriesFind.SetCurrentKey("Starting Date");
                NoSeriesFind.Ascending;
                if NoSeriesFind.FindLast() then begin
                    NoSeriesFind."Last No. Used" := mm."No.";
                    NoSeriesFind."Last Date Used" := today;
                    NoSeriesFind.Modify();
                    Commit();
                end;
            end;
            mm.Insert(true);
            Commit();

        end;

        SH.Init();
        SH."Customer No." := rec."No.";
        sh."Insert User ID" := UserId;
        sh."Insert Date and Time" := CurrentDateTime;
        sh."Source Table" := 18;
        sh."Information of processing" := sh."Information of processing"::Potential;
        sh.Active := true;

        SHLast.Reset();
        SHLast.SetFilter("Customer No.", '%1', rec."No.");
        SHLast.SetCurrentKey(Integer);
        SHLast.Ascending;
        if SHLast.FindLast() then
            SH.Integer := SHLast.Integer + 1
        else
            SH.Integer := 1;

        SH.Insert();


    end;

    trigger OnBeforeModify()
    begin
        if rec."VAT Registration No." <> '' then
            "Tax Liable" := true;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
    begin

        if UserId <> 'SARAJEVOGAS\TENEO' then
            Error('Karticu kupca nije moguće obrisati!');

    end;




    var
        myInt: Integer;
        OverrideImageQst: Label 'Override Image?';
        Text001: Label 'Do you want to change measuring point code?';
        Text003: Label 'Contact %1 %2 is not related to customer %3 %4.';

        PhoneNoCannotContainLettersErr: Label 'must not contain letters';

    local procedure CopyContactPicture(var Cont: Record Contact)
    var
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        FileManagement: Codeunit "File Management";
        ConfirmManagement: Codeunit "Confirm Management";
        ExportPath: Text;
    begin
        if Image.HasValue then
            if not ConfirmManagement.GetResponseOrDefault(OverrideImageQst, true) then
                exit;

        ExportPath := TemporaryPath + Cont."No." + Format(Cont.Image.MediaId);
        Cont.Image.ExportFile(ExportPath);
        FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
        TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
        TempNameValueBuffer.FindFirst;

        Clear(Image);
        Image.ImportFile(TempNameValueBuffer.Name, '');
        Modify;
        if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
    end;

    local procedure LookupContactList()
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        Cont: Record Contact;
        TempCust: Record Customer temporary;
        UserSetup: Record "User Setup";
    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."Type Relation" = UserSetup."Type Relation"::Owner
             then begin

                Commit();
                Cont.FilterGroup(2);
                if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Owner, "No.") then
                    Cont.SetRange("Company No.", ContactBusinessRelation."Contact No.")
                else
                    Cont.SetRange("Company No.", '');
                Cont.SetRange("Type Relation", cont."Type Relation"::Owner);


                if "Owner Primary Contact" <> '' then
                    if Cont.Get("Owner Primary Contact") then;
                Commit();
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    TempCust.Copy(Rec);
                    Find;
                    TransferFields(TempCust, false);
                    Validate("Owner Primary Contact", Cont."No.");
                end;

            end
            else begin

                Commit();
                Cont.FilterGroup(2);
                if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Customer, "No.") then
                    Cont.SetRange("Company No.", ContactBusinessRelation."Contact No.")
                else
                    Cont.SetRange("Company No.", '');
                Cont.SetRange("Type Relation", cont."Type Relation"::Customer);


                if "Primary Contact No.2" <> '' then
                    if Cont.Get("Primary Contact No.2") then;
                Commit();
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    TempCust.Copy(Rec);
                    Find;
                    TransferFields(TempCust, false);
                    Validate("Primary Contact No.2", Cont."No.");
                end;
            end;
        end;
    end;

    local procedure CheckCustomerContactRelation(Cont: Record Contact)
    var
        ContBusRel: Record "Contact Business Relation";
        IsHandled: Boolean;
        US: Record "User Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Type Relation" = us."Type Relation"::Customer then
                ContBusRel.FindOrRestoreContactBusinessRelation(Cont, Rec, ContBusRel."Link to Table"::Customer);
        end;

        IsHandled := false;

        if not IsHandled then
            if Cont."Company No." <> ContBusRel."Contact No." then
                Error(Text003, Cont."No.", Cont.Name, "No.", Name);
    end;




}