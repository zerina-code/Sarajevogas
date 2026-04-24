table 50149 "Customer Ledger Entry"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(90017; "Contract Name"; Text[250])
        {

            Caption = 'Contract Name';

        }
        field(90005; "Street No. Text"; text[250])
        {
            Caption = 'Street No. text';
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            trigger OnValidate()
            var
                myInt: Integer;
                cust: Record customer;
                ECL: record "Customer Ledger Entry";
            begin
                cust.Reset();
                cust.SetFilter("No.", '%1', rec."Customer No.");
                if cust.FindFirst() then begin
                    if (rec."Starting Date" = WorkDate()) or (Active = true) then begin
                        cust."Customer Contract Number" := Rec.Description;
                        cust."Contract Starting Date" := Rec."Starting Date";
                        cust.Modify();

                    end
                    else begin
                        ECL.reset;
                        ECL.SetFilter("Customer No.", '%1', rec."Customer No.");
                        ecl.SetFilter("Starting Date", '<=%1', WorkDate());
                        ecl.SetCurrentKey("Starting Date");
                        ecl.ascending;
                        if ecl.FindLast() then begin
                            cust."Customer Contract Number" := ecl.Description;
                            cust."Contract Starting Date" := ecl."Starting Date";
                            cust.Modify();
                        end;
                    end;

                end;

            end;

        }
        // Add changes to table fields here
        field(5000; "No. series"; Code[20])
        {
            Caption = 'No. series';

        }
        field(5001; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            trigger Onvalidate()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetFilter("No.", '%1', "Customer No.");
                if Cust.FindFirst() then begin
                    Rec."Customer Category" := Cust."Customer Category";
                    rec."Tax BooleanTest" := cust."Tax Liable";
                    Rec.Activity := Cust.Activity;
                    Rec."Activity Code" := Cust."Activity Code";
                    rec.Address := Cust.Address;
                    rec."Father Name" := cust."Father Name";
                    Rec."Address 2" := Cust."Address 2";
                    Rec.Agreement := Cust.Agreement;
                    Rec."Apartment No. Customer" := Cust."Apartment No. Customer";
                    Rec."Apartment No. Customer 2" := Cust."Apartment No. Customer 2";
                    Rec."Bill distribution percentage" := Cust."Bill distribution percentage";
                    Rec.City := Cust.City;
                    Rec."City 2" := Cust."City 2";
                    Rec."Country/Region Code" := Cust."Country/Region Code";
                    Rec.County := Cust.County;
                    Rec."Customer Name" := Cust.Name;
                    Rec."Customer String" := Cust."Customer String";
                    Rec."Customer String 2" := Cust."Customer String 2";
                    Rec."Customer Stroke" := Cust."Customer Stroke";
                    Rec."Customer Stroke 2" := Cust."Customer Stroke 2";
                    Rec."MZ Customer" := Cust."MZ Customer";
                    Rec."MZ Customer 2" := Cust."MZ Customer 2";
                    Rec."Floor Customer" := Cust."Floor Customer";
                    Rec."Floor Customer 2" := Cust."Floor Customer 2";
                    Rec."Street Customer" := Cust."Street Customer";
                    rec."Street Customer 2" := Cust."Street Customer 2";
                    Rec."Home No. Customer" := Cust."Home No. Customer";
                    Rec."Home No. Customer 2" := Cust."Home No. Customer 2";
                    Rec."Street Name Customer" := Cust."Street Name Customer";
                    Rec."Street Name Customer 2" := Cust."Street Name Customer 2";
                    Rec."Municipality Code Customer" := Cust."Municipality Code Customer";
                    Rec."Municipality Code Customer 2" := Cust."Municipality Code Customer 2";
                    Rec."Municipality Name Customer" := Cust."Municipality Name Customer";
                    Rec."Municipality Name Customer 2" := Cust."Municipality Name Customer 2";
                    Rec."MZ Name Customer" := Cust."MZ Name Customer";
                    Rec."MZ Name Customer 2" := Cust."MZ Name Customer 2";
                    Rec."Post Code" := Cust."Post Code";
                    Rec."Post Code 2" := Cust."Post Code 2";
                    Rec."Zone stroke" := Cust."Zone stroke";
                    Rec."Zone stroke 2" := Cust."Zone stroke 2";
                    rec."VAT Registration No." := cust."VAT Registration No.";
                    REC."Registration No." := CUST."Registration No.";
                    rec."Contract Name" := Cust."Contract Name";
                    if cust."Name 2" <> '' then begin
                        rec."Customer Name" := cust.Name + ' ' + Cust."Name 2";
                    end;


                    if "Contract Name" = '' then
                        rec."Contract Name" := Cust.Name;

                    rec."Street No. Text" := Cust."Street No. Text";
                    rec."Street No.2 Text" := Cust."Street No.2 Text";




                end
                else begin

                end;
            end;




        }
        field(5002; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
            Editable = false;
        }
        field(5003; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            var
                myInt: Integer;
                ECL: record "Customer Ledger Entry";
                Cust: Record Customer;
            begin
                if (rec."Starting Date" <= today) and ((rec."Ending Date" = 0D) or (rec."Ending Date" >= today)) then begin

                    Active := true;
                    ECL.reset;
                    ECL.SetFilter("Customer No.", '%1', rec."Customer No.");
                    ecl.SetCurrentKey("Starting Date");
                    ecl.ascending;
                    if ecl.FindLast() then begin
                        if (ecl."Ending Date" = 0D) and (Rec."Starting Date" <> 0D) then begin
                            ecl."Ending Date" := CalcDate('<-1D>', rec."Starting Date");
                        end;

                    end;
                    cust.Reset();
                    cust.SetFilter("No.", '%1', rec."Customer No.");
                    if cust.FindFirst() then begin
                        if rec."Starting Date" = WorkDate() then begin
                            cust."Customer Contract Number" := Rec.Description;
                            cust."Contract Starting Date" := Rec."Starting Date";
                            cust.Modify();

                        end
                        else begin
                            cust."Customer Contract Number" := ecl.Description;
                            cust."Contract Starting Date" := ecl."Starting Date";
                            cust.Modify();
                        end;
                    end;

                end
                else begin
                    ECL.reset;
                    ECL.SetFilter("Customer No.", '%1', rec."Customer No.");
                    ecl.SetFilter("Starting Date", '<=%1', WorkDate());
                    ecl.SetCurrentKey("Starting Date");
                    ecl.ascending;
                    if ecl.FindLast() then begin
                        cust.Reset();
                        cust.SetFilter("No.", '%1', rec."Customer No.");
                        if cust.FindFirst() then begin
                            cust."Customer Contract Number" := ecl.Description;
                            cust."Contract Starting Date" := ecl."Starting Date";
                            cust.Modify();
                        end;

                    end;
                end;

            end;


        }
        field(5004; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(5005; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(5008; "Active"; Boolean)
        {
            Caption = 'Active';
        }

        field(92; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(91; "Post Code"; Code[20])
        {
            Editable = false;
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin


                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");


            end;

            trigger OnValidate()
            begin


                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);


            end;
        }
        field(5006; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");

                if "Country/Region Code" <> xRec."Country/Region Code" then
                    ;
            end;
        }
        field(5007; City; Text[30])
        {
            Caption = 'City';
            Editable = false;
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin


                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin


                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);


            end;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            Editable = false;
        }
        field(6; "Address 2"; Text[50])
        {
            Editable = false;
            Caption = 'Address 2';
        }
        field(50035; "Municipality Code Customer"; code[20])
        {
            Caption = 'Customer Municipality Code Customer';
            Editable = false;
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
                Mun.SetFilter(type, '%1', mun.Type::Regular);
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

                Address := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

            end;
        }
        field(50036; "Municipality Name Customer"; Text[250])
        {
            Caption = 'Municipality name Customer';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code Customer"), type = filter(Regular)));
        }

        field(50037; "MZ Customer"; code[20])
        {
            Editable = false;
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
            Editable = false;
            Caption = 'MZ Name Customer';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ Customer")));
        }

        field(50039; "Street Customer"; code[20])
        {
            Caption = 'Street Customer';
            TableRelation = Street.Code;
            Editable = false;
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

                Address := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

                //                "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;

        }

        field(50040; "Street Name Customer"; Text[250])
        {
            Caption = 'Street Name Customer';
            FieldClass = FlowField;
            Editable = false;
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
        field(50072; "Agreement"; Text[500])
        {
            Caption = 'Agreement';

        }

        field(50045; "Customer Stroke"; Integer)
        {
            Editable = false;
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
            Editable = false;
            Caption = 'Customer String';
            //ĐK    TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ Customer"), Street = field("Street Customer"), "Municipality Code" = field("Municipality Code Customer"));


        }


        field(50047; "Customer Stroke 2"; Integer)
        {
            Editable = false;
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
            Editable = false;
            Caption = 'Customer String 2';
            TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ Customer 2"), Street = field("Street Customer 2"), "Municipality Code" = field("Municipality Code Customer 2"));

        }


        //

        field(50049; "Municipality Code Customer 2"; code[20])
        {
            Editable = false;
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
                Mun.SetFilter(type, '%1', mun.Type::Regular);
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

                Address := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";
            end;

        }
        field(50050; "Municipality Name Customer 2"; Text[250])
        {
            Editable = false;
            Caption = 'Municipality name Customer 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code Customer 2"), Type = filter(Regular)));
        }

        field(50051; "MZ Customer 2"; code[20])
        {
            Editable = false;
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
            Editable = false;
            Caption = 'MZ Name Customer 2';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ Customer 2")));
        }

        field(50053; "Street Customer 2"; code[20])
        {
            Editable = false;
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

                Address := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

                //                "Address 2" := Rec."MZ Customer" + ' ' + Rec."Street Customer" + ' ' + Rec."Home No. Customer";

            end;

        }

        field(50054; "Street Name Customer 2"; Text[250])
        {
            Editable = false;
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
            Editable = false;
            Caption = 'Apartment No. Customer 2';
            //ĐK  TableRelation = Street."Apartment No." where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"), Floor = field("Floor Customer"));
        }
        field(50057; "Floor Customer 2"; code[20])
        {
            Editable = false;
            Caption = 'Floor Customer 2';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));


        }
        field(50058; "City 2"; Text[30])
        {
            Editable = false;
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
            Editable = false;
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

        }
        field(50066; "MM"; Integer)
        {
            Caption = 'MM';
            FieldClass = FlowField;
            CalcFormula = count("Service Item" WHERE("Customer No. - Gauge" = field("Customer No.")));

        }
        field(50061; "Activity Code"; text[250])
        {
            Caption = 'Activity Code';


        }
        field(50062; "Street No."; code[20])
        {
            Caption = 'Street No.';
            Editable = false;
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

                Address := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";


            end;

        }
        field(50063; "Street No. 2"; code[20])
        {
            Editable = false;
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

                Address := "Street Name Customer" + ' ' + "Street No.";
                "Address 2" := "Street Name Customer 2" + ' ' + "Street No. 2";

            end;
        }
        field(50064; "Zone stroke"; Integer)
        {
            Editable = false;
            Caption = 'Zone stroke';

        }

        field(50065; "Zone stroke 2"; Integer)
        {
            Editable = false;
            Caption = 'Zone stroke 2';

        }
        field(50067; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }

        field(50068; "NAV ID"; integer)
        {
            Caption = 'NAV ID';
            trigger OnValidate()
            var
                myInt: Integer;
                CRL: Record "Custom Report Layout";
                ReportLayoutSelection: Record "Report Layout Selection";
                HRSetup: Record "Human Resources Setup";
                tempSaveDest: Text[250];
                Contractwithoutpdv: report Contractwithoutpdv;
                contractforgas: report Contractforgas;
                safetygasbigeconomy: report Safetyofuniggascontract;
                safetygasbigeconomy1: report Annex1Contract;
                contractwithpdv: report contractwithpdv;
                FileManagement: Codeunit "File Management";
                Attachment: Record Attachment;
                Text004: Label 'Replace existing attachment?';
                AttachmentManagement: Codeunit AttachmentManagement;
                ServiceHeader: Record "Service Header";
                DepartmentCode: Code[20];
                CustVers: Record Customer;
                Emp_2: code[20];
                ServiceItemLine: record "Service Item Line";
                Manag: Boolean;
                ServiceItem: Record "Service Item";
                AB: Report "A-B";
                OrgSh: Record "ORG Shema";
                EmployeeContractLedger: Record "Employee Contract Ledger";
                UseriD_Rec: Record "User Setup";
                Department: Record Department;
                MM: Record "Service Item";
                CUstCategory: Record customer;

            begin

                if "NAV ID" = 50148 then begin

                    if Confirm('Da li želite otvoriti radni nalog za provjeru UGI?') then begin


                        ServiceHeader.Init();
                        ServiceHeader."No." := '';
                        ServiceHeader."A-B" := true;
                        ServiceHeader."A-B Entry" := rec.Code;
                        ServiceHeader.Validate("Reason For Service Order", 'PREGLED UGI I MJERNOG MJESTA ');

                        ServiceHeader."Request Type" := ServiceHeader."Request Type"::"General Work Order";
                        ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
                        ServiceHeader.validate("Customer No.", rec."Customer No.");
                        Rec.GetDefaultResponsibleDepartment(DepartmentCode, Manag, Emp_2);
                        Manag := false;

                        UseriD_Rec.Get(UseriD);
                        EmployeeContractLedger.Reset();
                        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                        EmployeeContractLedger.SetFilter(Active, '%1', true);
                        if EmployeeContractLedger.FindFirst() then begin
                            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                                Manag := true
                            else
                                Manag := false;
                        end;
                        Emp_2 := UseriD_Rec."Employee No. for Wage";

                        ServiceHeader."Responsible Department" := DepartmentCode;

                        OrgSh.Reset();
                        OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                        if OrgSh.FindFirst() then begin


                            Department.Reset();
                            Department.SetFilter(Code, '%1', DepartmentCode);
                            Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                            if Department.FindFirst() then
                                ServiceHeader."Responsible Department Name" := Department.Description
                            else
                                ServiceHeader."Responsible Department Name" := '';
                        end;
                        //    ServiceHeader."Bill type" := rec."Bill type";
                        //  ServiceHeader."Bill Category" := rec."Bill Category";


                        ServiceHeader."Request Department" := DepartmentCode;

                        OrgSh.Reset();
                        OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                        if OrgSh.FindFirst() then begin


                            Department.Reset();
                            Department.SetFilter(Code, '%1', DepartmentCode);
                            Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                            if Department.FindFirst() then
                                ServiceHeader."Request Department Name" := Department.Description
                            else
                                ServiceHeader."Request Department Name" := '';
                        end;

                        ServiceHeader.Insert(true);
                        //  rec."Service Order" := ServiceHeader."No.";
                        Commit();
                        ServiceItemLine.Init();
                        ServiceItemLine."Document No." := ServiceHeader."No.";
                        ServiceItemLine.Type := ServiceItemLine.Type::MM;
                        MM.Reset();
                        MM.SetFilter("Customer No.", '%1', rec."Customer No.");
                        if mm.FindFirst() then begin
                            //    ServiceItemLine.Validate("Service Item No. - Relation", mm."No.");
                            ServiceItemLine."Service Item No." := mm."No.";

                            if ServiceItemLine."Service Item No." = '' then begin
                                ServiceItemLine."Purpose" := '';
                                ServiceItemLine."Dwelling Type" := '';
                                ServiceItemLine."Elevation" := 0;
                                ServiceItemLine."Reading Mode" := ServiceItemLine."Reading Mode"::Digital;
                                ServiceItemLine."MM Category" := Enum::Category::" ";
                                ServiceItemLine."Municipality Code" := '';
                                ServiceItemLine."MZ" := '';
                                ServiceItemLine."Street" := '';
                                ServiceItemLine."Street No." := '';
                                ServiceItemLine."String" := 0;
                                ServiceItemLine."Stroke" := 0;
                                ServiceItemLine."Zone Stroke" := 0;
                                ServiceItemLine."Municipality Name" := '';
                                ServiceItemLine."MZ Name" := '';
                                ServiceItemLine."Street Name" := '';
                                ServiceItemLine.Address := '';
                                ServiceItemLine."Home No. MM" := '';
                                ServiceItemLine."Floor MM" := '';
                                ServiceItemLine."Apartment No. MM" := '';
                                ServiceItemLine."Street No. Text MM" := '';

                            end;
                            mm.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                            ServiceItem.Get(mm."No.");
                            ServiceItemLine."Purpose" := ServiceItem."Purpose";
                            ServiceItemLine."Dwelling Type" := ServiceItem."Dwelling Type";
                            ServiceItemLine."Elevation" := ServiceItem."Elevation";
                            ServiceItemLine."Reading Mode" := ServiceItem."Reading Mode";
                            ServiceItemLine."MM Category" := ServiceItem."MM Category";
                            ServiceItemLine."Municipality Code" := ServiceItem."Municipality Code MM";
                            ServiceItemLine."MZ" := ServiceItem."MZ MM";
                            ServiceItemLine."Street" := Serviceitem.Street;

                            ServiceItemLine."Street No." := ServiceItem."Street No.";
                            ServiceItemLine."String" := ServiceItem."Measuring Point string";
                            ServiceItemLine."Stroke" := ServiceItem."Measuring Point Stroke";
                            ServiceItemLine."Zone Stroke" := ServiceItem."Zone stroke";
                            ServiceItemLine."Municipality Name" := ServiceItem."Municipality Name MM";
                            ServiceItemLine."MZ Name" := ServiceItem."MZ Name MM";
                            ServiceItemLine."Street Name" := ServiceItem."Street Name MM";
                            ServiceItemLine.Address := ServiceItem."Address MM";
                            ServiceItemLine."Home No. MM" := ServiceItem."Home No.";
                            ServiceItemLine."Floor MM" := ServiceItem.Floor;
                            ServiceItemLine."Apartment No. MM" := ServiceItem."Apartment No.";
                            ServiceItemLine."Street No. Text MM" := ServiceItem."Street No. Text";

                        end;

                        ServiceItemLine.Insert();
                        Commit();
                        //napravi novi radni nalog, razlog promjene a-b




                    end;

                    //drugi radni nalog: 
                    if Confirm('Da li želite otvoriti radni nalog za zamjenu mjerača?') then begin


                        ServiceHeader.Init();
                        ServiceHeader."No." := '';
                        ServiceHeader."A-B" := true;
                        ServiceHeader."A-B Entry" := rec.Code;

                        ServiceHeader."Request Type" := ServiceHeader."Request Type"::"General Work Order";
                        ServiceHeader.Validate("Reason For Service Order", 'ZAMJENA MJERILA KOD INDIVIDUALNIH KUPACA');
                        ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
                        ServiceHeader.validate("Customer No.", rec."Customer No.");
                        Rec.GetDefaultResponsibleDepartment(DepartmentCode, Manag, Emp_2);
                        Manag := false;

                        UseriD_Rec.Get(UseriD);
                        EmployeeContractLedger.Reset();
                        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                        EmployeeContractLedger.SetFilter(Active, '%1', true);
                        if EmployeeContractLedger.FindFirst() then begin
                            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                                Manag := true
                            else
                                Manag := false;
                        end;
                        Emp_2 := UseriD_Rec."Employee No. for Wage";

                        ServiceHeader."Responsible Department" := DepartmentCode;

                        OrgSh.Reset();
                        OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                        if OrgSh.FindFirst() then begin


                            Department.Reset();
                            Department.SetFilter(Code, '%1', DepartmentCode);
                            Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                            if Department.FindFirst() then
                                ServiceHeader."Responsible Department Name" := Department.Description
                            else
                                ServiceHeader."Responsible Department Name" := '';
                        end;
                        //    ServiceHeader."Bill type" := rec."Bill type";
                        //  ServiceHeader."Bill Category" := rec."Bill Category";


                        ServiceHeader."Request Department" := DepartmentCode;

                        OrgSh.Reset();
                        OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                        if OrgSh.FindFirst() then begin


                            Department.Reset();
                            Department.SetFilter(Code, '%1', DepartmentCode);
                            Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                            if Department.FindFirst() then
                                ServiceHeader."Request Department Name" := Department.Description
                            else
                                ServiceHeader."Request Department Name" := '';
                        end;

                        ServiceHeader.Insert(true);
                        //  rec."Service Order" := ServiceHeader."No.";
                        Commit();
                        ServiceItemLine.Init();
                        ServiceItemLine."Document No." := ServiceHeader."No.";
                        ServiceItemLine.Type := ServiceItemLine.Type::MM;
                        MM.Reset();
                        MM.SetFilter("Customer No.", '%1', rec."Customer No.");
                        if mm.FindFirst() then begin
                            //    ServiceItemLine.Validate("Service Item No. - Relation", mm."No.");
                            ServiceItemLine."Service Item No." := mm."No.";

                            if ServiceItemLine."Service Item No." = '' then begin
                                ServiceItemLine."Purpose" := '';
                                ServiceItemLine."Dwelling Type" := '';
                                ServiceItemLine."Elevation" := 0;
                                ServiceItemLine."Reading Mode" := ServiceItemLine."Reading Mode"::Digital;
                                ServiceItemLine."MM Category" := Enum::Category::" ";
                                ServiceItemLine."Municipality Code" := '';
                                ServiceItemLine."MZ" := '';
                                ServiceItemLine."Street" := '';
                                ServiceItemLine."Street No." := '';
                                ServiceItemLine."String" := 0;
                                ServiceItemLine."Stroke" := 0;
                                ServiceItemLine."Zone Stroke" := 0;
                                ServiceItemLine."Municipality Name" := '';
                                ServiceItemLine."MZ Name" := '';
                                ServiceItemLine."Street Name" := '';
                                ServiceItemLine.Address := '';
                                ServiceItemLine."Home No. MM" := '';
                                ServiceItemLine."Floor MM" := '';
                                ServiceItemLine."Apartment No. MM" := '';
                                ServiceItemLine."Street No. Text MM" := '';

                            end;
                            mm.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                            ServiceItem.Get(mm."No.");
                            ServiceItemLine."Purpose" := ServiceItem."Purpose";
                            ServiceItemLine."Dwelling Type" := ServiceItem."Dwelling Type";
                            ServiceItemLine."Elevation" := ServiceItem."Elevation";
                            ServiceItemLine."Reading Mode" := ServiceItem."Reading Mode";
                            ServiceItemLine."MM Category" := ServiceItem."MM Category";
                            ServiceItemLine."Municipality Code" := ServiceItem."Municipality Code MM";
                            ServiceItemLine."MZ" := ServiceItem."MZ MM";
                            ServiceItemLine."Street" := Serviceitem.Street;

                            ServiceItemLine."Street No." := ServiceItem."Street No.";
                            ServiceItemLine."String" := ServiceItem."Measuring Point string";
                            ServiceItemLine."Stroke" := ServiceItem."Measuring Point Stroke";
                            ServiceItemLine."Zone Stroke" := ServiceItem."Zone stroke";
                            ServiceItemLine."Municipality Name" := ServiceItem."Municipality Name MM";
                            ServiceItemLine."MZ Name" := ServiceItem."MZ Name MM";
                            ServiceItemLine."Street Name" := ServiceItem."Street Name MM";
                            ServiceItemLine.Address := ServiceItem."Address MM";
                            ServiceItemLine."Home No. MM" := ServiceItem."Home No.";
                            ServiceItemLine."Floor MM" := ServiceItem.Floor;
                            ServiceItemLine."Apartment No. MM" := ServiceItem."Apartment No.";
                            ServiceItemLine."Street No. Text MM" := ServiceItem."Street No. Text";

                        end;

                        ServiceItemLine.Insert();
                        Commit();
                        //napravi novi radni nalog, razlog promjene a-b




                    end;

                    //kraj
                    //ovo je A-B promjena

                    //uradi i ovo, a onda dodaj i ostalo

                    crl.Reset();
                    //  CRL.SETFILTER(Code, '%1', '50125-000002');
                    crl.SetFilter("Report ID", '%1', 50148);
                    // crl.SetFilter("customer category", '%1', crl."Customer Category"::"Large Economy");
                    IF CRL.FindFirst() THEN BEGIN


                        ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                        //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                        HRSetup.GET;

                        tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                        AB.SetParam(rec.Code);
                        AB.SAVEASPDF(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No. A-B") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No. A-B" <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment2(FALSE);
                            "Attachment No. A-B" := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No. A-B");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No. A-B" := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment2;


                    "NAV ID" := 50125;
                end;


                if "NAV ID" = 50125 then begin


                    if ("Customer Category" = "Customer Category"::"Large Economy") or ("Customer Category" = "Customer Category"::"KJKP Heating plant")
                    or ("Customer Category" = "Customer Category"::"Special Customer") then begin


                        crl.Reset();
                        //  CRL.SETFILTER(Code, '%1', '50125-000002');
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::"Large Economy");
                        CRL.SetFilter(Description, '<>%1', 'CNG Punionice');
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END
                    else
                        CustVers.get("Customer No.");


                    if ("Customer Category" = "Customer Category"::Household) and (CustVers."Tax Liable") and (CustVers."Customer Category" = CustVers."Customer Category"::Household) then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::Household);
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END

                    //dodaje novu opciju 2
                    else
                        CustVers.get("Customer No.");
                    if ("Customer Category" = "Customer Category"::Household) and (CustVers."Customer Category" = CustVers."Customer Category"::"Large Economy") then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::"Large Economy");
                        CRL.SetFilter(Description, '<>%1', 'CNG Punionice');
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END

                    //kraj
                    else
                        CustVers.get("Customer No.");
                    if ("Customer Category" = "Customer Category"::Household) and (CustVers."Customer Category" = CustVers."Customer Category"::"Small Economy") then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::"Small Economy");
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END
                    else
                        if ("Customer Category" = "Customer Category"::"Small Economy") then begin
                            crl.Reset();
                            crl.SetFilter("Report ID", '%1', 50125);
                            crl.SetFilter("customer category", '%1', crl."Customer Category"::"Small Economy");
                            IF CRL.FindFirst() THEN BEGIN


                                ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                                //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                                HRSetup.GET;

                                tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                                Contractwithoutpdv.SetParam(rec.Code);
                                Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                                FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                                IF Attachment.GET("Attachment No.") THEN
                                    Attachment.TESTFIELD("Read Only", FALSE);

                                IF "Attachment No." <> 0 THEN BEGIN
                                    IF NOT CONFIRM(Text004, FALSE) THEN
                                        EXIT;
                                    RemoveAttachment(FALSE);
                                    "Attachment No." := 0;
                                    MODIFY(FALSE);
                                    COMMIT;
                                END;

                                NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                                IF NewAttachNo <> 0 THEN BEGIN
                                    "Attachment No." := NewAttachNo;

                                    COMMIT;
                                END;


                            END;
                            ImportAttachment;
                        END
                        else
                            CustVers.get("Customer No.");
                    if ("Customer Category" = "Customer Category"::Household) and (CustVers."Tax Liable" = false) and (CustVers."Customer Category" = CustVers."Customer Category"::Household) then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::Household);
                        crl.SetFilter(Description, '%1', 'fizicki');
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END

                    else
                        CustVers.get("Customer No.");
                    if ("Customer Category" = "Customer Category"::CNG) and (CustVers."Customer Category" = CustVers."Customer Category"::"Large Economy") then begin

                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::"Large Economy");
                        CRL.SetFilter(Description, '%1', 'CNG Punionice');
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END
                    else
                        CustVers.get("Customer No.");
                    if ("Customer Category" = "Customer Category"::CNG) and (CustVers."Customer Category" = CustVers."Customer Category"::CNG) then begin

                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50125);
                        crl.SetFilter("customer category", '%1', crl."Customer Category"::CNG);
                        if rec."Contract Reason" = 'ANEX' then
                            CRL.SetFilter(Description, '%1', 'Anex')
                        else
                            CRL.SetFilter(Description, '<>%1', 'Anex');
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            Contractwithoutpdv.SetParam(rec.Code);
                            Contractwithoutpdv.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END

                end





                else
                    if ("NAV ID" = 0) then begin
                        crl.Reset();
                        CRL.SETFILTER("Report ID", '%1', 50140);
                        //       crl.SetFilter("customer category", '%1', crl."Customer Category"::"CNG");
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf';
                            safetygasbigeconomy1.SetParam(rec.Code);
                            safetygasbigeconomy1.SAVEASPDF(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
            END;





        }
        field(50395; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
        }
        field(50396; Number_Field; Text[100])
        {
            Caption = 'Evidencijski broj';

        }
        field(50097; "Tax BooleanTest"; Boolean)
        {
            Caption = 'Tax Boolean';
        }
        field(50098; "Employment Contract"; Code[20])
        {
            Caption = 'Employment Contract';
            TableRelation = "Employment Contract".Code where(Type = filter(Customer));
            trigger OnValidate()
            var
                myInt: Integer;
                EC: Record "Employment Contract";

                MMFind: Record "Service Item";
                GaugeF: Record "Installation History";
            begin
                ec.Reset();
                ec.SetFilter(Code, '%1', rec.Code);
                if ec.FindFirst() then begin
                    if ec."NAV ID" <> 0 then begin

                        //error
                        if rec."Customer Category" = rec."Customer Category"::Household then begin

                            GaugeF.Reset();
                            GaugeF.SetFilter(Type, '%1', GaugeF.Type::Gauge);
                            GaugeF.SetFilter(Active, '%1', true);
                            MMFind.Reset();
                            MMFind.SetFilter("Customer No.", '%1', rec."Customer No.");
                            if MMFind.FindFirst() then
                                GaugeF.SetFilter("Measuring Point Code", '%1', MMFind."No.")
                            else
                                Error('Ne postoji mjerno mjesto dodijeljeno ovom kupcu, prema tome ne možete kreirati ugovor!');

                            GaugeF.SetFilter("Customer No.", '%1', rec."Customer No.");
                            if GaugeF.FindFirst() then begin
                                if GaugeF.Count > 1 then
                                    Error('Ovo mjerno mjesto ima više mjerača, prema tome molimo Vas da prvo provjerite podatke prije nego kreirate ugovor!');

                                if GaugeF.Count = 0 then
                                    Error('Ne postoji mjerač dodijeljen ovom kupcu, prema tome ne možete kreirati ugovor!');
                            end
                            else begin
                                Error('Ne postoji mjerač dodijeljen ovom kupcu, prema tome ne možete kreirati ugovor!');
                            end;
                        end;
                        Validate("NAV ID", ec."NAV ID");
                    end;
                end;

            end;
        }

        field(50099; "Contract Reason"; Code[20])
        {
            Caption = 'Employment Contract';
            TableRelation = "Employment Contract".Code where(Type = filter(Reason));
            trigger OnValidate()
            var
                myInt: Integer;
                EC: Record "Employment Contract";
            begin

                ec.Reset();
                ec.SetFilter(Code, '%1', rec."Contract Reason");
                // ec.SetFilter(type, '%1', ec.Type::Reason);
                if ec.FindFirst() then begin
                    if ec."NAV ID" <> 0 then begin
                        Validate("NAV ID", ec."NAV ID");
                    end;
                end;

            end;
        }
        field(50100; "Attachment Count"; Integer)
        {
            Caption = 'Attachment Count';

            FieldClass = FlowField;
            CalcFormula = count("A-B Attachments" where(Code = field(Code), Type = filter(Customer), Source = filter("Standard Text")));
            InitValue = 0;
        }

        field(50079; "Responsible Person No."; Code[20])
        {
            Caption = 'Responsible Person No.';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Primary Contact No." where("No." = field("Customer No.")));
        }
        field(50080; "Responsible Person Name"; Text[100])
        {
            Caption = 'Responsible Person Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Contact where("No." = field("Customer No.")));
        }
        field(50081; "Responsible Person_Job Title"; Text[100])
        {
            Caption = 'Responsible Person_Job Title';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact."Job Title" where("No." = field("Responsible Person No.")));
        }
        field(50074; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Price"."Unit Price" where("Sales Code" = field("Customer No.")));

        }
        field(50075; "Unit Price Includes VAT"; Decimal)
        {
            Caption = 'Unit price includes VAT';

        }

        field(50076; "Price Description"; Text[100])
        {
            Caption = 'Unit price includes VAT';
        }
        field(500678; "Registration No."; code[250])
        {
            Caption = 'Registration No.';
        }
        field(50077; "Starting date for unit price"; Date)
        {
            Caption = 'Starting date for unit price';
            //TableRelation = "sales price"."Starting Date";
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Price"."Starting Date" where("Sales Code" = field("Customer No.")));
        }
        field(50078; "Reason for Termination"; Text[250])
        {
            Caption = 'Reason for Termination';
            //TableRelation = "sales price"."Starting Date";
            //TableRelation = "Grounds for Termination".Description where(Type2 = filter(customer));
        }
        field(50082; "Attachment No. A-B"; Integer)
        {
            Caption = 'Attachment No. A-B';
        }
        field(50083; "Date of creation"; Date)
        {
            Caption = 'Date of creation';
        }
        field(50084; "Service Order"; Integer)
        {
            Caption = 'Service Order';
            // TableRelation = "Service Header"."No." where("Customer No." = field("Customer No."), "Request Type" = filter("General Work Order"), "A-B" = filter(true), "A-B Entry" = field(Code));
            FieldClass = FlowField;
            CalcFormula = count("Service Header" where("Customer No." = field("Customer No."), "Request Type" = filter("General Work Order"), "A-B" = filter(true), "A-B Entry" = field(Code)));
        }

        field(50085; "Verification"; Boolean)
        {
            Caption = 'Verification';


            trigger OnValidate()
            var
                myInt: Integer;
                Cus: Record Customer;
                CuStatus: Record "Status History";
                SHLast: Record "Status History";

            //CalcFormula = lookup("Status History"."Information of processing" where(Active = filter(true), "Source Table" = filter(18), "Customer No." = field("No."
            // )));
            begin

                if rec.Active = true then begin
                    Cus.Reset();
                    Cus.SetFilter("No.", '%1', rec."Customer No.");
                    if Cus.FindFirst() then begin
                        Cus.CalcFields("Customer Status");
                        if cus."Customer Status" <> cus."Customer Status"::Active then begin
                            CuStatus.Reset();
                            CuStatus.SetFilter(Active, '%1', true);
                            CuStatus.SetFilter("Customer No.", '%1', rec."Customer No.");
                            CuStatus.SetFilter("Source Table", '%1', 18);
                            CuStatus.SetFilter("Information of processing", '%1', CuStatus."Information of processing"::Active);
                            if not CuStatus.FindFirst() then begin
                                CuStatus.Init();

                                CuStatus."Customer No." := rec."Customer No.";
                                CuStatus.Active := true;
                                CuStatus."Source Table" := 18;
                                CuStatus."Insert User ID" := UserId;
                                CuStatus."Insert Date and Time" := CurrentDateTime;
                                CuStatus."Information of processing" := CuStatus."Information of processing"::Active;

                                SHLast.Reset();
                                SHLast.SetFilter("Customer No.", '%1', rec."Customer No.");
                                SHLast.SetCurrentKey(Integer);
                                SHLast.Ascending;
                                if SHLast.FindLast() then
                                    CuStatus.Integer := SHLast.Integer + 1
                                else
                                    CuStatus.Integer := 1;

                                CuStatus.Insert();

                            end;
                        end;

                    end;

                end;

            end;
        }

        field(50086; "Public Procurement"; Boolean)
        {
            Caption = 'Public Procurement';
        }

        field(50087; "Date of Public Procurement"; Date)
        {
            Caption = 'Date of Public Procurement';
        }
        field(50088; "Father Name"; Text[250])
        {
            Caption = 'Father Name"';
        }
        field(50089; "Street No.2 Text"; text[250])
        {
            Caption = 'Street No.2 text';
        }
        field(50090; "Public Document No."; Text[250])
        {
            Caption = 'Public Document No.';
        }
        field(50091; "CZK"; Text[250])
        {
            Caption = 'CZK';

        }
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
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(50199; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }


    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(key2M; "Customer No.") { }


    }

    var
        PostCode: Record "Post Code";

    trigger OnDelete()
    var
        myInt: Integer;
        CUst: Record "Customer Ledger Entry";
        CUF: Record Customer;
    begin
        CUst.reset;
        CUst.SetFilter("Customer No.", '%1', rec."Customer No.");
        CUst.SetFilter(Code, '<>%1', rec.Code);
        CUst.SetFilter("Starting Date", '<=%1', WorkDate());
        CUst.SetFilter("Ending Date", '%1|>=%2', 0D, WorkDate());
        cust.SetCurrentKey("Starting Date");
        if cust.FindLast() then begin
            CUF.Reset();
            CUF.SetFilter("No.", '%1', cust."Customer No.");
            if CUF.FindFirst() then begin
                cuf."Contract Starting Date" := cust."Starting Date";
                cuf."Customer Contract Number" := cust.Description;
                cuf.Modify();
            end;
        end else begin
            CUF.Reset();
            CUF.SetFilter("No.", '%1', rec."Customer No.");
            if CUF.FindFirst() then begin
                cuf."Contract Starting Date" := 0D;
                cuf."Customer Contract Number" := '';
                cuf.Modify();
            end;
        end;
    end;

    trigger OnInsert()
    var
        myInt: Integer;
        GLS: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        US: Record "User Setup";
        ECL: Record "Employee Contract Ledger";
        ECL2: record "Customer Ledger Entry";
        Cust: Record Customer;
        AddText: text;
        DepFind: Record Department;
        CZkValue: text;
        Descriptiondd: TEXT;
        Customer: Record Customer;

    begin

        CZkValue := '';

        US.Reset();
        us.setfilter("User ID", '%1', userid);
        if us.FindFirst() then begin
            rec.CZK := us.CZK;
            CZkValue := rec.CZK;

            if rec.CZK = '' then begin

                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', us."Employee No. for Wage");
                ecl.SetFilter(Active, '%1', true);
                if ecl.FindFirst() then begin
                    rec.CZK := ecl."Department Name";
                    CZkValue := rec.CZK;

                    DepFind.Reset();
                    DepFind.SetFilter(Description, '%1', ecl."Department Name");
                    DepFind.SetFilter("ORG Shema", '%1', ecl."Org. Structure");
                    if DepFind.FindFirst() then begin
                        if DepFind."Short Code" <> '' then
                            CZkValue := DepFind."Short Code";

                    end
                    else begin

                    end;
                end
                else begin
                    rec.CZK := '';
                end;
            end;

        end
        else begin

            rec.CZK := '';
        end;

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if rec."Customer No." = '' then begin
                //   Validate("Customer No.", us."Customer No.");
            end;
        end;
        IF Code = '' THEN BEGIN

            GLS.GET;
            GLS.TESTFIELD("Customer Contract Entry");
            NoSeriesMgt.InitSeries(GLS."Customer Contract Entry", xRec."No. Series", 0D, Code, "No. Series");
        END;


        if "Starting Date" = 0D then
            validate("Starting Date", today);

        AddText := '';

        AddText := CZkValue + '/';

        //ovo možemo odkomentarisati kada bude trebalo Kenan Krka rekao!
        // AddText := '';



        Customer.Reset();
        Customer.SetFilter("No.", '%1', "Customer No.");
        if Customer.FindFirst() then begin
            if "Customer Category" = "Customer Category"::"CNG" then begin
                Descriptiondd := 'CNG'
            end
            ELSE
                if "Customer Category" = "Customer Category"::"Small Economy" then begin
                    Descriptiondd := 'MP'
                end
                else
                    if "Customer Category" = "Customer Category"::Household then begin
                        Descriptiondd := 'D'
                    END
                    else
                        if "Customer Category" = "Customer Category"::"KJKP Heating plant" then
                            Descriptiondd := 'TK-6'

                        else
                            if "Customer Category" = "Customer Category"::"Large Economy" then begin
                                Descriptiondd := 'VP'
                            END
                            else
                                if "Customer Category" = "Customer Category"::"Special Customer" then begiN
                                    Descriptiondd := 'TK-9'
                                end

                                else
                                    Descriptiondd := '';
        end;


        Description := Descriptiondd + '-' + AddText + Code + '/' + format(Date2DMY(today, 3));



        if (rec."Starting Date" <= today) and ((rec."Ending Date" = 0D) or (rec."Ending Date" >= today)) then begin
            Active := true;
            ECL2.reset;
            ECL2.SetFilter("Customer No.", '%1', rec."Customer No.");
            ECL2.SetFilter(Code, '<>%1', rec.Code);
            ECL2.SetCurrentKey("Starting Date");
            ECL2.ascending;
            if ECL2.FindLast() then begin
                if (ECL2."Ending Date" = 0D) and (ECL2."Starting Date" <> 0D) then begin
                    ECL2."Ending Date" := CalcDate('<-1D>', rec."Starting Date");
                    Ecl2.Modify();
                end;
            end;
            cust.Reset();
            cust.SetFilter("No.", '%1', rec."Customer No.");
            if cust.FindFirst() then begin
                if rec."Starting Date" = WorkDate() then begin
                    cust."Customer Contract Number" := Rec.Description;
                    cust."Contract Starting Date" := Rec."Starting Date";
                    cust.Modify();
                end
                else begin
                    cust."Customer Contract Number" := ecl2.Description;
                    cust."Contract Starting Date" := ecl2."Starting Date";
                    cust.Modify();
                end;
            end;
        end
        else begin
            ECL2.reset;
            ECL2.SetFilter("Customer No.", '%1', rec."Customer No.");
            ecl2.SetFilter("Starting Date", '<=%1', WorkDate());
            ecl2.SetCurrentKey("Starting Date");
            ecl2.ascending;
            if ecl2.FindLast() then begin
                cust.Reset();
                cust.SetFilter("No.", '%1', rec."Customer No.");
                if cust.FindFirst() then begin
                    cust."Customer Contract Number" := ecl2.Description;
                    cust."Contract Starting Date" := ecl2."Starting Date";
                    cust.Modify();
                end;
            end;
        end;

    end;




    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Attachment No.") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Attachment No." := 0;
                MODIFY;
            END;
    end;

    procedure RemoveAttachment2(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Attachment No. A-B") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Attachment No. A-B" := 0;
                MODIFY;
            END;
    end;

    procedure OpenAttachment()
    var
        Attachment: Record Attachment;
    begin
        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment(FORMAT(rec.Code) + ' ' + rec.Description, FALSE, '');

    end;

    procedure OpenAttachment2()
    var
        Attachment: Record Attachment;
    begin
        IF "Attachment No. A-B" = 0 THEN
            EXIT;
        Attachment.GET("Attachment No. A-B");
        Attachment.OpenAttachment(FORMAT(rec.Code) + ' ' + rec.Description, FALSE, '');

    end;

    procedure ImportAttachment()
    var
        Attachment: Record "Attachment";
        HRSetup: Record "Human Resources Setup";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);

        END;
        HRSetup.get;

        //    Attachment.SetParam(Rec."Employee No.", "No.", 1);
        IF Attachment.ImportAttachmentFromClientFile2(HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf', FALSE, FALSE)

       THEN BEGIN
            "Attachment No." := Attachment."No.";
            MODIFY;
        END;
        HRSetup.GET;
        IF EXISTS(HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf') THEN
            ERASE(HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf');


    end;

    procedure GetDefaultResponsibleDepartment(var DepartmentCode: Code[20]; var Manag: boolean; Emp_2: Code[20])
    var
        CZKUser: Boolean;
    begin
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
    end;

    procedure GetDefaultResponsibleDepartment(var DeparmentCode: Code[20]; var CZKUser: Boolean; Manag: Boolean; Emp_bezt: Code[20])
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        US: Record "User Personalization";
        EmployeeContractLedger: Record "Employee Contract Ledger";
    begin
        Employee.SetAutoCalcFields("Department Code");
        Employee.SetLoadFields("Department Code");


        if not UserSetup.Get(UserId) then
            exit;
        if not Employee.Get(UserSetup."Employee No. for Wage") then
            exit;

        DeparmentCode := Employee."Department Code";
        CZKUser := UserSetup."CZK User";
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Profile ID" = 'CZK' then
                CZKUser := true
            else
                CZKUser := false;

        end;

        Manag := false;



        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', Employee."No.");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp_bezt := Employee."No.";



    end;

    procedure ImportAttachment2()
    var
        Attachment: Record "Attachment";
        HRSetup: Record "Human Resources Setup";
    begin
        IF "Attachment No. A-B" <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No. A-B") THEN
                Attachment.TESTFIELD("Read Only", FALSE);

        END;
        HRSetup.get;

        //    Attachment.SetParam(Rec."Employee No.", "No.", 1);
        IF Attachment.ImportAttachmentFromClientFile2(HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf', FALSE, FALSE)

       THEN BEGIN
            "Attachment No. A-B" := Attachment."No.";
            MODIFY;
        END;
        HRSetup.GET;
        IF EXISTS(HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf') THEN
            ERASE(HRSetup."File Path" + rec.Code + '-' + FORMAT(rec."Customer No.") + '.pdf');


    end;

    var
        txt1: Label 'Not correct Category for this report';

        myInt: Integer;
        NewAttachNo: Integer;
}